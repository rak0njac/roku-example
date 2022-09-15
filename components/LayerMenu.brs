sub init() 
    m.grid = m.top.findNode("lGrid")
    m.search = m.top.findNode("search")
    m.searchPlaceholder = m.top.findNode("search_placeholder")
    m.noResults = m.top.findNode("no_results")
    m.KbExpandAnim = m.top.findNode("animation_expand_keyboard")
    m.KbShrinkAnim = m.top.findNode("animation_shrink_keyboard")

    'm.grid.setFocus(true)
    m.descText = m.top.findNode("lbTopDesc")
    m.titleText = m.top.findNode("lbTopTitle")

    m.grid.observeField("rowItemSelected", "showDetails")
    m.grid.observeField("rowItemFocused", "changeTopDescText")
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
            rowChild = m.global.content.getChild(i)
            newRowChild = newContent.createChild("CustomContentNode")
            newRowChild.title = rowChild.title
            for j = 0 to rowChild.getChildCount() - 1
                movieChild = rowChild.getChild(j)
                if not lCase(movieChild.title).InStr(lCase(m.search.text)) then
                    'copy everything manually since there are no deep copy constructors in brs.. let me know if there's a better way
                    newMovieChild = newRowChild.createChild("CustomContentNode")
                    newMovieChild.id = movieChild.id
                    newMovieChild.isFavorite = movieChild.isFavorite
                    newMovieChild.shortdescriptionline1 = movieChild.shortdescriptionline1
                    newMovieChild.shortdescriptionline2 = movieChild.shortdescriptionline2
                    newMovieChild.FHDPosterURL = movieChild.FHDPosterURL
                    newMovieChild.actors = movieChild.actors
                    newMovieChild.releasedate = movieChild.releasedate
                    newMovieChild.title = movieChild.title
                    newMovieChild.categories = movieChild.categories
                    newMovieChild.length = movieChild.length
                    newMovieChild.directors = movieChild.directors
                    newMovieChild.Description = movieChild.Description
                    newMovieChild.rating = movieChild.rating
                    newMovieChild.HDBackgroundImageUrl = movieChild.HDBackgroundImageUrl
                    newMovieChild.url = movieChild.url
                    newMovieChild.streamformat = movieChild.streamformat
                end if
            end for
        end for
        m.grid.content = newContent
end sub

sub changeTopDescText()
    row = m.grid.rowItemFocused.getEntry(0)
    movie = m.grid.rowItemFocused.getEntry(1)
    contentChild = m.grid.content.getChild(row).getChild(movie)
    m.desctext.text = contentChild.description
    m.titleText.text = contentChild.title
end sub

sub showDetails()
    row = m.grid.rowItemSelected.getEntry(0)
    movie = m.grid.rowItemSelected.getEntry(1)
    m.contentChild = m.grid.content.getChild(row).getChild(movie)
    m.global.details.content = m.contentChild
    m.global.details.visible = true
end sub

sub showKeyboard(show as boolean)
if show then
    m.KbExpandAnim.control = "start"
    m.searchPlaceholder.visible = false
    m.search.setFocus(true)
else
    m.KbShrinkAnim.control = "start"
    if m.search.text = "" then
        m.searchPlaceholder.visible = true
    end if
    m.grid.setFocus(true)
end if
end sub

sub showExitDialog()
    m.global.exit.visible = true
    m.global.exit.setFocus(true)
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean


    if key = "options" and press then
        showKeyboard(true)
        return true
    else if key = "back" and press then
         if m.grid.hasFocus() then
            showExitDialog()
         else
            showKeyboard(false)
         end if
        return true
    end if
    return false
end function