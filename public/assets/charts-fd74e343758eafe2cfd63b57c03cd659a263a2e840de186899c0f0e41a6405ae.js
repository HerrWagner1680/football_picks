function asdfasdf(e){var s=$(".buttonGrey[pc="+e+"]").css("color");"rgb(51, 51, 51)"===s?($(".buttonGrey[pc="+e+"]").css("color","rgb(255, 0, 0)"),$(".buttonGrey[pc="+e+"]").html("UPDATE"),$(".game_form[pc="+e+"]").css("display","table-cell"),$(".game_text[pc="+e+"]").css("display","none")):"rgb(255, 0, 0)"===s?($(".buttonGrey[pc="+e+"]").css("color","rgb(51, 51, 51)"),$(".buttonGrey[pc="+e+"]").html("&nbsp;&nbsp;&nbsp;&nbsp;edit&nbsp;&nbsp;&nbsp;&nbsp;"),$(".game_form[pc="+e+"]").css("display","none"),$(".game_text[pc="+e+"]").css("display","table-cell")):alert("The Toggler is askew"),count+=1}var hidePC,hideSwitch,pc_style,pick_style;hideSwitch=function(e,s){for(var t=document.getElementsByClassName("pick_hide").length,c=document.getElementsByClassName("pc_hide").length,n=0;c>n;n++)document.getElementsByClassName("pc_hide")[n].style.display=e;for(var n=0;t>n;n++)console.log("pick_h"+n),document.getElementsByClassName("pick_hide")[n].style.display=s},hidePC=function(e){if(e===!0){var s="none",t="block";hideSwitch(s,t)}else{var s="block",t="none";hideSwitch(s,t)}},$(document).ready(function(){oldchartPicks()}),count=0;