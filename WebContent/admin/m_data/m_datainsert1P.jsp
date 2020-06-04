<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@page import="exam.jdbc.ManagePeopleDAO"%>
<jsp:useBean id="bean" class="exam.jdbc.ManagePeopleBean" />
<jsp:setProperty property="*" name="bean" />
<% 
		
		ManagePeopleDAO dao = ManagePeopleDAO.getInstance();
 		dao.insertPeople(bean);
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
		location.href="m_datapeople.jsp?paging1=0";	
	</script>
</body>
</html>