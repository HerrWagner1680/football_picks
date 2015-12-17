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
// app.config(['$resourceProvider', function($resourceProvider) {
//   // Don't strip trailing slashes from calculated URLs
//   $resourceProvider.defaults.stripTrailingSlashes = false;
// }])


.controller('FirstCtrl', function($scope, $log, $http, $resource, Restangular, Secure) {
    $scope.data = {id: "234", content: "Hello", asdf: "yesss"};
    //$scope.items = Restangular.restangularizeCollection(null, users, 'users');
    //$log.info($scope.items);
 
    $http({
    url: "http://localhost:3000/users",
    method: "GET",
    //params: {orderBy: id}
    }).success(function(data, headers, current_user, latest_text)
    {
        $log.info("sdfsdfsdfs");
        //$log.info(data);
        $log.info(headers);
        $log.info(latest_text);
        $log.info(current_user)
    })
    Restangular.one('users', '').get().then(function(users){
        //$scope.accounts = Restangular.all('accounts').getList().$object;
        $scope.users = users;
        //$log.info(users.headers)
        //  var userWithId = _.find(users, function(user) {
        //   return user.id === 1;
        //   $log.info("werwer");
        // });
        //$log.info($("td").filter('.zedpick')[0]);
        $log.info($scope.users);
    });
    


   // var baseUsers = Restangular.all('users').getList()
   // .then(function(response){ yoyo = response.data });
  //  $log.info(baseUsers);
    //$log.info("yoyo " + yoyo);

    // This will query /accounts and return a promise.
  //  baseUsers.getList().setListTypeIsArray(false).then(function(users) {
  //    $scope.allUsers.setListTypeIsArray(false) = user;
  //    $log.info("all users " + $scope.allUsers);
  //  });

  //  $scope.users = Restangular.all('users').getList().$object;
    // Restangular returns promises
 //   $log.info($scope.users);
    // Restangular.all('users').customGet()  // GET: /users
    // .then(function(users) {
    //   $log.info(user.customGet('user_name'));
    //   // returns a list of users
    //   $scope.user = user[0]; // first Restangular obj in list: { id: 123 }
    //   $scope.data.frog = user.customGet('user_name')
    // })

})






app.factory("Secure", function($resource, $http, $log, Restangular) {

  return Restangular.all('users')
  //return $http.get("http://localhost:3000/admin/charts").success(function(data){
  //$http.defaults.headers.post['My-Header']='value';
  var csrf_stuff = $(data).filter('meta');
  $log.info("csrf-token: " + csrf_stuff[1].content); //this displays csrf-token in meta tag
  $log.info(Restangular.all('users'));
  //var inout = $(data).filter('.loginout');
  //$log.info(inout.html());
  });




// angular.module('cookiesExample', ['ngCookies'])
// .controller('ExampleController', ['$cookies', function($cookies) {
//   // Retrieving a cookie
//   var favoriteCookie = $cookies.get('_fantasy_sports_session');
//   // Setting a cookie
//   $log.info(favoriteCookie);
//   //$cookies.put('myFavorite', 'oatmeal');
// }]);



// setup controller and pass data source
// app.controller("TypeaheadCtrl", function($scope, States) {
  
//   $scope.selected = undefined;
  
//   $scope.states = States;
  
// });

// $http.get('/res').success(function(data){
//   $scope.test = data;
// });


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

  for (var i=0; i < old_ch_num; i++){
    var current_pick = $(".hidden")[i].innerHTML

    if (current_pick === "visit") {
      $(".v_checkbox")[i].innerHTML = "&#10003";
      $(".h_checkbox")[i].innerHTML = "...";
      $(".v_pick")[i].style.textDecoration = "underline";
      $(".v_checkbox")[i].style.color = "#222";
      $(".v_pick")[i].style.color = "#222";
      // REM adding the underline
    } else if (current_pick === "home") {
      $(".v_checkbox")[i].innerHTML = "...";
      $(".h_checkbox")[i].innerHTML = "&#10003";
      $(".h_pick")[i].style.textDecoration = "underline";
      $(".h_checkbox")[i].style.color = "#222";
      $(".h_pick")[i].style.color = "#222";
    } else {
      $(".v_checkbox")[i].innerHTML = "...";
      $(".h_checkbox")[i].innerHTML = "...";
    }

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
