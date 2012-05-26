$('#thought-list').html("<%= escape_javascript(render(:partial => 'thoughts/thought_list', :locals => {:thoughts => @thought.thought_wall.thoughts})) %>");

$('#thought_text').focus();