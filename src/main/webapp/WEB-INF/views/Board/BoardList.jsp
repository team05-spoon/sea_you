<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유 게시판</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600;800&family=Poppins:wght@500;700&display=swap" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/BoardList.css">
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<jsp:include page="/WEB-INF/views/Message/MessageAlert.jsp" />
<script>
$(document).ready(function() {
  const rowsPerPage = 10;
  // 게시글 데이터 행만 선택 (empty 메시지 제외)
  const $tableRows = $(".board-table tbody tr:not(:has(.empty))");
  const totalRows = $tableRows.length;
  const totalPages = Math.ceil(totalRows / rowsPerPage);
  
  // 데이터가 10개 초과일 때만 페이징 생성
  if (totalRows > rowsPerPage) {
    const $pagination = $("<div class='pagination-container'></div>");
    $(".board-card").after($pagination);

    function showPage(page) {
      const start = (page - 1) * rowsPerPage;
      const end = start + rowsPerPage;

      $tableRows.hide();
      $tableRows.slice(start, end).fadeIn(400);

      renderButtons(page);
    }

    function renderButtons(currentPage) {
      $pagination.empty();
      for (let i = 1; i <= totalPages; i++) {
        const $btn = $(`<button class="page-btn">${i}</button>`);
        if (i === currentPage) $btn.addClass("active");
        
        $btn.on("click", function() {
          showPage(i);
          // 페이지 이동 시 게시판 상단으로 스크롤
          $('html, body').animate({ scrollTop: $(".board-main").offset().top - 50 }, 300);
        });
        $pagination.append($btn);
      }
    }

    showPage(1); // 초기 호출
  }
});
</script>
</head>

<body>
<!-- 배경 -->
<div class="bg-wrap">
  <video class="bg-video" autoplay muted playsinline>
    <source src="<c:url value='/video/10.mp4'/>" type="video/mp4">
  </video>
  <div class="bg-overlay"></div>
</div>

<!-- 상단바 -->
<div class="top" data-aos="fade-down" data-aos-duration="850">

  <div class="logo">
    <a href="<c:url value='/'/>">
      <img src="<c:url value='/images/Logo/sea_you3.png'/>" alt="SEA_YOU">
    </a>
  </div>

  <nav class="nav">

    <!-- ✅ 지역별(place) : 클릭 시 이동 막고, 드롭다운 안에서만 place로 이동 -->
    <div class="menu region-menu">
      <a href="javascript:void(0)" onclick="return false;">지역</a>

      <div class="dropdown region">
        <div class="title">지역별 해수욕장</div>
        <div class="region-grid">
          <a href="<c:url value='/Beach/list?place=강원도'/>">강원도</a>
          <a href="<c:url value='/Beach/list?place=경상남도'/>">경상남도</a>
          <a href="<c:url value='/Beach/list?place=경상북도'/>">경상북도</a>
          <a href="<c:url value='/Beach/list?place=부산시'/>">부산시</a>
          <a href="<c:url value='/Beach/list?place=울산시'/>">울산시</a>
          <a href="<c:url value='/Beach/list?place=인천시'/>">인천시</a>
          <a href="<c:url value='/Beach/list?place=전라남도'/>">전라남도</a>
          <a href="<c:url value='/Beach/list?place=전라북도'/>">전라북도</a>
          <a href="<c:url value='/Beach/list?place=제주특별자치도'/>">제주특별자치도</a>
          <a href="<c:url value='/Beach/list?place=충청남도'/>">충청남도</a>
        </div>
      </div>
    </div>
    <span class="sep">|</span>

    <!-- 게시판 -->
    <div class="menu no-dropdown">
      <a href="<c:url value='/Board/BoardList'/>">게시판</a>
      <div class="dropdown">
        <div class="title">게시판</div>
      </div>
    </div>
    <span class="sep">|</span>

    <!-- 공지사항 -->
    <div class="menu no-dropdown">
      <a href="<c:url value='/Notice/NoticeList'/>">공지사항</a>
      <div class="dropdown">
        <div class="title">공지사항</div>
      </div>
    </div>

    <span class="sep">|</span>

    <!-- 쪽지함 -->
    <div class="menu">
      <a href="<c:url value='/Message/RecvMessageList'/>">쪽지함</a>
      <div class="dropdown">
        <div class="title">쪽지함</div>
        <a href="<c:url value='/Message/RecvMessageList'/>">받은쪽지함</a>
        <a href="<c:url value='/Message/SentMessageList'/>">보낸쪽지함</a>
      </div>
    </div>
    
        <span class="sep">|</span>
        
        <!-- 회원목록 -->
    <div class="menu no-dropdown">
      <a href="<c:url value='/Member/MemberAllView'/>">회원목록</a>
      <div class="dropdown">
        <div class="title">회원목록</div>
      </div>
    </div>
    
   	<span class="sep">|</span>
   	
           <!-- 관심 목록 -->
    <div class="menu no-dropdown">
      <a href="<c:url value='/BookMark/MyBookMarkList'/>">찜 목록</a>
      <div class="dropdown">
        <div class="title">찜</div>
      </div>
    </div> 
    
      <span class="sep">|</span>
    

    <!-- 전체채팅 -->
   <a href="/Chat/ChatRoom" onclick="window.open(this.href, 'chat', 'width=500, height=700'); return false;">소통</a>

    <!-- 관리자 -->
    <c:if test="${not empty member and member.m_temp eq 'ADMIN'}">
      <span class="sep">|</span>
      <a href="<c:url value='/Member/MemberList'/>">회원 관리</a>
      <span class="sep">|</span>
      <a href="/Report/ReportList">신고 목록</a>
      <span class="sep">|</span>
      <a href="http://192.168.10.47:5601/app/dashboards#/view/862cbfe0-01a4-11f1-ba0f-aff3b8d6751c?_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-15m,to:now))&_a=(description:'',filters:!(),fullScreenMode:!f,options:(hidePanelTitles:!f,useMargins:!t),query:(language:kuery,query:''),timeRestore:!f,title:sea_you,viewMode:view)">통계</a>
    </c:if>
  </nav>

  <!-- 오른쪽: 검색 + 로그인/프로필 -->
  <div class="right-tools">

    <form name="search" method="get" action="<c:url value='/search'/>" class="search-wrap" autocomplete="off">
      <input type="text" id="keyword" name="keyword" class="search-input" placeholder="해수욕장 검색..." autocomplete="off">
      <button type="submit" class="search-btn">검색</button>
      <div id="suggestions"></div>
    </form>

    <div class="auth">
      <c:choose>
        <c:when test="${not empty pageContext.request.userPrincipal}">
          <a class="profile-link" href="<c:url value='/Member/MemberView?m_no=${member.m_no}'/>">
            <img class="profile-img"
                 src="<c:url value='/m_images/${member.m_image}'/>"
                 alt="profile"
                 onerror="this.onerror=null; this.src='<c:url value='/images/common/default_profile.png'/>';"/>
          </a>
          <a href="<c:url value='/logout'/>">로그아웃</a>
        </c:when>
        <c:otherwise>
          <a href="<c:url value='/Member/MemberLoginForm'/>">로그인</a>
          <a href="<c:url value='/Member/MemberWriteForm'/>">회원가입</a>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>

