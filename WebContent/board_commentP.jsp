<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String useridx = (String)session.getAttribute("sIdx");
	String c_boardidx = (String)request.getParameter("b_idx");
	String c_content = (String)request.getParameter("c_content");
	String b_ip = (String)request.getRemoteAddr();

	if (c_content == null || c_content.equals("")) {
		%>
		<script>
		alert("댓글 내용을 작성하신 후 작성 버튼을 눌러주세요.");
		location.href="board_view.jsp?b_idx="+<%=c_boardidx%>;
		</script>
		<%
	} else {
	PreparedStatement pstmt = null;
	Connection conn = null;
	int result = 0;
	
	try {
		Class.forName("org.mariadb.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/website", "root", "1234");
		String sql = "insert into comment1 (c_useridx, c_boardidx, c_content, c_ip) values "
				+ "(?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, useridx);
		pstmt.setString(2, c_boardidx);
		pstmt.setString(3, c_content); 
		pstmt.setString(4, b_ip);
		pstmt.executeUpdate();
	} catch (Exception e) {
		out.println(e.getMessage());
	} finally {
	%>
		<script>
		alert("댓글을 작성하였습니다.");
		location.href = "board_view.jsp?b_idx=<%=c_boardidx%>";
		</script>
	<%
	}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>