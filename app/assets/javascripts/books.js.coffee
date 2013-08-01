# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("#if_serial").hide()
  $("#if_editorial").hide()
  $("#if_collection").hide()
  $("#unless_serial").hide()
  $("#year").hide()
  $("#articles").hide()
  $('#book-submit').attr('disabled','disabled')
  $('#book_book_type').change( ->
    book_type = $("#book_book_type option").filter(':selected').text()
    # alert('Handler for .change() called. from ' + book_type)
    if book_type == 'Monographie'
      $("#if_serial").hide()
      $("#if_editorial").hide()
      $("#if_collection").hide()
      $("#unless_serial").show()
      $("#year").show()
      $("#articles").show()
      $('#book-submit').removeAttr('disabled')
    if book_type == 'Sammelband'
      $("#if_serial").hide()
      $("#if_editorial").show()
      $("#if_collection").show()
      $("#unless_serial").show()
      $("#year").show()
      $("#articles").show()
      $('#book-submit').removeAttr('disabled')
    if book_type == 'Monographie in einer Reihe'
      $("#if_serial").show()
      $("#if_editorial").hide()
      $("#if_collection").hide()
      $("#unless_serial").show()
      $("#year").show()
      $("#articles").show()
      $('#book-submit').removeAttr('disabled')
    if book_type == 'Sammelband in einer Reihe'
      $("#if_serial").show()
      $("#if_editorial").show()
      $("#if_collection").show()
      $("#unless_serial").show()
      $("#year").show()
      $("#articles").show()
      $('#book-submit').removeAttr('disabled')
    if book_type == 'Band einer Zeitschrift'
      $("#if_serial").show()
      $("#if_editorial").hide()
      $("#if_collection").hide()
      $("#unless_serial").hide()
      $("#year").show()
      $("#articles").show()
      $('#book-submit').removeAttr('disabled')
    if book_type == ''
      $("#if_serial").hide()
      $("#if_editorial").hide()
      $("#if_collection").hide()
      $("#unless_serial").hide()
      $("#year").hide()
      $("#articles").hide()
      $('#book-submit').attr('disabled','disabled') ).trigger('change')