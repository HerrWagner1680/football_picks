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

//AVOID Generalized jQuery! Adjustments must be cell specific.
var highlightPicks;

highlightPicks = function(obj){
  obj.parentNode.style.backgroundColor = "#A1EFB4";
  //$('.vis').css("background-color","#A1EFB4");
  //console.log("sfsdfsdfsdf" + $(this).next('input'));
  //var radButton = $(this).find('input[type=radio]');
  //var radButton = $(obj).find('input[type=radio]');
  //$(radButton).prop("checked", true);
  var radio_chart_id = obj.name
  var clicked_row = document.getElementsByName(radio_chart_id)
  //console.log("obj " + obj.name);
  //var winner_column = obj.parentNode.parentNode.getElementsByClassName('win')[0]

    if (obj.value === "visit") {
      //$('.vis').css("background-color","#A1EFB4");
      //$('.home').css("background-color","");
      document.getElementsByName(radio_chart_id)[1].parentNode.style.backgroundColor = ""
      //document.getElementsByName(radio_chart_id)[2].parentNode.style.backgroundColor = ""

    }
    else if (obj.value === "home"){
      document.getElementsByName(radio_chart_id)[0].parentNode.style.backgroundColor = ""

    }
    else {

      console.log("highlightPicks error");

    }   
}



// note - can not use highLight because old files not getting cleared
// had to create new function of hightLightt
var highLight;

//AVOID Generalized jQuery! Adjustments must be cell specific.

