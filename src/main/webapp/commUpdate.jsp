<%@ page import="com.example.common1.CommunityDAO" %>
<%@ page import="com.example.common1.CommunityDTO" %>
<%@ page import="com.example.user.UserDTO" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
  UserDTO user = (UserDTO) session.getAttribute("user");
  String userId = (user != null) ? user.getName() : "";
  int userType = (user != null) ? user.getType() : 0;

  int idx = Integer.parseInt(request.getParameter("idx"));
  CommunityDAO dao = new CommunityDAO();
  CommunityDTO dto = dao.getArticle(idx);

  if (dto == null || (!userId.equals(dto.getUserId()) && userType != 1)) {
    response.sendRedirect("community.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <title>게시글 수정</title>
  <!-- Bootstrap CSS -->
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <h2>게시글 수정</h2>
  <form action="commUpdateAction.jsp" method="post">
    <input type="hidden" name="idx" value="<%= idx %>">
    <div class="form-group">
      <label for="title">제목</label>
      <input type="text" class="form-control" id="title" name="title" value="<%= dto.getTitle() %>" required>
    </div>
    <div class="form-group">
      <label for="content">내용</label>
      <textarea class="form-control" id="content" name="content" rows="5" required><%= dto.getContent() %></textarea>
    </div>
    <button type="submit" class="btn btn-primary">수정</button>
    <a href="commview.jsp?idx=<%= idx %>" class="btn btn-secondary">취소</a>
  </form>
</div>
</body>
</html>