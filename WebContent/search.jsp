<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Set"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="java.io.IOException"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%>
<%@ page import="dataBase.SearchWordHandler"%>
<%@ page import="dataBase.MovieInfo"%>
<%@page import="dataBase.ReturnInfo"%>

<%
	request.setCharacterEncoding("UTF-8");
	
	// 문자열 공백(띄어쓰기) 삭제
	String userInput = request.getParameter("userinput").replaceAll(" ", ""); 
	
	// 사용자가 입력한 검색어(userInput)를 java 파일로 보내준다.
	SearchWordHandler dataHandler = new SearchWordHandler(userInput, request, response);
	HashMap<String, MovieInfo> searchResultMap = dataHandler.getKobisMovie();
	
	
	ArrayList<ReturnInfo> returnInfo = new ArrayList<>(); 
	returnInfo = dataHandler.connectJspToDBConnector(userInput);
	
	if(returnInfo.size() == 0){
		System.out.println("검색결과없음");
	}
	/////////////////////////////////////////////////////////////////////////////////////////////////////

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.movieimg {
	width: 203px;
	height: 290px;
}
</style>
</head>

<body>
	<div></div>
	<script>
		var arrForImgSrcForScript = new Array();
		var divTag = document.getElementsByTagName('div');
		
		<%for (int i = 0; i < returnInfo.size(); i++) {
				
			String movieCd = returnInfo.get(i).getMovieCd();
			String movieNm = returnInfo.get(i).getMovieNm();
			String imgUrl = returnInfo.get(i).getImgUrl();
			%>
			
			var aTag = document.createElement('a');
			aTag.setAttribute('href', 'javascript:moreInfo(<%=movieCd%>)');
			var textNode = document.createTextNode("<%=movieNm%>");
			
			var imgTag = document.createElement('img');
			imgTag.setAttribute('src', '<%=imgUrl%>');
			imgTag.setAttribute('class', 'movieimg');
			
			divTag[0].appendChild(aTag).appendChild(textNode);
			divTag[0].appendChild(aTag).appendChild(imgTag);
			
			// aTag[0].innerHTML += "<%=movieNm%>";
			//	aTag[j].appendChild(imgTag);
	<%}%>
	
	function moreInfo(movieCd){ // 영화 상세정보링크 생성 함수
		
		location.href="moreInfo.jsp?movieCd=" + movieCd;
	}
		
	</script>
</body>
</html>