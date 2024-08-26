package com.example.user;

import com.example.common.DBConnPool;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO extends DBConnPool {

    public UserDAO() {
        super(); // DBConnPool의 생성자 호출하여 DB 연결을 설정
    }

    // 사용자 추가 메서드
    public int addUser(UserDTO user) {
        int result = 0;
        String query = "INSERT INTO SCOTT.USERS (ID, PWD, NAME, EMAIL, type) VALUES (?, ?, ?, ?, ?)";

        try {
            // PreparedStatement 객체 생성
            PreparedStatement psmt = conn.prepareStatement(query);
            psmt.setString(1, user.getId());
            psmt.setString(2, user.getPwd());
            psmt.setString(3, user.getName());
            psmt.setString(4, user.getEmail());
            psmt.setInt(5, user.getType());  // type 값 설정 (2: 일반 회원)

            // 쿼리 실행
            result = psmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("회원가입 오류 발생");
        } finally {
            close(); // 연결 종료
        }
        return result;
    }

    // 사용자 인증 메서드
    public UserDTO getUser(String userId, String password) {
        UserDTO user = null;
        String query = "SELECT * FROM SCOTT.USERS WHERE ID = ? AND PWD = ?";

        try {
            psmt = conn.prepareStatement(query);
            psmt.setString(1, userId);
            psmt.setString(2, password);

            rs = psmt.executeQuery();

            if (rs.next()) {
                user = new UserDTO();
                user.setId(rs.getString("ID"));
                user.setPwd(rs.getString("PWD"));
                user.setName(rs.getString("NAME"));
                user.setEmail(rs.getString("EMAIL"));
                user.setType(rs.getInt("type"));  // type 값도 가져옴
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("로그인 오류 발생");
        } finally {
            close(); // 자원 반납
        }

        return user;
    }

    // ID 중복 검사
    public boolean checkIdExists(String id) {
        boolean exists = false;
        String query = "SELECT COUNT(*) FROM SCOTT.USERS WHERE ID = ?";

        try {
            PreparedStatement psmt = conn.prepareStatement(query);
            psmt.setString(1, id);

            ResultSet rs = psmt.executeQuery();
            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("ID 중복 검사 오류 발생");
        } finally {
            close(); // 자원 반납
        }

        return exists;
    }

    // 이메일 중복 검사
    public boolean checkEmailExists(String email) {
        boolean exists = false;
        String query = "SELECT COUNT(*) FROM SCOTT.USERS WHERE EMAIL = ?";

        try {
            PreparedStatement psmt = conn.prepareStatement(query);
            psmt.setString(1, email);

            ResultSet rs = psmt.executeQuery();
            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("이메일 중복 검사 오류 발생");
        } finally {
            close(); // 자원 반납
        }

        return exists;
    }
    public int updateUser(UserDTO user) {
        int result = 0;
        String query = "UPDATE USERS SET NAME = ?, EMAIL = ? WHERE ID = ?";

        try {
            PreparedStatement psmt = conn.prepareStatement(query);
            psmt.setString(1, user.getName());
            psmt.setString(2, user.getEmail());
            psmt.setString(3, user.getId());

            result = psmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("정보 수정 오류 발생");
        } finally {
            close();
        }

        return result;
    }

}