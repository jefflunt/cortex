$('.edit_thought_wall').html("<%= escape_javascript(render('thought_walls/form')) %>");
$('#thought_text').focus();