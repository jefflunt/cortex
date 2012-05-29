var overlay         = $('#overlay');
var overlay_content = $('#overlay-content');
overlay_content.html("<%= escape_javascript(render(:partial => 'thoughts/thought_box_overlay', :locals => {:thought => @thought})) %>");

overlay.show();
overlay.animate({opacity: 1.0}, 100);