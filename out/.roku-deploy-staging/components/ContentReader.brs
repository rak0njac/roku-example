sub init()
    m.top.functionName = "getcontent"
    m.top.contenttype = "list"
  end sub

  sub getcontent()
    contenttype = m.top.contenttype
    content = createObject("roSGNode", "ContentNode")
    readInternet = createObject("roUrlTransfer")
    readInternet.SetCertificatesFile("common:/certs/ca-bundle.crt")
    readInternet.AddHeader("X-Roku-Reserved-Dev-Id", "")
    readInternet.InitClientCertificates()
    readInternet.setUrl(m.top.contenturi)
    response = parseJson(readInternet.GetToString())
    'print(response)
    responseItems = response.channels
    
    if contenttype = "list"
        for each item in responseItems
            'movies
            itemcontent = content.createChild("ContentNode")
            itemcontent.id = item.id

            
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
            'print(item)
        end for
    else if contenttype = "details"

    end if
    m.top.content = content
  end sub