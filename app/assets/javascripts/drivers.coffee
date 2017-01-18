# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', ->
#
  init_car_js = ->

    $('#driver_conpany_id').bind 'railsAutocomplete.select', (event, data) ->
      $('#driver_conpany_id').val data.item.name
      return

  init_car_js()
  $(document).on 'pjax:complete', ->
    init_car_js()
  return