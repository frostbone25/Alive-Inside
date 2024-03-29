--[[
Custom Development Tools/Functions script

THIS SCRIPT IS FOR HANDLING THE MAIN RELIGHT TOOL

KEYCODE VALUES - https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
Keycode values are in hexcode, so use this to convert them to decimal - https://www.rapidtables.com/convert/number/hex-to-decimal.html

This script also uses functions from the following lua scripts...
- ALIVE_Core_AgentExtensions.lua
- ALIVE_Core_Printing.lua
- ALIVE_Development_Freecam.lua

WHEN IMPLEMENTING THIS INTO A LEVEL, YOU MUST DO THE FOLLOWING...

1. At the top of the script, you must have a variable that is named
- ALIVE_Development_SceneObject
This will just simply contain a reference to the kScene variable so the function can reference object from the scene.

2. At the top of the script, you must have a variable that is named
- ALIVE_Development_SceneObjectAgentName
This will just simply contain a reference to the scene agent name.

3. In the main function of the level script you call this function before step 2
ALIVE_Development_CreateFreeCamera(kScene)

4. Lastly, also in the main function of the level script you add the functionality like so...

Callback_OnPostUpdate:Add(ALIVE_Development_UpdateFreeCamera)
]]--

--ALIVE_Development_SceneObject
--ALIVE_Development_SceneObjectAgentName
--ALIVE_Development_UseSeasonOneAPI

--(public) relight dev variables (public because these values need to be persistent)
ALIVE_Development_CutsceneToolsText = nil;
ALIVE_Development_CutsceneToolsHighlightText = nil;
ALIVE_Development_CutsceneToolsEditMode = false;
ALIVE_Development_CutsceneToolsTextTitle = "FOFLE Editor v1.0";
ALIVE_Development_SceneAgentNames = {};
ALIVE_Development_SceneAgentOriginalVisibility = {};
ALIVE_Development_AgentIndex = 1;
ALIVE_Development_MaxDisplayedItemCount = 10;
ALIVE_Development_MenuItem = 1;

Fofle_EditorActiveProject = nil;

local currentAgent_name = ""; --string type
local currentAgent_agent = nil; --Agent type
local currentAgent_position_vector = nil; --Vector type
local currentAgent_rotation_vector = nil; --Vector type

--(private) relight dev variables
local AgentOperations = 
{
    "Create New Light",
    "Delete Selected Light",
    "Modify Agent Position",
    "Modify Agent Rotation",
    "Move Agent To Camera"
}

