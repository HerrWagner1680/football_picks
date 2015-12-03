// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

// receta = angular.module('receta',['ngResource'
// ]) // injecting ngResource into module

// function FirstCtrl($scope) {
//     $scope.data = {id: "234", content: "Hello"};
// };

// // var Hello;
// function Hello($scope, $http) {
//     $http.get('http://fantasy-sports.dev/admin/chart/2').
//         success(function(data) {
//             $scope.greeting = data;
//             console.log(data);
//         });
// }

// function Hello() {
//   this.id = "1";
//   this.content = "hoo he ha ha";
//   this.greeting.id = "234"
// }


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

// function of oldchartPicks is in application.js
// underlines and checkmarks picks from previous wk
$(document).ready(function(){
    oldchartPicks();
});

count = 0
function asdfasdf(f) { 
  var clr = $(".buttonGrey[pc="+f+"]").css('color');
  if (count%2 === 0){
    $(".buttonGrey[pc="+f+"]").css('color','red');
    $('.buttonGrey[pc='+f+']').html("UPDATE")
    $('.game_form[pc='+f+']').css('display', 'table-cell')
    $('.game_text[pc='+f+']').css('display', 'none')
  } else if (count%2 === 1) {
    $(".buttonGrey[pc="+f+"]").css('color', 'black')
    $('.buttonGrey[pc='+f+']').html("&nbsp;&nbsp;&nbsp;&nbsp;edit&nbsp;&nbsp;&nbsp;&nbsp;")
    $('.game_form[pc='+f+']').css('display', 'none') 
    $('.game_text[pc='+f+']').css('display', 'table-cell') 
  } else {  alert("nope")}
  count = count + 1;
};
