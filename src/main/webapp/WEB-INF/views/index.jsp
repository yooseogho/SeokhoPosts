<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>	


<link rel="stylesheet" type="text/css"
	href="https://www.inven.co.kr/sitebuilder/lib/style/dist/commu_style.css?v=bc93539f03bb11963c0f80f1b118198fa" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>



<head>
<meta name=”viewport”
	content=”initial-scale=1.0;maximum-scale=1.0;minimum-scale=1.0;
	user-scalable=no;” />
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시판</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="/script/category.js"></script>
<link rel="stylesheet" type="text/css" href="CSS/index.css">
<link rel="stylesheet" type="text/css" href="CSS/header.css">
<link rel="stylesheet" type="text/css" href="CSS/nav.css">
<link rel="stylesheet" type="text/css" href="CSS/left_asid.css">
<link rel="stylesheet" type="text/css" href="CSS/right_asid.css">
<link rel="stylesheet" type="text/css" href="CSS/footer.css">


<script>
	
	window.onload = function() {
		// 쿠키에서 이름을 가져옴
		var name = getCookie('name');

		// 이름이 존재하면, 알림 창을 띄우고 이름을 쿠키에서 삭제
		if (name) {
			alert(name + '님, 환영합니다!');
			deleteCookie('name');
		}
	}

	function getCookie(cname) {
		var name = cname + "=";
		var decodedCookie = decodeURIComponent(document.cookie);
		var ca = decodedCookie.split(';');
		for (var i = 0; i < ca.length; i++) {
			var c = ca[i];
			while (c.charAt(0) == ' ') {
				c = c.substring(1);
			}
			if (c.indexOf(name) == 0) {
				return c.substring(name.length, c.length);
			}
		}
		return "";
	}

	function deleteCookie(name) {
		document.cookie = name
				+ '=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
	}
	
	$(document).ready(function(){
	    // 메뉴 항목을 클릭했을 때의 이벤트 핸들러
	    $('#menuList li').click(function() {
	        // 모든 메뉴 항목에서 'active-menu' 클래스를 제거합니다.
	        $('#menuList li').removeClass('active-menu');

	        // 클릭된 메뉴 항목에만 'active-menu' 클래스를 추가합니다.
	        $(this).addClass('active-menu');

	        // 게시글 목록을 숨깁니다.
	        $('.board-post').hide();
	    });
	});

	
</script>
<style>
main {
	min-width: 939px;
	background-color: aliceblue;
	padding: 2px;
	margin: 1px 5px;
	height: 850px;
	min-height:100%;
	width: 50%;
	margin-left: 3px;
	margin-right: 3px;
	
}

section {
	margin: 20px 20px 20px 20px;
}

/* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ메뉴목록ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ */
#menuList {
	list-style: none;
	/* 리스트 스타일 제거 */
	padding: 0;
	/* 패딩 제거 */
	display: flex;
	/* 리스트 아이템들을 가로로 나열 */
	justify-content: space-between;
	/* 아이템들 사이에 공간을 균등하게 분배 */
	border-bottom: 1px solid #ddd;
	/* 전체 메뉴에 대한 밑줄 추가 */
}

#menuList li {
	position: relative;
	margin: 10px;
	/* 아이템들 간의 마진 설정 */
}

#menuList li a {
	text-decoration: none;
	/* 링크의 밑줄 제거 */
	color: #333;
	/* 링크 색상 설정 */
	font-size: 1.2em;
	/* 폰트 크기 설정 */
}

#menuList li a:hover {
	color: #007BFF;
	/* 링크에 마우스를 올렸을 때의 색상 설정 */
}

#menuList li.active-menu::after {
	content: '';
	position: absolute;
	left: -10px;
	/* 감싸는 밑줄이 메뉴 아이템의 패딩 영역까지 확장되도록 설정 */
	right: -10px;
	/* 감싸는 밑줄이 메뉴 아이템의 패딩 영역까지 확장되도록 설정 */
	bottom: -10px;
	/* 감싸는 밑줄이 메뉴 아이템 아래에 위치하도록 설정 */
	height: 1px;
	background: #FF6347;
}

/*ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ */

/* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ게시글 작성후 밑줄ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ */
.board-post {
	border-bottom: 1px solid rgba(0, 0, 0, 0.2);
	/* 밑줄 색상을 검정색의 50% 투명도로 설정 */
	padding-bottom: 10px;
	/* 밑줄과 게시글 사이의 간격 설정 */
}

/* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ */

/* 본문 광고 이미지 */
.responsive-image {
	width: 80%;
	height: auto;
	margin-bottom: 30px;
}

/* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ */
#board-header, .board-post {
	list-style-type: none;
	padding: 0;
	display: grid;
	grid-template-columns: 1fr 3fr 2fr 2fr 1fr 1fr;
	/* 각 컬럼의 비율 설정 */
	gap: 1em;
	/* 각 항목 사이의 간격 설정 */
	background-color: #f2f4f7;
	padding: 2px;
}

.board-post {
	padding: 10px;
}

/*ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ카테고리ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ*/
#menuList {
	display: flex;
	list-style-type: none;
	justify-content: space-around;
	/* 메뉴 항목들 사이에 공간을 동일하게 배분 */
	padding: 0;
	/* 패딩 제거 */
	min-width: 582px;
}

#menuList li a {
	color: black;
	text-decoration: none;
	/* 링크 밑줄 제거 */
}

#menuList li a:hover {
	color: blue;
	/* 마우스를 가져다 대었을 때의 텍스트 색상 */
	font-weight: bold;
	/* 마우스를 가져다 대었을 때의 텍스트 굵기 */
}

#menuList li {
	display: inline-block;
	/* 리스트 항목을 인라인 블록으로 설정 */
	margin-right: 10px;
	/* 항목 사이의 간격 조정 */
}

/* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ세션밑에 전체글 추천글 선택 목록ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ*/
.btn:hover {
	background-color: #0056b3;
	border-color: #0056b3;
}

.select-list-type {
	width: 68px;
	margin-left: 10px;
	margin-right: 0px;
}

/* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ세션밑에 검색창ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ*/
.search-form {
	display: flex;
	justify-content: flex-end;
	/* 오른쪽 정렬 */
	width: 874px;
	box-sizing: border-box;
	/* 추가된 부분 */
}

.right-aligned-group select, .right-aligned-group input,
	.right-aligned-group button {
	font-size: 0.8em;
	/* 폰트 크기를 줄임 */
	padding: 5px;
	/* 패딩을 조정함 */
}

.right-aligned-group select {
	background-color: #f8f9fa;
	/* 배경색을 설정함 */
	border: 1px solid #ced4da;
	/* 테두리를 설정함 */
	border-radius: 3px;
	/* 테두리 모서리를 둥글게 만듦 */
}

.right-aligned-group input {
	background-color: #ffffff;
	/* 배경색을 설정함 */
	border: 1px solid #ced4da;
	/* 테두리를 설정함 */
	border-radius: 3px;
	/* 테두리 모서리를 둥글게 만듦 */
}

.right-aligned-group button {
	background-color: #007bff;
	/* 배경색을 설정함 */
	border: 1px solid #007bff;
	/* 테두리를 설정함 */
	color: #ffffff;
	/* 글자색을 설정함 */
	border-radius: 3px;
	/* 테두리 모서리를 둥글게 만듦 */
}

/* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ*/
.input-group {
	width: 300px;
}

.list-boderbar {
	display: flex;
	justify-content: flex-start;
}

/*  글쓰기 버튼쪽*/
.box {
	border: 1px solid #000;
	/* 테두리 설정 */
	padding: 2px;
	/* 안쪽 여백 설정 */
	margin: 13px;
	/* 바깥쪽 여백 설정 */
}

/* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ*/

/* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ글쓰기ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ*/
.float-right {
	float: right;
}

.right-aligned-group {
	margin-left: auto;
	display: flex;
	/* 추가된 부분 */
}

.right-aligned-group>* {
	margin-right: 10px;
}

/* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ페이징쿼리 cssㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ*/
.pagination {
	list-style: none;
	/* 목록 스타일 제거 */
	padding: 0;
	/* 패딩 제거 */
	display: flex;
	/* 플렉스박스로 만들어 아이템들을 가로로 배치 */
	justify-content: center;
	/* 아이템들을 가운데 정렬 */
}

.page-item {
	margin: 0 5px;
	/* 아이템들 사이에 마진 추가 */
}

.page-link {
	display: block;
	/* 링크를 블록 요소로 만들어 아이템 전체에 클릭 영역 확장 */
	padding: 5px 10px;
	/* 패딩 추가 */
	color: #000000;
	/* 링크 색상 설정 */
	text-decoration: none;
	/* 밑줄 제거 */
}

