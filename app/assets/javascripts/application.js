// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
// -> Fluidbox: https://github.com/terrymun/Fluidbox
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-datepicker/core
//= require jquery-fileupload
//= require chosen-jquery
//= require cocoon
//= require jquery.fluidbox.min.js
//= require underscore
//= require gmaps/google
//= require_tree .

$(document).ready(function(){
    $('.tooltip-bottom').tooltip({
        placement: 'bottom'
    });
    $('.tooltip-right').tooltip({
        placement: 'right'
    });
    $('.tooltip-left').tooltip({
        placement: 'left'
    });
    $('.popover-top').popover({
        placement: 'top',
        trigger: 'hover'
    });
    $('.popover-right').popover({
        placement: 'right',
        trigger: 'hover'
    });
    $('.popover-left').popover({
        placement: 'left',
        trigger: 'hover'
    });
    $('.popover-bottom').popover({
        placement: 'bottom',
        trigger: 'hover',
        delay: { show: 0, hide: 900 }
    });

    $('.chosen-select').chosen({
    	search_contains: true
    });
    $('#connect_profile_modal').on('shown.bs.modal', function () {
    	$('#person-connect-select').chosen({
    		no_results_text: "Oops, nothing found!",
    		width: "98%"
    	});
    });
    $('.input-append.date').datepicker({
        format: "dd.mm.yyyy",
        todayHighlight: true,
        forceParse: false
    });
    $('.img-fluid').fluidbox({
        viewportFill: 0.8
    });

    $("#spinner").bind("ajaxSend", function() {
        $(this).show();
    }).bind("ajaxStop", function() {
        $(this).hide();
    }).bind("ajaxError", function() {
        $(this).hide();
    });

});
