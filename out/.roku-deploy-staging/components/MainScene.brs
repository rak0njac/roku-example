sub init()
  m.contentTask = createObject("roSGNode", "ContentReader")
  m.contentTask.contenturi = "https://api.npoint.io/b096a65d709fbe682348"
  m.contentTask.control = "RUN"

  m.menu = m.top.findNode("lMenu")
  m.menu.observeField("itemSelected", "fillDetails")

  m.details = m.top.findNode("lDetails")
end sub

sub fillDetails()
  content_child = m.contentTask.content.getChild(m.menu.itemSelected)
  description = m.details.findNode("lbDescription")
  description.text = "Description: " + content_child.description
  m.details.visible = true
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
  handled = false

  if key = "back" and m.details.visible = true
    m.details.visible = false
    handled = true
  end if

  return handled
end function