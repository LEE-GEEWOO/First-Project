package com.example.common;

import jakarta.servlet.ServletContext;

import java.sql.*;

public class JDBCConnect {

    //데이터베이스와 연결을 담당
    public Connection conn;
    //파라미터가 없는 정적 쿼리를 실행할 때 사용
    public Statement stmt;
    //파라미터가 없는 동적 쿼리를 실행할 때 사용
    public PreparedStatement psmt;
    //쿼리문 결과를 저장할 때 사용
    public ResultSet rs;


    public JDBCConnect() {
       //기본 생성자
        try {

            //JDBC 드라이버 로드
            Class.forName("oracle.jdbc.driver.OracleDriver");

            //DB 연결
            String url = "jdbc:oracle:thin:@localhost:1521:xe";  // 자신의 IP 127.0.0.1
            String id = "scott";
            String pass = "tiger";

            conn = DriverManager.getConnection(url, id, pass);
            System.out.println("DB 연결 성공(기본생성자)");

        }catch (Exception e) {
            e.printStackTrace();
        }
    }

    public JDBCConnect(String driver, String url, String id, String pwd) {
        try {
            Class.forName(driver);

            //DB 연결
            conn = DriverManager.getConnection(url, id, pwd);

            System.out.println("DB 연결 성공 (파라미터 생성자)");
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public JDBCConnect(ServletContext application){

        try {

            String driver = application.getInitParameter("OracleDriver");
            Class.forName(driver);
            String url = application.getInitParameter("OracleURL");
            String id = application.getInitParameter("OracleId");
            String pwd = application.getInitParameter("OraclePwd");

            conn = DriverManager.getConnection(url,id,pwd);
            System.out.println("DB 연결 성공(파라미터 생성자2)");
        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    //연결 해제(자원 반납)
    public void close() {
        try {
            if(rs != null) rs.close();
            if(stmt != null) stmt.close();
            if(psmt != null) psmt.close();
            if(conn != null) conn.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }


}
