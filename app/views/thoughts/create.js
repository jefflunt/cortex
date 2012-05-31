// Update the UI after a new Thought is created on the server side

setNextThoughtWallRefreshDelay(minThoughtWallRefreshDelay);
clearNewThoughtForm();

$('#thought-list').prepend("<%= escape_javascript(render(:partial => 'thoughts/thought_box', :locals => {:thought => @thought, :is_new_thought => true})) %>");
$('#thought-box-<%= escape_javascript(@thought.id.to_s) %>').animate({width: 215}, 500, function() { $(this).animate({opacity: 1.0}, 175, function() { $(this).removeClass('new-thought-box'); }) });

focusOnNewThoughtText();
