<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
    <link rel="stylesheet" type="text/css" href="https://www.inven.co.kr/sitebuilder/lib/style/dist/commu_style.css?v=bc93539f03bb11963c0f80f1b118198fa"/>

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>게시판</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <link rel="stylesheet" type="text/css" href="CSS/index.css">
    <link rel="stylesheet" type="text/css" href="CSS/header.css">
    <link rel="stylesheet" type="text/css" href="CSS/nav.css">
    <link rel="stylesheet" type="text/css" href="CSS/left_asid.css">
    <link rel="stylesheet" type="text/css" href="CSS/right_asid.css">
        <link rel="stylesheet" type="text/css" href="CSS/footer.css">
   	<script src="/script/login.js"></script>

    <style>
  

  main {

min-width: 939px;
background-color: aliceblue;
padding: 2px;
margin: 1px 5px;
height: 1554px;
margin-left: 1%;
width: 55%;

}    


        section {
            width: 100%;
            max-width: 50%;
            margin: 100px auto;
            padding: 20px;
            background-color: #f2f4f7;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        section h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        section form {
            display: flex;
            flex-direction: column;
        }

        section form label {
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }

        section form input {
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        section form input[type="submit"] {
            margin-top: 20px;
            background-color: #5C6BC0;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px;
            font-size: 16px;
            cursor: pointer;
        }

        section form input[type="submit"]:hover {
            background-color: #3f51b5;
        }
        
        
        #login-msg{
        	color: red;	
        
        }
        
    </style>
</head>

<body>


<header>
    <div>
        <% if(session.getAttribute("loginUser") == null) { %>
            <a href="login_page">로그인</a>
            <a href="create_member_page">회원가입</a>
        <% } else { %>
            <a href="/logout">로그아웃</a>
        <% } %>
    </div>
</header>




    <nav id="commu-nav">
        <div class="board-title">
            <a href="/">
                <img class="channel-icon" src="/images/RIDA.jpg" alt="채널 아이콘">
            </a>
            <div class="right">
                <div class="head">
                    <a href="/" class="title" data-channel-name="이터널 리턴 채널">
                        <span title="이터널 리턴 채널">이터널 리턴 채널 </span>
                    </a><a href="#" class="info-btn" role="button">
                        <span class="ion-ios-information-outline"></span>
                    </a>
                </div>
                <div class="description">
                    <div>
                        <span>구독자 20374명</span>
                        <span class="sep"></span>
                        <span>알림수신 204명</span>
                        <span class="sep"></span>
                        <span class="user-info">
                            <a href="/u/@%EC%8B%9C%EB%A7%88%EB%A6%B0">@시마린</a>
                            <span class="ion-checkmark-circled user-icon user-manager" title="매니저"></span>
                        </span>
                    </div>
                    <div>
                        2023 특.별.한 홀리데이 트리스마스 이벤트 진행 중 !
                    </div>
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
                <h2>로그인</h2>

          		   <form action="/login_page" method="post">
					<p id="login-msg">${loginMsg}</p>	                
                    <label for="memberId">아이디:</label><br>
                    <input type="text" id="memberId" name="memberId"><br>
                    <label for="password">비밀번호:</label><br>
                    <input type="password" id="password" name="password"><br>
                    <input type="submit" value="로그인">
                </form>
            </section>


        </main>


           <aside class="sidebar right-sidebar">
           
           
	<div class="sidebar-item">
	    <img src="images/고양이1.jpg" alt="Example Image">
	    <img src="images/고양이2.jpg" alt="Example Image">
	    <img src="images/고양이3.jpg" alt="Example Image">
	</div>
	





	</aside>
</div>

    <footer class="footer">
                href="mailto:support@arca.live">Contáctenos</a><span class="sep"></span><a
                href="mailto:arcalive@safefra.me">Ads</a><span class="sep"></span><a href="/policy">POLÍTICA DE
                PRIVACIDAD Y REGLAS DE USO</a></p>
        <p>Operado por umanle S.R.L.<span class="sep"></span>Hecho con &lt;3 en Asunción, República del Paraguay</p>
        <p class="footer-current-users"><span class="ion-ios-people"></span>&nbsp;<span
                id="arcalive-current-users">41913</span>명</p>
    </footer>
</body>

</html>