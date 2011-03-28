$(function () {
  //$('textarea').autoResize({extraSpace : 20})
  $('#notice').delay('3000').hide('slow');
  //$('time').clockwinder();
  
  $('textarea').live('keydown', 'ctrl+return', function() {
    $(this).closest('form').submit();
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
  
  $('#new_post').submit(function() {
    var content = $('#post_content').val();
    $.post("/streams/" + Pipe.stream_id + "/posts", { 'post[content]': content });
    $('#post_content').val('');
    return false;
  });
  
  $('.new_comment').live('submit', function() {
    var content = $(this).find('textarea').val();
    
    $.post(
      $(this).attr('action'), 
      {'comment[content]': content}
    );
    $(this).find('textarea').val('');
    $(this).find('textarea').blur();
    
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
