<%@ page import="com.example.user.UserDTO" %>
<%@ page import="com.example.user.UserDAO" %>
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
    <h1>마이페이지</h1>
    <%
      // 세션에서 사용자 정보 가져오기
      UserDTO user = (UserDTO) session.getAttribute("user");
      if (user == null) {
        // 로그인이 안되어 있다면 로그인 페이지로 리다이렉트
        response.sendRedirect("login.jsp");
        return;
      }

      // 폼이 제출되었는지 확인
      if (request.getMethod().equalsIgnoreCase("POST")) {
        String newName = request.getParameter("name");
        String newEmail = request.getParameter("email");

        UserDAO dao = new UserDAO();
        user.setName(newName);
        user.setEmail(newEmail);

        int result = dao.updateUser(user);

        if (result > 0) {
          // 업데이트된 사용자 정보를 세션에 다시 저장
          session.setAttribute("user", user);
        }
      }
    %>

    <!-- 왼쪽 정렬된 정보 영역 -->
    <form action="mypage.jsp" method="post" id="userForm">
      <div class="container-left-align">
        <p>아이디 : <%= user.getId() %></p>
        <p>이름 :
          <span id="nameDisplay"><%= user.getName() %></span>
          <input type="text" id="nameEdit" name="name" value="<%= user.getName() %>" class="input-hidden" autocomplete="name">
        </p>
        <p>이메일 :
          <span id="emailDisplay"><%= user.getEmail() %></span>
          <input type="email" id="emailEdit" name="email" value="<%= user.getEmail() %>" class="input-hidden" autocomplete="email">
        </p>
      </div>
    </form>

    <!-- 버튼들을 폼 바깥으로 배치 -->
    <div class="button-container">
      <input type="button" id="editBtn" value="수정" class="btn" onclick="enableEdit()">
      <button type="button" id="saveBtn" class="btn hidden" onclick="submitForm()">저장</button>
      <a href="../html/index.html" class="btn">홈으로</a>
    </div>
  </div>
</div>
<script>
  function enableEdit() {
    document.getElementById('nameDisplay').style.display = 'none';
    document.getElementById('nameEdit').style.display = 'inline-block';

    document.getElementById('emailDisplay').style.display = 'none';
    document.getElementById('emailEdit').style.display = 'inline-block';

    document.getElementById('saveBtn').classList.remove('hidden');
    document.getElementById('editBtn').classList.add('hidden');
  }

  function submitForm() {
    document.getElementById('userForm').submit(); // 폼을 강제로 제출합니다.
  }
</script>
</body>
</html>
