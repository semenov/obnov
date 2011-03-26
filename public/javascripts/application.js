/*var Global = {};

Global.lastUpdate = new Date();

var Post = {};

Post.refresh = function() {
  $.ajax({
    url: "test.html",
    cache: false,
    success: function(html) {
      $("#results").append(html);
    }
  });
}



var Comment = {};
*/
$(function () {
  $('#notice').delay('3000').hide('slow');
  
  $('#posts .post').live('click', function() {
    var url = '/streams/' + Pipe.stream_id + '/posts/' + $(this).data('id')
    window.location = url;
  });
  
  $('textarea').bind('keydown', 'ctrl+return', function() {
    $(this).closest('form').submit();
  });
  
  $('#new_post').submit(function() {
    var content = $('#post_content').val();
    $.post("/streams/" + Pipe.stream_id + "/posts", { 'post[content]': content });
    $('#post_content').val('');
    return false;
  });
  
  $('#new_comment').submit(function() {
    
    var content = $('#comment_content').val();

    $.post(
      "/streams/" + Pipe.stream_id + "/posts/" + Pipe.post_id + "/comments", 
      { 'comment[content]': content }
    );
    $('#comment_content').val('');
    
    return false;
  });
  
  $('textarea').autoResize();
  
  var jug = new Juggernaut({ host: 'obnov.com' });
  jug.subscribe("streams/" + Pipe.stream_id, function(data) {
    $(data['html']).prependTo('#posts')
  });
  
  jug.subscribe("posts/" + Pipe.post_id, function(data) {
    $(data['html']).appendTo('#comments')
  });

})
