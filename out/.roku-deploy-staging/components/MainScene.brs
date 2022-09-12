sub init()


  m.contentTask = createObject("roSGNode", "ContentReaderTask")
  m.contentTask.contenturi = "https://api.npoint.io/b096a65d709fbe682348"
  m.contentTask.control = "RUN"
  m.contentTask.observeField("content", "fillGlobalContentVar")

  m.video = m.top.findNode("lVideo")
  m.menu = m.top.findNode("lMenu")
  m.grid = m.top.findNode("lGrid")
  m.details = m.top.findNode("lDetails")

  m.video.observeField("state", "handleVideoState")
end sub

sub handleVideoState()
  m.video.setFocus(true)
  m.video.visible = true
  m.menu.visible = false 
  m.details.visible = false

  if m.video.state = "stopped" or m.video.state = "finished"
    'm.menu.setFocus(true)
    m.menu.visible = true
    m.video.visible = false
    m.video.content = invalid
    m.details.visible = true
    m.details.setFocus(true)
  endif

end sub

sub fillGlobalContentVar()
  m.global.addFields({video: m.video, content: m.contentTask.content, details: m.details, grid: m.grid})
  m.grid.content = m.global.content
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
  handled = press

  if key = "back" and m.video.state = "playing" then
    m.video.control = "stop"
  end if

  return handled
end function
