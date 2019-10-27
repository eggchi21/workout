$(function(){
// Sticky Header
$(window).scroll(function() {

    if ($(window).scrollTop() > 100) {
        $('.main-header').addClass('sticky');
    } else {
        $('.main-header').removeClass('sticky');
    }
});

// Mobile Navigation
$('.main-header--content__mobile-toggle').click(function() {
    if ($('.main-header').hasClass('open-nav')) {
        $('.main-header').removeClass('open-nav');
    } else {
        $('.main-header').addClass('open-nav');
    }
});

$('.main-header li a').click(function() {
    if ($('.main-header').hasClass('open-nav')) {
        $('.navigation').removeClass('open-nav');
        $('.main-header').removeClass('open-nav');
    }
});

// navigation scroll
$('.main-header--nav a').click(function(event) {
    var id = $(this).attr("href");
    var offset = 0;
    var target = $(id).offset().top - offset;
    $('html, header').animate({
        scrollTop: target
    }, 500);
    event.preventDefault();
});
/* Scroll-to-Top Button */
$(window).scroll(function () {
    if ($(this).scrollTop() > 100) {
        $('.scrollup').fadeIn();
    } else {
        $('.scrollup').fadeOut();
    }
});

$('.scrollup').click(function () {
    $("html, header").animate({
        scrollTop: 0
    }, 600);
    return false;
});
/* WORK IN PROGRESS
   NAVIGATION ACTIVE STATE IN SECTION AREA
*/
var sections = $('section'), nav = $('.main-header--nav'), nav_height = nav.outerHeight();

$(window).on('scroll', function () {
  var cur_pos = $(this).scrollTop();

  sections.each(function() {
    var top = $(this).offset().top - nav_height,
        bottom = top + $(this).outerHeight();

    if (cur_pos >= top && cur_pos <= bottom) {
      nav.find('a').removeClass('active');
      sections.removeClass('active');

      $(this).addClass('active');
      nav.find('a[href="#'+$(this).attr('id')+'"]').addClass('active');
    }
  });
});

})