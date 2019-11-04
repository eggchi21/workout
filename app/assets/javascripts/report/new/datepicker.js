$(function() {
  if(document.URL.match(/\/users\/\d\/reports\/new/)) {
    $("#datepicker").datepicker();
  }
  if(document.URL.match(/\/plans\/new/)) {
    $("#start_on_datepicker").datepicker();
    $("#target_on_datepicker").datepicker();
  }
});