highLight = function(obj){
  //obj.parentNode.style.backgroundColor = "#A1EFB4";
  obj.style.backgroundColor = "#A1EFB4";  
      // line below highlights the rec
  //obj.parentNode.nextSibling.nextSibling.style.backgroundColor = "#A1EFB4"
  //var radButton = $(this).find('input[type=radio]');
  //var radButton = $(obj).find('input[type=radio]');
  //$(radButton).prop("checked", true);

  var radio_chart_id = obj.name
  var clicked_row = document.getElementsByName(radio_chart_id)

  var winner_column = obj.parentNode.parentNode.getElementsByClassName('win')[0]

    if (obj.value === "visit") {
    	document.getElementsByName(radio_chart_id)[1].parentNode.style.backgroundColor = ""
    	document.getElementsByName(radio_chart_id)[2].parentNode.style.backgroundColor = ""

      //$('.win').css("background-color", "blue");
      //$('.win').css("color", "white")
      winner_column.style.backgroundColor = "blue";
  		winner_column.style.color = "white";

      console.log("parentnoe " + obj.parentNode.textContent);

  		// Remove asterisk and last word from text
  		var win_name = obj.parentNode.textContent
  		//////var win_name = win_name.replace(/[\s][\*]/, "");
      /// REGEX - you want to remove final word if team name is too long
  		var lastIndex = win_name.lastIndexOf(" ");
  		//////var win_name = win_name.substring(0, lastIndex);
  		winner_column.innerHTML = win_name;
      ///$('.win').text(win_name);

    }
    else if (obj.value === "home"){
    	document.getElementsByName(radio_chart_id)[0].parentNode.style.backgroundColor = ""
    	document.getElementsByName(radio_chart_id)[2].parentNode.style.backgroundColor = ""

  		winner_column.style.backgroundColor = "green";
  		winner_column.style.color = "white";
      //$('.win').css("background-color", "green");
      //$('.win').css("color", "white")

  		// Remove asterisk and last word from text
  		var win_name = obj.parentNode.textContent
  		//var win_name = win_name.replace(/[\s][\*]/, "");
  		var lastIndex = win_name.lastIndexOf(" ");
  		//var win_name = win_name.substring(0, lastIndex);
  		winner_column.innerHTML = win_name;
      //$('.win').text(win_name);

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

// $('#submitted_picks').ready(function() {
//     oldchartPicks();
// });

var selectTriggered

selectTriggered = function(){
  //$this = $(e.target);

  $('#shaded_background').hide()
  var selected = $('#triggered').val().toString()
  $('#triggered').blur();

  var now = new Date();
  var time = now.getTime();
  var expireTime = time + 12000; // was 10000
  now.setTime(expireTime);

  document.cookie = 'wk=' + selected + ';expires='+now.toGMTString()+';path=/';


  $('#latest_wk').load(location.href + ' #latest_wk');
    $('#latest_wk').promise().done(function(){ setTimeout(function(){$('#latest_wk p').unwrap()}, 1500) })
                             .fail(function(){ console.log("#latest_wk FAIL")});

  $('#master_wk').load(location.href + ' #master_wk');
    $('#master_wk').promise().done(function(){ setTimeout(function(){$('#master_wk p').unwrap()}, 1500) })
                             .fail(function(){ console.log("#master_wk FAIL")});
    $('#master_wk').fadeTo("slow", 0)
    //$('#master_wk').hide();

  $('#shaded_background').fadeTo("fast", 1)

   //$('#horiz_overflow div').fadeTo("fast", 0)
  $('#horiz_overflow').load(location.href + ' #horiz_overflow')
  //console.log("LINE 105: " + $('#horiz_overflow').css('height'));
    $('#horiz_overflow').promise().done(function(){ setTimeout(function(){ $('#horiz_overflow div').unwrap()}, 3000); $('#loading_gif').fadeTo("fast", 1);})
                                  .fail(function(){ console.log("#horiz_overflow FAIL")});
   // $('#horiz_overflow').fadeTo("slow", 0).then(function(){
    //       alert("HELLO!");
    //       $('#horiz_overflow').css('background-color', '#eee')
    //       $('#horiz_overflow').css('border', '3px solid #eee')
    //       $('#horiz_overflow').html('<a class="loading gray_link">Taking too long? <u onclick="selectTriggered()">Click here to reload.</u></a>')         
    //       $('#horiz_overflow').fadeTo("fast", 1)
    // });
   //NOTE -- time of 1000 shows the previous height. 2000 shows new height. 

  // $('#horiz_overflow').css('background-color', '#eee')
  // $('#horiz_overflow').css('border', '3px solid #eee')
  // $('#horiz_overflow').html('<a class="loading gray_link">Taking too long? <u onclick="selectTriggered()">Click here to reload.</u></a>')
  setTimeout(function(){ $('#shaded_background').fadeTo("fast", 0);  }, 3300);
 
  setTimeout(function(){ $('#shaded_background').hide();  }, 3700);

  $('#submitted_picks').load(location.href + ' #submitted_picks')
     $('#submitted_picks').promise().done(function(){ setTimeout(function(){ $('#submitted_picks section').unwrap();  oldchartPicks();}, 1500)})
                          .fail(function(){ console.log("#submitted_picks FAIL")});
     $('#submitted_picks').fadeTo("slow", 0)


          $('#horiz_overflow').css('background-color', '#eee')
          $('#horiz_overflow').css('border', '3px solid #eee')
          $('#horiz_overflow').html('<a class="loading gray_link">Taking too long? <u onclick="selectTriggered()">Click here to reload.</u></a>')         
          $('#horiz_overflow').fadeTo("fast", 1)

     // jQuery error handling with promises
     // http://stackoverflow.com/questions/23744612/problems-inherent-to-jquery-deferred-jquery-1-x-2-x
  
     //USE CATCH TO DESCRIBE WHAT TO DO IF ERROR



}

//STANDINGS PAGE - SCROLL IN UNISON
$('.vertical').ready(function(){
  $('.vertical').scroll(function(){
    $('.vertical').scrollTop($(this).scrollTop());
  });
})

var csv_experiment

csv_experiment = function(){

    var total_entries = $('.index_pick').length
    var num_rows = $('tr').length
    var num_cols = total_entries / num_rows;

    var whole_tamale = []

    for (i = 0; i < num_rows; i++) {

        var aaa = []

        for (col = num_cols * i; col < num_cols * (i+1); col++) {
            var qqq = $('.index_pick').eq(col).html();
            aaa.push(qqq);
        };

        whole_tamale.push(aaa);
    };

    console.log(whole_tamale);

    //create array of arrays
    //[[“sdf”,”sdf”],[“sdf”,”wer”],[“234”,”234”]]

};

//document.cookie = "pass = no" // cookie 'edit password' default
