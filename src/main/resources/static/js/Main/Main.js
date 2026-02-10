let currentSlide = 0;
let slideTimer;

// 1. 쿠키 설정/가져오기
function setCookie(name, value, expiredays) {
    var todayDate = new Date();
    todayDate.setDate(todayDate.getDate() + expiredays);
    document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";";
}

function getCookie(name) {
    var nameOfCookie = name + "=";
    var x = 0;
    while (x <= document.cookie.length) {
        var y = (x + nameOfCookie.length);
        if (document.cookie.substring(x, y) == nameOfCookie) {
            if ((endOfCookie = document.cookie.indexOf(";", y)) == -1) endOfCookie = document.cookie.length;
            return unescape(document.cookie.substring(y, endOfCookie));
        }
        x = document.cookie.indexOf(" ", x) + 1;
        if (x == 0) break;
    }
    return "";
}

// 2. 슬라이드 제어
function showSlide(n) {
    const slides = $(".popup-slide");
    if (slides.length === 0) return;
    slides.removeClass("active");
    currentSlide = (n + slides.length) % slides.length;
    slides.eq(currentSlide).addClass("active");
}

function moveSlide(n) {
    clearInterval(slideTimer);
    showSlide(currentSlide + n);
    startAutoSlide();
}

function startAutoSlide() {
    slideTimer = setInterval(() => showSlide(currentSlide + 1), 3000);
}

// 3. 팝업 닫기
function closeMainPopup() {
    if ($("#chk_today_main").is(":checked")) {
        setCookie("main_popup", "done", 1);
    }
    $("#main-rolling-popup").fadeOut(200);
    clearInterval(slideTimer);
}

// 4. 로드 시 실행
$(document).ready(function() {
    if (getCookie("main_popup") !== "done") {
        $("#main-rolling-popup").show();
        startAutoSlide();
    }
});