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
    currentPreset = 0
end

local otherPresetString = reaper.GetExtState("ProgramChanger", "OtherPreset")
local otherPreset = tonumber(otherPresetString)
if otherPreset == nil then
    otherPreset = 1
end

-- swap them

local presetsNumber = 6
local newPreset = currentPreset
if newPreset == otherPreset then
    newPreset = (otherPreset + 1) % presetsNumber
end
reaper.SetExtState("ProgramChanger", "OtherPreset", newPreset, true)
newPreset = otherPreset
reaper.SetExtState("ProgramChanger", "Preset", newPreset, true)

setProgram(newPreset)