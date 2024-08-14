<%@ page import="com.example.common1.BoardDTO" %>
<%@ page import="com.example.common1.BoardDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
//11
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();

    // 글 번호 파라미터 받기
    String idxParam = request.getParameter("idx");
    int idx = 0;
    BoardDTO dto = null;

    if (idxParam != null && !idxParam.isEmpty()) {
        try {
            idx = Integer.parseInt(idxParam);
            BoardDAO dao = new BoardDAO();
            dto = dao.getArticle(idx);
            dao.close(); // 자원 정리
            if (dto == null) {
                out.println("<script>alert('해당 글을 찾을 수 없습니다.'); history.back();</script>");
                return;
            }
        } catch (NumberFormatException e) {
            out.println("<script>alert('유효하지 않은 ID입니다.'); history.back();</script>");
            return;
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('오류가 발생했습니다.'); history.back();</script>");
            return;
        }
    } else {
        out.println("<script>alert('글 번호가 지정되지 않았습니다.'); history.back();</script>");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 수정</title>
    <link rel="stylesheet" type="text/css" href="<%=cp%>/CreateProject/css/styles.css"/>
</head>
<body>
<div id="bbs">
    <div id="bbs_title">
        공지사항 수정
    </div>
    <form action="EditProcess.jsp" method="post">
        <input type="hidden" name="idx" value="<%= dto.getIdx() %>">
        <div id="bbsCreated">
            <div class="bbsCreated_bottomLine">
                <dl>
                    <dt>제&nbsp;&nbsp;&nbsp;&nbsp;목</dt>
                    <dd>
                        <input type="text" name="title" size="60"
                               maxlength="100" class="boxTF"
                               value="<%= dto.getTitle() %>"/>
                    </dd>
                </dl>
            </div>
            <div id="bbsCreated_content">
                <dl>
                    <dt>내&nbsp;&nbsp;&nbsp;&nbsp;용</dt>
                    <dd>
                        <textarea name="content" cols="63" rows="12"
                                  class="boxTA"><%= dto.getContent() %></textarea>
                    </dd>
                </dl>
            </div>
        </div>
        <div id="bbsCreated_footer">
            <input type="button" value="취소" class="btn2"
                   onclick="javascript:location.href='<%=cp%>/CreateProject/Article.jsp?idx=<%= dto.getIdx() %>'"/>
            <input type="submit" value="수정완료" class="btn2"/>
        </div>
    </form>
</div>
</body>
</html>
