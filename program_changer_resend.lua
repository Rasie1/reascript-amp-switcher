local startTime = reaper.time_precise()
local delay = 0.2


function nextFunction()
    local presetString = reaper.GetExtState("ProgramChanger", "Preset")
    local currentPreset = tonumber(presetString)
    if currentPreset == nil then
        currentPreset = 0
    end
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