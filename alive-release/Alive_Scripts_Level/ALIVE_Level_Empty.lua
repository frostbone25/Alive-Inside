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
local kScript = "ALIVE_Level_Empty"
local kScene = "adv_forestBarn"
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

ALIVE_Level_Empty = function()
    if (ALIVE_Core_Project_IsDebugMode) and (EnableFreecamTools) then
        --Initialize tools
        ALIVE_Development_CreateFreeCamera();
        ALIVE_Development_InitalizeCutsceneTools();
    
        --Add required callbacks
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateFreeCamera);
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Input);
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Main);
    end
end

SceneOpen(kScene,kScript)