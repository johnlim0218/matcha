<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dataBase.WishListHandler"%>
<%
	request.setCharacterEncoding("UTF-8");

	String sIdx = (String) session.getAttribute("sIdx");
	String sUserId = (String) session.getAttribute("sUserid");
	String sName = (String) session.getAttribute("sName");
	String movieCd = (String) request.getParameter("movieCd");

	boolean dbCheck = false;
	WishListHandler wishListHandler = new WishListHandler();
	if (sIdx != null) {
		dbCheck = wishListHandler.connectJspToDBConnectorForWishList(request, response, movieCd);
		if (dbCheck == true) {
			%>
			<script>
				alert("이미 등록된 정보입니다");
			</script>
			<%
				} else if (dbCheck == false) {
			%>
			<script>
				alert("등록되었습니다");
			</script>
			
			<%
				}
				} else {
			%>
			<script>
				alert("로그인 해주세요");
			</script>
			<%
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		history.back();
	</script>
</body>
</html>