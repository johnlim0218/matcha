<%@page import="dataBase.MovieMoreInfo"%>
<%@page import="dataBase.MovieInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dataBase.WishListHandler"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String useridx = (String)session.getAttribute("sIdx");
	String username = (String)session.getAttribute("sName");
	
	if(useridx == null || useridx == "") {
		response.sendRedirect("main.jsp");
	}
	
	WishListHandler wishListHandler = new WishListHandler();
	ArrayList<MovieMoreInfo> arrForMovieInfo = new ArrayList<>();
	arrForMovieInfo = wishListHandler.connectJspToDBConnectorToGetWishList(request, response);
	
	
    %>
    
    
<!DOCTYPE HTML>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
    <link rel="stylesheet" href="css/moviecollect_css.css" type="text/css">
    <script>
    function myPage() {
		window.history.back();
	}
    </script>
</head>

<body>
    <div class="box">
        <header>
    		<%@ include file="headerinc.jsp" %>
        </header>
        <section class="mid">
            <section class="mid2">
                <header class="midheader">
                    <div class="backblank">
                        <div>
                            <button class="backbutton" onclick="myPage()"></button>
                        </div>
                        <div class="want">
                            <div class="wantsee">보고싶어요</div>
                        </div>
                    </div>
        
                    <div class="wannasee">보고싶어요</div>
                </header>
                <section class="movielist">
                    <div class="movielist1">
                        <div class="movielist2">
                            <ul class="moviecontainer">
                               
                             <%for(int i = 0; i < arrForMovieInfo.size(); i++) {%>  
                                <li class="movietitle">
                                    <a lang="ko=KR" title="<%=arrForMovieInfo.get(i).getMovieNm() %>" href="javascript:moreInfo('<%=arrForMovieInfo.get(i).getMovieCd()%>')">
                                        <div class="posterbox">
                                            <div class="poster">
                                                <img class="posterimg" src="<%=arrForMovieInfo.get(i).getImgUrl() %>">
                                            </div>
        
                                        </div>
                                        <div class="titlebox">
                                            <div class="titlebox1"><%=arrForMovieInfo.get(i).getMovieNm() %></div>
                                            <div class="starrate"><%=arrForMovieInfo.get(i).getPrdtYear()%> <%if(arrForMovieInfo.get(i).getNations() != null)arrForMovieInfo.get(i).getNations();%></div>
                                        </div>
                                    </a>
                                </li>
                             
                             <%} %>
                             
                            </ul>
                        </div>
                    </div>
                </section>
            </section>
        </section>
        <footer class="footermenu1">
        	<%@ include file="footerinc.jsp" %>
     	</footer>
     	<script>
     	function moreInfo(movieCd) {

			location.href = "moreinfo.jsp?movieCd=" + movieCd;
		}
     	</script>
    </div>
</body>

</html>