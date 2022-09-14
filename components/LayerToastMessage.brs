sub init()
    m.label = m.top.findNode("label")

    m.top.observeField("visible", "show")
    m.top.observeField("text", "updateText")

    m.timer = CreateObject("roSGNode", "Timer")
    m.timer.duration = 3
    m.timer.repeat = false
    m.timer.observeField("fire", "hide")
end sub 

sub show()
    if m.top.visible then
        m.timer.control = "start"
    end if
end sub

sub updateText()
    m.label.text = m.top.text
end sub

sub hide()
    m.top.visible = false
end sub