# Gateway for microservices project

[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

## About

Project is dedicated to making a primitive microservice application.
On the base of this repository gateway kubernetes pods are created.

## Prerequisites

- Java 25

## License

This software is licensed under the [BSD License][BSD]. For more information, read the file [LICENSE](LICENSE).

[BSD]: https://opensource.org/licenses/BSD-3-Clause

Backend project here.
https://github.com/grigof45/microservices-backend

Run all project from existing on dockerhub images
Create net
docker network create msvc-network
Run backend
docker run -dit --name demo6-backend --network demo6-network grigof/microservices-backend:1.0.0
Run gate
docker run -dit -p 80:8080 --env secret=my-real-secret --env BACKEND_URL=http://demo6-backend:8080/ --name gateway --network demo6-network grigof/microservices-gateway:1.0.0
