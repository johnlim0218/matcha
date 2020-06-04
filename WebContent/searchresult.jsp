<%@page import="dataBase.ReturnUserInfo"%>
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

	String sIdx = (String) session.getAttribute("sIdx");
	String sUserId = (String) session.getAttribute("sUserid");
	String sName = (String) session.getAttribute("sName");

	// 문자열 공백(띄어쓰기) 삭제
	String userInput = request.getParameter("userinput").replaceAll(" ", "");

	SearchWordHandler dataHandler = new SearchWordHandler(request, response);

	// 1. 영화, 영화인 정보 검색 결과 (DB로부터)
	ArrayList<ReturnInfo> returnInfo = new ArrayList<>();
	returnInfo = dataHandler.connectJspToDBConnector(userInput);
	
	// 2. DB에 저장된 정보가 없을 경우 API에 접속해서 데이터를 수집
	if (returnInfo.size() == 0) {
		
		// 사용자가 입력한 검색어(userInput)를 searchWordHandler로 보내준다.
		dataHandler = new SearchWordHandler(userInput, request, response);
		// 영화, 영화인 정보 검색 결과 (DB로부터)
		returnInfo = dataHandler.connectJspToDBConnector(userInput);

	} else {
		
	}
	
	// 사용자 정보 검색 결과 (DB로부터)
	ArrayList<ReturnUserInfo> returnUserInfo = new ArrayList<>();
	returnUserInfo = dataHandler.connectJspToDBConnectorForUserInfo();

	if (returnInfo.size() == 0) {
		System.out.println("검색결과없음");
	}
	/////////////////////////////////////////////////////////////////////////////////////////////////////

	dataHandler.userinputToDBConnectorToCheckSuccessful(request, response, userInput, returnInfo.size());
	
	// 로그인 안해도 검색 가능하도록 협의, 따라서 해당 조건 분기 처리는 하지 않음.
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/searchresult_css.css">
<link
	href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900&amp;subset=korean"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<title>MATCHA</title>
