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

--dof autofocus variables
ALIVE_DOF_AUTOFOCUS_SceneObject = kScene;
ALIVE_DOF_AUTOFOCUS_SceneObjectAgentName = agent_name_scene;
ALIVE_DOF_AUTOFOCUS_UseCameraDOF = false;

--list of gameplay camera agent names, putting a camera name in here means that DOF will be disabled since its a gameplay camera, and we dont want DOF during gameplay.
ALIVE_DOF_AUTOFOCUS_GameplayCameraNames = 
{
    "nil"
};

--list of objects in the scene that are our targets for depth of field autofocusing
ALIVE_DOF_AUTOFOCUS_ObjectEntries =
{
    "AJ_Parent"
};

--|||||||||||||||||||||||||||||||||||||||||||||| SCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||

--ResourceSetEnable("UISeason4");
--ResourceSetEnable("ProjectSeason4");
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

HideCusorInGame = function()
    CursorHide(true);
    CursorEnable(true);
end

local DoSandraStuff = function()

    ResourceSetEnable("ProjectSeason1");
    ResourceSetEnable("WalkingDead101");

    local clem100 = AgentCreate("Clementine100", "sk56_clementine.prop", Vector(0,0,0), Vector(0, 0, 0), kScene, false, false);
    local sandra100 = AgentCreate("Sandra100", "sk62_lilly.prop", Vector(0,0,0), Vector(0, 0, 0), kScene, false, false);




    --local clem_anmClip = "sk63_clementine100_sk62_idle_sandraHugClem.anm";
    --local sandra_anmClip = "sk62_idle_sandraHugClem.anm";

    local clem_anmClip = "sk63_clementine100_sk62_action_sandraTickleClem.anm";
    local sandra_anmClip = "sk62_action_sandraTickleClem.anm";

    local clem100_cnt1 = PlayAnimation(clem100, clem_anmClip);
    local sandra100_cnt1 = PlayAnimation(sandra100, sandra_anmClip);

    ControllerSetLooping(clem100_cnt1, true);
    ControllerSetLooping(sandra100_cnt1, true);

end

