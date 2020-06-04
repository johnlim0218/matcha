<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Driver"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userid = request.getParameter("id");
	String pwd = request.getParameter("pw");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	if(gender.equals("남자") || gender.equals("여자")){
		if(gender.equals("남자")){
			gender = "남";
		}
		if(gender.equals("여자")){
			gender = "여";
		}
	}
	//String address = request.getParameter("address");
%>

<%-- <%=userid %> --%>
<%-- <%=pwd %> --%>
<%-- <%=name %> --%>
<%-- <%=gender %> --%>
<%-- <%=address %> --%>
<!-- 값 전달 확인용 주석 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String dburl ="";
	String dbid = "";
	String dbpwd = "";
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int result = 0;
	
	try {
		Class.forName("org.mariadb.jdbc.Driver");
		dburl="jdbc:mariadb://localhost:3306/website?autoReconnect=true&";
		dbid = "root";
		dbpwd = "1234";
		Connection con = DriverManager.getConnection(dburl, dbid, dbpwd);
		String dbsql = "insert into member1 (mem_userid, mem_pwd, mem_name, mem_gender) "
				+ "values (?, password(?), ?, ?)";
		pstmt = con.prepareStatement(dbsql);
		pstmt.setString(1, userid);
		pstmt.setString(2, pwd);
		pstmt.setString(3, name);
		pstmt.setString(4, gender);
		//pstmt.setString(5, address);
		result = pstmt.executeUpdate();
		if (result == 1) {
		%>
			<script>
				alert("회원가입 되었습니다.");
				location.href="main.jsp";
			</script>
		<%
		} else {
			out.println("회원가입실패");
		}
	} catch (Exception e) {
		out.println("DB 연결 실패" + e.getMessage());
	} 
	// 회원 탈퇴
%>
</body>
</html>