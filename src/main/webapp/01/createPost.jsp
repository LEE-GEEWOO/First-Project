<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>새 게시물 작성</title>
</head>
<body>
<h1>새 게시물 작성</h1>
<form action="addPostServlet" method="post">
    제목: <input type="text" name="title" required /><br/>
    <input type="submit" value="저장" />
</form>
<a href="index.jsp">게시판으로 돌아가기</a>
</body>
</html>
