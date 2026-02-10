<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SEA_YOU | 회원가입</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600;800&family=Poppins:wght@500;700&display=swap" rel="stylesheet">

<link rel="stylesheet" href="<c:url value='/css/Main.css'/>">
<link rel="stylesheet" href="<c:url value='/css/MemberWriteForm.css'/>">

<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
  function goPopup(){
    window.open("/Member/jusoPopup", "pop", "width=570,height=420,scrollbars=yes,resizable=yes");
  }


  function jusoCallBack(roadFullAddr, zipNo){
    const addrEl = document.getElementById("m_addr") || document.querySelector("[name='m_addr']");
    if(addrEl) addrEl.value = roadFullAddr;


    const zipEl = document.getElementById("m_zip") || document.querySelector("[name='m_zip']");
    if(zipEl) zipEl.value = zipNo;
  }
</script>
</head>

<body>


<div class="bg-wrap">
  <video class="bg-video" autoplay muted playsinline>
    <source src="<c:url value='/video/10.mp4'/>" type="video/mp4">
  </video>
  <div class="bg-overlay"></div>
</div>

<!-- 상단바 -->
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
      <a href="<c:url value='/BookMark/MyBookMarkList'/>">관심 목록</a>
      <div class="dropdown"><div class="title">관심 목록</div></div>
    </div>

    <span class="sep">|</span>

    <div class="menu no-dropdown">
      <a href="<c:url value='/BookMark/MyBookMarkList'/>">찜 목록</a>
      <div class="dropdown"><div class="title">찜 목록</div></div>
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
          <a class="active" href="<c:url value='/Member/MemberWriteForm'/>">회원가입</a>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>


<div class="page">
  <div class="card" data-aos="fade-up" data-aos-duration="900">
    <div class="card-head">
      <h2 class="title">회원가입</h2>
      <p class="sub">SEA_YOU를 시작해볼까요?</p>
    </div>

    <form name="member" class="form" action="/Member/MemberWrite" method="post" enctype="multipart/form-data" onsubmit="return check()">

      <div class="row">
        <label>아이디</label>
        <input type="text" name="m_nick" id="m_nick" placeholder="아이디 입력">
        <input type="button" id="idCheckBtn" value="중복확인" class="file-btn">
      </div>

      <div class="row">
        <label>프로필 사진</label>
        <div class="filebox">
          <input type="file" id="m_file" name="m_file" class="file-input" accept="image/*">
          <div class="fileline">
            <label for="m_file" class="file-btn">파일 선택</label>
            <span class="file-name" id="fileName">선택된 파일 없음</span>
          </div>
          <div class="file-preview">
            <img id="filePreview" alt="preview" style="display:none; width:100px; margin-top:10px;">
          </div>
        </div>
      </div>

      <div class="row">
        <label>비밀번호</label>
        <input type="password" name="m_pw" placeholder="비밀번호 입력">
      </div>

      <div class="row">
        <label>이름</label>
        <input type="text" name="m_name" placeholder="이름 입력">
      </div>

      <div class="row">
        <label>성별</label>
        <div class="radio">
          <label><input type="radio" name="m_sex" value="MAN"> 남</label>
          <label><input type="radio" name="m_sex" value="WOMAN"> 여</label>
        </div>
      </div>

      <div class="row">
        <label>생년월일</label>
        <input type="date" name="m_birth">
      </div>

      <div class="row">
        <label>주소</label>
        <input type="button" value="주소 검색" onclick="goPopup();" class="input-text"><br>
        <input type="text" name="m_addr" id="m_addr" placeholder="도로명 주소" readonly><br>

        <!-- ✅ 우편번호 저장하고 싶으면 사용(없어도 안전 콜백이라 에러 안 남) -->
        <input type="hidden" name="m_zip" id="m_zip">
      </div>

      <div class="row">
        <label>전화번호</label>
        <input type="text" name="m_tel" placeholder="01000000000">
      </div>

      <div class="row">
        <label>이메일</label>
        <input type="text" name="m_email" placeholder="email@example.com">
      </div>

      <div class="actions">
        <input type="submit" class="btn primary" value="회원가입">
        <input type="reset" class="btn ghost" value="다시 쓰기">
      </div>
    </form>
  </div>
</div>


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


<script>
$(function(){
  const MAX_MB = 5; 

  $("#m_file").on("change", function(){
    const file = this.files && this.files[0];

    if(!file){
      $("#fileName").text("선택된 파일 없음");
      $("#filePreview").hide().attr("src","");
      return;
    }

    if(!file.type.startsWith("image/")){
      alert("이미지 파일만 선택할 수 있어요!");
      this.value = "";
      $("#fileName").text("선택된 파일 없음");
      $("#filePreview").hide().attr("src","");
      return;
    }

    const sizeMB = file.size / (1024 * 1024);
    if(sizeMB > MAX_MB){
      alert("이미지 용량이 너무 커요! (" + sizeMB.toFixed(1) + "MB)\n" + MAX_MB + "MB 이하로 올려주세요.");
      this.value = "";
      $("#fileName").text("선택된 파일 없음");
      $("#filePreview").hide().attr("src","");
      return;
    }

    $("#fileName").text(file.name);

    const reader = new FileReader();
    reader.onload = (e) => {
      $("#filePreview").attr("src", e.target.result).show();
    };
    reader.readAsDataURL(file);
  });
});
</script>

<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script src="<c:url value='/js/Member/MemberWriteForm.js'/>"></script>
<script>
  AOS.init({
    duration: 900,
    once: true,
    easing: "ease-out-cubic"
  });
</script>
<footer class="footer">
    <p><b>SEA YOU</b></p>
    <p>© 2026 Sea YOU. All Rights Reserved. | KH 정보교육원 프로젝트</p>
</footer>
</body>
</html>
