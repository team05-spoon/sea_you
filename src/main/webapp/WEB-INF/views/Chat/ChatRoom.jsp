<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SEA YOU - 전체 채팅</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ChatRoom.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>

<div class="bg-wrap">
  <video class="bg-video" autoplay muted playsinline loop>
    <source src="<c:url value='/video/sea2.mp4'/>" type="video/mp4">
  </video>
  <div class="bg-overlay"></div>
</div>

<main class="chat-main">
  <div class="chat-head">
    <h2 class="chat-title">소통</h2>
  </div>

  <div class="chat-card">
    <div id="chatBox" class="chat-box"></div>

    <div class="chat-input-row">
      <input type="text" id="chatInput" placeholder="메시지 입력">
      <button id="sendBtn" type="button">전송</button>
    </div>
  </div>
</main>

<script>
$(document).ready(function() {
  const currentUserNo = "${member.m_no}";

  if (currentUserNo === "" || currentUserNo === null) {
      alert("로그인이 필요한 서비스입니다.");
      if (window.opener && !window.opener.closed) {
          window.opener.location.href = "<c:url value='/Member/MemberLoginForm'/>";
          window.opener.focus();
          window.close();
      } else {
          location.href = "<c:url value='/'/>";
      }
      return; 
  }

  fetchChats(true); 
  setInterval(function() {
      fetchChats(false);
  }, 2000);

  $("#sendBtn").click(sendMsg);
  $("#chatInput").keydown(function(e) {
    if (e.keyCode == 13) sendMsg();
  });
});

function escapeHtml(str){
  if(!str) return "";
  return String(str)
    .replaceAll("&","&amp;")
    .replaceAll("<","&lt;")
    .replaceAll(">","&gt;")
    .replaceAll('"',"&quot;")
    .replaceAll("'","&#039;");
}

function openInOpener(url) {
    if (window.opener && !window.opener.closed) {
        window.opener.location.href = url;
        window.opener.focus();
    } else {
        location.href = url;
    }
}

let lastHtml = ""; // 이전 HTML 저장용 변수

function fetchChats(forceScroll) {
  const currentUserNo = "${member.m_no}";

  $.ajax({
    url: "/Chat/Chatlist",
    type: "GET",
    success: function(data) {
      const chatBox = document.getElementById("chatBox");
      const isAtBottom = chatBox.scrollHeight - chatBox.clientHeight <= chatBox.scrollTop + 50;

      let html = "";
      const cp = "${pageContext.request.contextPath}";

      data.forEach(function(chat) {
        const isMine = (String(chat.m_no) === String(currentUserNo));
        const rowClass = isMine ? 'msg-row mine' : 'msg-row';
        const d = new Date(chat.c_date);
        const time = String(d.getHours()).padStart(2,"0") + ":" + String(d.getMinutes()).padStart(2,"0");

        let imgPath = (chat.m_image && chat.m_image.trim() !== "")
          ? ("/m_images/" + chat.m_image)
          : "/m_images/default.png";

        const img = cp + imgPath;
        const profileUrl = cp + "/Member/MemberView?m_no=" + chat.m_no;

        html += "<div class='" + rowClass + "'>"
          +   "<img class='msg-avatar' src='" + img + "' alt='profile' onclick=\"openInOpener('" + profileUrl + "')\" style='cursor:pointer;'>"
          +   "<div class='msg-bubble'>"
          +     "<div class='msg-meta'>"
          +       "<span class='msg-nick' onclick=\"openInOpener('" + profileUrl + "')\" style='cursor:pointer;'>" + escapeHtml(chat.m_nick) + "</span>"
          +       "<span class='msg-time'>" + time + "</span>"
          +     "</div>"
          +     "<div class='msg-text'>" + escapeHtml(chat.c_content) + "</div>"
          +   "</div>"
          + "</div>";
      });

      // [핵심] 이전 내용과 다를 때만 화면을 갱신합니다.
      if (lastHtml !== html) {
        $("#chatBox").html(html);
        lastHtml = html; // 새로운 내용을 저장

        if (forceScroll || isAtBottom) {
          chatBox.scrollTop = chatBox.scrollHeight;
        }
      }
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
        fetchChats(true);
      }
    }
  });
}
</script>

</body>
</html>