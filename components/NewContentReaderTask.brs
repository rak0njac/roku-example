sub init()
  m.top.functionName = "getcontent"
end sub

sub getcontent()
  reg = CreateObject("roRegistrySection", "General")
  assocFavorites = CreateObject("roAssociativeArray")

  if reg.Exists("Favorites") then
      favorites = reg.Read("Favorites")
      favorites = favorites.Split(", ")
  else
      favorites = createObject("roArray", 1, false)
  endif

  for each entry in favorites
    assocFavorites[entry] = true
  end for

  content = CreateObject("roSGNode", "CustomContentNode")

  request = createObject("roUrlTransfer")
  request.SetCertificatesFile("common:/certs/ca-bundle.crt")
  request.InitClientCertificates()
  request.setUrl(m.top.contenturi)
  response = request.GetToString()
  json = parseJson(response)

  for each category in json.categories

    categoryContent = content.createChild("CustomContentNode")
    categoryContent.id = category.id
    categoryContent.title = category.name

    for each channel in json.channels
      if (category.id = channel.categoryid)
        'setup
        channelContent = categoryContent.createChild("CustomContentNode")
        channelContent.id = channel.id
        if channelContent.id = m.top.argsId then
          m.global.addFields({deepLinkedContent: channelContent})
        end if

        channelContent.categoryId = channel.categoryid

        'favorite
        channelContent.isFavorite = assocFavorites.doesExist(channel.id)

        'movies
        channelContent.shortdescriptionline1 = channel.Title
        channelContent.shortdescriptionline2 = channel.Description
        channelContent.FHDPosterURL = channel.PosterURL

        'details
        channelContent.actors = channel.cast
        channelContent.releasedate = channel.year
        channelContent.title = channel.title
        channelContent.categories = channel.genres
        channelContent.length = channel.length
        channelContent.directors = channel.director
        channelContent.Description = channel.Description
        channelContent.rating = channel.parentalrating
        channelContent.HDBackgroundImageUrl = channel.backgroundimageurl

        'video
        channelContent.url = channel.url
        channelContent.streamformat = channel.streamformat
      end if
    end for

  end for

  m.top.content = content
end sub