local SceneModifiablePropertyNames = 
{
    "FX anti-aliasing",
    "FX TAA Weight",
    "FX Sharp Shadows Enabled",
    "FX Ambient Occlusion Enabled",
    "FX Tonemap Enabled",
    "FX Tonemap Intensity",
    "FX Tonemap Type",
    "FX Tonemap White Point",
    "FX Tonemap Black Point",
    "FX Tonemap Filmic Pivot",
    "FX Tonemap Filmic Shoulder Intensity",
    "FX Tonemap Filmic Toe Intensity",
    "FX Tonemap Filmic Sign",
    "FX Tonemap Far White Point",
    "FX Tonemap Far Black Point",
    "FX Tonemap Far Filmic Pivot",
    "FX Tonemap Far Filmic Shoulder Intensity",
    "FX Tonemap Far Filmic Toe Intensity",
    "FX Tonemap Far Filmic Sign",
    "FX Tonemap RGB Enabled",
    "FX Tonemap RGB DOF Enabled",
    "FX Tonemap RGB Black Points",
    "FX Tonemap RGB White Points",
    "FX Tonemap RGB Pivots",
    "FX Tonemap RGB Shoulder Intensities",
    "FX Tonemap RGB Toe Intensities",
    "FX Tonemap RGB Signs",
    "FX Tonemap RGB Far Black Points",
    "FX Tonemap RGB Far White Points",
    "FX Tonemap RGB Far Pivots",
    "FX Tonemap RGB Far Shoulder Intensities",
    "FX Tonemap RGB Far Toe Intensities",
    "FX Tonemap RGB Far Signs",
    "FX Bloom Threshold",
    "FX Bloom Intensity",
    "Glow Clear Color",
    "Glow Sigma Scale",
    "FX Vignette Tint Enabled",
    "FX Vignette Tint",
    "FX Vignette Falloff",
    "FX Vignette Center",
    "FX Vignette Corners",
    "FX Force Linear Depth Offset",
    "HBAO Enabled",
    "HBAO Intensity",
    "HBAO Radius",
    "HBAO Max Radius Percent",
    "HBAO Hemisphere Bias",
    "HBAO Max Distance",
    "HBAO Blur Sharpness",
    "HBAO Distance Falloff",
    "HBAO Occlusion Scale",
    "HBAO Luminance Scale",
    "Ambient Color",
    "Shadow Color",
    "LightEnv Enabled",
    "LightEnv Reflection Enabled",
    "LightEnv Bake Enabled",
    "LightEnv Intensity",
    "LightEnv Saturation",
    "LightEnv Reflection Intensity Shadow",
    "LightEnv Reflection Intensity",
    "LightEnv Reflection Tint",
    "LightEnv Tint",
    "LightEnv Background Color",
    "LightEnv Shadow Light Bleed Reduction",
    "LightEnv Shadow Moment Bias",
    "LightEnv Shadow Depth Bias",
    "LightEnv Shadow Auto Depth Bounds",
    "LightEnv Dynamic Shadow Max Distance",
    "LightEnv Shadow Max Distance",
    "Light Shadow Trace Max Distance",
    "Specular Multiplier Enabled",
    "Specular Color Multiplier",
    "Specular Intensity Multiplier",
    "Specular Exponent Multiplier",
    "Fog Color",
    "Fog Enabled",
    "Fog Far Plane",
    "Fog Near Plane",
    "Fog Alpha"
}

local LightModifiablePropertyNames = 
{
    "EnvLight - Type",
    "EnvLight - Color",
    "EnvLight - Intensity",
    "EnvLight - Intensity Specular",
    "EnvLight - Intensity Diffuse",
    "EnvLight - Intensity Dimmer",
    "EnvLight - Enlighten Intensity",
    "EnvLight - Opacity",
    "EnvLight - Radius",
    "EnvLight - Distance Falloff",
    "EnvLight - Spot Angle Inner",
    "EnvLight - Spot Angle Outer",
    "EnvLight - Enabled Group",
    "EnvLight - Groups",
    "EnvLight - Wrap",
    "EnvLight - HBAO Participation Type",
    "EnvLight - Mobility",
    "EnvLight - Shadow Type",
    "EnvLight - Shadow Quality",
    "EnvLight - Shadow Softness",
    "EnvLight - Shadow Modulated Intensity",
    "EnvLight - Shadow Near Clip",
    "EnvLight - Shadow Depth Bias",
    "EnvLight - Shadow Map Quality Distance Scale"
}

local FogModifiablePropertyNames = 
{
    "Env - Enabled",
    "Env - Enabled on High",
    "Env - Enabled on Medium",
    "Env - Enabled on Low",
    "Env - Fog Enabled",
    "Env - Fog Height Falloff",
    "Env - Fog Max Opacity",
    "Env - Fog Start Distance",
    "Env - Fog Height",
    "Env - Fog Density",
    "Env - Priority",
    "Env - Fog Color"
}

local FOFLE_AgentsMarkedForDeletion = {};

--input workaround because S1 has different API
local ALIVE_InputKeyPress = function(keyCode)
    if (ALIVE_Development_UseSeasonOneAPI == true) then
        return Input_IsPressed(keyCode);
    else
        return Input_IsVKeyPressed(keyCode);
    end
end

