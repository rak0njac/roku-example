sub init()
    m.top.visible = false

    m.top.observeField("content", "playVideo")
    
end sub

sub playVideo()
    print m.top.content.url
    m.top.control = "play"
end sub