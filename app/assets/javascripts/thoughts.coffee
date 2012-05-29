$ ->
  maxThoughtChars = 65500
  $('#thought_text').focus()
  
  $("body").delegate "#thought_text", "keyup", (event) ->
      $('#thought_new_remaining_characters').html('remaining: ' + (maxThoughtChars - $('#thought_text').val().length))
        
  $("#thought_wall_title").keyup ->
    $("#update_thought_wall_spinner").show()
    $("#collection-name").html($(this).val())
    delay (->
      $(".edit_thought_wall").submit()
      $("#update_thought_wall_spinner").hide()
    ), 750
    false

  delay = (->
    timer = 0
    (callback, ms) ->
      clearTimeout timer
      timer = setTimeout(callback, ms)
  )()
