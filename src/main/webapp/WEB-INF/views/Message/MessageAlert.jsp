<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
  /* 1. 디자인 (!important로 모든 간섭 차단) */
  #msgAlert {
    position: fixed !important; 
    bottom: 80px !important;    /* 챗봇보다 확실히 위로 */
    right: 40px !important;     
    background: #2196F3 !important; 
    color: #ffffff !important;
    padding: 18px 28px !important; 
    border-radius: 50px !important; 
    box-shadow: 0 15px 35px rgba(0,0,0,0.4) !important;
    display: none;              /* 기본은 숨김 */
    z-index: 2147483647 !important; /* 브라우저가 허용하는 최대치 */
    cursor: pointer !important;
    align-items: center !important; 
    gap: 12px !important;
    font-family: 'Noto Sans KR', sans-serif !important;
    font-weight: 600 !important;
    transition: transform 0.2s ease !important;
  }

  /* 등장 애니메이션 */
  @keyframes seaSlideUp {
    from { transform: translateY(100px); opacity: 0; }
    to { transform: translateY(0); opacity: 1; }
  }

  #msgAlert:hover { transform: scale(1.05) !important; background: #1976D2 !important; }
</style>

<div id="msgAlert" onclick="location.href='<c:url value='/Message/RecvMessageList'/>'">
  <span style="font-size: 22px;">📩</span>
  <span id="alertText">새로운 쪽지가 도착했습니다!</span>
</div>

<script>
(function() {
    let lastUnreadCount = -1;
    const alertDiv = document.getElementById('msgAlert');

    function checkMessageCount() {
        // Fetch API 사용 (jQuery 없이 순수 JS로 서버 호출)
        fetch("<c:url value='/Message/UnreadCount'/>", { cache: 'no-store' })
            .then(res => res.text())
            .then(data => {
                const count = parseInt(data);
                console.log("[쪽지체크]", count, " (이전:", lastUnreadCount, ")");

                if (isNaN(count)) return;

                if (lastUnreadCount === -1) {
                    lastUnreadCount = count;
                    return;
                }
                
                if (count > lastUnreadCount) {
                    // 알림바 표시
                    alertDiv.style.display = 'flex';
                    alertDiv.style.animation = 'seaSlideUp 0.5s ease-out';
                    
                    // 7초 후 제거
                    setTimeout(() => {
                        alertDiv.style.opacity = '0';
                        alertDiv.style.transition = 'opacity 0.8s ease';
                        setTimeout(() => { 
                            alertDiv.style.display = 'none';
                            alertDiv.style.opacity = '1'; 
                        }, 800);
                    }, 7000);
                }
                lastUnreadCount = count;
            })
            .catch(err => console.error("쪽지 체크 오류:", err));
    }

    // 초기 실행
    window.addEventListener('load', function() {
        // JSP에서 로그인 유무 확인
        const isLogin = ${not empty pageContext.request.userPrincipal};
        
        if (isLogin) {
            checkMessageCount(); 
            setInterval(checkMessageCount, 3000); // 15초마다 체크
        }
    });
})();
</script>