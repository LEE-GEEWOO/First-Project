package com.example;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CommunityDAO {

    public List<CommunityDTO> getAllPosts() throws Exception {
        List<CommunityDTO> posts = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            InitialContext initContext = new InitialContext();
            DataSource ds = (DataSource) initContext.lookup("java:/jdbc/CommunityDB");
            conn = ds.getConnection();
            stmt = conn.createStatement();
            String query = "SELECT * FROM COMMUNITY ORDER BY POSTDATE DESC";
            rs = stmt.executeQuery(query);

            while (rs.next()) {
                CommunityDTO post = new CommunityDTO();
                post.setIdx(rs.getInt("IDX"));
                post.setTitle(rs.getString("TITLE"));
                post.setPostDate(rs.getDate("POSTDATE"));
                post.setViews(rs.getInt("VIEWS"));
                post.setLikes(rs.getInt("LIKES"));
                post.setType(rs.getString("TYPE"));
                posts.add(post);
            }
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
        return posts;
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
