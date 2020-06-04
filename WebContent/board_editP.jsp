<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	PreparedStatement pstmt = null;
	Connection conn = null;
	int result = 0;
	
	String uploadPath = request.getRealPath("/upload");
	out.println("절대경로 : " + uploadPath + "<br/>");
	
	int maxSize = 1024 * 1024 * 10; // 파일 용량 10M

	MultipartRequest multi = null;
	multi = new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());
	// request, 
	
	String useridx = (String)session.getAttribute("sIdx");
	String sUserid = (String)session.getAttribute("sUserid");
	String sName = (String)session.getAttribute("sName");
	String b_idx = (String)session.getAttribute("b_idx");
	String b_title = (String)multi.getParameter("b_title");
	String b_email = (String)multi.getParameter("b_email");
	String b_content = (String)multi.getParameter("b_content");
	String b_ip = request.getRemoteAddr();
	

	
	String name = "";
	String subject = "";
	
	String fileName1 = "";	// DB컬럼에 저장될 이름
	String originalName1 = "";	// 실제 파일 이름
	long fileSize = 0;
	String fileType = "";
	
	
		
	if(useridx == null || useridx.equals("")){
		response.sendRedirect("main.jsp");	// 로그인
	}
	
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
	
	try {
		Class.forName("org.mariadb.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/website", "root", "1234");
		String sql = "update board1 set b_useridx=?, b_name=?, b_title=?, b_email=?, b_content=?, b_file=?, b_ip=? where b_idx="+ b_idx;
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, useridx);
		pstmt.setString(2, sName);
		pstmt.setString(3, b_title);
		pstmt.setString(4, b_email);
		pstmt.setString(5, b_content);
		pstmt.setString(6, fileName1); // file
		pstmt.setString(7, b_ip);
		out.println(pstmt);
		result = pstmt.executeUpdate();

	} catch (Exception e) {
		e.getMessage();
	} finally {
		
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<script>
			alert("수정이 완료되었습니다.");
			location.href="board_view.jsp?b_idx=<%=b_idx%>";
		</script>
</body>
</html>