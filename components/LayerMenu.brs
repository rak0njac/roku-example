sub init() 
    m.grid = m.top.findNode("lGrid")
    m.details = m.top.findNode("details")
    m.grid.setFocus(true)
    m.descText = m.top.findNode("lbTopDesc")
    m.buttonGrp = m.top.findNode("btnGroup")

    m.buttongrp.buttons = ["Play", "Close"]

    m.grid.observeField("itemSelected", "showDetails")
    m.grid.observeField("itemFocused", "changeTopDescText")
end sub

sub changeTopDescText()
    if m.grid.content <> invalid then
        
        contentChild = m.grid.content.getChild(m.grid.itemFocused)
        m.desctext.text = contentChild.description
    end if
end sub

sub showDetails()
    
    m.buttongrp.setFocus(true)
    contentChild = m.grid.content.getChild(m.grid.itemSelected)
    m.vidurl = contentChild.url
    m.details.findNode("imgPoster").uri = contentChild.FHDPosterURL
    m.details.findNode("lbCast").text = "Cast: " + contentChild.actors.Join(", ")
    m.details.findNode("lbYear").text = "Year: " + contentChild.releasedate
    m.details.findNode("lbTitle").text = "Title: " + contentChild.title
    m.details.findNode("lbGenres").text = "Genres: " + contentChild.categories.Join(", ")
    m.details.findNode("lbLength").text = "Length: " + str(contentChild.length)
    m.details.findNode("lbDirector").text = "Director: " + contentChild.directors.Join(", ")
    m.details.findNode("lbRating").text = "Parental Rating: " + contentChild.rating
    m.details.findNode("lbDescription").text = "Description: " + contentChild.description
    m.details.visible = true
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false
  
    if key = "back" and press then
        m.grid.setFocus(true)
      m.details.visible = false
      handled = true
    end if
  
    return handled
end function
