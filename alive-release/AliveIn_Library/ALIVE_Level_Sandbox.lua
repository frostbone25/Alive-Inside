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
require("ALIVE_Gameplay_Player_ThirdPerson_Base.lua");
require("ALIVE_Gameplay_AI_Zombies.lua");
require("ALIVE_Scene_LevelCleanup_305_RichmondOverpass.lua");
require("ALIVE_Scene_LevelCleanup_305_RichmondStreetTile.lua");
require("ALIVE_Scene_LevelCleanup_403_BoardingSchoolExterior.lua");
require("ALIVE_Scene_LevelRelight_305_RichmondOverpass.lua");
require("ALIVE_Scene_LevelRelight_305_RichmondStreetTile.lua");
require("ALIVE_Scene_LevelRelight_403_BoardingSchoolExterior.lua");
require("ALIVE_Scene_CharacterStates.lua");
require("ALIVE_Project.lua");

--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||

--main level variables
local kScript = "ALIVE_Level_Sandbox";
local kScene = "adv_boardingSchoolExterior";
local agent_name_scene = "adv_boardingSchoolExterior.scene"; 
--local kScene = "adv_richmondOverpass";
--local agent_name_scene = "adv_richmondOverpass.scene"; 
--local kScene = "adv_richmondStreetTile";
--local agent_name_scene = "adv_richmondStreetTile.scene"; 

ThirdPerson_kScene = kScene;
ZombieAI_kScene = kScene;

ALIVE_Development_SceneObject = kScene;
ALIVE_Development_SceneObjectAgentName = agent_name_scene;
ALIVE_Development_UseSeasonOneAPI = false;
ALIVE_Development_FreecamUseFOVScale = false;

local EnableFreecam = false;

--|||||||||||||||||||||||||||||||||||||||||||||| SCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||

ResourceSetEnable("UISeason4");
ResourceSetEnable("ProjectSeason4");
ResourceSetEnable("WalkingDead401");
ResourceSetEnable("WalkingDead402");
ResourceSetEnable("WalkingDead403");
ResourceSetEnable("WalkingDead404");

--ResourceSetEnable("ProjectSeason3", 1000);
--ResourceSetEnable("WalkingDead301", 1200);
--ResourceSetEnable("WalkingDead302", 1300);
--ResourceSetEnable("WalkingDead303", 1400);
--ResourceSetEnable("WalkingDead304", 1500);
--ResourceSetEnable("WalkingDead305", 1600);

local PlayTempSoundtrack = function()
    local musicController = SoundPlay("music_temp_action1.wav");
    --local musicController = SoundPlay("music_temp_action1.wav");
    ControllerSetLooping(musicController, true);
    --ControllerSetVolume(musicController, 0.25);
    ControllerSetSoundVolume(musicController, 0.25);

    --local controller_sound_soundtrack = SoundPlay("custom_soundtrack1.wav");
    
    ----set it to loop
    --ControllerSetLooping(controller_sound_soundtrack, true)
end

ALIVE_Level_Sandbox = function()
    --ALIVE_PrintSceneListToTXT(kScene, "adv_boardingSchoolExterior.txt");
    --ALIVE_PrintSceneListToTXT(kScene, "adv_richmondOverpass.txt");
    --ALIVE_PrintSceneListToTXT(kScene, "adv_richmondStreetTile.txt");
    --ALIVE_PrintValidPropertyNames("fx_lightShaft01", kScene);
    --ALIVE_PrintValidPropertyNames("fx_camPollen", kScene);
    --ALIVE_PrintValidPropertyNames("fxg_bloodBleedDirRad", kScene);
    --ALIVE_PrintValidPropertyNames("obj_capClementine400", kScene);
    --ALIVE_PrintValidPropertyNames("AJ", kScene);
    --ALIVE_PrintValidPropertyNames("Clementine", kScene);
    --ALIVE_PrintValidPropertyNames("adv_boardingSchoolExterior_meshesABuilding", kScene);
    --ALIVE_PrintValidPropertyNames("obj_skydome", kScene);

    ALIVE_Project_SetProjectSettings();
    ALIVE_Scene_LevelCleanup_403_BoardingSchoolExterior(kScene);
    ALIVE_Scene_LevelRelight_403_BoardingSchoolExterior(kScene);

    --ALIVE_Scene_LevelCleanup_305_RichmondOverpass(kScene);
    --ALIVE_Scene_LevelRelight_305_RichmondOverpass(kScene);

    --ALIVE_Scene_LevelCleanup_305_RichmondStreetTile(kScene);
    --ALIVE_Scene_LevelRelight_305_RichmondStreetTile(kScene);

    ALIVE_Gameplay_Shared_HideCusorInGame();
    PlayTempSoundtrack();

    --ChorePlay("ui_death_show.chore");

    --kUIChoreClose = "UI Scene - Chore Close"
    --kUIChoreOpen = "UI Scene - Chore Open"

    --SceneAdd("ui_death");
    --ChorePlayAndWait(AgentGetProperty(SceneGetSceneAgent("ui_death"), "UI Scene - Chore Open"));

    --Callback_OnPostUpdate:Add(PerformAutofocusDOF);

    --DoSandraStuff();

    --sk62_action_sandraGrabZombieLeg.chore
    --ALIVE_PrintChoreAgentNames("sk62_action_sandraGrabZombieLeg.chore")

    if (EnableFreecam == true) then
        ALIVE_Development_CreateFreeCamera();
        ALIVE_Development_InitalizeCutsceneTools();

        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateFreeCamera);
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Input);
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Main);
    else
        SceneAdd(ThirdPerson_UI_kScene);
        ALIVE_Gameplay_CreateThirdPersonController(Vector(15, 0, 0));
        --ALIVE_Gameplay_CreateThirdPersonController();
        --ALIVE_Gameplay_CreateThirdPersonController(Vector(0, 0, 15));
        ALIVE_Gameplay_AI_CreateZombies(10, Vector(0, 0, 17), Vector(15, 0, 15));
        --ALIVE_Gameplay_AI_CreateZombies(200, Vector(0, 0, 0), Vector(10, 0, 10));
    end

    ALIVE_Scene_SetCharacterState_AJ(kScene);
    ALIVE_Scene_SetCharacterState_AJ_KennyHat(kScene);
    ALIVE_Scene_SetCharacterState_Clementine(kScene);
end

SceneOpen(kScene, kScript)
--SceneAdd("ui_death");
--SceneAdd("ui_vignette.scene");
--SceneAdd("ui_panicMeter.scene");
--SceneAdd("ui_crosshair.scene");
--ChorePlayAndWait(AgentGetProperty(AgentFindInScene("ui_death.scene", "ui_death"), "UI Scene - Chore Open"));