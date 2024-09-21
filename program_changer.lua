-- midiChannel = 0
-- cc = 4
-- ccValue = 0
-- reaper.StuffMIDIMessage(0, 0xC0 + string.format("%x", midiChannel), cc, ccValue)
reaper.SetExtState("ProgramChanger", "KeyDownTime", reaper.time_precise(), true)
