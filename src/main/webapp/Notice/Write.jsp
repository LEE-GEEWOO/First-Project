<%@page import="java.sql.Connection"%>
<%@page import="com.example.common.DBConnPool1"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
    Connection conn = null;
    try {
        conn = DBConnPool1.getConnection();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>글쓰기</title>
    <link rel="stylesheet" type="text" href="<%=request.getContextPath()%>/CreateProject/css/styles.css/">
</head>
<body>
<div id="WriteForm">
    <form action="WriteProc.jsp" method="post">
        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" id="title" name="title" required/>
        </div>
        <div class="form-group">
            <label for="content">내용</label>
            <textarea id="content" name="content" rows="10" required></textarea>
        </div>
        <div class="form-group">
            <input type="submit" value="저장" class="btn"/>
            <input type="button" value="목록" class="btn" onclick="location.href='List.jsp'"/>
        </div>
    </form>
</div>
</body>
</html>
