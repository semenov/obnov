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
  $('.refresh').click(function() {
    alert('lol');
  });
  
  $('#new_post').submit(function() {
    var content = $('#post_content').val();
    $.post("/streams/" + Pipe.stream_id + "/posts", { 'post[content]': content });
    $('#post_content').val('');
    return false;
  });
  
  var jug = new Juggernaut({ host: 'obnov.com' });
  jug.subscribe("streams/" + Pipe.stream_id, function(data) {
    $(data['html']).prependTo('#posts')
  });
  

})
