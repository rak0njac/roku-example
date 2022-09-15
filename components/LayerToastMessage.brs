sub init()
    m.label = m.top.findNode("label")

    m.top.observeField("text", "updateText")

    m.timer = CreateObject("roSGNode", "Timer")
    m.timer.duration = 3
    m.timer.repeat = false
    m.timer.observeField("fire", "hide")

    m.animIn = m.top.findNode("animIn")
    m.animOut = m.top.findNode("animOut")
    m.animOut.observeField("state", "turnOffVisibility")
end sub 

sub updateText()
    m.top.visible = true
    m.timer.control = "start"
    m.animIn.control = "start"
    m.animOut.control = "stop"
    m.label.text = m.top.text
end sub

sub hide()
    m.animOut.control = "start"
end sub

sub turnOffVisibility()
    if m.animOut.state = "stopped" and m.animIn.state = "stopped" then
        m.top.visible = false
    end if
end sub