local CreateTextAgent = function(name, text, posx, posy, posz, halign, valign)
    local pos       = Vector(posx, posy, posz)
    local textAgent = AgentCreate(name, "ui_text.prop", pos)

    if halign then
        TextSetHorizAlign(textAgent, halign)
    end
    
    if valign then
        TextSetVertAlign(textAgent, valign)
    end
    
    TextSet(textAgent, text)
    
    AgentSetProperty(textAgent, "Text Render Layer", 99)
    AgentSetProperty(textAgent, "Text Render After Post-Effects", true)
    
    return textAgent
end

ALIVE_Development_BuildSceneAgentList = function()
    local allSceneAgents = SceneGetAgents(ALIVE_Development_SceneObject);
    local onlyDoLights = false;
    
    ALIVE_Development_SceneAgentNames = {};
    
    for i, sceneAgent in ipairs(allSceneAgents) do
        local sceneAgentName = AgentGetName(sceneAgent);
        local originalVisibility = ALIVE_AgentGetProperty(sceneAgentName, "Runtime: Visible", ALIVE_Development_SceneObject); --bool type
    
        if (onlyDoLights == true) then
            --scene lights and custom lights
            if (string.match)(sceneAgentName, "light_") or (string.match)(sceneAgentName, "myLight_") then
                table.insert(ALIVE_Development_SceneAgentNames, sceneAgentName);
                table.insert(ALIVE_Development_SceneAgentOriginalVisibility, originalVisibility);
            end
            
            --scene object
            if (string.match)(sceneAgentName, ALIVE_Development_SceneObjectAgentName) then
                table.insert(ALIVE_Development_SceneAgentNames, sceneAgentName);
                table.insert(ALIVE_Development_SceneAgentOriginalVisibility, originalVisibility);
            end
            
            --scene fog
            if (string.match)(sceneAgentName, "module_environment") then
                table.insert(ALIVE_Development_SceneAgentNames, sceneAgentName);
                table.insert(ALIVE_Development_SceneAgentOriginalVisibility, originalVisibility);
            end
        else
            table.insert(ALIVE_Development_SceneAgentNames, sceneAgentName);
            table.insert(ALIVE_Development_SceneAgentOriginalVisibility, originalVisibility);
        end
    end
end

