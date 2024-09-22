require "set_program"

-- midiChannel = 0
-- cc = 4
-- ccValue = 0
-- reaper.StuffMIDIMessage(0, 0xC0 + string.format("%x", midiChannel), cc, ccValue)
reaper.SetExtState("ProgramChanger", "KeyDownTime", reaper.time_precise(), true)


-- get current and other preset

local presetString = reaper.GetExtState("ProgramChanger", "Preset")
local currentPreset = tonumber(presetString)
if currentPreset == nil then
    currentPreset = 1
end

local otherPresetString = reaper.GetExtState("ProgramChanger", "OtherPreset")
local otherPreset = tonumber(otherPresetString)
if otherPreset == nil then
    otherPreset = 2
end

-- swap them

local presetsNumber = 6
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
    reaper.ShowMessageBox(0, "DEBUG", 0)
end
if otherPreset == 0 then
    if newPreset == 1 then
        otherPreset = 2
    else
        otherPreset = 1
    end
    reaper.ShowMessageBox(1, "DEBUG", 0)
end

-- reaper.ShowMessageBox(newPreset, "DEBUG", 0)

reaper.SetExtState("ProgramChanger", "OtherPreset", newPreset, true)
newPreset = otherPreset
reaper.SetExtState("ProgramChanger", "Preset", newPreset, true)

setProgram(newPreset)