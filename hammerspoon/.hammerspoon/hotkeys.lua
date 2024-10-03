--- Type clipboard content
hs.hotkey.bind({ "control" }, "v", function()
    for _, c in utf8.codes(hs.pasteboard.getContents()) do
        local char = utf8.char(c)
        if char == "\n" then
            hs.eventtap.keyStroke({}, "return")
        else
            hs.eventtap.keyStrokes(char)
        end
    end
end)

--- Shutdown Hotkey
hs.hotkey.bind({ "control", "option" }, "f12", function()
    hs.caffeinate.shutdownSystem()
end)
hs.hotkey.bind({ "control", "option" }, "end", function()
    hs.caffeinate.shutdownSystem()
end)
hs.hotkey.bind({ "control", "option", "command" }, "end", function()
    hs.caffeinate.shutdownSystem()
end)
