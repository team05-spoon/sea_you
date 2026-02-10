<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SEA_YOU - 검색결과</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600;800&family=Poppins:wght@500;700&display=swap" rel="stylesheet">

<link rel="stylesheet" href="<c:url value='/css/Main.css'/>">
<link rel="stylesheet" href="<c:url value='/css/SearchList.css?v=1'/>">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="<c:url value='/js/SearchList.js'/>"></script>
<jsp:include page="/WEB-INF/views/Message/MessageAlert.jsp" />

<style>
  .beach-thumb {
    width: 120px !important;
    height: 80px !important;
    object-fit: cover;    
    border-radius: 8px;   
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
  }
  .col-img { width: 140px; text-align: center; }
</style>
</head>

<body>

<div class="bg-wrap">
  <video class="bg-video" autoplay muted loop playsinline>
    <source src="<c:url value='/video/10.mp4'/>" type="video/mp4">
  </video>
  <div class="bg-overlay"></div>
</div>

<div class="top">
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
      <input type="text" id="keyword" name="keyword" class="search-input" placeholder="해수욕장 검색..." value="${keyword}">
      <button type="submit" class="search-btn">검색</button>
      <div id="suggestions"></div>
    </form>
    <div class="auth">
      <c:choose>
        <c:when test="${not empty pageContext.request.userPrincipal}">
          <a class="profile-link" href="<c:url value='/Member/MemberView?m_no=${member.m_no}'/>">
            <img class="profile-img" src="<c:url value='/m_images/${member.m_image}'/>" onerror="this.src='<c:url value='/images/common/default_profile.png'/>';"/>
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

<div class="page-wrap">
  <div class="page-card">
    <div class="page-head">
      <h1>해수욕장 검색 결과</h1>
      <p class="meta">키워드: <strong>${keyword}</strong> · 총 <strong>${count}</strong>건</p>
    </div>

    <c:choose>
      <c:when test="${not empty searchList}">
        <div class="table-wrap">
          <table class="result-table">
            <thead>
              <tr>
                <th>이미지</th>
                <th>이름</th>
                <th>위치</th>
                <th>관리기관</th>
                <th>관심등록</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="beach" items="${searchList}">
                <tr>
                  <td class="col-img">
                    <c:choose>
                      <c:when test="${not empty beach.bc_image}">
                        <img src="${pageContext.request.contextPath}/images/bc_images/${beach.bc_image}" 
                             class="beach-thumb" 
                             alt="${beach.bc_name}"
                             onerror="this.src='https://via.placeholder.com/120x80?text=No+Image'">
                      </c:when>
                      <c:otherwise>
                        <img src="https://via.placeholder.com/120x80?text=No+Image" class="beach-thumb">
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td class="col-name">
                    <a class="beach-link" href="/Beach/BeachDetail?bc_no=${beach.bc_no}">
                      ${beach.bc_name}
                    </a>
                  </td>
                  <td>${beach.bc_location}</td>
                  <td>${beach.bc_office}</td>
                  <td class="col-bm">
                    <button type="button" class="btn-bookmark" data-bcno="${beach.bc_no}">
                      <c:choose>
                        <c:when test="${not empty myBookmarkIds and fn:contains(myBookmarkIds, beach.bc_no)}">❤️ 찜취소</c:when>
                        <c:otherwise>🤍 찜하기</c:otherwise>
                      </c:choose>
                    </button>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </c:when>
      <c:otherwise>
        <div class="empty">검색된 해수욕장이 없습니다.</div>
      </c:otherwise>
    </c:choose>

    <div class="page-foot">
      <a class="btn-back" href="<c:url value='/'/>">메인으로 돌아가기</a>
    </div>
  </div>
</div>

<input type="hidden" id="session-m-id" value="${m_id}">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" id="csrf-token">
<footer class="footer">
    <p><b>SEA YOU</b></p>
    <p>© 2026 Sea YOU. All Rights Reserved. | KH 정보교육원 프로젝트</p>
</footer>
</body>
</html>