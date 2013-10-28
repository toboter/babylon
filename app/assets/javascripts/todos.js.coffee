# jQuery.fn.submitOnCheck = ->
#   @find('input[type=submit]').remove()
#   @find('input[type=checkbox]').click ->
#     $(this).parent('form').submit()
#   this
# 
# jQuery ->
#   $('.edit_todo').submitOnCheck()

jQuery ->
  $('.input-append.date').datepicker(
    format: "dd.mm.yyyy",
    todayHighlight: true,
    forceParse: false
  )