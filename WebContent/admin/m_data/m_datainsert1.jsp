<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %> 
<%
	request.setCharacterEncoding("UTF-8");
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화데이터추가</title>
</head>
<body>
	<h2>영화 데이터 추가 페이지</h2>

		<form name="bForm" method="post" action="m_datainsert1P.jsp">
			<p><label>인물코드 : <input type="text" name="peoCd"></label></p>
			<p><label>인물이름 : <input type="text" name="peopleNm"></label></p>
			<p><label>인물이름(En) : <input type="text" name="peopleNmEn""></label></p>
			<p><label>출연영화 : <input type="text" name="movieNm""></label></p>
			<p><label>출연영화코드 : <input type="text" name="movieCd"></label></p>
			<p><label>출연영화배역 : <input type="text" name="moviePartNm"></label></p>
			<p><label>인물이미지링크 : <input type="text" name="peoImgUrl"></label></p>
			<p><label>포스터이미지링크 : <input type="text" name="imgUrl"></label></p>
			<p><input type="submit" value="수정완료"></p>
		</form>
		<p><a href="m_datapeople.jsp?paging1=0">뒤로가기</a></p>
</body>
</html>

	