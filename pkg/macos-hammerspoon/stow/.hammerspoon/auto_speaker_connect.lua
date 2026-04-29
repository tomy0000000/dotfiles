-- Auto connect to speak when connected to monitor
--
-- Reference: https://www.hammerspoon.org/go/#usbevents

local monitorVendorID = 32903
local speakerBluetoothAddress = "74-ca-60-56-7a-d4"

local BLUEUTIL = "/opt/homebrew/bin/blueutil"

local function usbDeviceCallback(data)
    if data.eventType == "added" and data.vendorID == monitorVendorID then
        -- print("USB event:", hs.inspect(data))
        print("Dell monitor connected, start connecting to speak")
        local ok, out = hs.execute(BLUEUTIL .. " --connect " .. speakerBluetoothAddress)
        if not ok then
            print("Failed to connect to speak:", out)
        else
            print("Successfully connected to speak")
        end
    end
end

UsbWatcher = hs.usb.watcher.new(usbDeviceCallback)
UsbWatcher:start()
