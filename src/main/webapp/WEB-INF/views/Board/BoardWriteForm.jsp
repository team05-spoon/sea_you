<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새 글 작성</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600;800&family=Poppins:wght@500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/BoardWriteForm.css">
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/js/Board/BoardWriteForm.js?v=1.1"></script>
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
      <div class="dropdown">
        <div class="title">게시판</div>
      </div>
    </div>
    <span class="sep">|</span>
    <div class="menu no-dropdown">
      <a href="<c:url value='/Notice/NoticeList'/>">공지사항</a>
      <div class="dropdown">
        <div class="title">공지사항</div>
      </div>
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
      <div class="dropdown">
        <div class="title">회원목록</div>
      </div>
    </div>
    
      <span class="sep">|</span>
    <div class="menu no-dropdown">
      <a href="<c:url value='/BookMark/MyBookMarkList'/>">찜 목록</a>
      <div class="dropdown">
        <div class="title">찜</div>
      </div>
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

<main class="board-write-main">
  <div class="board-head">
    <h2 class="board-title">새 글 작성</h2>
  </div>

  <div class="board-card">
    <form class="write-form"
          name="BoardWriteForm"
          action="${pageContext.request.contextPath}/Board/BoardWrite"
          method="post"
          enctype="multipart/form-data"
          onsubmit="return boardCheck();">

      <div class="field">
        <label class="label">제목</label>
        <input class="input" name="b_title" placeholder="제목을 입력하세요" maxlength="100" />
      </div>

      <div class="field">
        <label class="label">내용</label>
        <textarea class="textarea" name="b_memo" placeholder="내용을 입력하세요"></textarea>
      </div>

<div class="field">
  <label class="label">이미지 업로드</label>
  
  <div id="previewContainer" style="margin-bottom: 15px; display: none;">
    <img id="previewImg" src="" alt="미리보기" 
         style="width: 120px; height: 120px; object-fit: cover; border-radius: 12px; border: 1px solid rgba(255,255,255,0.2); box-shadow: 0 4px 15px rgba(0,0,0,0.3);">
  </div>

  <div class="file-upload-row" style="display: flex; align-items: center; gap: 15px;">
    <label for="b_image" class="btn-file-custom">
      📸 사진 선택하기   
    </label>
    <span id="fileName" class="file-name-display">선택된 파일 없음</span>
    
    <input type="file" id="b_image" name="b_image" accept="image/*" class="input-file-hidden" />
  </div>
</div>

      <div class="btn-row">
        <a class="btn-cancel" href="${pageContext.request.contextPath}/Board/BoardList">목록으로</a>
        <button class="btn-submit" type="submit">등록하기</button>
      </div>
    </form>
  </div>
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
<script>AOS.init({ duration: 900, once: true, easing: "ease-out-cubic" });</script>
<footer class="footer">
    <p><b>SEA YOU</b></p>
    <p>© 2026 Sea YOU. All Rights Reserved. | KH 정보교육원 프로젝트</p>
</footer>
</body>
</html>
