package com.example.demo.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


// 페이지 정보를 담을 클래스
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PagingInfo {
    private int startPage;
    private int endPage;
    private boolean hasNextGroup;
    private boolean hasPreviousGroup;
    private int totalPages;
    private Long categoryId; // categoryId 속성 추가

}
