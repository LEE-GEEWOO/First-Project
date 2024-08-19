package com.example.common1;

import com.example.common.DBConnPool1;

import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommunityDAO {
    private Connection conn;

    public CommunityDAO() {
        this.conn = DBConnPool1.getConnection();
        if (this.conn == null) {
            throw new RuntimeException("DB 연결 실패");
        }
    }

    private CommunityDTO mapResultSetToCommunityDTO(ResultSet rs) throws SQLException {
        CommunityDTO dto = new CommunityDTO();
        dto.setIdx(rs.getInt("IDX"));
        dto.setTitle(rs.getString("TITLE"));
        dto.setContent(rs.getString("CONTENT"));
        dto.setPostdate(rs.getDate("POSTDATE"));
        dto.setViews(rs.getInt("VIEWS"));
        dto.setLikes(rs.getInt("LIKES"));
        dto.setAuthorName(rs.getString("AUTHOR"));
        dto.setUserId(rs.getString("USER_ID"));
        dto.setType(rs.getInt("TYPE"));
        return dto;
    }

    public int getDataCount(String searchKey, String searchValue) {
        String sql = "SELECT COUNT(*) FROM scott.USER_COMMUNITY WHERE " + searchKey + " LIKE ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + searchValue + "%");
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                } else {
                    throw new RuntimeException("결과가 없습니다.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("getDataCount 오류: " + e.getMessage(), e);
        }
    }

    public List<CommunityDTO> getDataList(int start, int end, String searchKey, String searchValue) {
        String sql = "SELECT * FROM (SELECT ROWNUM rnum, data.* FROM (SELECT * FROM USER_COMMUNITY WHERE "
                + searchKey + " LIKE ? ORDER BY IDX ASC) data) WHERE rnum BETWEEN ? AND ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + searchValue + "%");
            pstmt.setInt(2, start);
            pstmt.setInt(3, end);
            try (ResultSet rs = pstmt.executeQuery()) {
                List<CommunityDTO> list = new ArrayList<>();
                while (rs.next()) {
                    list.add(mapResultSetToCommunityDTO(rs));
                }
                return list;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("getDataList 오류: " + e.getMessage(), e);
        }
    }

    public CommunityDTO getArticle(int idx) {
        String sql = "SELECT * FROM USER_COMMUNITY WHERE IDX=?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idx);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCommunityDTO(rs);
                } else {
                    return null;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("getArticle 오류: " + e.getMessage(), e);
        }
    }

    public void close() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException e) {
            throw new RuntimeException("DB 연결 닫기 오류: " + e.getMessage(), e);
        } finally {
            this.conn = null;
        }
    }

    public int insertArticle(CommunityDTO dto) throws SQLException {
        String sql = "INSERT INTO USER_COMMUNITY (TITLE, CONTENT, AUTHOR, USER_ID, TYPE) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getContent());
            pstmt.setString(3, dto.getAuthor());
            pstmt.setString(4, dto.getUserId());
            pstmt.setInt(5, dto.getType());
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

    public int updateArticle(CommunityDTO dto, String currentUserId, int currentUserType) {
        String sql = "UPDATE USER_COMMUNITY SET TITLE = ?, CONTENT = ? WHERE IDX = ? AND (USER_ID = ? OR ? = 1)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getContent());
            pstmt.setInt(3, dto.getIdx());
            pstmt.setString(4, currentUserId);
            pstmt.setInt(5, currentUserType);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("updateArticle 오류: " + e.getMessage(), e);
        }
    }

    public int delete(int idx, String currentUserId, int currentUserType) {
        String sql = "DELETE FROM USER_COMMUNITY WHERE IDX = ? AND (USER_ID = ? OR ? = 1)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idx);
            pstmt.setString(2, currentUserId);
            pstmt.setInt(3, currentUserType);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("delete 오류: " + e.getMessage(), e);
        }
    }

    public int getViews(int idx) {
        String sql = "SELECT VIEWS FROM USER_COMMUNITY WHERE IDX = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idx);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("VIEWS");
                } else {
                    return 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("getViews 오류: " + e.getMessage(), e);
        }
    }

    public void incrementViews(int idx) {
        String sql = "UPDATE USER_COMMUNITY SET VIEWS = VIEWS + 1 WHERE IDX = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idx);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("incrementViews 오류: " + e.getMessage(), e);
        }
    }

    // 좋아요 수 증가 메서드
    public boolean incrementLikes(int idx) {
        String sql = "UPDATE USER_COMMUNITY SET LIKES = LIKES + 1 WHERE IDX = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idx);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("incrementLikes 오류: " + e.getMessage(), e);
        }
    }

    // 좋아요 수 감소 메서드
    public boolean decrementLikes(int idx) {
        String sql = "UPDATE USER_COMMUNITY SET LIKES = LIKES - 1 WHERE IDX = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idx);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("decrementLikes 오류: " + e.getMessage(), e);
        }
    }


    // 좋아요 수 조회 메서드
    public int getLikes(int idx) {
        String sql = "SELECT LIKES FROM USER_COMMUNITY WHERE IDX = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idx);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("LIKES");
                } else {
                    return 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("getLikes 오류: " + e.getMessage(), e);
        }
    }


    public void addPost(String title) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            InitialContext initContext = new InitialContext();
            DataSource ds = (DataSource) initContext.lookup("java:/jdbc/CommunityDB");
            conn = ds.getConnection();
            String query = "INSERT INTO COMMUNITY (TITLE) VALUES (?)";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, title);
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
}

