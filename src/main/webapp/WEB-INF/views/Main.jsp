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
</head>

<body>

<!-- 배경 -->
<div class="bg-wrap">
  <video class="bg-video" autoplay muted playsinline>
    <source src="<c:url value='/video/10.mp4'/>" type="video/mp4">
  </video>
   <div class="whaley-float" aria-hidden="true">
     <img src="<c:url value='/images/Logo/웨일리.png'/>" alt="웨일리" class="whaley-float__img">
   </div>
  <div class="bg-overlay"></div>
</div>

<!-- 상단바 (✅ 네 코드 그대로 / 단, 검색폼만 제거) -->
<div class="top" data-aos="fade-down" data-aos-duration="850">

  <div class="logo">
    <a href="<c:url value='/'/>">
      <img src="<c:url value='/images/Logo/sea_you3.png'/>" alt="SEA_YOU">
    </a>
  </div>

  <nav class="nav">

    <!-- ✅ 지역별(place) -->
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

    <a href="/Chat/ChatRoom" onclick="window.open(this.href, 'chat', 'width=500, height=700'); return false;">전체채팅</a>

<div class="main-search-wrap nav-search ${member.m_temp eq 'ADMIN' ? 'admin-nav' : ''}">
      <form name="search" method="get" action="<c:url value='/search'/>"
            class="search-wrap main-search" autocomplete="off">
        <input type="text" id="keyword" name="keyword" class="search-input"
               placeholder="해수욕장 검색..." autocomplete="off">
        <button type="submit" class="search-btn">검색</button>
        <div id="suggestions"></div>
      </form>
    </div>

    <c:if test="${not empty member and member.m_temp eq 'ADMIN'}">
      <span class="sep">|</span>
      <a href="<c:url value='/Member/MemberList'/>">회원 관리</a>
      <a href="/Report/ReportList">신고 목록</a>
    </c:if>
  </nav>

  <!-- 오른쪽: (✅ 검색 제거) 로그인/프로필만 유지 -->
  <div class="right-tools">
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

