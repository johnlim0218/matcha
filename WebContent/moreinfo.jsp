<%@page import="dataBase.StarScoreHandler"%>
<%@page import="dataBase.ReturnBoard"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dataBase.SearchWordHandler"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dataBase.MoreInfoHandler"%>
<%@ page import="dataBase.MovieMoreInfo"%>
<%
	request.setCharacterEncoding("UTF-8");

	String movieCd = request.getParameter("movieCd");
	MoreInfoHandler moreInfoHandler = new MoreInfoHandler(movieCd);

	MovieMoreInfo movieMoreInfo = moreInfoHandler.getMovieMoreInfo();
	ArrayList<ReturnBoard> returnArrForMovieArticle = new ArrayList<>();
	returnArrForMovieArticle = moreInfoHandler.getReturnArrForMovieArticle();
	
	
	String openDtYear = "";
	String openDtMonth = "";
	String openDtDate = "";

	if (movieMoreInfo.getOpenDt().length() == 8) {
		openDtYear = movieMoreInfo.getOpenDt().substring(0, 4) + "년";
		openDtMonth = movieMoreInfo.getOpenDt().substring(4, 6);
		int parseOpenDtMonth = Integer.parseInt(openDtMonth);
		openDtMonth = parseOpenDtMonth + "";
		openDtMonth += "월";

		openDtDate = movieMoreInfo.getOpenDt().substring(6, 8);
		int parseOpenDtDate = Integer.parseInt(openDtDate);
		openDtDate = parseOpenDtDate + "";
		openDtDate += "일";
	}
	// 평점 담아올 변수
	int starScore = 0;
	// 로그인 세션이 있을 때만 평점을 가져온다.
	if ((String) session.getAttribute("sIdx") != null) {
		StarScoreHandler starScoreHandler = new StarScoreHandler();
		starScore = starScoreHandler.connectJspToDBConnectorToGetStarScore(movieCd,
				(String) session.getAttribute("sIdx"));
		
	}
	
	request.setAttribute("movieTitle", movieMoreInfo.getMovieNm());
%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<title></title>
<link
	href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- jQuery 호출 -->
<link href="css/moreinfo_css.css" rel="stylesheet" type="text/css">
<link href="css/main.css" rel="stylesheet" type="text/css">
<link href="css/loading.css" rel="stylesheet" type="text/css">
<!-- main.css 파일 호출 -->
<link rel="stylesheet" href="css/footerinc_css.css" type="text/css">
<link rel="stylesheet" href="css/star_score.css" type="text/css">
<meta http-equiv="X-UA-Compatible" content="IE=edge,IE=9,chrome=1" />

