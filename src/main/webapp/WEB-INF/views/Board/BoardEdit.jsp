<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SEA_YOU - 게시글 수정</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600;800&family=Poppins:wght@500;700&display=swap" rel="stylesheet">

<link rel="stylesheet" href="<c:url value='/css/Main.css'/>">
<link rel="stylesheet" href="<c:url value='/css/BoardEdit.css'/>">

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


<main class="be-main" data-aos="fade-up" data-aos-duration="900">
  <section class="be-card">
    <header class="be-head">
      <h2 class="be-title">게시글 수정</h2>
      <p class="be-sub">내용을 수정한 뒤 저장을 눌러주세요.</p>
    </header>

    <form class="be-form"
          name="editForm"
          action="${pageContext.request.contextPath}/Board/BoardEdit"
          method="post"
          enctype="multipart/form-data" 
          onsubmit="return editCheck()">

      <input type="hidden" name="b_no" value="${dto.b_no}"/>

      <div class="be-row">
        <label class="be-label">제목</label>
        <input class="be-input" name="b_title" value="${dto.b_title}" maxlength="100" required />
      </div>

      <div class="be-row">
        <label class="be-label">작성자</label>
        <div class="be-static">${dto.b_write}</div>
      </div>

      <div class="be-row">
        <label class="be-label">내용</label>
        <textarea class="be-textarea" name="b_memo" required>${dto.b_memo}</textarea>
      </div>


<div class="be-row">
  <label class="be-label">이미지 변경</label>
  
  <div class="upload-content-wrap"> <div class="be-image-preview">
      <c:if test="${not empty dto.b_image}">
        <img id="previewImg" src="<c:url value='/images/b_images/${dto.b_image}'/>" class="be-image-preview-img" />
      </c:if>
    </div>
    
    <div class="file-upload-row">
      <label for="b_image" class="btn-file-custom">📸 사진 선택하기</label>
      <span id="fileName" class="file-name-display">변경할 사진 선택...</span>
      <input type="file" id="b_image" name="b_image" accept="image/*" class="input-file-hidden" />
    </div>
  </div>
</div>

      <div class="be-actions">
        <button type="submit" class="btn-primary">수정 완료</button>
        <a class="btn-ghost" href="${pageContext.request.contextPath}/Board/BoardDetail?b_no=${dto.b_no}">
          취소하고 돌아가기
        </a>
      </div>
    </form>
  </section>
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
  $("#b_image").on("change", function() {
    const file = this.files[0];
    const fileName = $(this).val().split("\\").pop();
    if(fileName) {
      $("#fileName").text(fileName).css("color", "#fff");

      const reader = new FileReader();
      reader.onload = function(e) {
        $("#previewImg").attr("src", e.target.result).show();
      }
      reader.readAsDataURL(file);
    } else {
      $("#fileName").text("변경할 사진을 선택하세요").css("color", "rgba(255,255,255,0.6)");
    }
  });
});
function editCheck() {
    const title = document.editForm.b_title.value.trim();
    const memo = document.editForm.b_memo.value.trim();

    if (title == "") {
        alert("제목을 입력해주세요.");
        document.editForm.b_title.focus();
        return false;
    }
    if (memo == "") {
        alert("내용을 입력해주세요.");
        document.editForm.b_memo.focus();
        return false;
    }
    if (!confirm("수정된 내용을 저장하시겠습니까?")) {
        return false;
    }
    return true;
}
</script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>AOS.init({ duration: 900, once: true, easing: "ease-out-cubic" });</script>
<footer class="footer">
    <p><b>SEA YOU</b></p>
    <p>© 2026 Sea YOU. All Rights Reserved. | KH 정보교육원 프로젝트</p>
</footer>
</body>
</html>

