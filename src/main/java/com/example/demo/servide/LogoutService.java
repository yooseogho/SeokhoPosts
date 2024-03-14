package com.example.demo.servide;

import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class LogoutService {
    public void logout(String accessToken) {
        RestTemplate restTemplate = new RestTemplate();

        // 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        headers.set("Authorization", "Bearer " + accessToken);

        // HTTP 요청 만들기
        HttpEntity<String> requestEntity = new HttpEntity<>("", headers);

        // HTTP 요청 보내기
        ResponseEntity<String> responseEntity = restTemplate.exchange("https://kapi.kakao.com/v1/user/logout", HttpMethod.POST, requestEntity, String.class);

        // 응답 받기
        String result = responseEntity.getBody();
        
        System.out.println(result);
    }
}
