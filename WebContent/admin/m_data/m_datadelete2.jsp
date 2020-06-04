<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="exam.jdbc.ManagePeopleDAO"%>
<jsp:useBean id="bean" class="exam.jdbc.ManagePeopleBean" />
<jsp:setProperty property="*" name="bean" />
<% 
		ManagePeopleDAO dao = ManagePeopleDAO.getInstance();
 		dao.deletePeople(bean);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		alert("인물정보가 삭제되었습니다..");
		location.href="m_datapeople.jsp?paging1=0";	
	</script>
</body>
</html>