// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "easing"
import "easingmin"
import "owlcarousel"
import "owlcarouselmin"
import "trix"
import "@rails/actiontext"


document.addEventListener("turbo:load", function () {
  "use strict";
  
  // Dropdown on mouse hover
  function toggleNavbarMethod() {
    if ($(window).width() > 992) {
      $('.navbar .dropdown').on('mouseover', function () {
        $('.dropdown-toggle', this).trigger('click');
      }).on('mouseout', function () {
        $('.dropdown-toggle', this).trigger('click').blur();
      });
    } else {
      $('.navbar .dropdown').off('mouseover').off('mouseout');
    }
  }
  toggleNavbarMethod();
  $(window).resize(toggleNavbarMethod);

  // Back to top button
  $(window).scroll(function () {
    if ($(this).scrollTop() > 100) {
      $('.back-to-top').fadeIn('slow');
    } else {
      $('.back-to-top').fadeOut('slow');
    }
  });
  $('.back-to-top').click(function () {
    $('html, body').animate({scrollTop: 0}, 1500, 'easeInOutExpo');
    return false;
  });

  // Carousels
  $(".main-carousel").owlCarousel({
    autoplay: true,
    smartSpeed: 1500,
    items: 1,
    dots: true,
    loop: true,
    center: true,
  });

  $(".tranding-carousel").owlCarousel({
    autoplay: true,
    smartSpeed: 2000,
    items: 1,
    dots: false,
    loop: true,
    nav: true,
    navText: [
      '<i class="fa fa-angle-left"></i>',
      '<i class="fa fa-angle-right"></i>'
    ]
  });

  // Sidebar menu
  $(".sidebar-dropdown > a").click(function() {
    $(".sidebar-submenu").slideUp(200);
    if ($(this).parent().hasClass("active")) {
      $(".sidebar-dropdown").removeClass("active");
      $(this).parent().removeClass("active");
    } else {
      $(".sidebar-dropdown").removeClass("active");
      $(this).next(".sidebar-submenu").slideDown(200);
      $(this).parent().addClass("active");
    }
  });

  $("#close-sidebar").click(function() {
    $(".page-wrapper").removeClass("toggled");
  });

  $("#show-sidebar").click(function() {
    $(".page-wrapper").addClass("toggled");
  });
});