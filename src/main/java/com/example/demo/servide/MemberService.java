package com.example.demo.servide;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.demo.dao.MemberDao;
import com.example.demo.entity.Member;

@Service
public class MemberService {

	@Autowired
	private MemberDao memberDao;
	@Autowired
	private PasswordEncoder encoder;

	// 화원가입
	public Long register(Member member) {
		// 비밀번호 암호화
		String encodedPassword = encoder.encode(member.getPassword());
		member.setPassword(encodedPassword);
		member.setRno(1L);
		// 회원가입 시점의 날짜 설정
		member.setMemberCreatedate(LocalDate.now());
		// 회원정보 저장
		return memberDao.save(member);
	}

	// 회원 탈퇴
	public Long quit(Member member) {
		Member foundMember = memberDao.getmember(member.getMemberId());

		if (foundMember != null) {
			return memberDao.deleteMember(member);
		} else {
			return null;
		}

	}
	
//	아이디 중복확인
    public boolean isDuplicatedId(String memberId) {
        Member member = memberDao.getmember(memberId);
        // memberDao.getMemberById(memberId) 메서드가 memberId에 해당하는 회원을 반환하므로,
        // 이 메서드의 반환값이 null이 아니라면 memberId가 중복된다는 것을 의미합니다.
        return member != null;
    }

    
    
    
    
    
 // 로그인 
    public Long login(String memberId, String password) {
        Member member = memberDao.getmember(memberId);
        if (member != null) {
            boolean passwordMatch = encoder.matches(password, member.getPassword());
            if (passwordMatch) {
                return member.getRno();  // 로그인 성공시 rno를 반환
            }
        }
        return null;
    }
    
    
    // 닉네임
    public Member nicknameSelect(String memberId) {
    	return memberDao.nicknameSelect(memberId);
    }


    

}
