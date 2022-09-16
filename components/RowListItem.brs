sub init()
  m.isFavorite = m.top.findNode("isFavorite")

  m.itemposter = m.top.findNode("itemPoster") 
  m.itemmask = m.top.findNode("itemMask")

  m.title = m.top.findNode("mgiTitle")
  m.genre = m.top.findNode("mgiGenre")
  m.year = m.top.findNode("mgiYear")

  m.title.scrollspeed = 0
  m.genre.scrollspeed = 0
end sub

sub showcontent()
  m.isFavorite.visible = m.top.itemContent.isFavorite
  m.itemposter.uri = m.top.itemContent.fhdposterurl
  m.title.text = m.top.itemContent.title
  m.genre.text = m.top.itemContent.categories.join(", ")
  m.year.text = m.top.itemContent.releasedate
end sub

sub showfocus()
  scale = 1 + (m.top.focusPercent * 0.08)
  m.itemposter.scale = [scale, scale]
  m.title.translation = [10, 380 + m.top.focusPercent * 20]
  m.genre.translation = [10, 425 + m.top.focusPercent * 20]
  m.year.translation = [10, 455 + m.top.focusPercent * 20]
end sub
sub showrowfocus()
  scale = 1 + (m.top.rowfocusPercent * 0.08)
  m.itemposter.scale = [scale, scale]
  m.title.translation = [10, 380 + m.top.rowfocusPercent * 20]
  m.genre.translation = [10, 425 + m.top.rowfocusPercent * 20]
  m.year.translation = [10, 455 + m.top.rowfocusPercent * 20]
  m.itemmask.opacity = 0.75 - (m.top.rowFocusPercent * 0.75)
end sub

sub handlefocus()
  if m.top.itemHasFocus = true then
    m.title.color = "0x000000FF"
    m.genre.color = "0x000000FF"
    m.year.color = "0x000000FF"
    m.title.repeatCount = 10
    m.title.scrollspeed = 100
    m.genre.repeatCount = 10
    m.genre.scrollspeed = 100
  else
    m.title.color = "0x888888FF"
    m.genre.color = "0x888888FF"
    m.year.color = "0x888888FF"
    m.title.repeatCount = 0
    m.title.scrollspeed = 0
    m.genre.repeatCount = 0
    m.genre.scrollspeed = 0
  endif
end sub