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