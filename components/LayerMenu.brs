sub init() 


    m.grid = m.top.findNode("lGrid")
    m.details = m.top.findNode("details")

    m.grid.setFocus(true)
    m.descText = m.top.findNode("lbTopDesc")
    m.titleText = m.top.findNode("lbTopTitle")

    m.grid.observeField("itemSelected", "showDetails")
    m.grid.observeField("itemFocused", "changeTopDescText")
    m.details.observeField("visible", "handleFocus")
end sub

sub handleFocus()
    if m.details.visible then
        m.details.setFocus(true)
    else m.grid.setFocus(true)
    end if
end sub

sub changeTopDescText()
    if m.grid.content <> invalid then
        
        contentChild = m.grid.content.getChild(m.grid.itemFocused)
        m.desctext.text = contentChild.description
        m.titleText.text = contentChild.title
    end if
end sub

sub showDetails()
    m.contentChild = m.grid.content.getChild(m.grid.itemSelected)
    m.details.content = m.contentChild
    m.details.visible = true

end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = press
  
    if key = "back" and press then
        m.grid.setFocus(true)
      m.details.visible = false
    end if
  
    return handled
end function
