<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<%
	String sPower = (String) session.getAttribute("sPower");
%>
<head>
<meta charset="UTF-8">
<title>영화데이터 관리</title>
<link rel="stylesheet" href="data.css" type="text/css">
<%
	if (sPower.equals("관리자")) {
		// sPower session 값이 admin인 경우 admin.jsp창으로 이동

	} else {
		// sPower session값이 관리자가 아닐때만 response.redirect로 main페이지 출력
%>
<script>
	alert("관리자 계정만 접속할 수 있습니다");
	location.href = "../main.jsp";
</script>
<%
	}
%>
</head>

<body>
	<header class="box">
		<div class="subj">
			<div>
				<a href="../../main.jsp"> <span src="images/logo.png"
					class="logo"></span></a>
			</div>
			<div class="subjbox">
				<h1>
					<a class="subjecttitle" href="../admin.jsp">영화데이터 관리</a>
				</h1>
			</div>
		</div>
	</header>
	<section>

		<div class="midheader">
			<div class="midblank">
				<li class="list1">
					<p class="list">
						<a href="m_datatitle.jsp?paging1=0">영화명</a>
					</p>
				</li>
				<li class="list1">
					<p class="list">
						<a href="m_datapeople.jsp?paging1=0">영화인</a>
					</p>
			</div>
		</div>


	</section>



</body>

</html>