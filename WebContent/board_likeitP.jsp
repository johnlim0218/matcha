<%@page import="dataBase.BoardHandler"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String b_idx = request.getParameter("b_idx");
	String movieCd = request.getParameter("movieCd");
	
	BoardHandler boardHandler = new BoardHandler();
	boardHandler.connectJspToDBConnectorForLikeit(b_idx);
%>
    <Script>
    	alert("좋아요를 누르셨습니다.");
    	location.href = "moreinfo.jsp?movieCd=" + <%=movieCd%>;
    </Script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>