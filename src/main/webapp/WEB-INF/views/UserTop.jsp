<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<link rel="stylesheet" href="<c:url value='/css/UserTop.css'/>">

<div class="follower-rank-box">
  <div class="rank-header">
    <h3>🏆 인기 멤버 TOP 5</h3>
    <div class="live-indicator"><span class="live-dot"></span>LIVE</div>
  </div>
  <div class="rank-list" id="followerRankList">
    <div style="text-align: center; color: rgba(255,255,255,0.4); padding: 30px 0; font-size: 13px;">
      순위를 집계 중입니다...
    </div>
  </div>
</div>

<script>
function fetchUserRank() {
  $.ajax({
    url: "<c:url value='/Member/FollowerRank'/>",
    type: "GET",
    dataType: "json",
    success: function(data) {
      let html = "";
      // 데이터가 있는지 확인
      if(data && data.length > 0) {
        data.forEach((m, i) => {
          /**
           * 오라클 + MyBatis Map 리턴 시 Key값은 보통 대문자로 옵니다.
           * 데이터가 안 나올 경우를 대비해 대문자와 소문자 처리를 병행하거나 
           * 아래처럼 대문자로 명시하는 것이 안전합니다.
           */
          let mNo = m.M_NO || m.m_no;
          let mNick = m.M_NICK || m.m_nick;
          let mImage = m.M_IMAGE || m.m_image;
          let followerCount = m.FOLLOWER_COUNT || m.follower_count || 0;

          let imgPath = mImage ? `/m_images/\${mImage}` : `<c:url value='/images/common/default_profile.png'/>`;
          
          html += `
            <a href="<c:url value='/Member/MemberView?m_no='/>\${mNo}" class="rank-item">
              <span class="rank-num">\${i+1}</span>
              <img src="\${imgPath}" class="rank-profile" onerror="this.src='<c:url value='/images/common/default_profile.png'/>'">
              <div class="rank-info">
                <span class="rank-name">\${mNick}</span>
                <span class="rank-cnt">팔로워 \${followerCount.toLocaleString()}명</span>
              </div>
            </a>`;
        });
      } else {
        html = "<p style='color:rgba(255,255,255,0.4); font-size:12px; text-align:center; padding:20px 0;'>집계된 팔로워 정보가 없습니다.</p>";
      }
      $("#followerRankList").html(html);
    },
    error: function(xhr, status, error) {
      console.error("AJAX Error:", error);
      $("#followerRankList").html("<p style='color:gray; font-size:12px; text-align:center; padding:20px 0;'>데이터를 가져올 수 없습니다.</p>");
    }
  });
}

$(document).ready(function() {
  fetchUserRank();
  // 10초마다 갱신
  setInterval(fetchUserRank, 10000); 
});
</script>