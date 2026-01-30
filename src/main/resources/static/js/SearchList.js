$(document).ready(function() {
    $(document).on("click", ".btn-bookmark", function() {
        const bc_no = $(this).data("bcno");
        const $btn = $(this);
        
        const m_id = $("#session-m-id").val(); 
        const csrfToken = $("#csrf-token").val();
        const csrfParameter = $("#csrf-token").attr("name");

        if (m_id && m_id.trim() !== "") {
            $.ajax({
                url: "/bookmark/toggle",
                type: "POST",
                data: { 
                    bc_no: bc_no,
                    [csrfParameter]: csrfToken 
                },
                success: function(response) {
                    if (response === "added") {
                        $btn.html("❤️ 찜취소");
                    } else if (response === "removed") {
                        // [중요] 찜 취소 시 동작 로직
                        $btn.html("🤍 찜하기");

                        // 현재 페이지가 '내 찜 목록' 페이지(/myBookMark)라면 해당 줄을 바로 삭제
                        if (window.location.pathname.includes("myBookMark")) {
                            $btn.closest("tr").fadeOut(400, function() {
                                $(this).remove();
                                
                                // 만약 모든 줄이 삭제되었다면 '데이터 없음' 메시지 표시 (선택사항)
                                if ($("tbody tr").length === 0) {
                                    location.reload(); // 새로고침해서 "찜한 해수욕장이 없습니다" 보여주기
                                }
                            });
                        }
                    }
                },
                error: function() {
                    alert("통신 중 오류가 발생했습니다.");
                }
            });
        } else {
            alert("로그인이 필요한 서비스입니다.");
            window.location.href = "/Member/MemberLoginForm";
        }
    });
});