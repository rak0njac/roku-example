sub init() 
    m.top.setFocus(true)

    m.top.basePosterSize = [ 150, 229 ]
    m.top.caption1NumLines = 1
    m.top.numColumns = 6
    m.top.numRows = 2
    m.top.itemSpacing = [ 20, 20 ]
    m.top.translation = [50, 50]

    m.readPosterGridTask = createObject("roSGNode", "ContentReader")
    m.readPosterGridTask.contenturi = "https://api.npoint.io/b096a65d709fbe682348"
    m.readPosterGridTask.observeField("content", "showpostergrid")
    m.readPosterGridTask.control = "RUN"
end sub

sub showpostergrid()
    m.top.content = m.readPosterGridTask.content
end sub