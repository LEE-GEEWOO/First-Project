<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.common1.BoardDAO" %>
<%@ page import="com.example.common1.BoardDTO" %>
<%@ page import="com.example.common.DBConnPool1" %>
//11
<%
    request.setCharacterEncoding("UTF-8");
    String title = request.getParameter("title");
    String content = request.getParameter("content");

    Connection conn = null;
    BoardDAO dao = null;
    BoardDTO dto = new BoardDTO();

    try {
        conn = DBConnPool1.getConnection();
        dao = new BoardDAO();

        // 공지 DTO 설정
        dto.setTitle(title);
        dto.setContent(content);

        // 공지 삽입
        dao.insertArticle(dto);

        // 성공 시 목록 페이지로 리다이렉트
        response.sendRedirect("List.jsp");

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>");
        out.println("alert('게시글 작성 중 오류가 발생했습니다.');");
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
