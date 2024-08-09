package com.example.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnPool1 {

    private static final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521:xe"; // 데이터베이스 URL
    private static final String JDBC_USER = "scott"; // 데이터베이스 사용자 이름
    private static final String JDBC_PASSWORD = "tiger"; // 데이터베이스 비밀번호

    static {
        try {
            // Oracle JDBC 드라이버 로드
            Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("Oracle JDBC Driver loaded successfully");
        } catch (ClassNotFoundException e) {
            System.out.println("Failed to load Oracle JDBC Driver");
            e.printStackTrace();
        }
    }

    public static Connection getConnection() {
        Connection conn = null;
        try {
            // JDBC 연결 생성
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
        } catch (SQLException e) {
            System.out.println("Failed to get a connection from the database");
            e.printStackTrace();
        }
        return conn;
    }
}