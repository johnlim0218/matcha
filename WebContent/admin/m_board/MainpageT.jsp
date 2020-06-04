<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String sPower = (String) session.getAttribute("sPower");
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	String dburl = "jdbc:mariadb://localhost:3306/website?autoReconnect=true&";
	String dbid = "root";
	String dbpw = "1234";

	try {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection(dburl, dbid, dbpw);
		String dbsql = "select b_idx, B.b_useridx, b_name, b_title, b_email, b_content, b_file, b_regdate, b_hit, b_ip,mem_power from board1 B join member1 M on B.b_useridx = M.mem_idx order by b_regdate desc,b_idx desc limit 10";
		pstmt = conn.prepareStatement(dbsql);
		rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<link
	href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900&amp;subset=korean"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="MainpageT.css">
<%
	if (sPower.equals("관리자")) {
			// sPower session 값이 admin인 경우 admin.jsp창으로 이동

		} else {
			// sPower session값이 관리자가 아닐때만 response.redirect로 main페이지 출력
%>
<script>
	alert("관리자 계정만 접속할 수 있습니다");
	location.href = "../main.jsp";
</script>
<%
	}
%>
<meta charset="UTF-8">
<title>관리자페이지 - 게시판관리</title>
</head>
<body>
	<header class="box">
		<div class="subj">
			<a href="../../main.jsp"> <span src="images/logo.png"
				class="logo"></span></a>
			<h1>
				<a href="../admin.jsp">게시판 관리</a>
			</h1>
		</div>


		<div class="searchdiv_div2">
			<select name="category" class="category">
				<option value="title/all">제목검색</option>
				<option value="title/not">제목/공지사항</option>
				<option value="title/com">제목/일반글</option>
				<option value="name/com">작성자</option>
				<option value="con">내용</option>
			</select> <input type="text" id="se" name="nsearch"> <input
				type="button" value="검색" onclick="search()">
		</div>
	</header>
	<section>
		<div class="board_container">
			<hr>
			<div class="menu">
				<table>
					<tr>
						<td width="5%">글번호</td>
						<td width="30%">제목</td>
						<td width="10%">작성자</td>
						<td width="10%">첨부파일</td>
						<td width="10%">작성일</td>
						<td width="5%">추천수</td>
						<td width="10%">조회수</td>
						<td width="10%">글쓰기권한</td>
						<td width="10%">기능</td>
					</tr>
				</table>
			</div>
			<hr>

			<div class="content">

				<%
					while (rs.next()) {
							String b_idx = rs.getString("b_idx");
							String re_b_idx = rs.getString("b_idx");
							String b_title = rs.getString("b_title");
							String b_name = rs.getString("b_name");
							String b_hit = rs.getString("b_hit");
							String b_file = rs.getString("b_file");
							String b_regdate = rs.getString("b_regdate");
							String mem_power = rs.getString("mem_power");

							if (mem_power.equals("관리자")) {
								b_idx = "[공지]";
							}

							b_regdate = b_regdate.substring(0, 10);
				%>


				<table>
					<tr>
						<td width="5%"><%=b_idx%></td>
						<td width="30%"><%=b_title%></td>
						<td width="10%"><%=b_name%></td>
						<td width="10%"><%=b_file%></td>
						<td width="10%"><%=b_regdate%></td>
						<td width="5%"><%=b_hit%></td>
						<td width="10%"><%=b_hit%></td>
						<td width="10%"><%=mem_power%></td>
						<td width="10%"><input type="button" id="mod" value="수정"
							onclick="noticepopup(<%=re_b_idx%>)"> <input
							type="button" id="del" value="삭제"
							onclick="noticedelete(<%=re_b_idx%>)"></td>
					</tr>
				</table>
				<hr>
				<%
					}
						dbsql = "select count(b_idx) from board1";
						pstmt = conn.prepareStatement(dbsql);
						rs = pstmt.executeQuery();
						while (rs.next()) {
							int anote = rs.getInt("count(b_idx)");
							int pg = anote / 10;
							if (anote % 10 > 0) {
								pg += 1;
							}

							for (int i = 1; i <= pg; i++) {
				%>
				<a href="#" onclick='pagingS("<%=i%>","<%=dbsql%>","a")'>[<%=i%>]
				</a>
				<%
					}
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				%>
			</div>
		</div>
	</section>
	<script type="text/javascript" src="Mainpage.js"></script>
</body>
</html>