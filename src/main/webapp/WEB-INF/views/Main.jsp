<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SEA_YOU 메인</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600;800&family=Poppins:wght@500;700&display=swap" rel="stylesheet">

<link rel="stylesheet" href="<c:url value='/css/Main.css'/>">

<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>

<!-- 배경 -->
<div class="bg-wrap">
  <video class="bg-video" autoplay muted playsinline>
    <source src="<c:url value='/video/10.mp4'/>" type="video/mp4">
  </video>
  <div class="bg-overlay"></div>
</div>

<!-- 상단바 (✅ 네 코드 그대로 / 단, 검색폼만 제거) -->
<div class="top" data-aos="fade-down" data-aos-duration="850">

  <div class="logo">
    <a href="<c:url value='/'/>">
      <img src="<c:url value='/images/Logo/sea_you3.png'/>" alt="SEA_YOU">
    </a>
  </div>

  <nav class="nav">

    <!-- ✅ 지역별(place) -->
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
      <div class="dropdown"><div class="title">게시판</div></div>
    </div>
    <span class="sep">|</span>

    <!-- 공지사항 -->
    <div class="menu no-dropdown">
      <a href="<c:url value='/Notice/NoticeList'/>">공지사항</a>
      <div class="dropdown"><div class="title">공지사항</div></div>
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
      <div class="dropdown"><div class="title">회원목록</div></div>
    </div>

    <span class="sep">|</span>

    <!-- 찜 목록 -->
    <div class="menu no-dropdown">
      <a href="<c:url value='/BookMark/MyBookMarkList'/>">찜 목록</a>
      <div class="dropdown"><div class="title">찜</div></div>
    </div>

    <span class="sep">|</span>

    <!-- 전체채팅 -->
    <a href="/Chat/ChatRoom" onclick="window.open(this.href, 'chat', 'width=500, height=700'); return false;">전체채팅</a>

    <!-- 관리자 -->
    <c:if test="${not empty member and member.m_temp eq 'ADMIN'}">
      <span class="sep">|</span>
      <a href="<c:url value='/Member/MemberList'/>">회원 관리</a>
      <a href="/Report/ReportList">신고 목록</a>
    </c:if>
  </nav>

  <!-- 오른쪽: (✅ 검색 제거) 로그인/프로필만 유지 -->
  <div class="right-tools">
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

