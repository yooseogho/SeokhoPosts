package com.example.demo.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.dao.RoleDao;
import com.example.demo.dto.MemberDto;
import com.example.demo.dto.PostsDto.PostsDetail;
import com.example.demo.entity.Member;
import com.example.demo.entity.News;
import com.example.demo.entity.NewsResponse;
import com.example.demo.entity.Posts;
import com.example.demo.service.MemberService;
import com.example.demo.service.PostsService;
import com.example.demo.service.RoleService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private PasswordEncoder encoder;
	@Autowired
	private RoleDao roleDao;
	
	@Autowired
	private RoleService roleService;
	
	@Autowired
	private PostsService postsService;

	

	
	// 회원가입 페이지
	@GetMapping("create_member_page")
	public ModelAndView getJoinForm(Member member,Model model) {
		
	    // 뉴스 데이터를 가져오는 코드
	    final String url = "https://openapi.naver.com/v1/search/news.json?query=%EC%A3%BC%EC%8B%9D&display=10&start=1&sort=sim";

	    HttpHeaders headers = new HttpHeaders();
	    headers.set("X-Naver-Client-Id", "WAeE5GRg__9xflIfBSQ5");
	    headers.set("X-Naver-Client-Secret", "2YF69gonop");

	    HttpEntity<String> entity = new HttpEntity<>(headers);
	    RestTemplate restTemplate = new RestTemplate();
	    ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
	    String newsData = response.getBody();
	    ObjectMapper mapper = new ObjectMapper();
	    mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false); // 이 줄 추가

	    try {
	        NewsResponse newsResponse = mapper.readValue(newsData, NewsResponse.class);
	        List<News> newsList = newsResponse.getItems();
	        model.addAttribute("newsData", newsList);
	        System.out.println("newsList: " + newsList);
	        System.out.println("Response from API: " + response.getBody());

	    } catch (JsonProcessingException e) {
	    	System.out.println("Response from API: " + response.getBody());

	        e.printStackTrace();
	        System.out.println("뉴스 데이터를 가져오는 데 실패했습니다.");
	    }

	    // 다른 데이터를 가져오는 코드
	    List<PostsDetail> postsDetailList = postsService.getAllPostsDetail();
	    System.out.println("postsDetailList: " + postsDetailList);
	    model.addAttribute("posts", postsDetailList);

	    ModelAndView mav = new ModelAndView("create_member_page");
	    mav.addAllObjects(model.asMap()); // 모델에 있는 모든 데이터를 ModelAndView에 추가
	    return mav;
	}
	
	
	

	// 로그인 페이지
	@PreAuthorize("isAnonymous()")
	@GetMapping("/login_page")
	public String login_page(Model model) {
	    // 뉴스 데이터를 가져오는 코드
	    final String url = "https://openapi.naver.com/v1/search/news.json?query=%EC%A3%BC%EC%8B%9D&display=10&start=1&sort=sim";

	    HttpHeaders headers = new HttpHeaders();
	    headers.set("X-Naver-Client-Id", "WAeE5GRg__9xflIfBSQ5");
	    headers.set("X-Naver-Client-Secret", "2YF69gonop");

	    HttpEntity<String> entity = new HttpEntity<>(headers);
	    RestTemplate restTemplate = new RestTemplate();
	    ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
	    String newsData = response.getBody();
	    ObjectMapper mapper = new ObjectMapper();
	    mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false); // 이 줄 추가

	    try {
	        NewsResponse newsResponse = mapper.readValue(newsData, NewsResponse.class);
	        List<News> newsList = newsResponse.getItems();
	        model.addAttribute("newsData", newsList);
	        System.out.println("newsList: " + newsList);
	        System.out.println("Response from API: " + response.getBody());

	    } catch (JsonProcessingException e) {
	    	System.out.println("Response from API: " + response.getBody());

	        e.printStackTrace();
	        System.out.println("뉴스 데이터를 가져오는 데 실패했습니다.");
	    }

	    // 다른 데이터를 가져오는 코드
	    List<PostsDetail> postsDetailList = postsService.getAllPostsDetail();
	    System.out.println("postsDetailList: " + postsDetailList);
	    model.addAttribute("posts", postsDetailList);

	    ModelAndView mav = new ModelAndView("create_member_page");
	    mav.addAllObjects(model.asMap()); // 모델에 있는 모든 데이터를 ModelAndView에 추가
	    return "login_page";
	}

	

	
	

	// 회원가입 로직
	@PostMapping("/create_member_page")
	public String postJoinForm(@ModelAttribute MemberDto.Join joinDto, RedirectAttributes redirectAttributes,
			HttpServletResponse response) {
		try {
			// 회원 가입 서비스 호출
			Long memberId = memberService.register(joinDto.toEntity());
			// 회원 가입 성공 메시지 설정
			redirectAttributes.addFlashAttribute("message", "회원 가입에 성공했습니다.");

			// 사용자의 이름을 세션 스토리지에 저장하는 코드를 추가
			Cookie cookie = new Cookie("name", joinDto.getName());
			response.addCookie(cookie);

			// 로그인 페이지로 리다이렉트
			return "redirect:/";

		} catch (Exception e) {
			// 에러 메시지 설정
			redirectAttributes.addFlashAttribute("errorMessage", "회원 가입에 실패했습니다: " + e.getMessage());
			// HTTP 상태 코드 400을 반환하며 오류를 발생시킵니다.
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "회원 가입에 실패했습니다.");
		}
	}
	
	
	

	// 로그인 컨트롤러
	@PostMapping("/login_page")
	public ModelAndView postLogin(String memberId, String password, HttpSession session) {
	    Long rno = memberService.login(memberId, password);

	    if (rno != null) {
	        session.setAttribute("loginUser", memberId);

	        // 사용자의 권한 목록을 가져오기 위한 변수를 준비합니다.
	        List<GrantedAuthority> authorities = new ArrayList<>();

	        // rno 값에 따라 권한을 부여합니다.
	        if (rno == 1L) {
	            authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
	        } else if (rno == 2L) {
	            authorities.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
	        }


	        // 사용자의 권한을 인증 토큰에 설정합니다.
	        UsernamePasswordAuthenticationToken auth = 
	            new UsernamePasswordAuthenticationToken(memberId, password, authorities);
	        SecurityContextHolder.getContext().setAuthentication(auth);

	        return new ModelAndView("redirect:/");
	    } else if (memberId == null || memberId.trim().isEmpty()) {
	        ModelAndView modelAndView = new ModelAndView("login_page");
	        modelAndView.addObject("loginMsg", "아이디를 입력해주세요");
	        return modelAndView;
	    } else if (password == null || password.trim().isEmpty()) {
	        ModelAndView modelAndView = new ModelAndView("login_page");
	        modelAndView.addObject("loginMsg", "비밀번호를 입력해주세요");
	        return modelAndView;
	    } else {
	        ModelAndView modelAndView = new ModelAndView("login_page");
	        modelAndView.addObject("loginMsg", "ID 또는 비밀번호가 올바르지 않습니다");
	        return modelAndView;
	    }
	}

	

//	@PreAuthorize("isAuthenticated()")
//	@GetMapping("/member_info")
//	public ModelAndView getMemberInfo(@AuthenticationPrincipal Member member) {
//	    // 회원 정보 조회 코드...
//	}
//
//	@PreAuthorize("isAuthenticated()")
//	@PostMapping("/member_info")
//	public String postMemberInfo(@ModelAttribute Member member, RedirectAttributes redirectAttributes) {
//	    // 회원 정보 수정 코드...
//	}
//
//	@PreAuthorize("isAuthenticated()")
//	@PostMapping("/delete_member")

//	public String deleteMember(@AuthenticationPrincipal Member member, RedirectAttributes redirectAttributes) {
//	    // 회원 탈퇴 코드...
//	}

}
