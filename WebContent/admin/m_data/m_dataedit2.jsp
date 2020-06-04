<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %> 
<%
	Connection conn = null;
	ResultSet  rs = null;	
	PreparedStatement pstmt = null;

	request.setCharacterEncoding("UTF-8");
	String peoCd = request.getParameter("peoCd");

	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/matcha", "root", "1234");
	
	String sql = "select peopleNm, peopleNmEn, peoImgUrl from peopleinfo where peoCd=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, peoCd);
	rs = pstmt.executeQuery();
	
	
	if(rs.next())
	{
		try{
			String peopleNm 		= rs.getString("peopleNm");
			String peopleNmEn 	= rs.getString("peopleNmEn");
			String peoImgUrl 		= rs.getString("peoImgUrl");
			
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정페이지</title>
</head>
<body>
	<h2>수정 페이지</h2>

		<form name="bForm" method="post" action="m_dataedit2P.jsp">
			<p>인물코드 : <%=peoCd%>"</p>
			<input type="hidden" name="peoCd" value="<%=peoCd%>">
			<p><label>인물이름 : <input type="text" name="peopleNm" value="<%=peopleNm%>"></label></p>
			<p><label>인물이름(En) : <input type="text" name="peopleNmEn" value="<%=peopleNmEn%>"></label></p>
			<p><label>인물사진(Url) : <input type="text" name="peoImgUrl" value="<%=peoImgUrl%>"></label></p>
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

	