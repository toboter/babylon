# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("#date").hide()
  $("#alt-author").hide()

  $("#toggle-authors").click ->
    $("#alt-author").toggle()
    $("#authors").toggle()

  $("#add-date").click ->
    $("#date").toggle()


