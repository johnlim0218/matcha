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
	String peopleNm1 = request.getParameter("peopleNm");
%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<title>영화데이터 관리</title>
<link rel="stylesheet" href="data.css" type="text/css">
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

						String sql = "select distinct peoCd from peopleinfo where peopleNm like ? order by peoCd desc";
						pstmt = conn.prepareStatement(sql);

						pstmt.setString(1, "%" + peopleNm1 + "%");
						pstmt.executeUpdate();

						rs = pstmt.executeQuery();
						while (rs.next()) {
							boardSum += 1;
						}
						pageSum = boardSum / 10;

						sql = "select distinct peoCd, peopleNm, peopleNmEn from peopleinfo where peopleNm like ? order by peoCd desc limit "
								+ paging1 + ", 10";
						pstmt = conn.prepareStatement(sql);

						pstmt.setString(1, "%" + peopleNm1 + "%");
						pstmt.executeUpdate();

						rs = pstmt.executeQuery();
				%>
				<tr>
					<td width="50" align="center">인물코드</td>
					<td width="300" align="center">인물 이름</td>
					<td width="300" align="center">영문 이름</td>
				</tr>
				<%
					while (rs.next()) {
							String peoCd = rs.getString("peoCd");
							String peopleNm = rs.getString("peopleNm");
							String peopleNmEn = rs.getString("peopleNmEn");
				%>
				<tr>
					<td width="50" align="center"><a
						href="m_dataview2.jsp?peoCd=<%=peoCd%>"><%=peoCd%></a></td>
					<td width="320" align="center"><a
						href="m_dataview2.jsp?peoCd=<%=peoCd%>"><%=peopleNm%></a></td>
					<td width="80" align="center"><%=peopleNmEn%></td>
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
				<a href="m_datapeople.jsp?paging1=<%=pageNum%>"><%=i + 1%></a>
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
					action="m_datasearch2.jsp">
					<input type="text" name="peopleNm"> <input type="hidden"
						name="paging1" value="0"> <input align="center"
						type="submit" value="검색">
				</form>
			</div>
			<div class="updatebt">
				<p>
					<input type="button" value="인물데이터추가" onclick="insertData()">
				</p>
			</div>
		</div>
	</footer>


	</div>

</body>

</html>