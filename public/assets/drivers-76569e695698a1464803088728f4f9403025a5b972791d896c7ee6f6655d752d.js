(function() {
  $(document).on('ready page:load', function() {
    var init_car_js;
    init_car_js = function() {
      return $('#driver_conpany_id').bind('railsAutocomplete.select', function(event, data) {
        $('#driver_conpany_id').val(data.item.name);
      });
    };
    init_car_js();
    $(document).on('pjax:complete', function() {
      return init_car_js();
    });
  });

}).call(this);
