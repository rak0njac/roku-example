sub init()
    m.top.observeField("focusedChild", "handleFocus")
    m.top.observeField("visible", "showDetails")

    m.play = m.top.findNode("bp")
    m.fs = m.top.findNode("bfs")
    'm.play.setFocus(true)

    m.play.observeField("buttonSelected", "handleBtnPress")
    m.fs.observeField("buttonSelected", "handleBtnPress")

    font  = CreateObject("roSGNode", "Font")
    font.uri = "pkg:/fonts/OpenSans-Bold.ttf"
    font.size = 24

    titlelabel = m.top.findNode("title")
    titlelabel.font = font
endsub

sub showDetails()
    if m.top.visible then
        m.top.findNode("bkg").uri = m.top.content.FHDPosterURL
        m.top.findNode("cast").text = m.top.content.actors.Join(", ")
        m.top.findNode("title").text = m.top.content.title
        m.top.findNode("directed_by").text = "Directed by: " + m.top.content.directors.Join(", ")
        m.top.findNode("description").text = m.top.content.description

        year = m.top.content.releasedate
        length = str(m.top.content.length)
        genres = m.top.content.categories.Join(" | ")
        rating = m.top.content.rating

        m.top.findNode("general_details").text = year + " | " + rating + " | " + length + " | " + genres
        m.play.setFocus(true)
    end if
end sub

sub hideDetails()
    m.global.grid.setFocus(true)
    m.top.visible = false
end sub

sub handleBtnPress()
    if m.play.hasFocus() then
        video = m.global.video
        video.content = m.top.content
    else if m.fs.hasfocus() then
        hideDetails()
    else 
        'addFavoriteToRegistry(m.top.content.id)
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
        m.button3content.text = "Add to favorites"
        assocFavorites.delete(favorite)
    else 
        m.top.content.isFavorite = true
        m.button3content.text = "Remove from favorites"
        assocFavorites[favorite] = true
    end if

    favorites = assocFavorites.Keys()
    favorites = favorites.Join(", ")
    reg.Write("Favorites", favorites)
    reg.Flush()

    print reg.Read("Favorites")
end sub


function onKeyEvent(key as String, press as Boolean) as Boolean
    print key
    print m.top.visible
    print press

    if (key = "left" or key = "right") and press then
        changeButton()
        return true
    end if

    if key = "back" and m.top.visible then
        hideDetails()
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