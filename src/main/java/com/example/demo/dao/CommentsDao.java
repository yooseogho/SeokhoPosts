package com.example.demo.dao;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.dto.CommentsDto.CommentsRead;
import com.example.demo.entity.Comments;

@Mapper
public interface CommentsDao {
	
    // 댓글 생성
	@Insert("INSERT INTO Comments(cono, comments_content, comments_createdate, member_id, pno, parent_id)"
	        + " VALUES (comments_seq.NEXTVAL, #{commentsContent}, #{commentsCreatedate}, #{memberId}, #{pno}, #{parentId})")
	public Long insertComment(Comments comment);

    
    // 댓글 조회 (특정 게시글에 달린 모든 댓글을 조회)
    @Select("SELECT * FROM Comments WHERE pno = #{pno} ORDER BY comments_createdate DESC")
    public List<Comments> getCommentsByPostId(Long pno);

    
    // 댓글 수정
    @Update("UPDATE Comments SET commentsContent = #{commentsContent} WHERE cono = #{cono}")
    public Comments updateComment(Comments comment);

    
    // 댓글 삭제
    @Delete("DELETE FROM Comments WHERE cono = #{cono}")
    public Long deleteComment(Long cono);
    
    
    @Select("SELECT COUNT(*) FROM Comments WHERE pno = #{pno}")
    public Long getCommentsCountByPostId(Long pno);
    

    // 댓글과 닉네임 조회
    public List<CommentsRead> getCommentsWithNickname();
    
    
    // 댓글 조회 (특정 ID의 댓글을 조회)
    @Select("SELECT * FROM Comments WHERE cono = #{cono}")
    public Comments selectCommentById(Long cono);




}
