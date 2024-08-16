package com.example.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/CreateProject/login.do")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // 폼 데이터 수집
        String userId = req.getParameter("userId");
        String password = req.getParameter("password");

        // 유효성 검사
        if (userId == null || password == null || userId.isEmpty() || password.isEmpty()) {
            req.setAttribute("error", "아이디와 비밀번호를 입력해야 합니다.");
            req.getRequestDispatcher("login.jsp").forward(req, res);
            return;
        }

        // UserDAO 객체 생성 및 사용자 인증
        UserDAO userDAO = new UserDAO();
        UserDTO user = userDAO.getUser(userId, password);

        if (user != null) {
            // 로그인 성공 시 세션에 사용자 정보 저장
            HttpSession session = req.getSession();
            session.setAttribute("user", user);

            // 로그인 성공 페이지로 리디렉션
            res.sendRedirect("loginSuccess.jsp");
        } else {
            // 로그인 실패 시 에러 메시지 표시
            req.setAttribute("error", "아이디 또는 비밀번호가 잘못되었습니다.");
            req.getRequestDispatcher("login.jsp").forward(req, res);
        }
    }
}
