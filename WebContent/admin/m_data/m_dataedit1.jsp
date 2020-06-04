<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %> 
<%
	Connection conn = null;
	ResultSet  rs = null;	
	PreparedStatement pstmt = null;

	request.setCharacterEncoding("UTF-8");
	String movieCd = request.getParameter("movieCd");

	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/matcha", "root", "1234");
	
	String sql = "select movieCd, movieNm, movieNmEn, movieprdtYear, movieopenDt, movienationAlt, genreAlt, imgUrl from movieinfo where movieCd=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, movieCd);
	rs = pstmt.executeQuery();
	
	
	if(rs.next())
	{
		try{
			String movieNm 			= rs.getString("movieNm");
			String movieNmEn 		= rs.getString("movieNmEn");
			String movieprdtYear 	= rs.getString("movieprdtYear");
			String movieopenDt 		= rs.getString("movieopenDt");
			String movienationAlt 	= rs.getString("movienationAlt");
			String genreAlt 		= rs.getString("genreAlt");
			String imgUrl			= rs.getString("imgUrl");
			
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정페이지</title>
</head>
<body>
	<h2>수정 페이지</h2>

		<form name="bForm" method="post" action="m_dataedit1P.jsp">
			<p>영화코드 : <%=movieCd%></p>
			<input type="hidden" name="movieCd" value="<%=movieCd%>">
			<p><label>영화제목 : <input type="text" name="movieNm" value="<%=movieNm%>"></label></p>
			<p><label>영화제목(En) : <input type="text" name="movieNmEn" value="<%=movieNmEn%>"></label></p>
			<p><label>영화장르 : <input type="text" name="genreAlt" value="<%=genreAlt%>"></label></p>
			<p><label>제작년도 : <input type="text" name="movieprdtYear" value="<%=movieprdtYear%>"></label></p>
			<p><label>국내개봉일 : <input type="text" name="movieopenDt" value="<%=movieopenDt%>"></label></p>
			<p><label>제작국가 : <input type="text" name="movienationAlt" value="<%=movienationAlt%>"></label></p>
			<p><label>포스터이미징크 : <input type="text" name="imgUrl" value="<%=imgUrl%>"></label></p>
			<p><input type="submit" value="수정완료"></p>
		</form>
		<p><a href="m_dataview1.jsp?movieCd=<%=movieCd%>">뒤로가기</a></p>
<%
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
%>
</body>
</html>

	