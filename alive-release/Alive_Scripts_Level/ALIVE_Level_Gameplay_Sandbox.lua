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
require("ALIVE_Character_AJ.lua");
require("ALIVE_Character_Clementine.lua");
require("ALIVE_Core_Project.lua");

--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||

--main level variables
local kScript = "ALIVE_Level_Gameplay_Sandbox";
local kScene = "adv_boardingSchoolExterior";
local agent_name_scene = "adv_boardingSchoolExterior.scene"; 
--local kScene = "adv_richmondOverpass";
--local agent_name_scene = "adv_richmondOverpass.scene"; 
--local kScene = "adv_richmondStreetTile";
--local agent_name_scene = "adv_richmondStreetTile.scene"; 
--local kScene = "adv_boardingSchoolInterior"; --401/402/403
--local agent_name_scene = "adv_boardingSchoolInterior.scene";  --401/402/403
--local kScene = "adv_boardingSchoolInteriorNight"; --402
--local agent_name_scene = "adv_boardingSchoolInteriorNight.scene";  --402
--local kScene = "adv_dormRoom"; --402
--local agent_name_scene = "adv_dormRoom.scene";  --402
--local kScene = "adv_bellTower"; --402
--local agent_name_scene = "adv_bellTower.scene";  --402
--local kScene = "adv_boardingSchoolExteriorGate"; --401/402/404
--local agent_name_scene = "adv_boardingSchoolExteriorGate.scene";  --401/402/404
--local kScene = "adv_boardingSchoolDorm"; --401/402/403/404
--local agent_name_scene = "adv_boardingSchoolDorm.scene";  --401/402/403/404
--local kScene = "adv_greenHouse"; --402
--local agent_name_scene = "adv_greenHouse.scene";  --402

--season 3
--local kScene = "adv_richmondMedical"; --303
--local agent_name_scene = "adv_richmondMedical.scene"; --303
--local kScene = "adv_richmondArmoryInterior"; --304
--local agent_name_scene = "adv_richmondArmoryInterior.scene"; --304
--local kScene = "adv_richmondQuarantineInterior"; --303
--local agent_name_scene = "adv_richmondQuarantineInterior.scene"; --303
--local kScene = "adv_richmondApartment"; --304
--local agent_name_scene = "adv_richmondApartment.scene"; --304
--local kScene = "adv_richmondMedical304"; --304
--local agent_name_scene = "adv_richmondMedical304.scene"; --304


ThirdPerson_kScene = kScene;
ZombieAI_kScene = kScene;

ALIVE_Development_SceneObject = kScene;
ALIVE_Development_SceneObjectAgentName = agent_name_scene;
ALIVE_Development_UseSeasonOneAPI = false;
ALIVE_Development_FreecamUseFOVScale = false;

local EnableFreecam = true;

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

--ResourceSetEnable("ProjectSeason3", 1000);
--ResourceSetEnable("WalkingDead301", 1200);
--ResourceSetEnable("WalkingDead302", 1300);
--ResourceSetEnable("WalkingDead303", 1400);
--ResourceSetEnable("WalkingDead304", 1500);
--ResourceSetEnable("WalkingDead305", 1600);

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

ALIVE_Level_Gameplay_Sandbox = function()
    --ALIVE_PrintSceneListToTXT(kScene, "adv_boardingSchoolExterior.txt");
    --ALIVE_PrintValidPropertyNames("fx_lightShaft01", kScene);

    ALIVE_Core_Project_SetProjectSettings();
    ALIVE_Scene_LevelCleanup_403_BoardingSchoolExterior(kScene);
    ALIVE_Scene_LevelRelight_403_BoardingSchoolExterior(kScene);

    --ALIVE_Scene_LevelCleanup_305_RichmondOverpass(kScene);
    --ALIVE_Scene_LevelRelight_305_RichmondOverpass(kScene);

    --ALIVE_Scene_LevelCleanup_305_RichmondStreetTile(kScene);
    --ALIVE_Scene_LevelRelight_305_RichmondStreetTile(kScene);

    --WheelBarrowSpawn();

    ALIVE_Gameplay_Shared_HideCusorInGame();
    --PlayTempSoundtrack(); 

    if (EnableFreecam == true) then
        ALIVE_Development_CreateFreeCamera();
        --ALIVE_Development_InitalizeCutsceneTools();

        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateFreeCamera);
        --Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Input);
        --Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Main);
    else
        SceneAdd(ThirdPerson_UI_kScene);
        ALIVE_Gameplay_CreateThirdPersonController(Vector(15, 0, 0));
        ALIVE_Gameplay_AI_CreateZombies(10, Vector(0, 0, 17), Vector(15, 0, 15));
    end

    ALIVE_Character_AJ_Jackets(kScene);
    --ALIVE_Character_AJ_KennyHat(kScene);
    ALIVE_Character_AJ_ClementineHat(kScene);
    ALIVE_Character_Clementine_Sick(kScene);
end

SceneOpen(kScene, kScript)