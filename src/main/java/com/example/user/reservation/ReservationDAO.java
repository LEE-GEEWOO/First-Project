package com.example.user.reservation;

import com.example.common.DBConnPool;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ReservationDAO extends DBConnPool {

    public ReservationDAO() {
        super(); // DBConnPool의 생성자 호출하여 DB 연결을 설정
    }

    // 예약 추가 메서드
    public int addReservation(ReservationDTO reservation) {
        int result = 0;
        String query = "INSERT INTO SCOTT.ATTENDLIST (IDX, ID, TEL, ATTEND_DATE) VALUES (SCOTT.SEQ_ATTENDLIST.NEXTVAL, ?, ?, ?)";

        try {
            PreparedStatement psmt = conn.prepareStatement(query);
            psmt.setString(1, reservation.getId());
            psmt.setString(2, reservation.getTel());
            psmt.setDate(3, reservation.getAttendDate());

            // 쿼리 실행
            result = psmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("예약 오류 발생");
        } finally {
            close(); // 연결 종료
        }
        return result;
    }
}