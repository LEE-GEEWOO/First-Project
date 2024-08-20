<%@ page import="com.example.common1.BoardDTO" %>
<%@ page import="com.example.common1.BoardDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();

    String idParam = request.getParameter("idx");
    boolean isEditMode = (idParam != null && !idParam.isEmpty());

    BoardDTO dto = null;
    if (isEditMode) {
        BoardDAO dao = new BoardDAO();
        try {
            int idx = Integer.parseInt(idParam);
            dto = dao.getArticle(idx);
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
        } finally {
            dao.close(); // 자원 정리
        }
    }
%>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title><%= isEditMode ? "공지사항 수정" : "공지사항 작성" %>
    </title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" type="text/css" href="<%=cp%>../css/Write.css"/>
</head>
<body>
<div id="bbs">
    <div id="bbs_title">
        <%= isEditMode ? "공지사항 수정" : "공지사항 작성" %>
    </div>
    <form action="<%= isEditMode ? "EditProcess.jsp" : "/CreateProject/WriteProc.jsp" %>" method="post">
        <% if (isEditMode) { %>
        <input type="hidden" name="id" value="<%= dto.getIdx() %>">
        <% } %>
        <div id="bbsCreated">
            <div class="bbsCreated_bottomLine">
                <dl>
                    <dt>제&nbsp;&nbsp;&nbsp;&nbsp;목</dt>
                    <dd>
                        <input type="text" name="title" size="60" maxlength="100" class="boxTF"
                               value="<%= isEditMode ? dto.getTitle() : "" %>"/>
                    </dd>
                </dl>
            </div>
            <div id="bbsCreated_content">
                <dl>
                    <dt>내&nbsp;&nbsp;&nbsp;&nbsp;용</dt>
                    <dd>
                        <textarea name="content" class="boxTA"><%= isEditMode ? dto.getContent() : "" %></textarea>
                    </dd>
                </dl>
            </div>
        </div>
        <div id="bbsCreated_footer">
            <input type="button" value="목록으로" class="btn2"
                   onclick="javascript:location.href='<%=cp%>/CreateProject/List.jsp'"/>
            <input type="reset" value="다시 입력" class="btn3"/>
            <input type="submit" value="<%= isEditMode ? "수정하기" : "저장" %>" class="btn4"/>
        </div>
    </form>
</div>
</body>
</html>
