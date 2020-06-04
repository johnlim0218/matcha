<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
  

    <%
    request.setCharacterEncoding("UTF-8");
    String b_idx = request.getParameter("b_idx");
    
    Connection conn = null;
	ResultSet  rs = null;	
	PreparedStatement pstmt = null;
    
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/website", "root", "1234");
    
	
	String sql = "select b_idx, B.b_useridx, b_name, b_title, b_email, b_content, b_file, b_regdate, b_hit, b_ip,mem_power,mem_name,mem_userid,mem_idx from board1 B join member1 M on B.b_useridx = M.mem_idx where b_idx = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, b_idx);
	rs = pstmt.executeQuery();
	
	if(rs.next())
	{
		try{
			
			String b_useridx 	= rs.getString("b_useridx");
			String mem_name 	= rs.getString("mem_name");
			String mem_idx 	= rs.getString("mem_idx");
			String mem_userid 	= rs.getString("mem_userid");
			
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>글수정</title>
<script>
$(window).on("beforunload",function(){
	
});
</script>
</head>
<body>
	<form name="bForm" method="POST" action="b_viewtestP.jsp" enctype="Multipart/form-data">
	<input type="hidden" name="b_idx" value="<%=b_idx%>">
	<input type="hidden" name="mem_name" value="<%=mem_name%>">
	<input type="hidden" name="mem_userid" value="<%=mem_userid%>">
	<input type="hidden" name="mem_idx" value="<%=mem_idx%>">
	
	<p>이름 : <%=mem_name %></p>
	<p><label>제목 : <input type="text" name="b_title" value="<%=b_title%>"></label></p>
	<p><label>이메일 : <input type="text" name="b_email" value="<%=b_email%>"></label></p>
	<p>내용</p>
	<p><textarea name="b_content" cols="50" rows="5"><%=b_content %></textarea></p>	
	<p><label>파일 : <input type="file" name="b_file" value="<%=b_file%>"></label></p>	
	<p><input type="submit" value="글수정완료"><input type="button" value="취소"></p>
	</form>
	
</body>
</html>
<%
		}catch(Exception e){
			e.printStackTrace();
		}
	}	
%>