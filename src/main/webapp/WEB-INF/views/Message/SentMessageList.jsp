<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보낸 쪽지함</title>
<link rel="stylesheet" href="<c:url value='/css/Main.css'/>">
<link rel="stylesheet" href="<c:url value='/css/SentMessageList.css'/>">
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
      <a href="<c:url value='/Member/MemberAllView'/>">회원목록</a>
    </div>
    <span class="sep">|</span>
    <div class="menu no-dropdown">
      <a href="<c:url value='/BookMark/MyBookMarkList'/>">찜 목록</a>
    </div> 
    <span class="sep">|</span>
    <a href="/Chat/ChatRoom" onclick="window.open(this.href, 'chat', 'width=500, height=700'); return false;">전체채팅</a>
    <c:if test="${not empty member and member.m_temp eq 'ADMIN'}">
      <span class="sep">|</span>
      <a href="<c:url value='/Member/MemberList'/>">회원 관리</a>
      <a href="/Report/ReportList">신고 목록</a>
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

<main class="msg-main">
  <div class="msg-head">
    <h2 class="msg-title">보낸 쪽지함</h2>
  </div>

  <div class="msg-card">
    <table class="msg-table">
      <thead>
        <tr>
          <th width="25%">받는 사람</th>
          <th width="50%">내용</th>
          <th width="25%">날짜</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${list}" var="dto">
          <tr>
            <td class="msg-user-td">
              <a href="<c:url value='/Member/MemberView?m_no=${dto.recv_m_no}'/>" class="user-link">
                <div class="user-avatar">
                  <img src="<c:url value='/m_images/${dto.recv_image}'/>" 
                       onerror="this.onerror=null; this.src='<c:url value='/images/common/default_profile.png'/>';"/>
                </div>
                <span class="user-nick">${dto.recv_nick}</span>
              </a>
            </td>
            <td>
              <a class="title-link" href="/Message/SentMessageView?ms_no=${dto.ms_no}">${dto.ms_content}</a>
            </td>
            <td class="msg-date">
              <fmt:formatDate value="${dto.ms_date}" pattern="yyyy년 MM월 dd일 HH:mm"/>
            </td>
          </tr>
        </c:forEach>
        <c:if test="${empty list}">
          <tr>
            <td class="empty" colspan="3">보낸 쪽지가 없습니다.</td>
          </tr>
        </c:if>
      </tbody>
    </table>
  </div>

  <a class="btn-home" href="<c:url value='/'/>">홈으로</a>
</main>

<footer class="footer">
    <p><b>SEA YOU</b></p>
    <p>© 2026 Sea YOU. All Rights Reserved. | KH 정보교육원 프로젝트</p>
</footer>

</body>
</html>