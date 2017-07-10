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
//= require jquery.datetimepicker
//= require jquery-ui
//= require autocomplete-rails
//= require highcharts/highstock
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
        init_datepicker();
        bind_autocomplete();
        $(".modal-backdrop").remove();
        init_flow();
    });

    $(document).on('submit', '.pjax-form', function(event) {
        $.pjax.submit(event, '[data-pjax-container]',{timeout: 50000});
    });

    init_datepicker();
    init_menus();
    bind_autocomplete();
    init_flow();
});

function init_flow() {
    if($(".work-flow").size() == 0){
        return false
    }
    $(".flow_status_btn").click(function () {
        var current_status_name = $(this).attr('current_status_name');
        $.ajax({
            url: '/flows/'+$(this).attr('data'),
            type: 'GET',
            success: function (data) {
                initFlow(data['content']);
                $("#showFlow").modal('show');
                $('#myflow text').each(function (index, node) {
                    if ($(node).find('tspan').text() == current_status_name){
                        $(node).css('fill', 'red');
                    }
                })
            }
        })
    });

    function initFlow(content) {
        $("#myflow").html("");
        content = content.replace(/&#39;/g, '\'');
        $('#myflow').myflow(
            {
                basePath: "/",
                restore: eval("(" + content + ")"),
            });
    }
}


function init_html() {
    var footer_height = $(".navbar-fixed-bottom").height();
    var header_height = $(".header").height();
    var win_height = $(window).height();
    var div_height = win_height - footer_height - header_height - 30;
    $(".panel").css('height', div_height + 'px' );
    $(".panel").css('overflow', 'auto' );
}

function bind_autocomplete() {
    $('.asutocomplete').bind('input propertychange', function() {
    });
}

function init_menus() {
    var a_href = $("#left_menu").find('a').attr('href')


    // 菜单点击展开／关闭
    $(".dcjq-parent-menu").click(function () {
        $(".dcjq-parent-menu").removeClass('active');
        if($(this).next().css('display') == 'none'){
            $(this).addClass('active');
            $('.menu-sub').slideUp();
            $(this).next().slideDown();
        }else{
            $(this).next().slideUp();
        }
    });
    // 菜单选中
    $(".menu-sub").find('a').click(function(){
        $(".menu-sub").find('a').css('color', '#aeb2b7');
        $(this).css('color', '#428bca');
    })
}

function init_datepicker(){
    $(".datepicker-start, .datepicker-end, .selectpicker, .datepicker, .monthpicker, " +
        ".datetimepicker, .datetimepicker-start, .datetimepicker-end").attr("readonly", true);
    try {
        $('.datepicker').datetimepicker({
            format: 'Y-m-d',
            timepicker: false,
            lang: 'zh'
        });
        $('.monthpicker').datetimepicker({
            format: 'Y-m-01',
            timepicker: false,
            lang: 'zh'
        });
        $('.datetimepicker').datetimepicker({
            format: 'Y-m-d H:i:s',
            lang: 'zh'
        });
        $('.datepicker-start').datetimepicker({
            format: 'Y-m-d',
            timepicker: false,
            lang: 'zh'
        });
        $('.datepicker-end').datetimepicker({
            format: 'Y-m-d',
            timepicker: false,
            lang: 'zh'
        });
        $('.datetimepicker-start').datetimepicker({
            format: 'Y-m-d H:i:s',
            lang: 'zh'
        });
        $('.datetimepicker-end').datetimepicker({
            format: 'Y-m-d H:i:s',
            lang: 'zh'
        });
    } catch (e) {
    }
}