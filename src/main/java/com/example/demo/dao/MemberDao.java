package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.entity.Member;

@Mapper
public interface MemberDao {

	// 전체 조회
	@Select("SELECT * FROM Member")
	List<Member> getAllMembers();
	// 회원정보 저장
	@Insert("INSERT INTO Member(member_id, password, email, name, nickname, lastlogin, member_createdate, modified, birthday, rno) "
	        + "VALUES (#{memberId}, #{password}, #{email}, #{name}, #{nickname}, #{lastlogin,jdbcType=TIMESTAMP}, #{memberCreatedate,jdbcType=DATE}, #{modified,jdbcType=TIMESTAMP}, #{birthday}, #{rno})")
	public Long save(Member member);
	

	// 회원정보 조회
	@Select("Select * from member where member_id = #{memberId}")
	public Member getmember(String memberId);

	// 비밀번호 변경
	@Update("UPDATE Member SET password = #{password}  WHERE email = #{email}")
	public Long updateMember(Member member);
	
	// 회원 탈퇴
	@Delete("DELETE FROM Member WHERE member_id = #{memberId}")
	public Long deleteMember(Member member);
	
	// 로그인 쿼리
	@Select("SELECT * FROM Member WHERE member_id = #{memberId} AND password = #{password}")
	public Member login(String memberId, String password);
	
	
	@Select("SELECT nickname FROM Member WHERE member_id = #{memberId}")
	public Member nicknameSelect(String memberId);
	

}
