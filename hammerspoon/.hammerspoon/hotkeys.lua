--- Type clipboard content
hs.hotkey.bind({ "control" }, "v", function()
    hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)

--- Shutdown Hotkey
hs.hotkey.bind({ "control", "option" }, "f12", function()
    hs.caffeinate.shutdownSystem()
end)
hs.hotkey.bind({ "control", "option" }, "end", function()
    hs.caffeinate.shutdownSystem()
end)
