# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("#publications").on('cocoon:after-insert', ->
    $(".chosen-select").chosen
      no_results_text: "Oops, nothing found!"
      search_contains: true
    )
  $("#connections").on('cocoon:after-insert', ->
    $(".chosen-select").chosen
      no_results_text: "Oops, nothing found!"
      search_contains: true
    )
  $("#buckets").on('cocoon:after-insert', ->
    $(".chosen-select").chosen
      no_results_text: "Oops, nothing found!"
      search_contains: true
    )
  $("#documents").on('cocoon:after-insert', ->
    $(".chosen-select").chosen
      no_results_text: "Oops, nothing found!"
      search_contains: true
    )
  $("#sources").on('cocoon:after-insert', ->
    $(".chosen-select").chosen
      no_results_text: "Oops, nothing found!"
      search_contains: true
    )
  $("#actions").on('cocoon:after-insert', -> 
    $('.input-append.date').datepicker(
      format: "dd.mm.yyyy",
      todayHighlight: true,
      forceParse: false)
    )