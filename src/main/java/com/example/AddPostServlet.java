package com.example;

import java.io.IOException;

import com.example.common1.CommunityDAO;
import com.example.common1.CommunityDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/addPostServlet")
public class AddPostServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String author = request.getParameter("author");
        String userId = request.getParameter("userId");
        int type = Integer.parseInt(request.getParameter("type")); // 적절한 타입으로 변환

        CommunityDTO dto = new CommunityDTO();
        dto.setTitle(title);
        dto.setContent(content);
        dto.setAuthor(author);
        dto.setUserId(userId);
        dto.setType(type);

        try (CommunityDAO dao = new CommunityDAO()) {
            int generatedId = dao.insertArticle(dto);
            response.sendRedirect("viewPost.jsp?idx=" + generatedId);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "게시물 저장에 실패했습니다.");
        }
    }
}
