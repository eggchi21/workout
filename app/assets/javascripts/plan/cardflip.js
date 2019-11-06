$(function() {
  var tofront = '.plan-index--toggle__tofront';

  $(tofront).hover(function() {
    $(this).prev().toggleClass('plan-index--toggle__toback_hover');
    return false;
  });

  $(tofront).click(function() {
    $(this).parent().prev().toggleClass('flipped');
    $(this).addClass('plan-index--toggle__tofront_click');
    $(this).children().toggleClass('plan-index--toggle__arrow_rotate');
    $(this).next().toggleClass('plan-index--toggle__toback_back_hover');
    return false;
  });

  $(tofront).on('transitionend', function() {
    $(this).removeClass('plan-index--toggle__tofront_click');
    $(this).addClass('plan-index--toggle__tofront_back');
    return false;
  });
});