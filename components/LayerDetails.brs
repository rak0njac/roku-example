sub init()
    m.top.observeField("visible", "showDetails")

    'animation logic
    m.animationIn = m.top.findNode("animation_fly_in")
    m.animationOut = m.top.findNode("animation_fly_out")
    m.animationOut.observeField("state", "hideDetails")

    'video logic
    m.video = m.top.findNode("local_video")
    m.video.observeField("state", "changeplayButtonText")

    'button logic
    m.playBtn = m.top.findNode("bp")
    m.playBtnText = m.top.findNode("lb_bp")
    m.playBtnIcon = m.top.findNode("icon_bp")
    m.fsBtn = m.top.findNode("bfs")
    m.favBtn = m.top.findNode("batf")
    m.favBtnText = m.top.findNode("lb_batf")

    m.playBtn.observeField("buttonSelected", "handleBtnPress")
    m.fsBtn.observeField("buttonSelected", "handleBtnPress")
    m.favBtn.observeField("buttonSelected", "handleBtnPress")

    'classic labels
    m.img_bkg = m.top.findNode("bkg")
    m.lb_cast = m.top.findNode("cast")
    m.lb_title = m.top.findNode("title")
    m.lb_description = m.top.findNode("description")

    'multi style labels
    m.lb_general_details = m.top.findNode("general_details")
    m.lb_directed_by = m.top.findNode("directed_by")
    m.lb_lower_cast = m.top.findNode("lower_cast")
    m.lb_lower_genres = m.top.findNode("lower_genres")
    m.lb_lower_directors = m.top.findNode("lower_directors")

    drawingStyles = {
        "purple":{
            "fontUri": "pkg:/fonts/OpenSans-Regular.ttf"
            "fontSize" : 15
            "color": "#8A2BE2FF"
        }
        "default":{
            "fontUri": "pkg:/fonts/OpenSans-Regular.ttf"
            "fontSize" : 15
            "color": "#8A8A8AFF"
        }
    }

    drawingStylesSmall = {
        "purple":{
            "fontUri": "pkg:/fonts/OpenSans-Light.ttf"
            "fontSize" : 12
            "color": "#8A2BE2FF"
        }
        "default":{
            "fontUri": "pkg:/fonts/OpenSans-Light.ttf"
            "fontSize" : 12
            "color": "#8A8A8AFF"
        }
    }

    m.lb_general_details.drawingStyles = drawingStyles
    m.lb_directed_by.drawingStyles = drawingStyles
    m.lb_lower_cast.drawingStyles = drawingStylesSmall
    m.lb_lower_genres.drawingStyles = drawingStylesSmall
    m.lb_lower_directors.drawingStyles = drawingStylesSmall

endsub

sub hideDetails()
    if m.animationOut.state = "stopped" then
        m.video.content = invalid
        m.video.control = "stop"
        m.global.grid.setFocus(true)
        m.top.visible = false
    end if
end sub

sub showDetails()
    if m.top.visible then
        if m.top.content.isFavorite then
            m.favBtnText.text = "Remove From Favorites"
        else
            m.favBtnText.text = "Add To Favorites"
        end if

        m.img_bkg.uri = m.top.content.HDBackgroundImageURL
        m.lb_cast.text = m.top.content.actors.Join(", ")
        m.lb_title.text = m.top.content.title
        m.lb_directed_by.text = "Directed by: <purple>" + m.top.content.directors.Join(", ") + "</purple>"
        m.lb_description.text = m.top.content.description

        year = m.top.content.releasedate
        length = str(m.top.content.length)
        genres = m.top.content.categories.Join(" | ")
        rating = m.top.content.rating

        m.lb_general_details.text = year + " | " + rating + " | " + length + " | <purple>" + genres + "</purple>"
        m.lb_lower_cast.text = "Cast: <purple>" + m.top.content.actors.Join(", ") + "</purple>"
        m.lb_lower_genres.text = "Genres: <purple>" + m.top.content.categories.Join(", ") + "</purple>"
        m.lb_lower_directors.text = "Directors: <purple>" + m.top.content.directors.Join(", ") + "</purple>"
        m.playBtn.setFocus(true)

        m.animationIn.control = "start"
    end if