ALIVE_Development_InitalizeCutsceneTools = function()

    Fofle_EditorActiveProject = Fofle_GetActiveProject();
    if (Fofle_EditorActiveProject ~= nil) and (Fofle_EditorActiveProject ~= false) then
        print("Fofle EDITOR - Set Agents Marked For Deletion");
        for i, sceneAgent in pairs(Fofle_EditorActiveProject.agents.remove) do
            print("Fofle EDITOR - Set Agents Marked For Deletion - Add: " .. sceneAgent);
            FOFLE_AgentsMarkedForDeletion[sceneAgent] = sceneAgent;
        end
    end

    -------------------------------------------------------------
    --initalize menu text
    --force scene vignette off because it makes it hard to read text
    ALIVE_AgentSetProperty(ALIVE_Development_SceneObjectAgentName, "FX Vignette Tint Enabled", false, ALIVE_Development_SceneObject);

    --create our menu text
    ALIVE_Development_CutsceneToolsText = CreateTextAgent("CutsceneToolsText", "Relight Text Initalized", 0.0, 0.0, 0, 0, 0);
    
    --create our agent highlighted text
    ALIVE_Development_CutsceneToolsHighlightText = CreateTextAgent("CutsceneToolsHighlightedText", "Relight Text Initalized", 0.0, 0.0, 0, 0, 0);

    --scale note
    --1.0 = default
    --0.5 = half
    --2.0 = double
    TextSetScale(ALIVE_Development_CutsceneToolsText, 0.75);
    TextSetScale(ALIVE_Development_CutsceneToolsHighlightText, 0.75);

    --color note
    --text colors are additive on the scene
    TextSetColor(ALIVE_Development_CutsceneToolsText, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(ALIVE_Development_CutsceneToolsHighlightText, Color(1.0, 0.0, 1.0, 1.0));
    -------------------------------------------------------------
    --initalize other dev tool values
    ALIVE_Development_BuildSceneAgentList();
end

--temp variables for input (for limiting the amount of times input runs because its sooo fast)
local inputRunRate = 0;
local maxInputRunRate = 5;

ALIVE_Development_UpdateCutsceneTools_Input = function()
    -------------------------------------------------------------
    --limit amount of time this function executes because its so responsive
    inputRunRate = inputRunRate + 1;
    
    if not (inputRunRate == maxInputRunRate) then
        do return end
    else
        inputRunRate = 0;
    end
    
    --edit mode toggle
    
    if ALIVE_InputKeyPress(70) then
        --F key
        ALIVE_Development_CutsceneToolsEditMode = not ALIVE_Development_CutsceneToolsEditMode;
        if(ALIVE_Development_CutsceneToolsEditMode) then
            InputMapperActivate("FOFLE_Editor.imap")
        else
            InputMapperActivate("Alive_Development_Freecam.imap")
        end
        ALIVE_Development_BuildSceneAgentList();
    end

    ------------------------------------------------------------

    if (ALIVE_Development_CutsceneToolsEditMode == false) then
        do return end
    end

    if ALIVE_InputKeyPress(9) then
        --tab
        ALIVE_Development_BuildSceneAgentList();
    end
end

ALIVE_Development_UpdateCutsceneTools_Main = function()  
    -------------------------------------------------------------
    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    local screenPos = Vector(0.0, 0.0, 0.0);
    AgentSetWorldPosFromLogicalScreenPos(ALIVE_Development_CutsceneToolsText, screenPos);
    --AgentSetWorldPosFromScreenPos(ALIVE_Development_CutsceneToolsText,  Vector(0.5, 0.5, 0.0));
    --AgentSetWorldPosFromCursorPos(ALIVE_Development_CutsceneToolsText);

    -------------------------------------------------------------
    --get the current camera, normally we would just cache this but scene cameras change all the time
    local currentCamera_agent = SceneGetCamera(ALIVE_Development_SceneObject); --Agent type
    local currentCamera_camera = AgentGetCamera(currentCamera_agent); --Camera type
    local currentCamera_name = tostring(AgentGetName(currentCamera_agent)); --String type
    local currentCamera_position_vector = AgentGetWorldPos(currentCamera_agent); --Vector type
    local currentCamera_forward_vector = AgentGetForwardVec(currentCamera_agent); --Vector type
    local currentCamera_rotation_vector = AgentGetWorldRot(currentCamera_agent); --Vector type
    local currentCamera_fov = ALIVE_AgentGetProperty(currentCamera_name, "Field of View", ALIVE_Development_SceneObject); --number type
    
    currentAgent_name = ALIVE_Development_SceneAgentNames[ALIVE_Development_AgentIndex];
    currentAgent_agent = AgentFindInScene(currentAgent_name, ALIVE_Development_SceneObject);
    currentAgent_position_vector = AgentGetWorldPos(currentAgent_agent); --Vector type
    currentAgent_rotation_vector = AgentGetWorldRot(currentAgent_agent); --Vector type
    
    -------------------------------------------------------------
    --for highlighted text
    local highlightedText = currentAgent_name;
    highlightedText = highlightedText .. "\n"; --new line
    highlightedText = highlightedText .. "World Pos: " .. VectorToString(currentAgent_position_vector);
    highlightedText = highlightedText .. "\n"; --new line
    highlightedText = highlightedText .. "World Rot: " .. VectorToString(currentAgent_rotation_vector); 
    
    TextSet(ALIVE_Development_CutsceneToolsHighlightText, highlightedText);
    AgentSetWorldPos(ALIVE_Development_CutsceneToolsHighlightText, currentAgent_position_vector);

    -------------------------------------------------------------
    --main menu text
    local relightMenuText = ALIVE_Development_CutsceneToolsTextTitle;
    
    if (ALIVE_Development_CutsceneToolsEditMode == true) then
        relightMenuText = relightMenuText .. "\n"; --new line
        relightMenuText = relightMenuText .. "[EDIT MODE]";
        relightMenuText = relightMenuText .. "\n"; --new line
        
        --clamp
        if (ALIVE_Development_AgentIndex > #ALIVE_Development_SceneAgentNames) then
            ALIVE_Development_AgentIndex = 1;
        elseif (ALIVE_Development_AgentIndex < 1) then
            ALIVE_Development_AgentIndex = #ALIVE_Development_SceneAgentNames;
        end

        if (ALIVE_Development_MenuItem < 1) then
            ALIVE_Development_MenuItem = 1;
        end

        local text_sceneAgentIndex = tostring(ALIVE_Development_AgentIndex);
        local text_totalSceneAgentAmount = tostring(#ALIVE_Development_SceneAgentNames);
        local text_currSceneAgentName = tostring(ALIVE_Development_SceneAgentNames[ALIVE_Development_AgentIndex]);
        relightMenuText = relightMenuText .. "Selected Agent [" .. text_sceneAgentIndex .. " / " .. text_totalSceneAgentAmount .. "] ".. text_currSceneAgentName;
        relightMenuText = relightMenuText .. "\n";
        relightMenuText = relightMenuText .. "+   | Add New Agent\n";
        relightMenuText = relightMenuText .. "-   | Mark Agent For Deletion (toggle)\n";
        relightMenuText = relightMenuText .. "P   | Save FOFLE JSON File\n";
        relightMenuText = relightMenuText .. "ESC | Reload Scene";
        relightMenuText = relightMenuText .. "\n"; --new line
        relightMenuText = relightMenuText .. "\n"; --new line

        if(FOFLE_AgentsMarkedForDeletion[text_currSceneAgentName] ~= nil) and (FOFLE_AgentsMarkedForDeletion[text_currSceneAgentName] ~= false) then
            relightMenuText = relightMenuText .. "This agent is currently marked for deletion on scene load.\n"
        end
        
        local displayIndex = 0;
        local displayIndexOffset = 0;
        local modifiablePropertyNames = {};

        --scene lights and custom lights
        if (string.match)(currentAgent_name, "light_") or (string.match)(currentAgent_name, "myLight_") then
            relightMenuText = relightMenuText .. "[LIGHT PROPERTIES]";
            relightMenuText = relightMenuText .. "\n"; --new line
            modifiablePropertyNames = ALIVE_PropertiesListToStringList(currentAgent_name, LightModifiablePropertyNames);
        end
        
        --scene object
        if (string.match)(currentAgent_name, ALIVE_Development_SceneObjectAgentName) then
            relightMenuText = relightMenuText .. "[SCENE PROPERTIES]";
            relightMenuText = relightMenuText .. "\n"; --new line
            modifiablePropertyNames = ALIVE_PropertiesListToStringList(currentAgent_name, SceneModifiablePropertyNames);
        end
        
        --scene fog
        if (string.match)(currentAgent_name, "module_environment") then
            relightMenuText = relightMenuText .. "[FOG PROPERTIES]";
            relightMenuText = relightMenuText .. "\n"; --new line
            modifiablePropertyNames = ALIVE_PropertiesListToStringList(currentAgent_name, FogModifiablePropertyNames);
        end
        
        local currentModifablePropertyName = modifiablePropertyNames[ALIVE_Development_MenuItem];
        
        --start seperator
        relightMenuText = relightMenuText .. "----------------------------------------------------";
        relightMenuText = relightMenuText .. "\n"; --new line
        
        --clamp menu item index
        if(ALIVE_Development_MenuItem > #modifiablePropertyNames) then
            ALIVE_Development_MenuItem =  #modifiablePropertyNames;
        end
        
        --move the display window to display the rest of the items properly
        if(ALIVE_Development_MenuItem > ALIVE_Development_MaxDisplayedItemCount + displayIndexOffset) then 
            displayIndexOffset = displayIndexOffset + (ALIVE_Development_MenuItem - ALIVE_Development_MaxDisplayedItemCount) - 1; 
        end

        --iterate through the menu items
        for i, item in ipairs(modifiablePropertyNames) do
            local loopIndex = i + displayIndexOffset;
            local loopItem = modifiablePropertyNames[loopIndex];

            if (loopIndex == ALIVE_Development_MenuItem) then
                relightMenuText = relightMenuText .. "*   ";
            end
                
            relightMenuText = relightMenuText .. "( " .. tostring(#modifiablePropertyNames) .. " / " .. tostring(loopIndex) .. " ) ";
            relightMenuText = relightMenuText .. loopItem;
            relightMenuText = relightMenuText .. "\n"; --new line
                
            displayIndex = displayIndex + 1;
                
            if (displayIndex > ALIVE_Development_MaxDisplayedItemCount) then break end
        end
        
        --end seperator
        relightMenuText = relightMenuText .. "----------------------------------------------------";
        relightMenuText = relightMenuText .. "\n"; --new line
    else
        relightMenuText = relightMenuText .. "\n"; --new line
        relightMenuText = relightMenuText .. "[FREECAMERA MODE]";
        relightMenuText = relightMenuText .. "\n"; --new line
        relightMenuText = relightMenuText .. "Press F to toggle edit mode.";
        relightMenuText = relightMenuText .. "\n"; --new line
        
        relightMenuText = relightMenuText .. "\n"; --new line
        relightMenuText = relightMenuText .. "Current Camera: " .. currentCamera_name;
        relightMenuText = relightMenuText .. "\n"; --new line
        relightMenuText = relightMenuText .. "Camera FOV: " .. currentCamera_fov;
        relightMenuText = relightMenuText .. "\n"; --new line
        relightMenuText = relightMenuText .. "Camera World Position: " .. VectorToString(currentCamera_position_vector);
        relightMenuText = relightMenuText .. "\n"; --new line
        relightMenuText = relightMenuText .. "Camera World Rotation: " .. VectorToString(currentCamera_rotation_vector); 
    end
    
    TextSet(ALIVE_Development_CutsceneToolsText, relightMenuText)
end

FOFLE_Editor_ReloadScene = function()
    print("Fofle EDITOR - Scene Reload Requested - " .. kScene .. ".lua");

    if (DialogBox_YesNo("All unsaved progress will be lost! Press P to export/save your work BEFORE doing this!", "Are you sure?")) then
        SubProject_Switch("Menu", kScript .. ".lua")
    end
end

FOFLE_Editor_ExportJSON = function()
    if (Fofle_EditorActiveProject ~= nil) and (Fofle_EditorActiveProject ~= false) then
        print("Fofle EDITOR - JSON Export - Active Project Loaded")
        --Proceed with Export
        
        print("Fofle EDITOR - JSON Export - Set File Version " .. FofleProject_FileVersion)
        Fofle_EditorActiveProject.fofle.version = FofleProject_FileVersion;

        local fileName, cancel = Menu_OpenTextEntryBox(FOFLE_SceneID, Menu_Text("Please enter the Scene ID. The default value will override the existing loaded scene."))
        if(cancel) then
            print("Fofle EDITOR - JSON Export - Cancel")
            DialogBox_Okay("We've cancelled the scene export.", "Export - Cancelled")
            return
        end

        local enableTools = DialogBox_YesNo("Would you like to enable devtools by default when this project is loaded?", "Export - Enable Tools?")
        Fofle_EditorActiveProject.debug.useFreecamTools = enableTools;

        local enableMetrics = DialogBox_YesNo("Would you like to enable performance metrics by default when this project is loaded?", "Export - Enable Metrics?")
        Fofle_EditorActiveProject.debug.showPerformanceMetrics = enableMetrics;

        if not Fofle_EditorActiveProject.debug.useFreecamTools then
            print("Fofle EDITOR - JSON Export - Freecam Tools Not Enabled")
            DialogBox_Okay("We won't add devtools.", "Export - Tools Not Enabled.")
        end

        print("Fofle EDITOR - JSON Export - Mark Agents For Deletion")
        Fofle_EditorActiveProject.agents.remove = {};
        for i, sceneAgent in pairs(FOFLE_AgentsMarkedForDeletion) do
            
            if(sceneAgent ~= nil) and (sceneAgent ~= false) then
                print("Fofle EDITOR - JSON Export - Mark Agent For Deletion - Add: " .. sceneAgent)
                Fofle_EditorActiveProject.agents.remove[#Fofle_EditorActiveProject.agents.remove+1] = sceneAgent;
            end
        end

        if ALIVE_Core_FileUtils_EncodeJSONFile(Fofle_EditorActiveProject, "\\Data\\fofle_" .. fileName) then
            print("Fofle EDITOR - JSON Export - Export Successful");
            DialogBox_Okay("Export Successful!", "Project Exported");
        else
            print("Fofle EDITOR - JSON Export - Export NOT Successful");
            DialogBox_Okay("Export Unsuccessful", "Fatal Error");
        end

    else
        print("Fofle EDITOR - JSON Export - Project Load Failed")
        DialogBox_Okay("Could not get active FOFLE project.", "Fatal Error");
    end
end

FOFLE_Editor_CycleMenuLeft = function()
    ALIVE_Development_AgentIndex = ALIVE_Development_AgentIndex - 1;
end

FOFLE_Editor_CycleMenuRight = function()
    ALIVE_Development_AgentIndex = ALIVE_Development_AgentIndex + 1;
end

FOFLE_Editor_CycleMenuUp = function()
    ALIVE_Development_MenuItem = ALIVE_Development_MenuItem + 1;
end

FOFLE_Editor_CycleMenuDown = function()
    ALIVE_Development_MenuItem = ALIVE_Development_MenuItem - 1;
end

FOFLE_Editor_RemoveAgent = function()
    local selectedAgent = ALIVE_Development_SceneAgentNames[ALIVE_Development_AgentIndex];
    if FOFLE_AgentsMarkedForDeletion[selectedAgent] == nil or FOFLE_AgentsMarkedForDeletion[selectedAgent] == false then
        print("Fofle EDITOR - Mark Agent For Deletion - " .. selectedAgent)
        --Remove Agent
        ALIVE_AgentSetProperty(ALIVE_Development_SceneAgentNames[ALIVE_Development_AgentIndex], "Runtime: Visible", false, kScene)
        FOFLE_AgentsMarkedForDeletion[selectedAgent] = selectedAgent;
        DialogBox_Okay("The agent " .. ALIVE_Development_SceneAgentNames[ALIVE_Development_AgentIndex] .. " has been marked for deletion, and won't appear on the next scene load.", "Marked for deletion");
    else
        print("Fofle EDITOR - UNDO Mark Agent For Deletion - " .. selectedAgent)
        --Add Agent Back
        ALIVE_AgentSetProperty(ALIVE_Development_SceneAgentNames[ALIVE_Development_AgentIndex], "Runtime: Visible", true, kScene)
        FOFLE_AgentsMarkedForDeletion[selectedAgent] = false;
        DialogBox_Okay("The agent " .. ALIVE_Development_SceneAgentNames[ALIVE_Development_AgentIndex] .. " is no longer marked for deletion, and will appear on the next scene load.", "No Longer Marked");
    end
end

FOFLE_Editor_AddAgent = function()
    DialogBox_Okay("Not Yet Implemented", "Add Agent")
end