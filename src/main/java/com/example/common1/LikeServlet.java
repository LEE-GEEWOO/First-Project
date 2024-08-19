package com.example.common1;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/like.do")
public class LikeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            int idx = Integer.parseInt(request.getParameter("idx"));
            boolean isLiked = Boolean.parseBoolean(request.getParameter("isLiked"));
            CommunityDAO dao = new CommunityDAO();

            boolean success;
            if (isLiked) {
                // 좋아요를 취소할 경우, 좋아요 수 감소
                success = dao.decrementLikes(idx);
            } else {
                // 좋아요를 추가할 경우, 좋아요 수 증가
                success = dao.incrementLikes(idx);
            }

            // 현재 좋아요 수 가져오기
            int newLikeCount = dao.getLikes(idx);

            // JSON 응답 작성
            out.print("{\"success\":" + success + ", \"newLikeCount\":" + newLikeCount + "}");
        } catch (NumberFormatException e) {
            // 인덱스 파라미터가 잘못된 경우 처리
            e.printStackTrace();
            out.print("{\"success\":false, \"message\":\"Invalid index format\"}");
        } catch (Exception e) {
            // 기타 예외 처리
            e.printStackTrace();
            out.print("{\"success\":false, \"message\":\"Error occurred\"}");
        } finally {
            out.flush();
            out.close();
        }
    }
}
