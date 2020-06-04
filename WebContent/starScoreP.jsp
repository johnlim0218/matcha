<%@page import="dataBase.StarScoreHandler"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String sIdx = (String) session.getAttribute("sIdx");
	String sUserId = (String) session.getAttribute("sUserid");
	String sName = (String) session.getAttribute("sName");

	String movieCd = request.getParameter("movieCd");
	String starScore = request.getParameter("starScore");
	
	StarScoreHandler starScoreHandler = new StarScoreHandler();
	
	if(sIdx == null){
%>		
		<script>
			alert("로그인해주세요");
			window.history.back();
		</script>	
<%		
	} else if(sIdx != null){
		starScoreHandler.connectJspToDBConnectorForStarScore(movieCd, sIdx, starScore);
%>
		<script>
			alert("평점을 매겼습니다");
			location.href = "moreinfo.jsp?movieCd=" + <%=movieCd%>;
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

</body>
</html>