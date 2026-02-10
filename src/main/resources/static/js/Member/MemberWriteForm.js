/**
 * 회원가입 통합 로직 (수정본)
 */

let isIdChecked = false; 

function check() {
    const f = document.member;
    const expnick = /^[A-Za-z0-9]+$/;
    const exppw = /^[a-zA-Z0-9!@#$%^&]{6,20}$/;
    const expname = /^[가-힣]+$/;
    const exptel = /^[0-9]{11}$/;
    const expemail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

    if (!isIdChecked) {
        alert("아이디 중복 확인을 반드시 해주세요.");
        return false;
    }

    if(!f.m_nick.value || !expnick.test(f.m_nick.value)){
        alert("아이디는 영문 또는 숫자만 가능합니다.");
        f.m_nick.focus();
        return false;
    }

    if (!f.m_file.value) { alert("프로필 사진을 등록해주세요."); return false; }
    if(!f.m_pw.value || !exppw.test(f.m_pw.value)){ alert("비밀번호 형식을 확인하세요."); f.m_pw.focus(); return false; }
    if(!f.m_name.value || !expname.test(f.m_name.value)){ alert("이름을 확인하세요."); f.m_name.focus(); return false; }
    if(f.m_sex.value == ""){ alert("성별을 선택하세요."); return false; }
    if(f.m_birth.value == ""){ alert("생년월일을 선택하세요."); return false; }

    // 성인 인증 로직
    const birthValue = f.m_birth.value.replace(/-/g, '');
    if (!checkIsAdult(birthValue)) {
        alert("만 19세 미만은 가입할 수 없습니다.");
        return false;
    }

    if(f.m_addr.value == ""){ alert("주소를 입력하세요."); return false; }
    if(!f.m_tel.value || !exptel.test(f.m_tel.value)){ alert("전화번호를 확인하세요."); f.m_tel.focus(); return false; }
    if(!f.m_email.value || !expemail.test(f.m_email.value)) { alert('이메일을 확인하세요.'); f.m_email.focus(); return false; }

    return true; 
}

function checkIsAdult(birthDateStr) {
    const year = parseInt(birthDateStr.substring(0, 4));
    const month = parseInt(birthDateStr.substring(4, 6)) - 1;
    const day = parseInt(birthDateStr.substring(6, 8));
    const birthday = new Date(year, month, day);
    const today = new Date(); 
    let age = today.getFullYear() - birthday.getFullYear();
    const monthDiff = today.getMonth() - birthday.getMonth();
    if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthday.getDate())) { age--; }
    return age >= 19;
}

$(function() {
    // [중복 확인 버튼 클릭]
    $("#idCheckBtn").on("click", function() {
        const m_nick = $("#m_nick").val().trim(); // 공백 제거
        const expnick = /^[A-Za-z0-9]+$/;

        if (!m_nick || !expnick.test(m_nick)) {
            alert("아이디는 영문 또는 숫자만 가능합니다.");
            $("#m_nick").focus();
            return;
        }

        $.ajax({
            url: "/Member/IdCheck",
            type: "get",
            data: { "m_nick": m_nick },
            success: function(res) {
                // res를 확실히 숫자로 변환해서 비교
                if (parseInt(res) === 0) {
                    alert("사용 가능한 아이디입니다.");
                    $("#idMsg").text("사용 가능한 아이디입니다.").css("color", "blue");
                    isIdChecked = true; 
                } else {
                    alert("이미 사용 중인 아이디입니다.");
                    $("#idMsg").text("이미 사용 중인 아이디입니다.").css("color", "red");
                    // ★ 중요: 입력을 비우지(val("")) 않습니다!
                    $("#m_nick").focus(); 
                    isIdChecked = false;
                }
            },
            error: function() {
                alert("서버 통신 오류가 발생했습니다.");
            }
        });
    });

    // [아이디 입력 시 중복확인 리셋]
    // 직접 타이핑할 때만 리셋되도록 input 이벤트를 사용합니다.
    $("#m_nick").on("input", function() {
        isIdChecked = false;
        $("#idMsg").text("");
    });

    // 이미지 미리보기 로직
    $("#m_file").on("change", function(){
        const file = this.files[0];
        if(!file) return;
        if(!file.type.startsWith("image/")){ alert("이미지만 가능합니다."); this.value = ""; return; }
        $("#fileName").text(file.name);
        const reader = new FileReader();
        reader.onload = function(e) { $("#filePreview").attr("src", e.target.result).show(); }
        reader.readAsDataURL(file);
    });
});