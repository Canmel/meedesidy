// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.pjax
//= require_tree .


$(document).on('ready page:load',function(){
    // 初始化pjax
    $(document).pjax('a:not([data-remote]):not([data-behavior]):not([data-skip-pjax]):not([data-method="delete"])', '[data-pjax-container]',{timeout: 50000});
    // 调整布局
    $(".panel").css('margin-top', $(".header").height()+'px');

    // pjax 开始 回调
    $(document).on('pjax:start', function() {
        NProgress.start();
    });
    // pjax 结束 回调
    $(document).on('pjax:end', function() {
        NProgress.done();
        // 微调布局
        $(".panel").css('margin-top', $(".header").height()+'px');
        init_html();
    });

    $(document).on('submit', '.pjax-form', function(event) {
        $.pjax.submit(event, '[data-pjax-container]',{timeout: 50000});
    });
});


function init_html() {
    var footer_height = $(".navbar-fixed-bottom").height();
    var header_height = $(".header").height();
    var win_height = $(window).height();
    var div_height = win_height - footer_height - header_height - 30;
    $(".panel").css('height', div_height + 'px' );
    $(".panel").css('overflow', 'auto' );
}

function init_menus() {
    $(".dcjq-parent").click(function () {
        if($(this).next().css('display') == 'none'){
            $(this).next().slideDown();
        }else{
            $(this).next().slideUp();
        }
    });
}
