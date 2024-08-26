package com.example.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnPool2 {

    private static final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521:xe"; // 데이터베이스 URL
    private static final String JDBC_USER = "scott"; // 데이터베이스 사용자 이름
    private static final String JDBC_PASSWORD = "tiger"; // 데이터베이스 비밀번호

    static {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("Oracle JDBC Driver loaded successfully");
        } catch (ClassNotFoundException e) {
            System.err.println("Failed to load Oracle JDBC Driver");
            e.printStackTrace();
            throw new RuntimeException("Oracle JDBC Driver loading failed", e); // 초기화 실패 시 예외 발생
        }
    }

    public static Connection getConnection() {
        try {
            // JDBC 연결 생성
            return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
        } catch (SQLException e) {
            System.err.println("Failed to get a connection from the database");
            e.printStackTrace();
            throw new RuntimeException("Database connection failed", e); // 연결 실패 시 예외 발생
        }
    }
}
