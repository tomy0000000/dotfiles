hs.application.watcher.new(function(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        ABC_APPS = { "Code", "Finder", "GitHub", "Grammarly", "iTerm2", "LeetCode", "Sublime Text", "Termius", "Tower",
            "Xcode" }
        SHUANGPIN_APPS = {}

        if (hs.fnutils.contains(ABC_APPS, appName)) then
            hs.console.printStyledtext("Switching to ABC for ", appName)
            hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
        elseif (hs.fnutils.contains(SHUANGPIN_APPS, appName)) then
            hs.console.printStyledtext("Switching to Shuangpin for ", appName)
            hs.keycodes.currentSourceID("com.apple.inputmethod.TCIM.Shuangpin")
        elseif (appName == "LINE") then
            if (hs.window.focusedWindow():title() == "LINE") then
                -- Change input method to ShuangPin
                hs.console.printStyledtext("Switching to Shuangpin for ", appName)
                hs.keycodes.currentSourceID("com.apple.inputmethod.TCIM.Shuangpin")
            else
                -- Change input method to English
                hs.console.printStyledtext("Switching to ABC for ", appName)
                hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
            end
        end
    end
end):start()
