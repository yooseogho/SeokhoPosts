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

	@Insert("INSERT INTO Posts(pno, title, posts_content, posts_createdate, posts_modified, member_id,views,likeCount,cano) " +
	        "VALUES ( posts_seq.nextval, #{title}, #{postsContent}, SYSDATE, SYSDATE, #{memberId},0,0,#{cano})")
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
    public List<PostsDetail> findAllPostsDetail();
    
    // 모든 게시글의 수를 반환하는 메서드
    @Select("SELECT COUNT(*) FROM Posts")
    Long countAllPosts();
    // 개사글 읽기
    public List<read> findAllRead();
    
    // 본문 내용
    @Select("SELECT posts_content FROM Posts WHERE pno=#{pno}")
    public String FindByContent(Long pno);
    
    // 최신글 정보 5게 가져오는 쿼리
    @Select("SELECT * FROM (SELECT * FROM Posts ORDER BY posts_createdate DESC) WHERE ROWNUM <= 5")
    public List<Posts> findTop5ByOrderByCreatedDateDesc();
    
    // 페이징 쿼리
    @Select("SELECT * FROM (SELECT p.*, rownum AS rnum FROM (SELECT * FROM Posts ORDER BY pno DESC) p) WHERE rnum BETWEEN #{start} AND #{end}")
    public List<PostsDetail> findPostsDetailByPage(@Param("start") int start, @Param("end") int end);
 
    @Select("SELECT COUNT(*) FROM Posts")
    public int countPosts();
    
    
    // 카테고리 ID에 따른 게시글을 필터링하는 메서드
    @Select("SELECT * FROM posts WHERE cano = #{cano}")
    public List<Posts> findPostsByCategory(Long category);
    
    
 // 카테고리 ID에 따른 게시글 상세 정보 조회
    @Select("SELECT p.*, c.CATEGORY_NAME AS categoryName, m.nickname FROM Posts p JOIN category c ON p.cano = c.cano JOIN member m ON p.member_id = m.member_id WHERE p.cano = #{cano} ORDER BY p.pno DESC")
    public List<PostsDetail> findPostsDetailByCategory(@Param("cano") Long cano);

    @Select("SELECT COUNT(*) FROM Posts WHERE cano = #{cano}")
    public Long countPostsByCategory(@Param("cano") Long cano);

    @Select("SELECT * FROM posts WHERE cano = #{cano} LIMIT #{offset}, #{pageSize}")
    public List<Posts> findPostsByCategoryAndPage(Long category, int offset, int pageSize);

    
    
}


