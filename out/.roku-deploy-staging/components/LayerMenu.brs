sub init() 
    m.grid = m.top.findNode("lGrid")
    'm.details = m.top.findNode("details")

    m.grid.setFocus(true)
    m.descText = m.top.findNode("lbTopDesc")
    m.titleText = m.top.findNode("lbTopTitle")

    m.grid.observeField("itemSelected", "showDetails")
    m.grid.observeField("itemFocused", "changeTopDescText")
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
    m.global.details.content = m.contentChild
    m.global.details.visible = true

end sub