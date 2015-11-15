// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require admin
//= require_tree .

var hidePC;
var hideSwitch;
var pc_style;
var pick_style;

hideSwitch = function(pc_style, pick_style, bool) {
	var pick_h_length = document.getElementsByClassName("pick_hide").length
	var pc_h_length = document.getElementsByClassName("pc_hide").length

	for (var i = 0; i < pc_h_length; i++){
 	 	document.getElementsByClassName("pc_hide")[i].style.display = pc_style
	}
	for (var i = 0; i < pick_h_length; i++){
		document.getElementsByClassName("pick_hide")[i].style.display = pick_style
	}

  var radio_num = document.getElementsByClassName("vis").length
  //var radio_num = radio_num * 2

  for (var i = 0; i < radio_num*2; i++){
    document.getElementsByTagName("input")[i].disabled = bool
  };
};

hidePC = function(bool) {
  if (bool === true) {
    var pc_style = 'none';
    var pick_style = 'block';
    var bool = false;

    hideSwitch(pc_style, pick_style, bool);

  } else {
    var pc_style = 'block';
    var pick_style = 'none';
    var bool = true

    hideSwitch(pc_style, pick_style, bool);
  }
};


var highLight;

highLight = function(obj){
  obj.parentNode.style.backgroundColor = "#A1EFB4";
      // line below highlights the rec
  //obj.parentNode.nextSibling.nextSibling.style.backgroundColor = "#A1EFB4"

  var radio_chart_id = obj.name

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