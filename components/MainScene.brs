sub init()
  m.contentTask = createObject("roSGNode", "ContentReader")
  m.contentTask.contenturi = "https://api.npoint.io/b096a65d709fbe682348"
  m.contentTask.control = "RUN"
  m.contentTask.observeField("content", "fillGlobalContentVar")

  m.video = m.top.findNode("lVideo")
  m.menu = m.top.findNode("lMenu")
end sub

sub fillGlobalContentVar()
  'm.global.content = m.contentTask.content
  m.menu.content = m.contentTask.content
end sub
