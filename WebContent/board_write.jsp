<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String useridx = (String)session.getAttribute("sIdx");
	String username = (String)session.getAttribute("sName");
	String movieCd = request.getParameter("movieCd");
	
	if(useridx == null){
	%>
	<script>
		alert("로그인해주세요");
		history.back();
	</script>
	<%
	}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf_8">
        <link rel="stylesheet" href="css/Board_write_css.css">
        <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900" rel="stylesheet"> <!-- google noto-sans font 호출 -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> <!-- jQuery 호출 -->
		<script src="https://cdn.ckeditor.com/ckeditor5/12.0.0/classic/ckeditor.js"></script>
        <title>게시글 작성</title>
    </head>
    <script>
    $(document).ready(function() {
    	// submitBoard 영역 선택 시 이벤트 발생
    	$("#submitBoard").click(function () {
    		$("#boardForm").submit();
    	});
    });
    </script>
    <body>
    	<header>
        <%@ include file="headerinc.jsp" %>
     	 </header>
        <div class="container">
        	<form name="boardForm" method="post" action="board_writeP.jsp?movieCd=<%=movieCd %>" enctype="Multipart/form-data" id="boardForm">
            <header class="container_header">
            <div class="container_title"><h2>제목</h2></div>
            <div class="container_title_text"><h2><input type="text" name="b_title"></h2></div>
            <div class="container_title_info"></div>
            <hr>
            </header>
            <!-- 제목 상단 부분 -->
            <section class="content">
                <div class="content_header_left">
                    <img src="images/people.jpg"> <!-- 사용자의 프로필 이미지 -->
                    <span><%=username %></span>
                </div>
                <div class="content_header_right">
                    <!-- <span>작성일 : 2019 / 05 / 29 12:10</span><br/> -->
                    <span><label>파일 :　
                    <input type="file" name="b_file"></label></span>
                </div>
                <hr class="content_hr">
                <!-- 게시글의 내용이 출력되는 부분 -->
                <div class="content_main_text">
                	<textarea class="content_main_text_editor" name="b_content"></textarea>
                </div>
                <!-- <div class="content_footer_button" id="suggest_button">
                    추천 
                </div> --> <!-- 해당 부분은 게시글 상세보기 화면에서만 작동해야 합니다. -->
            </section>
            <!-- 글쓰기 버튼 -->
            <div class="footer_board_write_button">
                	<input type="button" id="submitBoard" value="글쓰기">
            </div>
            </form>
        	</div>
    </body>
    <script>
    ClassicEditor
    .create( document.querySelector( '.content_main_text_editor' ) )
    .then( editor => {
            console.log( editor );
    } )
    .catch( error => {
            console.error( error );
    } );
    </script>
</html>