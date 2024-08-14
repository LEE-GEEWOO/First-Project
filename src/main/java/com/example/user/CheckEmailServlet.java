package com.example.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/CreateProject/checkEmail.do")
public class CheckEmailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String email = req.getParameter("email");
        UserDAO userDAO = new UserDAO();
        boolean exists = userDAO.checkEmailExists(email);

        res.setContentType("application/json");
        res.getWriter().write("{ \"exists\": " + exists + " }");
    }
}
