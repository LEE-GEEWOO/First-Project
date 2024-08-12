<%@ page import="com.example.common1.BoardDAO" %>
<%@ page import="com.example.common1.BoardDTO" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
    BoardDAO dao = null;
    BoardDTO dto = null;

    int idx = 0;
    String pageNum = request.getParameter("pageNum");
    String idxParam = request.getParameter("idx");

    if (idxParam != null && !idxParam.isEmpty()) {
        try {
            idx = Integer.parseInt(idxParam);
        } catch (NumberFormatException e) {
            out.println("<script>");
            out.println("alert('유효하지 않은 게시글 번호입니다.');");
            out.println("history.back();");
            out.println("</script>");
            return;
        }
    } else {
        out.println("<script>");
        out.println("alert('게시글 번호가 지정되지 않았습니다.');");
        out.println("history.back();");
        out.println("</script>");
        return;
    }

    try {
        dao = new BoardDAO();
        dto = dao.getArticle(idx);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 보기</title>
    <link rel="stylesheet" type="text/css" href="<%=cp%>/CreateProject/css/styles.css"/>
</head>
<body>
<div id="bbsView">
    <div id="bbsView_title">게시글 보기</div>
    <div id="bbsView_content">
        <div class="form-group">
            <label for="title">제목</label>
            <div id="title"><%= dto != null ? dto.getTitle() : "제목 없음" %></div>
        </div>
        <div class="form-group">
            <label for="content">내용</label>
            <div id="content"><%= dto != null ? dto.getContent() : "내용 없음" %></div>
        </div>
    </div>
    <div id="bbsView_footer">
        <input type="button" value="목록" class="btn" onclick="location.href='List.jsp?pageNum=<%=pageNum%>'"/>
        <input type="button" value="수정" class="btn" onclick="location.href='Edit.jsp?idx=<%=idx%>&pageNum=<%=pageNum%>'"/>
        <form action="Delete.jsp" method="get" style="display:inline;">
            <input type="hidden" name="idx" value="<%=idx%>"/>
            <input type="hidden" name="pageNum" value="<%=pageNum%>"/>
            <input type="submit" value="삭제" class="btn"/>
        </form>
    </div>
</div>
</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>");
        out.println("alert('게시글을 불러오는 중 오류가 발생했습니다.');");
        out.println("history.back();");
        out.println("</script>");
    } finally {
        if (dao != null) {
            dao.close();
        }
    }
%>
