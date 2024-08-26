<%@ page import="com.example.common1.CommunityDAO" %>
<%@ page import="com.example.common1.CommunityDTO" %>
<%@ page import="com.example.user.UserDTO" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    UserDTO user = (UserDTO) session.getAttribute("user");
    String userId = (user != null) ? user.getName() : "";
    int userType = (user != null) ? user.getType() : 0;

    int idx = Integer.parseInt(request.getParameter("idx"));
    String title = request.getParameter("title");
    String content = request.getParameter("content");

    CommunityDAO dao = new CommunityDAO();
    CommunityDTO dto = dao.getArticle(idx);

    if (dto == null || (!userId.equals(dto.getUserId()) && userType != 1)) {
        response.sendRedirect("community.jsp");
        return;
    }

    dto.setTitle(title);
    dto.setContent(content);

    int result = dao.updateArticle(dto, userId, userType);

    if (result > 0) {
        response.sendRedirect("commview.jsp?idx=" + idx);
    } else {
        out.println("<script>alert('게시글 수정에 실패했습니다.'); history.back();</script>");
    }
%>