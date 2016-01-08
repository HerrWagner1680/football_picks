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
//= require angular
//= require angular-resource
//= require angular-route
//= require lodash

// REMOVED TURBOLINKS
//= require admin
//= require_tree .

var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

app = angular.module('app',['ngResource', 'ngRoute', 'restangular'
]) // injecting ngResource into module

.config(['$httpProvider', function ($httpProvider) {
    $httpProvider.defaults.headers.common[header] = token;
}])


.controller('FirstCtrl', function($scope, $log, $http, $resource, Restangular, Secure) {
    $scope.data = {id: "234", content: "Hello", asdf: "yesss"};


})




app.factory("Secure", function($resource, $http, $log, Restangular) {

  return Restangular.all('users')
  //return $http.get("http://localhost:3000/admin/charts").success(function(data){
  //$http.defaults.headers.post['My-Header']='value';
  var csrf_stuff = $(data).filter('meta');

  });




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

  var radio_num = document.querySelectorAll('input[type=radio]').length
  //var radio_num = radio_num * 2

  for (var i = 0; i < radio_num; i++){
    document.querySelectorAll('input[type=radio]')[i].disabled = bool
  };
};

var oldchartPicks;
oldchartPicks = function(){
  var old_ch_num = $(".hidden").length
  total_wins = 0

  for (var i=0; i < old_ch_num; i++){
    var current_pick = $(".hidden")[i].innerHTML
    // comment out oc_winner when usser not admin
    var the_win = $('.oc_winner')[i].innerHTML

    if (current_pick === the_win){
      total_wins = total_wins + 1;
    }

    if ($(".v_checkbox").length){


    if (current_pick === "visit" && the_win === "visit") {
      $(".v_checkbox").eq(i).html("&#10003");
      $(".h_checkbox").eq(i).html("...");
      $(".v_pick").eq(i).css('text-decoration', 'underline');
      $(".v_checkbox")[i].style.color = "#006633"; //green
      $(".v_pick")[i].style.color = "#006633"; //green
          // comment out oc_winner when usser not admin
      $(".oc_winner").eq(i).html("visitor");
    
      $(".h_checkbox").eq(i).parent().css("background-color", "#b2d8b2");

  
    } else if (current_pick === "visit" && the_win === "home") {
      $(".v_checkbox").eq(i).html("&#10003");
      $(".h_checkbox").eq(i).html("...");
      $(".v_pick").eq(i).css('text-decoration', 'underline');
      $(".v_checkbox")[i].style.color = "red"; //red
      $(".v_pick")[i].style.color = "red"; //red

      $(".h_checkbox").eq(i).parent().css("background-color", "#ffcccc");

     } else if (current_pick === "visit" && the_win === "") {
        $(".v_checkbox").eq(i).html("&#10003");
        $(".h_checkbox").eq(i).html("...");
        $(".v_pick").eq(i).css('text-decoration', 'underline');

        $(".v_checkbox")[i].style.color = "#222";
        $(".v_pick")[i].style.color = "#222";
        // REM adding the underline


    } else if (current_pick === "home" && the_win === "visit") {
      //$(".oc_winner")[i].innerHTML = "sdfsdf";
      $(".v_checkbox").eq(i).html("...");
      $(".h_checkbox").eq(i).html("&#10003");
      $(".h_pick").eq(i).css('text-decoration', 'underline');
      $(".h_checkbox")[i].style.color = "red"; //red
      $(".h_pick")[i].style.color = "red"; //red
          // comment out oc_winner when usser not admin
      $(".oc_winner").eq(i).html("visitor");
   
      $(".h_checkbox").eq(i).parent().css("background-color", "#ffcccc");

    } else if (current_pick === "home" && the_win === "home") {
      $(".v_checkbox").eq(i).html("...");
      $(".h_checkbox").eq(i).html("&#10003");
      $(".h_pick").eq(i).css('text-decoration', 'underline');
      $(".h_checkbox")[i].style.color = "#006633"; //green
      $(".h_pick")[i].style.color = "#006633"; //green
      
      $(".h_checkbox").eq(i).parent().css("background-color", "#b2d8b2");

    } else if (current_pick === "home" && the_win === "") {
      $(".v_checkbox").eq(i).html("...");
      $(".h_checkbox").eq(i).html("&#10003");
      $(".h_pick").eq(i).css('text-decoration', 'underline');

      $(".h_checkbox")[i].style.color = "#222";
      $(".h_pick")[i].style.color = "#222";

    } else {
      $(".v_checkbox").eq(i).innerHTML = "...";
      $(".h_checkbox").eq(i).innerHTML = "...";
    }

  } // end of if v_checkbox exists

  }

  if ($('.oc_winner').length) {
    total_loss = old_ch_num - total_wins;
    $('#wins').html("total wins: " + total_wins);
    $('#loss').html("total NOT wins: " + total_loss);
  }

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

  var winner_column = obj.parentNode.parentNode.getElementsByClassName('win')[0]
  //console.log("radio id line 219: " + radio_chart_id)
  console.log(obj.value) //either home or visit
  console.log(obj.parentNode.textContent)
    if (obj.value === "visit") {
      winner_column.style.backgroundColor = "blue";
      winner_column.style.color = "white";
      winner_column.innerHTML = obj.parentNode.textContent
    }
    else if (obj.value === "home"){
      winner_column.style.backgroundColor = "green";
      winner_column.style.color = "white";
      winner_column.innerHTML = obj.parentNode.textContent
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
