--[[

]]--

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
require("ALIVE_Camera_DepthOfFieldAutofocus.lua");
require("ALIVE_Gameplay_Shared.lua");
require("ALIVE_Scene_CharacterStates.lua");
require("ALIVE_Scene_LevelCleanup_403_TrainTile.lua");
require("ALIVE_Scene_LevelRelight_403_TrainTile.lua");
require("ALIVE_Project.lua");

ResourceSetEnable("ProjectSeason4");
ResourceSetEnable("WalkingDead401");
ResourceSetEnable("WalkingDead402");
ResourceSetEnable("WalkingDead403");
ResourceSetEnable("WalkingDead404");
ResourceSetEnable("WalkingDead201");

--ResourceSetEnable("ProjectSeason3", 1000);
--ResourceSetEnable("WalkingDead301", 1200);
--ResourceSetEnable("WalkingDead302", 1300);
--ResourceSetEnable("WalkingDead303", 1400);
--ResourceSetEnable("WalkingDead304", 1500);
--ResourceSetEnable("WalkingDead305", 1600);



--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||

--main level variables
local kScript = "ALIVE_Level_Flashback";
local kScene = "adv_trainTile";
--local kScene = "adv_virginiaRailroad";

ThirdPerson_kScene = kScene;
ZombieAI_kScene = kScene;

--scene agent name variable
local agent_name_scene = kScene .. ".scene"; 

ALIVE_Development_SceneObject = kScene;
ALIVE_Development_SceneObjectAgentName = agent_name_scene;
ALIVE_Development_UseSeasonOneAPI = false;
ALIVE_Development_FreecamUseFOVScale = false;

local EnableFreecam = false;

--dof autofocus variables
ALIVE_DOF_AUTOFOCUS_SceneObject = kScene;
ALIVE_DOF_AUTOFOCUS_SceneObjectAgentName = agent_name_scene;
ALIVE_DOF_AUTOFOCUS_UseCameraDOF = true;

--list of gameplay camera agent names, putting a camera name in here means that DOF will be disabled since its a gameplay camera, and we dont want DOF during gameplay.
ALIVE_DOF_AUTOFOCUS_GameplayCameraNames = 
{
    "test"
};

--list of objects in the scene that are our targets for depth of field autofocusing
ALIVE_DOF_AUTOFOCUS_ObjectEntries =
{
    "AJ"
};

Custom_DarkenAllSceneCameras = function()
    --get all agents in the scene
    local scene_agents = SceneGetAgents(kScene);

    --fill out rig agents list
    for i, agent_object in ipairs(scene_agents) do
        --grab the camera property set on an agent
        local agent_camera = AgentGetCamera(agent_object);
        
        --if there is infact a camera property set on an agent (meaning that its a camera)
        if (cameraTest ~= nil) then
            --get the agent object property set
            local agent_props = AgentGetRuntimeProperties(agent_object);

            --set the exposure property on the cameras to a really small value
            PropertySet(agent_props, "Exposure", -100);
        end
    end
end

ALIVE_Level_Flashback = function()
    ALIVE_Project_SetProjectSettings();
    
    ALIVE_Scene_LevelCleanup_403_TrainTile(kScene);
    --ALIVE_Scene_LevelRelight_403_TrainTile(kScene);

    ALIVE_Gameplay_Shared_HideCusorInGame();

    --Custom_DarkenAllSceneCameras();

    --ALIVE_PrintSceneListToTXT(kScene, "adv_trainTile403.txt");

    --if (EnableFreecam == true) then
        ALIVE_Development_CreateFreeCamera();
        ALIVE_Development_InitalizeCutsceneTools();

        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateFreeCamera);

        --ALIVE_Gameplay_CreateThirdPersonController(true, Vector(0, 0, 11));
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Input);
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Main);
    --else
        --ALIVE_Gameplay_CreateThirdPersonController(true, Vector(0, 0, 11));
        --Callback_OnPostUpdate:Add(ALIVE_Gameplay_UpdateThirdPerson_Input);
        --Callback_OnPostUpdate:Add(ALIVE_Gameplay_UpdateThirdPerson_Camera);
        --Callback_OnPostUpdate:Add(ALIVE_Gameplay_UpdateThirdPerson_Character);
        --Callback_OnPostUpdate:Add(ALIVE_Gameplay_UpdateThirdPerson_CharacterAnimation);
        --Callback_OnPostUpdate:Add(ALIVE_Gameplay_UpdateThirdPerson_CameraAnimation);

        --ALIVE_Gameplay_AI_CreateZombie(Vector(0, 0, 17));
        --Callback_OnPostUpdate:Add(ALIVE_Gameplay_AI_UpdateZombie_Character);
        --Callback_OnPostUpdate:Add(ALIVE_Gameplay_AI_UpdateZombie_CharacterAnimation);
    --end

    Custom_DarkenAllSceneCameras();
end

SceneOpen(kScene, kScript)