$('#render_timestamp').html('<%= @render_timestamp %>');
$('#next_refresh').html('<%= @next_refresh %>');

<% @thoughts.each do |thought| %>
  thoughtBoxIsNewToClient = ($("#thought-box-<%= thought.id.to_s %>").length == 0);
  if (thoughtBoxIsNewToClient) {
    $("#thought-list").prepend("<%= escape_javascript(render(:partial => 'thoughts/thought_box', :locals => {:thought => thought, :is_new_thought => true})) %>");
    $('#thought-box-<%= thought.id.to_s %>').animate({width: 215}, 500, function() { $(this).animate({opacity: 1.0}, 175, function() { $(this).removeClass('new-thought-box'); }) });
  } else {
    $("#thought-box-<%= thought.id.to_s %>").replaceWith("<%= escape_javascript(render(:partial => 'thoughts/thought_box', :locals => {:thought => thought})) %>");
  }
<% end %>

var delay, nextRefreshDelay, renderTimestamp;
delay = (function() {
  var timer;
  timer = 0;
  return function(callback, ms) {
    clearTimeout(timer);
    return timer = setTimeout(callback, ms);
  };
})();

<% if @thoughts.count > 0 %>
  nextRefreshDelay = 5000;
<% else %>
  nextRefreshDelay = 10000;
<% end %>

nextRefreshDelay = $('#next_refresh').html()
delay((function() {
  renderTimestamp = $('#render_timestamp').html();
  return $.get(document.URL+".js?since="+renderTimestamp+"&next_refresh="+nextRefreshDelay, function(data) {
    return console.log(data);
  });
}), nextRefreshDelay);
false;