</head>
<body>
	<div id="firstdiv">
		<div id="seconddiv">
			<div id="thirddiv">
				<header class="topsearch">
					<!-- 로그인 세션 상태에 따라서 다른 JSP를 include 합니다. -->
					<%
						if (sIdx == null || sIdx.equals("")) {
							// useridx session 값이 존재하지 않을 경우 logout 상태로 판단
					%>
					<%@ include file="headerinc_logout.jsp"%>
					<%
						} else {
							// useridx session 값이 존재할 경우 login 상태로 판단
					%>
					<%@ include file="headerinc.jsp"%>
					<%
						}
					%>
				</header>
				<section class="section1">
					<section class="section2">

						<!-- 상위 검색 결과  시작-->

						<section class="search">
							<div class="menuname">
								<div class="menuname2">
									<h2>상위 검색 결과</h2>
								</div>
							</div>
							<div class="slist">
								<div class="slistb">
									<div class="slistm">
										<ul class="slistm_ul">

											<%
												// 검색결과가 10건 이상일 경우
												if (returnInfo.size() >= 10) {

													for (int i = 0; i < 10; i++) {
														String movieCd = returnInfo.get(i).getMovieCd();
														String movieNm = returnInfo.get(i).getMovieNm();
														String imgUrl = returnInfo.get(i).getImgUrl();
											%>


											<li class="slistm_ul_li"><a
												href='javascript:moreInfo(<%=movieCd%>)' title=<%=movieNm%>>
													<div class="slistm_ul_li_div">
														<div class="slistm_ul_li_div_div">
															<img class="slistm_ul_li_div_div_img" src=<%=imgUrl%>>
														</div>
													</div>
													<div class="slistm_ul_li_info">
														<div class="slistm_ul_li_info_title"><%=movieNm%></div>
														<div class="slistm_ul_li_info_yyyy_ct">
															<%
																//Year 들어갈 자리
															%>
															・
															<%
																//country 들어갈 자리
															%>
														</div>
														<div class="slistm_ul_li_info_media">영화</div>
													</div>
											</a></li>
											<%
												}
													// 검색결과 10건 미만일 경우
												} else if (returnInfo.size() < 10) {
													for (int i = 0; i < returnInfo.size(); i++) {
														String movieCd = returnInfo.get(i).getMovieCd();
														String movieNm = returnInfo.get(i).getMovieNm();
														String imgUrl = returnInfo.get(i).getImgUrl();
											%>


											<li class="slistm_ul_li"><a
												href='javascript:moreInfo(<%=movieCd%>)' title=<%=movieNm%>>
													<div class="slistm_ul_li_div">
														<div class="slistm_ul_li_div_div">
															<img class="slistm_ul_li_div_div_img" src=<%=imgUrl%>>
														</div>
													</div>
													<div class="slistm_ul_li_info">
														<div class="slistm_ul_li_info_title"><%=movieNm%></div>
														<div class="slistm_ul_li_info_yyyy_ct">
															<%
																//Year 들어갈 자리
															%>

															<%
																//country 들어갈 자리
															%>
														</div>
														<div class="slistm_ul_li_info_media">영화</div>
													</div>
											</a></li>
											<%
												}
												}
											%>
											<!-- 상위 검색 결과  끝-->



										</ul>

									</div>
								</div>
							</div>
							<hr>
						</section>




						<section class="smovie">
							<div class="menuname">
								<div class="menuname2">
									<h2>영화</h2>
									<div class="more">
										<div class="more2">
											<a class="morea" href='javascript:searchResultMore()'>더보기</a>
										</div>
									</div>
								</div>
							</div>

							<div class="slist">
								<div class="slistb">

									<ul class="slistm_2ul">

										<%
											if (returnInfo.size() >= 9) {
												for (int i = 0; i < 9; i++) {
													String movieCd = returnInfo.get(i).getMovieCd();
													String movieNm = returnInfo.get(i).getMovieNm();
													String imgUrl = returnInfo.get(i).getImgUrl();
										%>

										<li class="slistm_2ul_li"><a class="slistm_2ul_li_a"
											href='javascript:moreInfo(<%=movieCd%>)'>
												<div class="a_div">
													<div class="a_div_div" alt=<%=movieNm%>>
														<span class="slistm_2ul_li_sp"
															style="background-image:url(<%=imgUrl%>);"></span>
													</div>
												</div>

												<div class="a_div_div2">
													<div class="a_div_div2_info">
														<div class="a_div_div2_info_title"><%=movieNm%></div>
														<div class="a_div_div2_info_cn">
															<%
																//Year
															%>
															・
															<%
																//country
															%>
														</div>
													</div>
												</div>
										</a></li>

										<%
											}
											} else if (returnInfo.size() < 9) {
												for (int i = 0; i < returnInfo.size(); i++) {
													String movieCd = returnInfo.get(i).getMovieCd();
													String movieNm = returnInfo.get(i).getMovieNm();
													String imgUrl = returnInfo.get(i).getImgUrl();
										%>

										<li class="slistm_2ul_li"><a class="slistm_2ul_li_a"
											href='javascript:moreInfo(<%=movieCd%>)'>
												<div class="a_div">
													<div class="a_div_div" alt=<%=movieNm%>>
														<span class="slistm_2ul_li_sp"
															style="background-image:url(<%=imgUrl%>);"></span>
													</div>
												</div>

												<div class="a_div_div2">
													<div class="a_div_div2_info">
														<div class="a_div_div2_info_title"><%=movieNm%></div>
														<div class="a_div_div2_info_cn">
															<%
																//Year
															%>
															・
															<%
																//country
															%>
														</div>
													</div>
												</div>
										</a></li>
										<%
											}
											}
										%>



										<!-- ---------------------------------------------------------------------------------------------------------------- -->

									</ul>

								</div>
							</div>

							<hr>
						</section>

						<section class="Users">
							<div class="menuname">
								<div class="menuname2">
									<h2>사용자</h2>
									<div class="more">
										<div class="more2">
											<a class="morea" href="#"></a>
										</div>
									</div>
								</div>
							</div>
							<div class="slist">
								<div class="slistb">
									<ul class="slistm_2ul">

										<%
											if (returnUserInfo.size() > 0) {
												for (int i = 0; i < returnUserInfo.size(); i++) {
										%>
										<li class="slistm_2ul_li"><a class="slistm_2ul_li_a"
											href="#">
												<div class="a_div">
													<div class="a_div_div"
														alt="<%=returnUserInfo.get(i).getMem_userid()%>">
														<span class="slistm_2ul_li_sp"
															style="background-image: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI0OCIgaGVpZ2h0PSI0OCIgdmlld0JveD0iMCAwIDQ4IDQ4Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPGcgZmlsbD0iI0UwRTBFMCI+CiAgICAgICAgICAgIDxwYXRoIGQ9Ik0yNCAyMS4yNzhhOC41NyA4LjU3IDAgMCAxLTguNTcxLTguNTdBOC41NzEgOC41NzEgMCAxIDEgMjQgMjEuMjc3TTQzLjUxOSA0My44NjVjLjU2NCAwIDEuMDMzLS40NjggMS4wMDMtMS4wMzFDNDMuOTYzIDMyLjQyNCAzNC45ODkgMjQuMTUgMjQgMjQuMTVjLTEwLjk4OSAwLTE5Ljk2MyA4LjI3NC0yMC41MjIgMTguNjgzLS4wMy41NjMuNDM5IDEuMDMgMS4wMDMgMS4wM2gzOS4wMzh6Ii8+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4K');"></span>
													</div>
												</div>

												<div class="a_div_div2">
													<div class="a_div_div2_info">
														<div class="a_div_div2_info_title"><%=returnUserInfo.get(i).getMem_name()%></div>
														<div class="a_div_div2_info_cn"><%=returnUserInfo.get(i).getMem_idx()%></div>
													</div>
												</div>
										</a></li>

										<%
											}
											}
										%>
									</ul>
								</div>
							</div>
							<hr>
						</section>
					</section>
				</section>
				<footer class="footermenu1">
					<%@ include file="footerinc.jsp"%>
				</footer>
			</div>
		</div>
	</div>

	<script type="text/javascript" src="js/searchresult_js.js"></script>
	<script>
		// 영화 상세정보링크 생성 함수
		function moreInfo(movieCd) {

			location.href = "moreinfo.jsp?movieCd=" + movieCd;
		}
		
		function searchResultMore(){
			
			location.href = "searchresultmore.jsp?userinput=<%=userInput%>&nowpage=1";

		}
	</script>
</body>
</html>