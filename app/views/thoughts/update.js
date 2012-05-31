setNextThoughtWallRefreshDelay(minThoughtWallRefreshDelay);

if (getOverlayIsVisible()) {
  overlayContentDiv.html("<%= escape_javascript(render :partial => 'thoughts/thought_box_overlay',  :locals => {:thought => @thought}) %>");
}

$('#thought-box-<%= escape_javascript(@thought.id.to_s) %>').replaceWith("<%= escape_javascript(render :partial => 'thoughts/thought_box',  :locals => {:thought => @thought}) %>");

delayAction(refreshPageNow, getCurrThoughtWallRefreshDelay());