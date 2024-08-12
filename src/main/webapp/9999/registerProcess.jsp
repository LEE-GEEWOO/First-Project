<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 데이터베이스 연결
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        Class.forName("oracle.jdbc.OracleDriver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC", "root", "password");

        // 입력된 회원 정보를 가져옴
        String id = request.getParameter("id");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        // 아이디 중복 검사
        String sql = "SELECT COUNT(*) FROM user WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        ResultSet rs = pstmt.executeQuery();
        rs.next();
        int count = rs.getInt(1);
        rs.close();
        pstmt.close();
        if (count > 0) { // 이미 존재하는 아이디인 경우
            out.print("<p>이미 존재하는 아이디입니다.</p>");
        } else { // 새로운 아이디인 경우
            // 회원 정보를 데이터베이스에 저장
            sql = "INSERT INTO user (id, password, name, email) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, password);
            pstmt.setString(3, name);
            pstmt.setString(4, email);
            pstmt.executeUpdate();
            pstmt.close();
            out.print("<p>회원가입이 완료되었습니다.</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // 자원 해제
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
        if (conn != null) try { conn.close(); } catch (SQLException ex) {}
    }
%>