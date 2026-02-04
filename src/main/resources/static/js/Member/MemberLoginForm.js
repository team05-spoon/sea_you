window.onload = function() {
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('error')) {
        alert("아이디 혹은 비밀번호가 틀렸습니다.");
    }
}

// 빈칸 입력 확인 (변수 f 제거 버전)
function check(){
    if(document.MemberLoginForm.m_username.value == ""){
        alert("아이디를 입력해주세요");
        document.MemberLoginForm.m_username.focus();
        return false;
    }
    if(document.MemberLoginForm.m_password.value == ""){
        alert("비밀번호를 입력해주세요");
        document.MemberLoginForm.m_password.focus();
        return false;
    }
    
    return true;
}