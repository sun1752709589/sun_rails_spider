;
(function ($) {
    $.extend({
        birtLoading: function (action) {
            var loadingHtml = '<div class="birt-loading">' +
                '<div class="icon">' +
                '<img src="http://img.tanliani.com/public/assets/vd/icon_loading.png">' +
                '</div>' +
                '<p class="label">' +
                'Birt报表' +
                '</p>' +

                ' <div class="points">' +
                '  <i class="one"></i>' +
                '   <i class="two"></i>' +
                '   <i class="three"></i>' +
                '   </div>' +
                '</div>';
            $('.birt-loading').remove();
            $('body').append(loadingHtml);
            if (action == undefined || action == 'show') {
                $(".birt-loading").show();
            } else {
                $(".birt-loading").hide();
            }
        }
    });
})(jQuery);