sub init() 
    m.top.setFocus(true)

    m.top.basePosterSize = [ 150, 229 ]
    m.top.caption1NumLines = 1
    m.top.numColumns = 6
    m.top.numRows = 2
    m.top.itemSpacing = [ 20, 20 ]
    m.top.translation = [50, 50]

    m.top.observeField("itemSelected", "showDetails")
    m.top.observeField("itemFocused", "changeTopDescText")
end sub

sub changeTopDescText()

    if m.top.content <> invalid then
        temp = m.top.findNode("lbTopDesc")
        contentChild = m.top.content.getChild(m.top.itemFocused)
        temp.text = contentChild.description
    end if
end sub

sub showDetails()
    'm.top.setFocus(false)
    m.details = m.top.findNode("details")
    m.details.setFocus(true)
    contentChild = m.top.content.getChild(m.top.itemSelected)
    description = m.details.findNode("lbDescription")
    description.text = "Description: " + contentChild.description
    m.details.visible = true
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false
  
    if key = "back" and m.details.visible = true then
        'm.top.setFocus(true)
      m.details.visible = false
      handled = true
    end if
  
    return handled
end function
  