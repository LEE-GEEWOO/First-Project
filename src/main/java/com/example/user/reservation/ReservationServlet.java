package com.example.user.reservation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/CreateProject/reservation.do")
public class ReservationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // 폼 데이터 수집
        String id = req.getParameter("id");
        String tel = req.getParameter("tel");
        String attendDateStr = req.getParameter("attendDate");

        // ReservationDTO 객체 생성
        ReservationDTO reservation = new ReservationDTO(id, tel, java.sql.Date.valueOf(attendDateStr));

        // ReservationDAO 객체를 통해 DB에 예약 정보 저장
        ReservationDAO reservationDAO = new ReservationDAO();
        int result = 0;
        try {
            result = reservationDAO.addReservation(reservation);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "예약 처리 중 오류가 발생했습니다.");
            req.getRequestDispatcher("reservation.jsp").forward(req, res);
            return;
        }

        // 결과에 따라 페이지 리디렉션 또는 포워드
        if (result > 0) {
            res.sendRedirect("resSuccess.jsp"); // 성공 페이지로 리디렉션
        } else {
            req.setAttribute("error", "예약에 실패했습니다. 다시 시도해 주세요.");
            req.getRequestDispatcher("reservation.jsp").forward(req, res);
        }
    }
}