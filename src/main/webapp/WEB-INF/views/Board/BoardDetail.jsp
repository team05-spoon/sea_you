<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SEA_YOU - ${dto.b_title}</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600;800&family=Poppins:wght@500;700&display=swap" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/BoardDetail.css">
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<jsp:include page="/WEB-INF/views/Message/MessageAlert.jsp" />
</head>

<body>
<!-- 배경 -->
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

    <!-- ✅ 지역별(place) : 클릭 시 이동 막고, 드롭다운 안에서만 place로 이동 -->
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

    <!-- 게시판 -->
    <div class="menu no-dropdown">
      <a href="<c:url value='/Board/BoardList'/>">게시판</a>
      <div class="dropdown">
        <div class="title">게시판</div>
      </div>
    </div>
    <span class="sep">|</span>

    <!-- 공지사항 -->
    <div class="menu no-dropdown">
      <a href="<c:url value='/Notice/NoticeList'/>">공지사항</a>
      <div class="dropdown">
        <div class="title">공지사항</div>
      </div>
    </div>

    <span class="sep">|</span>

    <!-- 쪽지함 -->
    <div class="menu">
      <a href="<c:url value='/Message/RecvMessageList'/>">쪽지함</a>
      <div class="dropdown">
        <div class="title">쪽지함</div>
        <a href="<c:url value='/Message/RecvMessageList'/>">받은쪽지함</a>
        <a href="<c:url value='/Message/SentMessageList'/>">보낸쪽지함</a>
      </div>
    </div>
    
        <span class="sep">|</span>
        
        <!-- 회원목록 -->
    <div class="menu no-dropdown">
      <a href="<c:url value='/Member/MemberAllView'/>">회원목록</a>
      <div class="dropdown">
        <div class="title">회원목록</div>
      </div>
    </div>
    
   	<span class="sep">|</span>
   	
           <!-- 관심 목록 -->
    <div class="menu no-dropdown">
      <a href="<c:url value='/BookMark/MyBookMarkList'/>">찜 목록</a>
      <div class="dropdown">
        <div class="title">찜</div>
      </div>
    </div> 
    
      <span class="sep">|</span>
    

    <!-- 전체채팅 -->
   <a href="/Chat/ChatRoom" onclick="window.open(this.href, 'chat', 'width=500, height=700'); return false;">소통</a>

    <!-- 관리자 -->
    <c:if test="${not empty member and member.m_temp eq 'ADMIN'}">
      <span class="sep">|</span>
      <a href="<c:url value='/Member/MemberList'/>">회원 관리</a>
      <span class="sep">|</span>
      <a href="/Report/ReportList">신고 목록</a>
      <span class="sep">|</span>
      <a href="http://192.168.10.47:5601/app/dashboards#/view/862cbfe0-01a4-11f1-ba0f-aff3b8d6751c?_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-15m,to:now))&_a=(description:'',filters:!(),fullScreenMode:!f,options:(hidePanelTitles:!f,useMargins:!t),query:(language:kuery,query:''),timeRestore:!f,title:sea_you,viewMode:view)">통계</a>
    </c:if>
  </nav>

  <!-- 오른쪽: 검색 + 로그인/프로필 -->
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

<!-- 게시글 상세 내용 -->
<main class="detail-main" data-aos="fade-up" data-aos-duration="850">
  <section class="detail-card">

    <header class="detail-head">
      <h2 class="detail-title">${dto.b_title}</h2>

      <!-- 게시글 이미지 추가 -->
      <c:if test="${not empty dto.b_image}">
        <div class="detail-image">
          <img src="<c:url value='/images/b_images/${dto.b_image}'/>" alt="게시글 이미지" class="post-image">
        </div>
      </c:if>

      <div class="detail-meta">
        <div class="meta-left">
          작성자:
          <a class="writer-link" href="/Member/MemberView?m_no=${dto.m_no}">
            <img class="writer-avatar"
                 src="<c:url value='/m_images/${dto.m_image}'/>"
                 alt="writer"
                 onerror="this.onerror=null; this.src='<c:url value='/images/common/default_profile.png'/>';">
            ${dto.b_write}
          </a>
        </div>

        <div class="meta-right">
          <a class="btn-link" href="/Board/BoardList">목록</a>

          <c:if test="${not empty pageContext.request.userPrincipal and pageContext.request.userPrincipal.name eq dto.b_write}">
            <a class="btn-link" href="/Board/BoardEdit?b_no=${dto.b_no}">수정</a>
            <a class="btn-link danger"
               href="/Board/BoardDelete?b_no=${dto.b_no}"
               onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
          </c:if>
        </div>
      </div>
    </header>

    <article class="detail-body">
      <p class="detail-content">${dto.b_memo}</p>
    </article>
	
	<div class="board-like-container">
  <button type="button" id="btnBoardLike" class="btn-like ${iLiked ? 'active' : ''}">
    <span id="likeIcon">${iLiked ? '❤️' : '🤍'}</span> 
    좋아요 <span id="likeDisplayCount">${likeCount}</span>
  </button>
