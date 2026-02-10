<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SEA_YOU 메인</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600;800&family=Poppins:wght@500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<c:url value='/css/Main.css'/>">
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<jsp:include page="/WEB-INF/views/Message/MessageAlert.jsp" />
<style>
  .main-popup {
      position: fixed;
      width: 320px; 
      background: #fff;
      border-radius: 12px;
      box-shadow: 0 15px 35px rgba(0,0,0,0.3);
      z-index: 10001; 
      overflow: hidden;
  }
  .popup-content img { width: 100%; display: block; border-bottom: 1px solid #eee; }
  .popup-footer {
      padding: 10px 15px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      background: #fff;
  }
  .popup-footer label { font-size: 13px; color: #666; cursor: pointer; }
  .popup-footer button { 
      background: none; border: none; font-weight: 600; 
      color: #333; cursor: pointer; font-size: 13px;
  }
  
  .popup-slide {
    position: absolute;
    top: 0; left: 0;
    width: 100%; height: 100%;
    opacity: 0;
    transition: opacity 0.5s ease-in-out;
}
.popup-slide.active {
    opacity: 1;
    z-index: 1;
}
.popup-slide img {
    width: 100%;
    height: 100%;
    object-fit: contain; 
    background-color: #ffffff; 
    display: block;
}
</style>
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
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
<main class="home-layout">

  <!-- LEFT -->
  <section class="home-left" data-aos="fade-up" data-aos-delay="80">


    <div class="season-grid">

      <!-- 여름 -->
      <div class="season-col">
        <div class="season-title summer">
          <span class="season-ico">☀️</span>
          <span class="season-text">SUMMER</span>
          <span class="season-sub">PICKS</span>
        </div>

        <div class="season-list">
                 <a class="beach-card" href="<c:url value='/Beach/BeachDetail?bc_no=2'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Gyeongpodae.jpg'/>" alt="경포대"></div>
              <div class="back"><div class="back-title">경포대</div><div class="back-sub">강원</div></div>
            </div></div>
          </a>
          
          <a class="beach-card" href="<c:url value='/Beach/BeachDetail?bc_no=150'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Gwangalli.jpg'/>" alt="광안리"></div>
              <div class="back"><div class="back-title">광안리</div><div class="back-sub">부산</div></div>
            </div></div>
          </a>

          <a class="beach-card" href="<c:url value='/Beach/BeachDetail?bc_no=119'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Beejindo.jpg'/>" alt="비진도"></div>
              <div class="back"><div class="back-title">비진도</div><div class="back-sub">경남</div></div>
            </div></div>
          </a>

          <a class="beach-card" href="<c:url value='/Beach/BeachDetail?bc_no=154'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Jinha.jpg'/>" alt="진하"></div>
              <div class="back"><div class="back-title">진하</div><div class="back-sub">울산</div></div>
            </div></div>
          </a>

          <a class="beach-card" href="<c:url value='/Beach/BeachDetail?bc_no=164'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Eurwangri.jpg'/>" alt="을왕리"></div>
              <div class="back"><div class="back-title">을왕리</div><div class="back-sub">인천</div></div>
            </div></div>
          </a>

          <a class="beach-card" href="<c:url value='/Beach/BeachDetail?bc_no=142'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Yeongildae.jpg'/>" alt="영일대"></div>
              <div class="back"><div class="back-title">영일대</div><div class="back-sub">경북</div></div>
            </div></div>
          </a>
        </div>
      </div>


      <div class="season-col">
        <div class="season-title winter">
          <span class="season-ico">❄️</span>
          <span class="season-text">WINTER</span>
          <span class="season-sub">PICKS</span>
        </div>

        <div class="season-list">
        <a class="beach-card" href="<c:url value='/Beach/BeachDetail?bc_no=114'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/SangjuSilverSand.jpg'/>" alt="상주은모래"></div>
              <div class="back"><div class="back-title">상주은모래</div><div class="back-sub">경남</div></div>
            </div></div>
          </a>
        
          <a class="beach-card" href="<c:url value='/Beach/BeachDetail?bc_no=151'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/SongJung.jpg'/>" alt="송정"></div>
              <div class="back"><div class="back-title">송정</div><div class="back-sub">부산</div></div>
            </div></div>
          </a>

          <a class="beach-card" href="<c:url value='/Beach/BeachDetail?bc_no=212'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Myeongsasimni.jpg'/>" alt="신지명사십리"></div>
              <div class="back"><div class="back-title">신지명사십리</div><div class="back-sub">전남</div></div>
            </div></div>
          </a>

          <a class="beach-card" href="<c:url value='/Beach/BeachDetail?bc_no=230'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Byeonsan.jpg'/>" alt="변산"></div>
              <div class="back"><div class="back-title">변산</div><div class="back-sub">전북</div></div>
            </div></div>
          </a>

          <a class="beach-card" href="<c:url value='/Beach/BeachDetail?bc_no=239'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Hyeopjae.jpg'/>" alt="협재"></div>
              <div class="back"><div class="back-title">협재</div><div class="back-sub">제주</div></div>
            </div></div>
          </a>

          <a class="beach-card" href="<c:url value='/Beach/BeachDetail?bc_no=246'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Daecheon.jpg'/>" alt="대천"></div>
              <div class="back"><div class="back-title">대천</div><div class="back-sub">충남</div></div>
            </div></div>
          </a>
        </div>
      </div>

    </div>
  </section>

 
  <aside class="home-right" data-aos="fade-left" data-aos-delay="160">
    <div class="right-panels">
    

      <div class="side-box">
        <div class="side-head">
          <h3>📢 공지사항</h3>
          <a class="more" href="<c:url value='/Notice/NoticeList'/>">더보기</a>
        </div>
        <ul class="side-list">
          <li><a href="<c:url value='/Notice/NoticeDetail?n_no=8'/>">[공지] 마이페이지 업데이트</a></li>
          <li><a href="<c:url value='/Notice/NoticeDetail?n_no=7'/>">[공지] 서비스 점검 일정</a></li>
          <li><a href="<c:url value='/Notice/NoticeDetail?n_no=6'/>">[공지] 전체채팅 이용 수칙</a></li>
          <li><a href="<c:url value='/Notice/NoticeDetail?n_no=5'/>">[공지] 신고 처리 기준 안내</a></li>
          <li><a href="<c:url value='/Notice/NoticeDetail?n_no=1'/>">[공지] SEA_YOU와 함께하는 매너 있는 바다 여행</a></li>
        </ul>
      </div>

      <div class="side-box">
        <div class="side-head">
          <h3>📝 게시판</h3>
          <a class="more" href="<c:url value='/Board/BoardList'/>">더보기</a>
        </div>
        <ul class="side-list">
          <li><a href="<c:url value='/Board/BoardDetail?b_no=8'/>">오늘 바다 진짜 예쁨…</a></li>
          <li><a href="<c:url value='/Board/BoardDetail?b_no=67'/>">나야...</a></li>
          <li><a href="<c:url value='/Board/BoardDetail?b_no=10'/>">강원도 가진진 당일치기 가능한사람..</a></li>
          <li><a href="<c:url value='/Board/BoardDetail?b_no=61'/>">나 윈터인데..</a></li>
          <li><a href="<c:url value='/Board/BoardDetail?b_no=30'/>">이바다 어디임?</a></li>
        </ul>
      </div>

    </div>
  </aside>

<div id="userTopFloating">
  <jsp:include page="/WEB-INF/views/UserTop.jsp" />
</div>

<div id="leftRankingFloating">
  <div class="side-box user-top-box"> <div class="side-head">
      <h3>🏆 인기 해수욕장</h3>
      <div class="live-indicator"><span class="live-dot"></span>LIVE</div>
    </div>
    <ul class="side-list ranking-list">
      <c:forEach var="beach" items="${topBeaches}" varStatus="status">
        <li>
          <a href="<c:url value='/Beach/BeachDetail?bc_no=${beach.bc_no}'/>" class="rank-item-link">
            <div class="rank-img-icon">
              <img src="<c:url value='/images/bc_images/${beach.bc_image}'/>" 
                   onerror="this.src='<c:url value='/images/common/default_beach.jpg'/>'">
              <span class="rank-badge">${status.count}</span>
            </div>
            <div class="rank-text-info">
              <span class="rank-name">${beach.bc_name}</span>
              <span class="rank-meta">❤️ ${beach.bookmark_count}</span>
            </div>
          </a>
        </li>
      </c:forEach>
      <c:if test="${empty topBeaches}">
        <li class="none-msg">집계 중...</li>
      </c:if>
    </ul>
  </div>
</div>

</main>

<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

<script>
$(document).ready(function() {
   
    $("#chatbot-input").on("keydown", function(e) {
        if (e.keyCode === 13) { 
            sendChat();
            e.preventDefault();
        }
    });
});

function toggleChatbot(){
    $("#chatbot-box").toggleClass("on");
    if($("#chatbot-box").hasClass("on")){
        $("#chatbot-input").focus();
    }
}

function appendMsg(type, text){
    const safe = String(text ?? "")
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/\n/g, "<br>");

    const div = document.createElement("div");
    div.className = "chat-msg " + type;
    div.innerHTML = safe;

    const box = document.getElementById("chatbot-messages");
    box.appendChild(div);

    // 메시지 추가 후 항상 바닥으로 스크롤
    setTimeout(() => box.scrollTop = box.scrollHeight, 10);
}

function sendChat(){
    const msg = $("#chatbot-input").val().trim();
    if(!msg) return;

    appendMsg("user", msg);
    $("#chatbot-input").val("");

    // 로딩 메시지 추가
    appendMsg("bot", "답변 생성중...");

    $.ajax({
        url: "<c:url value='/ChatBot/Ask'/>",
        method: "POST",
        contentType: "application/json",
        data: JSON.stringify({ message: msg }),
        success: function(res){
            // "답변 생성중..." 메시지 제거
            $("#chatbot-messages .chat-msg.bot").last().remove();

            if(res && res.reply){
                appendMsg("bot", res.reply);
            } else {
                appendMsg("bot", "⚠️ 응답은 왔는데 내용이 비어있어요.");
            }
        },
        error: function(xhr){
            $("#chatbot-messages .chat-msg.bot").last().remove();
            appendMsg("bot", "⚠️ 챗봇 오류 (" + xhr.status + ")<br>잠시 후 다시 시도해 주세요.");
        }
    });
}
</script>

<script>
  AOS.init({ duration: 900, once: true, easing: "ease-out-cubic" });
</script>

<div id="chatbot-btn" onclick="toggleChatbot()">
  <img class="chatbot-icon" src="<c:url value='/ChatBot/ChatbotIcon.png'/>" alt="chatbot">
</div>


<div id="chatbot-box">
  <div class="chatbot-header">
    <div class="chatbot-title">SEA_YOU 챗봇</div>
    <button class="chatbot-close" type="button" onclick="toggleChatbot()">✕</button>
  </div>

  <div id="chatbot-messages">
    <div class="chat-msg bot">
      안녕하세요! SEA_YOU 안내 챗봇이에요 🙂<br>
      궁금한 거 편하게 물어보세요!
    </div>
  </div>

  <div class="chatbot-input">
    <input type="text"
           id="chatbot-input"
           placeholder="예) 겨울에 갈만한 바다 추천해줘"
           autocomplete="off">
    <button type="button" onclick="sendChat()">전송</button>
  </div>
</div>

<script>

function toggleChatbot(){
  $("#chatbot-box").toggleClass("on");
  if($("#chatbot-box").hasClass("on")){
    $("#chatbot-input").focus();
  }
}


function appendMsg(type, text){
  const safe = String(text ?? "")
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/\n/g, "<br>");

  const div = document.createElement("div");
  div.className = "chat-msg " + type;
  div.innerHTML = safe;

  const box = document.getElementById("chatbot-messages");
  box.appendChild(div);


  setTimeout(() => box.scrollTop = box.scrollHeight, 0);
}


