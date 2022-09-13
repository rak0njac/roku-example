sub init()
    m.top.observeField("visible", "showDetails")

    m.video = m.top.findNode("local_video")
    m.video.observeField("content", "playVideo")

    'button logic
    m.play = m.top.findNode("bp")
    'm.playText = m.top.findNode("bp_label")
    m.fs = m.top.findNode("bfs")

    m.play.observeField("buttonSelected", "handleBtnPress")
    m.fs.observeField("buttonSelected", "handleBtnPress")

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
            "fontUri": "font:SmallSystemFont"
            "color": "#8A2BE2FF"
        }
        "default":{
            "fontUri": "font:SmallSystemFont"
            "color": "#FFFFFFFF"
        }
    }

    m.lb_general_details.drawingStyles = drawingStyles
    m.lb_directed_by.drawingStyles = drawingStyles
    m.lb_lower_cast.drawingStyles = drawingStyles
    m.lb_lower_genres.drawingStyles = drawingStyles
    m.lb_lower_directors.drawingStyles = drawingStyles

endsub

sub showDetails()
    if m.top.visible then
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
        m.play.setFocus(true)
    end if
end sub

sub handleBackPress()
    if m.top.isVideoFullScreen then
        m.top.isVideoFullScreen = false
        m.video.width = 370
        m.video.height = 208
        m.video.translation = [850, 450]
        m.fs.setFocus(true)
    else
        m.video.content = invalid
        m.global.grid.setFocus(true)
        m.top.visible = false
    end if
end sub

sub playVideo()
    if m.video.content <> invalid then
        print m.video.content.url
        m.video.control = "play"
    else m.video.control = "stop"
    end if
end sub

sub handleBtnPress()
    if m.play.hasFocus() then
        if m.video.state = "paused" then
            m.video.control = "resume"
        else if m.video.state = "playing" or m.video.state = "buffering"
            m.video.control = "pause"
        else
            m.video.content = m.top.content
        end if
    else if m.fs.hasfocus() then
        m.top.isVideoFullScreen = true
        m.video.width = 1280
        m.video.height = 720
        m.video.translation = [0,0]
        m.video.setFocus(true)
    else 
        'addFavoriteToRegistry(m.top.content.id)
    endif
end sub

' sub addFavoriteToRegistry(movieId as dynamic)
'     reg = CreateObject("roRegistrySection", "General")
'     assocFavorites = createObject("roAssociativeArray")

'     if reg.Exists("Favorites") then
'         favorites = reg.Read("Favorites")
'         favorites = favorites.Split(", ")
'     else
'         favorites = createObject("roArray", 1, false)
'     endif

'     favorite = movieId

'     for each entry in favorites
'         assocFavorites[entry] = true
'     end for

'     if m.top.content.isFavorite then
'         m.top.content.isFavorite = false
'         m.button3content.text = "Add to favorites"
'         assocFavorites.delete(favorite)
'     else 
'         m.top.content.isFavorite = true
'         m.button3content.text = "Remove from favorites"
'         assocFavorites[favorite] = true
'     end if

'     favorites = assocFavorites.Keys()
'     favorites = favorites.Join(", ")
'     reg.Write("Favorites", favorites)
'     reg.Flush()

'     print reg.Read("Favorites")
' end sub


function onKeyEvent(key as String, press as Boolean) as Boolean
    print key
    print m.top.visible
    print press

    if (key = "left" or key = "right") and press then
        changeButton()
        return true
    end if

    if key = "back" and m.top.visible and press then
        handleBackPress()
        return true
    end if

    return false
end function

sub changeButton()
    if m.play.hasfocus() then
        m.play.setFocus(false)
        m.fs.setFocus(true)
    else 
        m.play.setFocus(true)
        m.fs.setFocus(false)
    end if
end sub