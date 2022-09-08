sub init()
  m.contentTask = createObject("roSGNode", "ContentReader")
  m.contentTask.contenturi = "https://api.npoint.io/b096a65d709fbe682348"
  m.contentTask.control = "RUN"
  m.contentTask.observeField("content", "fillGlobalContentVar")

  m.video = m.top.findNode("lVideo")
  m.menu = m.top.findNode("lMenu")
  m.grid = m.menu.findNode("lGrid")
  m.buttongrp = m.menu.findNode("btns")
  m.buttongrp.observeField("buttonSelected", "handleButtonPress")

end sub

sub fillGlobalContentVar()
  m.grid.content = m.contentTask.content
end sub


sub handleButtonPress()
  if m.buttongrp.buttonSelected = 0 then
      m.details = m.menu.findNode("details")
      playVideo(m.details.content)
  else
      m.grid.setFocus(true)
      m.details.visible = false
  end if
end sub

function playVideo(content as Dynamic)
    m.menu.visible = false
    m.video.visible = true
    'm.video.content = content
    videoContent = createObject("RoSGNode", "ContentNode")
   videoContent.url = m.details.vidurl
    videoContent.title = "Test Video"
   videoContent.streamformat = "hls"
    m.video.control = "play"
end function