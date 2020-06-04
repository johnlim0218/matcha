$(document).ready(function(){
    $(".topinput").on("keyup",function(){
        if($(".topinput").prop("value") != ""){
            $("#del").removeClass("spBtnh");
        }else{
            $("#del").addClass("spBtnh");
        }
    });

    $("#spBtn").on("click",function(){
        $(".topinput").val("");
        $("#del").addClass("spBtnh");
    });

});