</head>
<body>
	<div class="loading" onclick="canc()">
		<div class="lodingicon">

  		 </div>
   </div>
   <!-- 로딩 -->
	<div class="body_body">
		<div class="body_wrapper">
		
		
			<header class="main_header">
				<!-- 로그인 세션 상태에 따라서 다른 JSP를 include 합니다. -->
				<%
					if ((String) session.getAttribute("sIdx") == null || ((String) session.getAttribute("sIdx")).equals("")) {
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
			<section class="main_section">
				<div class="main_section_outer">
					<div class="section_wrapper">
						<section class="inner_top">
							<div class="main_top_info">
								<div class="main_top_wrapper">
									<div color="#332850" class="main_top_left"></div>
									<div color="#332850" class="main_top_right"></div>
									<div class="main_top_image">
										<div class="main_top_image_left"></div>
										<div class="main_top_image_right"></div>
									</div>
									<div class="main_top_background"></div>
								</div>
								<div class="main_top_lower_wrapper">
									<div class="main_top_lower">
										<div class="main_top_lower_inner">
											<div class="main_top_lower_info">
												<div class="main_top_poster">
													<img alt="" class="main_poster_img"
														src="<%=movieMoreInfo.getImgUrl()%>">
												</div>
												<ul class="main_top_lower_infolist">
													<li>예매 순위 <em>1</em>
													</li>
													<li>개봉 <em>1</em>
													</li>
													<li>누적 관객 <em>1</em>
													</li>
												</ul>
											</div>
										</div>

									</div>
								</div>
							</div>
							<div class="main_top_sum_wrapper">
								<div class="main_top_sum_inner">
									<div class="main_top_sum_inner_inner">
										<div class="main_top_sum_inner_inner_inner">
											<div class="main_top_sum">
												<h1 class="main_top_title"><%=movieMoreInfo.getMovieNm()%>&nbsp<%=movieMoreInfo.getMovieNmEn()%></h1>
												<div class="main_top_title_info"><%=openDtYear + " " + openDtMonth + " " + openDtDate%>
													·
													<%
													for (int i = 0; i < movieMoreInfo.getGenres().size(); i++) {
												%>
													<%=movieMoreInfo.getGenres().get(i).getGenreNm()%>
													<%
														}
													%>
													·
													<%
														for (int i = 0; i < movieMoreInfo.getNations().size(); i++) {
													%>
													<%=movieMoreInfo.getNations().get(i).getNationNm()%>
													<%
														}
													%>
												</div>
												<div class="main_top_judgescore">평점 ★5 (5천만 명)</div>
												<div class="main_top_likeit_wrapper">
													<div class="main_top_likeit">
														<button type="button" class="likeit_button">
															<div class="likeit_button_letters">
																<span
																	src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSIyNHB4IiB2aWV3Qm94PSIwIDAgMjQgMjQiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogc2tldGNodG9vbCA1MC4yICg1NTA0NykgLSBodHRwOi8vd3d3LmJvaGVtaWFuY29kaW5nLmNvbS9za2V0Y2ggLS0+CiAgICA8dGl0bGU+NjMwMjYxNEEtQzhBMy00MkMwLTlDQzctQTBEQzNDOEM1NTVDPC90aXRsZT4KICAgIDxkZXNjPkNyZWF0ZWQgd2l0aCBza2V0Y2h0b29sLjwvZGVzYz4KICAgIDxkZWZzPjwvZGVmcz4KICAgIDxnIGlkPSJJY29ucy0mYW1wOy1Bc3NldHMiIHN0cm9rZT0ibm9uZSIgc3Ryb2tlLXdpZHRoPSIxIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPgogICAgICAgIDxnIGlkPSJJY29uLS8tSWNBZGRXaGl0ZSIgZmlsbD0iI0ZGRkZGRiI+CiAgICAgICAgICAgIDxyZWN0IGlkPSJSZWN0YW5nbGUtMyIgeD0iMTEiIHk9IjQuNSIgd2lkdGg9IjIiIGhlaWdodD0iMTUiIHJ4PSIxIj48L3JlY3Q+CiAgICAgICAgICAgIDxyZWN0IGlkPSJSZWN0YW5nbGUtMy1Db3B5IiB4PSI0LjUiIHk9IjExIiB3aWR0aD0iMTUiIGhlaWdodD0iMiIgcng9IjEiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg=="
																	class="likeit_button_img"></span>
																<div class="likeit_likeit">보고싶어요</div>
															</div>
														</button>
														<button class="likeit_button_arrow">
															<svg fill width="24" height="24" viewBox="0 0 24 24"
																class="likeit_button_arrow_img">
                                                            <path
																	fill="fff" fill-rule="evenodd"></path>                                               
                                                        </svg>
														</button>
													</div>
												</div>
												<div class="main_top_score_wrapper">
													<div class="main_top_score_inner">
														<div class="main_top_score_letter">평가하기</div>
													</div>
													<div class="main_top_score_image">
														<div class="main_top_score_image_inner">
															<!-- 평점 부분 삽입했습니다. 190605, 이승우 -->
															<div class="starRev">
																<span class="starR1 on" id="score1">별1_왼쪽</span> <span
																	class="starR2" id="score2">별1_오른쪽</span> <span
																	class="starR1" id="score3">별2_왼쪽</span> <span
																	class="starR2" id="score4">별2_오른쪽</span> <span
																	class="starR1" id="score5">별3_왼쪽</span> <span
																	class="starR2" id="score6">별3_오른쪽</span> <span
																	class="starR1" id="score7">별4_왼쪽</span> <span
																	class="starR2" id="score8">별4_오른쪽</span> <span
																	class="starR1" id="score9">별5_왼쪽</span> <span
																	class="starR2" id="score10">별5_오른쪽</span>
															</div>
														</div>
													</div>
												</div>
												<%if(starScore != 0) {%>
												<div class="main_top_num_score_wrapper">
													<div class="main_top_num_score_inner">
														<div class="main_top_score_letter">나의 평점</div>
													</div>
													<div class="main_top_score_num">
														<div class="main_top_score_num_inner">
															<div class="starRev">
																<span class="numScore" id="numScore"><%=starScore %>점</span> 
															</div>
														</div>
													</div>
												</div>
												<%} %>
											</div>
										</div>
									</div>
								</div>
							</div>

						</section>



						<div class="main_lower">
							<div class="main_lower_wrapper">
								<div class="main_lower_wrapper_margin">
									<div class="main_lower_inner_position">
										<div class="main_lower_inner_align">
											<div class="main_lower_border">
												<section class="main_lower_section">
													<div class="main_lower_section_wrapper">
														<div class="main_lower_section_inner">
															<header class="main_lower_section_header">
																<h2 class="main_lower_section_header_name">기본정보</h2>
																<div class="main_lower_section_more_wrapper">
																	<div class="main_lower_section_more_inner">
																		<a class="main_lower_section_more_button"><!-- 더보기 --></a>
																	</div>
																</div>
															</header>
														</div>
													</div>
													<div class="main_lower_section_lower_wrapper">
														<div class="main_lower_section_lower_inner">
															<article class="main_lower_article">
																<div class="main_lower_article_inner"><%=movieMoreInfo.getMovieNm()%>
																	<%=movieMoreInfo.getMovieNmEn()%><br> <span
																		class="main_lower_article_contents"><%=openDtYear%>
																		· <%
 	for (int i = 0; i < movieMoreInfo.getGenres().size(); i++) {
 %> <%=movieMoreInfo.getGenres().get(i).getGenreNm()%> <%
 	}
 %> · <%
 	for (int i = 0; i < movieMoreInfo.getNations().size(); i++) {
 %> <%=movieMoreInfo.getNations().get(i).getNationNm()%> <%
 	}
 %> </span><br> <span class="main_lower_article_contents"><%=movieMoreInfo.getShowTm() + "분"%></span>
																</div>
																<div class="main_lower_article_box">
																	<div class="main_lower_article_box_inner"><!-- 영화 개요 --></div>
																</div>
															</article>
															<hr class="main_lower_divline">
														</div>
													</div>
												</section>
												<section class="main_lower_section">
													<div class="main_lower_section_wrapper">
														<div class="main_lower_section_inner">
															<header class="main_lower_section_header">
																<h2 class="main_lower_section_header_name">출연/제작</h2>
																<div class="main_lower_section_more_wrapper">
																	<div class="main_lower_section_more_inner">
																		<a class="main_lower_section_more_button" href="javascript:peopleMore()">더보기</a>
																	</div>
																</div>
															</header>
														</div>
													</div>
													<div class="main_lower_people_wrapper">
														<div class="main_lower_people_inner">
															<div class="main_lower_people_inner_wrapper">
																<div class="main_lower_people_inner_inner">
																	<div class="main_lower_people_list_wrapper">
																		<ul class="main_lower_people_list">
																			<%
																				for (int i = 0; i < movieMoreInfo.getDirectors().size(); i++) {
																			%>
																			<li class="main_lower_people_Alist"><a
																				lng="ko-KR"
																				title="<%=movieMoreInfo.getDirectors().get(i).getPeopleNm()%>"
																				class="main_people_link"
																				href="javascript:searchPersonFilmos('<%=movieMoreInfo.getDirectors().get(i).getPeopleNm()%>')">
																					<div class="main_lower_people_pic_wrapper">
																						<div class="main_lower_pic_inner">
																							<span class="main_lower_pic"
																								src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI0OCIgaGVpZ2h0PSI0OCIgdmlld0JveD0iMCAwIDQ4IDQ4Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPGcgZmlsbD0iI0UwRTBFMCI+CiAgICAgICAgICAgIDxwYXRoIGQ9Ik0yNCAyMS4yNzhhOC41NyA4LjU3IDAgMCAxLTguNTcxLTguNTdBOC41NzEgOC41NzEgMCAxIDEgMjQgMjEuMjc3TTQzLjUxOSA0My44NjVjLjU2NCAwIDEuMDMzLS40NjggMS4wMDMtMS4wMzFDNDMuOTYzIDMyLjQyNCAzNC45ODkgMjQuMTUgMjQgMjQuMTVjLTEwLjk4OSAwLTE5Ljk2MyA4LjI3NC0yMC41MjIgMTguNjgzLS4wMy41NjMuNDM5IDEuMDMgMS4wMDMgMS4wM2gzOS4wMzh6Ii8+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4K">

																							</span>
																						</div>
																					</div>
																					<div class="main_lower_people_info_wrapper">
																						<div class="main_lower_people_info_inner">
																							<div class="main_lower_people_info_name">
																								<%=movieMoreInfo.getDirectors().get(i).getPeopleNm()%>
																								<%=movieMoreInfo.getDirectors().get(i).getPeopleNmEn()%>
																							</div>
																							<div class="main_lower_people_info_position">
																								감독</div>
																						</div>
																					</div>
																			</a></li>
																			<%
																				}
																			%>
																			<%
																				if (movieMoreInfo.getActors().size() > 2) {
																					for (int i = 0; i < 3; i++) {
																			%>
																			<li class="main_lower_people_Alist"><a
																				lng="ko-KR" title="<%=movieMoreInfo.getActors().get(i).getPeopleNm()%>"
																				class="main_people_link"
																				href="javascript:searchPersonFilmos('<%=movieMoreInfo.getActors().get(i).getPeopleNm()%>')">
																					<div class="main_lower_people_pic_wrapper">
																						<div class="main_lower_pic_inner">
																							<span class="main_lower_pic"
																								src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI0OCIgaGVpZ2h0PSI0OCIgdmlld0JveD0iMCAwIDQ4IDQ4Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPGcgZmlsbD0iI0UwRTBFMCI+CiAgICAgICAgICAgIDxwYXRoIGQ9Ik0yNCAyMS4yNzhhOC41NyA4LjU3IDAgMCAxLTguNTcxLTguNTdBOC41NzEgOC41NzEgMCAxIDEgMjQgMjEuMjc3TTQzLjUxOSA0My44NjVjLjU2NCAwIDEuMDMzLS40NjggMS4wMDMtMS4wMzFDNDMuOTYzIDMyLjQyNCAzNC45ODkgMjQuMTUgMjQgMjQuMTVjLTEwLjk4OSAwLTE5Ljk2MyA4LjI3NC0yMC41MjIgMTguNjgzLS4wMy41NjMuNDM5IDEuMDMgMS4wMDMgMS4wM2gzOS4wMzh6Ii8+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4K">

																							</span>
																						</div>
																					</div>
																					<div class="main_lower_people_info_wrapper">
																						<div class="main_lower_people_info_inner">
																							<div class="main_lower_people_info_name">
																								<%=movieMoreInfo.getActors().get(i).getPeopleNm()%>
																								<%=movieMoreInfo.getActors().get(i).getPeopleNmEn()%>
																							</div>
																							<div class="main_lower_people_info_position">
																								<%=movieMoreInfo.getActors().get(i).getCast()%>
																								<%=movieMoreInfo.getActors().get(i).getCastEn()%>
																							</div>
																						</div>
																					</div>
																			</a></li>
																			<%
																				}
																				} else {
																					for (int i = 0; i < movieMoreInfo.getActors().size(); i++) {
																			%>
																			<li class="main_lower_people_Alist"><a
																				lng="ko-KR" title="<%=movieMoreInfo.getActors().get(i).getPeopleNm()%>"
																				class="main_people_link"
																				href="javascript:searchPersonFilmos('<%=movieMoreInfo.getActors().get(i).getPeopleNm()%>')">
																					<div class="main_lower_people_pic_wrapper">
																						<div class="main_lower_pic_inner">
																							<span class="main_lower_pic"
																								src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI0OCIgaGVpZ2h0PSI0OCIgdmlld0JveD0iMCAwIDQ4IDQ4Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPGcgZmlsbD0iI0UwRTBFMCI+CiAgICAgICAgICAgIDxwYXRoIGQ9Ik0yNCAyMS4yNzhhOC41NyA4LjU3IDAgMCAxLTguNTcxLTguNTdBOC41NzEgOC41NzEgMCAxIDEgMjQgMjEuMjc3TTQzLjUxOSA0My44NjVjLjU2NCAwIDEuMDMzLS40NjggMS4wMDMtMS4wMzFDNDMuOTYzIDMyLjQyNCAzNC45ODkgMjQuMTUgMjQgMjQuMTVjLTEwLjk4OSAwLTE5Ljk2MyA4LjI3NC0yMC41MjIgMTguNjgzLS4wMy41NjMuNDM5IDEuMDMgMS4wMDMgMS4wM2gzOS4wMzh6Ii8+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4K">

																							</span>
																						</div>
																					</div>
																					<div class="main_lower_people_info_wrapper">
																						<div class="main_lower_people_info_inner">
																							<div class="main_lower_people_info_name">
																								<%=movieMoreInfo.getActors().get(i).getPeopleNm()%>
																								<%=movieMoreInfo.getActors().get(i).getPeopleNmEn()%>
																							</div>
																							<div class="main_lower_people_info_position">
																								<%=movieMoreInfo.getActors().get(i).getCast()%>
																								<%=movieMoreInfo.getActors().get(i).getCastEn()%>
																							</div>
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
															</div>
														</div>
													</div>
													<div class="main_lower_divline_wrapper">
														<div class="main_lower_divline_inner">
															<hr class="main_lower_divline_divline">
														</div>
													</div>
												</section>
											</div>
										</div>
									</div>
								</div>
								<div class="main_lower_wrapper_margin">
									<div class="main_lower_inner_position">
										<div class="main_lower_inner_bottom_border">
											<section class="main_lower_section">
												<div class="main_lower_section_wrapper">
													<div class="main_lower_section_inner">
														<header class="main_lower_section_header">
															<h2 class="main_lower_section_header_name">코멘트</h2>
															<span class="main_loser_section_write_button"><a
																href="board_write.jsp?movieCd=<%=movieCd%>">글쓰기</a></span>
															<div class="main_lower_section_more_wrapper">
																<div class="main_lower_section_more_inner">
																	<a class="main_lower_section_more_button" href="board_list.jsp?pages=1&movieCd=<%=movieCd%>&movieNm=<%=movieMoreInfo.getMovieNm()%>">더보기</a>
																</div>
															</div>
														</header>
													</div>
												</div>
												<div class="main_lower_section_comments_wrapper">
													<div class="main_lower_section_comments_overflow">
														<div class="main_lower_section_comments_inner">
															<div class="main_lower_comments_inner_inner">
																<div class="main_lower_comments_margin">
																	<ul class="comments_ul">

																		<%
																			if (returnArrForMovieArticle.size() >= 1) {
																				for (int i = 0; i < 1; i++) {
																		%>
																		<li class="comments_list">
																			<div class="comments_list_wrapper">
																				<div class="comments_list_flex">
																					<div class="comments_list_font">
																						<a lng="ko-KR" class="comments_contents_link"
																							href="board_view.jsp?b_idx=<%=returnArrForMovieArticle.get(i).getB_idx()%>">
																							<div class="comments_pic_wrapper">
																								<div class="comments_pic"></div>
																							</div>
																							<div class="comments_name"><%=returnArrForMovieArticle.get(i).getB_name()%></div>
																						</a>
																					</div>
																				</div>
																				<div class="comments_contents_wrapper">
																					<a lng="ko-KR" class="comments_contents_link"
																						href="board_view.jsp?b_idx=<%=returnArrForMovieArticle.get(i).getB_idx()%>">
																						<div class="comments_contents_inner">
																							<div class="comments_contents_space"><%=returnArrForMovieArticle.get(i).getB_content()%></div>
																						</div>
																					</a>
																				</div>
																				<div class="comments_likeit_wrapper">
																					<span width="18px" height="18px"
																						class="comments_likeit_thumb"></span> <em><%=returnArrForMovieArticle.get(i).getB_likeit()%></em>
																					<span width="18px" height="18px"
																						class="comments_likeit_comments"></span> <em><%=returnArrForMovieArticle.get(i).getCountOfComment() %></em>
																				</div>
																				<div class="comments_likeit_button">
																					<button class="comments_likeit" type="button"
																						onclick="location.href='board_likeitP.jsp?b_idx=' + '<%=returnArrForMovieArticle.get(i).getB_idx()%>' + '&movieCd=' + '<%=movieCd%>'">좋아요</button>
																				</div>
																			</div>
																		</li>

																		<%
																			}
																		} else if (returnArrForMovieArticle.size() == 0){
																		%>
																		<li class="comments_list_none">
																			<div class="comments_list_none_wrapper">
																				<div class="comments_list_none_flex">
																					<div class="comments_list_font">
																						<a lng="ko-KR" class="comments_contents_link"
																							href="board_write.jsp?movieCd=<%=movieCd%>">
																							<div class="comments_none">
																							<div class="comments_none_none">이 영화에 대한 코멘트가 아직 없어요.<br></div>
																							<div class="comments_none_none">당신이 최초의 코멘터가 되어 주세요.<br></div>
																							</div>
																						</a>
																					</div>
																				</div>
																			</div>
																		</li>
																		<%} %>
																		
																	</ul>
																</div>
															</div>
														</div>
													</div>
												</div>
											</section>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>

		</div>
	</div>
	<!-- 이 부분은 로그인 / 회원가입 팝업 부분입니다. -->
	<!-- 아래 부분은 로그인 부분입니다. -->
	<div class="body_wrapper_darken" id="body_wrapper_darken_login">
		<div class="body_darken_inner">
			<div class="popup_wrapper">
				<div class="popup_inner">
					<header class="popup_header">
						<span class="popup_header_bi"></span>
					</header>
					<h2 class="popup_title">로그인</h2>
					<section>
						<div class="popup_section_wrapper">
							<div class="popup_section_inner">
								<form method="post" action="loginP.jsp">
									<div class="popup_input_id">
										<label class="popup_input_label">
											<div class="popup_input_label_inner">
												<input id="popup_input_id_input_id"
													class="popup_input_id_input" type="text" name="id"
													placeholder="아이디" autocomplete="off">
											</div>
										</label>
									</div>
									<div class="popup_input_pw">
										<label class="popup_input_label">
											<div class="popup_input_label_inner">
												<input id="popup_input_pw_input_id"
													class="popup_input_pw_input" type="password" name="pw"
													placeholder="비밀번호" autocomplete="off">
											</div>
										</label>
									</div>
									<button class="popup_input_button">로그인</button>
								</form>
								<div></div>
								<div class="popup_regist">
									계정이 없으신가요?
									<button class="popup_regist_button">회원가입</button>
								</div>
							</div>
						</div>
					</section>
				</div>
			</div>
		</div>
	</div>
	<!-- 아래 부분은 회원가입 부분입니다. -->
	<div class="body_wrapper_darken" id="body_wrapper_darken_regist">
		<div class="body_darken_inner">
			<div class="popup_wrapper">
				<div class="popup_inner">
					<header class="popup_header">
						<span class="popup_header_bi"> </span>
					</header>
					<h2 class="popup_title">회원가입</h2>
					<section>
						<div class="popup_section_wrapper">
							<div class="popup_section_inner">
								<form method="post" action="registP.jsp">
									<div class="popup_input_username">
										<label class="popup_input_label">
											<div class="popup_input_label_inner">
												<input type="text" name="name"
													id="popup_input_username_input_id"
													class="popup_input_username_input" label="이름"
													placeholder="이름">
											</div>
										</label>
									</div>
									<div class="popup_input_id">
										<label class="popup_input_label">
											<div class="popup_input_label_inner">
												<input type="text" name="id" id="popup_input_id_input_id"
													class="popup_input_id_input" label="아이디" placeholder="아이디">
											</div>
										</label>
									</div>
									<div class="popup_input_pw">
										<label class="popup_input_label">
											<div class="popup_input_label_inner">
												<input type="password" name="pw"
													id="popup_input_pw_input_id" class="popup_input_pw_input"
													label="비밀번호" placeholder="비밀번호">
											</div>
										</label>
									</div>
									<div class="popup_input_pw">
										<label class="popup_input_label">
											<div class="popup_input_label_inner">
												<input type="text" name="gender"
													id="popup_input_pw_input_id" class="popup_input_pw_input"
													label="성별" placeholder="성별">
											</div>
										</label>
									</div>
									<button class="popup_input_button">회원가입</button>
								</form>
								<div class="popup_forget">
									이미 가입하셨나요?
									<button class="popup_forget_button">로그인</button>
								</div>

							</div>
						</div>
					</section>
				</div>
			</div>
		</div>
	</div>
	<footer>
		<%@ include file="footerinc.jsp"%>
	</footer>
	
	<script type="text/javascript" src="js/main.js"></script>
	<!-- main page 구동 js 파일 호출 -->
	<script>
		function peopleMore(){
			
			location.href = "moreinfopeoplemore.jsp?movieCd=" + <%=movieCd%> + "&movieNm=" + '<%=movieMoreInfo.getMovieNm()%>';
		}
	
		function searchPersonFilmos(peopleNm) { // 영화인 검색
			$('.loading').show();
			location.href = "searchresult.jsp?userinput=" + peopleNm;
		}

		var addWish = document.getElementsByClassName("likeit_button");
		addWish[0].addEventListener('click', addWishList);
		function addWishList() {
			location.href = "wishlistP.jsp?movieCd=" + <%=movieCd%>;
		}
	</script>
	
	<!-- 평점 js -->
	<script>
		var score = null;
		var scoreout = null;
		$(".starRev span").click(function() {
			score = $(this).attr('id');
			scoreout = score.substring(5, 7);
			location.href = "starScoreP.jsp?starScore=" + scoreout +"&movieCd=<%=movieCd%>";
					// alert(scoreout);
				});
		$('.starRev span').hover(function() {
			$(this).parent().children('span').removeClass('on');
			$(this).addClass('on').prevAll('span').addClass('on');
		}, function() {
			$('#' + score).parent().children('span').removeClass('on');
			$('#' + score).addClass('on').prevAll('span').addClass('on');
		});
		
		var scoreOnLoad = parseInt(<%=starScore%>);
		$("document").ready(function(){
			if(scoreOnLoad > 0){
				$('#score' + scoreOnLoad).addClass('on').prevAll('span').addClass('on');
			}
		});
	</script>
	<!-- 평점 js -->
	
</body>
</html>