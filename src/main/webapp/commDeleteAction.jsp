<%@ page import="com.example.common1.CommunityDAO" %>
<%@ page import="com.example.common1.CommunityDTO" %>
<%@ page import="com.example.user.UserDTO" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    UserDTO user = (UserDTO) session.getAttribute("user");
    String userId = (user != null) ? user.getUserId() : "";
    int userType = (user != null) ? user.getType() : 0;

    int idx = Integer.parseInt(request.getParameter("idx"));

    CommunityDAO dao = new CommunityDAO();
    CommunityDTO dto = dao.getArticle(idx);

    if (dto == null || (!userId.equals(dto.getUserId()) && userType != 1)) {
        response.sendRedirect("community.jsp");
        return;
    }

    int result = dao.delete(idx, userId, userType);

    if (result > 0) {
        response.sendRedirect("community.jsp");
    } else {
        out.println("<script>alert('게시글 삭제에 실패했습니다.'); history.back();</script>");
    }
%>
