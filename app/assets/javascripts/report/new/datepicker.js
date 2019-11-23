$(function() {
  if(document.URL.match(/\/users\/\d\/reports\/new/)||document.URL.match(/\/diaries\/new/) || document.URL.match(/\/diaries\/\d+\/edit/) ||document.URL.match(/\/diaries$/)|| document.URL.match(/\/diaries\/\d+$/)) {
    $("#datepicker").datepicker();
  }
  if(document.URL.match(/\/plans\/new/) || document.URL.match(/\/plans\/\d+\/edit/) ) {
    $("#start_on_datepicker").datepicker();
    $("#target_on_datepicker").datepicker();
  }
});