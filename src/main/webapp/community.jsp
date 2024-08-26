<%@ page import="com.example.common1.CommunityDAO" %>
<%@ page import="com.example.common1.CommunityDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.example.user.UserDTO" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
  // 로그인 사용자 정보 가져오기
  UserDTO user = (UserDTO) session.getAttribute("user");
  String userId = (user != null) ? user.getName() : "";
  Integer userType = (user != null) ? user.getType() : 0;

  // 요청 인코딩 설정
  request.setCharacterEncoding("UTF-8");

  String cp = request.getContextPath();
  CommunityDAO dao = new CommunityDAO();
  List<CommunityDTO> lists = null;

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
    int dataCount = dao.getDataCount(searchKey, searchValue);
    int numPerPage = 5; // 페이지당 데이터 수
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

    String listUrl = "community.jsp";
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
  <title>커뮤니티</title>
  <link rel="stylesheet" href="<%=cp%>../css/styles.css">
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<header>
  <nav class="navbar navbar-expand-sm navbar-custom navbar-dark">
    <div class="container-fluid">
      <a class="navbar-brand" href="html/index.html">
        <img src="src/main/webapp/jpg/var_logo.png" alt style="height: 40px; width:40px">
        2024 부산 해산물 마켓
      </a>

      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse justify-content-end" id="collapsibleNavbar">
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link" style="color: white" href="html/info.html">관람 안내</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" style="color: white" href="./CreateProject/List.jsp">공지사항</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" style="color: white" href="QNA.html">Q&A</a>
          </li>
          <li class="nav-item dropdown" id="navbarUser">
            <% if (userId != null && !userId.isEmpty()) { %>
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: white">
              안녕하세요, <%= userId %>님
            </a>
            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
              <a class="dropdown-item" href="<%=request.getContextPath()%>/CreateProject/mypage.jsp">마이페이지</a>
              <a class="dropdown-item" href="<%=request.getContextPath()%>/CreateProject/logout.do">로그아웃</a>
            </div>
            <% } else { %>
            <a class="nav-link" style="color: white" href="<%=request.getContextPath()%>/CreateProject/login.jsp">로그인</a>
            <% } %>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</header>

<main class="container mt-4">
  <h1 class="text-center">커뮤니티 게시판</h1>

  <!-- 검색 폼 -->
  <form action="community.jsp" method="get" class="mb-4">
    <div class="form-row">
      <div class="col">
        <input type="text" class="form-control" name="searchValue" value="<%= searchValue %>" placeholder="검색어를 입력하세요">
      </div>
      <div class="col">
        <select class="form-control" name="searchKey">
          <option value="title" <%= "title".equals(searchKey) ? "selected" : "" %>>제목</option>
          <option value="content" <%= "content".equals(searchKey) ? "selected" : "" %>>내용</option>
        </select>
      </div>
      <div class="col">
        <button type="submit" class="btn btn-primary">검색</button>
      </div>
    </div>
  </form>

  <!-- 글쓰기 버튼 (로그인 사용자만) -->
  <% if (userId != null && !userId.isEmpty()) { %>
  <a href="Write.jsp" class="btn btn-success mb-3">글쓰기</a>
  <% } %>

  <!-- 게시물 목록 테이블 -->
  <table class="table table-bordered">
    <thead class="thead-dark">
    <tr>
      <th>번호</th>
      <th>제목</th>
      <th>작성자</th>
      <th>조회수</th>
      <th>좋아요</th>
      <th>작성일</th>
    </tr>
    </thead>
    <tbody>
    <% if (lists != null && !lists.isEmpty()) {
      for (CommunityDTO dto : lists) {
        int idx = dto.getIdx();
        String title = dto.getTitle();
        String author = dto.getAuthor();
        int views = dto.getViews();
        int likes = dto.getLikes();
        java.util.Date postdate = dto.getPostdate();
        String formattedDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(postdate);
    %>
    <tr>
      <td><%= idx %></td>
      <td><a href="<%= cp %>/commview.jsp?idx=<%= idx %>&pageNum=<%= currentPage %>"><%= title %></a></td>
      <td><%= author %></td>
      <td><%= views %></td>
      <td><%= likes %></td>
      <td><%= formattedDate %></td>
    </tr>
    <%
      }
    } else {
    %>
    <tr>
      <td colspan="6" class="text-center">게시물이 없습니다.</td>
    </tr>
    <%
      }
    %>
    </tbody>
  </table>

  <!-- 페이징 -->
  <nav aria-label="Page navigation">
    <ul class="pagination">
      <%
        int startPage = Math.max(currentPage - numPerBlock / 2, 1);
        int endPage = Math.min(startPage + numPerBlock - 1, totalPage);

        if (currentPage > 1) {
      %>
      <li class="page-item">
        <a class="page-link" href="<%= listUrl %>pageNum=1" aria-label="Previous">
          <span aria-hidden="true">&laquo;&laquo;</span>
        </a>
      </li>
      <li class="page-item">
        <a class="page-link" href="<%= listUrl %>pageNum=<%= currentPage - 1 %>" aria-label="Previous">
          <span aria-hidden="true">&laquo;</span>
        </a>
      </li>
      <%
        }

        for (int i = startPage; i <= endPage; i++) {
          if (i == currentPage) {
      %>
      <li class="page-item active"><a class="page-link" href="#"><%= i %></a></li>
      <%
      } else {
      %>
      <li class="page-item"><a class="page-link" href="<%= listUrl %>pageNum=<%= i %>"><%= i %></a></li>
      <%
          }
        }

        if (currentPage < totalPage) {
      %>
      <li class="page-item">
        <a class="page-link" href="<%= listUrl %>pageNum=<%= currentPage + 1 %>" aria-label="Next">
          <span aria-hidden="true">&raquo;</span>
        </a>
      </li>
      <li class="page-item">
        <a class="page-link" href="<%= listUrl %>pageNum=<%= totalPage %>" aria-label="Next">
          <span aria-hidden="true">&raquo;&raquo;</span>
        </a>
      </li>
      <%
        }
      %>
    </ul>
  </nav>
</main>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
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