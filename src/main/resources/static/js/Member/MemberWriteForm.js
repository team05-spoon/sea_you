/**
 * 회원가입 유효성 검사 및 성인 인증 로직
 */

// 1. 유효성 검사 함수
function check() {
    // 정규식 선언
    const expnick = /^[A-Za-z0-9]+$/;
    const exppw = /^[a-zA-Z0-9!@#$%^&]{6,20}$/;
    const expname = /^[가-힣]+$/;
    const exptel = /^[0-9]{11}$/;
    const expemail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

    const f = document.member;

    // 아이디 체크
    if(!f.m_nick.value || !expnick.test(f.m_nick.value)){
        alert("아이디는 영문 또는 숫자만 가능합니다.");
        f.m_nick.focus();
        return false;
    }

    // 사진 필수 체크
    if (!f.m_file.value) {
        alert("프로필 사진을 반드시 등록해주세요.");
        return false;
    }

    // 비밀번호 체크
    if(!f.m_pw.value || !exppw.test(f.m_pw.value)){
        alert("비밀번호는 영문, 숫자, 특수문자 포함 6~20자여야 합니다.");
        f.m_pw.focus();
        return false;
    }

    // 이름 체크
    if(!f.m_name.value || !expname.test(f.m_name.value)){
        alert("이름을 한글로 정확히 입력해주세요.");
        f.m_name.focus();
        return false;
    }

    // 성별 체크
    if(f.m_sex.value == ""){
        alert("성별을 선택해주세요.");
        return false;
    }

    // 생년월일 & 성인인증
    if(f.m_birth.value == ""){
        alert("생년월일을 선택해주세요.");
        return false;
    } else {
        const birthValue = f.m_birth.value.replace(/-/g, '');
        if (!checkIsAdult(birthValue)) {
            alert("죄송합니다. 만 19세 미만 미성년자는 가입할 수 없습니다.");
			window.location.href = "/";
            return false;
        }
    }

    // 주소 체크
    if(f.m_addr.value == ""){
        alert("주소를 입력해주세요.");
        return false;
    }

    // 전화번호 체크
    if(!f.m_tel.value || !exptel.test(f.m_tel.value)){
        alert("전화번호 11자리를 숫자만(하이픈 없이) 입력해주세요.");
        f.m_tel.focus();
        return false;
    }

    // 이메일 체크
    if(!f.m_email.value || !expemail.test(f.m_email.value)) {
        alert('이메일 형식이 올바르지 않습니다.');
        f.m_email.focus();
        return false;
    }

    return true; // 모든 검사 통과
}

// 2. 만 나이 계산 함수 (2026년 기준)
function checkIsAdult(birthDateStr) {
    const year = parseInt(birthDateStr.substring(0, 4));
    const month = parseInt(birthDateStr.substring(4, 6)) - 1;
    const day = parseInt(birthDateStr.substring(6, 8));

    const birthday = new Date(year, month, day);
    const today = new Date(); // 2026-01-28

    let age = today.getFullYear() - birthday.getFullYear();
    const monthDiff = today.getMonth() - birthday.getMonth();

    if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthday.getDate())) {
        age--;
    }
    return age >= 19;
}

// 3. 이미지 미리보기 (jQuery 사용)
$(function(){
    $("#m_file").on("change", function(){
        const file = this.files[0];
        if(!file) {
            $("#fileName").text("선택된 파일 없음");
            $("#filePreview").hide();
            return;
        }

        if(!file.type.startsWith("image/")){
            alert("이미지 파일만 선택 가능합니다.");
            this.value = "";
            return;
        }

        $("#fileName").text(file.name);
        const reader = new FileReader();
        reader.onload = function(e) {
            $("#filePreview").attr("src", e.target.result).show();
        }
        reader.readAsDataURL(file);
    });
});