<!-- ✅ 새 레이아웃 (왼쪽: 여름/겨울, 오른쪽: 공지/게시) -->
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
                 <a class="beach-card" href="<c:url value='/search?keyword=경포대'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Gyeongpodae.jpg'/>" alt="경포대"></div>
              <div class="back"><div class="back-title">경포대</div><div class="back-sub">강원</div></div>
            </div></div>
          </a>
          
          <a class="beach-card" href="<c:url value='/search?keyword=광안리'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Gwangalli.jpg'/>" alt="광안리"></div>
              <div class="back"><div class="back-title">광안리</div><div class="back-sub">부산</div></div>
            </div></div>
          </a>

          <a class="beach-card" href="<c:url value='/search?keyword=비진도'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Beejindo.jpg'/>" alt="비진도"></div>
              <div class="back"><div class="back-title">비진도</div><div class="back-sub">경남</div></div>
            </div></div>
          </a>

          <a class="beach-card" href="<c:url value='/search?keyword=진하'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Jinha.jpg'/>" alt="진하"></div>
              <div class="back"><div class="back-title">진하</div><div class="back-sub">울산</div></div>
            </div></div>
          </a>

          <a class="beach-card" href="<c:url value='/search?keyword=을왕리'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Eurwangri.jpg'/>" alt="을왕리"></div>
              <div class="back"><div class="back-title">을왕리</div><div class="back-sub">인천</div></div>
            </div></div>
          </a>

          <a class="beach-card" href="<c:url value='/search?keyword=영일대'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Yeongildae.jpg'/>" alt="영일대"></div>
              <div class="back"><div class="back-title">영일대</div><div class="back-sub">경북</div></div>
            </div></div>
          </a>
        </div>
      </div>

      <!-- 겨울 -->
      <div class="season-col">
        <div class="season-title winter">
          <span class="season-ico">❄️</span>
          <span class="season-text">WINTER</span>
          <span class="season-sub">PICKS</span>
        </div>

        <div class="season-list">
        <a class="beach-card" href="<c:url value='/search?keyword=상주은모래'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/SangjuSilverSand.jpg'/>" alt="상주은모래"></div>
              <div class="back"><div class="back-title">상주은모래</div><div class="back-sub">경남</div></div>
            </div></div>
          </a>
        
          <a class="beach-card" href="<c:url value='/search?keyword=송정'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/SongJung.jpg'/>" alt="송정"></div>
              <div class="back"><div class="back-title">송정</div><div class="back-sub">부산</div></div>
            </div></div>
          </a>

          <a class="beach-card" href="<c:url value='/search?keyword=신지명사십리'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Myeongsasimni.jpg'/>" alt="신지명사십리"></div>
              <div class="back"><div class="back-title">신지명사십리</div><div class="back-sub">전남</div></div>
            </div></div>
          </a>

          <a class="beach-card" href="<c:url value='/search?keyword=변산'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Byeonsan.jpg'/>" alt="변산"></div>
              <div class="back"><div class="back-title">변산</div><div class="back-sub">전북</div></div>
            </div></div>
          </a>

          <a class="beach-card" href="<c:url value='/search?keyword=협재'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Hyeopjae.jpg'/>" alt="협재"></div>
              <div class="back"><div class="back-title">협재</div><div class="back-sub">제주</div></div>
            </div></div>
          </a>

          <a class="beach-card" href="<c:url value='/search?keyword=대천'/>">
            <div class="beach-circle flip"><div class="flip-inner">
              <div class="front"><img src="<c:url value='/images/beach/Daecheon.jpg'/>" alt="대천"></div>
              <div class="back"><div class="back-title">대천</div><div class="back-sub">충남</div></div>
            </div></div>
          </a>
        </div>
      </div>

    </div>
  </section>

  <!-- RIGHT -->
  <aside class="home-right" data-aos="fade-left" data-aos-delay="160">
    <div class="right-panels">
    

      <div class="side-box">
        <div class="side-head">
          <h3>📢 공지사항</h3>
          <a class="more" href="<c:url value='/Notice/NoticeList'/>">더보기</a>
        </div>
        <ul class="side-list">
          <li><a href="<c:url value='/Notice/NoticeList'/>">[공지] SEA_YOU 오픈 안내</a></li>
          <li><a href="<c:url value='/Notice/NoticeList'/>">[공지] 신고 처리 기준 안내</a></li>
          <li><a href="<c:url value='/Notice/NoticeList'/>">[공지] 전체채팅 이용 수칙</a></li>
          <li><a href="<c:url value='/Notice/NoticeList'/>">[공지] 마이페이지 업데이트</a></li>
          <li><a href="<c:url value='/Notice/NoticeList'/>">[공지] 서비스 점검 일정</a></li>
        </ul>
      </div>

      <div class="side-box">
        <div class="side-head">
          <h3>📝 게시판</h3>
          <a class="more" href="<c:url value='/Board/BoardList'/>">더보기</a>
        </div>
        <ul class="side-list">
          <li><a href="<c:url value='/Board/BoardList'/>">오늘 바다 진짜 예쁨…</a></li>
          <li><a href="<c:url value='/Board/BoardList'/>">부산 추천 스팟 공유</a></li>
          <li><a href="<c:url value='/Board/BoardList'/>">강원도 당일치기 가능?</a></li>
          <li><a href="<c:url value='/Board/BoardList'/>">혼자 여행 가는 사람?</a></li>
          <li><a href="<c:url value='/Board/BoardList'/>">맛집/카페 추천 부탁</a></li>
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
    </div>
    <ul class="side-list ranking-list">
      <c:forEach var="beach" items="${topBeaches}" varStatus="status">
        <li>
          <a href="<c:url value='/search?keyword=${beach.bc_name}'/>" class="rank-item-link">
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
<!-- 자동완성 -->
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
    if(!$(e.target).closest('form[name=\"search\"]').length) $("#suggestions").hide();
  });
});
</script>

<script>
  AOS.init({ duration: 900, once: true, easing: "ease-out-cubic" });
