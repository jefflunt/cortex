var overlay = $('#overlay');
overlay.html("<%= escape_javascript(render(:partial => 'thoughts/thought_box_overlay', :locals => {:thought => @thought})) %>");
overlay.show();
overlay.animate({opacity: 1.0}, 100);