function sendChat(){
  const msg = $("#chatbot-input").val().trim();
  if(!msg) return;

  appendMsg("user", msg);
  $("#chatbot-input").val("");

  appendMsg("bot", "답변 생성중...");

  $.ajax({
    url: "<c:url value='/ChatBot/Ask'/>",
    method: "POST",
    contentType: "application/json",
    data: JSON.stringify({ message: msg }),

    success: function(res){
     
      $("#chatbot-messages .chat-msg.bot").last().remove();

      console.log("CHATBOT RESPONSE =>", res); // ✅ 디버그용

      if(res && res.reply){
        appendMsg("bot", res.reply);
      } else {
        appendMsg("bot", "⚠️ 응답은 왔는데 내용이 비어있어요.");
      }
    },

    error: function(xhr){
      $("#chatbot-messages .chat-msg.bot").last().remove();
      appendMsg(
        "bot",
        "⚠️ 챗봇 오류 (" + xhr.status + ")<br>잠시 후 다시 시도해 주세요."
      );
    }
  });
}

</script>
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
<div id="main-rolling-popup" class="main-popup" style="display:none; right: 50px; top: 150px;">
    <div class="popup-content">
        <div id="popup-slider" style="position: relative; width: 320px; height: 400px; overflow: hidden; background: #f8f8f8;">
            <div class="popup-slide active">
                <a href="http://192.168.10.31:8080"><img src="<c:url value='/images/Popup/ad1.png'/>" alt="광고1"></a>
            </div>
            <div class="popup-slide">
                <a href="http://192.168.10.46:8080"><img src="<c:url value='/images/Popup/ad3.png'/>" alt="광고2"></a>
            </div>
            <div class="popup-slide">
                <a href="http://192.168.10.49:8080"><img src="<c:url value='/images/Popup/ad4.png'/>" alt="광고3"></a>
            </div>
            
            <button type="button" onclick="moveSlide(-1)" style="position:absolute; left:10px; top:50%; transform:translateY(-50%); z-index:10; background:rgba(0,0,0,0.3); color:#fff; border:none; border-radius:50%; width:30px; height:30px; cursor:pointer;">〈</button>
            <button type="button" onclick="moveSlide(1)" style="position:absolute; right:10px; top:50%; transform:translateY(-50%); z-index:10; background:rgba(0,0,0,0.3); color:#fff; border:none; border-radius:50%; width:30px; height:30px; cursor:pointer;">〉</button>
        </div>
    </div>
    <div class="popup-footer">
        <label style="cursor:pointer; display:flex; align-items:center; gap:5px;">
            <input type="checkbox" id="chk_today_main"> 오늘 하루 보지 않기
        </label>
        <button type="button" onclick="closeMainPopup()" style="cursor:pointer; background:none; border:none; font-weight:bold;">닫기</button>
    </div>
</div>
<script src="<c:url value='/js/Main/Main.js'/>"></script>

<footer class="footer">
    <p><b>SEA YOU</b></p>
    <p>© 2026 Sea YOU. All Rights Reserved. | KH 정보교육원 프로젝트</p>
</footer>
</body>
</html>
