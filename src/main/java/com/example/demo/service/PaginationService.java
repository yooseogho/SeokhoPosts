package com.example.demo.service; 

import com.example.demo.dao.CategoryDao;
import com.example.demo.dao.PostsDao;
import com.example.demo.dto.PostsDto.PostsDetail;
import com.example.demo.entity.PagingInfo;
import com.example.demo.entity.Posts;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PaginationService {

    @Autowired
    private PostsDao postsDao;
    
    @Autowired
    private CategoryDao categoryDao;
    

    public List<PostsDetail> getPostsByPage(int pageNum, int pageSize) {
        System.out.println("getPostsByPage: 호출됨, 페이지 번호 = " + pageNum + ", 페이지 크기 = " + pageSize);
        
        List<PostsDetail> allPosts = postsDao.findAllPostsDetail(); // 모든 게시글 상세 정보 조회
        int totalPosts = allPosts.size(); // 전체 게시글 수
        
        // 페이지 시작 인덱스 계산 (0-based index)
        int startIndex = (pageNum - 1) * pageSize;
        // 페이지 끝 인덱스 계산, 전체 게시글 수를 넘지 않도록 처리
        int endIndex = Math.min(startIndex + pageSize, totalPosts);

        // 요청받은 페이지 번호에 맞는 게시글 목록 반환
        return allPosts.subList(startIndex, endIndex);
    }

    
 // 현재 페이지 번호와 카테고리 ID를 기반으로 페이징 정보 계산
    public PagingInfo getPagingInfo(int pageNum, int pageSize, Long cano) {
        Long totalPosts = postsDao.countPostsByCategory(cano); // 카테고리별 게시글 수
        int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
        int pageGroupSize = 5;

        int currentPageGroup = (int) ((pageNum - 1) / pageGroupSize);
        int startPage = currentPageGroup * pageGroupSize + 1;
        int endPage = Math.min(startPage + pageGroupSize - 1, totalPages);

        boolean hasNextGroup = endPage < totalPages;
        boolean hasPreviousGroup = startPage > 1;

        return new PagingInfo(startPage, endPage, hasNextGroup, hasPreviousGroup, totalPages, cano);
    }

    
    // 특정 카테고리의 게시글을 페이지네이션하여 조회하는 새로운 메소드
    public List<PostsDetail> getPostsByCategoryAndPage(Long cano, int pageNum, int pageSize) {
        System.out.println("getPostsByCategoryAndPage: 호출됨, 카테고리 ID = " + cano + ", 페이지 번호 = " + pageNum + ", 페이지 크기 = " + pageSize);

        // 특정 카테고리의 모든 게시글 상세 정보 조회
        List<PostsDetail> postsInCategory = postsDao.findPostsDetailByCategory(cano); 
        int totalPosts = postsInCategory.size(); // 특정 카테고리의 전체 게시글 수
        
        // 페이지 시작 인덱스 계산 (0-based index)
        int startIndex = (pageNum - 1) * pageSize;
        // 페이지 끝 인덱스 계산, 전체 게시글 수를 넘지 않도록 처리
        int endIndex = Math.min(startIndex + pageSize, totalPosts);

        // 요청받은 페이지 번호에 맞는 게시글 목록 반환
        return postsInCategory.subList(startIndex, endIndex);
    }

    
 // 카테고리별 페이징 정보 계산
    public PagingInfo getPagingInfoByCategory(Long cano, int pageNum, int pageSize) {
        // categoryId가 null이거나, 실제로 존재하지 않는 경우의 처리
        if (cano == null || !categoryDao.existsById(cano)) {
            // 여기서 적절한 예외 처리를 하거나, 기본값을 설정할 수 있습니다.
            throw new IllegalArgumentException("유효하지 않은 카테고리 ID입니다.");
        }
        Long totalPosts = postsDao.countPostsByCategory(cano); // 특정 카테고리의 게시글 수 조회
        int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
        int pageGroupSize = 5; // 한 번에 보여줄 페이지 번호 개수

        int currentPageGroup = (int) ((pageNum - 1) / pageGroupSize);
        int startPage = currentPageGroup * pageGroupSize + 1;
        int endPage = Math.min(startPage + pageGroupSize - 1, totalPages);

        boolean hasNextGroup = endPage < totalPages;
        boolean hasPreviousGroup = startPage > 1;

     // 마지막 매개변수로 categoryId를 추가
        return new PagingInfo(startPage, endPage, hasNextGroup, hasPreviousGroup, totalPages, cano);

    }

 // 모든 게시글을 대상으로 페이징 정보 계산
    public PagingInfo getPagingInfoForAllPosts(int pageNum, int pageSize) {
        Long totalPosts = postsDao.countAllPosts(); // 모든 게시글의 수 조회
        int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
        int pageGroupSize = 5; // 한 번에 보여줄 페이지 번호 개수

        int currentPageGroup = (int) ((pageNum - 1) / pageGroupSize);
        int startPage = currentPageGroup * pageGroupSize + 1;
        int endPage = Math.min(startPage + pageGroupSize - 1, totalPages);

        boolean hasNextGroup = endPage < totalPages;
        boolean hasPreviousGroup = startPage > 1;

        // 마지막 매개변수로 null을 전달하여 카테고리 ID 없음을 표시
        return new PagingInfo(startPage, endPage, hasNextGroup, hasPreviousGroup, totalPages, null);
    }



}

