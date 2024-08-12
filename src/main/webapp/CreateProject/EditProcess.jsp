<%@ page import="com.example.common1.BoardDTO" %>
<%@ page import="com.example.common1.BoardDAO" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.common.DBConnPool1" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
    int idx = Integer.parseInt(request.getParameter("idx"));
    String title = request.getParameter("title");
    String content = request.getParameter("content");

    Connection conn = null;
    BoardDAO dao = null;
    BoardDTO dto = new BoardDTO();

    try {
        conn = DBConnPool1.getConnection();
        dao = new BoardDAO();

        // 공지 DTO 설정
        dto.setIdx(idx);
        dto.setTitle(title);
        dto.setContent(content);

        // 공지 수정
        dao.updateArticle(dto);  // updateArticle 메소드는 BoardDAO에 새로 추가해야 합니다

        // 성공 시 해당 게시글 페이지로 리다이렉트
        response.sendRedirect("Article.jsp?idx=" + idx);

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>");
        out.println("alert('게시글 수정 중 오류가 발생했습니다.');");
        out.println("history.back();");
        out.println("</script>");
    } finally {
        try {
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>