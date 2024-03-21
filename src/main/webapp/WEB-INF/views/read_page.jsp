<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">


<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>게시판</title>
<link rel="stylesheet" type="text/css" href="CSS/index.css">
<link rel="stylesheet" type="text/css" href="CSS/header.css">
<link rel="stylesheet" type="text/css" href="CSS/nav.css">
<link rel="stylesheet" type="text/css" href="CSS/left_asid.css">
<link rel="stylesheet" type="text/css" href="CSS/right_asid.css">
      <link rel="stylesheet" type="text/css" href="CSS/footer.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script src="/script/read.js"></script>


<style>
/* 전체 레이아웃 설정 */
main {
	min-width: 939px;
	background-color: aliceblue;
	padding: 2px;
	margin: 1px 5px;
	height: auto;
	min-height: 100%;
	width: 50%;
	margin-left: 3px;
	margin-right: 3px;
}

section {
	width: 100%;	
	max-width: 80%;
	margin: 100px auto;
	padding: 40px;
	background-color: #f2f4f7;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	height: auto;
	overflow: auto;
}

/* 텍스트 스타일링 */
section h2, h2 {
	text-align: center;
	color: #333;
	margin-bottom: 20px;
}

section form label {
	margin-bottom: 5px;
	font-weight: bold;
	color: #333;
}

/* 폼 스타일링 */
section form, form {
	display: flex;
	flex-direction: column;
}

section form input, textarea, input[type="submit"] {
	margin-bottom: 10px;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
	font-size: 16px;
}

section form input[type="submit"], input[type="submit"] {
	margin-top: 20px;
	background-color: #5C6BC0;
	color: white;
	border: none;
	border-radius: 5px;
	font-size: 16px;
	cursor: pointer;
}

section form input[type="submit"]:hover, input[type="submit"]:hover {
	background-color: #3f51b5;
}

/* 버튼 스타일링 */
.bttnRecommend {
    display: flex;
    align-items: center;
    justify-content: center;
    border: none;
    padding: 10px 20px;
    background-color: #007BFF;
    color: white;
    text-align: center;
    cursor: pointer;
    border-radius: 5px;
    transition: background-color 0.3s ease;
    font-size: 20px;
    width: 100px;
    height: 40px;
    margin: 0 auto;  /* 가운데 정렬을 위해 추가 */
}

.bttnRecommend:hover {
	background-color: #0056b3;
}

.post-recommend {
	background-color: #5C6BC0;
	color: white;
	padding: 10px;
	border-radius: 5px;
	width: fit-content;
}

/* 기타 스타일링 */
.post-info {
	background-color: #f2f4f7;
	padding: 10px;
	border-radius: 5px;
	margin-bottom: 20px;
}

.write-box {
	display: flex;
	align-items: center;
	justify-content: space-between;
	height: 50px;
	font-size: 1.5em;
	color: #333;
	background-color: #f8f9fa;
	border-bottom: 2px solid #333;
	padding: 0 15px;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: bold;
	text-transform: uppercase;
	letter-spacing: 0.05em;
}
/*ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ*/
.comment-item {
	border: 1px solid #ccc;
	background-color: #f2f4f7;
	padding: 15px;
	margin-bottom: 15px;
	border-radius: 5px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.comment-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
	background-color: #b3b3b3; /* 헤더 배경색을 회색으로 설정 */
}

