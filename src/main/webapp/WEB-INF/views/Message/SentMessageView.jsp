<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보낸 쪽지 상세보기</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600;800&family=Poppins:wght@500;700&display=swap" rel="stylesheet">

<!-- ✅ 공통(메인) -->
<link rel="stylesheet" href="<c:url value='/css/Main.css'/>">
<!-- ✅ 페이지 전용 -->
<link rel="stylesheet" href="<c:url value='/css/SentMessageView.css'/>">

<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>

<!-- ===================== 배경 (메인과 동일) ===================== -->
<div class="bg-wrap">
  <video class="bg-video" autoplay muted loop playsinline>
    <source src="<c:url value='/video/10.mp4'/>" type="video/mp4">
  </video>
  <div class="bg-overlay"></div>
</div>

<!-- ===================== 상단바 (메인 그대로) ===================== -->
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
    </div>

    <span class="sep">|</span>

    <div class="menu no-dropdown">
      <a href="<c:url value='/Notice/NoticeList'/>">공지사항</a>
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
    </div>

    <span class="sep">|</span>

    <a href="/Chat/ChatRoom"
       onclick="window.open(this.href, 'chat', 'width=500, height=700'); return false;">
       전체채팅
    </a>

    <c:if test="${not empty member and member.m_temp eq 'ADMIN'}">
      <span class="sep">|</span>
      <a href="<c:url value='/Report/ReportList'/>">신고 목록</a>
    </c:if>
  </nav>

  <div class="right-tools">

    <form name="search" method="get" action="<c:url value='/search'/>"
          class="search-wrap" autocomplete="off">
      <input type="text" id="keyword" name="keyword"
             class="search-input" placeholder="해수욕장 검색..." autocomplete="off">
      <button type="submit" class="search-btn">검색</button>
      <div id="suggestions"></div>
    </form>

    <div class="auth">
      <c:choose>
        <c:when test="${not empty pageContext.request.userPrincipal}">
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

<!-- ===================== 내용(유리박스) ===================== -->
<div class="page">
  <div class="glass" data-aos="fade-up" data-aos-duration="850">

    <div class="head">
      <h2 class="title">보낸 쪽지 상세보기</h2>
      <div class="actions">
        <a class="btn" href="<c:url value='/Message/SentMessageList'/>">보낸 쪽지함으로</a>
        <a class="btn danger"
           href="<c:url value='/Message/DeleteSentMessage?ms_no=${dto.ms_no}&type=sent'/>"
           onclick="return confirm('이 쪽지를 삭제할까요?');">삭제</a>
      </div>
    </div>

    <table class="msg-table">
      <tr>
        <th>받는 사람</th>
        <td>${dto.recv_nick}</td>
      </tr>
      <tr>
        <th>날짜</th>
        <td>${dto.ms_date}</td>
      </tr>
      <tr>
        <th>내용</th>
        <td class="content">${dto.ms_content}</td>
      </tr>
    </table>

  </div>
</div>

<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
  AOS.init({ duration: 900, once: true, easing: "ease-out-cubic" });
</script>

</body>
</html>
