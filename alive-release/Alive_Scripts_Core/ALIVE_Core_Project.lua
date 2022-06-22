ALIVE_Core_Project_IsDebugMode = true;

ALIVE_Core_Project_SetProjectSettings = function()
    local prefs = GetPreferences();
    
    PropertySet(prefs, "Enable Graphic Black", false);
    PropertySet(prefs, "Render - Graphic Black Enabled", false);
    PropertySet(prefs, "Camera Lens Engine", false);
    PropertySet(prefs, "Enable Dialog System 2.0", true);
    PropertySet(prefs, "Enable LipSync 2.0", true);
    PropertySet(prefs, "Legacy Light Limits", false);
    PropertySet(prefs, "Render - Feature Level", 1);
    PropertySet(prefs, "Use Legacy DOF", true);
    PropertySet(prefs, "Animated Lookats Active", true);
    PropertySet(prefs, "Camera Lens Engine", false);
    PropertySet(prefs, "Chore End Lipsync Buffer Time", -1);
    PropertySet(prefs, "Enable Callbacks For Unchanged Key Sets", true);
    PropertySet(prefs, "Enable Lipsync Line Buffers", false);
    PropertySet(prefs, "Fix Pop In Additive Idle Transitions", false);
    PropertySet(prefs, "Fix Recursive Animation Contribution (set to false before Thrones)", true);
    PropertySet(prefs, "Legacy Use Default Lighting Group", true);
    PropertySet(prefs, "Lipsync Line End Buffer", 0);
    PropertySet(prefs, "Lipsync Line Start Buffer", 0);
    PropertySet(prefs, "Mirror Non-skeletal Animations", true);
    PropertySet(prefs, "Project Generates Procedural Look At Targets", true);
    PropertySet(prefs, "Remap bad bones", true);
    PropertySet(prefs, "Set Default Intensity", false);
    PropertySet(prefs, "Strip action lines", true);
    PropertySet(prefs, "Text Leading Fix", true);
end