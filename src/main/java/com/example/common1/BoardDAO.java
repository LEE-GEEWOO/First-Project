package com.example.common1;

import com.example.common.DBConnPool1;
import oracle.jdbc.proxy.annotation.Pre;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
    private Connection conn;
    private BoardDTO dto;

    public BoardDAO() {
        this.conn = DBConnPool1.getConnection();
        if (this.conn == null) {
            throw new RuntimeException("DB 연결 실패");
        }
    }

    private BoardDTO mapResultSetToBoardDTO(ResultSet rs) throws SQLException {
        BoardDTO dto = new BoardDTO();
        dto.setIdx(rs.getInt("IDX"));
        dto.setTitle(rs.getString("TITLE"));
        dto.setPostdate(rs.getDate("POSTDATE"));
        dto.setViews(rs.getInt("VIEWS"));
        dto.setLikes(rs.getInt("LIKES"));
        dto.setType(rs.getString("TYPE"));
        dto.setContent(rs.getString("CONTENT"));
        dto.setAuthor(rs.getString("AUTHOR"));
        return dto;
    }

    //검색 기능
    public int getDataCount(String searchKey, String searchValue) {
        String sql = "SELECT COUNT(*) FROM SCOTT.COMMUNITY WHERE " + searchKey + " LIKE ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + searchValue + "%");
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                } else {
                    throw new RuntimeException("결과가 없습니다.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("getDataCount 오류: " + e.getMessage(), e);
        }
    }

    //페이징 처리에 사용되며, 검색 키(searchKey)와 검색 값(searchValue)을 기반으로 start부터 end까지의 데이터를 가져옴
    public List<BoardDTO> getDataList(int start, int end, String searchKey, String searchValue) {
        String sql = "SELECT * FROM (SELECT ROWNUM rnum, data.* FROM (SELECT * FROM SCOTT.COMMUNITY WHERE "
                + searchKey + " LIKE ? ORDER BY IDX ASC) data) WHERE rnum BETWEEN ? AND ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + searchValue + "%");
            pstmt.setInt(2, start);
            pstmt.setInt(3, end);
            try (ResultSet rs = pstmt.executeQuery()) {
                List<BoardDTO> list = new ArrayList<>();
                while (rs.next()) {
                    list.add(mapResultSetToBoardDTO(rs));
                }
                return list;
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("getDataList 오류: " + e.getMessage(), e);
        }
    }

    public BoardDTO getArticle(int idx) {
        String sql = "SELECT * FROM SCOTT.COMMUNITY WHERE IDX=?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idx);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToBoardDTO(rs);
                } else {
                    return null;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("getArticle 오류: " + e.getMessage(), e);
        }
    }

    public void close() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (Exception e) {
            throw new RuntimeException("DB 연결 닫기 오류"+ e.getMessage(), e);
        }finally {
            this.conn = null;
        }
    }

    public int insertArticle(BoardDTO dto) throws SQLException {
        String sql = "INSERT INTO SCOTT.COMMUNITY (TITLE, CONTENT, AUTHOR, POSTDATE) VALUES (?, ?, ?, SYSDATE)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getContent());
            pstmt.setString(3, dto.getAuthor() != null ? dto.getAuthor() : "Anonymous");
            int affectedRows = pstmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("게시글 생성 실패, 영향받은 행이 없습니다.");
            }
            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("게시글 생성 실패, ID를 가져올 수 없습니다.");
                }
            }
        }
    }
    public int updateArticle(BoardDTO dto) {
        String sql = "UPDATE SCOTT.COMMUNITY SET TITLE = ?, CONTENT = ?, AUTHOR = ? WHERE IDX = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getContent());
            pstmt.setString(3, dto.getAuthor() != null ? dto.getAuthor() : "Anonymous");
            pstmt.setInt(4, dto.getIdx());
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("updateArticle 오류: " + e.getMessage(), e);
        }
    }

    public int getViews(int idx) {
        String sql = "SELECT VIEWS FROM SCOTT.COMMUNITY WHERE IDX = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idx);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("VIEWS");
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("getViews 오류: " + e.getMessage(), e);
        }
        return 0;
    }

    public void incrementViews(int idx) {
        String sql = "UPDATE SCOTT.COMMUNITY SET VIEWS = VIEWS + 1 WHERE IDX = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idx);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("incrementViews 오류: " + e.getMessage(), e);
        }
    }

    public BoardDTO getArticleWithViewIncrement(int idx) {
        incrementViews(idx);
        return getArticle(idx);
    }

    public int delete(int idx) {
        String sql = "DELETE FROM SCOTT.COMMUNITY WHERE IDX = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idx);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("delete 오류: " + e.getMessage(), e);
        }

    }
}
