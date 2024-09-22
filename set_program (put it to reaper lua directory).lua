local presetClean = 29898551 -- blue
local presetGlass = 16778240 -- black
local presetAcoustic = 23121345 -- yellow
local presetMath = 461221650 -- green
local presetDistortion = 16777406 -- red
local presetCrystal = 7935340 -- purple

function getTracks()
    trackL = reaper.GetTrack(0, 2)
    trackR = reaper.GetTrack(0, 3)
    a, state = reaper.GetTrackState(trackL)
    if state & 8 == 8 then
        return trackL, trackR
    else
        return trackR, trackL
    end
end

function getPresetIds()
    track, otherTrack = getTracks()
    a, trackName = reaper.GetTrackName(track)
    a, otherTrackName = reaper.GetTrackName(otherTrack)
    return string.byte(trackName, 1) - 48, string.byte(otherTrackName, 1) - 48, track, otherTrack
end

function locateTrack(trackId)
    idL, idR, trackL, trackR = getPresetIds()
    local track = 0
    local otherTrack = 0
    local changed = 0

    if idL == trackId then
        track = trackL
        otherTrack = trackR
    elseif idR == trackId then
        track = trackR
        otherTrack = trackL
    else
        track = trackL
        otherTrack = trackR
        changed = 1
    end

    return track, otherTrack, changed
end

local presetToUpdate = 0
function updatePreset()
    reaper.StuffMIDIMessage(0, 0xB5, 50 + presetToUpdate, 127)
end

function setProgram(newPreset, shouldRecord)
    if newPreset == 0 then
        -- nothing, so that defaulting to 0 on stopping playback does nothing
        return
    end
    local track, otherTrack, changed = locateTrack(newPreset)
    reaper.SetMediaTrackInfo_Value(track, "B_MUTE", 0)
    reaper.SetTrackSendInfo_Value(track, -1, 0, "B_MUTE", 0)
    reaper.SetMediaTrackInfo_Value(track, "I_RECARM", 1)
    reaper.SetMediaTrackInfo_Value(otherTrack, "B_MUTE", 1)
    reaper.SetTrackSendInfo_Value(otherTrack, -1, 0, "B_MUTE", 1)
    reaper.SetMediaTrackInfo_Value(otherTrack, "I_RECARM", 0)
    if newPreset == 1 then
        reaper.GetSetMediaTrackInfo_String(track, "P_NAME", "1 FX clean", true)
        reaper.TrackFX_SetEnabled(track, 1, false)
        reaper.TrackFX_SetEnabled(track, 2, true)
        reaper.SetTrackColor(track, presetClean)
        reaper.SetMediaTrackInfo_Value(track, "D_PAN", -1)
    elseif newPreset == 2 then
        reaper.GetSetMediaTrackInfo_String(track, "P_NAME", "2 FX glass", true)
        reaper.TrackFX_SetEnabled(track, 1, true)
        reaper.TrackFX_SetEnabled(track, 2, false)
        reaper.SetTrackColor(track, presetGlass)
        reaper.SetMediaTrackInfo_Value(track, "D_PAN", -1)
    elseif newPreset == 3 then
        reaper.GetSetMediaTrackInfo_String(track, "P_NAME", "3 FX acoustic", true)
        reaper.SetTrackColor(track, presetAcoustic)
        reaper.TrackFX_SetEnabled(track, 1, false)
        reaper.TrackFX_SetEnabled(track, 2, true)
        reaper.SetMediaTrackInfo_Value(track, "D_PAN", 1)
        reaper.SetMediaTrackInfo_Value(track, "D_PAN", -1)
    elseif newPreset == 4 then
        reaper.GetSetMediaTrackInfo_String(track, "P_NAME", "4 FX math", true)
        reaper.TrackFX_SetEnabled(track, 1, false)
        reaper.TrackFX_SetEnabled(track, 2, true)
        reaper.SetTrackColor(track, presetMath)
        reaper.SetMediaTrackInfo_Value(track, "D_PAN", -1)
    elseif newPreset == 5 then
        reaper.GetSetMediaTrackInfo_String(track, "P_NAME", "5 FX distortion", true)
        reaper.SetTrackColor(track, presetDistortion)
        reaper.TrackFX_SetEnabled(track, 1, false)
        reaper.TrackFX_SetEnabled(track, 2, true)
        reaper.SetMediaTrackInfo_Value(track, "D_PAN", 1)
    elseif newPreset == 6 then
        reaper.GetSetMediaTrackInfo_String(track, "P_NAME", "6 FX crystal", true)
        reaper.TrackFX_SetEnabled(track, 1, true)
        reaper.TrackFX_SetEnabled(track, 2, false)
        reaper.SetTrackColor(track, presetCrystal)
        reaper.SetMediaTrackInfo_Value(track, "D_PAN", -1)
    end
    if changed == 1 then
        presetToUpdate = newPreset
        reaper.defer(updatePreset)
    end

    if shouldRecord then
        -- cc channel 5 - this will be sent as a control message to be caught by another script so that it's recorded
        reaper.StuffMIDIMessage(0, 0xB4, 49, newPreset)
    end
end