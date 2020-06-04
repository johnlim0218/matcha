<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String useridx = (String) session.getAttribute("sIdx");


%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link
	href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900"
	rel="stylesheet">
<!-- google noto-sans font 호출 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- jQuery 호출 -->
<link rel="shortcut icon" href="images/favicon.ico">
<link href="css/main.css" rel="stylesheet" type="text/css">
<link href="css/loading.css" rel="stylesheet" type="text/css">
<!-- main.css 파일 호출 -->
<link rel="stylesheet" href="css/footerinc_css.css" type="text/css">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<!-- IE 에서 edge 로 랜더링 하도록 명시 -->
</head>
<body>
	<!-- 로딩 -->
	<script>
		var loding = function() {
			if(userinput_form.userinput.value != ""){
				$('.loading').show();
				return true;
				
			} else if(userinput_form.userinput.value == ""){
				
				return false;
			}

		};

		function canc() {
			$('.loading').css("display", "none");
		};
	</script>

	</head>
<body>
	<div class="loading" onclick="canc()">
		<div class="lodingicon">

  		 </div>
   </div><!-- 로딩 -->
	<div class="body_body">
		<div class="body_wrapper">
			<header class="main_header">
				<!-- 로그인 세션 상태에 따라서 다른 JSP를 include 합니다. -->
				<%
					if (useridx == null || useridx.equals("")) {
						// useridx session 값이 존재하지 않을 경우 logout 상태로 판단
				%>
				<%@ include file="mainheader_logout.jsp"%>
				<%
					} else {
						// useridx session 값이 존재할 경우 login 상태로 판단
				%>
				<%@ include file="mainheader_login.jsp"%>
				<%
					}
				%>
			</header>
			<section class="main_section">
				<div class="section_wrapper">
					<div class="main_bi_wrapper">
						<div class="main_bi_left"></div>
						<div class="main_bi_right"></div>
						<div class="main_bi_background">
							<span class="main_bi"> </span>
						</div>
					</div>
					<div class="main_lower_background"></div>
					<div class="main_lower">
						<div class="main_lower_wrapper">
							<div class="main_lower_wrapper_margin">
								<div class="main_lower_inner_position">
									<div class="main_lower_inner_align">
										<div class="main_lower_input">
											<form method="get" name="userinput_form" action="searchresult.jsp"
												class="main_lower_input_inner" onsubmit="return loding()">
												<label class="main_lower_input_label">
													<div class="main_lower_input_div">
														<input type="text" name="userinput"
															class="main_lower_input_input" label="검색"
															placeholder="작품 제목, 배우, 감독을 검색해보세요." autofocus> <input
															type="submit" value="" style="display: none">
															
													</div>
												</label>
											</form>
										</div>
										<section class="main_lower_icon">
											<div class="main_lower_icon_wrapper">
												<div class="main_lower_icon_inner">
													<ul class="iconlist">
														<li class="icon_movie"></li>
														<li class="icon_tv"></li>
														<li class="icon_book"></li>
													</ul>
													<p class="icon_cap">영화, TV, 도서를 검색하고 4억개의 평점과 리뷰를
														만나보세요.</p>
												</div>
											</div>
										</section>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		

		</div>
	</div>
	<!-- 이 부분은 로그인 / 회원가입 팝업 부분입니다. -->
	<!-- 아래 부분은 로그인 부분입니다. -->
	<div class="body_wrapper_darken" id="body_wrapper_darken_login">
		<div class="body_darken_inner">
			<div class="popup_wrapper">
				<div class="popup_inner">
					<header class="popup_header">
						<span class="popup_header_bi"></span>
					</header>
					<h2 class="popup_title">로그인</h2>
					<section>
						<div class="popup_section_wrapper">
							<div class="popup_section_inner">
								<form method="post" action="loginP.jsp">
									<div class="popup_input_id">
										<label class="popup_input_label">
											<div class="popup_input_label_inner">
												<input id="popup_input_id_input_id"
													class="popup_input_id_input" type="text" name="id"
													placeholder="아이디" autocomplete="off">
											</div>
										</label>
									</div>
									<div class="popup_input_pw">
										<label class="popup_input_label">
											<div class="popup_input_label_inner">
												<input id="popup_input_pw_input_id"
													class="popup_input_pw_input" type="password" name="pw"
													placeholder="비밀번호" autocomplete="off">
											</div>
										</label>
									</div>
									<button class="popup_input_button">로그인</button>
								</form>
								<div></div>
								<div class="popup_regist">
									계정이 없으신가요?
									<button class="popup_regist_button">회원가입</button>
								</div>
							</div>
						</div>
					</section>
				</div>
			</div>
		</div>
	</div>
	<!-- 아래 부분은 회원가입 부분입니다. -->
	<div class="body_wrapper_darken" id="body_wrapper_darken_regist">
		<div class="body_darken_inner">
			<div class="popup_wrapper">
				<div class="popup_inner">
					<header class="popup_header">
						<span class="popup_header_bi"> </span>
					</header>
					<h2 class="popup_title">회원가입</h2>
					<section>
						<div class="popup_section_wrapper">
							<div class="popup_section_inner">
								<form method="post" action="registP.jsp">
									<div class="popup_input_username">
										<label class="popup_input_label">
											<div class="popup_input_label_inner">
												<input type="text" name="name"
													id="popup_input_username_input_id"
													class="popup_input_username_input" label="이름"
													placeholder="이름">
											</div>
										</label>
									</div>
									<div class="popup_input_id">
										<label class="popup_input_label">
											<div class="popup_input_label_inner">
												<input type="text" name="id" id="popup_input_id_input_id"
													class="popup_input_id_input" label="아이디" placeholder="아이디">
											</div>
										</label>
									</div>
									<div class="popup_input_pw">
										<label class="popup_input_label">
											<div class="popup_input_label_inner">
												<input type="password" name="pw"
													id="popup_input_pw_input_id" class="popup_input_pw_input"
													label="비밀번호" placeholder="비밀번호">
											</div>
										</label>
									</div>
									<div class="popup_input_pw">
										<label class="popup_input_label">
											<div class="popup_input_label_inner">
												<input type="text" name="gender"
													id="popup_input_pw_input_id" class="popup_input_pw_input"
													label="성별" placeholder="성별">
											</div>
										</label>
									</div>
									<button class="popup_input_button">회원가입</button>
								</form>
								<div class="popup_forget">
									이미 가입하셨나요?
									<button class="popup_forget_button">로그인</button>
								</div>

							</div>
						</div>
					</section>
				</div>
			</div>
		</div>
	</div>
	<footer>
		<%@ include file="footerinc.jsp"%>
	</footer>

	<script>
		var doubleSubmitFlag = false;
		function doubleSubmitCheck() {
			if (doubleSubmitFlag) {
				return doubleSubmitFlag;
			} else {
				doubleSubmitFlag = true;
				return false;
			}
		}

		function insert() {
			if (doubleSubmitCheck())
				return;

			alert("등록");
		}
	</script>
</body>


</html>