<!-- 게시판 -->
<main class="board-main">
  <div class="board-head">
    <h2 class="board-title">자유 게시판</h2>
    <a class="btn-write" href="${pageContext.request.contextPath}/Board/BoardWrite">글쓰기</a>
  </div>

  <div class="board-card">
    <table class="board-table">
      <thead>
        <tr>
          <th width="10%">번호</th>
          <th width="40%">제목</th>
          <th width="20%">좋아요</th>
          <th width="20%">작성자</th>
          <th width="20%">등록일</th>
          <th width="10%">이미지</th> <!-- 추가된 열 -->
        </tr>
      </thead>
      <tbody>
        <c:forEach var="row" items="${list}">
          <tr>
            <td>${row.b_no}</td>
            <td>
              <a class="title-link" href="${pageContext.request.contextPath}/Board/BoardDetail?b_no=${row.b_no}">
                ${row.b_title}
              </a>
            </td>
            <td><span class="list-like-badge ${row.b_like_count == 0 ? 'zero-like' : ''}">
      <span class="heart-icon">${row.b_like_count == 0 ? '🤍' : '❤️'}</span>
      ${row.b_like_count}
    </span></td>

            <!-- ✅ 작성자 아이콘 + 이름 -->
            <td class="writer-cell">
              <a class="writer-link" href="${pageContext.request.contextPath}/Member/MemberView?m_no=${row.m_no}">
                <img class="writer-avatar"
                     src="<c:url value='/m_images/${row.m_image}'/>"
                     alt="writer"
                     onerror="this.onerror=null; this.src='<c:url value='/images/common/default_profile.png'/>';"/>
                ${row.b_write}
              </a>
            </td>

            <td><fmt:formatDate value="${row.b_date}" pattern="yyyy-MM-dd (E)"/></td>

            <!-- ✅ 게시글 이미지 (썸네일) -->
            <td>
          	  <c:choose>
	              <c:when test="${not empty row.b_image}">
	                <img src="<c:url value='/images/b_images/${row.b_image}'/>" alt="게시글 이미지" class="board-image" />
	              </c:when>
	              <c:otherwise>
	              	<img src="<c:url value='/images/Logo/웨일리.png'/>" class="whaile-image">
	              </c:otherwise>
              </c:choose>
            </td>
          </tr>
        </c:forEach>

        <c:if test="${empty list}">
          <tr><td class="empty" colspan="5">게시글이 없습니다.</td></tr>
        </c:if>
      </tbody>
    </table>
  </div>

  <a class="btn-home" href="/">홈으로</a>
</main>

<!-- 자동완성(메인과 동일) -->
<script>
$(document).ready(function(){
  $("#keyword").on("keyup", function(){
    let q = $(this).val();
    if(q.length < 1){ $("#suggestions").hide(); return; }

    $.ajax({
      url: "<c:url value='/autocomplete'/>",
      data: { keyword: q },
      success: function(list){
        let html = "";
        if(list && list.length > 0) {
          list.forEach(function(item){
            html += "<div class='item'>" + item.highlight + "</div>";
          });
          $("#suggestions").html(html).show();
        } else {
          $("#suggestions").hide();
        }
      }
    });
  });

  $(document).on("click", "#suggestions .item", function(){
    $("#keyword").val($(this).text());
    $("#suggestions").hide();
    document.search.submit();
  });

  $(document).click(function(e) {
    if(!$(e.target).closest('form[name="search"]').length) $("#suggestions").hide();
  });
});
</script>

<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>AOS.init({ duration: 900, once: true, easing: "ease-out-cubic" });</script>
<footer class="footer">
    <p><b>SEA YOU</b></p>
    <p>© 2026 Sea YOU. All Rights Reserved. | KH 정보교육원 프로젝트</p>
</footer>
</body>
</html>
