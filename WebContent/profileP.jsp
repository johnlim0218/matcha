<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	// 아래 부분은 JSP 입니다.
	// 전 페이지로부터 form 형식의 데이터를 받아옵니다.
	String userName = (String)request.getParameter("userName");
	String userID = (String)request.getParameter("userID");
	String userPassword = (String)request.getParameter("userPassword");
	String userGender = (String)request.getParameter("userGender");
	
	String useridx = (String)session.getAttribute("sIdx");
	
	
	/*
	out.println(userName);
	out.println(userID);
	out.println(userPassword);
	out.println(userGender);
	*/
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int result = 0;
	try{
		Class.forName("org.mariadb.jdbc.Driver");
   	 String dburl="jdbc:mariadb://localhost:3306/website?autoReconnect=true&";
   	 String dbid = "root";
   	 String dbpwd = "1234";
   	 Connection con = DriverManager.getConnection(dburl, dbid, dbpwd);
   	 
 	  String dbsql = "UPDATE member1 set mem_name=?, mem_userid=?, mem_pwd=password(?), mem_gender=? where mem_idx="+useridx;
 	  pstmt = con.prepareStatement(dbsql);
 	  pstmt.setString(1, userName);
 	  pstmt.setString(2, userID);
 	  pstmt.setString(3, userPassword);
 	  pstmt.setString(4, userGender);
  	  result = pstmt.executeUpdate();
  		if (result == 1) {
		out.println("<script>");
		out.println("alert('정보가 수정되었습니다.');");
		out.println("location.href='profile.jsp';");
		out.println("</script>");
		} else{
			out.println("정보수정실패");
			
		} 
	} catch (Exception e) {
		out.println("DB연결 실패" + e.getMessage());
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- DB 연결 > UPDATE SQL > alert 완료되었습니다. > 정보수정 페이지로 response.sendredirect -->
<!-- [부가적] DB 연결 > 기존 정보를 읽어와서 정보수정 페이지에 찍어주고 > 사용자 수정 > 서브밋 > 이 페이지로 넘어온다. -->
</body>
</html>