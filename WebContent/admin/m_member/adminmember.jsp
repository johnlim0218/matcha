<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="exam.jdbc.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="ko">
<jsp:useBean id="dao" class="exam.jdbc.JDBC_memberDAO" />
<% 
	String sPower = (String) session.getAttribute("sPower");
	request.setCharacterEncoding("UTF-8");
	String paging1 = "0";
	paging1 = request.getParameter("paging1");
	ArrayList<MemberVO> list = dao.getMemberlist(paging1);
	PreparedStatement pstmt = null;
	Connection conn = null;
	ResultSet rs = null;
	int whpage = 0;
%>
<head>
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
<link rel="stylesheet" href="adminmember.css" type="text/css">
<title>회원 관리 페이지</title>

</head>
<script>
	function idDelete(delID) {

		//alert(delID);
		location.href = "admin_member_del.jsp?mem_userid=" + delID; //get방식으로 삭제할아이디를 넘김

	}
</script>

<body>
	<div>
		<header class="box">
			<div class="subj">
				<div>
					<a href="../../main.jsp"> <span src="images/logo.png"
						class="logo"></span></a>
				</div>
				<div class="subjbox">
					<h1>
						<a class="subjecttitle" href="../admin.jsp">회원 관리</a>
					</h1>
				</div>
			</div>
		</header>
	</div>
	<section>

		<div class="midheader">
			<div>
				<form method="get" name="f">
					<table>
						<tr class="trtitle">
							<th>아이디</th>
							<th>이름</th>
							<th>비밀번호</th>
							<th>성별</th>
							<th></th>
						</tr>
						<%
							for (MemberVO vo : list) {
						%>
						<!-- 테이블 값 삽입  -->
						<tr>
							<td><%=vo.getMem_userid()%></td>
							<td><%=vo.getMem_name()%></td>
							<td><%=vo.getMem_pwd()%></td>
							<td><%=vo.getMem_gender()%></td>
							<td><input type="button" value="삭제"
								onclick="idDelete('<%=vo.getMem_userid()%>');"></td>
						</tr>

						<%
							}
						%>
						<tr>
						<tr>
							<td class="tdcol" colspan="7"><br /> <%
 	/*페이징 처리
 	1. db에서 mem_idx 번호 리스트 받아오기
 	2. 받아온 값들을 rs에 넣고 넘기면서 whpage에 총 갯수 넣기
 	3. whpage를 10으로 나누어 몇 페이지가 보여줄지(pagenum) 정하기
 	4. 
 	
 	*/
 	Class.forName("org.mariadb.jdbc.Driver");
 	conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/website", "root", "1234");
 	String dbsql = "select mem_idx from member1";
 	pstmt = conn.prepareStatement(dbsql);
 	rs = pstmt.executeQuery();
 	while (rs.next()) {
 		whpage += 1;
 	}
 	int pagenum = whpage / 10;

 	for (int i = 0; i <= pagenum; i++) {
 		int num = i * 10;
 %> <a href="adminmember.jsp?paging1=<%=num%>"><%=i + 1%></a> <%
 	}
 %></td>
						</tr>


						<tr>
							<!-- 오른쪽 하단 링크 -->
							<td class="tdcol" colspan="7"><p align="right">
									<a href="adminmember.jsp?paging1=0">[전체목록]</a>
								</p></td>
						</tr>
					</table>


				</form>

			</div>
		</div>


	</section>


	</div>

</body>

</html>