</script>

<!-- <!-- ========================= -->
<!--       ChatBot -->
<!-- ========================= --> -->
<!-- <div id="chatbot-btn" onclick="toggleChatbot()"> -->
<%--   <img class="chatbot-icon" src="<c:url value='/ChatBot/ChatbotIcon.png'/>" alt="chatbot"> --%>
<!-- </div> -->


<!-- <!-- ✅ 수정1: style="display:none;" 제거 --> -->
<!-- <div id="chatbot-box"> -->
<!--   <div class="chatbot-header"> -->
<!--     <div class="chatbot-title">SEA_YOU 챗봇</div> -->
<!--     <button class="chatbot-close" type="button" onclick="toggleChatbot()">✕</button> -->
<!--   </div> -->

<!--   <div id="chatbot-messages"> -->
<!--     <div class="chat-msg bot"> -->
<!--       안녕하세요! SEA_YOU 안내 챗봇이에요 🙂<br> -->
<!--       궁금한 거 편하게 물어보세요! -->
<!--     </div> -->
<!--   </div> -->

<!--   <div class="chatbot-input"> -->
<!--     <input type="text" -->
<!--            id="chatbot-input" -->
<!--            placeholder="예) 겨울에 갈만한 바다 추천해줘" -->
<!--            autocomplete="off"> -->
<!--     <button type="button" onclick="sendChat()">전송</button> -->
<!--   </div> -->
<!-- </div> -->

<!-- <script> -->
<!-- // /* 열고 닫기 */ -->
<!-- // function toggleChatbot(){ -->
<!-- //   $("#chatbot-box").toggleClass("on"); -->
<!-- //   if($("#chatbot-box").hasClass("on")){ -->
<!-- //     $("#chatbot-input").focus(); -->
<!-- //   } -->
<!-- // } -->

<!-- // /* 메시지 출력 (🔥 핵심) */ -->
<!-- // function appendMsg(type, text){ -->
<!-- //   const safe = String(text ?? "") -->
<!-- //     .replace(/&/g, "&amp;") -->
<!-- //     .replace(/</g, "&lt;") -->
<!-- //     .replace(/>/g, "&gt;") -->
<!-- //     .replace(/\n/g, "<br>"); -->

<!-- //   const div = document.createElement("div"); -->
<!-- //   div.className = "chat-msg " + type; -->
<!-- //   div.innerHTML = safe; -->

<!-- //   const box = document.getElementById("chatbot-messages"); -->
<!-- //   box.appendChild(div); -->

<!-- //   /* ✅ 수정2: 자동 스크롤 확실하게 */ -->
<!-- //   setTimeout(() => box.scrollTop = box.scrollHeight, 0); -->
<!-- // } -->

<!-- // /* 전송 */ -->
<!-- // function sendChat(){ -->
<!-- //   const msg = $("#chatbot-input").val().trim(); -->
<!-- //   if(!msg) return; -->

<!-- //   appendMsg("user", msg); -->
<!-- //   $("#chatbot-input").val(""); -->

<!-- //   appendMsg("bot", "답변 생성중..."); -->

<!-- //   $.ajax({ -->
<%-- //     url: "<c:url value='/ChatBot/Ask'/>", --%>
<!-- //     method: "POST", -->
<!-- //     contentType: "application/json", -->
<!-- //     data: JSON.stringify({ message: msg }), -->

<!-- //     success: function(res){ -->
<!-- //       // 로딩 메시지 제거 -->
<!-- //       $("#chatbot-messages .chat-msg.bot").last().remove(); -->

<!-- //       console.log("CHATBOT RESPONSE =>", res); // ✅ 디버그용 -->

<!-- //       if(res && res.reply){ -->
<!-- //         appendMsg("bot", res.reply); -->
<!-- //       } else { -->
<!-- //         appendMsg("bot", "⚠️ 응답은 왔는데 내용이 비어있어요."); -->
<!-- //       } -->
<!-- //     }, -->

