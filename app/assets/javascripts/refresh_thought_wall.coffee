$ ->
  delay = (->
    timer = 0
    (callback, ms) ->
      clearTimeout timer
      timer = setTimeout(callback, ms)
  )()
  
  renderTimestamp = $('#render_timestamp').html()
  if (renderTimestamp != '')
    nextRefreshDelay = $('#next_refresh').html()
    nextRefreshDelay = 2000
    delay (->
      $.get document.URL+".js?since="+renderTimestamp+"&next_refresh="+nextRefreshDelay
      , (data) ->
        console.log data
    ), nextRefreshDelay
    false
    
  