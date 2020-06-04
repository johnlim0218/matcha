<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String useridx = (String)session.getAttribute("sIdx");
	String username = (String)session.getAttribute("sName");
	
	if(useridx == null || useridx == "") {
		response.sendRedirect("main.jsp");
	}
%>
<!DOCTYPE html>
<html lang="en-KR">
  <head>
    <meta charset="utf-8">
    <title><%=username %>의 마이페이지</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
    <link rel="stylesheet" href="css/mypage_css.css">
  </head>


  <body>
    <div class="box">

      <header>
        <%@ include file="headerinc.jsp" %>
      </header>

      <section>
        <div>
          <div class="sectionbox1">
            <div class="sectionbox1-1">
              <div class="mainwallpaper">
                   <!-- <button aria-label="setting" class="settingicon"></button> --> 
              </div>
              <div class="m020">

                <header class="profile1">
                  <div class="mypic1">
                    <div class="mypic1-1"></div>
                  </div>
                  <div class="myname1">
                    <h1 class="myname1-1"><%=username %></h1>
                  </div>
                  <div class="introduce1">
                    <div class="introduce1-1">
                      <div style="white-space: pre-line;"><!-- 소개문을 입력해야 합니다. --></div>
                    </div>
                  </div>
                </header>

                <ul class="listbox1">
                  <li class="listbox1-1">
                    <a title="회원 정보 수정" href="profile.jsp">
                      <span class="listboxicon"></span> 
                      <span class="listln">회원 정보 수정</span>
                    </a>
                  </li>
                  <li class="listbox1-1">
                    <a title="내가 평가한 영화" href="mypage_starscoredlist.jsp">
                      <span class="listboxicon"></span> 
                      <span class="listln">평가한 영화</span>
                    </a>
                  </li>
                  <li class="listbox1-1">
                    <a title="코멘트 리스트" href="board_list.jsp?pages=1">
                      <span class="listboxicon"></span>
                      <span class="listln">코멘트 리스트</span>
                    </a>
                  </li>
                </ul>
              </div>

         
              <div class="scrapbox1">
                <ul class="scrapbox1-1">
                  <li class="scrapbox1-2">
                 	<a class="scrapboxlink" title="보고싶어요" href="mypage_wishlist.jsp">
                      <ul class="scrapboxlist">
                        <li class="sblist1">WatchList</li>
                        <li class="sblist2">★661</li>
                      </ul>
   					</a>
                  </li>
                </ul>
              </div>
       
            </div>
          </div>
        </div>
      </section>
      <footer">
        <%@ include file="footerinc.jsp" %>
      </footer>
    </div>

  </body>
</html>