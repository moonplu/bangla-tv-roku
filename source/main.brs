'********** Copyright 2016 Roku Corp.  All Rights Reserved. **********

sub Main()
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)

    ' M3U Playlist URL
    m.playlistUrl = "https://raw.githubusercontent.com/moonplu/me/refs/heads/main/index.m3u"

    m.global = screen.getGlobalNode()
    m.global.addField("Model", "int", true)
    m.global.Model = 0

    dev = createObject("roDeviceInfo")
    model = (Left(dev.GetModel(), 1)).toInt()
    if model < 4
        m.global.Model = 1
    end if

    scene = screen.CreateScene("HomeScene")
    screen.show()

    m.Video = scene.findNode("Video")
    playContent()

    while (true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            print msg
            if msg.isScreenClosed() then return
        end if
    end while
end sub

Sub playContent()
    ' Set the M3U playlist URL
    m.Video.content.uri = m.playlistUrl 
    m.Video.visible = true
    m.Video.control = "play"
End Sub
