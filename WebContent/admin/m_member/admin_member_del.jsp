<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 
<jsp:useBean id="dao" class="exam.jdbc.JDBC_memberDAO"/>

<%
	//넘어온 id값 받아서 삭제하는 메소드 호출
	
	int result = dao.delMemberlist(request.getParameter("mem_userid"));
	
	String message = "삭제되지 않았습니다.";
	if(result >0){
		message = "삭제되었습니다.";
	}
			
%>
<script>
	alert("<%=message%>");
	location.href = "adminmember.jsp"
</script>

</body>
</html>