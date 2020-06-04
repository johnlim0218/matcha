<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %> 
<%

	Connection conn = null;
	ResultSet  rs = null;	
	PreparedStatement pstmt = null;

	request.setCharacterEncoding("UTF-8");
	String movieCd = request.getParameter("movieCd");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글보기</title>
</head>
<body>
	<h1>영화데이터보기</h1>
<%
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
			<style>
				.box1 {
					display:inline-block;
				}
				.posterimg {
					display:inline-block;
				    position:relative;
				    z-index:1; /* 겹쳤을 때 우선순위(낮을수록 뒤로간다.) */
				    background:url("<%=imgUrl%>") no-repeat center; /* no-repeat : 배경의 크기가 화면보다 작아도 반복되지 않게 해준다. */
				    background-size:cover;
				    width:150px;
				    height:200px;
				    margin-left: 10%;
				}
			
			</style>
			<h2>글보기</h2>
			<div class="box1">
				<p>영화코드 : <%=movieCd %></p>
				<p>영화제목 : <%=movieNm%></p>
				<p>영화제목(En) : <%=movieNmEn%></p>
				<p>영화장르 : <%=genreAlt%></p>
				<p>제작년도 : <%=movieprdtYear%></p>
				<p>국내개봉일 : <%=movieopenDt%></p>
				<p>제작국가 : <%=movienationAlt%></p>
			</div>
			
			<div class="posterimg"></div>
			<p><a href="m_datatitle.jsp?paging1=0">리스트</a> | <a href="m_dataedit1.jsp?movieCd=<%=movieCd%>">영화데이터수정</a> | <a href="m_datadelete1.jsp?movieCd=<%=movieCd%>">영화데이터삭제</a></p>
<%
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
%>

</body>
</html>

	