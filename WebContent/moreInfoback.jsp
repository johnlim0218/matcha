<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="dataBase.MoreInfoHandler" %>
    <%@ page import="dataBase.MovieMoreInfo" %>
    <%
    	String movieCd = request.getParameter("movieCd");
    	MoreInfoHandler moreInfoHandler = new MoreInfoHandler(movieCd);
    	
    	MovieMoreInfo movieMoreInfo = moreInfoHandler.getMovieMoreInfo();
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style>
	.header{
		width: 400px;
		height: 600px;
	}
	.poster {
	width: 100%;
	height: 100%;
    background: url("<%=movieMoreInfo.getImgUrl()%>");
    background-position: center;
    background-repeat: no-repeat;
    background-size: contain;
}
</style>
</head>
<body>
	<div class="header">
		<p class="poster"></p>
	</div>
	<h1><%=movieMoreInfo.getMovieNm() %></h1>
	<h2><%=movieMoreInfo.getMovieNmEn() %></h2>
	<h3>제작년도 : <%=movieMoreInfo.getPrdtYear() %></h3>
	<h3>개봉일 : <%=movieMoreInfo.getOpenDt() %></h3>
	<h3>상영시간 : <%=movieMoreInfo.getShowTm() %></h3>
	<h5>제작국가 : 
	<% for(int i = 0; i < movieMoreInfo.getNations().size(); i++){%>  
	<%=	movieMoreInfo.getNations().get(i).getNationNm()%>
	 <%	} %>
	 </h5>
	<h5>장르 : 
	<%for(int i = 0; i < movieMoreInfo.getGenres().size(); i++){
	%>	<%= movieMoreInfo.getGenres().get(i).getGenreNm()%>
	<%	}%>
	 </h5>
	 <h5>감독 :
	 <%for(int i = 0; i < movieMoreInfo.getDirectors().size(); i++){
	%>	
	<a href = "javascript:searchPersonFilmos('<%=movieMoreInfo.getActors().get(i).getPeopleNm()%>')">
	<%= movieMoreInfo.getDirectors().get(i).getPeopleNm()%>
		<%= movieMoreInfo.getDirectors().get(i).getPeopleNmEn()%>
		</a>
	<%}%>
	 </h5>
	 <h5>출연배우 : 
	 <%for(int i = 0; i < movieMoreInfo.getActors().size(); i++){
	%>	<a href = "javascript:searchPersonFilmos('<%=movieMoreInfo.getActors().get(i).getPeopleNm()%>')">
	
		<%= movieMoreInfo.getActors().get(i).getPeopleNm()%>
		<%= movieMoreInfo.getActors().get(i).getPeopleNmEn()%>
		<%= movieMoreInfo.getActors().get(i).getCast()%>
		<%= movieMoreInfo.getActors().get(i).getCastEn()%>
		</a>
	<%}%>
	
	 </h5>
	 <script>
		 function searchPersonFilmos(peopleNm){ // 영화 상세정보 함수
			
			location.href="search.jsp?userinput=" + peopleNm;
		}
	 </script>
</body>
</html>