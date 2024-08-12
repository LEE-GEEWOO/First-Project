<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>입장권 예매</title>
  <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
<div class="container reservation-container">
  <h1>입장권 예매</h1>
  <p>2024년 부산 해산물 마켓 입장권 예매창입니다.</p>
  <p>아래 내용을 기재해주시면, 연락처를 통해 입장권이 발송됩니다.</p>
  <p>그외 문의사항은 부산 해산물 마켓 고객센터를 이용해주세요.</p>

  <form action="/9999/reservation.do" method="post" class="reservation-form">
    <div class="form-group">
      <label>행사참여일</label>
      <div class="radio-group">
        <label>
          <input type="radio" name="attendDate" value="2024-08-23" required>
          8월 23일(금)
        </label>
        <label>
          <input type="radio" name="attendDate" value="2024-08-24">
          8월 24일(토)
        </label>
        <label>
          <input type="radio" name="attendDate" value="2024-08-25">
          8월 25일(일)
        </label>
      </div>
    </div>

    <div class="form-group">
      <label>성함:</label>
      <input type="text" name="id" placeholder="성함" required class="underline-input">
    </div>

    <div class="form-group">
      <label>연락처:</label>
      <input type="tel" name="tel" placeholder="연락처" required class="underline-input">
    </div>

    <div class="form-group">
      <input type="submit" value="신청하기">
    </div>
  </form>
</div>
</body>
</html>
