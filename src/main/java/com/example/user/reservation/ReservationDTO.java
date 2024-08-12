package com.example.user.reservation;

import java.sql.Date;

public class ReservationDTO {
    private String id;
    private String tel;
    private Date attendDate;

    public ReservationDTO() {
    }

    public ReservationDTO(String id, String tel, Date attendDate) {
        this.id = id;
        this.tel = tel;
        this.attendDate = attendDate;
    }

    // Getter 및 Setter 메서드
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public Date getAttendDate() {
        return attendDate;
    }

    public void setAttendDate(Date attendDate) {
        this.attendDate = attendDate;
    }
}
