-- Print timestamp for debugging
print("Loading init.lua at " .. os.date("%Y-%m-%d %H:%M:%S"))

-- Load SpoonInstall to install other spoons
hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true
Install = spoon.SpoonInstall

-- Setup EmmlyLua for Lua code completion
Install:andUse("EmmyLua")

-- Auto reload config
Install:andUse("ReloadConfiguration")
spoon.ReloadConfiguration.watch_paths = { hs.configdir, "~/.dotfiles/hammerspoon/.hammerspoon" }
spoon.ReloadConfiguration:start()

-- Auto switch input method
require('AutoIME')

--- Type clipboard content
hs.hotkey.bind({ "control" }, "v", function()
    hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)

--- Shutdown Hotkey
hs.hotkey.bind({ "control", "option" }, "f12", function()
    hs.execute("shutdown -h now")
end)
hs.hotkey.bind({ "control", "option" }, "end", function()
    hs.execute("shutdown -h now")
end)
