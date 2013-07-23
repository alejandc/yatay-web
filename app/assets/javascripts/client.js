// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function(){
  //Display filter if have parameter settings 
  if ($('#client_name').val() != "" || $('#client_document_number').val() != "" || $('#client_certificates_attributes_0_taxi_license_number').val() != "") {
    $('#collapse_client_filter').addClass("in").css('height', 'auto;');
  }
});