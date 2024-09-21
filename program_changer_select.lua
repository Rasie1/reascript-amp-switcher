require "set_program"

is_new_value,filename,sectionID,cmdID,mode,resolution,newPreset,contextstr = reaper.get_action_context()

setProgram(newPreset)