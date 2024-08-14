<%@ page import="com.example.user.UserDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>마이 페이지</title>
  <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
<div class="container">
  <!-- 중앙 정렬된 제목과 로그아웃 버튼 -->
  <div class="container-central">
    <h1>마이 페이지</h1>
    <%
      // 세션에서 사용자 정보 가져오기
      UserDTO user = (UserDTO) session.getAttribute("user");
      if (user != null) {
    %>
    <!-- 왼쪽 정렬된 정보 영역 -->
    <div class="container-left-align">
      <p>아이디 : <%= user.getId() %></p>
      <p>이름 : <%= user.getName() %></p>
      <p>이메일 : <%= user.getEmail() %></p>
    </div>
    <a href="logout.do" class="btn">Logout</a>
    <%
    } else {
    %>
    <p>로그인하지 않았습니다. <a href="login.jsp">로그인</a></p>
    <%
      }
    %>
  </div>
</div>
</body>
</html>
