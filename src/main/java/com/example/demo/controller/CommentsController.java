package com.example.demo.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.dao.CommentsDao;
import com.example.demo.dto.CommentsDto;
import com.example.demo.entity.Comments;
import com.example.demo.servide.CommentsService;
import com.example.demo.servide.MemberService;
@RestController
public class CommentsController {
    
    @Autowired
    private CommentsService commentsService;
    
    @Autowired
    private MemberService memberService;
    @Autowired
    private CommentsDao commentsDao;
    
    @Secured("ROLE_USER")
    @PostMapping("/comments")
    public CommentsDto.CommentsRead createComment(@RequestBody Comments comment) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String currentUserName = authentication.getName();  

        comment.setMemberId(currentUserName);  
        comment.setCommentsCreatedate(LocalDateTime.now());  // 현재 시간을 설정합니다.
        Comments createdComment = commentsService.createComment(comment); 

        CommentsDto.CommentsRead commentRead = new CommentsDto.CommentsRead();
        commentRead.setCono(createdComment.getCono());
        commentRead.setCommentsContent(createdComment.getCommentsContent());
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedDateTime = createdComment.getCommentsCreatedate().format(formatter);
        commentRead.setCommentsCreatedate(formattedDateTime);

        return commentRead;  
    }


    
    @GetMapping("/comments/{pno}")
    public List<CommentsDto.CommentsRead> getComments(@PathVariable Long pno) {
        // 'pno'에 해당하는 댓글을 데이터베이스에서 불러옵니다.
        List<CommentsDto.CommentsRead> comments = commentsDao.getCommentsWithNickname();

        // 'pno'에 해당하는 댓글만 필터링합니다.
        comments = comments.stream()
                .filter(comment -> comment.getPno().equals(pno))
                .collect(Collectors.toList());

        return comments;
    }


    
}
