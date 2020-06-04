<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String useridx = (String)session.getAttribute("sIdx");
	String sUserid = (String)session.getAttribute("sUserid");
	String sName = (String)session.getAttribute("sName");
	String b_idx = (String)session.getAttribute("b_idx");
	String b_title = (String)request.getParameter("b_title");
	String b_email = (String)request.getParameter("b_email");
	String b_content = (String)request.getParameter("b_content");
	String b_ip = request.getRemoteAddr();
	
	PreparedStatement pstmt = null;
	Connection conn = null;
	int result = 0;
	
	if(useridx == null || useridx.equals("")){
		response.sendRedirect("member1_2.jsp");	// 로그인
	}
	
	try {
		Class.forName("org.mariadb.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/website", "root", "1234");
		String sql = "delete from board1 where b_useridx="+useridx+" and b_idx = "+b_idx;
		pstmt = conn.prepareStatement(sql);
		result = pstmt.executeUpdate();
	} catch (Exception e) {
		e.getMessage();
	} finally {
		
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
			alert("삭제가 완료되었습니다.");
			location.href="board_list.jsp?pages=1";
		</script>
</body>
</html>