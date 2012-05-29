$ ->
  maxThoughtChars = 65500
  thoughtTextarea = $('#thought_text')
  
  thoughtText = $('#thought_text')
  thoughtText.focus()
  
  thoughtTextarea.keyup ->
    $('#thought_new_remaining_characters').html('left: ' + (maxThoughtChars - thoughtTextarea.val().length))
  
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
