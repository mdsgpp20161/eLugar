$(document).ready(function() {
var count = 0;

    $("#show_filter_form").click(function(){
        $("#filter_form").toggle("slow");
        if(count == 0){
            $("#show_filter_form").text("-");
            count = 1;
        }else{
            $("#show_filter_form").text("+");
            count = 0;
        }
    });
});
