
-- reaper.StuffMIDIMessage(0, 0xC1 + string.format("%x", 0), 0, 0)

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

local presetsNumber = 6

local keyDownTime = reaper.GetExtState("ProgramChanger", "KeyDownTime")
local keyUpTime = reaper.time_precise()
local newPreset = 0
if keyUpTime - keyDownTime > 1 then
    newPreset = (currentPreset + 1) % presetsNumber
    if (newPreset == otherPreset) then
        newPreset = (newPreset + 1) % presetsNumber
    end
    -- reaper.StuffMIDIMessage(0, 0xC0 + string.format("%x", 0), newPreset, 1)
    -- reaper.StuffMIDIMessage(0, 0xC0 + string.format("%x", 0), otherPreset, 1)
else
    newPreset = currentPreset
    if newPreset == otherPreset then
        newPreset = (otherPreset + 1) % presetsNumber
    end

    reaper.SetExtState("ProgramChanger", "OtherPreset", newPreset, true)
    newPreset = otherPreset
end

reaper.SetExtState("ProgramChanger", "Preset", newPreset, true)

-- local track = reaper.GetTrack(0, 1)
-- if newPreset == 0 then
--     reaper.SetTrackColor(track, 190)
-- elseif newPreset == 1 then
--     reaper.SetTrackColor(track, 13121335)
-- elseif newPreset == 2 then
--     reaper.SetTrackColor(track, 7935340)
-- end

-- pc channel 4
-- reaper.StuffMIDIMessage(0, 0xC4, newPreset, 0)
-- cc channel 5 - this will be sent as a control message to be caught by another script so that it's recorded
reaper.StuffMIDIMessage(0, 0xB4, 49, newPreset)
-- cc channel 5
-- reaper.StuffMIDIMessage(0, 0xB5, 50 + newPreset, 127)