<!-- //     error: function(xhr){ -->
<!-- //       $("#chatbot-messages .chat-msg.bot").last().remove(); -->
<!-- //       appendMsg( -->
<!-- //         "bot", -->
<!-- //         "⚠️ 챗봇 오류 (" + xhr.status + ")<br>잠시 후 다시 시도해 주세요." -->
<!-- //       ); -->
<!-- //     } -->
<!-- //   }); -->
<!-- // } -->

<!-- // /* Enter 키 전송 */ -->
<!-- // $(document).on("keydown", "#chatbot-input", function(e){ -->
<!-- //   if(e.key === "Enter"){ -->
<!-- //     e.preventDefault(); -->
<!-- //     sendChat(); -->
<!-- //   } -->
<!-- // }); -->

<!-- // const quotes = [ -->
<!-- //      "오늘은 어떤 바다가 보고 싶나요?", -->
<!-- //      "파도가 바다의 일이라면, 너를 생각하는 것은 나의 일이었다.", -->
<!-- //      "바다는 비에 젖지 않는다.", -->
<!-- //      "가장 아름다운 항해는 아직 끝나지 않았다.", -->
<!-- //      "우리는 모두 저마다의 바다를 품고 산다.", -->
<!-- //      "푸른 바다를 보면 당신의 눈동자가 떠올라요.", -->
<!-- //      "바다의 깊이를 재기보다, 그 너머의 수평선을 바라보세요.", -->
<!-- //      "당신의 슬픔이 밀물에 씻겨 내려가길 바랍니다.", -->
<!-- //      "바람이 불어오는 곳, 그곳에 우리의 바다가 있습니다.", -->
<!-- //      "잠시 멈춰서 바다의 소리에 귀를 기울여보세요.", -->
<!-- //      "바다는 말이 없어도 모든 위로를 건넵니다.", -->
<!-- //      "오늘 하루도 수고했어요, 바다처럼 넓은 마음을 가진 당신.", -->
<!-- //      "끝이 보이지 않는 수평선처럼 당신의 꿈도 무한하길.", -->
<!-- //      "윤슬이 반짝이는 바다처럼 당신의 내일도 빛날 거예요.", -->
<!-- //      "바다는 우리에게 기다림의 미학을 가르쳐줍니다." -->
<!-- //    ]; -->

<!-- //    let quoteIndex = 0; -->
<!-- //    const intervalTime = 5000; // ✅ 5초로 변경 -->

<!-- //    function autoRefreshQuote() { -->
<!-- //      const track = $("#quote-track"); -->
<!-- //      const fill = $(".bar-fill"); -->

<!-- //      // 1. 진행바가 5초 동안 천천히 차오름 -->
<!-- //      fill.stop().css("width", "0%").animate({ width: "100%" }, intervalTime, "linear"); -->

<!-- //      // 2. 글귀 교체 타이머 -->
<!-- //      setTimeout(() => { -->
<!-- //        // 위로 부드럽게 사라짐 -->
<!-- //        track.addClass("slide-out"); -->

<!-- //        setTimeout(() => { -->
<!-- //          quoteIndex = (quoteIndex + 1) % quotes.length; -->
<!-- //          $("#display-quote").text('"' + quotes[quoteIndex] + '"'); -->

         
<!-- //          track.removeClass("slide-out").css("opacity", "0"); -->
         
<!-- //          setTimeout(() => { -->
           
<!-- //            track.css("opacity", "1").addClass("slide-in"); -->
           
<!-- //            setTimeout(() => { -->
<!-- //              track.removeClass("slide-in"); -->
<!-- //              autoRefreshQuote();  -->
<!-- //            }, 600);  -->
<!-- //          }, 50); -->
<!-- //        }, 700);  -->
<!-- //      }, intervalTime - 800);  -->
<!-- //    } -->

<!-- //    $(document).ready(function() { -->
<!-- //      $("#display-quote").text('"' + quotes[0] + '"'); -->
<!-- //      autoRefreshQuote(); -->
<!-- //    }); -->
<!-- <!-- </script> --> -->

</body>
</html>
