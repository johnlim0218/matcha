<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %> 

<%
	Connection conn = null;
	PreparedStatement pstmt = null;

	request.setCharacterEncoding("UTF-8");
	String movieCd			= request.getParameter("movieCd");
	String movieNm 			= request.getParameter("movieNm");
	String movieNmEn 		= request.getParameter("movieNmEn");
	String movieprdtYear 	= request.getParameter("movieprdtYear");
	String movieopenDt 		= request.getParameter("movieopenDt");
	String movienationAlt 	= request.getParameter("movienationAlt");
	String genreAlt 		= request.getParameter("genreAlt");
	String imgUrl			= request.getParameter("imgUrl");
	out.println(movieCd);
	try{
		Class.forName("org.mariadb.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/matcha", "root", "1234");

		String sql = "update movieinfo set movieNm=?, movieNmEn=?, movieprdtYear=?, movieopenDt=?, movienationAlt=?, genreAlt=?, imgUrl=? where movieCd=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, movieNm);
		pstmt.setString(2, movieNmEn);
		pstmt.setString(3, movieprdtYear);
		pstmt.setString(4, movieopenDt);
		pstmt.setString(5, movienationAlt);
		pstmt.setString(6, genreAlt);
		pstmt.setString(7, imgUrl);
		pstmt.setString(8, movieCd);
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
		location.href= "m_datatitle.jsp?paging1=0";
	</script>
</body>
</html>