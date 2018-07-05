// yarn packages
//= require slick-carousel/slick/slick.min.js
//= require lightbox2/dist/js/lightbox.min.js
//= require jscroll

$(document).ready(function() {
  //FlexEmpty
  var methods = {
    init: function (conf) {
      return this.each(function() {
        var $this = $(this);
        $this.conf = $.extend({
          //// 生成されるタグのタグ名
          tagName: "li",
          //// エンプティのクラス名
          emptyClass: "empty"
        }, conf);
        var emptyCells = [], i;
        for(i=-1; i<$this.children().length; i++) {
          emptyCells.push($('<'+$this.conf.tagName +'>', {class: $this.conf.emptyClass}));
        }
        $this.append(emptyCells);
      });
    }
  };

  $.fn.flexEmpty = function(method) {
    if(methods[method]) {
      return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method === 'object' || !method) {
      return methods.init.apply(this, arguments);
    } else {
      $.error('Method ' + method + 'does not exists on flexEmpty');
    }
  }
  $(".usrlist").flexEmpty();
  //ポップアップ時CSS
  $('.pop').click(function(){
    $('#advance_pop').addClass('open_pop')
  });
  $('#pop_close').click(function(){
    $('#advance_pop').removeClass('open_pop')
  });
  $('#pop_win').on('load', function(){
      $('#pop_win').contents().find('head').append('<link rel="stylesheet" href="./css/popup.css">');
  });
});

// 無限スクロール
$(function(){
  $('.scroll').jscroll({
    nextSelector: '.pagination a[rel="next"]',
    contentSelector: '.scroll-area'
  });
});
