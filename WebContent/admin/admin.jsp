<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String sPower = (String) session.getAttribute("sPower");
%>

<!DOCTYPE html>
<html lang="ko">

<head>
<link rel="stylesheet" href="admin.css" type="text/css">
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
<meta charset="UTF-8">
<title>관리자 페이지</title>
</head>

<body>
	<div>
		<header class="box">
			<div class="subj">
				<div>
					<a href="../main.jsp"> <span src="images/logo.png" class="logo"></span></a>
				</div>
				<div class="subjbox">
					<h1>관리자 페이지</h1>
				</div>
			</div>
		</header>
	</div>
	<section>

		<div class="midheader">
			<div class="midblank">
				<li class="list1">
					<p class="list">
						<a href="m_member/adminmember.jsp?paging1=0" title="회원관리페이지">회원관리</a>
					</p>
				</li>
				<li class="list1">
					<p class="list">
						<a href="m_board/MainpageT.jsp" title="게시판 관리">게시판 관리</a>
					</p>
				</li>
				<li class="list1">
					<p class="list">
						<a href="m_data/m_datamanage.jsp" title="영화 데이터 관리">영화 데이터 관리</a>
					</p>
				</li>
			</div>
		</div>
	</section>
	</div>

</body>

</html>