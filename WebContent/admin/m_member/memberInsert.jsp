<%@ page import="exam.jdbc.MemberVO" %>
<%@ page import="exam.jdbc.JDBC_memberDAO" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
<head>
		 
		<%
		request.setCharacterEncoding("UTF-8");
		MemberVO vo = new MemberVO();
		vo.setMem_userid(request.getParameter("mem_userid"));
		vo.setMem_name(request.getParameter("mem_name"));
		vo.setMem_pwd(request.getParameter("mem_pwd"));
		vo.setMem_gender(request.getParameter("mem_gender"));
		JDBC_memberDAO dao = new JDBC_memberDAO();
		
		
		%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<%request.setCharacterEncoding("UTF-8");%>

<%
  if(dao.memberInsert(vo)>0){
   
        out.print("<script>");
        out.print("alert('가입을 축하드립니다.');");  
        out.print("location.href='adminmember.jsp';");        
        out.print("</script>");
     }else{
       
        out.print("<script>");
        out.print("alert('회원가입이 정상적으로 완료되지 않았습니다.');");  
        out.print("history.back();");          
        out.print("</script>");
     }
 %>

</body>
</html>