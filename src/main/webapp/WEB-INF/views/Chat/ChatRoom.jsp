<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 채팅</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ChatRoom.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>

<div class="bg-wrap">
  <video class="bg-video" autoplay muted playsinline>
    <source src="<c:url value='/video/10.mp4'/>" type="video/mp4">
  </video>
  <div class="bg-overlay"></div>
</div>

<main class="chat-main">
  <div class="chat-head">
    <h2 class="chat-title">전체 채팅</h2>
  </div>

  <div class="chat-card">
    <div id="chatBox" class="chat-box"></div>

    <div class="chat-input-row">
      <input type="text" id="chatInput" placeholder="메시지 입력">
      <button id="sendBtn" type="button">전송</button>
    </div>
  </div>
</main>

<!-- ✅ 자동완성 (그대로 유지) -->
<script>
$(document).ready(function(){
  $("#keyword").on("keyup", function(){
    let q = $(this).val();
    if(q.length < 1){ $("#suggestions").hide(); return; }

    $.ajax({
      url: "/autocomplete",
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

<!-- ✅ 채팅 로직 (m_images 기준 최종) -->
<script>
$(document).ready(function() {
  fetchChats();
  setInterval(fetchChats, 2000);

  $("#sendBtn").click(sendMsg);
  $("#chatInput").keydown(function(e) {
    if (e.keyCode == 13) sendMsg();
  });
});

function escapeHtml(str){
  return String(str)
    .replaceAll("&","&amp;")
    .replaceAll("<","&lt;")
    .replaceAll(">","&gt;")
    .replaceAll('"',"&quot;")
    .replaceAll("'","&#039;");
}

function fetchChats() {
  $.ajax({
    url: "/Chat/Chatlist",
    type: "GET",
    success: function(data) {
      let html = "";
      const cp = "${pageContext.request.contextPath}";

      data.forEach(function(chat) {
        const d = new Date(chat.c_date);
        const hh = String(d.getHours()).padStart(2,"0");
        const mm = String(d.getMinutes()).padStart(2,"0");
        const time = hh + ":" + mm;

        // ✅ member.m_image가 "파일명" 이라고 가정: 1000000002_2.jpg
        // ✅ 없으면 default.png
        let imgPath = (chat.m_image && chat.m_image.trim() !== "")
          ? ("/m_images/" + chat.m_image)
          : "/m_images/default.png";

        const img = cp + imgPath;

        // ✅ 회원 상세보기 URL (너 매핑에 맞게 필요시 수정)
        const profileUrl = cp + "/Member/MemberView?m_no=" + chat.m_no;

        html += ""
          + "<div class='msg-row'>"
          +   "<img class='msg-avatar' src='" + img + "' alt='profile' onclick=\"location.href='" + profileUrl + "'\">"
          +   "<div class='msg-bubble'>"
          +     "<div class='msg-meta'>"
          +       "<span class='msg-nick' onclick=\"location.href='" + profileUrl + "'\">" + escapeHtml(chat.m_nick) + "</span>"
          +       "<span class='msg-time'>" + time + "</span>"
          +     "</div>"
          +     "<div class='msg-text'>" + escapeHtml(chat.c_content) + "</div>"
          +   "</div>"
          + "</div>";
      });

      $("#chatBox").html(html);
      $("#chatBox").scrollTop($("#chatBox")[0].scrollHeight);
    }
  });
}

function sendMsg() {
  let content = $("#chatInput").val();
  if (content.trim() === "") return;

  $.ajax({
    url: "/Chat/Chatsend",
    type: "POST",
    data: { content: content },
    success: function(res) {
      if (res === "ok") {
        $("#chatInput").val("");
        fetchChats();
      }
    }
  });
}
</script>

</body>
</html>
