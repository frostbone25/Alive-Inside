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
require("ALIVE_Gameplay_ThirdPerson.lua");

ResourceSetEnable("ProjectSeason4");
ResourceSetEnable("WalkingDead402");
ResourceSetEnable("WalkingDead404");
ResourceSetEnable("WalkingDead201");

--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||

--main level variables
local kScript = "ALIVE_Level_Sandbox";
local kScene = "adv_boardingSchoolExterior";

ThirdPerson_kScene = kScene;

--scene agent name variable
local agent_name_scene = "adv_boardingSchoolExterior.scene"; 

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
    ALIVE_RemovingAgentsWithPrefix(kScene, "light_CHAR_CC");
    ALIVE_RemovingAgentsWithPrefix(kScene, "lightrig");
    ALIVE_RemovingAgentsWithPrefix(kScene, "audio_");
    ALIVE_RemovingAgentsWithPrefix(kScene, "fx_");
    ALIVE_RemovingAgentsWithPrefix(kScene, "fxg_");
    ALIVE_RemovingAgentsWithPrefix(kScene, "fxa_");
    ALIVE_RemovingAgentsWithPrefix(kScene, "obj_lookAt");
    
    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "Zombie", "Runtime: Visible", true)
    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "Zombie", "Runtime: Visible", false)
    --ALIVE_RemovingAgentsWithPrefix(kScene, "Zombie");
    
    --ALIVE_AgentSetProperty("group_tile1", "Group - Visible", false, kScene);

    ALIVE_RemoveAgent("module_post_effect", kScene);
    --ALIVE_RemoveAgent("AJ", kScene);
    ALIVE_RemoveAgent("Aasim", kScene);
    --ALIVE_RemoveAgent("Clementine", kScene);
    ALIVE_RemoveAgent("Louis", kScene);
    ALIVE_RemoveAgent("Omar", kScene);
    ALIVE_RemoveAgent("Rosie", kScene);
    ALIVE_RemoveAgent("Ruby", kScene);
    ALIVE_RemoveAgent("Tennyson", kScene);
    ALIVE_RemoveAgent("Violet", kScene);
    ALIVE_RemoveAgent("Willy", kScene);
    ALIVE_RemoveAgent("module_environment_med", kScene);
    ALIVE_RemoveAgent("Hare", kScene);
    ALIVE_RemoveAgent("Horse", kScene);
    ALIVE_RemoveAgent("light_ENV_ambFill", kScene);
    --ALIVE_RemoveAgent("light_ENV_D_SunKey", kScene);
    ALIVE_RemoveAgent("keylight_node_exterior", kScene);
    --ALIVE_RemoveAgent("light_AMB_0", kScene);
    --ALIVE_RemoveAgent("light_AMB_grassIvy", kScene);
    --ALIVE_RemoveAgent("light_AMB_MatteTrees", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingStripe", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingStripe01", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingStripe02", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill01", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill02", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill03", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill04", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill05", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill06", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill07", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill08", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill09", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill10", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill11", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce01", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingStripe03", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingStripe04", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce02", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce03", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill12", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill13", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill14", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill15", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill16", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce04", kScene);
    ALIVE_RemoveAgent("light_ENV_C_characterBacklight01", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingLeafy01", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingLeafyInvert", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill17", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill18", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce06", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce07", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce08", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingStripe05", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingLeafyInvertStripes", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingLeafyInvertStripes01", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingLeafyInvertStripes02", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce09", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce10", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce11", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill19", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill20", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingLeafy02", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill21", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill22", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill23", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill24", kScene);
    --ALIVE_RemoveAgent("light_SKY_amb", kScene);
    ALIVE_RemoveAgent("light_SKY_horizonSpot", kScene);
    ALIVE_RemoveAgent("light_SKY_sunPoint", kScene);
    ALIVE_RemoveAgent("light_SKY_sunBroadLight", kScene);
    ALIVE_RemoveAgent("light_SKY_sunPoint01", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingStripe06", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingStripe07", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingLeafy03", kScene);
    ALIVE_RemoveAgent("light_SKY_sunPointNX", kScene);
    ALIVE_RemoveAgent("light_ENV_D_sunKeyNX", kScene);
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

--[[
HideCusorInGame = function()
    CursorHide(true);
    CursorEnable(true);
end

local agent_name_char = "AJ";
--local agent_name_char = "Clementine";
local agent_name_charParent = "AJ_Parent";
local agent_name_thirdPersonCamera = "myThirdPersonCamera";
local agent_name_thirdPersonGroupCamera = "myThirdPersonParentCamera";
local agent_name_thirdPersonAnimGroupCamera = "myThirdPersonAnimParentCamera";
local agent_name_thirdPersonDummyObject = "myThirdPersonDummyObject";

local aj_controller_anim_idle = nil;
local aj_controller_anim_walking = nil;
local aj_controller_anim_running = nil;
local aj_controller_anim_crouchIdle = nil;
local aj_controller_anim_crouchMoving = nil;

ALIVE_Gameplay_CreateThirdPersonController = function()
    -----------------------------------------------
    local cam_prop = "module_camera.prop";

    local cameraParentAgent = AgentCreate(agent_name_thirdPersonGroupCamera, "group.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    local cameraAnimParentAgent = AgentCreate(agent_name_thirdPersonAnimGroupCamera, "group.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    local cameraDummyAgent = AgentCreate(agent_name_thirdPersonDummyObject, "group.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    local cameraAgent = AgentCreate(agent_name_thirdPersonCamera, cam_prop, Vector(0,0,0), Vector(0,0,0), kScene, false, false);

    AgentAttach(cameraAgent, cameraAnimParentAgent);
    AgentAttach(cameraDummyAgent, cameraAnimParentAgent);
    AgentAttach(cameraAnimParentAgent, cameraParentAgent);

    ALIVE_AgentSetProperty(agent_name_thirdPersonCamera, "Clip Plane - Far", 1500, kScene);
    ALIVE_AgentSetProperty(agent_name_thirdPersonCamera, "Clip Plane - Near", 0.05, kScene);
    ALIVE_AgentSetProperty(agent_name_thirdPersonCamera, "Field Of View", 70, kScene)

    ALIVE_RemovingAgentsWithPrefix(kScene, "cam_");

    CameraPush(agent_name_thirdPersonCamera);
    
    -----------------------------------------------
    --local agent_aj = AgentCreate("AJ", "sk63_aj.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false)
    local agent_aj = AgentFindInScene(agent_name_char, kScene);
    local agent_ajGroup = AgentCreate(agent_name_charParent, "group.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    
    AgentAttach(agent_aj, agent_ajGroup);
    
    ALIVE_SetAgentWorldPosition(agent_name_char, Vector(0, 0, 0), kScene);
    ALIVE_SetAgentWorldRotation(agent_name_char, Vector(0, 0, 0), kScene);
    
    
    local controllersTable_aj = AgentGetControllers(agent_aj);
    
    for i, cnt in ipairs(controllersTable_aj) do
        ControllerKill(cnt);
        --ControllerPause(cnt);
        --ControllerStop(cnt);
    end
    
    
    aj_controller_anim_idle = PlayAnimation(agent_aj, "sk63_idle_ajStandA.anm");
    --aj_controller_anim_idle = PlayAnimation(agent_aj, "sk61_action_louisJumpGap.anm");
    --aj_controller_anim_idle = PlayAnimation(agent_aj, "sk61_action_batmanJumpDownOneStoryToCatwoman.anm");
    --aj_controller_anim_idle = PlayAnimation(agent_aj, "sk61_action_javierJumpDownLedge.anm");
    aj_controller_anim_walking = PlayAnimation(agent_aj, "sk63_aj_walk.anm");
    --aj_controller_anim_walking = PlayAnimation(agent_aj, "sk61_zombie400_walkA.anm");
    aj_controller_anim_running = PlayAnimation(agent_aj, "sk63_aj_run.anm");
    --aj_controller_anim_running = PlayAnimation(agent_aj, "sk35_rosie_run.anm");
    --aj_controller_anim_running = PlayAnimation(agent_aj, "sk62_clementine400_run.anm");
    aj_controller_anim_crouchIdle = PlayAnimation(agent_aj, "sk63_idle_ajCrouch.anm");
    aj_controller_anim_crouchMoving = PlayAnimation(agent_aj, "sk62_clementine400_crouchWalk.anm");
    
    ControllerSetLooping(aj_controller_anim_idle, true);
    ControllerSetLooping(aj_controller_anim_walking, true);
    ControllerSetLooping(aj_controller_anim_running, true);
    ControllerSetLooping(aj_controller_anim_crouchIdle, true);
    ControllerSetLooping(aj_controller_anim_crouchMoving, true);
    
    ControllerSetPriority(aj_controller_anim_idle, 100);
    ControllerSetPriority(aj_controller_anim_crouchIdle, 100);
    ControllerSetPriority(aj_controller_anim_walking, 100);
    ControllerSetPriority(aj_controller_anim_crouchMoving, 100);
    ControllerSetPriority(aj_controller_anim_running, 100);
    
    AgentSetState("AJ", "bodyJacketDisco");
    
    ALIVE_SetAgentWorldPosition(agent_name_charParent, Vector(0, 0, 11), kScene);
end

ALIVE_Gameplay_ThirdPerson_InputHorizontalValue = 0;
ALIVE_Gameplay_ThirdPerson_InputVerticalValue = 0;
ALIVE_Gameplay_ThirdPerson_InputHeightValue = 0;
ALIVE_Gameplay_ThirdPerson_PrevCamPos = Vector(0,0,0);
ALIVE_Gameplay_ThirdPerson_PrevCamRot = Vector(0,0,0);
ALIVE_Gameplay_ThirdPerson_PrevCursorPos = Vector(0,0,0);
ALIVE_Gameplay_ThirdPerson_InputMouseAmountX = 0;
ALIVE_Gameplay_ThirdPerson_InputMouseAmountY = 0;
ALIVE_Gameplay_ThirdPerson_InputFieldOfViewAmount = 90;
ALIVE_Gameplay_ThirdPerson_CameraRotLerp = 5.0
ALIVE_Gameplay_ThirdPerson_CameraPosLerp = 5.0

ALIVE_Gameplay_ThirdPerson_CharacterDirection = Vector(0, 0, 0);
ALIVE_Gameplay_ThirdPerson_CharacterOffset = Vector(0, 0, 0);

local player_anim_idle_contribution = 0;
local player_anim_walk_contribution = 0;
local player_anim_running_contribution = 0;
local player_anim_crouch_contribution = 0;
local player_anim_crouchWalk_contribution = 0;

local player_state_moving = false;
local player_state_running = false;
local player_state_crouching = false;

ALIVE_Gameplay_UpdateThirdPersonCharacterAnimation = function()
    local currFrameTime = GetFrameTime();
    local animationFadeTime = 7.5;
    
    if (player_state_moving) then
        if (player_state_running) then
            player_anim_idle_contribution = ALIVE_NumberLerp(player_anim_idle_contribution, 0, currFrameTime * animationFadeTime);
            player_anim_walk_contribution = ALIVE_NumberLerp(player_anim_walk_contribution, 0, currFrameTime * animationFadeTime);
            player_anim_running_contribution = ALIVE_NumberLerp(player_anim_running_contribution, 1, currFrameTime * animationFadeTime);
            player_anim_crouch_contribution = ALIVE_NumberLerp(player_anim_crouch_contribution, 0, currFrameTime * animationFadeTime);
            player_anim_crouchWalk_contribution = ALIVE_NumberLerp(player_anim_crouchWalk_contribution, 0, currFrameTime * animationFadeTime);
        else
            if(player_state_crouching) then
                player_anim_idle_contribution = ALIVE_NumberLerp(player_anim_idle_contribution, 0, currFrameTime * animationFadeTime);
                player_anim_walk_contribution = ALIVE_NumberLerp(player_anim_walk_contribution, 0, currFrameTime * animationFadeTime);
                player_anim_running_contribution = ALIVE_NumberLerp(player_anim_running_contribution, 0, currFrameTime * animationFadeTime);
                player_anim_crouch_contribution = ALIVE_NumberLerp(player_anim_crouch_contribution, 0, currFrameTime * animationFadeTime);
                player_anim_crouchWalk_contribution = ALIVE_NumberLerp(player_anim_crouchWalk_contribution, 1, currFrameTime * animationFadeTime);
            else
                player_anim_idle_contribution = ALIVE_NumberLerp(player_anim_idle_contribution, 0, currFrameTime * animationFadeTime);
                player_anim_walk_contribution = ALIVE_NumberLerp(player_anim_walk_contribution, 1, currFrameTime * animationFadeTime);
                player_anim_running_contribution = ALIVE_NumberLerp(player_anim_running_contribution, 0, currFrameTime * animationFadeTime);
                player_anim_crouch_contribution = ALIVE_NumberLerp(player_anim_crouch_contribution, 0, currFrameTime * animationFadeTime);
                player_anim_crouchWalk_contribution = ALIVE_NumberLerp(player_anim_crouchWalk_contribution, 0, currFrameTime * animationFadeTime);
            end
        end
    else
        if (player_state_crouching) then
            player_anim_idle_contribution = ALIVE_NumberLerp(player_anim_idle_contribution, 0, currFrameTime * animationFadeTime);
            player_anim_walk_contribution = ALIVE_NumberLerp(player_anim_walk_contribution, 0, currFrameTime * animationFadeTime);
            player_anim_running_contribution = ALIVE_NumberLerp(player_anim_running_contribution, 0, currFrameTime * animationFadeTime);
            player_anim_crouch_contribution = ALIVE_NumberLerp(player_anim_crouch_contribution, 1, currFrameTime * animationFadeTime);
            player_anim_crouchWalk_contribution = ALIVE_NumberLerp(player_anim_crouchWalk_contribution, 0, currFrameTime * animationFadeTime);
        else
            player_anim_idle_contribution = ALIVE_NumberLerp(player_anim_idle_contribution, 1, currFrameTime * animationFadeTime);
            player_anim_walk_contribution = ALIVE_NumberLerp(player_anim_walk_contribution, 0, currFrameTime * animationFadeTime);
            player_anim_running_contribution = ALIVE_NumberLerp(player_anim_running_contribution, 0, currFrameTime * animationFadeTime);
            player_anim_crouch_contribution = ALIVE_NumberLerp(player_anim_crouch_contribution, 0, currFrameTime * animationFadeTime);
            player_anim_crouchWalk_contribution = ALIVE_NumberLerp(player_anim_crouchWalk_contribution, 0, currFrameTime * animationFadeTime);
        end
    end

    ControllerSetContribution(aj_controller_anim_idle, player_anim_idle_contribution);
    ControllerSetContribution(aj_controller_anim_walking, player_anim_walk_contribution);
    ControllerSetContribution(aj_controller_anim_running, player_anim_running_contribution);
    ControllerSetContribution(aj_controller_anim_crouchIdle, player_anim_crouch_contribution);
    ControllerSetContribution(aj_controller_anim_crouchMoving, player_anim_crouchWalk_contribution);
end

local tpc_currentCameraFOV = 90;
local tpc_defaultFOV = 70;
local tpc_runningFOV = 80;

local player_camera_bobbingX = 0.0;
local player_camera_bobbingXAmount_Walk = 0.15;
local player_camera_bobbingXSpeed_Walk = 6.5;
local player_camera_bobbingXAmount_Run = 0.25;
local player_camera_bobbingXSpeed_Run = 11.5;
local player_camera_desiredRotation = Vector(0.0, 0.0, 0.0);

local cameraLocalPosition = Vector(0,0,0);

ALIVE_Gameplay_UpdateThirdPersonCameraAnimation = function()
    local frameTime = GetFrameTime();

    ------------------------------FOV KICK------------------------------
    if (player_state_moving) then
        if (player_state_running) then
            tpc_currentCameraFOV = ALIVE_NumberLerp(tpc_currentCameraFOV, tpc_runningFOV, frameTime * 2.5);
        else
            tpc_currentCameraFOV = ALIVE_NumberLerp(tpc_currentCameraFOV, tpc_defaultFOV, frameTime * 2.5);
        end
    else
        tpc_currentCameraFOV = ALIVE_NumberLerp(tpc_currentCameraFOV, tpc_defaultFOV, frameTime * 2.5);
    end

    ALIVE_AgentSetProperty(agent_name_thirdPersonCamera, "Field Of View", tpc_currentCameraFOV, kScene);

    ------------------------------CAMERA BOBBING------------------------------
    local newCamRotX = 0.0;

    if (player_state_moving) then
        if (player_state_running) then
            player_camera_bobbingX = player_camera_bobbingX + (GetFrameTime() * player_camera_bobbingXSpeed_Run);
            newCamRotX = math.sin(player_camera_bobbingX) * player_camera_bobbingXAmount_Run;
        else
            player_camera_bobbingX = player_camera_bobbingX + (GetFrameTime() * player_camera_bobbingXSpeed_Walk);
            newCamRotX = math.sin(player_camera_bobbingX) * player_camera_bobbingXAmount_Walk;
        end
    else
        player_camera_bobbingX = 0.0;
        newCamRotX = 0.0;
    end

    player_camera_desiredRotation = Vector(newCamRotX, player_camera_desiredRotation.y, player_camera_desiredRotation.z);

    ALIVE_SetAgentRotation(agent_name_thirdPersonAnimGroupCamera, player_camera_desiredRotation, kScene);
end

local player_movementVector = Vector(0,0,0);
local player_movementSpeed = 0.0;

ALIVE_Gameplay_UpdateThirdPersonControllerInput = function()
    ------------------------------INPUT------------------------------
    local key_moveForward = Input_IsVKeyPressed(87); --key w
    local key_moveBackward = Input_IsVKeyPressed(83); --key s
    local key_moveLeft = Input_IsVKeyPressed(65); --key a
    local key_moveRight = Input_IsVKeyPressed(68); --key d
    local key_running = Input_IsVKeyPressed(16); --key shift
    local key_crouch1 = Input_IsVKeyPressed(67); --key c
    local key_crouch2 = Input_IsVKeyPressed(17); --key ctrl

    ------------------------------MOVEMENT------------------------------
    local walkSpeed = 0.013;
    local crouchWalkSpeed = 0.01;
    local runSpeed = 0.06;
    player_movementSpeed = walkSpeed;
    
    --moving
    if key_moveForward or key_moveBackward or key_moveLeft or key_moveRight then
        player_state_moving = true;
    else
        player_state_moving = false;
    end

    --crouching
    if key_crouch1 or key_crouch2 then
        player_state_crouching = true;
    else
        player_state_crouching = false;
    end
    
    --running (can only run if we are not crouching)
    if (player_state_crouching == false) then
        if key_running then
            player_state_running = true;
            player_movementSpeed = runSpeed;
        else
            player_state_running = false;
            player_movementSpeed = walkSpeed;
        end
    else
        player_state_running = false;
        player_movementSpeed = crouchWalkSpeed;
    end

    local movementVector_x = 0.0;
    local movementVector_y = 0.0;
    local movementVector_z = 0.0;

    if key_moveForward then
        movementVector_z = 1.0;
    elseif key_moveBackward then
        movementVector_z = -1.0;
    end
    
    if key_moveLeft then
        movementVector_x = -1.0;
    elseif key_moveRight then
        movementVector_x = 1.0;
    end
    
    player_movementVector = Vector(movementVector_x, movementVector_y, movementVector_z);

    ------------------------------MOUSELOOK------------------------------
    local currCursorPos = CursorGetPos();
    
    --how close to the edges of the screen the cusor can be
    local minThreshold = 0.01;
    local maxThreshold = 0.99;
    
    --reset the cursor pos to the center of the screen when they get near the edges of the screen
    if (currCursorPos.x > maxThreshold) or (currCursorPos.x < minThreshold) or (currCursorPos.y > maxThreshold) or (currCursorPos.y < minThreshold) then
        CursorSetPos(Vector(0.5, 0.5, 0));
    end
    
    --get the delta (how fast they are moving the cusor)
    local xCursorDifference = currCursorPos.x - ALIVE_Gameplay_ThirdPerson_PrevCursorPos.x;
    local yCursorDifference = currCursorPos.y - ALIVE_Gameplay_ThirdPerson_PrevCursorPos.y;
    
    local sensitivity = 180.0;
    ALIVE_Gameplay_ThirdPerson_InputMouseAmountX = ALIVE_Gameplay_ThirdPerson_InputMouseAmountX - (xCursorDifference * sensitivity);
    ALIVE_Gameplay_ThirdPerson_InputMouseAmountY = ALIVE_Gameplay_ThirdPerson_InputMouseAmountY + (yCursorDifference * sensitivity);
end
ALIVE_Gameplay_UpdateThirdPersonController = function()
    local currFrameTime = GetFrameTime();

    local newRotation = Vector(ALIVE_Gameplay_ThirdPerson_InputMouseAmountY - 90, ALIVE_Gameplay_ThirdPerson_InputMouseAmountX, 0);
    newRotation.x = ALIVE_Clamp(newRotation.x, -90, 90);
    
    ------------------------------THIRD PERSON SHARED------------------------------
    local myCameraAgent = AgentFindInScene(agent_name_thirdPersonCamera, kScene); --Agent type
    local myCameraAgentGroup = AgentFindInScene(agent_name_thirdPersonGroupCamera, kScene); --Agent type
    local myCameraDummy = AgentFindInScene(agent_name_thirdPersonDummyObject, kScene); --Agent type

    local myAJAgent = AgentFindInScene(agent_name_char, kScene); --Agent type
    local myAJGroupAgent = AgentFindInScene(agent_name_charParent, kScene); --Agent type
    local ajPosition = AgentGetWorldPos(myAJGroupAgent); --Vector type
    local ajForward = AgentGetForwardVec(myAJGroupAgent); --Vector type

    local myCameraAgent_worldRot = AgentGetWorldRot(myCameraAgent);
    
    ALIVE_SetAgentWorldRotation(agent_name_thirdPersonDummyObject, Vector(0, myCameraAgent_worldRot.y, myCameraAgent_worldRot.z), kScene);

    ------------------------------THIRD PERSON MOVEMENT------------------------------
    local cam_right = AgentGetRightVec(myCameraDummy, true); --Vector type
    local cam_forward = AgentGetForwardVec(myCameraDummy, true); --Vector type
    cam_forward = cam_forward + Vector(0, 0);
    
    cam_right = VectorScale(cam_right, player_movementVector.x);
    cam_forward = VectorScale(cam_forward, player_movementVector.z);
    local finalPlayerMovement = VectorAdd(cam_right, cam_forward);
    finalPlayerMovement.y = 0;

    local clemPosition = AgentGetWorldPos(myAJGroupAgent);
    local clemForward = AgentGetForwardVec(myAJGroupAgent);
    local flippedMovementVector = Vector(-player_movementVector.x, player_movementVector.y, player_movementVector.z);

    if (player_state_moving) then
        local newDirection = AgentLocalToWorld(myCameraDummy, flippedMovementVector * 10.0);

        local directionLerpFactor = 5.0;

        ALIVE_Gameplay_ThirdPerson_CharacterDirection = ALIVE_VectorLerp(ALIVE_Gameplay_ThirdPerson_CharacterDirection, newDirection, currFrameTime * directionLerpFactor);
    end
    
    local newAJPosition = AgentGetWorldPos(myAJGroupAgent);
    finalPlayerMovement = VectorScale(finalPlayerMovement, player_movementSpeed);
    
    local lockedPos = VectorScale(Vector(0,0,1), AgentGetForwardAnimVelocity(myAJAgent));

    newAJPosition = newAJPosition + finalPlayerMovement;

    local legalNewPos = WalkBoxesPosOnWalkBoxes(newAJPosition, 0, "adv_boardingSchoolExterior.wbox", 1);

    ALIVE_Gameplay_ThirdPerson_CharacterDirection.y = newAJPosition.y;

    ALIVE_SetAgentPosition(agent_name_char, lockedPos, kScene);
    ALIVE_SetAgentPosition(agent_name_charParent, legalNewPos, kScene);

    AgentFacePos(myAJAgent, ALIVE_Gameplay_ThirdPerson_CharacterDirection);
    
    ------------------------------THIRD PERSON CAMERA------------------------------
    local camPosLerpFactor = ALIVE_Gameplay_ThirdPerson_CameraPosLerp;
    local camRotLerpFactor = ALIVE_Gameplay_ThirdPerson_CameraRotLerp;
    local localLerpPosFactor = 2.0;

    if (player_state_crouching) then
        if(player_state_moving) then
            ajPosition = ajPosition + Vector(-0.0, 0.6, 0.0);
            cameraLocalPosition = ALIVE_VectorLerp(cameraLocalPosition, Vector(-0.25, 0.0, -1.0) + (flippedMovementVector * 0.1), currFrameTime * localLerpPosFactor);
        else
            ajPosition = ajPosition + Vector(-0.0, 0.5, 0.0);
            cameraLocalPosition = ALIVE_VectorLerp(cameraLocalPosition, Vector(-0.25, 0.0, -0.9), currFrameTime * localLerpPosFactor);
        end
    else
        if (player_state_moving) then
            if(player_state_running) then
                ajPosition = ajPosition + Vector(-0.0, 0.95, 0.0);
                cameraLocalPosition = ALIVE_VectorLerp(cameraLocalPosition, Vector(-0.25, 0.0, -0.9), currFrameTime * localLerpPosFactor);
            else
                ajPosition = ajPosition + Vector(-0.0, 0.95, 0.0);
                cameraLocalPosition = ALIVE_VectorLerp(cameraLocalPosition, Vector(-0.25, 0.0, -0.9), currFrameTime * localLerpPosFactor);
            end
        else
            ajPosition = ajPosition + Vector(-0.0, 0.95, 0.0);
            cameraLocalPosition = ALIVE_VectorLerp(cameraLocalPosition, Vector(-0.25, 0.0, -0.9), currFrameTime * localLerpPosFactor);
        end
    end
    
    ALIVE_Gameplay_ThirdPerson_PrevCamPos = ALIVE_VectorLerp(ALIVE_Gameplay_ThirdPerson_PrevCamPos, ajPosition, currFrameTime * camPosLerpFactor);
    ALIVE_Gameplay_ThirdPerson_PrevCamRot = ALIVE_VectorLerp(ALIVE_Gameplay_ThirdPerson_PrevCamRot, newRotation, currFrameTime * camRotLerpFactor);
    --ALIVE_Gameplay_ThirdPerson_PrevCamPos = ajPosition;
    --ALIVE_Gameplay_ThirdPerson_PrevCamRot = newRotation;
    
    ALIVE_SetAgentPosition(agent_name_thirdPersonCamera, cameraLocalPosition, kScene);
    ALIVE_SetAgentPosition(agent_name_thirdPersonGroupCamera, ALIVE_Gameplay_ThirdPerson_PrevCamPos, kScene);
    ALIVE_SetAgentRotation(agent_name_thirdPersonGroupCamera, ALIVE_Gameplay_ThirdPerson_PrevCamRot, kScene);

    ------------------------------STORE FOR NEXT FRAME------------------------------
    ALIVE_Gameplay_ThirdPerson_PrevCursorPos = CursorGetPos();
end
]]--

ALIVE_Level_Sandbox = function()
    SetProjectSettings();
    Scene_CleanUpOriginalScene();
    Scene_RelightScene();

    --HideCusorInGame();

    --ALIVE_PrintSceneListToTXT(kScene, "adv_boardingSchoolExterior.txt");

    if (EnableFreecam == true) then
        ALIVE_Development_CreateFreeCamera();
        ALIVE_Development_InitalizeCutsceneTools();

        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateFreeCamera);
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Input);
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Main);
    else
        ALIVE_Gameplay_CreateThirdPersonController();
        Callback_OnPostUpdate:Add(ALIVE_Gameplay_UpdateThirdPerson_Input);
        Callback_OnPostUpdate:Add(ALIVE_Gameplay_UpdateThirdPerson_Camera);
        Callback_OnPostUpdate:Add(ALIVE_Gameplay_UpdateThirdPerson_Character);
        Callback_OnPostUpdate:Add(ALIVE_Gameplay_UpdateThirdPerson_CharacterAnimation);
        Callback_OnPostUpdate:Add(ALIVE_Gameplay_UpdateThirdPerson_CameraAnimation);
    end
end

SceneOpen(kScene, kScript)