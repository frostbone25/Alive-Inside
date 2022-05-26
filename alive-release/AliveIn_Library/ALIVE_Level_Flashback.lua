--[[

]]--

require("ALIVE_Utilities.lua");
require("ALIVE_AgentExtensions.lua");
require("ALIVE_Color.lua");
require("ALIVE_Printing.lua");
require("ALIVE_PropertyKeys.lua");
require("ALIVE_Development_Freecam.lua");
require("ALIVE_Development_AgentBrowser.lua");
require("ALIVE_DepthOfFieldAutofocus.lua");
require("ALIVE_Gameplay_Player_ThirdPerson.lua");
require("ALIVE_Gameplay_AI_Zombies.lua");

ResourceSetEnable("ProjectSeason4");
ResourceSetEnable("WalkingDead402");
ResourceSetEnable("WalkingDead403");
ResourceSetEnable("WalkingDead404");
ResourceSetEnable("WalkingDead201");

--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||

--main level variables
local kScript = "ALIVE_Level_Flashback";
local kScene = "adv_trainTile";

ThirdPerson_kScene = kScene;
ZombieAI_kScene = kScene;

--scene agent name variable
local agent_name_scene = "adv_trainTile.scene"; 

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

local SetProjectSettings = function()
    local prefs = GetPreferences();
    PropertySet(prefs, "Enable Graphic Black", false);
    PropertySet(prefs, "Render - Graphic Black Enabled", false);
    PropertySet(prefs, "Camera Lens Engine", false);
    PropertySet(prefs, "Enable Dialog System 2.0", true);
    PropertySet(prefs, "Enable LipSync 2.0", true);
    PropertySet(prefs, "Legacy Light Limits", false);
    PropertySet(prefs, "Render - Feature Level", 1);
    PropertySet(prefs, "Use Legacy DOF", true);
    PropertySet(prefs, "Animated Lookats Active", true);
    PropertySet(prefs, "Camera Lens Engine", false);
    PropertySet(prefs, "Chore End Lipsync Buffer Time", -1);
    PropertySet(prefs, "Enable Callbacks For Unchanged Key Sets", true);
    PropertySet(prefs, "Enable Lipsync Line Buffers", false);
    PropertySet(prefs, "Fix Pop In Additive Idle Transitions", false);
    PropertySet(prefs, "Fix Recursive Animation Contribution (set to false before Thrones)", true);
    PropertySet(prefs, "Legacy Use Default Lighting Group", true);
    PropertySet(prefs, "Lipsync Line End Buffer", 0);
    PropertySet(prefs, "Lipsync Line Start Buffer", 0);
    PropertySet(prefs, "Mirror Non-skeletal Animations", true);
    PropertySet(prefs, "Project Generates Procedural Look At Targets", true);
    PropertySet(prefs, "Remap bad bones", true);
    PropertySet(prefs, "Set Default Intensity", false);
    PropertySet(prefs, "Strip action lines", true);
    PropertySet(prefs, "Text Leading Fix", true);
end

--|||||||||||||||||||||||||||||||||||||||||||||| SCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||

