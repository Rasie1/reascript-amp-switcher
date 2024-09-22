function getPresetId()
    local track = 0
    trackL = reaper.GetTrack(0, 2)
    trackR = reaper.GetTrack(0, 3)
    a, state = reaper.GetTrackState(trackL)
    if state & 8 == 8 then
        track = trackR
    else
        track = trackL
    end
    a, trackName = reaper.GetTrackName(track)
    return string.byte(trackName, 1) - 48
end

local currentPreset = getPresetId()
is_new_value,filename,sectionID,cmdID,mode,resolution,value,contextstr = reaper.get_action_context()
local newVelocity = 0
if (currentPreset == 0) then
elseif (currentPreset == 1) then
    local rooted = value^0.4 * 31
    newVelocity = math.floor(math.max(0,math.min(rooted - 100, 127)))
    reaper.StuffMIDIMessage(0, 0xB8, 13, newVelocity)
    reaper.SetExtState("MidiCache", "c13", newVelocity, true)
elseif (currentPreset == 2) then
    local rooted = value^0.4 * 31
    newVelocity = math.floor(math.max(0,math.min(rooted - 100, 127)))
    reaper.StuffMIDIMessage(0, 0xB8, 13, newVelocity)
    reaper.SetExtState("MidiCache", "c13", newVelocity, true)
elseif (currentPreset == 3) then
    local rooted = value^0.4 * 31
    newVelocity = math.floor(math.max(0,math.min(rooted - 100, 127)))
    reaper.StuffMIDIMessage(0, 0xB8, 13, newVelocity)
    reaper.SetExtState("MidiCache", "c13", newVelocity, true)
elseif (currentPreset == 4) then
    local rooted = value^0.4 * 31
    newVelocity = math.floor(math.max(0,math.min(rooted - 100, 127)))
    reaper.StuffMIDIMessage(0, 0xB8, 13, newVelocity)
    reaper.SetExtState("MidiCache", "c13", newVelocity, true)
elseif (currentPreset == 5) then
    newVelocity = math.min(127, math.max(0, (140 - value - value // 4) // 2))
    reaper.StuffMIDIMessage(0, 0xB8, 12, newVelocity)
    reaper.SetExtState("MidiCache", "c14", newVelocity, true)
elseif (currentPreset == 6) then
    local rooted = value^0.4 * 31
    newVelocity = math.floor(math.max(0,math.min(rooted - 100, 127)))
    reaper.StuffMIDIMessage(0, 0xB8, 13, newVelocity)
    reaper.SetExtState("MidiCache", "c13", newVelocity, true)
end

-- old
