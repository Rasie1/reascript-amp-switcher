require "set_program"

-- midiChannel = 0
-- cc = 4
-- ccValue = 0
-- reaper.StuffMIDIMessage(0, 0xC0 + string.format("%x", midiChannel), cc, ccValue)
reaper.SetExtState("ProgramChanger", "KeyDownTime", reaper.time_precise(), true)

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

local currentPreset, otherPreset = getPresetIds()
-- reaper.ShowMessageBox(currentPreset, "DEBUG", 0)

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