local SetCharacterStates = function()
    AgentSetState("AJ", "bodyJacketDisco");
    AgentSetState("Clementine", "bodyLowerLegMissing");

    local myTextureeee = "sk62_clementine400_bodyLowerPantsBittenB.d3dtx";
    --local myTextureeee = "texture_clementine_bloody_stump.d3dtx";
    --local myTextureeee = "color_fff0000.d3dtx"; --red
    --local myTextureeee = "color_fff.d3dtx"; --white

    ALIVE_AgentSetProperty("Clementine", "sk62_clementine400_head_m - Diffuse Texture", "sk62_clementine400_headDyingD.d3dtx", kScene);
    ALIVE_AgentSetProperty("Clementine", "sk62_clementine400_eyes_m - Diffuse Texture", "sk62_clementine400_eyesDying.d3dtx", kScene);
    ALIVE_AgentSetProperty("Clementine", "sk62_clementine400_bodyLowerLegMissing_m - Diffuse Texture", myTextureeee, kScene);
    ALIVE_AgentSetProperty("Clementine", "sk62_clementine400_bodyLowerBitten_m - Diffuse Texture", myTextureeee, kScene);
    ALIVE_AgentSetProperty("Clementine", "sk62_clementine400_bodyLowerOutfitA_m - Diffuse Texture", myTextureeee, kScene);
    --texture_clementine_bloody_stump.d3dtx
    --ALIVE_PrintValidPropertyNames(AgentFindInScene("Clementine", ThirdPerson_kScene));
    --ALIVE_PrintProperties(AgentFindInScene("Clementine", ThirdPerson_kScene));

    --ALIVE_GetCacheObjectNameFromProperty(AgentFindInScene("Clementine", ThirdPerson_kScene), "sk62_clementine400_head_m - Diffuse Texture");
    --ALIVE_GetCacheObjectNamesFromProperties(AgentFindInScene("Clementine", ThirdPerson_kScene), "cleanedCacheObjectsList404.txt");



    --bodyLowerLegMissing

    --[[
        NOTE TO SELF:
        for properties with Handle<T3Texture> type, typically they have cached object and then a string of numbers
        we could try perhaps by taking that single field and running strings.txt through it.
        basically getting the inital field value, then setting it, then getting the value again and printing it, then repeat
    ]]--

    --local ajProps = AgentGetProperties(agent_character);
    --local clemProps = AgentGetProperties(AgentFindInScene("Clementine", ThirdPerson_kScene));
    --local textureOverride = "color_000.d3dtx"; --black

    --adv_boardingSchoolExterior_module_lightprobe.d3dtx
    --ALIVE_SetPropertyBySymbol(clemProps, "98822971867575553", textureOverride);

    --local myTexture = "color_fff.d3dtx"; --white
    --local myTexture = "color_fff0000.d3dtx"; --red
    --local myTexture = "color_818181.d3dtx"; --grey
    --local myTexture = "color_666666.d3dtx"; --dark grey
    --local myTexture = "color_000.d3dtx"; --black
    --ALIVE_GetCacheObjectNamesFromProperties(AgentFindInScene("AJ", ThirdPerson_kScene), "cleanedCacheObjectsList404.txt");

    --set aj spec
    --local ajSpecOverride = "color_818181.d3dtx"; --grey
    --local ajSpecOverride = "color_fff.d3dtx"; --white
    --local ajSpecOverride = "color_666666.d3dtx"; --dark grey
    --local ajSpecOverride = "color_000.d3dtx"; --black
    --ALIVE_AgentSetPropertyBySymbol("AJ", "990463370724338236", ajSpecOverride, ThirdPerson_kScene);
    --ALIVE_AgentSetPropertyBySymbol("AJ", "1463902169883331120", ajSpecOverride, ThirdPerson_kScene);
    --ALIVE_AgentSetPropertyBySymbol("AJ", "5661132411227395665", ajSpecOverride, ThirdPerson_kScene);
    --ALIVE_AgentSetPropertyBySymbol("AJ", "11664515276069663068", ajSpecOverride, ThirdPerson_kScene);
    --ALIVE_AgentSetPropertyBySymbol("AJ", "13884686417410322160", ajSpecOverride, ThirdPerson_kScene);

    --ALIVE_AgentSetPropertyBySymbol("AJ", "16751189380505258298", myTexture, kScene);

    --ALIVE_AgentSetProperty("AJ", "obj_gunRevolverClothwrap_m - Diffuse Texture", myTexture, ThirdPerson_kScene);
    --ALIVE_AgentSetProperty("AJ", "obj_gunRevolver_m - Diffuse Texture", myTexture, ThirdPerson_kScene);
    --ALIVE_AgentSetProperty("AJ", "sk63_aj_bodyLower_m - Diffuse Texture", myTexture, ThirdPerson_kScene);
    --ALIVE_AgentSetProperty("AJ", "sk63_aj_bodyUpperJacket_m - Diffuse Texture", myTexture, ThirdPerson_kScene);
    --ALIVE_AgentSetProperty("AJ", "sk63_aj_head_m - Diffuse Texture", myTexture, ThirdPerson_kScene);

    --ALIVE_AgentSetProperty("AJ", "obj_gunRevolverClothwrap_m - Specular Map Texture", myTexture, ThirdPerson_kScene);
    --ALIVE_AgentSetProperty("AJ", "obj_gunRevolver_m - Specular Map Texture", myTexture, ThirdPerson_kScene);
    --ALIVE_AgentSetProperty("AJ", "sk63_aj_bodyLower_m - Specular Map Texture", myTexture, ThirdPerson_kScene);
    --ALIVE_AgentSetProperty("AJ", "sk63_aj_bodyUpperJacket_m - Specular Map Texture", myTexture, ThirdPerson_kScene);
    --ALIVE_AgentSetProperty("AJ", "sk63_aj_head_m - Specular Map Texture", myTexture, ThirdPerson_kScene);
    
    --local ajProps = AgentGetRuntimeProperties(agent_character);
    --local ajModels = AgentToModels(agent_character);
    --local testAJ = PropertyGet(ajProps, "Mesh sk63_aj_bodyLower");
    --local ajMesh = PropertyGet(ajProps, "D3D Mesh");
    --local ajMeshList = PropertyGet(ajProps, "D3D Mesh List");

    --for x, mesh in ipairs(ajMeshList) do
    --    MeshSetDiffuseTexture(mesh, "color_fff.d3dtx");
    --end



    --for x, mesh in ipairs(ajModels) do
    --   MeshSetDiffuseTexture(mesh, "color_fff.d3dtx");
    --end

    --MeshSetDiffuseTexture(ajMesh, "color_fff.d3dtx");
    --MeshSetDiffuseTexture(testAJ, "color_fff.d3dtx");

    --ShaderSwapTexture

    --PropertySet(ajProps, "", );

    --MeshSetDiffuseTexture

    --D3D Mesh
    --D3D Mesh List

    --PropertySet(ajProps, "Mesh sk63_aj_bodyLower - Visible", false);
    --PropertySet(ajProps, "Material sk63_aj_bodyLower - Texture", "color_fff.d3dtx");
    --PropertySet(ajProps, "sk63_aj_bodyLower - Texture", "color_fff.d3dtx");
    --PropertySet(ajProps, "material_sk63_aj_bodyLower - Texture", "color_fff.d3dtx");
    --PropertySet(ajProps, "material_sk63_aj_bodyLower - Diffuse Texture", "color_fff.d3dtx");
    --ALIVE_PrintProperties(agent_character)
end

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

    HideCusorInGame();
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

    --if (EnableFreecam == true) then
        --ALIVE_Development_CreateFreeCamera();
        --ALIVE_Development_InitalizeCutsceneTools();

        --Callback_OnPostUpdate:Add(ALIVE_Development_UpdateFreeCamera);
        --Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Input);
        --Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Main);
    --else
        ALIVE_Gameplay_CreateThirdPersonController(Vector(15, 0, 0));
        --ALIVE_Gameplay_CreateThirdPersonController();
        --ALIVE_Gameplay_CreateThirdPersonController(Vector(0, 0, 15));
        ALIVE_Gameplay_AI_CreateZombies(5, Vector(0, 0, 17), Vector(15, 0, 15));
        --ALIVE_Gameplay_AI_CreateZombies(200, Vector(0, 0, 0), Vector(10, 0, 10));
    --end

    ALIVE_Scene_SetCharacterState_AJ(kScene);
    ALIVE_Scene_SetCharacterState_Clementine(kScene);

    --SetCharacterStates();
end

SceneOpen(kScene, kScript)
--SceneAdd("ui_death");
--ChorePlayAndWait(AgentGetProperty(AgentFindInScene("ui_death.scene", "ui_death"), "UI Scene - Chore Open"));