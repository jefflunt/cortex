$ ->
  $(document).keyup (event) ->
    overlay = $('#overlay')
    if event.keyCode == 13 or event.keyCode == 27
      unless overlay.css("display") is "none"
        overlay.animate
          opacity: 0.0
        , 100, ->
          overlay.hide()

  $('#overlay-close').on "click", (event) ->
    overlay = $('#overlay')
    overlay.animate
      opacity: 0.0
    , 100, ->
      overlay.hide()