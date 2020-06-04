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
<link rel="stylesheet" href="css/headerinc_css.css">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- jQuery 호출 -->
<link
	href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900"
	rel="stylesheet">
<!-- google noto-sans font 호출 -->
<link rel="shortcut icon" href="images/favicon.ico">
</head>
<body>

	<nav>
		<div>
			<div class="headerbox01">
				<ul class="headerside">
					<li class="toplogo"><a title="homepage" href="main.jsp">
							<div class="toplogo1">
								<div class="toplogo1-1"></div>
							</div>
					</a> <!-- 왓차 핑크 --></li>
					<li class="topicon"><a title="mypage" href="mypage.jsp">
							<div class="topicon1">
								<div class="topicon1-1"></div>
							</div>
					</a></li>
				</ul>
				<div class="headercenter1">
					<div class="headercenter1-1">
						<form id="search" action="searchresult.jsp" method="get">
							<label class="searchbox1">
								<div class="flex1">
									<!-- 검색 부분 -->
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
	<script>
		var delConButton = document.getElementsByClassName("xicon1-1");
		
		delConButton[0].addEventListener("click", function(){
			search[1].value = "";
		});
	</script>

</body>
</html>