$(document).ready(function() {
    $("#bookMarkBtn").click(function() {
        const bcNo = $(this).data("bcno"); 
        const $csrfInput = $("#csrf-token");
        const csrfToken = $csrfInput.val();
        const csrfParameter = $csrfInput.attr("name");

        $.ajax({
            url: "/bookmark/toggle",
            type: "POST",
            data: { 
                bc_no: bcNo,
                [csrfParameter]: csrfToken 
            },
            success: function(res) {
                if (res === "LOGIN_REQUIRED") {
                    alert("로그인이 필요합니다.");
                    window.location.href = "/Member/MemberLoginForm";
                } else if (res === "added") {
                    alert("찜 목록에 추가되었습니다.");
                    $("#bookMarkBtn").text("❤️ 찜취소");
                } else if (res === "removed") {
                    alert("찜이 해제되었습니다.");
                    $("#bookMarkBtn").text("🤍 찜하기");
                }
            },
            error: function() {
                alert("서버 통신 오류가 발생했습니다.");
            }
        });
    });
});