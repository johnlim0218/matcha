<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	// 문자열 공백(띄어쓰기) 삭제
	String userInputForHeader = request.getParameter("userinput");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/mainheader_css.css" type="text/css">
<link rel="stylesheet" href="css/headerinc_css.css" type="text/css">
<link href="css/main.css" rel="stylesheet" type="text/css">
<!-- main.css 파일 호출 -->
<link
	href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900"
	rel="stylesheet">
	<link href="css/loading.css" rel="stylesheet" type="text/css">
<!-- google noto-sans font 호출 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- jQuery 호출 -->
<link rel="shortcut icon" href="images/favicon.ico">

<title>로그인전 헤더</title>

</head>
<body>
	<nav>
		<div class="header_wrapper">
			<div class="header_inner">
				<ul class="header_menu">
					<li class="toplogo"><a title="homepage" href="main.jsp">
							<div class="toplogo1">
								<div class="toplogo1-1"></div>
							</div>
					</a> <!-- 왓차 핑크 --></li>
					<li class="header_menu_regist">
						<button id="header_regist_id"
							class="header_button_regist header_button_regist_box">회원가입</button>
					</li>
					<li class="header_menu_login">
						<button id="header_login_id"
							class="header_button_login header_button_login_box2">로그인</button>
					</li>
				</ul>
				<div class="headercenter1">
					<div class="headercenter1-1">
						<form id="search" action="searchresult.jsp" method="get">
							<label class="searchbox1">
								<div class="flex1">
									<input id="search" name="userinput" type="search"
										label="Search" placeholder="작품 제목, 배우, 감독을 검색해보세요."
										autocomplete="off" class="search" value="<%if(userInputForHeader!=null)%><%=userInputForHeader %>"
										onkeydown="if(event.keyCode==13){submit();}">
								</div>
								<div class="xicon1">
									<span aria-label="clear" role="button" class="xicon1-1"></span>
								</div>
							</label>
						</form>
					</div>
				</div>
			</div>
		</div>
	</nav>
	<!-- 아래 부분은 로그인 부분입니다. -->
	<div class="loginpopup">
		<%@ include file="loginpopup.jsp"%>
	</div>
	<!-- 아래 부분은 회원가입 부분입니다. -->
	<div class="registpopup">
		<%@ include file="registpopup.jsp"%>
	</div>
	<script type="text/javascript" src="js/main.js"></script>
	<script>
		var delConButton = document.getElementsByClassName("xicon1-1");
		
		delConButton[0].addEventListener("click", function(){
			search[1].value = "";
		});
	</script>
</body>
</html>