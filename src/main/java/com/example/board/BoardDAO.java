package com.example.board;

import com.example.common.DBConnPool1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
    private Connection conn;

    public BoardDAO() {
        this.conn = DBConnPool1.getConnection();
        if (this.conn == null) {
            throw new RuntimeException("DB 연결 실패");
        }
    }

    public int getDataCount(String searchKey, String searchValue) throws Exception {
        String sql = "SELECT COUNT(*) FROM SCOTT.COMMUNITY WHERE " + searchKey + " LIKE ?";
        try (PreparedStatement psmt = conn.prepareStatement(sql)) {
            psmt.setString(1, "%" + searchValue + "%");
            try (ResultSet rs = psmt.executeQuery()) {
                rs.next();
                return rs.getInt(1);
            }
        }
    }

    public List<BoardDTO> getDataList(int start, int end, String searchKey, String searchValue) throws Exception {
        String sql = "SELECT * FROM (SELECT ROWNUM rnum, data.* FROM (SELECT * FROM SCOTT.COMMUNITY WHERE "
                + searchKey + " LIKE ? ORDER BY IDX ASC) data) WHERE rnum BETWEEN ? AND ?";
        try (PreparedStatement psmt = conn.prepareStatement(sql)) {
            psmt.setString(1, "%" + searchValue + "%");
            psmt.setInt(2, start);
            psmt.setInt(3, end);
            try (ResultSet rs = psmt.executeQuery()) {
                List<BoardDTO> list = new ArrayList<>();
                while (rs.next()) {
                    BoardDTO dto = new BoardDTO();
                    dto.setIdx(rs.getInt("IDX"));
                    dto.setTitle(rs.getString("TITLE"));
                    dto.setPostdate(rs.getDate("POSTDATE"));
                    dto.setViews(rs.getInt("VIEWS"));
                    dto.setLikes(rs.getInt("LIKES"));
                    dto.setType(rs.getString("TYPE"));
                    dto.setContent(rs.getString("CONTENT"));
                    list.add(dto);
                }
                return list;
            }
        }
    }

    public BoardDTO getArticle(int idx) throws Exception {
        String sql = "SELECT * FROM SCOTT.COMMUNITY WHERE IDX=?";
        try (PreparedStatement psmt = conn.prepareStatement(sql)) {
            psmt.setInt(1, idx);
            try (ResultSet rs = psmt.executeQuery()) {
                if (rs.next()) {
                    BoardDTO dto = new BoardDTO();
                    dto.setIdx(rs.getInt("IDX"));
                    dto.setTitle(rs.getString("TITLE"));
                    dto.setPostdate(rs.getDate("POSTDATE"));
                    dto.setViews(rs.getInt("VIEWS"));
                    dto.setLikes(rs.getInt("LIKES"));
                    dto.setType(rs.getString("TYPE"));
                    dto.setContent(rs.getString("CONTENT"));
                    return dto;
                } else {
                    return null;
                }
            }
        }
    }

    public void close() {
        try {
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void insertArticle(BoardDTO dto) throws Exception {
        String sql = "INSERT INTO SCOTT.COMMUNITY (IDX, TITLE, CONTENT, POSTDATE, VIEWS, LIKES, TYPE) " +
                "VALUES (SCOTT.COMMUNITY_SEQ.NEXTVAL, ?, ?, SYSDATE, 0, 0, ?)";
        try (PreparedStatement psmt = conn.prepareStatement(sql)) {
            psmt.setString(1, dto.getTitle());
            psmt.setString(2, dto.getContent());
            psmt.setString(3, dto.getType());
            psmt.executeUpdate();
        }

    }

    public int updateArticle(BoardDTO dto) {
        int result = 0;
        String sql = "UPDATE SCOTT.COMMUNITY SET TITLE = ?, CONTENT = ? WHERE IDX = ?";
        try {
            PreparedStatement psmt = conn.prepareStatement(sql);
            psmt.setString(1, dto.getTitle());
            psmt.setString(2, dto.getContent());
            psmt.setInt(3, dto.getIdx());
            result = psmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("updateArticle 오류 발생: " + e.getMessage());
        }
        return result;
    }
}
