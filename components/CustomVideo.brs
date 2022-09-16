sub init()
    m.overlay = m.top.findNode("overlay")

    m.pause = m.top.findNode("pause")
    m.rewind = m.top.findNode("rewind")
    m.ff = m.top.findNode("ff")

    m.top.observeField("playbackMode", "handlePlaybackMode")

    m.top.observeField("position", "updatePositionLabel")

    m.timer = CreateObject("roSGNode", "Timer")
    m.duration = 0.25
    m.timer.repeat = true
    m.timer.observeField("fire", "timerFired")

    'm.timer.control = "start"

    m.positionLabel = m.top.findNode("label_pos")
    m.position = 0

    m.timeManager = CreateObject("roDateTime")
end sub

sub updatePositionLabel()
    m.timeManager.FromSeconds(m.top.position)
    m.positionLabel.text = StrI(m.timeManager.getMinutes()) + ":" + StrI(m.timeManager.getSeconds())
end sub

sub timerFired()
    if m.top.playbackMode = "fastforward" then
        m.position += 4
    else m.position -= 4
    end if
    m.timeManager.FromSeconds(m.position)
    m.positionLabel.text = StrI(m.timeManager.getMinutes()) + ":" + StrI(m.timeManager.getSeconds())
end sub

sub changeButton(key as String)
    'TODO figure out non-brute-force way
    if key = "left" then
        if m.pause.hasfocus() then
            m.pause.uri = "pkg:/images/pause.png"
            m.pause.setFocus(false)
            m.rewind.uri = "pkg:/images/rewind_focused.png"
            m.rewind.setFocus(true)
        else if m.ff.hasfocus() then
            m.ff.uri = "pkg:/images/ff.png"
            m.ff.setFocus(false)
            m.pause.uri = "pkg:/images/pause_focused.png"
            m.pause.setFocus(true)
        end if
    else 
        if m.rewind.hasfocus() then
            m.rewind.uri = "pkg:/images/rewind.png"
            m.rewind.setFocus(false)
            m.pause.uri = "pkg:/images/pause_focused.png"
            m.pause.setFocus(true)
        else if m.pause.hasfocus() then
            m.pause.uri = "pkg:/images/pause.png"
            m.pause.setFocus(false)
            m.ff.uri = "pkg:/images/ff_focused.png"
            m.ff.setFocus(true)
        end if
    end if
end sub

sub handleButtonPress()
    if m.pause.hasfocus() then
        'm.top.playbackMode = "normal"
        'm.timer.control = "stop"
        if m.top.state = "paused"
        m.top.control = "resume"
        else m.top.control = "pause"
        end if
    else if m.ff.hasfocus() then
        m.top.playbackMode = "fastforward"
    else m.top.playbackMode = "rewind"
    end if
end sub

sub handlePlaybackMode()
    if m.top.playbackMode = "normal" then
        m.top.control = "resume"
    else
        m.position = m.top.position
        m.top.control = "pause"
        m.timer.control = "start"
    end if
end sub


function onKeyEvent(key as String, press as Boolean) as Boolean
    if (key = "left" or key = "right") and press then
        changeButton(key)
        return true
    end if

    if key = "back" and m.overlay.visible and m.top.playbackMode = "normal" and press then
        m.top.setFocus(true)
        m.overlay.visible = false
        return true
    end if

    if key = "OK" and press then
        if m.top.playbackMode = "normal"
            if m.overlay.visible then
                handleButtonPress()
            else 
                m.overlay.visible = true
                m.pause.uri = "pkg:/images/pause_focused.png"
                m.pause.setFocus(true)
            end if
        else 
            m.top.seek = m.position
            m.timer.control = "stop"
            m.top.playbackMode = "normal"
            m.top.control = "resume"
        end if
        return true
    end if

    return false
end function