<%@ page import="com.example.common1.BoardDAO" %>
<%@ page import="com.example.common1.BoardDTO" %>
<%@ page contentType="text/html; charset=UTF-8" %>
//11
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
    BoardDAO dao = null;
    BoardDTO dto = null;

    String userID = (String) session.getAttribute("userID");
    boolean isAdmin = (userID != null);

    int idx = 0;
    String pageNum = request.getParameter("pageNum");
    pageNum = (pageNum == null || pageNum.isEmpty()) ? "1" : pageNum;
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

        // 조회수 증가
        dao.incrementViews(idx);

        // 게시글 정보 가져오기
        dto = dao.getArticle(idx);

        if(dto == null) {
            out.println("<script>");
            out.println("alert('존재하지 않는 게시글입니다.');");
            out.println("location.href='List.jsp';");
            out.println("</script>");
            return;
        }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 보기</title>
    <link rel="stylesheet" type="text/css" href="<%=cp%>src/main/webapp/css/styles.css"/>
</head>
<body>
<div id="bbsView">
    <div id="bbsView_title">게시글 보기</div>
    <div id="bbsView_content">
        <div class="form-group">
            <label for="title">제목</label>
            <div id="title"><%= dto.getTitle() %></div>
        </div>
        <div class="form-group">
            <label for="content">내용</label>
            <div id="content"><%= dto.getContent() %></div>
        </div>
    </div>
    <div id="bbsView_footer">
        <input type="button" value="목록" class="btn" onclick="location.href='List.jsp?pageNum=<%=pageNum%>'"/>
        <% if (isAdmin) { %>
        <input type="button" value="수정" class="btn" onclick="location.href='Edit.jsp?idx=<%=idx%>&pageNum=<%=pageNum%>'"/>
        <form action="DeleteAction.jsp" method="post" style="display:inline;" onsubmit="return confirm('정말로 이 게시글을 삭제하시겠습니까?');">
            <input type="hidden" name="idx" value="<%=idx%>"/>
            <input type="hidden" name="pageNum" value="<%=pageNum%>"/>
            <input type="submit" value="삭제" class="btn"/>
        </form>
        <% } %>
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
