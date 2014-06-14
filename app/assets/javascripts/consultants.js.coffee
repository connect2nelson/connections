$(document).ready ->
  $('#search_field').bind 'railsAutocomplete.select', (event, data) ->
    window.location = "/consultants/#{data.item.employee_id}"
