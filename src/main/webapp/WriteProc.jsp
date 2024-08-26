<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.common1.CommunityDAO" %>
<%@ page import="com.example.common1.CommunityDTO" %>
<%@ page import="com.example.common.DBConnPool2" %>
<%@ page import="org.apache.commons.text.StringEscapeUtils" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
    String title = StringEscapeUtils.escapeHtml4(request.getParameter("title"));
    String content = StringEscapeUtils.escapeHtml4(request.getParameter("content"));

    Connection conn = null;
    CommunityDAO dao = null;
    CommunityDTO dto = new CommunityDTO();

    try {
        conn = DBConnPool2.getConnection();
        dao = new CommunityDAO();

        // 공지 DTO 설정
        dto.setTitle(title);
        dto.setContent(content);

        // 세션에서 userId 가져오기
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            throw new Exception("로그인이 필요합니다.");
        }

        dto.setUserId(userId);
        dto.setAuthorName((String) session.getAttribute("userName"));
        dto.setType(2); // 기본 타입 설정

        // 게시글 삽입 호출
        int articleId = dao.insertArticle(dto);

        // 성공 시 목록 페이지로 리다이렉트
        response.sendRedirect("community.jsp");

    } catch (Exception e) {
        // 로그에 에러 기록
        e.printStackTrace();

        // 사용자에게 일반적인 에러 메시지 표시
        out.println("<script>");
        out.println("alert('게시글 작성 중 오류가 발생했습니다. 다시 시도해 주세요.');");
        out.println("history.back();");
        out.println("</script>");
    } finally {
        // Connection 닫기
        if (dao != null) {
            dao.close();  // CommunityDAO에 close 메서드가 있다고 가정
        }
    }
%>
