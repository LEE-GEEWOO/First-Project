package com.example.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/CreateProject/logout.do")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // 세션 무효화
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // 로그아웃 후 리다이렉트
        res.sendRedirect("../html/index.html");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // doGet을 호출
        doGet(req, res);
    }
}