</div>

    <div class="divider"></div>

    <!-- 댓글 영역 -->
    <section class="comment-wrap">
      <h4 class="comment-title">댓글</h4>

      <div class="comment-list">
        <c:forEach items="${commentList}" var="c">
          <div class="comment-item ${c.parent_id == 0 ? '' : 'is-reply'}">

            <c:choose>
              <c:when test="${c.is_deleted eq 'Y'}">
                <p class="comment-deleted">삭제된 댓글입니다.</p>
              </c:when>

              <c:otherwise>
                <div class="comment-top">
                  <div class="comment-writer">

                    <a href="/Member/MemberView?m_no=${c.m_no}">
                      <img class="comment-avatar"
                           src="<c:url value='/m_images/${c.m_image}'/>"
                           alt="avatar"
                           onerror="this.onerror=null; this.src='<c:url value='/images/common/default_profile.png'/>';">
                    </a>

                    <strong>
                      <a href="/Member/MemberView?m_no=${c.m_no}">${c.writer}</a>
                    </strong>

                    <small class="comment-date">${c.reg_date}</small>
                  </div>

                  <div class="comment-like">
                    👍 ${c.like_count}
                  </div>
                </div>

                <div class="comment-content">
                  ${c.content}
                </div>

                <div class="comment-actions">
                  <a class="action" href="/Comment/Like?comment_id=${c.comment_id}&b_no=${dto.b_no}">좋아요</a>

                  <c:if test="${c.parent_id == 0}">
                    <a class="action"
                       href="#"
                       onclick="$('#re-form-${c.comment_id}').toggle(); return false;">답글</a>
                  </c:if>

                  <c:if test="${not empty pageContext.request.userPrincipal and pageContext.request.userPrincipal.name eq c.writer}">
                    <a class="action danger"
                       href="/Comment/Delete?comment_id=${c.comment_id}&b_no=${dto.b_no}"
                       onclick="return confirm('삭제하시겠습니까?')">삭제</a>
                  </c:if>
                </div>

                <div id="re-form-${c.comment_id}" class="reply-form">
                  <form action="/Comment/Write" method="post" class="reply-inner">
                    <input type="hidden" name="board_id" value="${dto.b_no}">
                    <input type="hidden" name="parent_id" value="${c.comment_id}">
                    <input type="hidden" name="writer" value="${pageContext.request.userPrincipal.name}">
                    <textarea name="content" placeholder="답글을 입력하세요" required></textarea>
                    <button type="submit" class="btn-submit">답글 등록</button>
                  </form>
                </div>
              </c:otherwise>
            </c:choose>

          </div>
        </c:forEach>
      </div>

      <div class="comment-write-card">
        <c:choose>
          <c:when test="${empty pageContext.request.userPrincipal}">
            <p class="need-login">
              댓글을 작성하려면 <a href="/Member/MemberLoginForm">로그인</a>이 필요합니다.
            </p>
          </c:when>

          <c:otherwise>
            <form action="/Comment/Write" method="post" class="comment-form">
              <input type="hidden" name="board_id" value="${dto.b_no}">
              <input type="hidden" name="parent_id" value="0">
              <input type="hidden" name="writer" value="${pageContext.request.userPrincipal.name}">

              <div class="writer-row">
                <strong>작성자: ${pageContext.request.userPrincipal.name}</strong>
              </div>

              <textarea name="content" placeholder="댓글을 입력하세요" required></textarea>
              <button type="submit" class="btn-submit">댓글 등록</button>
            </form>
          </c:otherwise>
        </c:choose>
      </div>

      <div class="report-row">
        <a class="report-link" href="/Report/ReportBoardWriteForm?target_b_no=${dto.b_no}">게시글 신고</a>
      </div>
    </section>

  </section>
</main>
<!-- 자동완성(메인과 동일) -->
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
$(document).ready(function() {
    // ✅ 게시글 좋아요 클릭 이벤트
    // $(document).on 을 사용하면 요소가 나중에 로드되어도 확실하게 잡힙니다.
    $(document).on("click", "#btnBoardLike", function() {
        console.log("좋아요 버튼 클릭됨!"); // 브라우저 F12 콘솔에서 확인용

        $.ajax({
            url: "<c:url value='/Board/BoardLikeAction'/>",
            type: "POST",
            data: { b_no: "${dto.b_no}" },
            success: function(res) {
                console.log("서버 응답:", res);
                if (res === "login_required") {
                    alert("로그인이 필요한 서비스입니다.");
                    location.href = "<c:url value='/Member/MemberLoginForm'/>";
                } else {
                    // 성공 시 페이지를 새로고침하여 바뀐 하트와 숫자를 반영
                    location.reload(); 
                }
            },
            error: function(xhr, status, error) {
                console.error("에러 발생:", error);
                alert("좋아요 처리 중 오류가 발생했습니다.");
            }
        });
    });

    // --- 기존 자동완성 코드 (유지) ---
    $("#keyword").on("keyup", function(){
        // ... 생략 ...
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
