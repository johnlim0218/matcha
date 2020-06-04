<%@page import="dataBase.StarScoreHandler"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    request.setCharacterEncoding("UTF-8");
	StarScoreHandler starScoreHandlerFooter = new StarScoreHandler();
	int totalCountStarScore = starScoreHandlerFooter.connetJspToDBConnectorToGetTotalCountStarScore();
    
    %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/footerinc_css.css">
<title>Insert title here</title>
</head>
<body>
        <footer class="main_footer">
				<div class="main_footer_wrapper">
					<section class="main_footer_section">
						<div class="main_footer_section_left">
							<div class="main_footer_now">
								지금까지 <em>★ <%=totalCountStarScore %> 개의 평가가</em> 쌓였어요.
							</div>
							<ul class="main_footer_info1">
								<li class="main_footer_terms">서비스 이용약관</li>
								<li class="main_footer_privacy">개인정보 처리방침</li>
							</ul>
							<ul class="main_footer_info2">
								<li class="main_footer_regnum">사업자 등록 번호<span>(000-11-22222)</li>
								<li class="main_footer_cs">고객센터<a
									class="main_footer_cs_email">cs@matcha.com</a></li>
							</ul>
							<ul class="main_footer_info3">
								<span class="main_footer_bi"></span>
								<li class="main_footer_licen">© 2019–2019 by Matcha. Inc</li>
							</ul>
						</div>
						<div class="main_footer_section_right"></div>
					</section>
				</div>
			</footer>
</body>
</html>