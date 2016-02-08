# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

extendVertScroll = undefined
$('.hidden.done_loading').ready ->
  extendVertScroll()
  return

extendVertScroll = ->
  `var ht`
  ht = $('.header_table').length
  ht = ht * 212
  # multiply number columns by 210, 211 or 212
  ht_tot = ht.toString() + 'px'
  $('#vert_overflow').css 'width', ht_tot
  return


