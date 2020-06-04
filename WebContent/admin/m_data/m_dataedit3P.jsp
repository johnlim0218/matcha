<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %> 

<%
	Connection conn = null;
	PreparedStatement pstmt = null;

	request.setCharacterEncoding("UTF-8");
	String peoCd		= request.getParameter("peoCd");
	String movieCd 		= request.getParameter("movieCd");
	String movieNm		= request.getParameter("movieNm");
	String moviePartNm	= request.getParameter("moviePartNm");
	String imgUrl		= request.getParameter("imgUrl");
	out.println(peoCd);
	try{
		Class.forName("org.mariadb.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/matcha", "root", "1234");

		String sql = "update peopleinfo set movieNm=?, moviePartNm=?, imgUrl=? where peoCd=? and movieCd=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, movieNm);
		pstmt.setString(2, moviePartNm);
		pstmt.setString(3, imgUrl);
		pstmt.setString(4, peoCd);
		pstmt.setString(5, movieCd);
		pstmt.executeUpdate();
		out.println(pstmt);
	}catch(Exception e){
		out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		e.printStackTrace();
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
		alert("영화정보가 수정되었습니다..");
		location.href= "m_dataview2.jsp?peoCd=<%=peoCd%>";
	</script>
</body>
</html>