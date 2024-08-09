<%@page import="com.example.board.BoardDTO"%>
<%@page import="com.example.board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.example.common.DBConnPool1"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="com.example.board.BoardDAO" %>
<%@page contentType="text/html; charset=UTF-8"%>
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
            param = "?searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
        }

        String listUrl = "List.jsp" + param;
        String articleUrl = cp + "/CreateProject/Article.jsp";
        if (param.equals("")) {
            articleUrl += "?pageNum=" + currentPage;
        } else {
            articleUrl += param + "&pageNum=" + currentPage;
        }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항</title>
    <link rel="stylesheet" type="text/css" href="<%=cp%>/CreateProject/css/styles.css"/>
</head>
<body>
<div id="bbsList">
    <div id="bbsList_title">공지사항</div>
    <div id="bbsList_header">
        <div id="leftHeader">
            <form name="searchForm" method="get" action="">
                <select name="searchKey" class="selectField">
                    <option value="title" <%= "title".equals(searchKey) ? "selected" : "" %>>제목</option>
                    <option value="content" <%= "content".equals(searchKey) ? "selected" : "" %>>내용</option>
                </select>
                <input type="text" name="searchValue" class="textField" value="<%= searchValue %>"/>
                <input type="submit" value=" 검색 " class="btn2"/>
            </form>
        </div>
        <div id="rightHeader">
            <input type="button" value=" 글쓰기 " class="btn2" onclick="location.href='<%=cp%>/CreateProject/Write.jsp';"/>
        </div>
    </div>
    <div id="bbsList_list">
        <div id="title">
            <dl>
                <dt class="num">번호</dt>
                <dt class="subject">제목</dt>
                <dt class="name">작성자</dt>
                <dt class="created">작성일</dt>
                <dt class="hitCount">조회수</dt>
            </dl>
        </div>
        <div id="lists">
            <% if (lists != null && !lists.isEmpty()) { %>
            <% for (BoardDTO dto : lists) { %>
            <dl>
                <dd class="num"><%= dto.getIdx() %></dd>
                <dd class="subject">
                    <a href="<%= articleUrl %>&idx=<%= dto.getIdx() %>"><%= dto.getTitle() %></a>
                </dd>
                <dd class="name"><%= dto.getType() %></dd>
                <dd class="created"><%= dto.getPostdate() %></dd>
                <dd class="hitCount"><%= dto.getViews() %></dd>
            </dl>
            <% } %>
            <% } else { %>
            <p>게시물이 없습니다.</p>
            <% } %>
        </div>
        <div id="footer">
            <!-- 페이지 네비 추가 가능 -->
        </div>
    </div>
</div>
</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (dao != null) dao.close();
    }
%>