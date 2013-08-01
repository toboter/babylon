jQuery ->
  $("#death").hide()
  $("#add-day-of-death").show()

  $("#add-day-of-death").click ->
    $("#death").show()
    $("#add-day-of-death").hide()