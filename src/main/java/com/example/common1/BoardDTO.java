package com.example.common1;

import java.util.Date;

public class BoardDTO {
    private int idx;         // 게시글 ID
    private String title;    // 게시글 제목
    private String content;  // 게시글 내용
    private String author = "담당자";   // 게시글 작성자
    private Date postdate;   // 게시글 작성일
    private int views;       // 게시글 조회수
    private int likes;       // 게시글 좋아요 수
    private int type;        // 게시글 유형

    // 기본 생성자
    public BoardDTO() {
    }

    // 모든 필드를 초기화하는 생성자
    public BoardDTO(int idx, String title, String content, String author, Date postdate, int views, int likes, int type) {
        this.idx = idx;
        this.title = title;
        this.content = content;
        this.author = author;
        this.postdate = postdate;
        this.views = views;
        this.likes = likes;
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

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
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

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "BoardDTO [idx=" + idx + ", title=" + title + ", content=" + content + ", author=" + author + ", postdate="
                + postdate + ", views=" + views + ", likes=" + likes + ", type=" + type + "]";
    }
}