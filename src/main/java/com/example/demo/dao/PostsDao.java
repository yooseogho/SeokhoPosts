package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import com.example.demo.dto.PostsDto.PostsDetail;
import com.example.demo.dto.PostsDto.read;
import com.example.demo.entity.Posts;

@Mapper
public interface PostsDao {

	@Insert("INSERT INTO Posts(pno, title, posts_content, posts_createdate, posts_modified, member_id,views,likeCount) " +
	        "VALUES ( posts_seq.nextval, #{title}, #{postsContent}, SYSDATE, SYSDATE, #{memberId},0,0)")
	@SelectKey(statement = "SELECT posts_seq.currval FROM dual", keyProperty = "pno", before = false, resultType = Long.class)
	public Long save(Posts posts);




    @Select("SELECT * FROM Posts WHERE pno = #{pno}")
    public Posts getPost(Long pno);

    // 제목 수정
    @Update("UPDATE Posts SET title = #{title} WHERE pno = #{pno}")
    public Long updatePostTitle(@Param("title") String title, @Param("pno") Long pno);
    // 본문 수정
    @Update("update Posts set posts_content=#{potstContent} where pno=#{pno}")
    public Long updatePostContent();

    @Delete("DELETE FROM Posts WHERE pno = #{pno}")
    public Long deletePost(Long pno);
    
    @Select("SELECT * FROM Posts")
    public List<Posts> getAllPosts();
    
    @Select("SELECT * FROM Posts WHERE pno = #{pno}")
    public Posts findById(Long pno);
    
    // 조회수 증가
    @Update("update posts set views = views + 1 where pno = #{pno}")
    public Long increaseViews(Long pno);
    
    @Update("UPDATE Posts SET likeCount = likeCount + 1 WHERE pno = #{pno}")
    public void increaseLikeCount(Long pno);
    
    // 루트페이지 게시글 정보
    List<PostsDetail> findAllPostsDetail();
    

    // 개사글 읽기
    List<read> findAllRead();
    
    // 본문 내용
    @Select("SELECT posts_content FROM Posts WHERE pno=#{pno}")
    public String FindByContent(Long pno);
    
    // 최신글 정보 5게 가져오는 쿼리
    @Select("SELECT * FROM (SELECT * FROM Posts ORDER BY posts_createdate DESC) WHERE ROWNUM <= 5")
    List<Posts> findTop5ByOrderByCreatedDateDesc();
    
 
    
}


