<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;    
	
	request.setCharacterEncoding("UTF-8");
	String useridx = (String)session.getAttribute("sIdx");
	String userid = request.getParameter("id");
	String pwd = request.getParameter("pw");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
try {
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/website", "root", "1234");
	String sql = "select mem_idx, mem_userid, mem_name, mem_power from member1 where mem_userid = ? and mem_pwd = password(?)"; // pwd=password(?);
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, userid);
	pstmt.setString(2, pwd);
	rs = pstmt.executeQuery();
	
	
	if (rs.next()) {
		try {
			String mem_idx = rs.getString("mem_idx");
			String mem_userid = rs.getString("mem_userid");
			String mem_name = rs.getString("mem_name");
			String mem_power = rs.getString("mem_power");
			session.setAttribute("sIdx", mem_idx);
			session.setAttribute("sUserid", mem_userid);
			session.setAttribute("sName", mem_name);
			session.setAttribute("sPower", mem_power);
%>
		<script>
		alert("로그인 되었습니다.");
		location.href="main.jsp";
		</script>
<%
		} catch(Exception e) {
			e.printStackTrace();
		}
	} else {
%>
	<script>
		alert("아이디 또는 패스워드가 잘못 되었습니다.");
		history.back();
	</script>
<%
	}
} catch (Exception e) {
} finally {
	rs.close();
	pstmt.close();
	conn.close();
}

System.out.println(session.getAttribute("sPower"));
%>
</body>
</html>