/* DO NOT MODIFY. This file was compiled Sun, 03 Apr 2011 15:18:52 GMT from
 * /home/semenov/Dropbox/dev/obnov/app/coffeescripts/application.coffee
 */

(function() {
  $(function() {
    var jug;
    $('#notice').delay('3000').hide('slow');
    $('textarea').live('keydown', function(e) {
      var code, returnKeyCode;
      code = e.keyCode ? e.keyCode : e.which;
      returnKeyCode = 13;
      if (code === returnKeyCode && e.ctrlKey) {
        return $(this).closest('form').submit();
      }
    });
    $('input.reply').live('focus', function() {
      $(this).next('.new_comment').show().find('textarea.reply').focus();
      return $(this).hide();
    });
    $('textarea.reply').live('blur', function() {
      if ($(this).val() === '') {
        return $(this).closest('form').hide().prev('input.reply').show();
      }
    });
    $('#new_post, .new_comment').live('submit', function() {
      var form;
      form = $(this);
      $.post(form.attr('action'), form.serializeArray());
      form.find('textarea').val('').blur();
      return false;
    });
    jug = new Juggernaut({
      host: 'obnov.com'
    });
    return jug.subscribe("streams/" + Pipe.stream_id, function(data) {
      var event;
      event = data.event;
      if (event === 'posts/create') {
        return $(data.html).prependTo('#posts');
      } else if (event === 'comments/create') {
        return $(data.html).appendTo('.post[data-id="' + data['post_id'] + '"] .comments');
      }
    });
  });
}).call(this);
