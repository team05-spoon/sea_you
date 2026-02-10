<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600;800&family=Poppins:wght@500;700&display=swap" rel="stylesheet">

<link rel="stylesheet" href="<c:url value='/css/Main.css'/>">
<link rel="stylesheet" href="<c:url value='/css/MemberList.css'/>">

<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<jsp:include page="/WEB-INF/views/Message/MessageAlert.jsp" />
<script>
$(document).ready(function() {
  const rowsPerPage = 10;
  // 데이터가 있는 행만 선택 (empty 메시지 행 제외)
  const $tableRows = $(".member-table tbody tr:not(:has(.empty))");
  const totalRows = $tableRows.length;
  const totalPages = Math.ceil(totalRows / rowsPerPage);

  // 회원이 10명을 초과할 때만 페이징 생성
  if (totalRows > rowsPerPage) {
    const $pagination = $("<div class='pagination-container'></div>");
    $(".member-card").after($pagination); // 테이블 카드 뒤에 삽입

    function showPage(page) {
      const start = (page - 1) * rowsPerPage;
      const end = start + rowsPerPage;

      $tableRows.hide();
      $tableRows.slice(start, end).show(); // 관리자 페이지는 빠른 검토를 위해 fadeIn 생략 가능 (필요시 .fadeIn(200) 추가)

      renderButtons(page);
    }

    function renderButtons(currentPage) {
      $pagination.empty();
      for (let i = 1; i <= totalPages; i++) {
        const $btn = $(`<button class="page-btn">${i}</button>`);
        if (i === currentPage) $btn.addClass("active");
        
        $btn.on("click", function() {
          showPage(i);
          // 페이지 이동 시 상단으로 부드럽게 스크롤
          $('html, body').animate({ scrollTop: $(".member-main").offset().top - 50 }, 200);
        });
        $pagination.append($btn);
      }
    }

    showPage(1); // 첫 페이지 실행
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

    <a href="/Chat/ChatRoom"
       onclick="window.open(this.href, 'chat', 'width=500, height=700'); return false;">소통</a>

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


<main class="member-main" data-aos="fade-up" data-aos-duration="850">
  <div class="member-head">
    <h2 class="member-title">회원 관리</h2>
    <div class="member-sub">관리자 전용</div>
  </div>

  <div class="member-card">
    <table class="member-table">
      <thead>
        <tr>
          <th width="12%">회원 번호</th>
          <th width="18%">닉네임</th>
          <th width="18%">이름</th>
          <th width="12%">성별</th>
          <th width="20%">생년월일</th>
          <th width="20%">관리</th>
        </tr>
      </thead>

      <tbody>
        <c:forEach var="m" items="${list}">
          <tr>
            <td>
              <a class="id-link" href="<c:url value='/Member/AdminMemberView?m_no=${m.m_no}'/>">${m.m_no}</a>
            </td>
            <td>${m.m_nick}</td>
            <td>${m.m_name}</td>
            <td>${m.m_sex}</td>
            <td>
              <fmt:formatDate value="${m.m_birth}" pattern="yyyy-MM-dd"/>
            </td>
            <td>
              <a class="btn-danger"
                 href="<c:url value='/Member/AdminDelete?m_no=${m.m_no}'/>"
                 onclick="return confirm('정말 삭제하시겠습니까?');">
                 회원 삭제
              </a>
            </td>
          </tr>
        </c:forEach>

        <c:if test="${empty list}">
          <tr><td class="empty" colspan="6">회원이 없습니다.</td></tr>
        </c:if>
      </tbody>
    </table>
  </div>

  <a class="btn-home" href="<c:url value='/'/>">홈으로</a>
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
<script>
  AOS.init({
    duration: 900,
    once: true,
    easing: "ease-out-cubic"
  });
</script>
<footer class="footer">
    <p><b>SEA YOU</b></p>
    <p>© 2026 Sea YOU. All Rights Reserved. | KH 정보교육원 프로젝트</p>
</footer>
</body>
</html>
