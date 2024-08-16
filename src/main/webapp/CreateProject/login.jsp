<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <script src="/js/scripts.js" defer></script>
</head>
<body>
<div class="container">
    <form action="/CreateProject/login.do" method="post" onsubmit="return validateForm(this)">
        <h2>로그인</h2>
        <div class="form-group">
            <input type="text" name="userId" placeholder="아이디" required>
        </div>

        <div class="form-group">
            <input type="password" name="password" placeholder="패스워드" required>
        </div>

        <div class="form-group">
            <input type="submit" value="로그인">
        </div>

        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
        <div class="error-message">
            <p><%= error %></p>
        </div>
        <%
            }
        %>

    </form>

    <div class="additional-info">
        <p>아직 회원가입을 하지 않았다면?</p>
        <a href="register.jsp" class="btn">회원가입하기</a>
    </div>
</div>
</body>
</html>
