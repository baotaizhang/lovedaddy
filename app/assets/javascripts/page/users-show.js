// yarn packages
//= require slick-carousel/slick/slick.min.js
//= require lightbox2/dist/js/lightbox.min.js

$(document).ready(function() {
  //slick
  $('#pro_photo').slick({
   slidesToShow: 1,
   slidesToScroll: 1,
   arrows: false,
   fade: true,
   asNavFor: '#pro_thumb',
   zIndex:1
  });
  $('#pro_thumb').slick({
   slidesToShow: 2,
   slidesToScroll: 1,
   asNavFor: '#pro_photo',
   dots: false,
   arrows: false,
   centerMode: true,
   focusOnSelect: true,
   zIndex:1
  });
});
