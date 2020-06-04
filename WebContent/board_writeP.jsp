<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.io.File" %>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Enumeration" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import="com.oreilly.servlet.MultipartRequest" %>

<%

	request.setCharacterEncoding("UTF-8");

	String useridx = (String)session.getAttribute("sIdx");
	
	if(useridx == null || useridx.equals("")){
		response.sendRedirect("member1_2.jsp");	// 로그인
	}
	
	PreparedStatement pstmt = null;
	Connection conn = null;
	
	String uploadPath = request.getRealPath("/upload");
	out.println("절대경로 : " + uploadPath + "<br/>");
	
	int maxSize = 1024 * 1024 * 10; // 파일 용량 10M
	
	String name = "";
	String subject = "";
	
	String fileName1 = "";	// DB컬럼에 저장될 이름
	String originalName1 = "";	// 실제 파일 이름
	long fileSize = 0;
	String fileType = "";
	
	MultipartRequest multi = null;
		multi = new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());
		// request, 
		
		String movieCd = multi.getParameter("movieCd");
		
		if(movieCd.equals("null") || movieCd == null){
			movieCd = "0";
		}
		String sUserid = (String)session.getAttribute("sUserid");
		String sName = (String)session.getAttribute("sName");
		String b_title = multi.getParameter("b_title");
		String b_email = multi.getParameter("b_email");
		String b_content = multi.getParameter("b_content");
		String b_pwd = multi.getParameter("b_pwd");
		String b_ip = request.getRemoteAddr();
		
		Enumeration files = multi.getFileNames();
		
		
		//전송된 파일 이름들을 저장
		while(files.hasMoreElements()) {
			String file1 = (String)files.nextElement(); // 파일 input 에 지정된 이름
			originalName1 = multi.getOriginalFileName(file1); // 파일 이름
			fileName1 = multi.getFilesystemName(file1); // 중복 정책에 따라 뒤에 1,2,3 으로 이름을 변경하여 유니크하게 파일명 생성
			fileType = multi.getContentType(file1); // 파일타입
			File file = multi.getFile(file1); // 실제 바이너리 파일 
			//fileSize = file.length(); // 파일 크기
		}
		
		if(fileName1 == null) {
			fileName1 = "없음";
		}
		
		Class.forName("org.mariadb.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/website", "root", "1234");
		
		String sql = "insert into board1 (b_useridx, b_name, b_title, b_email, b_content, b_file, b_ip, b_moviecd) values (?,?,?,?,?,?,?,?)";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, useridx);
		pstmt.setString(2, sName);
		pstmt.setString(3, b_title);
		pstmt.setString(4, b_email);
		pstmt.setString(5, b_content);
		pstmt.setString(6, fileName1); // file
		pstmt.setString(7, b_ip);
		pstmt.setString(8, movieCd);
		pstmt.executeUpdate();

	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<script>
			alert("글쓰기가 완료되었습니다.");
			location.href="board_list.jsp?pages=1";
		</script>
</body>
</html>