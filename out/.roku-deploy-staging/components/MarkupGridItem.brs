sub init()
    m.itemPoster = m.top.findNode("itemPoster") 
    m.itemMask = m.top.findNode("itemMask")

    m.title = m.top.findNode("mgiTitle")
    m.genre = m.top.findNode("mgiGenre")
    m.year = m.top.findNode("mgiYear")
end sub

sub showcontent()
  m.itemposter.uri = m.top.itemContent.fhdposterurl
  m.title.text = m.top.itemContent.title
  m.genre.text = m.top.itemContent.categories.join(", ")
  m.year.text = m.top.itemContent.releasedate
end sub

sub showfocus()
  m.itemmask.opacity = 0.75 - (m.top.focusPercent * 0.75)
end sub

sub handlefocus()
  if m.top.itemHasFocus = true then
    m.title.scrollspeed = 100
    m.genre.scrollspeed = 100
  else
    m.title.scrollspeed = 0
    m.genre.scrollspeed = 0
  endif
end sub