$(document).ready(function() {
    // 페이지 로드 후 로그인 팝업 호출 버튼 선택 시 show
    $("#header_login_id").click(function() {
        $("#body_wrapper_darken_login").show();
    });
    // 페이지 로드 후 회원가입 팝업 호출 버튼 선택 시 show
    $("#header_regist_id").click(function() {
        $("#body_wrapper_darken_regist").show();
    });
    $(".body_wrapper_darken").click(function(e) {
    	if(e.target.className == "body_darken_inner") {
    		$("#body_wrapper_darken_login").hide();
            $("#body_wrapper_darken_regist").hide();
    	}
    });
    $(".popup_regist_button").click(function() {
    	$("#body_wrapper_darken_login").hide();
    	$("#body_wrapper_darken_regist").show();
    });
    $(".popup_forget_button").click(function() {
    	$("#body_wrapper_darken_regist").hide();
    	$("#body_wrapper_darken_login").show();
    });
});