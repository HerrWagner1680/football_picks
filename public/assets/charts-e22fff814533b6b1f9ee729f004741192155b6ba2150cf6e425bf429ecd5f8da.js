function asdfasdf(e){var t=$(".buttonGrey[pc="+e+"]").css("color");"rgb(51, 51, 51)"===t?($(".buttonGrey[pc="+e+"]").css("color","rgb(255, 0, 0)"),$(".buttonGrey[pc="+e+"]").html("UPDATE"),$(".game_form[pc="+e+"]").css("display","table-cell"),$(".game_text[pc="+e+"]").css("display","none")):"rgb(255, 0, 0)"===t?($(".buttonGrey[pc="+e+"]").css("color","rgb(51, 51, 51)"),$(".buttonGrey[pc="+e+"]").html("&nbsp;&nbsp;&nbsp;&nbsp;edit&nbsp;&nbsp;&nbsp;&nbsp;"),$(".game_form[pc="+e+"]").css("display","none"),$(".game_text[pc="+e+"]").css("display","table-cell"),updateText(e)):alert("The Toggler is askew"),count+=1}function updateText(e){var t=$(".tr_row_"+e+" .wk input").eq(0).val(),o=$(".tr_row_"+e+" .vt input").eq(1).val(),r=$(".tr_row_"+e+" .vr input").eq(0).val(),c=$(".tr_row_"+e+" .ht input").eq(1).val(),n=$(".tr_row_"+e+" .hr input").eq(0).val(),s=$(".tr_row_"+e+" .gt input").eq(0).val();$(".tr_row_"+e+" .wk").eq(0).text(t),$(".tr_row_"+e+" .vt").eq(0).text(o),$(".tr_row_"+e+" .vr").eq(0).text(r),$(".tr_row_"+e+" .ht").eq(0).text(c),$(".tr_row_"+e+" .hr").eq(0).text(n),$(".tr_row_"+e+" .gt").eq(0).text(s)}var hidePC,hideSwitch,pc_style,pick_style;hideSwitch=function(e,t){for(var o=document.getElementsByClassName("pick_hide").length,r=document.getElementsByClassName("pc_hide").length,c=0;r>c;c++)document.getElementsByClassName("pc_hide")[c].style.display=e;for(var c=0;o>c;c++)console.log("pick_h"+c),document.getElementsByClassName("pick_hide")[c].style.display=t},hidePC=function(e){if(e===!0){var t="none",o="block";hideSwitch(t,o)}else{var t="block",o="none";hideSwitch(t,o)}},$(document).ready(function(){oldchartPicks()}),count=0;var selectTriggered;selectTriggered=function(){var e=$("#triggered").val().toString();$("#triggered").blur(),console.log("hello, you triggered this message"),console.log(e),document.cookie="wk="+e+";",console.log(document.cookie)};