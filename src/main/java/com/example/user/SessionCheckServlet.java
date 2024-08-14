package com.example.user;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/checkSession")
public class SessionCheckServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Map<String, Object> responseData = new HashMap<>();

        if (session != null) {
            UserDTO user = (UserDTO) session.getAttribute("user");
            if (user != null) {
                responseData.put("loggedIn", true);
                responseData.put("userName", user.getName());
            } else {
                responseData.put("loggedIn", false);
            }
        } else {
            responseData.put("loggedIn", false);
        }

        res.setContentType("application/json");
        ObjectMapper mapper = new ObjectMapper();
        mapper.writeValue(res.getWriter(), responseData);
    }
}
