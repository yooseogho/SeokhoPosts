<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시판</title>
<!-- jQuery 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<!-- Popper.js 라이브러리 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- Bootstrap JS -->
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- Summernote CSS & JS -->
<link href="/summernote/summernote-lite.css" rel="stylesheet">
<script src="/summernote/summernote-lite.js"></script>
<script src="/summernote/lang/summernote-ko-KR.min.js"></script>


<!-- 나머지 스크립트 -->
<script src="/script/write.js"></script>
>
<link rel="stylesheet" type="text/css" href="CSS/index.css">
<link rel="stylesheet" type="text/css" href="CSS/header.css">
<link rel="stylesheet" type="text/css" href="CSS/nav.css">
<link rel="stylesheet" type="text/css" href="CSS/left_asid.css">
<link rel="stylesheet" type="text/css" href="CSS/right_asid.css">
<link rel="stylesheet" type="text/css" href="CSS/footer.css">






<style>
main {
	min-width: 930px;
	background-color: aliceblue;
	padding: 2px;
	margin: 4px 4px;
	height: 1542px;
	width: 47%;
}

/* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡnav글쓰기 메뉴에 맞게 수정ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ */
#commu-nav {
	background-color: #f8f9fa;
	border-radius: 11px;
	padding: 0px;
	margin: 4px 298px 5px -13px;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
	display: flex;
	justify-content: flex-start;
	width: 73%;
	height: 100px;
	overflow: hidden;
	float: left;
	position: relative;
	width: 73%;
}

/* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ글쓰기 헤더 부분ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ */
.form-group {
	margin-bottom: -1rem;
}

.note-toolbar {
	width: 100%;
	/* 도구 탭의 너비를 최대로 늘립니다 */
	flex-wrap: nowrap;
	/* 도구 탭 내의 요소들이 한 줄에만 나타나도록 합니다 */
}

.write-head {
	font-size: 1.5em;
	/* 글자 크기 설정 */
	color: #333;
	/* 글자 색상 설정 */
	padding: 10px;
	/* 패딩 설정 */
	background-color: #f8f9fa;
	/* 배경색 설정 */
	border-top: 2px solid #dee2e6;
	/* 위쪽 선 스타일 설정 */
	border-bottom: 2px solid #dee2e6;
	/* 아래쪽 선 스타일 설정 */
	text-align: left;
	/* 텍스트 왼쪽 정렬 설정 */
	/* 아래쪽 마진 설정 */
	font-size: 1.5em;
	color: #333;
	margin-bottom: 7px;
	margin-top: -5px;
}

/* ㅡㅡㅡㅡ카테고리 선택 탭ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ */
.sub-row {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
	justify-content: center;
	align-items: center;
	/* 추가 */
}

.sub-row span input[type=radio] {
	margin-right: 5px;
}

.sub-row span {
	margin-right: 10px;
	/* 추가 */
}

/* 라디오 버튼을 숨김 */
input[type="radio"] {
	display: none;
}

/* 라디오 버튼이 선택되지 않은 레이블의 스타일 */
input[type="radio"]+label {
	padding: 10px;
	background: #f2f2f2;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background .3s;
}

/* 라디오 버튼이 선택되었을 때의 레이블 스타일 */
input[type="radio"]:checked+label {
	background: #4caf50;
	color: white;
}

/* 레이블에 마우스를 올렸을 때의 스타일 */
input[type="radio"]+label:hover {
	background: #ddd;
}

/* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ */

/* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ글쓰기 본문ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ */
/* 제목 입력 부분 스타일 */
.input-group {
	margin-bottom: 30px;
	width: 91%;
	margin-left: 38px;
}

.input-group-text {
	margin: -1px;
}

/* Summernote 에디터 부분 스타일 */
.summernote {
	border: 1px solid #ccc;
	/* 테두리 스타일 변경 */
	border-radius: 5px;
	/* 테두리 둥글게 */
}

.summernote-container {
	width: 900px;
	min-width: 900px;
}

/* Summernote 에디터의 툴바 부분 스타일 */
.note-toolbar {
	background-color: #f8f9fa;
	/* 배경색 변경 */
}

/* Summernote 에디터의 입력 부분 스타일 */
.note-editable {
	background-color: #ffffff;
	/* 배경색 변경 */
	color: #333;
	/* 글자색 변경 */
	height: 500px;
}

/* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ */
.fr-counter {
	float: left;
	opacity: 0.5;
	/* 1.0은 완전 불투명, 0.0은 완전 투명. 이 경우에는 0.5로 설정하여 반투명하게 만듭니다. */
}

/* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ작성버튼ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ */
.btn {
	border: none;
	border-radius: 5px;
	font-size: 18px;
	cursor: pointer;
}

.btns {
	display: flex;
	justify-content: right;
}

.btn:hover {
	background-color: #c44569;
}

.btn:active {
	background-color: #903749;
}

.btn-arca {
	border: 1px solid #000;
	color: #333;
	font-size: 16px;
}

.btn-arca:hover {
	background-color: #b8a9c9;
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
			<a href="/"> <img class="channel-icon" src="/images/RIDA.jpg"
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
        
		<main style="text-align: center;">
			<div class="write-head">글쓰기</div>

			<div class="sub-row">
				<span>글머리</span> <span> <input type="radio" name="category"
					id="category-general" value="" checked="" required=""> <label
					for="category-general">일반</label>
				</span> <span> <input type="radio" name="category" id="category-공지"
					value="공지"> <label for="category-공지">공지</label>
				</span> <span> <input type="radio" name="category" id="category-공략"
					value="공략"> <label for="category-공략">공략</label>
				</span> <span> <input type="radio" name="category" id="category-정보"
					value="정보"> <label for="category-정보">정보</label>
				</span> <span> <input type="radio" name="category" id="category-늒네"
					value="늒네"> <label for="category-늒네">질문</label>
				</span> <span> <input type="radio" name="category" id="category-창작"
					value="창작"> <label for="category-창작">🎨창작</label>
				</span> <span> <input type="radio" name="category" id="category-짤"
					value="짤"> <label for="category-짤">그림/만화</label>
				</span>









				<section>
					<form id="uploadForm" action="/writePost" method="post"
						enctype="multipart/form-data">
						<div class="row">
							<div class="form-group col-12">
								<div class="input-group input-group-sm">
									<div class="input-group-prepend">
										<span class="input-group-text">제목</span>
									</div>
									<input type="text" name="title"
										class="form-control form-control-sm js-bound" id="inputTitle"
										maxlength="256" required="">
								</div>
							</div>
						</div>
						<div id="summernote">
							<div class="fr-second-toolbar"></div>

						</div>

						<span class="fr-counter">문자 : 1</span>
						<script>
							$('#uploadForm').on(
									'submit',
									function(e) {
										$('#postsContent').val(
												$('#summernote').summernote(
														'code'));
									});
						</script>


						<input type="file" name="file">


						<div class="btns">
							<button class="btn btn-arca" id="submitBtn" type="submit">작성</button>
						</div>
						<input type="hidden" name="postsContent" id="postsContent">
					</form>
				</section>
		</main>

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