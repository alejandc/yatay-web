// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function(){
  //Display filter if have parameter settings 
  if ($('#certificate_titular').val() != "" || $('#certificate_taxi_license_number').val() != "" || $('#certificate_clock_number').val() != "") {
    $('#collapse_certificate_filter').addClass("in").css('height', 'auto;');
  }
});