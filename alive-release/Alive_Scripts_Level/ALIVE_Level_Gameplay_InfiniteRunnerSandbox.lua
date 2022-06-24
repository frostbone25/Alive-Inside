require("ALIVE_Core_Inclusions.lua");
require("ALIVE_Gameplay_Shared.lua");
require("ALIVE_Character_AJ.lua");
require("ALIVE_Character_Clementine.lua");
require("ALIVE_Scene_LevelCleanup_401_ForestTile.lua");
require("ALIVE_Core_Project.lua");

--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||

--main level variables
local kScript = "ALIVE_Level_Gameplay_InfiniteRunnerSandbox";
local kScene = "adv_forestTile"; --401/402
local agent_name_scene = "adv_forestTile.scene";  --401/402

ThirdPerson_kScene = kScene;
ZombieAI_kScene = kScene;

ALIVE_Development_SceneObject = kScene;
ALIVE_Development_SceneObjectAgentName = agent_name_scene;
ALIVE_Development_UseSeasonOneAPI = false;
ALIVE_Development_FreecamUseFOVScale = false;

local EnableFreecamTools = true;
local EnablePerformanceMetrics = true;

--|||||||||||||||||||||||||||||||||||||||||||||| SCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||

ResourceSetEnable("UISeason4");
ResourceSetEnable("ProjectSeason4");
ResourceSetEnable("ProjectSeason1");
ResourceSetEnable("WalkingDead401", 950);
ResourceSetEnable("WalkingDead402");
ResourceSetEnable("WalkingDead403");
ResourceSetEnable("WalkingDead404");

local PlayTempSoundtrack = function()
    local musicController = SoundPlay("music_temp_action1.wav");
    ControllerSetLooping(musicController, true);
    ControllerSetSoundVolume(musicController, 0.25);
end

local WheelBarrowSpawn = function()
    local wheelBarrow = AgentCreate("wheelBarrow", "obj_wheelBarrow.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    --local objectTest1 = AgentCreate("objectTest1", "obj_trowel.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    --local objectTest2 = AgentCreate("objectTest2", "obj_pullCartA.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
end

ALIVE_Level_Gameplay_InfiniteRunnerSandbox = function()
    --ALIVE_PrintSceneListToTXT(kScene, "adv_forestTile401.txt");
    --ALIVE_PrintValidPropertyNames("fx_lightShaft01", kScene);

    ALIVE_Core_Project_SetProjectSettings();
    ALIVE_Scene_LevelCleanup_401_ForestTile(kScene);
    --ALIVE_Scene_LevelRelight_403_BoardingSchoolExterior(kScene);

    --WheelBarrowSpawn();

    ALIVE_Gameplay_Shared_HideCusorInGame();
    --PlayTempSoundtrack(); 

    if (ALIVE_Core_Project_IsDebugMode) then
        if(EnableFreecamTools) then
            --Initialize tools
            ALIVE_Development_CreateFreeCamera();
            ALIVE_Development_InitalizeCutsceneTools();
    
            --Add required callbacks
            Callback_OnPostUpdate:Add(ALIVE_Development_UpdateFreeCamera);
            Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Input);
            Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Main);
        end

        if(EnablePerformanceMetrics) then
            ALIVE_Development_PerformanceMetrics_Initalize();
            Callback_OnPostUpdate:Add(ALIVE_Development_PerformanceMetrics_Update);
        end
    end

    ALIVE_Character_AJ_Jackets(kScene);
    ALIVE_Character_AJ_KennyHat(kScene);
    --ALIVE_Character_AJ_ClementineHat(kScene);
    ALIVE_Character_Clementine_Sick(kScene);
end

SceneOpen(kScene, kScript)