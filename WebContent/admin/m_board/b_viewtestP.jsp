<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.File" %>
<%@ page import= "javax.naming.Context" %>
<%@ page import= "javax.naming.InitialContext" %>
<%@ page import= "javax.sql.DataSource" %>
<%@ page import= "java.util.Enumeration" %>
<%@ page import= "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import= "com.oreilly.servlet.MultipartRequest" %>
<%


DataSource dataSource;
String uploadPath = request.getRealPath("/upload");
int maxSize = 1024* 1024* 10;
String name = "";
String subject = "";
String fileName1 = "";  // db 컬럼에 저장될 이름
String originalName1 =""; // 실제 파일 이름
long fileSize = 0;
String fileType = "";

MultipartRequest multi;


	request.setCharacterEncoding("UTF-8");

	
	

	try{
	

		multi = new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());
		
		
		String mem_idx = multi.getParameter("mem_idx");
		String mem_userid = multi.getParameter("mem_userid");
		String mem_name = multi.getParameter("mem_name");
		
		String b_idx		= multi.getParameter("b_idx");
		String b_title 		= multi.getParameter("b_title");
		String b_email 		= multi.getParameter("b_email");
		String b_content 	= multi.getParameter("b_content");
		String b_ip			= request.getRemoteAddr();
		
		System.out.println("1");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		
		Enumeration files = multi.getFileNames();
		//전송된 모든 파일이름들을 저장
		System.out.println(multi.getParameter("b_file"));
		
			
		if(multi.getParameter("b_file") != null){
			while(files.hasMoreElements()){
				
			String file1 = (String)files.nextElement(); // 파일 input에 지정된 이름
			
			originalName1 = multi.getOriginalFileName(file1); // 파일이름
			
			fileName1 = multi.getFilesystemName(file1); // 중복정책에 따라 뒤에 1,2,3 으로 이름을 변경하여 유니크하게 파일을 생성.
			
			fileType = multi.getContentType(file1); //파일 타입
			
			File file = multi.getFile(file1); // 실제 바이너리 파일
		
			fileSize = file.length(); // 파일크기
			
		}
		}
		
		Class.forName("org.mariadb.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/website", "root", "1234");
		String sql = "update board1 set b_useridx=?, b_name=?, b_title=?, b_email=?, b_content=?, b_file=?, b_ip=? where b_idx=?";
	
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, mem_idx);
		pstmt.setString(2, mem_name);
		pstmt.setString(3, b_title);
		pstmt.setString(4, b_email);
		pstmt.setString(5, b_content);
		pstmt.setString(6, fileName1);	// 파일
		pstmt.setString(7, b_ip);
		pstmt.setString(8, b_idx);
		
	
		pstmt.executeUpdate();
	
	
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
</head>
<body>
	<script>
		alert("글변경이 완료되었습니다.");
		location.href="b_viewtest.jsp?b_idx=<%=b_idx%>";	
	</script>
</body>
</html>
<%
}catch(Exception e){
		e.printStackTrace();
		out.println("데이터베이스에 연결 할 수 없습니다.<br>");
	}
	%>