<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>새 글 작성</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
<h1>새 글 작성</h1>
<form action="write.do" method="post">
  <label for="title">제목</label>
  <input type="text" id="title" name="title" required />
  <label for="content">내용</label>
  <textarea id="content" name="content" rows="10" required></textarea>
  <input type="hidden" name="authorName" value="<%= session.getAttribute("userName") %>" />
  <input type="hidden" name="userId" value="<%= session.getAttribute("userId") %>" />
  <input type="hidden" name="type" value="2" /> <!-- 기본 타입 -->
  <button type="submit">작성</button>
</form>
<a href="community.jsp">목록으로 돌아가기</a>
</body>
</html>
