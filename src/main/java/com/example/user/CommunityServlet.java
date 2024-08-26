package com.example.user;

import com.example.common1.CommunityDAO;
import com.example.common1.CommunityDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/Delete.do")
public class CommunityServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 로그인 사용자 정보 가져오기
        UserDTO user = (UserDTO) request.getSession().getAttribute("user");
        String userName = (user != null) ? user.getName() : "";
        Integer userType = (user != null) ? user.getType() : 0;

        String idxParam = request.getParameter("idx");
        String pageNum = request.getParameter("pageNum");

        if (idxParam == null || idxParam.isEmpty()) {
            response.sendRedirect("List.jsp");
            return;
        }

        int boardId;
        try {
            boardId = Integer.parseInt(idxParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("List.jsp");
            return;
        }

        CommunityDAO dao = new CommunityDAO();
        CommunityDTO board = dao.getArticle(boardId);

        if (board == null) {
            response.sendRedirect("List.jsp");
            return;
        }

        boolean isAuthor = userName.equals(board.getUserId());
        boolean isAdmin = (userType != null && userType == 1);

        if (!isAuthor && !isAdmin) {
            response.sendRedirect("List.jsp");
            return;
        }

        if ("delete".equals(request.getParameter("action"))) {
            int result = dao.delete(boardId, userName, userType);
            if (result > 0) {
                response.sendRedirect("List.jsp?pageNum=" + (pageNum != null ? pageNum : "1"));
            } else {
                response.sendRedirect("List.jsp");
            }
        } else if ("update".equals(request.getParameter("action"))) {
            CommunityDTO updatedBoard = new CommunityDTO();
            updatedBoard.setIdx(boardId);
            updatedBoard.setTitle(request.getParameter("title"));
            updatedBoard.setContent(request.getParameter("content"));
            updatedBoard.setAuthor(userName);
            updatedBoard.setUserId(userName);
            updatedBoard.setType(board.getType());

            int result = dao.updateArticle(updatedBoard, userName, userType);
            if (result > 0) {
                response.sendRedirect("View.jsp?idx=" + boardId + "&pageNum=" + (pageNum != null ? pageNum : "1"));
            } else {
                response.sendRedirect("List.jsp");
            }
        } else {
            response.sendRedirect("List.jsp");
        }

        dao.close();
    }
}
