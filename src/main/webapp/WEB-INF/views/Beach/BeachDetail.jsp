<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>${beach.bc_name} 상세 정보</title>

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600;800&family=Poppins:wght@500;700&display=swap" rel="stylesheet">

  <!-- ✅ 공통(메인) -->
  <link rel="stylesheet" href="<c:url value='/css/Main.css'/>">
  <!-- ✅ 페이지 전용 -->
  <link rel="stylesheet" href="<c:url value='/css/BeachDetail.css'/>">

  <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <!-- ✅ 페이지 JS -->
  <script src="<c:url value='/js/Beach/BeachDetail.js'/>"></script>
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c85c508a36fffdab310feced3d60ccbc&libraries=services&autoload=false"></script>
</head>

<body>
<input type="hidden" id="csrf-token" name="${_csrf.parameterName}" value="${_csrf.token}">

<!-- 배경 (메인과 동일) -->
<div class="bg-wrap">
  <video class="bg-video" autoplay muted loop playsinline>
    <source src="<c:url value='/video/10.mp4'/>" type="video/mp4">
  </video>
  <div class="bg-overlay"></div>
</div>

<!-- ✅ 상단바(메인과 동일) -->
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

<!-- ✅ 상세 페이지 내용 (투명 카드) -->
<div class="page">
  <div class="glass" data-aos="fade-up" data-aos-duration="850">

    <div class="detail-head">
      <h2 class="detail-title">${beach.bc_name} 상세 페이지</h2>

      <button id="bookMarkBtn" class="btn-heart" data-bcno="${beach.bc_no}">
        <c:choose>
          <c:when test="${isBookMarked > 0}">❤️ 찜취소</c:when>
          <c:otherwise>🤍 찜하기</c:otherwise>
        </c:choose>
      </button>
    </div>
	
    <div class="detail-main-image" style="width: 100%; margin-bottom: 30px; text-align: center;">
      <c:choose>
        <c:when test="${not empty beach.bc_image}">
          <img src="<c:url value='/images/bc_images/${beach.bc_image}'/>" 
               alt="${beach.bc_name}"
               style="width: 100%; max-width: 900px; height: auto; border-radius: 15px; box-shadow: 0 8px 20px rgba(0,0,0,0.3);">
        </c:when>
        <c:otherwise>
          <img src="https://via.placeholder.com/900x450?text=No+Image" 
               style="width: 100%; max-width: 900px; height: auto; border-radius: 15px;">
        </c:otherwise>
      </c:choose>
    </div>

    <div class="detail-body">
      <table class="detail-table">
        <tr><th>위치</th><td>${beach.bc_location}</td></tr>
        <tr><th>관리청</th><td>${beach.bc_office}</td></tr>
        <tr><th>백사장 길이</th><td>${beach.bc_length}m</td></tr>
      </table>
    </div>
	<div class="map-section" style="margin: 40px 20px 20px 20px; padding-top: 20px; border-top: 1px solid rgba(255,255,255,0.2);">
        <h3 style="color: #fff; margin-bottom: 15px;">📍 위치 안내</h3>
        <div id="map" style="width:100%; height:400px; border-radius:15px; box-shadow: 0 4px 15px rgba(0,0,0,0.2);"></div>
    </div>
    <div style="text-align: center; margin-top: 30px;">
        <a href="javascript:history.back()" style="color: #fff; text-decoration: none; border: 1px solid rgba(255,255,255,0.5); padding: 10px 25px; border-radius: 30px; background: rgba(255,255,255,0.1);">이전으로</a>
    </div>

  </div>
</div>

<!-- ✅ 자동완성 (메인과 동일) -->
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
<jsp:include page="/WEB-INF/views/Message/MessageAlert.jsp" />
<script>
  AOS.init({ duration: 900, once: true, easing: "ease-out-cubic" });
</script>
<script>
kakao.maps.load(function() {
    var mapContainer = document.getElementById('map'); 
    var beachName = "${beach.bc_name}";
    var addr1 = "${beach.bc_location}";
    
    var searchQuery = addr1 + " " + beachName + " 해수욕장";

    var mapOption = {
        center: new kakao.maps.LatLng(35.1587, 129.1603), 
        level: 4 
    };  

    var map = new kakao.maps.Map(mapContainer, mapOption); 
    var ps = new kakao.maps.services.Places(); 

    ps.keywordSearch(searchQuery, function(data, status) {
        if (status === kakao.maps.services.Status.OK) {
            var coords = new kakao.maps.LatLng(data[0].y, data[0].x);
            applyMap(map, coords, beachName);
        } else {
            ps.keywordSearch(beachName + " 해수욕장", function(data2, status2) {
                if (status2 === kakao.maps.services.Status.OK) {
                    var coords2 = new kakao.maps.LatLng(data2[0].y, data2[0].x);
                    applyMap(map, coords2, beachName);
                }
            });
        }
    });

    function applyMap(map, coords, name) {
        var marker = new kakao.maps.Marker({ map: map, position: coords });
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;font-size:12px;color:#000;font-weight:bold;">' + name + '</div>'
        });
        infowindow.open(map, marker);
        map.setCenter(coords);
        
        setTimeout(function(){ 
            map.relayout(); 
            map.setCenter(coords);
        }, 300);
    }
});
</script>
<footer class="footer">
    <p><b>SEA YOU</b></p>
    <p>© 2026 Sea YOU. All Rights Reserved. | KH 정보교육원 프로젝트</p>
</footer>
</body>
</html>
