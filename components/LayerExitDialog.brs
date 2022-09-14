sub init()
    m.top.observeField("buttonSelected", "handleButtonSelected")
end sub

sub handleButtonSelected()
    if m.top.buttonSelected = 0 then

    else 
        m.top.visible = false
        m.global.grid.setFocus(true)
    end if
end sub