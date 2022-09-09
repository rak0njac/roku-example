sub init()
  m.contentTask = createObject("roSGNode", "ContentReaderTask")
  m.contentTask.contenturi = "https://api.npoint.io/b096a65d709fbe682348"
  m.contentTask.control = "RUN"
  m.contentTask.observeField("content", "fillGlobalContentVar")

  m.video = m.top.findNode("lVideo")
  m.menu = m.top.findNode("lMenu")
  m.grid = m.top.findNode("lGrid")

  m.video.observeField("control", "hideEverything")

  m.global.addFields({video : m.video})
end sub

sub hideEverything()
  if m.video.control = "play" then 
    m.video.setFocus(true)
    m.menu.visible = false 
  else 
    m.menu.visible = true
  endif

end sub

sub fillGlobalContentVar()
  m.global.addFields({content : m.contentTask.content})
  m.grid.content = m.global.content
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
  handled = press

  if key = "back" and m.video.state = "playing" and press then
    m.video.control = "stop"
  end if

  return handled
end function
