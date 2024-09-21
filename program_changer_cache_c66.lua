is_new_value,filename,sectionID,cmdID,mode,resolution,value,contextstr = reaper.get_action_context()
reaper.SetExtState("MidiCache", "c66", value, true)
reaper.StuffMIDIMessage(0, 0xB6, 66, value)