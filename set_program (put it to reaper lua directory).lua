local presetCleanNolly = 461221650
local presetCleanAAL = 29898551
local presetAcoustic = 23121345
local presetChug = 16778240
local presetDist = 16777406
local changed = 0

function locateTrack(trackId)
    -- colors are workarounds for encoding channel id+state, todo: use actual id in channel name
    local track = 0
    local otherTrack = 0

    local trackL = reaper.GetTrack(0, 2)
    local trackR = reaper.GetTrack(0, 3)

    local colorL = reaper.GetTrackColor(trackL)
    local colorR = reaper.GetTrackColor(trackR)
    if colorL == trackId then
        track = trackL
        otherTrack = trackR
    elseif colorR == trackId then
        track = trackR
        otherTrack = trackL
    else
        a, state = reaper.GetTrackState(trackL)
        if state & 8 == 8 then
            track = trackL
            otherTrack = trackR
        else
            track = trackR
            otherTrack = trackL
        end
        changed = 1
    end

    reaper.SetMediaTrackInfo_Value(track, "B_MUTE", 0)
    reaper.SetTrackSendInfo_Value(track, -1, 0, "B_MUTE", 0)
    reaper.SetMediaTrackInfo_Value(track, "I_RECARM", 1)

    reaper.SetMediaTrackInfo_Value(otherTrack, "B_MUTE", 1)
    reaper.SetTrackSendInfo_Value(otherTrack, -1, 0, "B_MUTE", 1)
    reaper.SetMediaTrackInfo_Value(otherTrack, "I_RECARM", 0)

    return track
end

function setProgram(newPreset, shouldRecord)
    if newPreset == 0 then
        -- nothing, so that defaulting to 0 on stopping playback does nothing
    elseif newPreset == 1 then
        -- my clean nolly
        local track = locateTrack(presetCleanNolly)
        reaper.GetSetMediaTrackInfo_String(track, "P_NAME", "1 FX clean 1", true)
        reaper.TrackFX_SetEnabled(track, 1, false)
        reaper.TrackFX_SetEnabled(track, 3, true)
        reaper.SetTrackColor(track, presetCleanNolly)
        reaper.SetMediaTrackInfo_Value(track, "D_PAN", -1)
    elseif newPreset == 2 then
        -- clean aal
        local track = locateTrack(presetCleanAAL)
        reaper.GetSetMediaTrackInfo_String(track, "P_NAME", "2 FX clean 2", true)
        reaper.TrackFX_SetEnabled(track, 1, true)
        reaper.TrackFX_SetEnabled(track, 3, fals
        reaper.SetTrackColor(track, presetCleanAAL)
        reaper.SetMediaTrackInfo_Value(track, "D_PAN", -1)
    elseif newPreset == 3 then
        -- acoustic
        local track = locateTrack(presetAcoustic)
        reaper.GetSetMediaTrackInfo_String(track, "P_NAME", "3 FX acoustic", true)
        reaper.SetTrackColor(track, presetAcoustic)
        reaper.TrackFX_SetEnabled(track, 1, false)
        reaper.TrackFX_SetEnabled(track, 3, true)
        reaper.SetMediaTrackInfo_Value(track, "D_PAN", 1)
        reaper.SetMediaTrackInfo_Value(track, "D_PAN", -1)
    elseif newPreset == 4 then
        -- future chug machine
        local track = locateTrack(presetChug)
        reaper.GetSetMediaTrackInfo_String(track, "P_NAME", "4 FX chugs", true)
        reaper.TrackFX_SetEnabled(track, 1, false)
        reaper.TrackFX_SetEnabled(track, 3, true)
        reaper.SetTrackColor(track, presetChug)
        reaper.SetMediaTrackInfo_Value(track, "D_PAN", -1)
    elseif newPreset == 5 then
        -- my dist
        local track = locateTrack(presetDist)
        reaper.GetSetMediaTrackInfo_String(track, "P_NAME", "5 FX distortion", true)
        reaper.SetTrackColor(track, presetDist)
        reaper.TrackFX_SetEnabled(track, 1, false)
        reaper.TrackFX_SetEnabled(track, 3, true)
        reaper.SetMediaTrackInfo_Value(track, "D_PAN", 1)
    end
    if changed == 1 then
        reaper.StuffMIDIMessage(0, 0xB5, 50 + newPreset, 127)
    end

    if shouldRecord then
        -- cc channel 5 - this will be sent as a control message to be caught by another script so that it's recorded
        reaper.StuffMIDIMessage(0, 0xB4, 49, newPreset)
    end
end