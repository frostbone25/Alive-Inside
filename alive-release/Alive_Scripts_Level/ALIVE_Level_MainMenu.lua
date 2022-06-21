require("ALIVE_Core_Math.lua");
require("ALIVE_Core_Utilities.lua");
require("ALIVE_Core_AgentExtensions_Properties.lua");
require("ALIVE_Core_AgentExtensions_Transform.lua");
require("ALIVE_Core_AgentExtensions_Utillity.lua");
require("ALIVE_Core_Color.lua");
require("ALIVE_Core_Strings.lua");
require("ALIVE_Core_Printing.lua");
require("ALIVE_Core_PropertyKeys.lua");
require("ALIVE_Development_Freecam.lua");
require("ALIVE_Development_AgentBrowser.lua");
require("ALIVE_Core_Project.lua");

--Enable requisite ResourceSets
ResourceSetEnable("ProjectSeason4");
ResourceSetEnable("WalkingDead404");

--Engine Scene Variables
local kScript = "ALIVE_Level_MainMenu"
local kScene = "adv_boardingSchoolDorm"
local kSceneObj = kScene .. ".scene"

--Cutscene Development Variables
ALIVE_Development_SceneObject = kScene;
ALIVE_Development_SceneObjectAgentName = kSceneObj;
ALIVE_Development_UseSeasonOneAPI = false;
ALIVE_Development_FreecamUseFOVScale = false;

local EnableFreecamTools = true;

--DOF Autofocus Variables
ALIVE_DOF_AUTOFOCUS_SceneObject = kScene;
ALIVE_DOF_AUTOFOCUS_SceneObjectAgentName = kSceneObj;
ALIVE_DOF_AUTOFOCUS_UseCameraDOF = false;

ALIVE_DOF_AUTOFOCUS_GameplayCameraNames = 
{
    "FuckinDontRemoveThis"
};

ALIVE_DOF_AUTOFOCUS_ObjectEntries =
{
    "FuckinDontRemoveThis"
};

ALIVE_MainMenu_PrepareCamera = function()
    local camProp = "module_camera.prop";
    local camPosition = Vector(15.05, 1.13, -4.32);
    local camRotation = Vector(0, 90, 0);

    local menuCamera = AgentCreate("ALIVE_MainMenuCamera", camProp, camPosition, camRotation, kScene, false, false);
    
    ALIVE_AgentSetProperty("ALIVE_MainMenuCamera", "Clip Plane - Far", 2500, kScene);
    ALIVE_AgentSetProperty("ALIVE_MainMenuCamera", "Clip Plane - Near", 0.05, kScene);
    ALIVE_AgentSetProperty("ALIVE_MainMenuCamera", "Lens - Current Lens", nil, kScene);
    ALIVE_RemovingAgentsWithPrefix(kScene, "cam_");

    CameraPush("ALIVE_MainMenuCamera");
end

ALIVE_MainMenu_PrepareAgents = function()
    --Prepare all scene agents
    
    local clemHat = AgentCreate("ALIVE_MainMenuClemHat", "obj_capClementine400.prop", Vector(16.05, 0.55, -4.32), Vector(0, 0, 0), kScene, false, false)
end

ALIVE_Level_MainMenu = function()

    ALIVE_MainMenu_PrepareAgents();

    if (ALIVE_Core_Project_IsDebugMode) and (EnableFreecamTools) then
        --Initialize tools
        ALIVE_Development_CreateFreeCamera();
        ALIVE_Development_InitalizeCutsceneTools();
    
        --Add required callbacks
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateFreeCamera);
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Input);
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Main);
    else
        ALIVE_MainMenu_PrepareCamera();
    end
end

SceneOpen(kScene,kScript)