package com.example.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/CreateProject/checkId.do")
public class CheckIdServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String id = req.getParameter("id");
        UserDAO userDAO = new UserDAO();
        boolean exists = userDAO.checkIdExists(id);

        res.setContentType("application/json");
        res.getWriter().write("{ \"exists\": " + exists + " }");
    }
}
