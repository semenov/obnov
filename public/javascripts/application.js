$(function () {
  //$('textarea').autoResize({extraSpace : 20})
  $('#notice').delay('3000').hide('slow');
  //$.clockwinder.live('time');
  
  $('textarea').live('keydown', function(e) {
    var code = (e.keyCode ? e.keyCode : e.which);
    var returnKeyCode = 13;
    if (code == returnKeyCode && e.ctrlKey) {
      $(this).closest('form').submit();
    }
  });
  
  $('input.reply').live('focus', function() {
    $(this).next('.new_comment').show().find('textarea.reply').focus();
    $(this).hide();
  });
  
  $('textarea.reply').live('blur', function() {
    if ($(this).val() == '') {
      $(this).closest('form').hide().prev('input.reply').show();
    }
  });

  $('#new_post, .new_comment').live('submit', function() {
    var form = $(this);

    $.post(
      form.attr('action'), 
      form.serializeArray()
    );

    form.find('textarea').val('').blur();
    return false;
  });
 
  
  var jug = new Juggernaut({ host: 'obnov.com' });
  jug.subscribe("streams/" + Pipe.stream_id, function(data) {
    var event = data['event'];
    if (event == 'posts/create') {
      $(data['html']).prependTo('#posts');
    } else if (event == 'comments/create') {
      $(data['html']).appendTo('.post[data-id="'+ data['post_id'] + '"] .comments');
    }
    
  });


})
