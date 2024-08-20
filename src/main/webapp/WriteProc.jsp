<%@ page import="com.example.common1.CommunityDAO" %>
<%@ page import="com.example.common1.CommunityDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    request.setCharacterEncoding("UTF-8");
    String title = request.getParameter("title");
    String content = request.getParameter("content");

    CommunityDAO dao = null;

    try {
        dao = new CommunityDAO();
        int newArticleId = dao.insertArticle(title, content);
        response.sendRedirect("community.jsp?idx=" + newArticleId);
    } catch (RuntimeException e) {
        e.printStackTrace();
        out.println("<script>alert('게시글 작성 중 오류가 발생했습니다: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        if (dao != null) dao.close();
    }
%>