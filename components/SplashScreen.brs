sub init()
    c1 = m.top.FindNode("splash_circle_1")
    c2 = m.top.FindNode("splash_circle_2")
    c3 = m.top.FindNode("splash_circle_3")
    c4 = m.top.FindNode("splash_circle_4")
    m.splashText = m.top.FindNode("splash_text")

    c1.scaleRotateCenter = [c1.width / 2, c1.height / 2]
    c2.scaleRotateCenter = [c2.width / 2, c2.height / 2]
    c3.scaleRotateCenter = [c3.width / 2, c3.height / 2]
    c4.scaleRotateCenter = [c4.width / 2, c4.height / 2]

    m.anim = m.top.FindNode("anim")
    m.anim.control = "start"


    m.text = "My Roku Channel"
    m.count = 1

    m.textTimer = CreateObject("roSGNode", "Timer")
    m.textTimer.duration = 0.15
    m.textTimer.repeat = true
    m.textTimer.observeField("fire", "textTimerFired")
    m.textTimer.control = "start"

    m.top.observeField("visible", "stopAnimation")

end sub

sub textTimerFired()
    if m.count <= m.text.len()
        m.splashText.text = m.text.left(m.count)
        m.count++
    else m.textTimer.control = "stop"
    end if
end sub

sub stopAnimation()
    if m.top.visible = false then
        m.anim.control = "stop"
    end if
end sub