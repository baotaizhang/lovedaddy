$(document).ready(function() {
  //PC menuBtn
  $(".menuBtn").click(function(){
    $("#sp_menu").toggleClass("open"),
    $("#mem_menu").toggleClass("open")
  });
  $(document).on('click touchend',   function(e) {
    if (!$(e.target).closest('.menuBtn').length) {
      $("#sp_menu").removeClass("open"),
      $('.spBtn').removeClass('close'),
      $("#mem_menu").removeClass("open")
      }
  });

  //SP menuBtn
  $(".spBtn").click(function(){
    $(this).toggleClass("close")
  });
  //TOPBTN
  $(function() {
      var topBtn = $('#TOP');
      topBtn.hide();
      //スクロールが100に達したらボタン表示
      $(window).scroll(function () {
          if ($(this).scrollTop() > 300) {
          //ボタンの表示方法
              topBtn.fadeIn();
          } else {
          //ボタンの非表示方法
              topBtn.fadeOut();
          }
      });
      //スクロールしてトップ
      topBtn.click(function () {
          $('body,  html').animate({
              scrollTop: 0
          },   500);
          return false;
      });
  })
});
