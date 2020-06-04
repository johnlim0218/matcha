<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="body_wrapper_darken" id="body_wrapper_darken_regist">
        <div class="body_darken_inner">
            <div class="popup_wrapper">
                <div class="popup_inner">
                    <header class="popup_header">
                        <span class="popup_header_bi">
                        </span>
                    </header>
                    <h2 class="popup_title">회원가입
                    </h2>
                    <section>
                        <div class="popup_section_wrapper">
                            <div class="popup_section_inner">
                                <form method="post" action="registP.jsp">
                                    <div class="popup_input_username">
                                        <label class="popup_input_label">
                                            <div class="popup_input_label_inner">
                                                <input type="text" name="name" id="popup_input_username_input_id" class="popup_input_username_input" label="이름" placeholder="이름">
                                            </div>
                                        </label>
                                    </div>
                                    <div class="popup_input_id">
                                        <label class="popup_input_label">
                                            <div class="popup_input_label_inner">
                                                <input type="text" name="id" id="popup_input_id_input_id" class="popup_input_id_input" label="아이디" placeholder="아이디">
                                            </div>
                                        </label>
                                    </div>
                                    <div class="popup_input_pw">
                                        <label class="popup_input_label">
                                            <div class="popup_input_label_inner">
                                                <input type="password" name="pw" id="popup_input_pw_input_id" class="popup_input_pw_input" label="비밀번호" placeholder="비밀번호">
                                            </div>
                                        </label>
                                    </div>
                                    <div class="popup_input_pw">
                                        <label class="popup_input_label">
                                            <div class="popup_input_label_inner">
                                                <input type="text" name="gender" id="popup_input_pw_input_id" class="popup_input_pw_input" label="성별" placeholder="성별">
                                            </div>
                                        </label>
                                    </div>
                                    <button class="popup_input_button">회원가입
                                    </button>
                                </form>
                                <div class="popup_forget">이미 가입하셨나요?
                                    <button class="popup_forget_button">로그인
                                    </button>
                                </div>            
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