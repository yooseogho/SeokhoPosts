<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<link rel="stylesheet" type="text/css"
    href="https://www.inven.co.kr/sitebuilder/lib/style/dist/commu_style.css?v=bc93539f03bb11963c0f80f1b118198fa" />

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>게시판</title>
    <link rel="stylesheet" type="text/css" href="CSS/index.css">
    <link rel="stylesheet" type="text/css" href="CSS/header.css">
    <link rel="stylesheet" type="text/css" href="CSS/nav.css">
    <link rel="stylesheet" type="text/css" href="CSS/left_asid.css">
    <link rel="stylesheet" type="text/css" href="CSS/right_asid.css">
    <script src="${pageContext.request.contextPath}/resources/summernote/summernote-lite.js"></script>
    <script src="${pageContext.request.contextPath}/resources/summernote/lang/summernote-ko-KR.js"></script>


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



        h2 {
            color: #333;
            margin-bottom: 1em;
        }

        ul {
            list-style-type: none;
            padding: 0;
        }

        li {
            padding: 1em;
            border-bottom: 1px solid #ddd;
        }

        li:last-child {
            border-bottom: none;
        }

        a {
            color: #007bff;
            text-decoration: none;
        }

        a:hover {
            color: #0056b3;
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
        <aside id="left_asid">

            <div class="rb_body">
                <div class="prod_list list_v">
                    <ul style="margin-top: 0px; height: 752px;">
                        <li class="rb_160x600_item__0"> </li>
                        <li class="rb_160x600_item__1"></li>
                        <li class="rb_160x600_item__2"></li>
                    </ul>
                </div>
            </div>

        </aside>
        <main>
            <section>
                <h2>공지사항</h2>
                <ul>
                    <li><a href="#">안녕하세요 여러분 1</a></li>
                    <li><a href="#">곤니찌와 ㅎ하하ㅏ핳 2</a></li>
                    <li><a href="#">앙기모찌이이이이잉이 3</a></li>
                    <li><a href="#">여기는 공지사항을 추가할 글 올리는곳 입니다. </a></li>
                    <li><a href="#">관리자 권한만 공지사항 글을 올릴 수 있습니다.</a></li>
                    <!-- 추가적인 공지사항을 여기에 추가하면 됩니다. -->
                </ul>
            </section>
        </main>



        <aside class="sidebar right-sidebar">
            <div class="sidebar-item">
                <div class="item-title">
                    <a href="/b/singbung?mode=best">유머 채널</a>
                </div>
                <div class="link-list">
                    <a href="/b/singbung/96811807?mode=best">
                        <span class="leaf-info float-right"><time datetime="2024-01-17T06:55:32.000Z"
                                data-format="m-d H:i">01-17 15:55</time></span>
                        뉴스피셜 요즘 증가중이라는 남성유형.jpg
                    </a>
                    <a href="/b/singbung/96856268?mode=best">
                        <span class="leaf-info float-right"><time datetime="2024-01-17T16:21:27.000Z"
                                data-format="m-d H:i">01-18 01:21</time></span>
                        세계최초의 컵라면 회사 닛신라면 근황.jpg
                    </a>
                    <a href="/b/singbung/96848313?mode=best">
                        <span class="leaf-info float-right"><time datetime="2024-01-17T14:31:10.000Z"
                                data-format="m-d H:i">01-17 23:31</time></span>
                        싱글벙글 프랑스 밈
                    </a>
                    <a href="/b/singbung/96849912?mode=best">
                        <span class="leaf-info float-right"><time datetime="2024-01-17T14:51:47.000Z"
                                data-format="m-d H:i">01-17 23:51</time></span>
                        K컵 유튜버
                    </a>
                    <a href="/b/singbung/96808358?mode=best">
                        <span class="leaf-info float-right"><time datetime="2024-01-17T06:12:39.000Z"
                                data-format="m-d H:i">01-17 15:12</time></span>
                        군, 4자녀가정 남성 당직근무 면제…"저출산 극복 동참"
                    </a>
                </div>
            </div>
            <div class="sidebar-item">
                <div class="item-title">
                    <a href="/b/bser?mode=best">이 채널의 개념글</a>
                </div>
                <div class="link-list">
                    <a href="/b/bser/96853184?mode=best">
                        <span class="leaf-info float-right"><time datetime="2024-01-17T15:35:16.000Z"
                                data-format="m-d H:i">01-18 00:35</time></span>
                        레니 뿌슝뿌슝
                    </a>
                    <a href="/b/bser/96839030?mode=best">
                        <span class="leaf-info float-right"><time datetime="2024-01-17T12:36:57.000Z"
                                data-format="m-d H:i">01-17 21:36</time></span>
                        레니 그려옴
                    </a>
                    <a href="/b/bser/96826353?mode=best">
                        <span class="leaf-info float-right"><time datetime="2024-01-17T10:02:58.000Z"
                                data-format="m-d H:i">01-17 19:02</time></span>
                        이새끼들 진짜 패치 존나못하네
                    </a>
                    <a href="/b/bser/96818045?mode=best">
                        <span class="leaf-info float-right"><time datetime="2024-01-17T08:16:19.000Z"
                                data-format="m-d H:i">01-17 17:16</time></span>
                        2024.01.18 - 1.13 패치노트
                    </a>
                    <a href="/b/bser/96821916?mode=best">
                        <span class="leaf-info float-right"><time datetime="2024-01-17T09:08:54.000Z"
                                data-format="m-d H:i">01-17 18:08</time></span>
                        갤펌 ??? 우리팀 테오 뭐함 ㅡㅡ
                    </a>
                </div>
            </div>
            <a href="/api/v1/entry/d7ZuWHJ7CPz6Yat?t=zLcnqmwwq6UCKGT7&amp;s=pc-sidebar" target="_blank"
                style="z-index: 1;"><img
                    src="https://da.namu.la/20240104snc/fc4da6aa2d28dc37230de6701f5a424876f66183fceb2b02334bef61a78b27eb.jpg?expires=1706713200&amp;key=ovRCmO2CCt6K1BWLpyR-MA"></a>


            <div class="sidebar-item" id="newsRank">
                <div class="item-title">
                    나무뉴스 주요
                </div>
                <div class="link-list"><a href="https://namu.news/article/221652"
                        title="아파트 주차장서 중학생 11명 소화기 '난동'…차량 41대 피해(종합)" target="_blank">아파트 주차장서 중학생 11명 소화기 '난동'…차량
                        41대 피해(종합)</a><a href="https://namu.news/article/2216314"
                        title="감사원, '이재명 지역화폐' 관리부실…&quot;선수금 6천억원 유용&quot;(종합)" target="_blank">감사원, '이재명 지역화폐'
                        관리부실…"선수금 6천억원 유용"(종합)</a><a href="https://namu.news/article/2216508"
                        title="[날씨] 출근길 빙판길 조심하세요…중부는 진눈깨비 곳곳" target="_blank">[날씨] 출근길 빙판길 조심하세요…중부는 진눈깨비 곳곳</a><a
                        href="https://namu.news/article/2216315"
                        title="BTS 뷔, 과감한 '최정예 훈련병'…파란 장발→상의 탈의 '숨멎' [엑's 이슈]  " target="_blank">BTS 뷔, 과감한 '최정예
                        훈련병'…파란 장발→상의 탈의 '숨멎' [엑's 이슈] </a><a href="https://namu.news/article/2216473"
                        title="엔씨소프트, TL 공성전 출시 임박…새로운 변화 보여줄까" target="_blank">엔씨소프트, TL 공성전 출시 임박…새로운 변화 보여줄까</a>
                </div>
                <div class="sidebar-by">
                </div>
            </div>

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