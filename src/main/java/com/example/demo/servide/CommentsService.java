package com.example.demo.servide;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.CommentsDao;
import com.example.demo.dto.CommentsDto;
import com.example.demo.entity.Comments;


@Service
public class CommentsService {
	
	@Autowired
	private CommentsDao commentsDao;
	
	

	// 댓글 생성
	public Comments createComment(Comments comment) {
	    Long commentId = commentsDao.insertComment(comment);
	    Comments createdComment = commentsDao.selectCommentById(commentId);
	    return createdComment;
	}
    // 댓글 조회
    public List<Comments> getCommentsByPostId(Long pno) {
        return commentsDao.getCommentsByPostId(pno);
    }

    // 댓글 수정
    public Comments updateComment(Comments comment) {
        return commentsDao.updateComment(comment);
    }
    
    // 댓글 삭제
    public Long deleteComment(Long cono) {
        return commentsDao.deleteComment(cono);
    }

    // 댓글 개수 조회
    public Long getCommentsCountByPostId(Long pno) {
        return commentsDao.getCommentsCountByPostId(pno);
    }
    
    
    
    public List<CommentsDto.CommentsRead> readCommentsByPostId(Long postId) {
        // 'postId'에 해당하는 게시글의 댓글을 모두 데이터베이스에서 찾습니다.
        List<Comments> comments = commentsDao.getCommentsByPostId(postId);
        // 'comments'를 'CommentsRead' DTO의 리스트로 변환합니다.
        List<CommentsDto.CommentsRead> commentsReads = comments.stream().map(comment -> {
            CommentsDto.CommentsRead commentRead = new CommentsDto.CommentsRead();
            // 'comment'의 필드를 'commentRead'에 복사합니다.
            // 이 부분은 'comment'와 'commentRead'의 필드에 따라 달라질 수 있습니다.
            commentRead.setCono(comment.getCono());
            commentRead.setCommentsContent(comment.getCommentsContent());
            // 'commentsCreatedate'를 'String'으로 변환합니다.
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String formattedDateTime = comment.getCommentsCreatedate().format(formatter);
            commentRead.setCommentsCreatedate(formattedDateTime);
            // 필요한 다른 필드를 여기에 추가하세요.
            return commentRead;
        }).collect(Collectors.toList());
        return commentsReads;
    }

    
    
    public CommentsDto.CommentsRead ReadComment(Long id) {
        // 'id'에 해당하는 댓글을 데이터베이스에서 찾습니다.
        Comments comment = commentsDao.selectCommentById(id);
        if (comment == null) {
            throw new IllegalArgumentException("Invalid comment ID: " + id);
        }

        // 'comment'를 'CommentsRead' DTO로 변환합니다.
        CommentsDto.CommentsRead commentRead = new CommentsDto.CommentsRead();
        // 'comment'의 필드를 'commentRead'에 복사합니다.
        // 이 부분은 'comment'와 'commentRead'의 필드에 따라 달라질 수 있습니다.
        commentRead.setCono(comment.getCono());
        commentRead.setCommentsContent(comment.getCommentsContent());

        // 'commentsCreatedate'를 'String'으로 변환합니다.
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedDateTime = comment.getCommentsCreatedate().format(formatter);
        commentRead.setCommentsCreatedate(formattedDateTime);

        // 필요한 다른 필드를 여기에 추가하세요.

        return commentRead;
    }

    
    
	
}
