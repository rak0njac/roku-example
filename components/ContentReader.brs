sub init()
  m.top.functionName = "getcontent"
end sub

sub getcontent()
  content = createObject("roSGNode", "ContentNode")
  request = createObject("roUrlTransfer")
  request.SetCertificatesFile("common:/certs/ca-bundle.crt")
  request.InitClientCertificates()
  request.setUrl(m.top.contenturi)
  response = request.GetToString()
  json = parseJson(response)

    for each item in json.channels
      'setup
      itemcontent = content.createChild("ContentNode")
      itemcontent.id = item.id

      'movies
      itemcontent.shortdescriptionline1 = item.Title
      itemcontent.shortdescriptionline2 = item.Description
      itemcontent.FHDPosterURL = item.PosterURL

      'details
      itemcontent.actors = item.cast
      itemcontent.releasedate = item.year
      itemcontent.title = item.title
      itemcontent.categories = item.genres
      itemcontent.length = item.length
      itemcontent.directors = item.director
      itemcontent.Description = item.Description
      itemcontent.rating = item.parentalrating
      itemcontent.HDBackgroundImageUrl = item.backgroundimageurl

      'video
      itemcontent.url = item.url
      itemcontent.streamformat = item.streamformat
    end for
  m.top.content = content
end sub