.page-item.active .page-link {
	background-color: #007bff;
	/* 활성화된 아이템의 배경색 설정 */
	color: #ffffff;
	/* 활성화된 아이템의 글자색 설정 */
}

    .channel-logo {
        width: 400px; /* 원하는 너비로 설정 */
        height: auto; /* 높이를 자동으로 조절하여 비율 유지 */
    }
/* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ*/
</style>
</head>

<body>

	<header>
		<a href="/"> <img class="channel-logo" src="/images/logo.png"
				alt="채널 로고">
			</a>
		<div>
			<%
			if (session.getAttribute("loginUser") == null) {
			%>
			<a href="login_page">로그인</a> <a href="create_member_page">회원가입</a>
			<%
			} else {
			%>
			<a href="/logout">로그아웃</a>
			<%
			}
			%>
		</div>
	</header>




	<nav id="commu-nav">
		<div class="board-title">
			<a href="/"> <img class="channel-icon" src="/images/고양이1.jpg"
				alt="채널 아이콘">
			</a>
			<div class="right">
				<div class="head">
					<a href="/" class="title" data-channel-name=""> <span
						title="">SEOKHO채널 </span>
					</a><a href="#" class="info-btn" role="button"> <span
						class="ion-ios-information-outline"></span>
					</a>
				</div>
				<div class="description">
					<div>
						<span>안녕하세요 |</span> <span class="sep"></span> <span>
							 |</span> <span class="sep"></span> <span class="user-info">
							<a href="">@유석호</a> <span
							class="ion-checkmark-circled user-icon user-manager" title="매니저"></span>
						</span>
					</div>
					<div>2024 고양이 커뮤니티 !</div>
				</div>
			</div>
		</div>
	</nav>




<div class="container">
    <div class="content-container">
        <aside id="left_asid">
            <div class="prod_list list_v">
                
            </div>
        </aside>
		
		

		<main style="text-align: center;">
		
			<section>
<img src="//img.mobon.net/servlet/image/mobon/728x90.png">


<ul id="menuList">
    <li class="active-menu" data-category-id="all"><a href="#" onclick="return false;">전체</a></li>
    <li data-category-id="1"><a href="#" onclick="return false;">일반</a></li>
    <li data-category-id="2"><a href="#" onclick="return false;">공지</a></li>
    <li data-category-id="3"><a href="#" onclick="return false;">정보</a></li>
    <li data-category-id="4"><a href="#" onclick="return false;">질문</a></li>
    <li data-category-id="5"><a href="#" onclick="return false;">사진</a></li>
</ul>

				<ul id="board-header">
				
					<li>번호</li>
					<li>제목</li>
					<li>작성자</li>
					<li>작성일</li>
					<li>조회수</li>
					<li>추천</li>
				</ul>




<div id="postsContainer" >
</div>



			</section>

			<div class="list-boderbar">
				<a class="btn btn-sm btn-arca float-left" href="/"> <span
					class="ion-android-list"></span> <span>전체글</span>
				</a> <select class="form-control select-list-type" name="sort">
					<option value="">등록순</option>
					<option value="rating">추천순 (24시간)</option>
					<option value="rating72">추천순 (3일)</option>
					<option value="ratingAll">추천순 (전체)</option>
					<option value="commentCount">댓글갯수순 (3일)</option>
					<option value="recentComment">최근댓글순</option>
				</select> <select class="form-control select-list-type" name="cut">
					<option value="">추천컷</option>
					<option>5</option>
					<option>10</option>
					<option>20</option>
					<option>30</option>
					<option>50</option>
					<option>70</option>
					<option>100</option>
					<option value="etc">기타</option>
				</select>
			</div>

			<div class="float-right">
				<div class="box">
					<a class="btn btn-sm btn-arca btn-arca-article-write"
						href="/write_page" title="글쓰기"> <img src="/images/pen-to.svg">
						<span class="ion-compose"> </span> 글쓰기
					</a>
				</div>
			</div>

			<form action="/b/bser" method="get"
				class="form-inline search-form justify-content-end">
				<div class="input-group">
					<div class="right-aligned-group">
						<select class="form-control form-control-sm" name="target">
							<option value="all" selected="">전체</option>
							<option value="title_content">제목/내용</option>
							<option value="title">제목</option>
							<option value="content">내용</option>
							<option value="nickname">글쓴이</option>
							<option value="comment">댓글</option>

						</select> <input type="text" class="form-control form-control-sm js-bound"
							name="keyword" value="" aria-labelledby="searchFormLabel">
						<div class="input-group-append">
							<button class="btn btn-arca btn-sm" type="submit">검색</button>
						</div>
					</div>
				</div>
			</form>
