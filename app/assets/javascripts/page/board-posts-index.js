// yarn packages
//= require jscroll

// 無限スクロール
$(function(){
  $('.scroll').jscroll({
    nextSelector: '.pagination a[rel="next"]',
    contentSelector: '.scroll-area'
  });
});
