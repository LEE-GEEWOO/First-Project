package com.example.common1;

import java.util.Date;

public class CommunityDTO {
    private int idx;         // 게시글 ID
    private String title;    // 게시글 제목
    private String content;  // 게시글 내용
    private Date postdate;   // 게시글 작성일
    private int views;       // 게시글 조회수
    private int likes;       // 게시글 좋아요 수
    private String author; // 게시글 작성자 이름
    private String userId;   // 사용자 ID
    private int type;        // 게시글 타입 (관리자, 일반 등)

    // 기본 생성자
    public CommunityDTO() {
    }

    // 모든 필드를 초기화하는 생성자
    public CommunityDTO(int idx, String title, String content, Date postdate, int views, int likes, String author, String userId, int type) {
        this.idx = idx;
        this.title = title;
        this.content = content;
        this.postdate = postdate;
        this.views = views;
        this.likes = likes;
        this.author = author;
        this.userId = userId;
        this.type = type;
    }

    // Getter 및 Setter 메서드
    public int getIdx() {
        return idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getPostdate() {
        return postdate;
    }

    public void setPostdate(Date postdate) {
        this.postdate = postdate;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthorName(String author) {
        this.author = author;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "CommunityDTO [idx=" + idx + ", title=" + title + ", content=" + content + ", postdate=" + postdate + ", views=" + views + ", likes=" + likes + ", authorName=" + author + ", userId=" + userId + ", type=" + type + "]";
    }
}
