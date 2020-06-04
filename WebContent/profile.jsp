<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String useridx = (String)session.getAttribute("sIdx");

	String id = "";
	String password = "";
	String name = "";
	String gender = "";

	try {
		//데이터베이스 Connection
		Class.forName("org.mariadb.jdbc.Driver");
	   	 String dburl="jdbc:mariadb://localhost:3306/website?autoReconnect=true&";
	   	 String dbid = "root";
	   	 String dbpwd = "1234";
	   	 Connection con = DriverManager.getConnection(dburl, dbid, dbpwd);
		//select 쿼리
		//테이블 불러오기
		String qu = "select*from member1 where mem_idx=" + useridx;
		//java statement 생성
		Statement st = con.createStatement();
		//쿼리 execute, 객체형성
		ResultSet rs = st.executeQuery(qu);
		//각 열을 반복적으로 나타냄
		while(rs.next()) {
			 id = rs.getString("mem_userid");
			 password = rs.getString("mem_pwd");
			 name = rs.getString("mem_name");
			 gender = rs.getString("mem_gender");
		}
		//닫아줌.
		st.close();
	}catch(Exception e){
		System.err.println("Got an exception! ");
		System.err.println(e.getMessage());
	}
%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>회원정보</title>
        <link rel="stylesheet" href="css/profile.css">
        <style>
            img.absolute {
                position: relative;
                left: 170px;
                top: -10px;
                margin: 6px;
            }
        </style>
    </head>
    <body>
    <header>
    <%@ include file="headerinc.jsp"%>
    </header>
        <div id="box-container" >
        <h1>회원정보</h1><br>
        <img src="images/people.jpg" class= "absolute">
            <div class="profile_name"><br><br><h2><%=name %></h2></div>
        <form method="post" action ="profileP.jsp">
            <div class="box"><input type="text" name="userName" class="aa" placeholder="이름" value=<%=name %>><br></div>
            <div class="box"><input type="text" name="userID" placeholder="아이디" class="aa" value=<%=id %>><br></div>
            <div class="box"><input type="password" name="userPassword" placeholder="비밀번호" class="aa" value=<%=password %>><br></div>
            <div class="box"><input type="text" name="userGender" placeholder="성별" class="aa" value=<%=gender %>><br></div>
            <div class="box5"><input type="submit" value="회원정보수정" class="profile_button"></div>
        </form>
        <footer class="footermenu1">
					<%@ include file="footerinc.jsp"%>
		</footer>
        
        </div>
        
    </body>
</html>