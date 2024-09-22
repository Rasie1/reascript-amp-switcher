require "set_program"


local isLivePress = reaper.GetExtState("ProgramChanger", "Live")
if isLivePress == "" then
    is_new_value,filename,sectionID,cmdID,mode,resolution,newPreset,contextstr = reaper.get_action_context()

    setProgram(newPreset, false)
else
    reaper.DeleteExtState("ProgramChanger", "Live", false)
end
