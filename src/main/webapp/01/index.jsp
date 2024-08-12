<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.CommunityDAO" %>
<%@ page import="com.example.CommunityDTO" %>
<%
    CommunityDAO dao = new CommunityDAO();
    List<CommunityDTO> posts = dao.getAllPosts();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>커뮤니티 게시판</title>
</head>
<body>
<h1>커뮤니티 게시판</h1>
<a href="createPost.jsp">새 게시물 작성</a>
<table border="1">
    <tr>
        <th>제목</th>
        <th>날짜</th>
        <th>조회수</th>
        <th>좋아요</th>
        <th>유형</th>
    </tr>
    <%
        for (CommunityDTO post : posts) {
    %>
    <tr>
        <td><%= post.getTitle() %></td>
        <td><%= post.getPostDate() %></td>
        <td><%= post.getViews() %></td>
        <td><%= post.getLikes() %></td>
        <td><%= post.getType() %></td>
    </tr>
    <%
        }
    %>
</table>
</body>
</html>
