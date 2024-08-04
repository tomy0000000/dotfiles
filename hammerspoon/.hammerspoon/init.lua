-- Credits:
-- https://github.com/zzamboni/dot-hammerspoon/blob/master/init.lua

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
require('auto_ime')

-- Hotkeys
require('hotkeys')

-- Menu tasks
require('menu_tasks')

