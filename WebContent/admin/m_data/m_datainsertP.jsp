<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@page import="exam.jdbc.ManageMovieDAO"%>
<jsp:useBean id="bean" class="exam.jdbc.ManageMovieBean" />
<jsp:setProperty property="*" name="bean" />
<%
		ManageMovieDAO dao = ManageMovieDAO.getInstance();
 		dao.insertMovie(bean);
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
</head>
<body>
	<script>
		alert("영화 데이터가 추가 되었습니다");
		location.href="m_datatitle.jsp?paging1=0";	
	</script>
</body>
</html>