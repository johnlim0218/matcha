<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	try {
		request.setCharacterEncoding("UTF-8");
		String useridx = (String) session.getAttribute("sIdx");
		String sUserid = (String) session.getAttribute("sUserid");
		String b_ip = request.getRemoteAddr();
		String pages = request.getParameter("pages");
		String movieCd = request.getParameter("movieCd");
		String movieNm = request.getParameter("movieNm");
		int sqlpage = 0;
	
		if (Integer.parseInt(pages) >= 2) {
			sqlpage = (Integer.parseInt(pages) - 1) * 20;
		} else {
			sqlpage = 0;
		}

		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;

		if (useridx == null || useridx.equals("")) {
			%>
			<script>
			alert("로그인해주세요");
			window.history.back();
			</script>
			<%
		}

		Class.forName("org.mariadb.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/website", "root", "1234");
		String sql = "";
		
		if (movieCd == null) {
			
			sql = "select b_idx, b_useridx, b_name, b_title, b_email, b_content, b_file, b_regdate, b_hit from board1 order by b_idx desc limit "
					+ sqlpage + ", 20";
			pstmt = conn.prepareStatement(sql);
		} else if (movieCd != null) {
		
			sql = "select b_idx, b_useridx, b_name, b_title, b_email, b_content, b_file, b_regdate, b_hit from board1 where b_moviecd = ? order by b_idx desc limit "
					+ sqlpage + ", 20";
		
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, movieCd);
			
		}
		
		rs = pstmt.executeQuery();
		
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/Board_list_css.css">
<title>Insert title here</title>
</head>
<body>
	<header>
		<%@ include file="headerinc.jsp"%>
	</header>
	<div class="board_container">
		<center>
		<%if(movieNm == null) {%> 
			<h2>코멘트 리스트 </h2>
			<%} else if(movieNm != null) {%>
			<h2><%=movieNm %></h2>
			<%} %>
		</center>

		<div class="menu">
			<table>
				<tr>
					<td width="10%">글번호</td>
					<td width="60%">제목</td>
					<td width="10%">작성자</td>
					<td width="10%">조회수</td>
					<td width="10%">작성일</td>
				</tr>
			</table>
		</div>
		<hr>
		<div class="content">
			<%
				while (rs.next()) {
						String b_idx = rs.getString("b_idx");
						String b_useridx = rs.getString("b_useridx");
						String b_name = rs.getString("b_name");
						String b_title = rs.getString("b_title");
						String b_email = rs.getString("b_email");
						String b_regdate = rs.getString("b_regdate").substring(0, 10);
						String b_file = rs.getString("b_file");
						String b_hit = rs.getString("b_hit");

						String c_cnt = "";
						String sql2 = "select count(c_idx) as c_cnt from comment1 where c_boardidx=?";
						pstmt = conn.prepareStatement(sql2);
						pstmt.setString(1, b_idx);
						ResultSet rs2 = pstmt.executeQuery();
						if (rs2.next()) {
							if (!rs2.getString("c_cnt").equals("0")) {
								c_cnt = "[" + rs2.getString("c_cnt") + "]";
							}
						}
			%>
			<table>
				<tr>
					<td width="10%"><%=b_idx%></td>
					<td width="60%"><a href="board_view.jsp?b_idx=<%=b_idx%>"><%=b_title%></a><%=c_cnt%></td>
					<td width="10%"><%=b_name%></td>
					<td width="10%"><%=b_hit%></td>
					<td width="10%"><%=b_regdate%></td>
					<td width="10%"></td>
				</tr>
			</table>
			<hr>
			<%
				}
				} catch (Exception e) {
					out.println(e.getMessage());
				} finally {

				}
			%>
			<span class="footer_pages"><a href="board_list.jsp?pages=1">1</a>
				| <a href="board_list.jsp?pages=2">2</a> | <a
				href="board_list.jsp?pages=3">3</a> | <a
				href="board_list.jsp?pages=4">4</a> | <a
				href="board_list.jsp?pages=5">5</a> </span> <span
				id="board_list_write_button"><a href="board_write.jsp">글쓰기</a></span>


		</div>
	</div>
</body>
</html>