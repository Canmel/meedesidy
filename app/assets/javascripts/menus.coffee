# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
load_menus = ->
  menus = null
  $.ajax
    url: 'users/load_menus'
    async: false
    dataType: 'json'
    success: (data) ->
      menus = data
      return
  i = 0
  while i < menus.length
    if menus[i].resource_type == 1
      $('#left_menu').append '<li class=\'sub-menu dcjq-parent-li\'>' + '<a href=\'javascript:;\' class=\'dcjq-parent active\'>' + '<i class=\'fa fa-laptop\'></i>' + '<span>' + menus[i].name + '</span>' + '<span class=\'label label-success span-sidebar\'>4</span>' + '<span class=\'dcjq-icon\'></span></a>' + '<ul class=\'sub\' style=\'overflow: hidden; display: block;\' id=\'menu_id_' + menus[i].id + '\'>' + '</ul>' + '</li>'
    else
      $('#menu_id_' + menus[i].parent_id).append '<li><a href=\'' + menus[i].source + '\'data-skip-pjax>' + menus[i].name + '</a></li>'
    i++
  return