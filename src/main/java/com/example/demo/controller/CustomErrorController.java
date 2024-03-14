package com.example.demo.controller;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CustomErrorController implements ErrorController {

    @RequestMapping("/error")
    public String handleError() {
        // 사용자 정의 오류 메시지
        return "An unexpected error has occurred. We are working to fix it.";
    }

    public String getErrorPath() {
        return "/error";
    }
}
