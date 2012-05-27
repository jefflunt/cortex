$('#thought-box-<%= escape_javascript(@thought.id.to_s) %>').replaceWith("<%= escape_javascript(render :partial => 'thoughts/thought_box',  :locals => {:thought => @thought}) %>");

$('#thought_text').focus();