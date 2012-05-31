$ ->
  $(document).keyup (event) ->
    if event.keyCode == 13 or event.keyCode == 27
      unless overlayDiv.css("display") is "none"
        overlayDiv.animate
          opacity: 0.0
        , 100, ->
          overlayDiv.hide()

  $('#overlay-close').on "click", (event) ->
    overlayDiv.animate
      opacity: 0.0
    , 100, ->
      overlayDiv.hide()