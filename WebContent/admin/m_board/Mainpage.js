// 검색 버튼
function search() {
    var option = $("select[name='category']").val();
  
	var sText = $("#se").val();
    
    $.ajax({
        type:"POST",
        url:"./MainpageP.jsp",
        data: {title : sText, op : option},
        dateType : "text",
        success: function(text){
        	$(".content").empty();
        	$(".content").append(text);
        },
        error: function(xhr,status,error){
            alert("에러");
        }
    });
};



    

// 수정버튼 이벤트 : 수정페이지 팝업 띄우기
function noticepopup(bidx){
	var pUri = "b_viewtest.jsp?b_idx="+bidx;
	var poption = "width=900, height=650,";
	window.open(pUri,"게시판수정",poption);
}

// 삭제버튼 이벤트 : 삭제여부 확인/취소
function noticedelete(bidx){
	
	if(confirm("정말 이글을 삭제하시겠습니까?") == true){
		$.ajax({
	        type:"POST",
	        url:"./noticedel.jsp",
	        data: {b_idx : bidx},
	        dateType : "text",
	        success: function(){
	        	alert("삭제 되었습니다.");
	        	location.reload();
	        },
	        error: function(xhr,status,error){
	            alert("삭제실패");
	        }
	    });
	}else{
		return;
	}
}




// 페이징이벤트

function pagingS(clickpage,option,search){
    $.ajax({
        type:"POST",
        url:"./MainpageTDP.jsp",
        data: {clickpage : clickpage, option : option, search : search},
        dateType : "text",
        success: function(text){
        	$(".content").empty();
        	$(".content").append(text);
        },
        error: function(xhr,status,error){
            alert("에러");
        }
    });
	
}