<div>


	<!--   페이징 처리1111 -->
	    <ul class="pagination justify-content-center">
	        <!-- 이전 페이지 그룹 링크 -->
<!-- 이전 페이지 그룹 링크, activeCategory 변수에 현재 카테고리 ID를 설정해야 함 -->
<c:if test="${pagingInfo.hasPreviousGroup}">
    <li class="page-item">
        <a class="page-link" href="?category=${activeCategory}&page=${pagingInfo.startPage - 1}" aria-label="Previous">
            <span aria-hidden="true">&laquo;</span>
            <span class="sr-only">이전</span>
        </a>
    </li>
</c:if>

<!-- 페이지 번호들 -->
<c:forEach var="pageNum" begin="${pagingInfo.startPage}" end="${pagingInfo.endPage}">
    <li class="${pageNum == page ? 'page-item active' : 'page-item'}">
        <a class="page-link" href="?category=${activeCategory}&page=${pageNum}">${pageNum}</a>
    </li>
</c:forEach>

<!-- 다음 페이지 그룹 링크 -->
<c:if test="${pagingInfo.hasNextGroup}">
    <li class="page-item">
        <a class="page-link" href="?category=${activeCategory}&page=${pagingInfo.endPage + 1}" aria-label="Next">
            <span aria-hidden="true">&raquo;</span>
            <span class="sr-only">다음</span>
        </a>
    </li>
</c:if>
	    </ul>
</div>
		</main>
		
		


         <aside class="sidebar right-sidebar">
	<div class="sidebar-item">
		<div class="item-title">
			<a>최신글</a>
		</div>
	<div class="link-list" id="latest-posts">
</div>
	</div>
	
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script>
$(document).ready(function() {
    updateLatestPosts();

    // 최신글 정보 가져오기
    setInterval(updateLatestPosts, 60000);  // 60000 밀리초(1분)마다 실행
});

function updateLatestPosts() {
    $.ajax({
        url: "/api/latest-posts",  // 최신 게시글 정보를 가져올 API URL
        type: "GET",
        success: function(data) {
            console.log(data);  
            var linkList = $('#latest-posts');  
            linkList.empty();  // 기존 게시글 목록을 삭제
            // 새로운 게시글 목록을 생성
            data.forEach(function(post) {
            	var postLink = $('<a>').attr('href', 'read_page?pno=' + post.pno).text(post.title);

                if (post.postsCreatedate) {
                    var postTime = $('<span>').addClass('leaf-info float-right')
                                              .append($('<time>').attr('datetime', post.postsCreatedate)
                                                                 .attr('data-format', 'm-d')
                                                                 .text(post.postsCreatedate));
                 												   postLink.append(postTime);  
                }

	                linkList.append(postLink);
            });
        },
        
        error: function(error) {
            console.log("Error: ", error);
        }
    });
}
</script>


<div class="sidebar-item" id="newsRank">
    <div class="item-title">뉴스</div>
    <div class="link-list">
        <c:forEach var="news" items="${newsData}">
            <c:choose>
                <c:when test="${fn:length(news.title) > 10}">
                    <a href="${news.link}" title="${news.title}" target="_blank">${fn:substring(news.title, 0, 18)}...</a>
                </c:when>
                <c:otherwise>
                    <a href="${news.link}" title="${news.title}" target="_blank">${news.title}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
    <div class="sidebar-by"></div>
</div>



	</aside>
</div>


	<footer class="footer">
		<p>
			Live v2&nbsp;<small class="text-muted">(7b489a59)</small><span
				class="sep"></span><a href="mailto:support@arca.live">Contáctenos</a><span
				class="sep"></span><a href="mailto:arcalive@safefra.me">Ads</a><span
				class="sep"></span><a href="/policy">POLÍTICA DE PRIVACIDAD Y
				REGLAS DE USO</a>
		</p>
		<p>
			Operado por umanle S.R.L.<span class="sep"></span>Hecho con &lt;3 en
			Asunción, República del Paraguay
		</p>
		<p class="footer-current-users">
			<span class="ion-ios-people"></span>&nbsp;<span
				id="arcalive-current-users">41913</span>명
		</p>
	</footer>
	</div>
	
	
</body>

</html>