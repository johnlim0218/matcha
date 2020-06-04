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
				b_regdate = b_regdate.substring(0,b_regdate.length()-2);
				String b_hit 		= rs.getString("b_hit");
				String b_ip 		= rs.getString("b_ip");
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글보기</title>
<link rel="stylesheet" href="css/Board_view_css.css">
</head>
<body>
<header>
     <%@ include file="headerinc.jsp" %>
</header>
<div class="container">
            <header class="container_header">
            <div class="container_title"><h2>제목</h2></div>
            <div class="container_title_text"><h2><%=b_title %></h2></div>
            <div class="container_title_info"><h2>조회수 : <%=b_hit %>
            <%
            	if(useridx.equals(b_useridx)){
            		out.println("<a class='view_sub_logic' href='board_edit.jsp?b_idx="+b_idx+"'>수정</a>");
            		out.println("<a class='view_sub_logic' href='board_deleteP.jsp?b_idx="+b_idx+"'>삭제</a>");
            	}
            %></h2></div>
            <hr>
            </header>
            <!-- 제목 상단 부분 -->
            <section class="content">
                <div class="content_header_left">
                    <img src="images/people.jpg"> <!-- 사용자의 프로필 이미지 -->
                    <span><%=b_name %></span>
                </div>
                <div class="content_header_right">
                    <span>작성일 : <%=b_regdate %></span><br/>
                    <span>파일첨부 : 
                    <%
                    	if (b_file.equals("없음")) {
                    		out.println("없음");
                    	} else {
                    		%>
                    		<a href="filedown.jsp?filename=<%=b_file %>"><%=b_file %></a></span>
                    		<%
                    	}
                    %>
                </div>
                <hr class="content_hr">
                <!-- 게시글의 내용이 출력되는 부분 -->
                <div class="content_main_text">
                <%=b_content %>
                </div>
                <!-- 
                <div class="content_footer_button" id="suggest_button">
                    	추천
                </div>
                 -->
            </section>
            <!-- 댓글 부분 -->
<form name="commentForm" method="post" action="board_commentP.jsp">
	<section class="comment">
	<div class="comment_image">
         <img src="images/people.jpg"> <!-- 사용자의 프로필 이미지 -->
    </div>
	<div class="comment_info"><%=sName %></div> 
	<div class="comment_content"><input type="text" name="c_content" id="comment_content_text"></div> 
	<div class="comment_write_button"><input type="submit" value="작성" id="submitbtn"></div>
	<input type="hidden" name="b_idx" value="<%=b_idx %>">
	</section>
</form>
	<hr>
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
		c_regdate = c_regdate.substring(0,c_regdate.length()-2);
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
	<section class="comment">
             <div class="comment_image">
                 <img src="images/people.jpg"> <!-- 사용자의 프로필 이미지 -->
             </div>
             <div class="comment_info">
                 <%=c_name%> <%=c_regdate%> 
                 <%
                 	if (useridx.equals(c_useridx)) {
                 		out.println("<a href='comment_deleteP.jsp?c_idx="+c_idx+"'>삭제</a>");
                 	} else {
                 		out.println("");
                 	}
                 %>
             </div>
             <div class="comment_content">
                 <%=c_content %>
             </div>
	</section>
<%
		}
	}
	} catch (Exception e) {
		out.println(e.getMessage());
	}
%>
            
        </div>
</body>
</html>


