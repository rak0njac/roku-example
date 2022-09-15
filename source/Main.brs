sub Main()
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)

    scene = screen.CreateScene("MainScene")
    screen.show()

    gl = screen.getGlobalNode()

    gl.addField("appExit", "boolean", true)
    gl.observeField("appExit", m.port)

    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        print msgType
        if msgType = "roSGScreenEvent" then
          if msg.isScreenClosed() then
            return
          end if
        else if msgType = "roSGNodeEvent" then
            field = msg.getField()
            print field
            if field = "appExit" then
              return
            end if
        end if
      end while
    end sub
