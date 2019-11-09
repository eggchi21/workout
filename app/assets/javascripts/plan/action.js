$(function(){
  $('.plan-card--action__good').hover(function() {
    $(this).toggleClass('plan-card--action__good_hover');
    return false;
  });
  $('.plan-card--action__edit').hover(function() {
    $(this).toggleClass('plan-card--action__edit_hover');
    return false;
  });
  $('.plan-card--action__delete').hover(function() {
    $(this).toggleClass('plan-card--action__delete_hover');
    return false;
  });
})