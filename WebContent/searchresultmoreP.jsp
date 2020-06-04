<%@page import="dataBase.ReturnInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dataBase.SearchWordHandler"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	// 문자열 공백(띄어쓰기) 삭제
	String userInput = request.getParameter("userinput").replaceAll(" ", "");
	String nowPage = (String) request.getParameter("nowPage");

	SearchWordHandler searchWordHandler = new SearchWordHandler(request, response);
	searchWordHandler.setUserInput(userInput);
	int listTotal = searchWordHandler.connectJspToDBConnectorForCountNumOfData();
	int totalPage = 0;
	int tempTotalpage = 0;
	int tempListTotal = 0;

	tempListTotal = listTotal - 10;
	tempListTotal /= 5;
	totalPage = tempListTotal + 2;

	// DB에서 더 가져와야할 데이터 개수
	if (!nowPage.equals("1")) {
		listTotal -= (Integer.parseInt(nowPage) * 5);
	}

	ArrayList<ReturnInfo> returnArr = new ArrayList<>();

	// DB에서 가져올 데이터의 수가 15개 이상일 때 (2페이지 이상일 때)
	if (listTotal > 10) {

		// 앞에서 계산한 예상 totalPage를 넘어가면 DB에 접근하지 못하게한다.
		if (totalPage >= Integer.parseInt(nowPage)) {

			returnArr = searchWordHandler.connectJspToDBConnectorForSearchResultMorePaging(nowPage);
		}
		// DB에서 가져올 데이터의 수가 15개 미만일 때	
	} else {
		returnArr = searchWordHandler.connectJspToDBConnectorForSearchResultMorePaging(nowPage);
	}

	for (int i = 0; i < returnArr.size(); i++) {
%>
		<li class="slistm_2ul_li"><a class="slistm_2ul_li_a"
			href="javascript:moreInfo(<%=returnArr.get(i).getMovieCd()%>)">
				<div class="a_div">
					<div class="a_div_div" alt="<%=returnArr.get(i).getMovieNm()%>">
						<span class="slistm_2ul_li_sp"
							style="background-image:url(<%=returnArr.get(i).getImgUrl()%>)"></span>
					</div>
				</div>
		
				<div class="a_div_div2">
					<div class="a_div_div2_info">
						<div class="a_div_div2_info_title"><%=returnArr.get(i).getMovieNm()%></div>
						<div class="a_div_div2_info_cn">・</div>
					</div>
				</div>
		</a></li>
<%
	}
%>