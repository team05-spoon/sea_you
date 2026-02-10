<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>${member.m_nick}님의 찜 목록</title>

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600;800&family=Poppins:wght@500;700&display=swap" rel="stylesheet">

  <link rel="stylesheet" href="<c:url value='/css/Main.css'/>">
  <link rel="stylesheet" href="<c:url value='/css/MyBookMarkList.css'/>">

  <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <jsp:include page="/WEB-INF/views/Message/MessageAlert.jsp" />
</head>

<body>

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
<main class="page" data-aos="fade-up" data-aos-duration="900">
  <section class="panel">
    <div class="panel-head">
      <div class="title-with-profile">
        <img class="title-small-icon"
             src="<c:url value='/m_images/${member.m_image}'/>"
             alt="user-icon"
             onerror="this.onerror=null; this.src='<c:url value='/images/common/default_profile.png'/>';"/>
        <h2 class="panel-title">${member.m_nick}님의 찜한 바다 목록</h2>
      </div>
      <div class="panel-sub">내가 찜한 해수욕장 리스트입니다.</div>
    </div>

    <input type="hidden" id="session-m-id" value="${m_nick}">
    <input type="hidden" id="csrf-token" name="${_csrf.parameterName}" value="${_csrf.token}">

    <div class="table-area">
      <c:choose>
        <c:when test="${not empty bookmarkList}">
          <table class="bookmark-table">
            <thead>
              <tr>
                <th style="width:140px;">사진</th>
                <th style="width:22%;">해수욕장명</th>
                <th style="width:28%;">위치</th>
                <th style="width:20%;">관리기관</th>
                <th style="width:15%;">수정</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="beach" items="${bookmarkList}">
                <tr>
                  <td>
                    <img src="<c:url value='/images/bc_images/${beach.bc_image}'/>" class="beach-img"
                         onerror="this.src='https://via.placeholder.com/120x80?text=No+Image'">
                  </td>
                  <td class="beach-name">
                    <a href="/Beach/BeachDetail?bc_no=${beach.bc_no}">${beach.bc_name}</a>
                  </td>
                  <td>${beach.bc_location}</td>
                  <td>${beach.bc_office}</td>
                  <td>
                       <a href="/BookMark/DeleteBookMark?bc_no=${beach.bc_no}" 
                         onclick="return confirm('정말 삭제하시겠습니까?');"
                         style="color: #e74c3c; text-decoration: none; font-weight: bold;">
                          [삭제] </a>
                   </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </c:when>
        <c:otherwise>
          <div class="no-data">
            <p>아직 찜한 해수욕장이 없습니다.</p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>

    <div class="panel-foot">
      <a class="btn-ghost" href="<c:url value='/'/>">메인으로 돌아가기</a>
    </div>
  </section>
</main>

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
          list.forEach(function(item){ html += "<div class='item'>" + item.highlight + "</div>"; });
          $("#suggestions").html(html).show();
        } else { $("#suggestions").hide(); }
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