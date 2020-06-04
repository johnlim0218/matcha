<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");

	String sIdx = (String) session.getAttribute("sIdx");
	String sUserId = (String) session.getAttribute("sUserid");
	String sName = (String) session.getAttribute("sName");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/headerinc_css.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- jQuery 호출 -->
<link rel="shortcut icon" href="images/favicon.ico">
<link href="css/loading.css" rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900"
	rel="stylesheet">
<!-- google noto-sans font 호출 -->
<title>Insert title here</title>
</head>
<body>
	
	<nav>
		<div>
			<div class="headerbox01">
				<ul class="headerside">
					<li class="toplogo"><a href="main.jsp">
							<div class="toplogo1">
								<div class="toplogo1-1"></div>
							</div>
					</a></li>
					<li class="topicon"><a href="mypage.jsp">
							<div class="topicon1">
								<div class="topicon1-1"></div>
							</div>
					</a></li>
					<li class="topicon"><a href="logoutP.jsp"
						class="header_button_login header_button_login_box"
						style="text-decoration: none;">로그아웃</a></li>
					<li class="topicon"><a href="board_list.jsp?pages=1"
						class="header_button_login header_button_login_box"
						style="text-decoration: none;">코멘트</a></li>
				</ul>

			</div>
		</div>
	</nav>
</body>
</html>