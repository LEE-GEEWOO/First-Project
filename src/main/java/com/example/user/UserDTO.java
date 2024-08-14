package com.example.user;

public class UserDTO {
    private String id;
    private String pwd;
    private String name;
    private String email;
    private int type;  // 사용자 권한 타입 (1: 관리자, 2: 일반 회원)

    // 기본 생성자
    public UserDTO() {}

    // 파라미터가 있는 생성자
    public UserDTO(String id, String pwd, String name, String email, int type) {
        this.id = id;
        this.pwd = pwd;
        this.name = name;
        this.email = email;
        this.type = type;
    }



    // Getter 및 Setter 메서드
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }


}