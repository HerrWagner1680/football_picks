// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

var hideCOF;

hideCOF = function(bool) {
  if (bool === true) {
    alert('hidden PC!');
  } else {
    alert('HIDE YOUR PICKS');
  }
};

// note - can not use highLight because old files not getting cleared
// had to create new function of hightLightt
var highLight;

highLight = function(obj){
  obj.parentNode.style.backgroundColor = "#A1EFB4";
      // line below highlights the rec
  //obj.parentNode.nextSibling.nextSibling.style.backgroundColor = "#A1EFB4"

  var radio_chart_id = obj.name
  var clicked_row = document.getElementsByName(radio_chart_id)

  var winner_column = obj.parentNode.parentNode.getElementsByClassName('win')[0]

    if (obj.value === "visit") {
    	document.getElementsByName(radio_chart_id)[1].parentNode.style.backgroundColor = ""
    	document.getElementsByName(radio_chart_id)[2].parentNode.style.backgroundColor = ""

		winner_column.style.backgroundColor = "blue";
		winner_column.style.color = "white";
		// Remove asterisk and last word from text
		var win_name = obj.parentNode.textContent
		var win_name = win_name.replace(/[\s][\*]/, "");
		var lastIndex = win_name.lastIndexOf(" ");
		var win_name = win_name.substring(0, lastIndex);
		winner_column.innerHTML = win_name;

    }
    else if (obj.value === "home"){
    	document.getElementsByName(radio_chart_id)[0].parentNode.style.backgroundColor = ""
    	document.getElementsByName(radio_chart_id)[2].parentNode.style.backgroundColor = ""

		winner_column.style.backgroundColor = "green";
		winner_column.style.color = "white";
		// Remove asterisk and last word from text
		var win_name = obj.parentNode.textContent
		var win_name = win_name.replace(/[\s][\*]/, "");
		var lastIndex = win_name.lastIndexOf(" ");
		var win_name = win_name.substring(0, lastIndex);
		winner_column.innerHTML = win_name;

    }
    else {
    	document.getElementsByName(radio_chart_id)[0].parentNode.style.backgroundColor = ""
    	document.getElementsByName(radio_chart_id)[1].parentNode.style.backgroundColor = ""
		winner_column.innerHTML = "--  none  --";
		winner_column.style.backgroundColor = "#444";
		winner_column.style.color = "white";
    }

};

$('#triggered').ready(function() {
    var latest = $('#latest_wk').html()
    $("#triggered").val(latest);
});

var selectTriggered

selectTriggered = function(){
  //$this = $(e.target);
  var selected = $('#triggered').val().toString()
  $('#triggered').blur();
  //console.log("hello, you triggered this message");
  //console.log(selected) //id number - wk number for chart

  var now = new Date();
  var time = now.getTime();
  var expireTime = time + 10000;
  now.setTime(expireTime);

  document.cookie = 'wk=' + selected + ';expires='+now.toGMTString()+';path=/';

  //console.log(document.cookie)
  //$('#latest_wk').load(location.href + ' #latest_wk'); //this works but nests
  $('#latest_wk').load(location.href + ' #latest_wk');
  //$('#latest_wk p').unwrap()
    setTimeout(function(){$('#latest_wk p').unwrap()}, 1000)

  $('#master_wk').load(location.href + ' #master_wk');
     setTimeout(function(){$('#master_wk h1').unwrap()}, 1000)

  //$('#latest_wk').html(selected);
  //$('.dynamic').load('/admin/cookie_rerun #grrr');
  //$('#latest_wk2').load(location.href + " #latest_wk2>*","");
  //console.log(document.cookie)
}
