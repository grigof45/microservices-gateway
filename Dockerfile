FROM eclipse-temurin:25-jdk-alpine AS builder
ADD . /src
WORKDIR /src
RUN ./mvnw package -DskipTests


FROM alpine:3.24.4 AS packager
RUN apk --no-cache add openjdk25-jdk openjdk25-jdk
RUN apk add --no-cache binutils
ENV JAVA_MINIMAL="/opt/java-minimal"
RUN chmod +x /usr/lib/jvm/java-25-openjdk/bin/jlink
# build minimal JRE
RUN /usr/lib/jvm/java-25-openjdk/bin/jlink \
    --verbose \
    --add-modules \
        java.base,java.sql,java.naming,java.desktop,java.management,java.security.jgss,java.instrument \
    --compress 2 --strip-debug --no-header-files --no-man-pages \
    --release-info="add:IMPLEMENTOR=radistao:IMPLEMENTOR_VERSION=radistao_JRE" \
    --output "$JAVA_MINIMAL"


FROM alpine:3.24.4
LABEL maintainer="Fedorinov"
ENV JAVA_HOME=/opt/java-minimal
ENV PATH="$PATH:$JAVA_HOME/bin"
COPY --from=packager "$JAVA_HOME" "$JAVA_HOME"
COPY --from=builder /src/target/microservices-gateway-*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]
