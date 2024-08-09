package com.example.util;

import jakarta.servlet.http.HttpServletResponse;

public class JSFunction {
    //메시지 알림창을 띄운 후 해당 URL로 이동
    public static void alertLocation(HttpServletResponse msg, String url, String out) {
        // 자바 스크립트 코드
        try {
            String script = ""
                    + "<script>"
                    + "alert('" + msg + "');"
                    + "location='" + url + "';"
                    + "</script>";
            System.out.println(script);
        } catch (Exception e) {  }
    }

        //메시지 알림창을 띄운 후 이전 페이지로 이동
        public static void alertBack (HttpServletResponse msg, String out){
            // 자바 스크립트 코드
            try {
                String script = ""
                        + "<script>"
                        + "alert('" + msg + "');"
                        + "history.back();"
                        + "</script>";
                System.out.println(script);
            } catch (Exception e) {  }
        }
    }

