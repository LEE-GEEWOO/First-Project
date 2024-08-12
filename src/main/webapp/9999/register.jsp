<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <script src="/js/scripts.js" defer></script>
    <style>
        .error-message {
            color: red;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
<form action="/9999/register.do" method="post" onsubmit="return validateForm(this)">
    <h2>회원가입</h2>

    <!-- 오류 메시지 출력 -->
    <c:if test="${not empty error}">
        <div style="color: red;">
                ${error}
        </div>
    </c:if>

    <div class="form-group">
        <input type="text" id="id" name="id" placeholder="아이디" required oninput="checkId(this)">
        <div id="id-error" class="error-message"></div>
    </div>

    <div class="form-group">
        <input type="password" id="pwd" name="pwd" placeholder="비밀번호" required minlength="8" maxlength="20"
               pattern="(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,20}"
               title="비밀번호는 8~20자이며 대소문자, 숫자, 특수문자를 포함해야 합니다." oninput="checkPwd(this)">
        <div id="pwd-error" class="error-message"></div>
    </div>

    <div class="form-group">
        <input type="text" id="name" name="name" placeholder="이름" required oninput="checkName(this)">
        <div id="name-error" class="error-message"></div>
    </div>

    <div class="form-group">
        <input type="email" id="email" name="email" placeholder="이메일" required oninput="checkEmail(this)">
        <div id="email-error" class="error-message"></div>
    </div>

    <div class="form-group">
        <input type="submit" value="회원가입">
    </div>
</form>
</body>
</html>
