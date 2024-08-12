package com.example.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/9999/register.do")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // 폼 데이터 수집
        String id = req.getParameter("id");
        String pwd = req.getParameter("pwd");
        String name = req.getParameter("name");
        String email = req.getParameter("email");

        // 유효성 검사
        if (id == null || id.isEmpty()) {
            req.setAttribute("error", "아이디를 입력하세요");
            req.getRequestDispatcher("register.jsp").forward(req, res);
            return;
        }

        if (pwd == null || pwd.isEmpty()) {
            req.setAttribute("error", "비밀번호를 입력하세요");
            req.getRequestDispatcher("register.jsp").forward(req, res);
            return;
        } else if (!pwd.matches("(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*])[A-Za-z\\d!@#$%^&*]{8,20}")) {
            req.setAttribute("error", "비밀번호는 8~20자이며 대소문자, 숫자, 특수문자를 포함해야 합니다.");
            req.getRequestDispatcher("register.jsp").forward(req, res);
            return;
        }

        if (name == null || name.isEmpty()) {
            req.setAttribute("error", "이름을 입력하세요");
            req.getRequestDispatcher("register.jsp").forward(req, res);
            return;
        }

        if (email == null || email.isEmpty()) {
            req.setAttribute("error", "이메일을 입력하세요");
            req.getRequestDispatcher("register.jsp").forward(req, res);
            return;
        }

        // UserDTO 객체 생성
        UserDTO user = new UserDTO(id, pwd, name, email);

        // DAO 객체를 통해 DB에 사용자 정보 저장
        UserDAO userDAO = new UserDAO();
        int result = 0;
        try {
            result = userDAO.addUser(user);
        } catch (Exception e) {
            e.printStackTrace(); // 로그 파일에 기록
            req.setAttribute("error", "회원가입 처리 중 오류가 발생했습니다.");
            req.getRequestDispatcher("register.jsp").forward(req, res);
            return;
        }

        // 결과에 따라 페이지 리디렉션 또는 포워드
        if (result > 0) {
            res.sendRedirect("success.jsp"); // 성공 페이지로 리디렉션
        } else {
            req.setAttribute("error", "회원가입에 실패했습니다. 중복된 아이디나 이메일이 있을 수 있습니다.");
            req.getRequestDispatcher("register.jsp").forward(req, res);
        }
    }
}
