$(document).keyup (event) ->
  overlay = $("#overlay")
  unless overlay.css("display") is "none"
    overlay.animate
      opacity: 0.0
    , 100, ->
      overlay.hide()