sub init()
    m.top.visible = false

    m.top.observeField("content", "playVideo")
    
end sub

sub playVideo()
    if m.top.content <> invalid then
        print m.top.content.url
        m.top.control = "play"
    end if
end sub