overlayContentDiv.html("<%= escape_javascript(render(:partial => 'thoughts/thought_box_overlay', :locals => {:thought => @thought})) %>");

overlayDiv.show();
overlayDiv.animate({opacity: 1.0}, 100);
recentThoughtWallsDiv.animate({opacity: 0.0}, 100);