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

// function of oldchartPicks is in application.js
// underlines and checkmarks picks from previous wk
$(document).ready(function(){
    oldchartPicks();
});

count = 0
function asdfasdf(f) { 
  var clr = $(".buttonGrey[pc="+f+"]").css('color');
  if (clr === 'rgb(51, 51, 51)'){
    $(".buttonGrey[pc="+f+"]").css('color','rgb(255, 0, 0)');
    $('.buttonGrey[pc='+f+']').html("UPDATE")
    $('.game_form[pc='+f+']').css('display', 'table-cell')
    $('.game_text[pc='+f+']').css('display', 'none')
  } else if (clr === 'rgb(255, 0, 0)') {
    $(".buttonGrey[pc="+f+"]").css('color', 'rgb(51, 51, 51)')
    $('.buttonGrey[pc='+f+']').html("&nbsp;&nbsp;&nbsp;&nbsp;edit&nbsp;&nbsp;&nbsp;&nbsp;")
    $('.game_form[pc='+f+']').css('display', 'none') 
    $('.game_text[pc='+f+']').css('display', 'table-cell')
    updateText(f); 
  } else {  alert("The Toggler is askew")}
  count = count + 1;
};

function updateText(f) {
    //console.log("YES YOU HIT UPDATE TEXT")
    //console.log("the pc number is " + f)
    //console.log($('.tr_row_' + f + ' .vt input').val())
    var _wk = $('.tr_row_' + f + ' .wk input').eq(0).val()
    var _vt = $('.tr_row_' + f + ' .vt input').eq(1).val()
    var _vr = $('.tr_row_' + f + ' .vr input').eq(0).val()
    var _ht = $('.tr_row_' + f + ' .ht input').eq(1).val()
    var _hr = $('.tr_row_' + f + ' .hr input').eq(0).val()
    var _gt = $('.tr_row_' + f + ' .gt input').eq(0).val()
    $('.tr_row_' + f + ' .wk').eq(0).text(_wk)
    $('.tr_row_' + f + ' .vt').eq(0).text(_vt)
    $('.tr_row_' + f + ' .vr').eq(0).text(_vr)
    $('.tr_row_' + f + ' .ht').eq(0).text(_ht)
    $('.tr_row_' + f + ' .hr').eq(0).text(_hr)
    $('.tr_row_' + f + ' .gt').eq(0).text(_gt)
};

var selectTriggered

selectTriggered = function(){
  //$this = $(e.target);

  console.log("hello, you triggered this message");
  console.log(  $('#triggered').val()) //id number - wk number for chart
  //console.log(  $('#triggered').html())


}

// $("select").change(function() {
//   alert( "Handler called." ).change();
// });

// $( "select" )
//   .change(function () {
//     var str = "";
//     $( "select option:selected" ).each(function() {
//       str += $( this ).text() + " ";
//     });
//     $( "div" ).text( str );
//   })
//   .change();

  // $('#countrylist').change(function(e){
  //     $this = $(e.target);
  //     $.ajax({
  //         type: "POST",
  //         url: "scriptname.asp", // Don't know asp/asp.net at all so you will have to do this bit
  //         data: { country: $this.val() },
  //         success:function(data){
  //             $('#stateBoxHook').html(data);
  //         }
  //     });
  // });
