sub init() 
    m.grid = m.top.findNode("lGrid")
    m.search = m.top.findNode("search")
    m.searchPlaceholder = m.top.findNode("search_placeholder")
    m.noResults = m.top.findNode("no_results")

    'm.grid.setFocus(true)
    m.descText = m.top.findNode("lbTopDesc")
    m.titleText = m.top.findNode("lbTopTitle")

    m.grid.observeField("itemSelected", "showDetails")
    m.grid.observeField("itemFocused", "changeTopDescText")
    m.search.observeField("text", "search")
    m.grid.observeField("content", "handleContentChange")
end sub

sub handleContentChange()

    'makes sure that the keyboard doesn't show up before markupgrid content gets filled
    if m.search.visible = false
        m.search.visible = true
    end if

    'handles no search results logic
    if m.grid.content.getChildCount() = 0 then
        m.noResults.visible = true
        m.noResults.text = "No results found for '" + m.search.text + "'"
    else
        m.noResults.visible = false
    end if
end sub

sub search()
        newContent = createObject("roSGNode", "CustomContentNode")
        for i = 0 to m.global.content.getChildCount() - 1
            child = m.global.content.getChild(i)
                if not lCase(child.title).InStr(lCase(m.search.text)) then

                    'copy everything manually since there are no deep copy constructors in brs.. let me know if there's a better way
                    itemcontent = newContent.createChild("CustomContentNode")
                    itemcontent.id = child.id
                    itemcontent.isFavorite = child.isFavorite
                    itemcontent.shortdescriptionline1 = child.shortdescriptionline1
                    itemcontent.shortdescriptionline2 = child.shortdescriptionline2
                    itemcontent.FHDPosterURL = child.FHDPosterURL
                    itemcontent.actors = child.actors
                    itemcontent.releasedate = child.releasedate
                    itemcontent.title = child.title
                    itemcontent.categories = child.categories
                    itemcontent.length = child.length
                    itemcontent.directors = child.directors
                    itemcontent.Description = child.Description
                    itemcontent.rating = child.rating
                    itemcontent.HDBackgroundImageUrl = child.HDBackgroundImageUrl
                    itemcontent.url = child.url
                    itemcontent.streamformat = child.streamformat
                end if
        end for
        m.grid.content = newContent
end sub

sub changeTopDescText()
    if m.grid.content.getChildCount() > 0 then
        
        contentChild = m.grid.content.getChild(m.grid.itemFocused)
        m.desctext.text = contentChild.description
        m.titleText.text = contentChild.title
    end if
end sub

sub showDetails()
    print "showDetails() called..."
        m.contentChild = m.grid.content.getChild(m.grid.itemSelected)
        m.global.details.content = m.contentChild
        m.global.details.visible = true
end sub

sub showKeyboard(show as boolean)
if show then
    m.searchPlaceholder.visible = false
    m.search.clippingRect = [0.0, 0.0, 1280.0, 720.0]
    m.search.setFocus(true)
    m.grid.translation = [50,500]
else
    if m.search.text = "" then
        m.searchPlaceholder.visible = true
    end if
    m.search.clippingRect = [0.0, 0.0, 1280.0, 60.0]    'show only top 60px of keyboard node so the user can see only the textbox
    m.grid.setFocus(true)
    m.grid.translation = [50,300]
end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean


    if key = "options" and press then
        showKeyboard(true)
        return true
    else if key = "back" and m.search.visible and press then
        showKeyboard(false)
        return true
    end if
    return false
end function