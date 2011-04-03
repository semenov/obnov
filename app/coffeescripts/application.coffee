$ ->
  $('#notice')
    .delay('3000')
    .hide('slow')
    
  # $.clockwinder.live('time')
  # $('textarea').autoResize extraSpace: 20
    
  $('textarea').live 'keydown', (e) ->
    code = if e.keyCode then e.keyCode else e.which
    returnKeyCode = 13
    
    if code == returnKeyCode && e.ctrlKey
      $(this).closest('form').submit()  

  $('input.reply').live 'focus', ->
    $(this)
      .next('.new_comment')
      .show()
      .find('textarea.reply')
      .focus()
    $(this).hide()
  
  $('textarea.reply').live 'blur', ->
    if $(this).val() == ''
      $(this)
        .closest('form')
        .hide()
        .prev('input.reply')
        .show()

  $('#new_post, .new_comment').live 'submit', ->
    form = $(this)

    $.post(
      form.attr('action'), 
      form.serializeArray()
    )

    form
      .find('textarea')
      .val('')
      .blur()
    
    return false
 
  
  jug = new Juggernaut host: 'obnov.com'
  jug.subscribe "streams/" + Pipe.stream_id, (data) ->
    event = data.event
    if event == 'posts/create'
      $(data.html).prependTo('#posts')
    else if event == 'comments/create'
      $(data.html).appendTo('.post[data-id="'+ data['post_id'] + '"] .comments')

