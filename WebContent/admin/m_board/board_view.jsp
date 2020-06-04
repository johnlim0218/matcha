<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %> 
<%
	try {
	request.setCharacterEncoding("UTF-8");
	String useridx = (String)session.getAttribute("sIdx");
	String sUserid = (String)session.getAttribute("sUserid");
	String sName = (String)session.getAttribute("sName");
	
	if(useridx == null || useridx.equals("")){
		response.sendRedirect("main.jsp");	// 로그인
	}
	
	Connection conn = null;
	ResultSet rs = null;	
	ResultSet rs2 = null;
	PreparedStatement pstmt = null;
	String b_pwd = "";
	int int_b_pwd = 0;

	request.setCharacterEncoding("UTF-8");
	String b_idx = request.getParameter("b_idx");
	session.setAttribute("b_idx", b_idx);

	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/website", "root", "1234");
	String sql = "select b_pwd from board1 where b_idx=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, b_idx);
	rs = pstmt.executeQuery();
	rs.next();
	b_pwd = rs.getString("b_pwd");
	if (b_pwd != null) {
		int_b_pwd = Integer.parseInt(b_pwd);
	}
	if (b_pwd != null) {
%>
	<script>
		var input_b_pwd = prompt("게시물의 비밀번호를 입력 해주세요.");
		if (input_b_pwd == <%=int_b_pwd%>) {
			alert("비밀번호가 맞습니다.");
		} else {
			alert("비밀번호가 틀립니다.");
			location.href="board_list.jsp?pages=1";
		}
	</script>
<%
	} 
		sql = "update board1 set b_hit = b_hit + 1 where b_idx = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, b_idx);
		pstmt.executeUpdate();
		
		sql = "select b_idx, b_useridx, b_name, b_title, b_email, b_content, b_file, b_regdate, b_hit, b_ip from board1 where b_idx=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, b_idx);
		rs = pstmt.executeQuery();
		
		if(rs.next())
		{
				String b_useridx 	= rs.getString("b_useridx");
				String b_name 		= rs.getString("b_name");
				String b_title 		= rs.getString("b_title");
				String b_email 		= rs.getString("b_email");
				String b_content 	= rs.getString("b_content");
				String b_file 		= rs.getString("b_file");
				String b_regdate 	= rs.getString("b_regdate");
				String b_hit 		= rs.getString("b_hit");
				String b_ip 		= rs.getString("b_ip");
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글보기</title>
</head>
<body>
	<h2>글보기</h2>
	<p>이름 : <%=b_name%> (<%=b_ip %>)</p>
	<p>제목 : <%=b_title %></p>
	<p>조회수 : <%=b_hit %></p>
	<p>이메일 : <%=b_email %></p>
	<p><%=b_content %></p>
	<p>첨부파일 : <%=b_file %></p>
	<p><a href="board_list.jsp?pages=1">리스트</a> | <a href="board_edit.jsp?b_idx=<%=b_idx%>">글수정</a> | <a href="board_deleteP.jsp">글삭제</a></p>

<form name="commentForm" method="post" action="board_commentP.jsp">
	<p><%=sName %> <input type="text" name="c_content"> <input type="submit" value="입력"></p>
	<input type="hidden" name="b_idx" value="<%=b_idx %>">
</form>
<% 
	sql = "select c_idx, c_useridx, c_boardidx, c_content, c_regdate, c_ip from comment1 where c_boardidx=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, b_idx);
	rs = pstmt.executeQuery();
	
	while(rs.next()) {
		String c_idx = rs.getString("c_idx");
		String c_useridx = rs.getString("c_useridx");
		String c_boardidx = rs.getString("c_boardidx");
		String c_content = rs.getString("c_content");
		String c_regdate = rs.getString("c_regdate");
		String c_ip = rs.getString("c_ip");
		String c_name = "";
		
		String sql2 = "select mem_name from member1 where mem_idx=?";
		pstmt = conn.prepareStatement(sql2);
		pstmt.setString(1, c_useridx);
		rs2 = pstmt.executeQuery();
		if(rs2.next()){
			c_name = rs2.getString("mem_name");
		}
%>

	<p><%=c_name %> | <%=c_content %> <%=c_regdate %></p>
<%
		}
	}
	} catch (Exception e) {
		out.println(e.getMessage());
	}
%>
	
</body>
</html>


