mouseDown = false
mouseDrag = false

$(document).keyup (event) ->
  overlay = $("#overlay")
  if event.keyCode == 13 or event.keyCode == 27
    unless overlay.css("display") is "none"
      overlay.animate
        opacity: 0.0
      , 100, ->
        overlay.hide()

$(document).mousedown  (event) ->
  mouseDown = true

$(document).mousemove  (event) ->
  if mouseDown
    mouseDrag = true
  
$(document).mouseup (event) ->
  unless mouseDrag
    overlay = $("#overlay")
    unless overlay.css("display") is "none"
      overlay.animate
        opacity: 0.0
      , 100, ->
        overlay.hide()
  mouseDown = false
  mouseDrag = false
  