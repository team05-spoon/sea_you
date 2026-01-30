/**
 * 쪽지 전송 유효성 검사
 */
function messageCheck() {
    // 폼 객체 가져오기
    const f = document.MessageWriteForm;
    const content = f.ms_content.value.trim();

    // 1. 내용 입력 여부 확인
    if (content === "") {
        alert("쪽지 내용을 입력해주세요.");
        f.ms_content.focus();
        return false; // 전송 중단
    }

    // 2. 글자 수 제한 (예: 500자) - 필요하면 추가하세요
    if (content.length > 500) {
        alert("쪽지 내용은 500자 이내로 작성 가능합니다.");
        f.ms_content.focus();
        return false;
    }

    // 3. 최종 전송 확인 창
    if (!confirm("쪽지를 정말 보내시겠습니까?")) {
        return false; // '취소' 클릭 시 전송 중단
    }

    // 모든 검사 통과 시 true 반환하여 폼 전송
    return true;
}