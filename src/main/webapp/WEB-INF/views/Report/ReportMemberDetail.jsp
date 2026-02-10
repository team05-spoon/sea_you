<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.sea_you.dto.ReportMemberDTO" %>
<%@ page import="com.sea_you.dto.MemberDTO" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd (E)");
    ReportMemberDTO bdto = (ReportMemberDTO) request.getAttribute("dto");
    // 컨트롤러에서 넘겨준 신고 대상자 데이터
    MemberDTO memberdto = (MemberDTO) request.getAttribute("memberdto");

    if (bdto == null) {
        response.sendRedirect(request.getContextPath() + "/Report/ReportList");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고 상세내용</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600;800&family=Poppins:wght@500;700&display=swap" rel="stylesheet">

<link rel="stylesheet" href="<c:url value='/css/Main.css'/>">
<link rel="stylesheet" href="<c:url value='/css/ReportMemberView.css'/>">
<link rel="stylesheet" href="<c:url value='/css/AdminMemberView.css?v=1'/>">

<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<jsp:include page="/WEB-INF/views/Message/MessageAlert.jsp" />

<style>
  /* 신고 페이지 내에서 회원 카드가 자연스럽게 보이도록 간격 조정 */
  .admin-wrap { padding: 0; min-height: auto; margin-top: 30px; }
  .admin-card { margin: 0; background: rgba(0,0,0,0.2); border: 1px solid rgba(255,255,255,0.1); }
  .divider-line { border-top: 1px dashed rgba(255,255,255,0.2); margin: 40px 0; }
</style>
</head>

<body>

<div class="bg-wrap">
  <video class="bg-video" autoplay muted loop playsinline>
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
    <div class="menu no-dropdown"><a href="<c:url value='/Board/BoardList'/>">게시판</a></div>
    <span class="sep">|</span>
    <div class="menu no-dropdown"><a href="<c:url value='/Notice/NoticeList'/>">공지사항</a></div>
    <span class="sep">|</span>
    <div class="menu"><a href="<c:url value='/Message/RecvMessageList'/>">쪽지함</a></div>
    <span class="sep">|</span>
    <div class="menu no-dropdown"><a href="<c:url value='/Member/MemberAllView'/>">회원목록</a></div>
    <span class="sep">|</span>
    <div class="menu no-dropdown"><a href="<c:url value='/BookMark/MyBookMarkList'/>">찜 목록</a></div>
    <span class="sep">|</span>
    <a href="/Chat/ChatRoom" onclick="window.open(this.href, 'chat', 'width=500, height=700'); return false;">소통</a>

    <c:if test="${not empty member and member.m_temp eq 'ADMIN'}">
      <span class="sep">|</span>
      <a href="<c:url value='/Member/MemberList'/>">회원 관리</a>
      <span class="sep">|</span>
      <a href="/Report/ReportList">신고 목록</a>
    </c:if>
  </nav>

  <div class="right-tools">
    <form name="search" method="get" action="<c:url value='/search'/>" class="search-wrap">
      <input type="text" id="keyword" name="keyword" class="search-input" placeholder="해수욕장 검색...">
      <button type="submit" class="search-btn">검색</button>
      <div id="suggestions"></div>
    </form>
    <div class="auth">
      <c:choose>
        <c:when test="${not empty member}">
          <a class="profile-link" href="<c:url value='/Member/MemberView?m_no=${member.m_no}'/>">
            <img class="profile-img" src="<c:url value='/m_images/${member.m_image}'/>" onerror="this.src='<c:url value='/m_images/default_profile.png'/>';"/>
          </a>
          <a href="<c:url value='/logout'/>">로그아웃</a>
        </c:when>
        <c:otherwise>
          <a href="<c:url value='/Member/MemberLoginForm'/>">로그인</a>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>

<div class="page">
  <div class="glass" data-aos="fade-up" data-aos-duration="850">

    <div class="head">
      <div class="badge">REPORT</div>
      <h2 class="title"><%= bdto.getRm_title() %></h2>
      <div class="meta">
        <div><span>신고 대상자</span> <b>${dto.rm_nick}</b></div>
        <div><span>작성일</span> <%= (bdto.getRm_date() != null ? sdf.format(bdto.getRm_date()) : "") %></div>
      </div>
    </div>

    <div class="content">
      <%= bdto.getRm_content() %>
    </div>

    <div class="divider-line"></div>
    <div class="admin-wrap">
      <div class="admin-card">
        <div class="admin-head">
          <h2 style="color: #ff4d4f;">신고 대상자 상세정보</h2>
          <p class="sub">관리자용 회원 정보 대조</p>
        </div>

        <c:if test="${not empty memberdto}">
          <div class="profile-row">
            <div class="avatar">
              <img src="${pageContext.request.contextPath}/m_images/${memberdto.m_image}"
                   alt="프로필"
                   onerror="this.onerror=null; this.src='<c:url value='/images/common/default_profile.png'/>';">
            </div>
            <div class="mini">
              <div class="pill">회원번호 <b>${memberdto.m_no}</b></div>
              <div class="pill">닉네임 <b>${memberdto.m_nick}</b></div>
              <div class="pill">이름 <b>${memberdto.m_name}</b></div>
            </div>
          </div>

          <div class="info-grid">
            <div class="info-item">
              <div class="k">성별</div>
              <div class="v">${memberdto.m_sex}</div>
            </div>
            <div class="info-item">
			  <div class="k">생일</div>
			  <div class="v">
			    <fmt:formatDate value="${memberdto.m_birth}" pattern="yyyy년 MM월 dd일" />
			  </div>
			</div>
			  <div class="info-item">
              <div class="k">이메일</div>
              <div class="v">${memberdto.m_email}</div>
            </div>
            <div class="info-item">
              <div class="k">전화번호</div>
              <div class="v">${memberdto.m_tel}</div>
            </div>
            <div class="info-item full">
              <div class="k">주소</div>
              <div class="v">${memberdto.m_addr}</div>
            </div>
          </div>
        </c:if>
        <c:if test="${empty memberdto}">
          <p style="text-align: center; color: #888; padding: 30px;">정보를 찾을 수 없는 회원입니다.</p>
        </c:if>
      </div>
    </div>
    <div class="actions">
      <a class="btn" href="<c:url value='/Report/ReportList'/>">목록으로</a>

      <form action="<c:url value='/Report/DeleteMemberReport'/>" method="post"
            onsubmit="return confirm('이 회원과 신고 내역을 모두 삭제하시겠습니까?');">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input type="hidden" name="m_nick" value="${dto.rm_nick}">
        <input type="hidden" name="rm_no" value="${dto.rm_no}">
        <button class="btn danger" type="submit">회원 강제 탈퇴 및 신고 삭제</button>
      </form>
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