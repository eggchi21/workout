$(function() {
  if(document.URL.match(/\/users\/\d\/reports\/new/)) {
    $("#datepicker").datepicker();
  }
  if(document.URL.match(/\/plans\/new/) || document.URL.match(/\/plans\/\d+\/edit/)) {
    $("#start_on_datepicker").datepicker();
    $("#target_on_datepicker").datepicker();
  }
});