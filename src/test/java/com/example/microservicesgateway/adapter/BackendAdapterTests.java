package com.example.microservicesgateway.adapter;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import org.springframework.http.MediaType;
import org.springframework.test.web.client.MockRestServiceServer;
import org.springframework.boot.restclient.test.autoconfigure.RestClientTest;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.client.match.MockRestRequestMatchers.requestTo;
import static org.springframework.test.web.client.response.MockRestResponseCreators.withSuccess;

@RestClientTest(BackendAdapter.class)
public class BackendAdapterTests {

    @Autowired
    private MockRestServiceServer server;

    @Autowired
    private BackendAdapter backendAdapter;

    @Value("${backend.url}")
    private String backendUrl;

    @Test
    public void getRequests_okResponse() {
        server.expect(requestTo(backendUrl + "/requests"))
            .andRespond(withSuccess("1", MediaType.APPLICATION_JSON));
        assertThat(backendAdapter.getRequests()).isEqualTo("1");
    }
}
