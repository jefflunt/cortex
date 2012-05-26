$('#thought-new').html("<%= escape_javascript(render(:partial => 'thoughts/form', :locals => {:thought_wall => @thought.thought_wall, :thought => @thought})) %>")
$('#thought-list').prepend("<%= escape_javascript(render(:partial => 'thoughts/thought_box', :locals => {:thought => @thought})) %>");

$('#thought_text').focus();