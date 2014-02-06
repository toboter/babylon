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
    if book_type == 'Monograph'
      $("#if_serial").hide()
      $("#if_editorial").hide()
      $("#if_collection").hide()
      $("#unless_serial").show()
      $("#year").show()
      $("#articles").show()
      $('#book-submit').removeAttr('disabled')
    if book_type == 'Collection'
      $("#if_serial").hide()
      $("#if_editorial").show()
      $("#if_collection").show()
      $("#unless_serial").show()
      $("#year").show()
      $("#articles").show()
      $('#book-submit').removeAttr('disabled')
    if book_type == 'Monograph in a serial'
      $("#if_serial").show()
      $("#if_editorial").hide()
      $("#if_collection").hide()
      $("#unless_serial").show()
      $("#year").show()
      $("#articles").show()
      $('#book-submit').removeAttr('disabled')
    if book_type == 'Collection in a serial'
      $("#if_serial").show()
      $("#if_editorial").show()
      $("#if_collection").show()
      $("#unless_serial").show()
      $("#year").show()
      $("#articles").show()
      $('#book-submit').removeAttr('disabled')
    if book_type == 'Issue of a journal'
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

  $("#articles").on('cocoon:after-insert', ->
    $(".chosen-select").chosen
      no_results_text: "Oops, nothing found!"
      search_contains: true)