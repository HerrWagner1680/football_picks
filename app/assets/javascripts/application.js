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

  if (!$('.oc_winner')[0]) { return false } //if no oc_winner stop function

  for (var i=0; i < old_ch_num; i++){
    var current_pick = $(".hidden")[i].innerHTML
    // comment out oc_winner when user not admin
    var the_win = $('.oc_winner')[i].innerHTML
    //console.log("oldmanchart - i:" + i);

    if (current_pick === the_win){
      total_wins = total_wins + 1;
    }

    if ($(".v_checkbox").length){

    if (current_pick === "visitor" && the_win === "visitor") {
      $(".v_checkbox").eq(i).html("&#10003");
      $(".h_checkbox").eq(i).html("...");
      $(".v_pick").eq(i).css('text-decoration', 'underline');
      $(".v_checkbox")[i].style.color = "#006633"; //green
      $(".v_pick")[i].style.color = "#006633"; //green
          // comment out oc_winner when usser not admin
      //$(".oc_winner").eq(i).html("visitor");
    
      $(".h_checkbox").eq(i).parent().css("background-color", "#b2d8b2");

  
    } else if (current_pick === "visitor" && the_win === "home") {
      $(".v_checkbox").eq(i).html("&#10003");
      $(".h_checkbox").eq(i).html("...");
      $(".v_pick").eq(i).css('text-decoration', 'underline');
      $(".v_checkbox")[i].style.color = "red"; //red
      $(".v_pick")[i].style.color = "red"; //red

      $(".h_checkbox").eq(i).parent().css("background-color", "#ffcccc");

     } else if (current_pick === "visitor" && the_win === "") {
        $(".v_checkbox").eq(i).html("&#10003");
        $(".h_checkbox").eq(i).html("...");
        $(".v_pick").eq(i).css('text-decoration', 'underline');

        $(".v_checkbox")[i].style.color = "#222";
        $(".v_pick")[i].style.color = "#222";
        // REM adding the underline


    } else if (current_pick === "home" && the_win === "visitor") {
      //$(".oc_winner")[i].innerHTML = "sdfsdf";
      $(".v_checkbox").eq(i).html("...");
      $(".h_checkbox").eq(i).html("&#10003");
      $(".h_pick").eq(i).css('text-decoration', 'underline');
      $(".h_checkbox")[i].style.color = "red"; //red
      $(".h_pick")[i].style.color = "red"; //red
          // comment out oc_winner when usser not admin
      //$(".oc_winner").eq(i).html("visitor");
   
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
      $(".h_checkbox").eq(i).parent().css("color", "#ff6666");
    }

  } 
    //console.log("current pick "+ current_pick);
    //console.log("the win " + the_win);

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

// code below from http://stackoverflow.com/questions/1517924/javascript-mapping-touch-events-to-mouse-events


/*function init() {
    document.getElementById('horiz_overflow_standing').addEventListener("touchstart", touchHandler, true);
    document.getElementById('horiz_overflow_standing').addEventListener("touchmove", touchHandler, true);
    document.getElementById('horiz_overflow_standing').addEventListener("touchend", touchHandler, true);
    document.getElementById('horiz_overflow_standing').addEventListener("touchcancel", touchHandler, true);
} */

//STANDINGS PAGE LOADED
$('#testing_stuff').ready(function(){
    if ($('#horiz_overflow_standing').length) {
          document.addEventListener("mousemove", function(){
              event.preventDefault() ;
              //showCoords();
              //if ($('#horiz_overflow_standing').length) {
              document.getElementById('testing_stuff').innerHTML = "touchmove";
              //}
          });

          document.addEventListener("touchmove", function(e){
              event.preventDefault() ;
              //showCoords();
              //if ($('#horiz_overflow_standing').length) {
              var xxx = e.pageX - offset.left
              var yyy = e.pageY - offset.top
              document.getElementById('testing_stuff').innerHTML = "move move move " + "X POS: " + xxx + "Y POS: " + yyy;
              //}
          });

          document.addEventListener("click", function(){
              event.preventDefault() ;
              //showCoords();
              //if ($('#horiz_overflow_standing').length) {
              document.getElementById('testing_stuff').innerHTML = "sdhjksdfkhjsfkhjdfskjh";
              //}
          }); 

          document.addEventListener("touchend", function(){
              event.preventDefault() ;
              //showCoords();
              //if ($('#horiz_overflow_standing').length) {
              document.getElementById('testing_stuff').innerHTML = "sdhjksdtouchendfskjh";
              //}
          }); 
    };
});

// document.getElementById('horiz_overflow_standing').addEventListener("click", function(){ event.preventDefault(); console.log("clicky on horiz"); }); 

