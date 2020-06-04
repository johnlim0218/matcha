<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %> 
<%
	Connection conn = null;
	ResultSet  rs = null;	
	PreparedStatement pstmt = null;

	request.setCharacterEncoding("UTF-8");
	String peoCd = request.getParameter("peoCd");
	String movieCd = request.getParameter("movieCd");

	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/matcha", "root", "1234");
	
	String sql = "select peopleNm, peopleNmEn, movieNm, moviePartNm, imgUrl from peopleinfo where peoCd=? and movieCd=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, peoCd);
	pstmt.setString(2, movieCd);
	rs = pstmt.executeQuery();
	
	
	if(rs.next())
	{
		try{
			String peopleNm 		= rs.getString("peopleNm");
			String peopleNmEn 	= rs.getString("peopleNmEn");
			String movieNm		= rs.getString("movieNm");
			String moviePartNm		= rs.getString("moviePartNm");
			String imgUrl		= rs.getString("imgUrl");
			
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정페이지</title>
</head>
<body>
	<h2>수정 페이지</h2>

		<form name="bForm" method="post" action="m_dataedit3P.jsp">
			<p>인물코드 : <%=peoCd%>"</p>
			<input type="hidden" name="peoCd" value="<%=peoCd%>">
			<p>인물이름 : <%=peopleNm%></p>
			<p>인물이름(En) : <%=peopleNmEn%></p>
			<p>영화코드 : <%=movieCd%></p>
			<input type="hidden" name="movieCd" value="<%=movieCd%>">
			<p><label>영화제목 : <input type="text" name="movieNm" value="<%=movieNm%>"></label></p>
			<p><label>영화배역 : <input type="text" name="moviePartNm" value="<%=moviePartNm%>"></label></p>
			<p><label>영화포스터 이미지URL : <input type="text" name="imgUrl" value="<%=imgUrl%>"></label></p>
			<p><input type="submit" value="수정완료"></p>
		</form>
		<p><a href="m_dataview2.jsp?peoCd=<%=peoCd%>">뒤로가기</a></p>
<%
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
%>
</body>
</html>

	