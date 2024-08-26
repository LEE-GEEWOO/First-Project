package com.example.common1;

import com.example.common.DBConnPool1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
    private Connection conn;
    //11
    // 생성자: DB 연결 설정
    public BoardDAO() {
        this.conn = DBConnPool1.getConnection();
        if (this.conn == null) {
            throw new RuntimeException("DB 연결 실패");
        }
    }

    // ResultSet을 BoardDTO로 매핑
    private BoardDTO mapResultSetToBoardDTO(ResultSet rs) throws SQLException {
        BoardDTO dto = new BoardDTO();
        dto.setIdx(rs.getInt("IDX"));
        dto.setTitle(rs.getString("TITLE"));
        dto.setContent(rs.getString("CONTENT"));
        dto.setAuthor(rs.getString("AUTHOR"));
        dto.setPostdate(rs.getDate("POSTDATE"));
        dto.setViews(rs.getInt("VIEWS"));
        dto.setLikes(rs.getInt("LIKES"));
        dto.setType(rs.getInt("TYPE"));
        return dto;
    }

    // 특정 검색 조건에 맞는 데이터 개수 조회
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
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("getDataCount 오류: " + e.getMessage(), e);
        }
    }

    // 특정 조건에 맞는 데이터 리스트 조회 (페이징 처리 포함)
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
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("getDataList 오류: " + e.getMessage(), e);
        }
    }

    // 특정 게시물 조회
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
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("getArticle 오류: " + e.getMessage(), e);
        }
    }

    // DB 연결 종료
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

    // 새 게시물 삽입
    public int insertArticle(String title, String content, String userId, int userType) {
        String sql = "INSERT INTO SCOTT.COMMUNITY (IDX, TITLE, CONTENT, AUTHOR, POSTDATE, TYPE) " +
                "VALUES (SCOTT.COMMUNITY_SEQ.NEXTVAL, ?, ?, ?, SYSDATE, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql, new String[]{"IDX"})) {
            pstmt.setString(1, title);
            pstmt.setString(2, content);
            pstmt.setString(3, userId); // userId를 AUTHOR로 사용
            pstmt.setInt(4, userType); // userType 사용

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
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("insertArticle 오류: " + e.getMessage(), e);
        }
    }

    // 게시물 업데이트
    public int updateArticle(BoardDTO dto) {
        String sql = "UPDATE SCOTT.COMMUNITY SET TITLE = ?, CONTENT = ?, AUTHOR = ? WHERE IDX = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getContent());
            pstmt.setString(3, dto.getAuthor());
            pstmt.setInt(4, dto.getIdx());
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("updateArticle 오류: " + e.getMessage(), e);
        }
    }

    // 게시물 삭제 (관리자 권한 필요)
    public int delete(int idx, int userType) {
        if (userType != 1) {
            throw new RuntimeException("삭제 권한이 없습니다.");
        }
        String sql = "DELETE FROM SCOTT.COMMUNITY WHERE IDX = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idx);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("delete 오류: " + e.getMessage(), e);
        }
    }

    // 특정 게시물의 조회수 조회
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

    // 특정 게시물의 조회수 1 증가
    public void incrementViews(int idx) {
        String sql = "UPDATE SCOTT.COMMUNITY SET VIEWS = VIEWS + 1 WHERE IDX = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idx);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("incrementViews 오류: " + e.getMessage(), e);
        }
    }

    // 조회수 증가 후 게시물 조회
    public BoardDTO getArticleWithViewIncrement(int idx) {
        incrementViews(idx);
        return getArticle(idx);
    }

    // 사용자 권한 검사 (편집 권한 여부 확인)
    public boolean hasEditPermission(int userType) {
        return userType == 1;
    }

}