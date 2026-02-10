<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.sea_you.dto.ReportBoardDTO" %>
<%@ page import="com.sea_you.dto.BoardDTO" %>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd (E)");
    ReportBoardDTO bdto = (ReportBoardDTO) request.getAttribute("dto");
    BoardDTO boarddto = (BoardDTO) request.getAttribute("boarddto");
    
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
<link rel="stylesheet" href="<c:url value='/css/ReportBoardDetail.css'/>">
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<jsp:include page="/WEB-INF/views/Message/MessageAlert.jsp" />
</head>

<body>

<div class="bg-wrap">
  <video class="bg-video" autoplay muted playsinline>
    <source src="<c:url value='/video/10.mp4'/>" type="video/mp4">
  </video>
   <div class="whaley-float" aria-hidden="true">
     <img src="<c:url value='/images/Logo/웨일리.png'/>" alt="웨일리" class="whaley-float__img">
   </div>
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

    <div class="main-search-wrap nav-search ${member.m_temp eq 'ADMIN' ? 'admin-nav' : ''}">
      <form name="search" method="get" action="<c:url value='/search'/>"
            class="search-wrap main-search" autocomplete="off">
        <input type="text" id="keyword" name="keyword" class="search-input"
               placeholder="해수욕장 검색..." autocomplete="off">
        <button type="submit" class="search-btn">검색</button>
        <div id="suggestions"></div>
      </form>
    </div>

  </nav>

<div class="right-tools">
    <div class="auth">
      <c:choose>
        <c:when test="${not empty pageContext.request.userPrincipal}">
          <a class="profile-link" href="<c:url value='/Member/MemberView?m_no=${member.m_no}'/>">
            <img class="profile-img"
                 src="<c:url value='/m_images/${member.m_image}'/>"
                 alt="profile"
                 onerror="this.onerror=null; this.src='<c:url value='/m_images/default_profile.png'/>';"/>
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

<main class="rbd-main" data-aos="fade-up" data-aos-duration="850">
  <section class="rbd-card">

    <header class="rbd-head">
      <h2 class="rbd-title"><%= bdto.getRb_title() %></h2>
      <div class="rbd-meta">
        작성일:
        <span><%= (bdto.getRb_date() != null ? sdf.format(bdto.getRb_date()) : "날짜 없음") %></span>
        <span class="dot">•</span>
        대상 게시글 번호: <b><%= bdto.getRb_bno() %></b>
      </div>
    </header>

    <article class="rbd-body">
      <div class="rbd-label">[신고 사유 내용]</div>
      <div class="rbd-content"><%= bdto.getRb_content() %></div>
    </article>

    <div class="divider"></div>
    
    <section class="original-post-preview">
      <h3>🚩 신고 대상 원본 게시글 정보</h3>
      
      <% if (boarddto != null) { %>
        <div class="post-info">
          <p><strong>제목:</strong> <%= boarddto.getB_title() %></p>
          <p><strong>작성자:</strong> <%= boarddto.getB_write() %></p>
          
          <div class="post-content"><%= boarddto.getB_memo() %></div>

          <%-- 이미지 출력 영역 --%>
<% if (boarddto != null && boarddto.getB_image() != null && !boarddto.getB_image().isEmpty()) { %>
  <div class="post-image-wrap">
    <div class="rbd-label">[원본 첨부 이미지]</div>
    <img src="${pageContext.request.contextPath}/images/b_images/<%= boarddto.getB_image() %>" 
         alt="원본 게시글 이미지" 
         class="original-img"
         onerror="this.parentElement.style.display='none';">
  </div>
<% } %>
        </div>
      <% } else { %>
        <div class="error-msg" style="text-align: center; padding: 20px;">
          <p style="color: #ff4d4f; font-weight: bold;">⚠️ 원본 게시글 정보를 불러올 수 없습니다.</p>
          <p style="color: rgba(255,255,255,0.5); font-size: 0.9em;">게시글 번호(<%= bdto.getRb_bno() %>)가 이미 삭제되었거나 유효하지 않습니다.</p>
        </div>
      <% } %>
    </section>

    <div class="rbd-actions">
      <a class="btn-ghost" href="<%= request.getContextPath() %>/Report/ReportList">목록으로</a>

      <% if (boarddto != null) { %>
      <form class="inline-form"
            action="${pageContext.request.contextPath}/Report/DeleteOriginalBoard"
            method="post"
            onsubmit="return confirm('원본 게시글을 삭제하면 되돌릴 수 없습니다. 정말 삭제하시겠습니까?');">
        <input type="hidden" name="b_no" value="<%= bdto.getRb_bno() %>">
        <input type="hidden" name="rb_no" value="<%= bdto.getRb_no() %>">
        <button type="submit" class="btn-danger">
          원본 게시글 삭제
        </button>
      </form>
      <% } %>
    </div>

  </section>
</main>

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