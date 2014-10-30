jQuery ->
    
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).closest('.field').remove()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  $('#csv-link').removeAttr('href')

  $("#per_page_submit_button").hide()
  $('#per_page_select').change ->
    $(this).closest('form').trigger('submit')

  $("#authors").on('cocoon:after-insert', ->
    $(".chosen-select").chosen
      no_results_text: "Nothing found!",
      search_contains: true )