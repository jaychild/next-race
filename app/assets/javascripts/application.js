// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


$(document).ready(function(){

    var starts_at = $('#start_time').val = new Date();

    var count_down = function(time){
        // var d = new Date();
        // var now = d.toLocaleTimeString();
        //
        // var diff = Math.abs(time - now);
        //
        // console.log(diff);
        // var time_until_start = (now);
        // $('#count_down').html(time_until_start);
    }

    // var time_interval = (1000 * 1);
    // setInterval(count_down(starts_at), time_interval);



    var poll_next_race = function() {
        $('.spinner').show();
        $('.runners').css("opacity", "0.2");

        setTimeout(function(){
            $.ajax(
                {
                    url: "/next_race",
                    method: 'GET',
                    dataType: 'script',
                    success: function(){
                        $('.spinner').hide();
                        $('.runners').css("opacity", "1")
                    },
                    error: function(){
                        $('.spinner').hide();
                        $('.runners').css("opacity", "1")
                    }
                }
            );
        }, 2000);


    };

    var interval = (1000 * 30) ;
    setInterval(poll_next_race, interval); // send ajax every 1 minute

});