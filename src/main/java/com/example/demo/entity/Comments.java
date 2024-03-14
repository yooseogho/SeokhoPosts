package com.example.demo.entity;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;



@Data
@AllArgsConstructor
@NoArgsConstructor
public class Comments {
    private Long cono;                  // 댓글 번호
    private String commentsContent;      // 댓글 내용
    private LocalDateTime commentsCreatedate;
    private String memberId;  // 회원 ID
    private Long pno;  // 게시글 번호
    private Long parentId;  // 부모 댓글 ID
}

