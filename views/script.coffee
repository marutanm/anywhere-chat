if rack_env isnt 'production'
  Pusher.log = (message) -> console.log(message)

addDiv = (data) ->
  $('<div/>')
    .text(data.text)
    .css(
      top: data.top + 'px'
      left: data.left + 'px'
    )
    .appendTo('#content')

channel = pusher.subscribe('test_channel');
channel.bind('my_event', (data) -> addDiv(data))

$ ->
  $('#form').keypress (e) ->
    if ((e.which and e.which is 13) or (e.keyCode and e.keyCode is 13))
      $.post '/',
        'text': $('#form').val()
        'top': @offsetTop
        'left': @offsetLeft
        => $(@).hide().val('')

  $(document).click (e) -> $('#form').css(left: e.clientX, top: e.clientY).show().focus()

  $.getJSON '/log',
    (json) -> addDiv(JSON.parse(data)) for data in json
