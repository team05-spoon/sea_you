function deleteCheck(m_no) {
    // 브라우저 상단 알림창
    let answer = confirm("정말로 탈퇴하시겠습니까?\n삭제된 데이터는 복구할 수 없습니다.");
    
    if (answer) {
        // '확인' 클릭 시 해당 번호를 가지고 삭제 경로로 이동
        location.href = "/Member/MemberDelete?m_no=" + m_no;
    }
    // '취소' 클릭 시 아무 동작 안 함
}