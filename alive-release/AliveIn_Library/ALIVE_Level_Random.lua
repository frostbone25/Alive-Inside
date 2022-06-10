require("ALIVE_Core_Utilities.lua");
require("ALIVE_Core_AgentExtensions.lua");
require("ALIVE_Core_Color.lua");
require("ALIVE_Core_Printing.lua");
require("ALIVE_Core_PropertyKeys.lua");
require("ALIVE_Development_Freecam.lua");
require("ALIVE_Development_AgentBrowser.lua");
require("ALIVE_Camera_DepthOfFieldAutofocus.lua");
require("ALIVE_Gameplay_Player_ThirdPerson.lua");
require("ALIVE_Gameplay_AI_Zombies.lua");
require("ALIVE_Scene_LevelCleanup.lua");
require("ALIVE_Scene_LevelRelight.lua");
require("ALIVE_Project.lua");

--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||

--main level variables
local kScript = "ALIVE_Level_Random";

--adv_boatTownShoreTreeline
--adv_boatTownShoreLineView
--adv_boatTownApproachTile
--adv_boatTownApproach
local kScene = "adv_shorelineApproachWoods";
local agent_name_scene = "adv_shorelineApproachWoods.scene"; 


--local kScene = "adv_shorelineApproachWoods";
--local agent_name_scene = "adv_shorelineApproachWoods.scene"; 

ThirdPerson_kScene = kScene;
ZombieAI_kScene = kScene;

ALIVE_Development_SceneObject = kScene;
ALIVE_Development_SceneObjectAgentName = agent_name_scene;
ALIVE_Development_UseSeasonOneAPI = false;
ALIVE_Development_FreecamUseFOVScale = false;

--dof autofocus variables
ALIVE_DOF_AUTOFOCUS_SceneObject = kScene;
ALIVE_DOF_AUTOFOCUS_SceneObjectAgentName = agent_name_scene;
ALIVE_DOF_AUTOFOCUS_UseCameraDOF = true;

--list of gameplay camera agent names, putting a camera name in here means that DOF will be disabled since its a gameplay camera, and we dont want DOF during gameplay.
ALIVE_DOF_AUTOFOCUS_GameplayCameraNames = 
{
    "nil"
};

--list of objects in the scene that are our targets for depth of field autofocusing
ALIVE_DOF_AUTOFOCUS_ObjectEntries =
{
    "AJ"
};

--|||||||||||||||||||||||||||||||||||||||||||||| SCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||

ResourceSetEnable("ProjectSeasonM");
ResourceSetEnable("WalkingDeadM101");
ResourceSetEnable("WalkingDeadM102");
ResourceSetEnable("WalkingDeadM103");

HideCusorInGame = function()
    CursorHide(true);
    CursorEnable(true);
end

ALIVE_Level_Random = function()
    --ALIVE_Project_SetProjectSettings();
    --ALIVE_Scene_LevelCleanup_BoardingSchoolExterior403(kScene);
    --ALIVE_Scene_LevelRelight_BoardingSchoolExterior403(kScene);

    --HideCusorInGame();

    --local cnt = ChorePlay("env_shorelineApproachWoods_cs_ENTER_7.chore");
    local cnt = ChorePlay("env_boatTownShoreline_escape_cs_ENTER_23.chore");
    ControllerSetLooping(cnt, true);
    --ALIVE_PrintChoreAgentNames("env_boatTownShoreline_escape_cs_ENTER_23.chore");
end

SceneOpen(kScene, kScript)