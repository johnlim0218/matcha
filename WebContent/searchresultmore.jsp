<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	request.setCharacterEncoding("UTF-8");
	
	// 문자열 공백(띄어쓰기) 삭제
	String userInput = request.getParameter("userinput").replaceAll(" ", "");
	String nowPage = request.getParameter("nowpage");
	
    %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
       <link rel="stylesheet" type="text/css" href="./css/searchmoremovie.css">
        <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900&amp;subset=korean" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
        <title>영화 결과 더보기</title>
        <script>
        	
        	var nowPage = parseInt(<%=nowPage%>);
        
        	function backButton() {
        		window.history.back();
        	}
        	
        	
        	var ajx = function loding(){
        		
    		    $.ajax({
    		        type:"Get",
    		        url:"./searchresultmoreP.jsp",
    		        data: {"nowPage" : nowPage, "userinput" : "<%=userInput%>"},
    		        dateType : "text",
    		        success: function(text){
    		     		$(".slistm_2ul").append(text);
    		        },
    		        error: function(xhr,status,error){
    		            alert("에러");
    		        }
    		    });
    			
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
         		
         		
        		ajx(nowPage);
        	}
        	
        	});
        	
        	$("document").ready(ajx());
        	
        	
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
                                    <div class="infotitle">영화</div>
                                </div>

                                <div class="hidetitle">영화</div>
                                </div>




    <!----------------------------------- ------------------->
                            <div class="slist">
                                <div class="slistb">
            
                                        <ul class="slistm_2ul">
                                        
										
                                           
                                        </ul>
    <!----------------------------------- ------------------->
                                </div>
                            </div>
                        </div>


						<div id="loding"></div>
                        </section>
                        
                     
                </div>
            </div>
        </div>
	<script>
		// 영화 상세정보링크 생성 함수
		function moreInfo(movieCd) {

			location.href = "moreinfo.jsp?movieCd=" + movieCd;
		}
		
	</script>
      
    </body>
</html>