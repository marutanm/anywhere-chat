Pusher.log = (message) ->
  console.log(message)

channel = pusher.subscribe('test_channel');
channel.bind('my_event', (data) -> 
  $('<div/>')
    .text(data.text)
    .css(
      top: data.top+'px'
      left: data.left+'px'
      )
    .prependTo('#content')
  $('#form').hide().val('')
)

$ ->
  $('#form')
  .keypress (e) ->
    if ((e.which and e.which is 13) or (e.keyCode and e.keyCode is 13))
      $.ajax '',
        type: 'post'
        data:
          'text': $('#form').val()
          'top': @offsetTop
          'left': @offsetLeft
  $(document).click (e) -> $('#form').css(left: e.clientX, top: e.clientY).show().focus()

