require "set_program"

-- midiChannel = 0
-- cc = 4
-- ccValue = 0
-- reaper.StuffMIDIMessage(0, 0xC0 + string.format("%x", midiChannel), cc, ccValue)
reaper.SetExtState("ProgramChanger", "KeyDownTime", reaper.time_precise(), true)

local currentPreset, otherPreset = getPresetIds()
-- reaper.ShowMessageBox(currentPreset, "DEBUG", 0)

-- swap them

local presetsNumber = 7
local newPreset = currentPreset
if newPreset == otherPreset then
    newPreset = (otherPreset + 1) % presetsNumber
end

-- skip 0 because it's a workaround for reset after playback
if newPreset == 0 then
    if otherPreset == 1 then
        newPreset = 2
    else
        newPreset = 1
    end
end
if otherPreset == 0 then
    if newPreset == 1 then
        otherPreset = 2
    else
        otherPreset = 1
    end
end

-- reaper.ShowMessageBox(newPreset, "DEBUG", 0)
reaper.SetExtState("ProgramChanger", "Live", 1, false)
setProgram(newPreset, true)

