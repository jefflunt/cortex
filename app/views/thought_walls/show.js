setRenderTimestamp(<%= @render_timestamp %>)
setNextThoughtWallRefreshDelay(<%= @next_refresh %>);
updatePageTitle('<%= escape_javascript(@thought_wall.title) %>');
thoughtWallTitleInput.val('<%= escape_javascript(@thought_wall.title) %>');

<% @thoughts.each do |thought| %>
  thoughtBoxIsNewToClient = ($("#thought-box-<%= thought.id.to_s %>").length == 0);
  if (thoughtBoxIsNewToClient) {
    thoughtListDiv.prepend("<%= escape_javascript(render(:partial => 'thoughts/thought_box', :locals => {:thought => thought, :is_new_thought => true})) %>");
    $('#thought-box-<%= thought.id.to_s %>').animate({width: 215}, 500, function() { $(this).animate({opacity: 1.0}, 175, function() { $(this).removeClass('new-thought-box'); }) });
  } else {
    $("#thought-box-<%= thought.id.to_s %>").replaceWith("<%= escape_javascript(render(:partial => 'thoughts/thought_box', :locals => {:thought => thought})) %>");
  }
<% end %>

delayAction(ajaxRefreshPage, getCurrThoughtWallRefreshDelay());
false;