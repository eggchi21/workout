$(function() {
  if(document.URL.match(/\/users\/\d\/reports\/new/)||document.URL.match(/\/diaries\/new/)) {
    $("#datepicker").datepicker();
  }
  if(document.URL.match(/\/plans\/new/) || document.URL.match(/\/plans\/\d+\/edit/) ||document.URL.match(/\/diaries$/)) {
    $("#start_on_datepicker").datepicker();
    $("#target_on_datepicker").datepicker();
  }
});