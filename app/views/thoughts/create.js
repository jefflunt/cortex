// Update the UI after a new Thought is created on the server side

setNextThoughtWallRefreshDelay(minThoughtWallRefreshDelay);
clearNewThoughtForm();

$('#thought-list').prepend("<%= escape_javascript(render(:partial => 'thoughts/thought_box', :locals => {:thought => @thought, :is_new_thought => true})) %>");
slideThoughtIn($('#thought-box-<%= escape_javascript(@thought.id.to_s) %>'), function() { $(this).removeClass('new-thought-box') })

focusOnNewThoughtText();
delayAction(ajaxRefreshPage, getCurrThoughtWallRefreshDelay());
