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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <link rel="stylesheet" type="text/css" href="CSS/index.css">
    <link rel="stylesheet" type="text/css" href="CSS/header.css">
    <link rel="stylesheet" type="text/css" href="CSS/nav.css">
    <link rel="stylesheet" type="text/css" href="CSS/left_asid.css">
    <link rel="stylesheet" type="text/css" href="CSS/right_asid.css">
    <link rel="stylesheet" type="text/css" href="CSS/footer.css">
	<script src="/script/member.js"></script>
	


    <style>

 /* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ */
        main {
            min-width: 939px;
            background-color: aliceblue;
            padding: 2px;
            margin: 1px 5px;
            height: 75%;
            width: 50%;
            margin-left: 3px;
            margin-right: 3px;
            
        }
       
 /* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ */
/*	메시지--*/
    #memberId-msg {
        font-size: 10px;  /* 원하는 크기로 조정하세요. */
    }

/* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ */



/* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ */
        section {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-color: #f2f4f7;
            padding: 100px;
            border-radius: 10px;
            box-shadow: 0px 0px 20 0px rgba(0, 0, 0, 0.1);
            height: 38%;
            background-repeat: no-repeat;
            background-size: cover;
            background-position: center;

   
        }


        h2 {
            color: #333;
            margin-bottom: 20px;
        }


        form {
            display: flex;
            flex-direction: column;
            width: 100%;
            max-width: 300px;
        }


        label {
            margin-bottom: -10px;
        }


        input[type='text'],
        input[type='password'],
        input[type='email'] {
            padding: 10px;
            margin-bottom: 1px;
            border-radius: 5px;
            border: 1px solid #333;

        }

        input[type='submit'] {
            padding: 10px;
            background-color: #007BFF;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type='submit']:hover {
            background-color: #0056b3;
        }
/* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ */




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
                <ul style="margin-top: 0px; height: 752px;"></ul>
            </div>
        </aside>
		


        <main style="text-align: center;">
            <section>
                <h2>회원가입</h2><br>
                
                <form action="/create_member_page" method="post">
                
              
                    <label for="memberId">회원 ID:</label><br>
                    		<span id="memberId-msg"></span>
                    <input type="text" id="memberId" name="memberId"><br>
                 
                 
                 
           		
                    <label for="password">비밀번호:</label><br>
                    	  <span id="password-msg"></span>
                    <input type="password" id="password" name="password"><br>
               
               
                    <label for="password_confirm">비밀번호 확인:</label><br>
                         <span id="password_check-msg"></span>
                    <input type="password" id="password_confirm" name="passwordCheck"><br>
               
                
                    <label for="email">이메일:</label><br>
                         <span id="email-msg"></span>
                    <input type="email" id="email" name="email"><br>
                
             
                    <label for="name">이름:</label><br>
                             <span id="name-msg"></span>
                    <input type="text" id="name" name="name"><br>
                   
                  
                    <label for="nickname">닉네임:</label><br>
                        <span id="nickname-msg"></span>
                    <input type="text" id="nickname" name="nickname"><br>
                
                  
                   <label for="birthday">생년월일:</label><br>
                       <span id="birthday-msg"></span>
                   <input type="date" id="birthday" name="birthday"><br>
                 
                    
                    <input type="submit" value="회원가입">
                </form>
            </section>
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
	            </c:choose>
	        </c:forEach>
	        
	    </div>
	    <div class="sidebar-by"></div>
	</div>
	
		</aside>
	</div>



    <footer class="footer">
        <p>Live v2&nbsp;<small class="text-muted">(7b489a59)</small><span class="sep"></span><a
                href="mailto:support@arca.live">Contáctenos</a><span class="sep"></span><a
                href="mailto:arcalive@safefra.me">Ads</a><span class="sep"></span><a href="/policy">POLÍTICA DE
                PRIVACIDAD Y REGLAS DE USO</a></p>
        <p>Operado por umanle S.R.L.<span class="sep"></span>Hecho con &lt;3 en Asunción, República del Paraguay</p>
        <p class="footer-current-users"><span class="ion-ios-people"></span>&nbsp;<span
                id="arcalive-current-users">41913</span>명</p>
    </footer>
</body>

</html>