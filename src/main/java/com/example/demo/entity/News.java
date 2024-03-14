package com.example.demo.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class News {
    private String title; // 뉴스 제목
    private String link; // 뉴스 링크
    private String pubDate; // 뉴스 날짜
}