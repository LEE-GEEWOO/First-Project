<%@ page import="com.example.common1.BoardDAO" %>
<%@ page import="com.example.common1.BoardDTO" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
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
        int boardId = Integer.parseInt(request.getParameter("idx"));
        String pageNum = request.getParameter("pageNum");
        dao = new BoardDAO();
        BoardDTO board = dao.getArticle(boardId);

        if (board == null) {
            out.println("<script>");
            out.println("alert('유효하지 않은 글입니다.');");
            out.println("location.href='List.jsp?pageNum=" + pageNum + "';");
            out.println("</script>");
            return;
        }

        int result = dao.delete(boardId);
        if (result > 0) {
            out.println("<script>");
            out.println("alert('글이 성공적으로 삭제되었습니다.');");
            out.println("location.href='List.jsp?pageNum=" + pageNum + "';");
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println("alert('글 삭제에 실패하였습니다.');");
            out.println("history.back();");
            out.println("</script>");
        }
    } catch (NumberFormatException e) {
        out.println("<script>");
        out.println("alert('잘못된 접근입니다.');");
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