<%@ page import="com.example.common1.BoardDTO" %>
<%@ page import="com.example.common1.BoardDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%@ page import="com.example.user.UserDTO" %>
<%
    UserDTO user = (UserDTO) session.getAttribute("user");
    String userName = (user != null) ? user.getName() : "";
    Integer userType = (user != null) ? user.getType() : 0; // 로그인된 사용자의 타입
%>


<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
    BoardDAO dao = null;
    List<BoardDTO> lists = null;
    String pageNum = request.getParameter("pageNum");
    int currentPage = 1;
    if (pageNum != null) {
        try {
            currentPage = Integer.parseInt(pageNum);
        } catch (NumberFormatException e) {
            currentPage = 1; // 페이지 번호가 올바르지 않으면 1로 설정
        }
    }

    String searchKey = request.getParameter("searchKey");
    String searchValue = request.getParameter("searchValue");

    if (searchValue != null && request.getMethod().equalsIgnoreCase("GET")) {
        searchValue = URLDecoder.decode(searchValue, "UTF-8");
    } else {
        searchKey = "title";
        searchValue = "";
    }

    try {
        dao = new BoardDAO();
        int dataCount = dao.getDataCount(searchKey, searchValue);
        int numPerPage = 10; // 페이지당 데이터 수
        int totalPage = (int) Math.ceil((double) dataCount / numPerPage); // 전체 페이지 수 계산

        if (currentPage > totalPage) {
            currentPage = totalPage; // 현재 페이지가 전체 페이지 수를 초과할 경우 마지막 페이지로 설정
        }

        int start = (currentPage - 1) * numPerPage + 1;
        int end = currentPage * numPerPage;
        lists = dao.getDataList(start, end, searchKey, searchValue);

        String param = "";
        if (!searchValue.equals("")) {
            param = "searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
        }

        String listUrl = "List.jsp";
        if (!param.equals("")) {
            listUrl += "?" + param + "&";
        } else {
            listUrl += "?";
        }

        String articleUrl = cp + "/CreateProject/Article.jsp";
        if (param.equals("")) {
            articleUrl += "?pageNum=" + currentPage;
        } else {
            articleUrl += "?" + param + "&pageNum=" + currentPage;
        }

        // 페이징 관련 변수
        int numPerBlock = 5; // 한 블록당 표시할 페이지 수
        int currentPageSetup = (currentPage / numPerBlock) * numPerBlock;
        if (currentPage % numPerBlock == 0) currentPageSetup = currentPageSetup - numPerBlock;
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=cp%>../css/list-styles.css">
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
                        <a class="nav-link" href="../html/QNA.html" style="color: white">Q&A</a>
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


<main class="container">
    <section class="notification-list">
        <div class="row mb-3">
            <div class="col-md-6">
                <form name="searchForm" method="get" action="">
                    <div class="input-group">
                        <select name="searchKey" class="form-control">
                            <option value="title" <%= "title".equals(searchKey) ? "selected" : "" %>>제목</option>
                            <option value="content" <%= "content".equals(searchKey) ? "selected" : "" %>>내용</option>
                        </select>
                        <input type="text" name="searchValue" class="form-control" value="<%= searchValue %>"/>
                        <div class="input-group-append">
                            <input type="submit" value=" 검색 " class="btn btn-primary"/>
                        </div>
                    </div>
                </form>
            </div>
            <div class="col-md-6 text-right">
                <% if (userType == 1) { %> <!-- 관리자 타입일 때만 글쓰기 버튼 표시 -->
                <a class="btn btn-success" href="<%= cp %>/CreateProject/Write.jsp">글쓰기</a>
                <% } %>
            </div>
        </div>

        <div class="list-group">
            <% if (lists != null && !lists.isEmpty()) { %>
            <% for (BoardDTO dto : lists) { %>
            <div class="list-group-item">
                <div class="d-flex w-100 justify-content-between">
                    <h5 class="mb-1"><a href="<%= articleUrl %>&idx=<%= dto.getIdx() %>">
                        <span class="article-ti" style="color: #950714">[공지] </span> <%= dto.getTitle() %>
                    </a></h5>
                    <small><%= dto.getPostdate() %>
                    </small>
                </div>
                <p class="mb-1-1"><%= dto.getContent() %>
                </p>
                <small>작성자: <%= dto.getAuthor() != null ? dto.getAuthor() : "담당자" %> | 조회수: <%= dto.getViews() %>
                </small>
            </div>
            <% } %>
            <% } else { %>
            <div class="alert alert-warning" role="alert">
                게시물이 없습니다.
            </div>
            <% } %>
        </div>

        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <%
                    if (dataCount != 0) {
                        // 페이지 네비게이션
                        // 처음 페이지
                        if (currentPageSetup > 0) {
                            out.println("<li class='page-item'><a class='page-link' href='" + listUrl + "pageNum=1'>처음</a></li>");
                        }

                        // 이전 블록
                        int n = currentPage - numPerBlock;
                        if (n > 0) {
                            out.println("<li class='page-item'><a class='page-link' href='" + listUrl + "pageNum=" + n + "'>이전</a></li>");
                        }

                        // 페이지 번호
                        for (int i = currentPageSetup + 1; i <= currentPageSetup + numPerBlock && i <= totalPage; i++) {
                            if (i == currentPage) {
                                out.println("<li class='page-item active'><span class='page-link'>" + i + "</span></li>");
                            } else {
                                out.println("<li class='page-item'><a class='page-link' href='" + listUrl + "pageNum=" + i + "'>" + i + "</a></li>");
                            }
                        }

                        // 다음 블록
                        n = currentPage + numPerBlock;
                        if (n <= totalPage) {
                            out.println("<li class='page-item'><a class='page-link' href='" + listUrl + "pageNum=" + n + "'>다음</a></li>");
                        }

                        // 마지막 페이지
                        if (totalPage - currentPageSetup > numPerBlock) {
                            out.println("<li class='page-item'><a class='page-link' href='" + listUrl + "pageNum=" + totalPage + "'>끝</a></li>");
                        }
                    }
                %>
            </ul>
        </nav>
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
            <div>붓싼 해산물 마켓 | 대표 이경민 | 123-45-6789 [사업자정보확인] | +82 2 123-4567</div>
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
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (dao != null) dao.close();
    }
%>