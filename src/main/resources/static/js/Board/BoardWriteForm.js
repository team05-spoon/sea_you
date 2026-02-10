$(document).ready(function() {
    $("#b_image").on("change", function() {
        const file = this.files[0];
        const fileName = $(this).val().split("\\").pop();
        
        if (file) {
            $("#fileName").text(fileName).css("color", "#fff");
            const reader = new FileReader();
            reader.onload = function(e) {
                $("#previewImg").attr("src", e.target.result);
                $("#previewContainer").show();
            }
            reader.readAsDataURL(file);
        } else {
            $("#fileName").text("선택된 파일 없음").css("color", "rgba(255,255,255,0.6)");
            $("#previewContainer").hide();
        }
    });
});

function boardCheck() {
    if (document.BoardWriteForm.b_title.value.trim() == "") {
        alert("제목을 입력해주세요.");
        document.BoardWriteForm.b_title.focus();
        return false;
    }

    if (document.BoardWriteForm.b_memo.value.trim() == "") {
        alert("내용을 입력해주세요.");
        document.BoardWriteForm.b_memo.focus();
        return false;
    }

    if (!confirm("작성하신 글을 등록하시겠습니까?")) {
        return false; 
    }

    return true;
}