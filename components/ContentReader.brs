sub init()
    m.top.functionName = "getcontent"
  end sub

  sub getcontent()
    content = createObject("roSGNode", "ContentNode")
    readInternet = createObject("roUrlTransfer")
    readInternet.setUrl(m.top.contenturi)
    response = parseJson(readInternet.GetToString())
    responseItems = response.Search
    
    for each item in responseItems
        itemcontent = content.createChild("ContentNode")
        itemcontent.Title = item.Title
        itemcontent.ContentType = item.Type
        itemcontent.ReleaseDate = "1/1/" + item.Year
        itemcontent.shortdescriptionline1 = item.Title
        itemcontent.FHDPosterURL = item.Poster
        print(item)
    end for
    m.top.content = content
  end sub