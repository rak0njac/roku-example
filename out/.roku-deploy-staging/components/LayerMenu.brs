sub init() 
    m.grid = m.top.findNode("lGrid")
    m.details = m.top.findNode("details")
    m.grid.setFocus(true)
    m.descText = m.top.findNode("lbTopDesc")
    m.titleText = m.top.findNode("lbTopTitle")
    m.btngrid = m.details.findNode("buttons")

    m.grid.observeField("itemSelected", "showDetails")
    m.grid.observeField("itemFocused", "changeTopDescText")
    m.btngrid.observeField("itemSelected", "handleBtnPress")

    m.btncontent = createObject("roSGNode", "ContentNode")
    m.button1content = m.btncontent.createChild("ContentNode")
    m.button2content = m.btncontent.createChild("ContentNode")

    m.button1content.text = "Play"
    m.button2content.text = "Close"

    m.btngrid.content = m.btncontent
end sub

sub handleBtnPress()
    if m.btngrid.itemSelected = 0 then
        m.top.visible = false

        video = m.global.video
        video.content = m.contentChild
    else
        m.details.visible = false
        m.grid.setFocus(true)
    endif
end sub

sub changeTopDescText()
    if m.grid.content <> invalid then
        
        contentChild = m.grid.content.getChild(m.grid.itemFocused)
        m.desctext.text = contentChild.description
        m.titleText.text = contentChild.title
    end if
end sub

sub showDetails()
    m.btngrid.setFocus(true)
    m.contentChild = m.grid.content.getChild(m.grid.itemSelected)
    m.vidurl = m.contentChild.url
    m.details.findNode("imgPoster").uri = m.contentChild.FHDPosterURL
    m.details.findNode("lbCast").text = "Cast: " + m.contentChild.actors.Join(", ")
    m.details.findNode("lbYear").text = "Year: " + m.contentChild.releasedate
    m.details.findNode("lbTitle").text = "Title: " + m.contentChild.title
    m.details.findNode("lbGenres").text = "Genres: " + m.contentChild.categories.Join(", ")
    m.details.findNode("lbLength").text = "Length: " + str(m.contentChild.length)
    m.details.findNode("lbDirector").text = "Director: " + m.contentChild.directors.Join(", ")
    m.details.findNode("lbRating").text = "Parental Rating: " + m.contentChild.rating
    m.details.findNode("lbDescription").text = "Description: " + m.contentChild.description
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
