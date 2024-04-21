package com.example.demo.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.entity.Likes;

@Mapper
public interface LikesDao {
	
	
    // 좋아요 추가
    @Insert("INSERT INTO Likes(INO, LIKE_DATE, member_id, pno) " + 
            "VALUES(likes_seq.nextval, sysdate, #{memberId}, #{pno})")
    public Long save(Likes likes);
	
    // 특정 게시글의 좋아요 증가
    @Update("UPDATE Posts SET LIKECOUNT = LIKECOUNT + 1 WHERE PNO = #{pno}")
    public int updateLikeCountByPno(@Param("pno") Long pno);



	// 사용자의 게시글 좋아요 갯수 확인 쿼리
	@Select("SELECT COUNT(*) FROM Likes WHERE member_id = #{memberId} AND pno = #{pno}")
	public int countByMemberId(String memberId, Long pno);
	
	

}
