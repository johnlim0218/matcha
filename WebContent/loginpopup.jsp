<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
        <div class="body_wrapper_darken" id="body_wrapper_darken_login">
        <div class="body_darken_inner">
            <div class="popup_wrapper">
                <div class="popup_inner">
                    <header class="popup_header"><span class="popup_header_bi"></span></header>
                    <h2 class="popup_title">로그인</h2>
                    <section>
                        <div class="popup_section_wrapper">
                            <div class="popup_section_inner">
                                <form method="post" action="loginP.jsp">
                                    <div class="popup_input_id"><label class="popup_input_label">
                                            <div class="popup_input_label_inner"><input id="popup_input_id_input_id"
                                                    class="popup_input_id_input" type="text" name="id" placeholder="아이디"
                                                    autocomplete="off"></div>
                                        </label></div>
                                    <div class="popup_input_pw"><label class="popup_input_label">
                                            <div class="popup_input_label_inner"><input id="popup_input_pw_input_id"
                                                    class="popup_input_pw_input" type="password" name="pw"
                                                    placeholder="비밀번호" autocomplete="off"></div>
                                        </label></div><button class="popup_input_button">로그인</button>
                                </form>
                                <div>　</div>
                                <div class="popup_regist">계정이 없으신가요?　<button class="popup_regist_button"> 회원가입</button></div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript" src="js/main.js"></script> <!-- main page 구동 js 파일 호출 -->
</html>