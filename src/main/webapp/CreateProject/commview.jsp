<%@ page import="com.example.common1.CommunityDAO" %>
<%@ page import="com.example.common1.CommunityDTO" %>
<%@ page import="com.example.user.UserDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    // 로그인 사용자 정보 가져오기
    UserDTO user = (UserDTO) session.getAttribute("user");
    String userId = (user != null) ? user.getName() : "";
    int userType = (user != null) ? user.getType() : 0;

    // 요청 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // 커뮤니티 DAO 객체 생성
    CommunityDAO dao = new CommunityDAO();

    // 게시물 ID 파라미터
    String strIdx = request.getParameter("idx");
    int idx = 0;
    try {
        idx = Integer.parseInt(strIdx);
    } catch (NumberFormatException e) {
        response.sendRedirect("community.jsp");
        return;
    }

    // 게시물 상세 정보 조회
    CommunityDTO dto = dao.getArticle(idx);
    if (dto == null) {
        response.sendRedirect("community.jsp");
        return;
    }

    // 게시물 조회수 증가
    dao.incrementViews(idx);

    // 게시물 작성일 포맷
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String postDate = sdf.format(dto.getPostdate());

    String listUrl = "community.jsp";
    String articleUrl = "commview.jsp?idx=" + idx;
    if (userId != null && !userId.isEmpty()) {
        articleUrl += "&pageNum=" + request.getParameter("pageNum");
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시물 보기</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>../css/styles.css">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

</head>
<body>
<header>
    <nav class="navbar navbar-expand-sm navbar-custom navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="../html/index.html">
                <img src="src/main/webapp/jpg/var_logo.png" alt style="height: 40px; width:40px">
                2024 부산 해산물 마켓
            </a>

            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse justify-content-end" id="collapsibleNavbar">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" style="color: white" href="../html/info.html">관람 안내</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" style="color: white"
                           href="<%=request.getContextPath()%>/CreateProject/List.jsp">공지사항</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" style="color: white" href="QNA.html">Q&A</a>
                    </li>
                    <li class="nav-item dropdown" id="navbarUser">
                        <% if (userId != null && !userId.isEmpty()) { %>
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: white">
                            안녕하세요, <%= userId %>님
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item"
                               href="<%=request.getContextPath()%>/CreateProject/mypage.jsp">마이페이지</a>
                            <a class="dropdown-item"
                               href="<%=request.getContextPath()%>/CreateProject/logout.do">로그아웃</a>
                        </div>
                        <% } else { %>
                        <a class="nav-link" style="color: white"
                           href="<%=request.getContextPath()%>/CreateProject/login.jsp">로그인</a>
                        <% } %>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>

<main class="container mt-4">
    <h1 class="text-center">게시물 상세 보기</h1>

    <!-- 게시물 상세 정보 -->
    <div class="card mb-4 position-relative">
        <div class="position-absolute" style="top: 10px; right: 10px; cursor: pointer;">
            <i class="bi bi-heart" id="heartIcon"></i> <!-- 초기 빈 하트 아이콘 -->
        </div>
        <div class="card-body">
            <h2 class="card-title"><%= dto.getTitle() %>
            </h2>
            <h5 class="card-subtitle mb-2 text-muted">작성자: <%= dto.getAuthor() %> / 작성일: <%= postDate %>
            </h5>
            <p class="card-text"><%= dto.getContent() %>
            </p>
            <p class="card-text">조회수: <%= dto.getViews() %>
            </p>
        </div>
    </div>

    <!-- 수정 및 삭제 버튼 (작성자 또는 관리자만) -->
    <% if (userId.equals(dto.getUserId()) || userType == 1) { %>
    <div class="text-center">
        <a href="<%=request.getContextPath()%>/CreateProject/Update.jsp?idx=<%= idx %>&pageNum=<%= request.getParameter("pageNum") %>"
           class="btn btn-warning">수정</a>
        <a href="<%=request.getContextPath()%>/CreateProject/Delete.do?idx=<%= idx %>&pageNum=<%= request.getParameter("pageNum") %>"
           class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
        <a href="<%= listUrl %>" class="btn btn-secondary">목록으로</a>
    </div>
    <% } else { %>
    <div class="text-center">
        <a href="<%= listUrl %>" class="btn btn-secondary">목록으로</a>
    </div>
    <% } %>
</main>

<script>
    $(document).ready(function () {
        var isLiked = false; // 사용자의 좋아요 상태를 저장합니다.

        $("#heartIcon").click(function () {
            var $icon = $(this);
            var idx = <%= dto.getIdx() %>; // 게시글 ID

            $.ajax({
                url: '<%= request.getContextPath() %>/like.do',
                type: 'POST',
                data: {
                    idx: idx,
                    isLiked: isLiked
                },
                dataType: 'json',
                success: function (response) {
                    if (response.success) {
                        // 하트 아이콘과 좋아요 수 업데이트
                        if (isLiked) {
                            $icon.removeClass("bi-heart-fill").addClass("bi-heart");
                            isLiked = false;
                        } else {
                            $icon.removeClass("bi-heart").addClass("bi-heart-fill");
                            isLiked = true;
                        }
                        $("#likeCount").text(response.newLikeCount); // 서버에서 반환한 좋아요 수 업데이트
                    } else {
                        alert(response.message || '좋아요 처리 중 오류가 발생했습니다.');
                    }
                },
                error: function () {
                    alert('서버와의 통신 오류가 발생했습니다.');
                }
            });
        });
    });
</script>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
