$('#next_refresh').html('5000');

$('#thought-form').html("<%= escape_javascript(render(:partial => 'thoughts/form', :locals => {:thought_wall => @thought.thought_wall, :thought => @thought})) %>")
$('#thought-list').prepend("<%= escape_javascript(render(:partial => 'thoughts/thought_box', :locals => {:thought => @thought, :is_new_thought => true})) %>");
$('#thought-box-<%= escape_javascript(@thought.id.to_s) %>').animate({width: 215}, 500, function() { $(this).animate({opacity: 1.0}, 175, function() { $(this).removeClass('new-thought-box'); }) });

$('#thought_text').focus();