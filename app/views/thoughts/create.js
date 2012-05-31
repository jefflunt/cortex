$('#next_refresh').html('5000');

$('#thought_text').val('');
maxThoughtChars = 65500
$('#thought-new-remaining-characters').html('remaining: ' + (maxThoughtChars - $('#thought_text').val().length))

$('#thought-list').prepend("<%= escape_javascript(render(:partial => 'thoughts/thought_box', :locals => {:thought => @thought, :is_new_thought => true})) %>");
$('#thought-box-<%= escape_javascript(@thought.id.to_s) %>').animate({width: 215}, 500, function() { $(this).animate({opacity: 1.0}, 175, function() { $(this).removeClass('new-thought-box'); }) });

$('#thought_text').focus();