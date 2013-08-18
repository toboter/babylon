jQuery.fn.submitOnCheck = ->
  @find('#ctodo').remove()
  @find('input[type=checkbox]').click ->
    $("form").submit()
  this

jQuery ->
  $('.edit_todo').submitOnCheck()
  $('.datepicker').fdatepicker
    format: 'yy-mm-dd'