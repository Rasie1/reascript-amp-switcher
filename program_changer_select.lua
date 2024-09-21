is_new_value,filename,sectionID,cmdID,mode,resolution,newPreset,contextstr = reaper.get_action_context()

local track = reaper.GetTrack(0, 1)
if newPreset == 0 then
    -- my dist
    reaper.SetTrackColor(track, 190)
    reaper.TrackFX_SetEnabled(track, 2, false)
    reaper.TrackFX_SetEnabled(track, 3, false)
    reaper.TrackFX_SetEnabled(track, 4, true)
    reaper.SetMediaTrackInfo_Value(track, "D_PAN", 1)
elseif newPreset == 1 then
    -- my clean nolly (math rock)
    reaper.TrackFX_SetEnabled(track, 2, false)
    reaper.TrackFX_SetEnabled(track, 3, false)
    reaper.TrackFX_SetEnabled(track, 4, true) 
    reaper.SetTrackColor(track, 444444444)
    reaper.SetMediaTrackInfo_Value(track, "D_PAN", -1)
elseif newPreset == 2 then
    -- clean
    reaper.TrackFX_SetEnabled(track, 2, true)
    reaper.TrackFX_SetEnabled(track, 3, false)
    reaper.TrackFX_SetEnabled(track, 4, false)
    reaper.SetTrackColor(track, 13121335)
    reaper.SetMediaTrackInfo_Value(track, "D_PAN", -1)
elseif newPreset == 3 then
    -- acoustic
    reaper.SetTrackColor(track, 23121345)
    reaper.TrackFX_SetEnabled(track, 2, false)
    reaper.TrackFX_SetEnabled(track, 3, false)
    reaper.TrackFX_SetEnabled(track, 4, true) 
    reaper.SetMediaTrackInfo_Value(track, "D_PAN", 1)
    reaper.SetMediaTrackInfo_Value(track, "D_PAN", -1)
elseif newPreset == 4 then
    -- future chug machine
    reaper.TrackFX_SetEnabled(track, 2, false)
    reaper.TrackFX_SetEnabled(track, 3, false)
    reaper.TrackFX_SetEnabled(track, 4, true) 
    reaper.SetTrackColor(track, 1024)
    reaper.SetMediaTrackInfo_Value(track, "D_PAN", -1)
elseif newPreset == 5 then
    -- bass
    reaper.TrackFX_SetEnabled(track, 2, false)
    reaper.TrackFX_SetEnabled(track, 3, true) 
    reaper.TrackFX_SetEnabled(track, 4, false)
    reaper.SetTrackColor(track, 7935340)
    reaper.SetMediaTrackInfo_Value(track, "D_PAN", 1)
end
reaper.StuffMIDIMessage(0, 0xB5, 50 + newPreset, 127)