FofleProject_FileVersion = 120
Fofle_ActiveProject = nil;

Fofle_SetActiveProject = function(project)
    Fofle_ActiveProject = project;
end

Fofle_GetActiveProject = function()
    if Fofle_ActiveProject == nil then
        return false;
    else
        return Fofle_ActiveProject;
    end
end

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