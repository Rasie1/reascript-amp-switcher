require "set_program"

currentPreset, otherPreset = getPresetIds()

local presetsNumber = 7

local keyDownTime = reaper.GetExtState("ProgramChanger", "KeyDownTime")
local keyUpTime = reaper.time_precise()
if keyUpTime - keyDownTime > 1 then
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
    setProgram(newPreset, true)
end