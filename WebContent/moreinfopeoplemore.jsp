<%@page import="dataBase.DirectorsMovieMoreInfo"%>
<%@page import="dataBase.ActorsMovieMoreInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dataBase.MoreInfoHandler"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	request.setCharacterEncoding("UTF-8");
    

    String sIdx = (String) session.getAttribute("sIdx");
	String sUserId = (String) session.getAttribute("sUserid");
	String sName = (String) session.getAttribute("sName");
    
    String movieCd = request.getParameter("movieCd");
    String movieNm = request.getParameter("movieNm");
  	MoreInfoHandler moreInfoHandler = new MoreInfoHandler();
  	ArrayList<DirectorsMovieMoreInfo> arrForReturnDirectors = new ArrayList<>();
  	ArrayList<ActorsMovieMoreInfo> arrForReturnActors = new ArrayList<>();
  	
  	arrForReturnDirectors = moreInfoHandler.toDBConnectorToGetDirectorsMore(movieCd); 
  	arrForReturnActors = moreInfoHandler.toDBConnectorToGetActorsMore(movieCd);
  	
  	
    %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
       <link rel="stylesheet" type="text/css" href="./css/searchmoremovie.css">
        <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900&amp;subset=korean" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
        <title>제작진 결과 더보기</title>
        <script>
        
        	function backButton() {
        		window.history.back();
        	}
        	
        	
        
        	//스크롤시에 함수 실행.
        	$(window).scroll(function(){
        	
        	//스크롤 값 scrol 변수에 저장. 맨위값이 0.
        	var scrol = $(window).scrollTop();
        	
        	// 콘솔에 변수출력
        	//console.log(scrol);
        	
        	//스크롤값이 일정값이상 일때 이벤트 실행, 이하일때 이벤트 되돌리기.
        	if(scrol > 200){
        		//$(".menuname2_div2").css("display","none");
        		$(".menuname2_div2").css("height",0);
        		$(".hidetitle").css("opacity",1);
        		$(".infotitle").css("height",0);
        		
        	}
        	else if(scrol < 200){
        		//$(".menuname2_div2").css("display","flex");
        		$(".menuname2_div2").css("height",49);
        			$(".hidetitle").css("opacity",0);
        			$(".infotitle").css("height",40);
            		
        	}
        		
        	// 맨아래로 스크롤 했을경우 에이젝스 실행. 로딩,데이터불러오기.
        	if ($(window).scrollTop() >= $(document).height()-$(window).height()) {
        		nowPage++;
        		
        		$(document).ajaxStart(function() {

         		   $("#loding").addClass(".lodingicon");

         		});
         		// AJAX가 끝날 경우 호출할 함수를 등록

         		$(document).ajaxStop(function() {

         			$("#loding").removeClass(".lodingicon");

         		});
         		
         		
        		
        	}
        	
        	});
        	
        	
        	
        	
        </script>
    </head>
    <body>
        <div id="firstdiv">
            <div id="seconddiv">
                <div id="thirddiv">
                    <header class="topsearch">
                        <%@ include file="headerinc.jsp" %>
						<%-- <%@ include file="headerinc_logout.jsp" %> --%>
                    </header>
                    



                    <section class="smovie">
                        <div class="menuname">
                            <div class="menuname2">
                                <div class="menuname2_div">
                                    <div class="manuname2_d_d">
                                        <button class="backbtn" onclick="javascript:backButton()"></button>
                                    </div>
                                </div>

                                <div class="menuname2_div2">
                                    <div class="infotitle"><%=movieNm %></div>
                                </div>

                                <div class="hidetitle"><%=movieNm %></div>
                                </div>




    <!----------------------------------- ------------------->
                            <div class="slist">
                                <div class="slistb">
            
                                        <ul class="slistm_2ul">
                                        	
                                        <% for(int i = 0; i < arrForReturnDirectors.size(); i++){ %>
                                        	<li class="slistm_2ul_li"><a class="slistm_2ul_li_a"
												href="javascript:searchPersonFilmos('<%=arrForReturnDirectors.get(i).getPeopleNm()%>')">
													<div class="a_div">
														<div class="a_div_div" alt="<%=arrForReturnDirectors.get(i).getPeopleNm()%>">
															<span class="slistm_2ul_li_sp"
																style="background-image:url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI0OCIgaGVpZ2h0PSI0OCIgdmlld0JveD0iMCAwIDQ4IDQ4Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPGcgZmlsbD0iI0UwRTBFMCI+CiAgICAgICAgICAgIDxwYXRoIGQ9Ik0yNCAyMS4yNzhhOC41NyA4LjU3IDAgMCAxLTguNTcxLTguNTdBOC41NzEgOC41NzEgMCAxIDEgMjQgMjEuMjc3TTQzLjUxOSA0My44NjVjLjU2NCAwIDEuMDMzLS40NjggMS4wMDMtMS4wMzFDNDMuOTYzIDMyLjQyNCAzNC45ODkgMjQuMTUgMjQgMjQuMTVjLTEwLjk4OSAwLTE5Ljk2MyA4LjI3NC0yMC41MjIgMTguNjgzLS4wMy41NjMuNDM5IDEuMDMgMS4wMDMgMS4wM2gzOS4wMzh6Ii8+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4K)"></span>
														</div>
													</div>
											
													<div class="a_div_div2">
														<div class="a_div_div2_info">
															<div class="a_div_div2_info_title"><%=arrForReturnDirectors.get(i).getPeopleNm()%><%=arrForReturnDirectors.get(i).getPeopleNmEn()%></div>
															<div class="a_div_div2_info_cn">감독</div>
														</div>
													</div>
												</a>	
											</li>
										   <%} %>
										    <% for(int i = 0; i < arrForReturnActors.size(); i++){ %>
                                        	<li class="slistm_2ul_li"><a class="slistm_2ul_li_a"
												href="javascript:searchPersonFilmos('<%=arrForReturnActors.get(i).getPeopleNm()%>')">
													<div class="a_div">
														<div class="a_div_div" alt="<%=arrForReturnActors.get(i).getPeopleNm()%>">
															<span class="slistm_2ul_li_sp"
																style="background-image:url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI0OCIgaGVpZ2h0PSI0OCIgdmlld0JveD0iMCAwIDQ4IDQ4Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPGcgZmlsbD0iI0UwRTBFMCI+CiAgICAgICAgICAgIDxwYXRoIGQ9Ik0yNCAyMS4yNzhhOC41NyA4LjU3IDAgMCAxLTguNTcxLTguNTdBOC41NzEgOC41NzEgMCAxIDEgMjQgMjEuMjc3TTQzLjUxOSA0My44NjVjLjU2NCAwIDEuMDMzLS40NjggMS4wMDMtMS4wMzFDNDMuOTYzIDMyLjQyNCAzNC45ODkgMjQuMTUgMjQgMjQuMTVjLTEwLjk4OSAwLTE5Ljk2MyA4LjI3NC0yMC41MjIgMTguNjgzLS4wMy41NjMuNDM5IDEuMDMgMS4wMDMgMS4wM2gzOS4wMzh6Ii8+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4K)"></span>
														</div>
													</div>
											
													<div class="a_div_div2">
														<div class="a_div_div2_info">
															<div class="a_div_div2_info_title"><%=arrForReturnActors.get(i).getPeopleNm() %> <%=arrForReturnActors.get(i).getPeopleNmEn() %></div>
															<div class="a_div_div2_info_cn"><%=arrForReturnActors.get(i).getCast() %> ・ <%=arrForReturnActors.get(i).getCastEn() %></div>
														</div>
													</div>
												</a>	
											</li>
										   <%} %>
                                        </ul>
    <!----------------------------------- ------------------->
                                </div>
                            </div>
                        </div>


						<div id="loding"></div>
                        </section>
                       <footer class="footermenu1">
								<%@ include file="footerinc.jsp"%>
						</footer>
                     
                </div>
            </div>
        </div>
	<script>
		// 영화 상세정보링크 생성 함수
		function searchPersonFilmos(peopleNm) { // 영화인 검색

			location.href = "searchresult.jsp?userinput=" + peopleNm;
		}
		
	</script>
      
    </body>
</html>