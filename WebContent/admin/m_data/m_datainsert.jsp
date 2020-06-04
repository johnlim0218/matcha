<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %> 
<%
	request.setCharacterEncoding("UTF-8");
	String movieCd = request.getParameter("movieCd");
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화데이터추가</title>
</head>
<body>
	<h2>영화 데이터 추가 페이지</h2>

		<form name="bForm" method="post" action="m_datainsertP.jsp">
			<p><label>영화코드 : <input type="text" name="movieCd"></label></p>
			<p><label>영화제목 : <input type="text" name="movieNm"></label></p>
			<p><label>영화제목(En) : <input type="text" name="movieNmEn""></label></p>
			<p><label>영화장르 : <input type="text" name="genreAlt""></label></p>
			<p><label>제작년도 : <input type="text" name="movieprdtYear"></label></p>
			<p><label>국내개봉일 : <input type="text" name="movieopenDt"></label></p>
			<p><label>제작국가 : <input type="text" name="movienationAlt"></label></p>
			<p><label>포스터이미지링크 : <input type="text" name="imgUrl"></label></p>
			<p><input type="submit" value="수정완료"></p>
		</form>
		<p><a href="m_datatitle.jsp?paging1=0">뒤로가기</a></p>
</body>
</html>

	