<!-- ✅ 새 레이아웃 (왼쪽: 여름/겨울, 오른쪽: 공지/게시) -->
<main class="home-layout">

  <!-- LEFT -->
  <section class="home-left" data-aos="fade-up" data-aos-delay="80">

    <!-- ✅ 검색창을 여기로 이동 (SUMMER/WINTER 위 중앙) -->
    <div class="main-search-wrap" data-aos="fade-down" data-aos-delay="120">
      <form name="search" method="get" action="<c:url value='/search'/>"
            class="search-wrap main-search" autocomplete="off">
        <input type="text" id="keyword" name="keyword" class="search-input"
               placeholder="해수욕장 검색..." autocomplete="off">
        <button type="submit" class="search-btn">검색</button>
        <div id="suggestions"></div>
      </form>
    </div>

    <div class="season-grid">

      <!-- 여름 -->
      <div class="season-col">
        <div class="season-title summer">
          <span class="season-ico">☀️</span>
          <span class="season-text">SUMMER</span>
          <span class="season-sub">PICKS</span>
        </div>

        <div class="season-list">
                 <a class="beach-card" href="<c:url value='/search?keyword=경포대'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Gyeongpodae.jpg'/>" alt="경포대"></div>
              <div class="back"><div class="back-title">경포대</div><div class="back-sub">강원</div></div>
            </div></div>
          </a>
          
          <a class="beach-card" href="<c:url value='/search?keyword=광안리'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Gwangalli.jpg'/>" alt="광안리"></div>
              <div class="back"><div class="back-title">광안리</div><div class="back-sub">부산</div></div>
            </div></div>
          </a>

          <a class="beach-card" href="<c:url value='/search?keyword=비진도'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Beejindo.jpg'/>" alt="비진도"></div>
              <div class="back"><div class="back-title">비진도</div><div class="back-sub">경남</div></div>
            </div></div>
          </a>

          <a class="beach-card" href="<c:url value='/search?keyword=진하'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Jinha.jpg'/>" alt="진하"></div>
              <div class="back"><div class="back-title">진하</div><div class="back-sub">울산</div></div>
            </div></div>
          </a>

          <a class="beach-card" href="<c:url value='/search?keyword=을왕리'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Eurwangri.jpg'/>" alt="을왕리"></div>
              <div class="back"><div class="back-title">을왕리</div><div class="back-sub">인천</div></div>
            </div></div>
          </a>

          <a class="beach-card" href="<c:url value='/search?keyword=영일대'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Yeongildae.jpg'/>" alt="영일대"></div>
              <div class="back"><div class="back-title">영일대</div><div class="back-sub">경북</div></div>
            </div></div>
          </a>
        </div>
      </div>
   

	



      <!-- 겨울 -->
      <div class="season-col">
        <div class="season-title winter">
          <span class="season-ico">❄️</span>
          <span class="season-text">WINTER</span>
          <span class="season-sub">PICKS</span>
        </div>

        <div class="season-list">
        <a class="beach-card" href="<c:url value='/search?keyword=상주은모래'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/SangjuSilverSand.jpg'/>" alt="상주은모래"></div>
              <div class="back"><div class="back-title">상주은모래</div><div class="back-sub">경남</div></div>
            </div></div>
          </a>
        
          <a class="beach-card" href="<c:url value='/search?keyword=송정'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/SongJung.jpg'/>" alt="송정"></div>
              <div class="back"><div class="back-title">송정</div><div class="back-sub">부산</div></div>
            </div></div>
          </a>

          <a class="beach-card" href="<c:url value='/search?keyword=신지명사십리'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Myeongsasimni.jpg'/>" alt="신지명사십리"></div>
              <div class="back"><div class="back-title">신지명사십리</div><div class="back-sub">전남</div></div>
            </div></div>
          </a>

          <a class="beach-card" href="<c:url value='/search?keyword=변산'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Byeonsan.jpg'/>" alt="변산"></div>
              <div class="back"><div class="back-title">변산</div><div class="back-sub">전북</div></div>
            </div></div>
          </a>

          <a class="beach-card" href="<c:url value='/search?keyword=협재'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Hyeopjae.jpg'/>" alt="협재"></div>
              <div class="back"><div class="back-title">협재</div><div class="back-sub">제주</div></div>
            </div></div>
          </a>

          <a class="beach-card" href="<c:url value='/search?keyword=대천'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Daecheon.jpg'/>" alt="대천"></div>
              <div class="back"><div class="back-title">대천</div><div class="back-sub">충남</div></div>
            </div></div>
          </a>
        </div>
      </div>

    </div>
  </section>
  


  <!-- RIGHT -->
  <aside class="home-right" data-aos="fade-left" data-aos-delay="160">
    <div class="right-panels">
    

      <div class="side-box">
        <div class="side-head">
          <h3>📢 공지사항</h3>
          <a class="more" href="<c:url value='/Notice/NoticeList'/>">더보기</a>
        </div>
        <ul class="side-list">
          <li><a href="<c:url value='/Notice/NoticeList'/>">[공지] SEA_YOU 오픈 안내</a></li>
          <li><a href="<c:url value='/Notice/NoticeList'/>">[공지] 신고 처리 기준 안내</a></li>
          <li><a href="<c:url value='/Notice/NoticeList'/>">[공지] 전체채팅 이용 수칙</a></li>
          <li><a href="<c:url value='/Notice/NoticeList'/>">[공지] 마이페이지 업데이트</a></li>
          <li><a href="<c:url value='/Notice/NoticeList'/>">[공지] 서비스 점검 일정</a></li>
        </ul>
      </div>

      <div class="side-box">
        <div class="side-head">
          <h3>📝 게시판</h3>
          <a class="more" href="<c:url value='/Board/BoardList'/>">더보기</a>
        </div>
        <ul class="side-list">
          <li><a href="<c:url value='/Board/BoardList'/>">오늘 바다 진짜 예쁨…</a></li>
          <li><a href="<c:url value='/Board/BoardList'/>">부산 추천 스팟 공유</a></li>
          <li><a href="<c:url value='/Board/BoardList'/>">강원도 당일치기 가능?</a></li>
          <li><a href="<c:url value='/Board/BoardList'/>">혼자 여행 가는 사람?</a></li>
          <li><a href="<c:url value='/Board/BoardList'/>">맛집/카페 추천 부탁</a></li>
        </ul>
      </div>
		
    </div>
  </aside>
<div id="userTopFloating">
  <jsp:include page="/WEB-INF/views/UserTop.jsp" />
</div>
</main>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<!-- 자동완성 -->
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
    if(!$(e.target).closest('form[name=\"search\"]').length) $("#suggestions").hide();
  });
});
</script>

<script>
  AOS.init({ duration: 900, once: true, easing: "ease-out-cubic" });
</script>

</body>
</html>
