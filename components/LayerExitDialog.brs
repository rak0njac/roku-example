sub init()
    m.top.observeField("buttonSelected", "handleButtonSelected")
end sub

sub handleButtonSelected()
    if m.top.buttonSelected = 0 then
        m.global.appExit = true
        print "works"
    else 
        m.top.visible = false
        m.global.grid.setFocus(true)
    end if
end sub