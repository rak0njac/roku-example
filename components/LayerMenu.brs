sub init() 
    m.grid = m.top.findNode("lGrid")
    m.search = m.top.findNode("search")
    'm.details = m.top.findNode("details")

    m.grid.setFocus(true)
    m.descText = m.top.findNode("lbTopDesc")
    m.titleText = m.top.findNode("lbTopTitle")

    m.grid.observeField("itemSelected", "showDetails")
    m.grid.observeField("itemFocused", "changeTopDescText")
    m.search.observeField("text", "search")


end sub

sub search()
    if m.grid.content <> invalid then
        for i = 0 to m.grid.content.getChildCount() - 1
            child = m.grid.content.getChild(i)
                child.searchVisible = not lCase(child.title).InStr(lCase(m.search.text))
        end for
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
    m.global.details.content = m.contentChild
    m.global.details.visible = true

end sub

sub showKeyboard(show as boolean)
if show then
    m.search.visible = true
    m.search.setFocus(true)
    m.grid.translation = [50,500]
else
    m.search.visible = false
    m.grid.setFocus(true)
    m.grid.translation = [50,300]
end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    print key
    print m.top.visible
    print press

    if key = "options" and press then
        showKeyboard(true)
        return true
    else if key = "back" and m.search.visible and press then
        showKeyboard(false)
        return true
    end if
    return false
end function