.comment-item, .reply-item {
	border: 1px solid #ccc;
	background-color: #f2f4f7;
	padding: 15px;
	margin-bottom: 15px;
	border-radius: 5px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.comment-box {
	font-weight: bold;
	color: #000; /* 이름을 검은색으로 설정 */
	flex-grow: 1; /* 이름 부분이 가능한 많은 공간을 차지하도록 설정 */
}

.comment-info {
	color: #000; /* 날짜를 검은색으로 설정 */
	margin-right: 10px; /* 날짜와 답글 버튼 사이에 마진 추가 */
}

.top-comment {
	background-color: transparent; /* 버튼 배경색을 투명으로 설정 */
	border: none; /* 버튼 테두리를 제거 */
	cursor: pointer; /* 답글 버튼에 마우스 포인터를 변경 */
	color: #000; /* 답글 버튼 글자색을 검은색으로 설정 */
}

.reply-list {
	margin-left: 20px; /* 답글 목록을 약간 들여쓰기 */
}
/*ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ*/
.reply-form {
	border: 1px solid #ccc;
	padding: 1px;
	margin-bottom: 1px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	background-color: #fff; /* 폼 전체 배경색을 흰색으로 설정 */
}

.reply-form__container {
	display: flex;
	flex-direction: column;
}

.reply-form__user-info {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
	border-bottom: 1px solid #ccc; /* 밑줄 추가 */
}

.reply-form-textarea-wrapper {
	position: relative;
	min-height: 0em;
	padding-bottom: 0px;
}

.reply-form-textarea {
	border: none;
	width: 100%;
	height: 100%;
	overflow: auto; /* 스크롤 가능하게 설정 */
	resize: none;
}

.form-footer {
	position: absolute; /* 작성 버튼을 절대 위치로 설정 */
	right: 10px; /* 작성 버튼을 오른쪽으로 정렬 */
	bottom: 20px; /* 작성 버튼을 아래쪽으로 정렬. 값을 높여서 버튼을 위로 올림 */
}

.form-footer button {
	border: 1px solid #000; /* 테두리를 검은색으로 설정 */
	background-color: transparent; /* 배경색을 투명으로 설정 */
	border-radius: 5px;
	padding: 5px 10px;
	cursor: pointer; /* 작성 버튼에 마우스 포인터를 변경 */
	color: #000; /* 작성 버튼 글자색을 검은색으로 설정 */
}
</style>

</head>

<body>


	<header>
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
			<a href="/"> <img class="channel-icon" src="/upload/RIDA.jpg"
				alt="채널 아이콘">
			</a>
			<div class="right">
				<div class="head">
					<a href="/" class="title" data-channel-name="이터널 리턴 채널"> <span
						title="이터널 리턴 채널">이터널 리턴 채널 </span>
					</a><a href="#" class="info-btn" role="button"> <span
						class="ion-ios-information-outline"></span>
					</a>
				</div>
				<div class="description">
					<div>
						<span>구독자 20374명</span> <span class="sep"></span> <span>알림수신
							204명</span> <span class="sep"></span> <span class="user-info"> <a
							href="/u/@%EC%8B%9C%EB%A7%88%EB%A6%B0">@시마린</a> <span
							class="ion-checkmark-circled user-icon user-manager" title="매니저"></span>
						</span>
					</div>
					<div>2023 특.별.한 홀리데이 트리스마스 이벤트 진행 중 !</div>
				</div>
			</div>
		</div>
	</nav>

<div class="container">
    <div class="content-container">
        <aside id="left_asid">
            <div class="prod_list list_v">
                <ul style="margin-top: 0px; height: 752px;"></ul>
            </div>
        </aside>

		<main>
			<div>
				<h1 style="font-size: 2em; color: #333; text-align: center;">${post.title}</h1>
			</div>

			<div class="post-info">
				<span>작성자: ${post.nickname}</span> <span>조회수${post.views} |</span> <span>추천${post.likeCount}
					|</span> <span>댓글수${post.commentsCount} |</span> <span>작성일자${post.postsCreatedate}
					|</span> <span>추천 ${post.likeCount} </span>
			</div>
			<hr>
			<br>

			<div>
				<p>${post.postsContent}</p>
			</div>

<div class="botMenuCenter">
    <div class="bttnRecom onlyRecom">
        <a class="bttnRecommend"
            href="javascript:alert('로그인 하셔야 추천할 수 있습니다');" title="추천하기"> 
            <img src="/images/thumbs-up-regular.svg" alt="추천 이모티콘" width="35" height="35"> 
            <span class="reqnum reqblue"><span id="recomresult_173">
        </a>
    </div>
			</div>
			<hr>
			<div class="write-box">
				<span>댓글목록</span>
				<div class="float-right">
					<div class="box">
						<a class="btn btn-sm btn-arca btn-arca-article-write"
							href="/write_page" title="글쓰기"> <img src="/upload/pen-to.svg">
							<span class="ion-compose"> </span> 글쓰기
						</a>
					</div>
				</div>
			</div>

			<hr>
			<div>
				<!-- 댓글 목록 -->
<div class="comment-list">

</div>
		
				
		





		<%@ page import="javax.servlet.http.HttpSession" %>
<%
// 세션에서 로그인 상태 확인
boolean isLoggedIn = (session != null && session.getAttribute("loginUser") != null);
%>

<form id="commentForm" class="reply-form">
    <div class="reply-form__container">
        <div class="reply-form__user-info">
            <span class="reply-form-title">댓글 작성</span> <input
                class="reply-form-user-input" type="text" disabled="disabled"
                value="이리이리이리">
        </div>
        <div class="reply-form-textarea-wrapper">
            <textarea class="reply-form-textarea" id="commentsContent"
                name="commentsContent" rows="4">
            </textarea>
            <input type="hidden" id="isLoggedIn" value="<%= isLoggedIn ? "true" : "false" %>" /> <!-- 로그인 상태 표시, 서버에서 설정 -->
            
            <div class="form-footer">
                <button id="submitComment" type="button">작성</button>
                
            </div>
              <input type="hidden" id="pno" value="${post.pno}" />  <!-- 'pno' 값 저장 -->
        </div>
    </div>
</form>





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
</body>

</html>