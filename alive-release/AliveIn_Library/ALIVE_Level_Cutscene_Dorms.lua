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
require("ALIVE_Gameplay_Shared.lua");
require("ALIVE_Scene_LevelCleanup_403_BoardingSchoolDorm.lua");
require("ALIVE_Scene_LevelRelight_403_BoardingSchoolDorm.lua");
require("ALIVE_Project.lua");

--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||

--main level variables
local kScript = "ALIVE_Level_Cutscene_Dorms";
local kScene = "adv_boardingSchoolDorm";
local agent_name_scene = "adv_boardingSchoolDorm.scene"; 

ALIVE_Development_SceneObject = kScene;
ALIVE_Development_SceneObjectAgentName = agent_name_scene;
ALIVE_Development_UseSeasonOneAPI = false;
ALIVE_Development_FreecamUseFOVScale = false;

--|||||||||||||||||||||||||||||||||||||||||||||| SCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||

ResourceSetEnable("UISeason4");
ResourceSetEnable("ProjectSeason4");
ResourceSetEnable("WalkingDead401");
ResourceSetEnable("WalkingDead402");
ResourceSetEnable("WalkingDead403", 950);
ResourceSetEnable("WalkingDead404");

ALIVE_Level_Cutscene_Dorms = function()
    --ALIVE_PrintSceneListToTXT(kScene, "adv_boardingSchoolDorm.txt");

    ALIVE_Project_SetProjectSettings();
    ALIVE_Scene_LevelCleanup_403_BoardingSchoolDorm(kScene);
    --ALIVE_Scene_LevelRelight_403_BoardingSchoolExterior(kScene);

    ALIVE_Gameplay_Shared_HideCusorInGame();

    ---------------------------------------------------
    --freecam
    ALIVE_Development_CreateFreeCamera();
    ALIVE_Development_InitalizeCutsceneTools();

    Callback_OnPostUpdate:Add(ALIVE_Development_UpdateFreeCamera);
    Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Input);
    Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Main);
end

SceneOpen(kScene, kScript)