end sub

sub handleBackPress()
    if m.top.isVideoFullScreen then
        m.top.isVideoFullScreen = false
        m.video.width = 370
        m.video.height = 208
        m.video.translation = [850, 450]
        m.fsBtn.setFocus(true)
    else
        m.animationOut.control = "start"
    end if
end sub

sub changeplayButtonText()
    if m.video.state = "playing" or m.video.state = "buffering"
        m.playBtnText.text = "Pause"
        m.playBtnIcon.uri = "pkg:/images/pause.png"
    else if m.video.state = "finished"
        m.playBtnText.text = "Replay"
        m.playBtnIcon.uri = "pkg:/images/replay.png"
    else 
        m.playBtnText.text = "Play"
        m.playBtnIcon.uri = "pkg:/images/icon_play.png"
    end if
end sub

sub assignVideoContent(content as dynamic)   'prevents video playback from stopping when adding/removing movie from favorites
    newContent = CreateObject("RoSGNode", "CustomContentNode")
    newContent.url = content.url
    newContent.streamformat = content.streamformat
    m.video.content = newContent
end sub

sub handleBtnPress()
    'mb change hasFocus() to buttonSelected but it works...
    'playBtn button
    if m.playBtn.hasFocus() then
        if m.video.state = "paused" then
            m.video.control = "resume"
        else if m.video.state = "playing"
            m.video.control = "pause"
        else if m.video.state = "finished"
            m.video.seek = 0
            m.video.control = "replay"
        else
            'm.video.content = m.top.content
            assignVideoContent(m.top.content)
            m.video.control = "play"
        end if

    'go to full screen button
    else if m.fsBtn.hasfocus() then
        m.top.isVideoFullScreen = true
        m.video.width = 1280
        m.video.height = 720
        m.video.translation = [0,0]
        m.video.setFocus(true)

    'favorites button
    else 
        addFavoriteToRegistry(m.top.content.id)
    endif
end sub

sub addFavoriteToRegistry(movieId as dynamic)
    reg = CreateObject("roRegistrySection", "General")
    assocFavorites = createObject("roAssociativeArray")

    if reg.Exists("Favorites") then
        favorites = reg.Read("Favorites")
        favorites = favorites.Split(", ")
    else
        favorites = createObject("roArray", 1, false)
    endif

    favorite = movieId

    for each entry in favorites
        assocFavorites[entry] = true
    end for

    if m.top.content.isFavorite then
        m.top.content.isFavorite = false
        m.favBtnText.text = "Add To Favorites"
        assocFavorites.delete(favorite)
    else 
        m.top.content.isFavorite = true
        m.favBtnText.text = "Remove From Favorites"
        assocFavorites[favorite] = true
    end if

    favorites = assocFavorites.Keys()
    favorites = favorites.Join(", ")
    reg.Write("Favorites", favorites)
    reg.Flush()

    print reg.Read("Favorites")
end sub


function onKeyEvent(key as String, press as Boolean) as Boolean
    if (key = "left" or key = "right") and press then
        changeButton(key)
        return true
    end if

    if key = "back" and m.top.visible and press then
        handleBackPress()
        return true
    end if

    return false
end function

sub changeButton(key as String)
    'TODO figure out non-brute-force way
    if key = "left" then
        if m.playBtn.hasfocus() then
            m.playBtn.setFocus(false)
            m.favBtn.setFocus(true)
        else if m.fsBtn.hasfocus() then
            m.fsBtn.setFocus(false)
            m.playBtn.setFocus(true)
        else 
            m.favBtn.setFocus(false)
            m.fsBtn.setFocus(true)
        end if
    else 
        if m.playBtn.hasfocus() then
            m.playBtn.setFocus(false)
            m.fsBtn.setFocus(true)
        else if m.fsBtn.hasfocus() then
            m.fsBtn.setFocus(false)
            m.favBtn.setFocus(true)
        else 
            m.favBtn.setFocus(false)
            m.playBtn.setFocus(true)
        end if
    end if
end sub