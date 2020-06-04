<%@page import="javax.websocket.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	String filecheck = null;
	int boardSum = 0;
	int pageSum = 0;
	String paging1 = "hi";
	String movieNm1 = request.getParameter("movieNm");
	session.setAttribute("movieNm1", movieNm1);
%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<title>영화데이터 관리</title>
<link rel="stylesheet" href="data.css" type="text/css">
<script>
	function insertData() {
		location.href = "m_datainsert.jsp";
	}
</script>
</head>

<body>
	<div>
		<header class="box">
			<div class="subj">
				<div>
					<a href="#"> <span src="images/logo.png" class="logo"></span></a>
				</div>
				<div class="subjbox">
					<h1>
						<a class="subjecttitle" href="../admin.jsp">영화데이터 관리</a>
					</h1>
				</div>
			</div>
		</header>
	</div>
	<section>
		<div class="midheader">
			<%
				paging1 = request.getParameter("paging1");
			%>
			<table width="800" align="center">
				<%
					try {
						Class.forName("org.mariadb.jdbc.Driver");
						conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/matcha", "root", "1234");

						String sql = "select movieCd from movieinfo where movieNm like ? order by movieCd desc";
						pstmt = conn.prepareStatement(sql);

						pstmt.setString(1, "%" + movieNm1 + "%");
						pstmt.executeUpdate();

						rs = pstmt.executeQuery();
						while (rs.next()) {
							boardSum += 1;
						}
						pageSum = boardSum / 10;

						sql = "select movieCd, movieNm, movieNmEn, movieprdtYear, movienationAlt from movieinfo where movieNm like ? order by movieCd desc limit "
								+ paging1 + ", 10";
						pstmt = conn.prepareStatement(sql);

						pstmt.setString(1, "%" + movieNm1 + "%");
						pstmt.executeUpdate();

						rs = pstmt.executeQuery();
				%>
				<tr>
					<td width="50" align="center">영화코드</td>
					<td width="300" align="center">영화 제목</td>
					<td width="300" align="center">영문 제목</td>
					<td width="50" align="center">제작 연도</td>
					<td width="50" align="center">국가</td>
				</tr>
				<%
					while (rs.next()) {
							String movieCd = rs.getString("movieCd");
							String movieNm = rs.getString("movieNm");
							String movieNmEn = rs.getString("movieNmEn");
							String movieprdtYear = rs.getString("movieprdtYear");
							String movienationAlt = rs.getString("movienationAlt");
				%>
				<tr>
					<td width="50" align="center"><a
						href="m_dataview1.jsp?movieCd=<%=movieCd%>"><%=movieCd%></a></td>
					<td width="320" align="center"><a
						href="m_dataview1.jsp?movieCd=<%=movieCd%>"><%=movieNm%></a></td>
					<td width="80" align="center"><%=movieNmEn%></td>
					<td width="80" align="center"><%=movieprdtYear%></td>
					<td width="190" align="center"><%=movienationAlt%></td>
				</tr>
				<%
					}
					} catch (Exception e) {
						e.printStackTrace();
						out.println("board_list페이지 오류");
					} finally {
						if (rs != null)
							try {
								rs.close();
							} catch (SQLException sqle) {
							}
						if (pstmt != null)
							try {
								pstmt.close();
							} catch (SQLException sqle) {
							}
						if (conn != null)
							try {
								conn.close();
							} catch (SQLException sqle) {
							}
					}
				%>
			</table>
		</div>
		<div class="pagebox">
			<p class="pagenum">
				<%
					for (int i = 0; i <= pageSum; i++) {
						int pageNum = i;
						if (pageNum != 0) {
							pageNum = i * 10;
						}
				%>
				<a href="m_datatitle.jsp?paging1=<%=pageNum%>"><%=i + 1%></a>
				<%
					}
				%>
			</p>
		</div>
	</section>
	<footer>
		<div class="footerbox">
			<div class="searchbox">
				<form align="center" name="bForm" method="post"
					action="m_datasearch1.jsp">
					<input type="text" name="movieNm"> <input type="hidden"
						name="paging1" value="0"> <input align="center"
						type="submit" value="검색">
				</form>
			</div>
			<div class="updatebt">
				<p>
					<input type="button" value="영화데이터추가" onclick="insertData()">
				</p>
			</div>
		</div>
		<a href="m_datamanage.jsp">영화관리페이지로</a>
	</footer>


	</div>

</body>

</html>