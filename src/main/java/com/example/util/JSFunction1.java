package com.example.util;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.jsp.JspWriter;
import java.io.PrintWriter;

public class JSFunction1 {
    // 메시지 알림창을 띄운 후 해당 URL로 이동
    public static void alertLocation(String msg, String url, JspWriter out) {
        try {
            String script = ""
                    + "<script>"
                    + " alert('" + msg + "');"
                    + " location='" + url + "';"
                    + "</script>";
            out.println(script);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void alertLocation(HttpServletResponse resp, String msg, String url) {
        try {
            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter writer = resp.getWriter();
            String script = ""
                    + "<script>"
                    + " alert('" + msg + "');"
                    + " location='" + url + "';"
                    + "</script>";
            writer.println(script);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 메시지 알림창을 띄운 후 이전 페이지로 이동
    public static void alertBack(String msg, JspWriter out) {
        try {
            String script = ""
                    + "<script>"
                    + " alert('" + msg + "');"
                    + " history.back();"
                    + "</script>";
            out.println(script);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 총 페이지 수 계산
    public static int getPageCount(int numPerPage, int dataCount) {
        int pageCount = 0;

        if (dataCount > 0) {
            pageCount = dataCount / numPerPage;
            if (dataCount % numPerPage != 0) {
                pageCount++;
            }
        }
        return pageCount;
    }

    // 페이지 인덱스 리스트 생성
    public static String pageIndexList(int currentPage, int totalPage, String listUrl) {
        int numPerBlock = 5; // 한 번에 표시할 페이지 수
        int currentPageSetup;
        int page;
        StringBuilder sb = new StringBuilder();

        if (currentPage == 0 || totalPage == 0) {
            return "";
        }

        // 바로 가기 페이지
        if (listUrl.contains("?")) {
            listUrl += "&";
        } else {
            listUrl += "?";
        }

        // 이전 페이지 블록으로 이동
        currentPageSetup = (currentPage / numPerBlock) * numPerBlock;
        if (currentPage % numPerBlock == 0) {
            currentPageSetup = currentPageSetup - numPerBlock;
        }

        if (totalPage > numPerBlock && currentPageSetup > 0) {
            sb.append("<a href='").append(listUrl).append("pageNum=").append(currentPageSetup).append("'>Prev</a>&nbsp;");
        }

        // 페이지 숫자 나열
        page = currentPageSetup + 1;
        while (page <= totalPage && page <= (currentPageSetup + numPerBlock)) {
            if (page == currentPage) {
                sb.append("<span>").append(page).append("</span>&nbsp;");
            } else {
                sb.append("<a href='").append(listUrl).append("pageNum=").append(page).append("'>").append(page).append("</a>&nbsp;");
            }
            page++;
        }

        // 다음 페이지 블록으로 이동
        if (totalPage - currentPageSetup > numPerBlock) {
            sb.append("<a href='").append(listUrl).append("pageNum=").append(page).append("'>Next</a>&nbsp;");
        }

        return sb.toString();
    }
}
