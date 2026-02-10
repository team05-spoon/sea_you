<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="ko_KR"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${view.m_nick}님의 프로필</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600;800&family=Poppins:wght@500;700&display=swap" rel="stylesheet">

<link rel="stylesheet" href="<c:url value='/css/Main.css'/>">
<link rel="stylesheet" href="<c:url value='/css/MemberView.css'/>">
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
    <form name="search" method="get" action="<c:url value='/search'/>"
          class="search-wrap" autocomplete="off" style="position:relative;">
      <input type="text" id="keyword" name="keyword" class="search-input"
             placeholder="해수욕장 검색..." autocomplete="off">
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


<main class="member-main" data-aos="fade-up" data-aos-duration="900">

  <div class="member-head">
    <h2 class="member-title">회원 상세보기</h2>
  </div>

  <div class="member-card">

    <div class="card-top">
      <div class="card-top-left">
        <div class="card-title">프로필</div>
        <div class="card-sub">${view.m_nick} 님</div>
      </div>

<div class="follow-pill">
        <a href="<c:url value='/Member/MyFollowList?type=follower&m_no=${view.m_no}'/>" class="pill follow-link" style="text-decoration: none; color: inherit;">
          <span class="pill-label">팔로워</span>
          <strong id="followerCount">${followerCount}</strong>
        </a>

        <span class="sep" style="margin: 0 5px; opacity: 0.2; color: white;">|</span>

        <a href="<c:url value='/Member/MyFollowList?type=following&m_no=${view.m_no}'/>" class="pill follow-link" style="text-decoration: none; color: inherit;">
          <span class="pill-label">팔로잉</span>
          <strong id="followingCount">${followingCount}</strong>
        </a>
      </div>
    </div>

    <div class="card-body">
      <div class="profile-grid">

        <div class="photo-cell">
          <img class="member-photo"
               src="<c:url value='/m_images/${view.m_image}'/>"
               onerror="this.onerror=null; this.src='<c:url value='/images/common/default_profile.png'/>';"/>
        </div>

        <div class="info">
          <div class="row">
            <div class="label">회원 닉네임</div>
            <div class="value">${view.m_nick}</div>
          </div>

          <div class="row">
            <div class="label">이름</div>
            <div class="value">${view.m_name}</div>
          </div>

          <div class="row">
            <div class="label">성별</div>
            <div class="value">${view.m_sex}</div>
          </div>

          <div class="row">
            <div class="label">생일</div>
            <div class="value">
              <fmt:formatDate value="${view.m_birth}" pattern="yyyy년 MM월 dd일 (E)"/>
            </div>
          </div>
        </div>

      </div>

      <c:if test="${not empty member and (member.m_no == view.m_no or member.m_temp == 'ADMIN')}">
        <div class="section-head">상세 정보</div>
        <div class="detail-box">
          <div class="row"><div class="label">이메일</div><div class="value">${view.m_email}</div></div>
          <div class="row"><div class="label">주소</div><div class="value">${view.m_addr}</div></div>
          <div class="row"><div class="label">전화번호</div><div class="value">${view.m_tel}</div></div>
        </div>
      </c:if>

      <div class="member-actions">
        <c:choose>
          <c:when test="${not empty member and member.m_no == view.m_no}">
            <a class="btn" href="<c:url value='/Member/MemberUpdateForm?m_no=${view.m_no}'/>">정보 수정</a>
            <a class="btn danger" href="<c:url value='/Member/MemberDeleteForm?m_no=${view.m_no}'/>">회원 탈퇴</a>
          </c:when>
          <c:otherwise>
            <c:if test="${not empty member}">
              <button type="button" id="followBtn"
                      class="btn ${isFollowing ? 'unfollow-style' : 'follow-style'}"
                      onclick="toggleFollow(${view.m_no})">
                ${isFollowing ? '언팔로우' : '팔로우'}
              </button>
            </c:if>

            <a class="btn" href="<c:url value='/Message/MessageWriteForm?recv_nick=${view.m_nick}'/>">쪽지보내기</a>

            <c:if test="${not empty member and member.m_no != view.m_no}">
              <a class="btn ghost" href="<c:url value='/Report/ReportMemberWriteForm?target_m_no=${view.m_no}'/>">신고하기</a>
            </c:if>
          </c:otherwise>
        </c:choose>

        <a class="btn ghost back-right" href="javascript:history.back()">뒤로가기</a>
      </div>

    </div>
  </div>
 <div class="member-card" style="margin-top: 40px;">
  <div class="member-head">
  </div>
  
  <div class="post-grid">
    <c:choose>
      <c:when test="${not empty myBoardList}">
        <c:forEach var="post" items="${myBoardList}">
          <a href="<c:url value='/Board/BoardDetail?b_no=${post.b_no}'/>" class="post-item">
            <c:choose>
              <c:when test="${not empty post.b_image}">
                <img src="<c:url value='/images/b_images/${post.b_image}'/>" alt="게시글 이미지">
              </c:when>
              <c:otherwise>
                <img src="<c:url value='/images/Logo/웨일리.png'/>" alt="기본 이미지" class="default-img">
              </c:otherwise>
            </c:choose>
            <div class="post-overlay">
              <span class="post-title">${post.b_title}</span>
            </div>
          </a>
        </c:forEach>	
      </c:when>
      <c:otherwise>
        <div class="empty">작성한 게시글이 없습니다.</div>
      </c:otherwise>
    </c:choose>
  </div>
</div>
</main>

<script>
function toggleFollow(targetNo) {
  $.ajax({
    url: "<c:url value='/Member/toggleFollow'/>",
    type: "POST",
    data: { target_m_no: targetNo },
    success: function(res) {
      if (res.status === "followed") {
        $("#followBtn").text("언팔로우")
          .addClass("unfollow-style").removeClass("follow-style");
        let count = parseInt($("#followerCount").text(), 10) || 0;
        $("#followerCount").text(count + 1);
      } else if (res.status === "unfollowed") {
        $("#followBtn").text("팔로우")
          .addClass("follow-style").removeClass("unfollow-style");
        let count = parseInt($("#followerCount").text(), 10) || 0;
        $("#followerCount").text(Math.max(0, count - 1));
      } else if (res.status === "error") {
        alert(res.message || "처리 중 오류가 발생했습니다.");
      }
    },
    error: function() {
      alert("로그인이 필요하거나 오류가 발생했습니다.");
    }
  });
}

/** 자동완성 */
$(document).ready(function(){
  $("#keyword").on("keyup", function(){
    let q = $(this).val();
    if(!q || q.length < 1){ $("#suggestions").hide(); return; }

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
      },
      error: function(){
        $("#suggestions").hide();
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
  if (window.AOS) {
    AOS.init({ duration: 900, once: true, easing: "ease-out-cubic" });
  }
</script>
<footer class="footer">
    <p><b>SEA YOU</b></p>
    <p>© 2026 Sea YOU. All Rights Reserved. | KH 정보교육원 프로젝트</p>
</footer>
</body>
</html>