Scene_CleanUpOriginalScene = function()
    --local test1 = AgentCreate("zombs", "sk61_zombie400.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    --local test1 = AgentCreate("zombs", "zombie.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    --local test1 = AgentCreate("zombs", "sk61_zombie400Sherak.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    --ALIVE_AgentSetProperty("zombs", "Runtime: Visible", true, kScene);

    ALIVE_RemovingAgentsWithPrefix(kScene, "light_CHAR_CC");
    ALIVE_RemovingAgentsWithPrefix(kScene, "lightrig");
    ALIVE_RemovingAgentsWithPrefix(kScene, "audio_");
    ALIVE_RemovingAgentsWithPrefix(kScene, "fx_");
    ALIVE_RemovingAgentsWithPrefix(kScene, "fxg_");
    ALIVE_RemovingAgentsWithPrefix(kScene, "fxa_");
    ALIVE_RemovingAgentsWithPrefix(kScene, "obj_lookAt");
    
    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "Zombie", "Runtime: Visible", true)
    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "Zombie", "Runtime: Visible", false)

    ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "adv_", "Runtime: Visible", true)
    ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "obj_", "Runtime: Visible", true)
    --ALIVE_RemovingAgentsWithPrefix(kScene, "Zombie");
    
    --ALIVE_AgentSetProperty("group_tile1", "Group - Visible", false, kScene);

    ALIVE_AgentSetProperty("Clementine", "Runtime: Visible", true, kScene);
    ALIVE_AgentSetProperty("AJ", "Runtime: Visible", true, kScene);

    ALIVE_RemoveAgent("module_post_effect", kScene);
    ALIVE_RemoveAgent("Lee", kScene);
    ALIVE_RemoveAgent("ClementineFlashback", kScene);
    --ALIVE_RemoveAgent("Clementine", kScene);
    --ALIVE_RemoveAgent("AJ", kScene);
    ALIVE_RemoveAgent("light_ENV_roadTile", kScene);
    --ALIVE_RemoveAgent("light_SKY_amb", kScene);
    --ALIVE_RemoveAgent("light_SKY_horizonSpot", kScene);
    --ALIVE_RemoveAgent("light_SKY_sunPoint", kScene);
    --ALIVE_RemoveAgent("light_SKY_sunBroadLight", kScene);
    --ALIVE_RemoveAgent("light_ENV_ambFill", kScene);
    --ALIVE_RemoveAgent("light_ENV_D_SunKey", kScene);
    --ALIVE_RemoveAgent("light_AMB_grassIvy", kScene);
    --ALIVE_RemoveAgent("light_AMB_MatteTrees", kScene);
    ALIVE_RemoveAgent("light_NODE_roadTile", kScene);
    ALIVE_RemoveAgent("module_post_effect", kScene);
    --ALIVE_RemoveAgent("module_environment", kScene);
    ALIVE_RemoveAgent("group_dormRoom", kScene);
    ALIVE_RemoveAgent("group_train", kScene);
    ALIVE_RemoveAgent("group_tileParent", kScene);
    ALIVE_RemoveAgent("group_tileGrandParent", kScene);
    ALIVE_RemoveAgent("obj_matteForestTileRing", kScene);
    --ALIVE_RemoveAgent("obj_skydomeOverheadClouds", kScene);
    ALIVE_RemoveAgent("obj_trainEngineFlashbackInnerWalls", kScene);
    ALIVE_RemoveAgent("obj_trainEngineFlashbackJunk", kScene);
    ALIVE_RemoveAgent("obj_trainEngineFlashbackOuterWalls", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAClem", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAClemFurniture", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAClemCloth", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAClemCobwebs", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAClemPipes", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAClemCeiling", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAClemFloor", kScene);
    ALIVE_RemoveAgent("obj_doorClemBoardingSchoolDorm", kScene);
    ALIVE_RemoveAgent("obj_doorClosetClemABoardingSchoolDorm", kScene);
    ALIVE_RemoveAgent("obj_drawingAJ", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAWalls", kScene);
    ALIVE_RemoveAgent("obj_drawerBoardingSchoolDorm", kScene);
    ALIVE_RemoveAgent("obj_drawerDeskABoardingSchoolDorm", kScene);
    ALIVE_RemoveAgent("obj_pillowDormA", kScene);
    ALIVE_RemoveAgent("obj_capClementine400", kScene);
    ALIVE_RemoveAgent("obj_trainBoxCar", kScene);
    ALIVE_RemoveAgent("obj_trainCoalCar", kScene);
    ALIVE_RemoveAgent("obj_trainCoalCar01", kScene);
    ALIVE_RemoveAgent("obj_trainBoxCar01", kScene);
    ALIVE_RemoveAgent("light_NODE_clemsRoomNight", kScene);
    ALIVE_RemoveAgent("light_ENV_clemsRoomNight_moonKey", kScene);
    ALIVE_RemoveAgent("light_ENV_clemsRoomNight_moonHotspot", kScene);
    ALIVE_RemoveAgent("light_ENV_clemsRoomNight_moonBounceDoor", kScene);
    ALIVE_RemoveAgent("light_ENV_clemsRoomNight_moonBounceWindow", kScene);
    ALIVE_RemoveAgent("light_ENV_clemsRoomNight", kScene);
    ALIVE_RemoveAgent("light_ENV_clemsRoomNight_moonBounceWindow01", kScene);
    ALIVE_RemoveAgent("fx_lightShaft402", kScene);
    ALIVE_RemoveAgent("light_SKY_ambRoomB", kScene);
    ALIVE_RemoveAgent("light_SKY_horizonSpotRoomB", kScene);
    ALIVE_RemoveAgent("group_skydomeRoomB", kScene);
    ALIVE_RemoveAgent("group_moonRoomB", kScene);
    ALIVE_RemoveAgent("obj_skydomeStars", kScene);
    ALIVE_RemoveAgent("obj_skydomeOverheadCloudsRoomB", kScene);
    ALIVE_RemoveAgent("obj_skydomeMoonRoomB", kScene);
    ALIVE_RemoveAgent("obj_matteForestTileRingRoomB", kScene);
    ALIVE_RemoveAgent("light_NODE_roadTileKey", kScene);
    ALIVE_RemoveAgent("light_ENV_P_leeSpecial01", kScene);
    ALIVE_RemoveAgent("light_ENV_P_leeSpecial02", kScene);
    --ALIVE_RemoveAgent("light_AMB_Trees01", kScene);

    ALIVE_RemoveAgent("fx_forceBackBufferStaticObj", kScene);
end

Scene_RelightScene = function()
    --local envlight  = AgentFindInScene("light_ENV_sunKey", kScene);
    --local envlight_props = AgentGetRuntimeProperties(envlight);
    --local envlight_groupEnabled = PropertyGet(envlight_props, "EnvLight - Enabled Group");
    --local envlight_groups = PropertyGet(envlight_props, "EnvLight - Groups");
    
    --find the original sky light in the scene (note telltale dev, why do you use a light source for the skybox when you could've just had the sky be an (emmissive/unlit) shader?)
    --local skyEnvlight  = AgentFindInScene("light_SKY_amb", kScene);
    --local skyEnvlight_props = AgentGetRuntimeProperties(skyEnvlight);
    --local skyEnvlight_groupEnabled = PropertyGet(skyEnvlight_props, "EnvLight - Enabled Group");
    --local skyEnvlight_groups = PropertyGet(skyEnvlight_props, "EnvLight - Groups");

    --the main prop (like a prefab) file for a generic light
    local envlight_prop = "module_env_light.prop";
    
    --calculate some new colors
    local sunColor     = RGBColor(255, 220, 188, 255);
    local ambientColor = RGBColor(108, 150, 225, 255);
    local skyColor     = RGBColor(0, 80, 255, 255);
    local fogColor     = Desaturate_RGBColor(skyColor, 0.7);
    
    --adjust the colors a bit (yes there is a lot of tweaks... would be easier if we had a level editor... but we dont yet)
    skyColor = Desaturate_RGBColor(skyColor, 0.2);
    fogColor = Multiplier_RGBColor(fogColor, 0.8);
    fogColor = Desaturate_RGBColor(fogColor, 0.45);
    sunColor = Desaturate_RGBColor(sunColor, 0.15);
    skyColor = Desaturate_RGBColor(skyColor, 0.2);
    sunColor = Desaturate_RGBColor(sunColor, 0.0);
    ambientColor = Desaturate_RGBColor(ambientColor, 0.45);
    ambientColor = Multiplier_RGBColor(ambientColor, 1.0);
    
    --set the alpha value of the fog color to be fully opaque
    local finalFogColor = Color(fogColor.r, fogColor.g, fogColor.b, 1.0);
    
    --change the properties of the fog
    local fogName = "module_environment"
    ALIVE_AgentSetProperty(fogName, "Env - Fog Color", finalFogColor, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Fog Start Distance", 0.25, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Fog Height", 3.45, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Fog Density", 0.00025, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Fog Max Opacity", 0.35, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Fog Enabled", true, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Enabled", true, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Enabled on High", true, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Enabled on Medium", true, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Enabled on Low", true, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Priority", 1000, kScene);

    --create our sunlight and set the properties accordingly
    --local myLight_Sun = AgentCreate("myLight_Sun", envlight_prop, Vector(0,0,0), Vector(36.666, 113.1561, 0), kScene, false, false);
    ALIVE_SetAgentWorldRotation("light_ENV_D_SunKey", Vector(36.666, 113.1561, 0), kScene);
    --ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Type", 2, kScene);
    ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Intensity", 6, kScene);
    ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Radius", 1, kScene);
    --ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Distance Falloff", 1, kScene);
    --ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Spot Angle Inner", 5, kScene);
    --ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Spot Angle Outer", 45, kScene);
    ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Color", sunColor, kScene);
    --ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    --ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Shadow Type", 2, kScene);
    --ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Wrap", 0.05, kScene);
    ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Shadow Quality", 3, kScene);
    ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Mobility", 2, kScene);

    --sky light/color
    ALIVE_AgentSetProperty("light_SKY_amb", "EnvLight - Intensity", 4, kScene);
    ALIVE_AgentSetProperty("light_SKY_amb", "EnvLight - Color", skyColor, kScene);
    
    
    
    ALIVE_AgentSetProperty("light_AMB_0", "EnvLight - Intensity", 2, kScene);
    ALIVE_AgentSetProperty("light_AMB_0", "EnvLight - Color", sunColor, kScene);
    
    ALIVE_AgentSetProperty("light_AMB_grassIvy", "EnvLight - Intensity", 2, kScene);
    ALIVE_AgentSetProperty("light_AMB_grassIvy", "EnvLight - Color", sunColor, kScene);
    
    ALIVE_AgentSetProperty("light_AMB_MatteTrees", "EnvLight - Intensity", 2, kScene);
    ALIVE_AgentSetProperty("light_AMB_MatteTrees", "EnvLight - Color", sunColor, kScene);
    
    --create a spotlight that emulates the sundisk in the sky
    --local myLight_SkySun = AgentCreate("myLight_SkySun", envlight_prop, Vector(0,0,0), Vector(36.666 - 180, 113.1561, 0), kScene, false, false);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Type", 1, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Intensity", 25, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Enlighten Intensity", 0.0, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Radius", 2555, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Distance Falloff", 9, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Spot Angle Inner", 5, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Spot Angle Outer", 65, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Color", sunColor, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Enabled Group", skyEnvlight_groupEnabled, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Groups", skyEnvlight_groups, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Shadow Type", 0, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Wrap", 0.0, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Shadow Quality", 0, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - HBAO Participation Type", 1, kScene);
  
    --remove original sun since we created our own and only needed it for getting the correct lighting groups.
    --ALIVE_RemoveAgent("light_ENV_D_SunKey", kScene);
    --ALIVE_RemoveAgent("module_environment", kScene);

    ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "adv_", "Render EnvLight Shadow Cast Enable", true)
    ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "adv_", "Render Shadow Force Visible", true)
    ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "adv_", "Render Enlighten Force Visible", true)
    

    --modify the scene post processing
    ALIVE_AgentSetProperty(agent_name_scene, "FX anti-aliasing", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Sharp Shadows Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Ambient Occlusion Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap White Point", 10.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Black Point", 0.005, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Toe Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Shoulder Intensity", 0.75, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Type", 2, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Pivot", 0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Shoulder Intensity", 0.8, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Radius", 0.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Max Radius Percent", 0.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Max Distance", 35.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Distance Falloff", 1, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Hemisphere Bias", 0.1, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Bloom Threshold", -0.45, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Bloom Intensity", 0.45, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Ambient Color", ambientColor, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Shadow Color", RGBColor(0, 0, 0, 0), kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Tint Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Tint", RGBColor(0, 0, 0, 255), kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Falloff", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Center", 0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Corners", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Saturation", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Reflection Intensity Shadow", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Reflection Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Max Distance", 40.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Dynamic Shadow Max Distance", 45.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Position Offset Bias", 0.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Depth Bias", -1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Auto Depth Bounds", false, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Light Bleed Reduction", 0.8, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Moment Bias", 0.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Specular Multiplier Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Specular Color Multiplier", 55, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Specular Intensity Multiplier", 1, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Specular Exponent Multiplier", 1, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Noise Scale", 1, kScene);
end

--|||||||||||||||||||||||||||||||||||||||||||||| 3RD PERSON CONTROLLER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| 3RD PERSON CONTROLLER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| 3RD PERSON CONTROLLER ||||||||||||||||||||||||||||||||||||||||||||||

HideCusorInGame = function()
    CursorHide(true);
    CursorEnable(true);
end

ALIVE_Level_Flashback = function()
    SetProjectSettings();
    Scene_CleanUpOriginalScene();
    --Scene_RelightScene();

    HideCusorInGame();

    --ALIVE_PrintSceneListToTXT(kScene, "adv_trainTile403.txt");

    --if (EnableFreecam == true) then
        --ALIVE_Development_CreateFreeCamera();
        --ALIVE_Development_InitalizeCutsceneTools();

        --Callback_OnPostUpdate:Add(ALIVE_Development_UpdateFreeCamera);

        ALIVE_Gameplay_CreateThirdPersonController(true, Vector(0, 0, 11));
        --Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Input);
        --Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Main);
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
end

SceneOpen(kScene, kScript)