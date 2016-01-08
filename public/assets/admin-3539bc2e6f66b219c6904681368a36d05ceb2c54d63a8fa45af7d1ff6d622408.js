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


var highLight;

highLight = function(obj){
  obj.parentNode.style.backgroundColor = "#A1EFB4";
      // line below highlights the rec
  //obj.parentNode.nextSibling.nextSibling.style.backgroundColor = "#A1EFB4"

  var radio_chart_id = obj.name

  var winner_column = obj.parentNode.parentNode.getElementsByClassName('win')[0]
  //console.log("radio id line 219: " + radio_chart_id)
  //console.log(obj.value) //either home or visit
  //console.log(obj.parentNode.textContent)
    if (obj.value === "visit") {
    	console.log("VIZZZZZZZ")
      winner_column.style.backgroundColor = "blue";
      winner_column.style.color = "white";
      var win_name = obj.parentNode.textContent
      win_name.replace(/[\s][\*]/, "");
      console.log("asdfasdf" + win_name)
  	  var lastIndex = win_name.lastIndexOf(" ");
  	  win_name.substring(0, lastIndex);
      winner_column.innerHTML = win_name;
      console.log(win_name)
    }
    else if (obj.value === "home"){
      winner_column.style.backgroundColor = "green";
      winner_column.style.color = "white";
      var win_name = obj.parentNode.textContent
      var win_name = win_name.replace(/[\s][\*]/, "");
  	  var lastIndex = win_name.lastIndexOf(" ");
  	  var win_name = win_name.substring(0, lastIndex);
      winner_column.innerHTML = win_name;
      console.log(win_name)
    }
    else {
      winner_column.innerHTML = "NULL"
    }
 

  //document.getElementsByName(radio_chart_id)[0].parentNode.nextSibling.nextSibling.style.backgroundColor = "#A1EFB4"

  if (document.getElementsByName(radio_chart_id)[0].checked == true) {
    document.getElementsByName(radio_chart_id)[1].parentNode.style.backgroundColor = ""
    // line below highlights the rec
    //document.getElementsByName(radio_chart_id)[1].parentNode.nextSibling.nextSibling.style.backgroundColor = ""
  } else {
    document.getElementsByName(radio_chart_id)[0].parentNode.style.backgroundColor = ""
    // line below highlights the rec
    //document.getElementsByName(radio_chart_id)[0].parentNode.nextSibling.nextSibling.style.backgroundColor = ""
  }

}
