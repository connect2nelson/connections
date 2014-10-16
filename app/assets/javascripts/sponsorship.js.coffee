$(document).ready ->
  $('#sponsee_full_name').bind 'railsAutocomplete.select', (event, data) ->
    $('#sponsee_id').val(data.item.employee_id)

