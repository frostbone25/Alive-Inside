FofleProject_FileVersion = 120

Fofle_IsSceneVersionSupported = function(version)
    if (version > FofleProject_FileVersion) then
        return false
    else
        return true
    end
end

Fofle_DialogBoxOkay = function(text, header)
    Game_PushMode(eModeDialogBox)
    DialogBox_Okay(text, header)
    Game_PopMode(eModeDialogBox)
end