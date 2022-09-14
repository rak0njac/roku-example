sub init()
  m.top.setFocus(true)

  m.contentTask = createObject("roSGNode", "ContentReaderTask")
  m.contentTask.contenturi = "https://api.npoint.io/b096a65d709fbe682348"
  m.contentTask.control = "RUN"
  m.contentTask.observeField("content", "fillGlobalContentVar")

  m.menu = m.top.findNode("lMenu")
  m.grid = m.top.findNode("lGrid")
  m.details = m.top.findNode("lDetails")
  m.splash = m.top.findNode("lSplash")


  m.splashTimer = CreateObject("roSGNode", "Timer")
  m.splashTimer.duration = 3
  m.splashTimer.repeat = false
  m.splashTimer.observeField("fire", "splashTimerFired")
  m.splashTimer.control = "start"
end sub

sub fillGlobalContentVar()
  m.global.addFields({content: m.contentTask.content, details: m.details, grid: m.grid})
  m.grid.content = m.global.content

  if m.splashTimer = invalid
    hideSplash()
  end if
end sub


sub splashTimerFired()
  if m.global.content <> invalid
    hideSplash()
  end if
  m.splashTimer = invalid
end sub

sub hideSplash()
  m.grid.setFocus(true)
  m.splash.visible = false
end sub
