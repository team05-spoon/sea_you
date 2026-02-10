<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>전체 일반 회원 목록</title>

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600;800&family=Poppins:wght@500;700&display=swap" rel="stylesheet">

  <link rel="stylesheet" href="<c:url value='/css/Main.css'/>">
  <link rel="stylesheet" href="<c:url value='/css/MemberAllView.css'/>">

  <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <jsp:include page="/WEB-INF/views/Message/MessageAlert.jsp" />
  <script>
$(document).ready(function() {
  const rowsPerPage = 10; // 한 페이지에 보여줄 인원 수
  const $tableRows = $(".member-table tbody tr:not(.empty)"); // 데이터 행만 선택
  const totalRows = $tableRows.length;
  const totalPages = Math.ceil(totalRows / rowsPerPage);
  
  // 1. 페이지네이션 컨테이너 생성 및 삽입
  const $pagination = $("<div class='pagination-container'></div>");
  $(".table-area").after($pagination);

  // 2. 페이지 표시 함수
  function showPage(page) {
    const start = (page - 1) * rowsPerPage;
    const end = start + rowsPerPage;

    // 모든 행 숨기고 해당 범위만 표시
    $tableRows.hide();
    $tableRows.slice(start, end).fadeIn(300); // 부드럽게 나타나도록 페이드 효과

    // 버튼 활성화 상태 변경
    renderButtons(page);
  }

  // 3. 버튼 렌더링 함수
  function renderButtons(currentPage) {
    $pagination.empty();
    
    for (let i = 1; i <= totalPages; i++) {
      const $btn = $(`<button class="page-btn">${i}</button>`);
      if (i === currentPage) $btn.addClass("active");
      
      $btn.on("click", function() {
        showPage(i);
        // 페이지 이동 시 상단으로 스크롤 (선택 사항)
        $('html, body').animate({ scrollTop: $(".table-area").offset().top - 100 }, 300);
      });
      
      $pagination.append($btn);
    }
  }

  // 4. 초기 실행 (데이터가 있을 때만)
  if (totalRows > 0) {
    showPage(1);
  }
});
</script>
</head>
<body>

<div class="bg-wrap">
  <video class="bg-video" autoplay muted playsinline>
    <source src="<c:url value='/video/10.mp4'/>" type="video/mp4">
  </video>
  <div class="bg-overlay"></div>
</div>


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
      <a href="<c:url value='/Member/MemberAllView'/>">회원목록</a>
      <div class="dropdown"><div class="title">회원목록</div></div>
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

<main class="page" data-aos="fade-up" data-aos-duration="900">
  <section class="panel">
    <div class="panel-head">
      <div class="title-with-profile">
        <img class="title-tiny-icon"
             src="<c:url value='/m_images/${member.m_image}'/>"
             onerror="this.onerror=null; this.src='<c:url value='/images/common/default_profile.png'/>';"/>
        <h2 class="panel-title">전체 일반 회원 목록</h2>
      </div>
      <div class="panel-sub">닉네임 클릭하면 상세페이지로 이동</div>
    </div>

    <div class="table-area">
      <table class="member-table">
        <thead>
          <tr>
            <th>닉네임</th>
            <th>이름</th>
            <th>성별</th>
            <th>생년월일</th>
          </tr>
        </thead>

        <tbody>
          <c:choose>
            <c:when test="${not empty list}">
              <c:forEach var="m" items="${list}">
                <tr>
                  
                  <td class="nick">
                    <a class="nick-link" href="<c:url value='/Member/MemberView?m_no=${m.m_no}'/>">
                      <img class="mini-avatar"
                           src="<c:url value='/m_images/${m.m_image}'/>"
                           alt="profile"
                           onerror="this.onerror=null; this.src='<c:url value='/images/common/default_profile.png'/>';"/>
                      ${m.m_nick}
                    </a>
                  </td>

                  <td>${m.m_name}</td>
                  <td>${m.m_sex}</td>
                  <td><fmt:formatDate value="${m.m_birth}" pattern="yyyy-MM-dd"/></td>
                </tr>
              </c:forEach>
            </c:when>

            <c:otherwise>
              <tr><td class="empty" colspan="4">조회된 일반 회원이 없습니다.</td></tr>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>
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
<script>AOS.init({ duration: 900, once: true });</script>
<footer class="footer">
    <p><b>SEA YOU</b></p>
    <p>© 2026 Sea YOU. All Rights Reserved. | KH 정보교육원 프로젝트</p>
</footer>
</body>
</html>
