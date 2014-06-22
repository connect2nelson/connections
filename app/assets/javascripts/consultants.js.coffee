$(document).ready ->
  $('#full_name').bind 'railsAutocomplete.select', (event, data) ->
    window.location = "/consultants/#{data.item.employee_id}"
  onHoverIn = ->
    $(this).find('.label').addClass 'highlight'
    texts = $(this).find('.label').map(-> this.innerText).get()
    $('.skills .label').each ->
      if(texts.indexOf($(this).text()) != -1)
        $(this).addClass 'highlight'
  onHoverOut = ->
    $('.label').removeClass 'highlight'
  $('.matches li').hover onHoverIn, onHoverOut

