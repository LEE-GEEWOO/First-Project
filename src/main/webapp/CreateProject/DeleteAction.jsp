<%@ page import="com.example.common1.BoardDAO" %>
<%@ page import="com.example.common1.BoardDTO" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="adminCheck.jsp" %>
//11
<%
    request.setCharacterEncoding("UTF-8");

    // 관리자 로그인 확인
    String userID = (String) session.getAttribute("userID");
    if (userID == null) {
        out.println("<script>");
        out.println("alert('관리자 로그인이 필요합니다.');");
        out.println("location.href='../9999/login.jsp';");
        out.println("</script>");
        return;
    }

    BoardDAO dao = null;
    try {
        // 글 번호 및 페이지 번호 파라미터 받기
        String idxParam = request.getParameter("idx");
        String pageNum = request.getParameter("pageNum");

        if (idxParam == null || idxParam.isEmpty()) {
            throw new IllegalArgumentException("게시글 번호가 지정되지 않았습니다.");
        }

        int boardId;
        try {
            boardId = Integer.parseInt(idxParam);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("유효하지 않은 게시글 번호입니다.");
        }

        dao = new BoardDAO();
        BoardDTO board = dao.getArticle(boardId);

        if (board == null) {
            out.println("<script>");
            out.println("alert('존재하지 않는 게시글입니다.');");
            out.println("location.href='List.jsp?pageNum=" + (pageNum != null ? pageNum : "1") + "';");
            out.println("</script>");
            return;
        }

        // 게시글 삭제
        int result = dao.delete(boardId, board.getType());
        if (result > 0) {
            out.println("<script>");
            out.println("alert('게시글이 성공적으로 삭제되었습니다.');");
            out.println("location.href='List.jsp?pageNum=" + (pageNum != null ? pageNum : "1") + "';");
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println("alert('게시글 삭제에 실패하였습니다.');");
            out.println("history.back();");
            out.println("</script>");
        }
    } catch (IllegalArgumentException e) {
        out.println("<script>");
        out.println("alert('" + e.getMessage() + "');");
        out.println("location.href='List.jsp';");
        out.println("</script>");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>");
        out.println("alert('오류가 발생하였습니다: " + e.getMessage() + "');");
        out.println("location.href='List.jsp';");
        out.println("</script>");
    } finally {
        if (dao != null) {
            dao.close();
        }
    }
%>
<%
    // 관리자 권한 확인
    Integer userType = (Integer) session.getAttribute("userType");
    if (userType == null || userType != 1) {
        out.println("<script>alert('관리자만 삭제할 수 있습니다.'); location.href='List.jsp';</script>");
        return;
    }
%>