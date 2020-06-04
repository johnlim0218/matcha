<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="exam.jdbc.ManageMovieDAO"%>
<jsp:useBean id="bean" class="exam.jdbc.ManageMovieBean" />
<jsp:setProperty property="*" name="bean" />
<% 
		ManageMovieDAO dao = ManageMovieDAO.getInstance();
 		dao.deleteMovie(bean);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		alert("영화정보가 삭제되었습니다..");
		location.href="m_datatitle.jsp?paging1=0";	
	</script>
</body>
</html>