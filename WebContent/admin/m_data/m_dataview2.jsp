<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %> 
<%

	Connection conn = null;
	ResultSet  rs = null;	
	PreparedStatement pstmt = null;

	request.setCharacterEncoding("UTF-8");
	String peoCd = request.getParameter("peoCd");
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
 
	
	String sql = "select distinct peopleNm, peopleNmEn, movieNm, movieCd, moviePartNm, imgUrl, peoImgUrl from peopleinfo where peoCd=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, peoCd);
	rs = pstmt.executeQuery();
	
	if(rs.next())
	{
		try{
			String peopleNm 		= rs.getString("peopleNm");
			String peopleNmEn 		= rs.getString("peopleNmEn");
			String peoImgUrl		= rs.getString("peoImgUrl");
%>	
			<style>
				.box1 {
					display:inline-block;
					position:relative;
					vertical-align: top;
					padding-left: 30px;
    				
				}
				.box2 {
					border: 1px solid black;
					margin-right: 40%;
					position:relative;
				}
				.box3 {
					padding-top: 50px;
				}
				.editbt {
					position:relative;
					margin: auto 0;
				}
				.peopleimg {
					display:inline-block;
				    position:relative;
				    z-index:1; /* 겹쳤을 때 우선순위(낮을수록 뒤로간다.) */
				    margin: 5% 0;
				    margin-left: 10%;
				}
				.posterimg {
					display:inline-block;
				    position:relative;
				    z-index:1; /* 겹쳤을 때 우선순위(낮을수록 뒤로간다.) */
				    float: right;
				    margin-top: 5%;
				    margin-right: 10%;
				}				
			
			</style>
			<h2>글보기</h2>
			<div class="box2">
				<div class="box1">
					<div class="box3">
						<p>인물코드 : <%=peoCd %></p>
						<p>인물이름 : <%=peopleNm%></p>
						<p>인물이름(En) : <%=peopleNmEn%></p>
					</div>
				</div>
				<div class="peopleimg">
					<img src="<%=peoImgUrl%>" width="150px" height="200px">
				</div>
				
			</div>
			
			<h1>출연 영화</h1>
		<%
				while(rs.next()){
					String movieNm 			= rs.getString("movieNm");
					String movieCd 			= rs.getString("movieCd");
					String moviePartNm 		= rs.getString("moviePartNm");
					String imgUrl			= rs.getString("imgUrl");
				
		%>

		<div class= "box2">
			<div class="box1">
				<p>영화코드 : <%=movieCd%></p>
				<p>영화제목 : <%=movieNm%></p>
				<p>영화배역 : <%=moviePartNm%></p>
			</div>
			<div class="posterimg">
				<img src="<%=imgUrl%>" width="50px" height="70px">
			</div>
			
		</div>
		<div class= "editbt">
			<form name="bForm" method="post" action="m_dataedit3.jsp">
				<input type="hidden" name="peoCd" value="<%=peoCd%>">
				<input type="hidden" name="movieCd" value="<%=movieCd%>">
				<input type="submit" value="수정"">
			</form>
		</div>

		
		<br/>
				
		<%
				}
		%>
			
			<p><a href="m_datapeople.jsp?paging1=0">리스트</a> | <a href="m_dataedit2.jsp?peoCd=<%=peoCd%>">인물데이터수정</a> | <a href="m_datadelete2.jsp?peoCd=<%=peoCd%>">인물데이터삭제</a></p>
<%
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
%>

</body>
</html>

	