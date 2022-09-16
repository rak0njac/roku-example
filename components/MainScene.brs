sub init()
  m.top.setFocus(true)
  args = m.global.args



  m.contentTask = createObject("roSGNode", "NewContentReaderTask")
  m.contentTask.contenturi = "https://api.npoint.io/b096a65d709fbe682348"
  if args.DoesExist("contentId") and args.DoesExist("mediaType") then
    m.contentTask.argsId = args.contentId
  end if
  m.contentTask.control = "RUN"
  m.contentTask.observeField("content", "fillGlobalContentVar")

  m.menu = m.top.findNode("lMenu")
  m.grid = m.top.findNode("lGrid")
  m.details = m.top.findNode("lDetails")
  m.splash = m.top.findNode("lSplash")
  m.exit = m.top.findNode("lExit")
  m.toast = m.top.findNode("lToast")


  m.splashTimer = CreateObject("roSGNode", "Timer")
  m.splashTimer.duration = 3
  m.splashTimer.repeat = false
  m.splashTimer.observeField("fire", "splashTimerFired")
  m.splashTimer.control = "start"
end sub

sub fillGlobalContentVar()
  m.global.addFields({content: m.contentTask.content, details: m.details, grid: m.grid, exit: m.exit, toast: m.toast, scene: m.top})
  m.grid.content = m.global.content

  if m.global.deepLinkedContent <> invalid
    m.details.content = m.global.deepLinkedContent
    m.details.deepLinked = true
  end if

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
  if m.details.deepLinked = false then
    m.grid.setFocus(true)
  end if
  m.splash.visible = false
end sub
