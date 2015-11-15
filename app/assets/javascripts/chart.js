// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/


var hidePC;
var hideSwitch;
var pc_style;
var pick_style;

hideSwitch = function(pc_style, pick_style) {
	var pick_h_length = document.getElementsByClassName("pick_hide").length
	var pc_h_length = document.getElementsByClassName("pc_hide").length

	for (var i = 0; i < pc_h_length; i++){
 	 	document.getElementsByClassName("pc_hide")[i].style.display = pc_style
	}
	for (var i = 0; i < pick_h_length; i++){
		console.log('pick_h' + i);
		document.getElementsByClassName("pick_hide")[i].style.display = pick_style
	}
};

hidePC = function(bool) {
  if (bool === true) {
    var pc_style = 'none';
    var pick_style = 'block';

    hideSwitch(pc_style, pick_style);

  } else {
    var pc_style = 'block';
    var pick_style = 'none';

    hideSwitch(pc_style, pick_style);
  }
};

//document.getElementsByTagName("input")[5].parentNode.style.backgroundColor = "#A1EFB4"