// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "easing"
import "easingmin"
import "owlcarousel"
import "owlcarouselmin"
import "trix"
import "@rails/actiontext"



  
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

  function initializeMainCarousel() {
  $(".main-carousel").owlCarousel({
    autoplay: true,
    smartSpeed: 1500,
    items: 1,
    dots: true,
    loop: true,
    center: true,
  });
}

    // Wait until all images inside .main-carousel are loaded
    let sliderImages = document.querySelectorAll('.main-carousel img');
    let totalImages = sliderImages.length;
    let imagesLoaded = 0;

    if (totalImages === 0) {
      initializeMainCarousel(); // fallback
    } else {
      sliderImages.forEach(function(img) {
        if (img.complete) {
          imagesLoaded++;
          if (imagesLoaded === totalImages) {
            initializeMainCarousel();
          }
        } else {
          img.addEventListener('load', function () {
            imagesLoaded++;
            if (imagesLoaded === totalImages) {
              initializeMainCarousel();
            }
          });
          img.addEventListener('error', function () {
            imagesLoaded++; // even failed images count to avoid blocking
            if (imagesLoaded === totalImages) {
              initializeMainCarousel();
            }
          });
        }
      });
    }

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

  // Carousel item 1
  $(".carousel-item-1").owlCarousel({
      autoplay: true,
      smartSpeed: 1500,
      items: 1,
      dots: false,
      loop: true,
      nav : true,
      navText : [
          '<i class="fa fa-angle-left" aria-hidden="true"></i>',
          '<i class="fa fa-angle-right" aria-hidden="true"></i>'
      ]
  });

  // Carousel item 2
  $(".carousel-item-2").owlCarousel({
      autoplay: true,
      smartSpeed: 1000,
      margin: 30,
      dots: false,
      loop: true,
      nav : true,
      navText : [
          '<i class="fa fa-angle-left" aria-hidden="true"></i>',
          '<i class="fa fa-angle-right" aria-hidden="true"></i>'
      ],
      responsive: {
          0:{
              items:1
          },
          576:{
              items:1
          },
          768:{
              items:2
          }
      }
  });


  // Carousel item 3
  $(".carousel-item-3").owlCarousel({
      autoplay: true,
      smartSpeed: 1000,
      margin: 30,
      dots: false,
      loop: true,
      nav : true,
      navText : [
          '<i class="fa fa-angle-left" aria-hidden="true"></i>',
          '<i class="fa fa-angle-right" aria-hidden="true"></i>'
      ],
      responsive: {
          0:{
              items:1
          },
          576:{
              items:1
          },
          768:{
              items:2
          },
          992:{
              items:3
          }
      }
  });
  

  // Carousel item 4
  $(".carousel-item-4").owlCarousel({
      autoplay: true,
      smartSpeed: 1000,
      margin: 30,
      dots: false,
      loop: true,
      nav : true,
      navText : [
          '<i class="fa fa-angle-left" aria-hidden="true"></i>',
          '<i class="fa fa-angle-right" aria-hidden="true"></i>'
      ],
      responsive: {
          0:{
              items:1
          },
          576:{
              items:1
          },
          768:{
              items:2
          },
          992:{
              items:3
          },
          1200:{
              items:4
          }
      }
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