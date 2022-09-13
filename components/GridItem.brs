sub init()
    m.isFavorite = m.top.findNode("isFavorite")

    m.itemPoster = m.top.findNode("itemPoster") 
    m.itemMask = m.top.findNode("itemMask")

    m.title = m.top.findNode("mgiTitle")
    m.genre = m.top.findNode("mgiGenre")
    m.year = m.top.findNode("mgiYear")

    m.title.scrollspeed = 0
    m.genre.scrollspeed = 0
end sub

sub showcontent()
  m.top.visible = m.top.itemContent.searchVisible

  m.isFavorite.visible = m.top.itemContent.isFavorite
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
    m.title.repeatCount = 10
    m.title.scrollspeed = 100
    m.genre.repeatCount = 10
    m.genre.scrollspeed = 100
  else
    m.title.repeatCount = 0
    m.title.scrollspeed = 0
    m.genre.repeatCount = 0
    m.genre.scrollspeed = 0
  endif
end sub