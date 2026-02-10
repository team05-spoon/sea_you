<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${place} 해수욕장 목록</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600;800&family=Poppins:wght@500;700&display=swap" rel="stylesheet">


<link rel="stylesheet" href="<c:url value='/css/Main.css'/>">


<link rel="stylesheet" href="<c:url value='/css/BeachList.css'/>">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<jsp:include page="/WEB-INF/views/Message/MessageAlert.jsp" />
<script>
$(document).ready(function() {
  const rowsPerPage = 10;
 
  const $tableRows = $(".list-table tbody tr:not(:has(.empty))");
  const totalRows = $tableRows.length;
  const totalPages = Math.ceil(totalRows / rowsPerPage);
  
  if (totalRows <= rowsPerPage) return; 

  const $pagination = $("<div class='pagination-container'></div>");
  $(".table-wrap").after($pagination);

  function showPage(page) {
    const start = (page - 1) * rowsPerPage;
    const end = start + rowsPerPage;

    $tableRows.hide();
    $tableRows.slice(start, end).fadeIn(300);

    renderButtons(page);
  }

  function renderButtons(currentPage) {
    $pagination.empty();
    for (let i = 1; i <= totalPages; i++) {
      const $btn = $(`<button class="page-btn">${i}</button>`);
      if (i === currentPage) $btn.addClass("active");
      
      $btn.on("click", function() {
        showPage(i);
 
        $('html, body').animate({ scrollTop: $(".table-wrap").offset().top - 100 }, 200);
      });
      $pagination.append($btn);
    }
  }

  showPage(1); 
});
</script>
</head>

<body>


<div class="bg-wrap">
  <video class="bg-video" autoplay muted  playsinline>
    <source src="<c:url value='/video/10.mp4'/>" type="video/mp4">
  </video>
  <div class="bg-overlay"></div>
</div>

<!-- ✅ 상단바 (메인 그대로) -->
<div class="top" data-aos="fade-down" data-aos-duration="850">

  <div class="logo">
    <a href="<c:url value='/'/>">
      <img src="<c:url value='/images/Logo/sea_you3.png'/>" alt="SEA_YOU">
    </a>
  </div>

  <nav class="nav">
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

    <div class="menu no-dropdown">
      <a href="<c:url value='/Board/BoardList'/>">게시판</a>
      <div class="dropdown"><div class="title">게시판</div></div>
    </div>

    <span class="sep">|</span>

    <div class="menu no-dropdown">
      <a href="<c:url value='/Notice/NoticeList'/>">공지사항</a>
      <div class="dropdown"><div class="title">공지사항</div></div>
    </div>

    <span class="sep">|</span>

    <div class="menu">
      <a href="<c:url value='/Message/RecvMessageList'/>">쪽지함</a>
      <div class="dropdown">
        <div class="title">쪽지함</div>
        <a href="<c:url value='/Message/RecvMessageList'/>">받은쪽지함</a>
        <a href="<c:url value='/Message/SentMessageList'/>">보낸쪽지함</a>
      </div>
    </div>

    <span class="sep">|</span>

    <div class="menu no-dropdown">
      <a href="<c:url value='/BookMark/MyBookMarkList'/>">찜 목록</a>
      <div class="dropdown"><div class="title">찜</div></div>
    </div>

    <span class="sep">|</span>

    <a href="/Chat/ChatRoom" onclick="window.open(this.href, 'chat', 'width=500, height=700'); return false;">소통</a>

    <c:if test="${not empty member and member.m_temp eq 'ADMIN'}">
      <span class="sep">|</span>
      <a href="<c:url value='/Member/MemberList'/>">회원 관리</a>
      <span class="sep">|</span>
      <a href="/Report/ReportList">신고 목록</a>
      <span class="sep">|</span>
      <a href="http://192.168.10.47:5601/app/dashboards#/view/862cbfe0-01a4-11f1-ba0f-aff3b8d6751c?_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-15m,to:now))&_a=(description:'',filters:!(),fullScreenMode:!f,options:(hidePanelTitles:!f,useMargins:!t),query:(language:kuery,query:''),timeRestore:!f,title:sea_you,viewMode:view)">통계</a>
    </c:if>
  </nav>

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

<!-- ✅ 목록 컨텐츠 -->
<div class="page">
  <div class="glass" data-aos="fade-up" data-aos-duration="850">

    <div class="head">
      <h2 class="title">${place} 해수욕장 목록</h2>
      <div class="head-actions">
        <a class="btn" href="<c:url value='/'/>">메인으로</a>
        <a class="btn" href="javascript:history.back()">뒤로가기</a>
      </div>
    </div>

    <div class="table-wrap">
      <table class="list-table">
        <thead>
          <tr>
            <th>해변사진</th>
            <th>해수욕장명</th>
            <th>위치</th>
            <th>관리청</th>
            <th>길이</th>
            <th>너비</th>
            <th>면적</th>
          </tr>
        </thead>

        <tbody>
          <c:forEach var="b" items="${list}">
            <tr>
              <td>
              	
              	<c:choose>
                   <c:when test="${not empty b.bc_image}">
                        <img src="${pageContext.request.contextPath}/images/bc_images/${b.bc_image}" 
                             class="beachimage" 
                             alt="${b.bc_name}"
                             onerror="this.src='https://via.placeholder.com/120x80?text=No+Image'">
                      </c:when>
                      <c:otherwise>
                        <img src="https://via.placeholder.com/120x80?text=No+Image" class="beachimage">
                      </c:otherwise>
                </c:choose>
			  </td>
              <td>
                <a class="name-link" href="<c:url value='/Beach/BeachDetail?bc_no=${b.bc_no}'/>">
                  ${b.bc_name}
                </a>
              </td>
              <td>${b.bc_location}</td>
              <td>${b.bc_office}</td>
              <td>${b.bc_length}</td>
              <td>${b.bc_width}</td>
              <td>${b.bc_area}</td>
            </tr>
          </c:forEach>

          <c:if test="${empty list}">
            <tr><td colspan="7" class="empty">데이터가 없습니다.</td></tr>
          </c:if>
        </tbody>
      </table>
    </div>

  </div>
</div>

<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
  AOS.init({ duration: 900, once: true, easing: "ease-out-cubic" });
</script>
<footer class="footer">
    <p><b>SEA YOU</b></p>
    <p>© 2026 Sea YOU. All Rights Reserved. | KH 정보교육원 프로젝트</p>
</footer>
</body>
</html>
