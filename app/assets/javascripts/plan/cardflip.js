$(function() {
  var tofront = '.plan-card--toggle__tofront';

  $(tofront).hover(function() {
    $(this).prev().toggleClass('plan-card--toggle__toback_hover');
    return false;
  });

  $(tofront).click(function() {
    $(this).parent().prev().prev().toggleClass('flipped');
    $(this).addClass('plan-card--toggle__tofront_click');
    $(this).children().toggleClass('plan-card--toggle__arrow_rotate');
    $(this).next().toggleClass('plan-card--toggle__toback_back_hover');
    return false;
  });

  $(tofront).on('transitionend', function() {
    $(this).removeClass('plan-card--toggle__tofront_click');
    $(this).addClass('plan-card--toggle__tofront_back');
    return false;
  });
});