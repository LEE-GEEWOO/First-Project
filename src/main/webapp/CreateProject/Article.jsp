<%@ page import="com.example.common1.BoardDTO" %>
<%@ page import="com.example.common1.BoardDAO" %>
<%@ page import="com.example.user.UserDTO" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    // 세션에서 사용자 정보를 가져오기
    UserDTO user = (UserDTO) session.getAttribute("user");
    String userName = (user != null) ? user.getName() : "";
    Integer userType = (user != null) ? user.getType() : 0; // 로그인된 사용자의 타입

    // 게시물 ID를 URL 파라미터에서 가져오기
    String idxParam = request.getParameter("idx");
    int idx = (idxParam != null && !idxParam.isEmpty()) ? Integer.parseInt(idxParam) : 0;

    // BoardDAO를 사용하여 게시물 데이터를 가져오기
    BoardDAO dao = null;
    BoardDTO dto = null;

    try {
        dao = new BoardDAO();
        dto = dao.getArticleWithViewIncrement(idx); // 게시물 데이터 가져오기 및 조회수 증가
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (dao != null) dao.close();
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= dto != null ? dto.getTitle() : "게시글" %>
    </title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/../css/Article-styles.css">
</head>
<body>
<header>
    <nav class="navbar navbar-expand-sm navbar-custom navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="../html/index.html">
                <img alt src="../jpg/var_logo.png" style="height: 40px; width:40px">
                2024 부산 해산물 마켓
            </a>

            <button class="navbar-toggler" data-target="#collapsibleNavbar" data-toggle="collapse" type="button">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse justify-content-end" id="collapsibleNavbar">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="../html/info.html" style="color: white">관람 안내</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="List.jsp" style="color: white">공지사항</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="QNA.html" style="color: white">Q&A</a>
                    </li>
                    <li class="nav-item dropdown" id="navbarUser">
                        <% if (userName != null && !userName.isEmpty()) { %>
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: white">
                            안녕하세요, <%= userName %>님
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item"
                               href="<%=request.getContextPath()%>/CreateProject/mypage.jsp">마이페이지</a>
                            <a class="dropdown-item"
                               href="<%=request.getContextPath()%>/CreateProject/logout.do">로그아웃</a>
                        </div>
                        <% } else { %>
                        <a class="nav-link" style="color: white"
                           href="<%=request.getContextPath()%>/CreateProject/login.jsp">로그인</a>
                        <% } %>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="var_bottom">
        <p class="v_bot">일시 2024.08.23~25 (금-일)</p>
        <p class="v_bot">시간 9AM - 5PM</p>
        <p class="v_bot3">장소 부산 부산진구 중앙대로 708 <span class="v-bot3-del">부산파이낸스센터 4층</span></p>
        <button class="right-button" name="myButton" onclick="button()">바로 예매하기</button>
    </div>

    <script>
        function button() {
            window.location.href = "../CreateProject/reservation.jsp";
        }
    </script>


</header>

<main class="container my-4">
    <section class="article">
        <% if (dto != null) { %>
        <h1 class="article-title"><span class="article-ti">[공지]</span> <%= dto.getTitle() %>
        </h1>
        <p class="article-tm"><%= dto.getContent() %>
        </p>
        <small>작성자: <%= dto.getAuthor() != null ? dto.getAuthor() : "담당자" %> | 조회수: <%= dto.getViews() %>
        </small>


        <div id="bbsView_footer" class="mt-3">
            <!-- 목록 버튼 추가 -->
            <input type="button" value="목록"
                   class="btn btn-primary" onclick="location.href='List.jsp'"/>

            <% if (userType == 1) { %> <!-- 관리자일 때만 표시 -->
            <input type="button" class="btn btn-warning" value="수정"
                   onclick="location.href='Edit.jsp?idx=<%=dto.getIdx()%>'"/>

            <form action="DeleteAction.jsp" method="post" style="display:inline;"
                  onsubmit="return confirm('정말로 이 게시글을 삭제하시겠습니까?');">
                <input type="hidden" name="idx" value="<%=dto.getIdx()%>"/>
                <input type="submit" value="삭제" class="btn btn-danger"/>
            </form>
            <% } %>
        </div>
        <% } else { %>
        <div class="alert alert-warning" role="alert">
            게시물이 존재하지 않습니다.
        </div>
        <% } %>
    </section>
</main>

<footer>
    <div class="footer">
        <div class="footer_left">
            <a href="../html/info.html">관람안내</a>
            <a href="List.jsp">공지사항</a>
            <a href="reservation.jsp">예매하기</a>
        </div>
        <div class="footer_cen"><b>2024</br>붓싼 해산물 마켓</b></div>
        <div class="footer_right">
            <div>붓싼 해산물 마켓 | 대표자 김민주 | 123-45-6789 [사업자정보확인] | +82 2 123-4567</div>
            <p></p>
            <div>BusanSeaMarket@gmailmilk.com | 이용약관 | 개인정보처리방침</div>
        </div>
    </div>
</footer>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>