local startTime = reaper.time_precise()
local delay = 0.2

function getPresetId()
    local track = 0
    trackL = reaper.GetTrack(0, 2)
    trackR = reaper.GetTrack(0, 3)
    a, state = reaper.GetTrackState(trackL)
    if state & 8 == 8 then
        track = trackL
    else
        track = trackR
    end
    a, trackName = reaper.GetTrackName(track)
    return string.byte(trackName, 1) - 48
end

function nextFunction()
    local currentPreset = getPresetId()
                                --4 is channel
                                --c is PC
                                --0 is value
    -- reaper.StuffMIDIMessage(0, 0xC4, currentPreset, 0)
    reaper.StuffMIDIMessage(0, 0xB4, 49, currentPreset)
    -- reaper.StuffMIDIMessage(0, 0xB5, 50 + currentPreset, 127)

    local valueString = reaper.GetExtState("MidiCache", "c66")
    local value = tonumber(valueString)
    if value == nil then
        value = 0
    end
    reaper.StuffMIDIMessage(0, 0xB6, 66, value)


    local valueString = reaper.GetExtState("MidiCache", "c12")
    local value = tonumber(valueString)
    if value == nil then
        value = 0
    end
    -- reaper.StuffMIDIMessage(0, 0xB8, 12, value)
    reaper.StuffMIDIMessage(0, 0xB8, 13, value)
    reaper.StuffMIDIMessage(0, 0xB8, 14, value)
end

function update()
  local currentTime = reaper.time_precise()
  if (currentTime - startTime >= delay) then
    nextFunction()
    return
  end
  reaper.runloop(update)
end


reaper.defer(update)