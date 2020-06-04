<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
    <%
    
    request.setCharacterEncoding("UTF-8");
    String b_idx = request.getParameter("b_idx");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet re = null;
    String sql = "";
    
	conn = null;
	pstmt = null;
	try{
		Class.forName("org.mariadb.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/website", "root", "1234");
		sql = "delete from board1 where b_idx=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, b_idx);
		pstmt.executeUpdate();
		out.println("삭제 완료");
	}catch(Exception e){
		out.println("데이터베이스에 연결 할 수 없습니다.<br>");
	}
	
    %>
