require "set_program"

function getPresetIds()
    local track = 0
    local otherTrack = 0
    trackL = reaper.GetTrack(0, 2)
    trackR = reaper.GetTrack(0, 3)
    a, state = reaper.GetTrackState(trackL)
    if state & 8 == 8 then
        track = trackL
        otherTrack = trackR
    else
        track = trackR
        otherTrack = trackL
    end
    a, trackName = reaper.GetTrackName(track)
    a, otherTrackName = reaper.GetTrackName(otherTrack)
    return string.byte(trackName, 1) - 48, string.byte(otherTrackName, 1) - 48
end

currentPreset, otherPreset = getPresetIds()

local presetsNumber = 6

local keyDownTime = reaper.GetExtState("ProgramChanger", "KeyDownTime")
local keyUpTime = reaper.time_precise()
if keyUpTime - keyDownTime > 1 then
    -- reaper.ShowMessageBox(currentPreset, "DEBUG", 0)
    -- maybe i don't have to record? then move the midi message back out
    -- setProgram(currentPreset, true)

    local newPreset = (currentPreset + 1) % presetsNumber
    if (newPreset == otherPreset) then
        newPreset = (newPreset + 1) % presetsNumber
    end
    -- skip 0 because it's a workaround for reset after playback
    if newPreset == 0 then
        if otherPreset == 1 then
            newPreset = 2
        else
            newPreset = 1
        end
    end
    -- reaper.ShowMessageBox(newPreset, "DEBUG", 0)
    setProgram(newPreset, true)
end