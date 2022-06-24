require("ALIVE_Core_Inclusions.lua");
require("ALIVE_Gameplay_Shared.lua");
require("ALIVE_Cutscene_HandheldCameraAnimation.lua");
require("ALIVE_Cutscene_CharacterVoiceLine.lua");
require("ALIVE_Scene_LevelCleanup_404_ForestBarn_Teaser.lua");
require("ALIVE_Scene_LevelRelight_404_ForestBarn_Teaser.lua");
require("ALIVE_Character_AJ.lua");
require("ALIVE_Character_Clementine.lua");

ResourceSetEnable("ProjectSeason4");
ResourceSetEnable("WalkingDead402");
ResourceSetEnable("WalkingDead404");
ResourceSetEnable("WalkingDead201");

--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||

--main level variables
local kScript = "ALIVE_Level_Cutscene_Teaser1";
local kScene = "adv_forestBarn";
local kSceneObj = kScene .. ".scene";

--Cutscene Development Variables
ALIVE_Development_SceneObject = kScene;
ALIVE_Development_SceneObjectAgentName = kSceneObj;
ALIVE_Development_UseSeasonOneAPI = false;
ALIVE_Development_FreecamUseFOVScale = false;

local EnableFreecamTools = false;
local EnablePerformanceMetrics = true;

--DOF Autofocus Variables
ALIVE_DOF_AUTOFOCUS_SceneObject = kScene;
ALIVE_DOF_AUTOFOCUS_SceneObjectAgentName = kSceneObj;
ALIVE_DOF_AUTOFOCUS_UseCameraDOF = true;
ALIVE_DOF_AUTOFOCUS_UseLegacyDOF = false;
ALIVE_DOF_AUTOFOCUS_UseHighQualityDOF = true;
ALIVE_DOF_AUTOFOCUS_GameplayCameraNames = { "FuckinDontRemoveThis" };
ALIVE_DOF_AUTOFOCUS_ObjectEntries = { "AJ" };
ALIVE_DOF_AUTOFOCUS_Settings =
{
    TargetValidation_IsOnScreen = true,
    TargetValidation_IsVisible = true,
    TargetValidation_IsWithinDistance = true,
    TargetValidation_IsFacingCamera = true,
    TargetValidation_IsOccluded = false
};
ALIVE_DOF_AUTOFOCUS_BokehSettings =
{
    BokehBrightnessDeltaThreshold = 0.1,
    BokehBrightnessThreshold = 0.1,
    BokehBlurThreshold = 0.1,
    BokehMinSize = 0.0,
    BokehMaxSize = 0.05,
    BokehFalloff = 0.30,
    MaxBokehBufferAmount = 1.0,
    BokehPatternTexture = "bokeh_circle5.d3dtx"
};
ALIVE_DOF_AUTOFOCUS_ManualSettings =
{
    ManualOnly = false,
    NearFocusDistance = 2.0,
    NearFallof = 0.25,
    NearMax = 0.5,
    FarFocusDistance = 2.25,
    FarFalloff = 0.25,
    FarMax = 0.25
};

--cutscene variables
local agent_name_cutsceneCamera = "myCutsceneCamera";

--current sequence variables
local currentSequence_clip = nil; --dont touch (the current clip object that we are on)
local currentSequence_clipInfo_duration = nil; --dont touch (the duration of the shot)
local currentSequence_clipInfo_angleIndex = nil; --dont touch (the chosen angle item index for the shot)
local currentSequence_angle = nil; --dont touch (the actual angle object the clip references)

--main sequence variables
local sequence_maxClips = 8; --the maximum amount of clips in the sequence
local sequence_currentShotIndex = 1; --dont touch (the current shot index that are are on)
local sequence_currentTimer = 0; --dont touch (update tick that gets incremented 1 every frame and resets when we reach the end of the current shot duration)

--this variable is an array that will contain our (clips)
local sequence_clips = 
{
    clip1 = 
    {
        angleIndex = 1,
        shotDuration = 160
    },
    clip2 = 
    {
        angleIndex = 2,
        shotDuration = 315
    },
    clip3 = 
    {
        angleIndex = 4,
        shotDuration = 450
    },
    clip4 = 
    {
        angleIndex = 5,
        shotDuration = 320
    },
    clip5 = 
    {
        angleIndex = 3,
        shotDuration = 400
    },
    clip6 = 
    {
        angleIndex = 1,
        shotDuration = 155
    },
    clip7 = 
    {
        angleIndex = 7,
        shotDuration = 380
    },
    clip8 = 
    {
        angleIndex = 1,
        shotDuration = 9000
    }
};

--this variable is an array that will contain all of our camera angles in the scene (this gets referenced by the current sequence clip according to the angle index number)
local sequence_cameraAngles = 
{
    angle1 = --black angle
    {
        FieldOfView = 0.5,
        CameraPosition = Vector(0, -9, 0),
        CameraRotation = Vector(90, 0, 0.0)
    },
    angle2 = --forest upward shot
    {
        FieldOfView = 65.5,
        CameraPosition = Vector(-65.524002, 0.173396, -5.811923),
        CameraRotation = Vector(-38.999889, -87.072439, 0.0)
    },
    angle3 = --barn exterior meduim canted towards forest path
    {
        FieldOfView = 69.0,
        CameraPosition = Vector(2.767061, 0.100698, 7.187203),
        CameraRotation = Vector(-21.333302, -95.406273, 15.0) --more negative y = more towards barn doors
    },
    angle4 = --forest birds eye view zombie shadows from frame left to right
    {
        FieldOfView = 63.5,
        CameraPosition = Vector(-143.763138, 9.336121, 1.1964511),
        CameraRotation = Vector(90, -177.5, 0.0)
    },
    angle5 = --low to the ground, barn wide shot
    {
        FieldOfView = 72,
        CameraPosition = Vector(-12.931522, 0.438396, 13.83891),
        CameraRotation = Vector(-13.166538, 138.46904, 0.0)
    },
    angle6 = --low to the ground, forest path walkers coming to frame
    {
        FieldOfView = 74,
        CameraPosition = Vector(-10.882403, 0.109696, 11.172777),
        CameraRotation = Vector(-24.16666, -59.81234, 0.0)
    },
    angle7 = --aj closeup
    {
        FieldOfView = 34,
        CameraPosition = Vector(-0.479356, 0.536277, -2.422815),
        CameraRotation = Vector(-4.166649, -22.812515, 0.0)
    }
};

local agent_clementine = nil;
local agent_aj = nil;
local agent_zombie01 = nil;
local agent_zombie02 = nil;
local agent_zombie03 = nil;
local agent_zombie04 = nil;
local agent_zombie05 = nil;
local agent_zombie06 = nil;
local agent_zombie07 = nil;
local agent_zombie08 = nil;
local agent_zombie09 = nil;
local agent_zombie10 = nil;
local agent_zombie11 = nil;
local agent_zombie12 = nil;
local agent_zombie13 = nil;
local agent_zombie14 = nil;
local agent_zombie15 = nil;
local agent_zombie16 = nil;
local agent_zombie17 = nil;
local agent_zombie18 = nil;
local agent_zombie19 = nil;
local agent_zombie20 = nil;
local agent_zombie21 = nil;
local agent_zombie22 = nil;
local agent_zombie23 = nil;
local agent_zombie24 = nil;
local agent_zombie25 = nil;
local agent_zombieCombat1 = nil;
local agent_zombieCombat2 = nil;
local agent_zombieCombat3 = nil;
local agent_zombieCombat4 = nil;
local agent_zombieCombat5 = nil;

local PlayLoopingAnimation = function(agent, anmName)
    local controller_anm = PlayAnimation(agent, anmName);
    ControllerSetLooping(controller_anm, true);
end

local PlayRandomLoopingAnimation = function(agent, anmNameTable)
    local agentControllers = AgentGetControllers(agent);
    
    for i, cnt in ipairs(agentControllers) do
        ControllerStop(cnt);
    end

    local randomIndex = math.random(1, #anmNameTable);
    local chosenAnmName = anmNameTable[randomIndex];

    local controller_anm = PlayAnimation(agent, chosenAnmName);
    ControllerSetLooping(controller_anm, true);
end

local SetupClementineAndAJ = function()
    agent_aj = AgentFindInScene("AJ", kScene);
    agent_clementine = AgentFindInScene("Clementine", kScene);

    PlayLoopingAnimation(agent_aj, "sk63_idle_ajSitGround.anm");
    PlayLoopingAnimation(agent_clementine, "sk62_idle_clementine400OnGroundWallHoldGun.anm");
end

local GetExistingZombieAgents = function()
    agent_zombie01 = AgentFindInScene("Zombie01", kScene);
    agent_zombie02 = AgentFindInScene("Zombie02", kScene);
    agent_zombie03 = AgentFindInScene("Zombie03", kScene);
    agent_zombie04 = AgentFindInScene("Zombie04", kScene);
    agent_zombie05 = AgentFindInScene("Zombie05", kScene);
    agent_zombie06 = AgentFindInScene("Zombie06", kScene);
    agent_zombie07 = AgentFindInScene("Zombie07", kScene);
    agent_zombie08 = AgentFindInScene("Zombie08", kScene);
    agent_zombie09 = AgentFindInScene("Zombie09", kScene);
    agent_zombie10 = AgentFindInScene("Zombie10", kScene);
    agent_zombie11 = AgentFindInScene("Zombie11", kScene);
    agent_zombie12 = AgentFindInScene("Zombie12", kScene);
    agent_zombie13 = AgentFindInScene("Zombie13", kScene);
    agent_zombie14 = AgentFindInScene("Zombie14", kScene);
    agent_zombie15 = AgentFindInScene("Zombie15", kScene);
    agent_zombie16 = AgentFindInScene("Zombie16", kScene);
    agent_zombie17 = AgentFindInScene("Zombie17", kScene);
    agent_zombie18 = AgentFindInScene("Zombie18", kScene);
    agent_zombie19 = AgentFindInScene("Zombie19", kScene);
    agent_zombie20 = AgentFindInScene("Zombie20", kScene);
    agent_zombie21 = AgentFindInScene("Zombie21", kScene);
    agent_zombie22 = AgentFindInScene("Zombie22", kScene);
    agent_zombie23 = AgentFindInScene("Zombie23", kScene);
    agent_zombie24 = AgentFindInScene("Zombie24", kScene);
    agent_zombie25 = AgentFindInScene("Zombie25", kScene);
    agent_zombieCombat1 = AgentFindInScene("ZombieCombat01", kScene);
    agent_zombieCombat2 = AgentFindInScene("ZombieCombat02", kScene);
    agent_zombieCombat3 = AgentFindInScene("ZombieCombat03", kScene);
    agent_zombieCombat4 = AgentFindInScene("ZombieCombat04", kScene);
    agent_zombieCombat5 = AgentFindInScene("ZombieCombat05", kScene);
    
    local zombieWalkAnmTable = 
    {
        "sk61_zombie400_walkA.anm",
        "sk61_zombie400_walkC.anm",
        "sk61_zombie400_walkD.anm"
        --"sk61_zombie400_walkE.anm"
        --"sk61_zombie400_walkSlowA.anm",
        --"sk61_zombie400_walkSlowB.anm"
    };

    PlayRandomLoopingAnimation(agent_zombie01, zombieWalkAnmTable);
    PlayRandomLoopingAnimation(agent_zombie02, zombieWalkAnmTable);
    PlayRandomLoopingAnimation(agent_zombie03, zombieWalkAnmTable);
    PlayRandomLoopingAnimation(agent_zombie04, zombieWalkAnmTable);
    PlayRandomLoopingAnimation(agent_zombie05, zombieWalkAnmTable);
    PlayRandomLoopingAnimation(agent_zombie06, zombieWalkAnmTable);
    PlayRandomLoopingAnimation(agent_zombie07, zombieWalkAnmTable);
    PlayRandomLoopingAnimation(agent_zombie08, zombieWalkAnmTable);
    PlayRandomLoopingAnimation(agent_zombie09, zombieWalkAnmTable);
    PlayRandomLoopingAnimation(agent_zombie10, zombieWalkAnmTable);
    PlayRandomLoopingAnimation(agent_zombie11, zombieWalkAnmTable);
    PlayRandomLoopingAnimation(agent_zombie12, zombieWalkAnmTable);
    PlayRandomLoopingAnimation(agent_zombie13, zombieWalkAnmTable);
    PlayRandomLoopingAnimation(agent_zombie14, zombieWalkAnmTable);
    PlayRandomLoopingAnimation(agent_zombie15, zombieWalkAnmTable);
    PlayRandomLoopingAnimation(agent_zombie16, zombieWalkAnmTable);
    PlayRandomLoopingAnimation(agent_zombie17, zombieWalkAnmTable);
    PlayRandomLoopingAnimation(agent_zombie18, zombieWalkAnmTable);
    PlayRandomLoopingAnimation(agent_zombie19, zombieWalkAnmTable);
    PlayRandomLoopingAnimation(agent_zombie20, zombieWalkAnmTable);
    PlayRandomLoopingAnimation(agent_zombie21, zombieWalkAnmTable);
    PlayRandomLoopingAnimation(agent_zombie22, zombieWalkAnmTable);
    PlayRandomLoopingAnimation(agent_zombie23, zombieWalkAnmTable);
    PlayRandomLoopingAnimation(agent_zombie24, zombieWalkAnmTable);
    PlayRandomLoopingAnimation(agent_zombie25, zombieWalkAnmTable);
end

--|||||||||||||||||||||||||||||||||||||||||||||| CUTSCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CUTSCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CUTSCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--now starting to get into the actual juice...
--this section contains a bunch of setup functions that are basically here to get things ready for use when we need them during the actual cutscene itself.

--creates a camera that will be used for the cutscene (yes usually you create multiple but I haven't wrapped my head around how your camera layer stack system works telltale!)
Cutscene_CreateCutsceneCamera = function()
    --generic camera prop (prefab) asset
    local cam_prop = "module_camera.prop";
    
    --set a default position/rotation for the camera. (in theory this doesn't matter, but if the script somehow breaks during update the camera will stay in this position).
    local newPosition = Vector(0,15,0);
    local newRotation = Vector(90,0,0);
    
    --instaniate our cutscene camera object
    local cameraAgent = AgentCreate(agent_name_cutsceneCamera, cam_prop, newPosition, newRotation, kScene, false, false);
    
    --set the clipping planes of the camera (in plain english, how close the camera can see objects, and how far the camera can see)
    --if the near is set too high we start loosing objects in the foreground.
    --if the far is set to low we will only see part or no skybox at all
    ALIVE_AgentSetProperty(agent_name_cutsceneCamera, "Clip Plane - Far", 2500, kScene);
    ALIVE_AgentSetProperty(agent_name_cutsceneCamera, "Clip Plane - Near", 0.05, kScene);

    --bulk remove the original cameras that were in the scene
    ALIVE_RemovingAgentsWithPrefix(kScene, "cam_");

    --push our new current camera to the scene camera layer stack (since we basically removed all of the original cameras just the line before this)
    CameraPush(agent_name_cutsceneCamera);
end

--create our soundtrack for the cutscene
Cutscene_CreateSoundtrack = function()
    --play the soundtrack file
    local controller_sound_soundtrack = SoundPlay("music_teaser1.wav");
    
    --set it to loop
    ControllerSetLooping(controller_sound_soundtrack, true)
end

--|||||||||||||||||||||||||||||||||||||||||||||| CUTSCENE UPDATE ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CUTSCENE UPDATE ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CUTSCENE UPDATE ||||||||||||||||||||||||||||||||||||||||||||||


--this function is important and is responsible for setting the current shot that we are on
Cutscene_UpdateSequence = function()

    --while our shot index is less than the total amount of clips in the sequence (meaning that we are not on the last clip, and if we are then there are no more clips so this if block won't be exectuted)
    if(sequence_currentShotIndex <= sequence_maxClips) then
    
        --increment our time
        sequence_currentTimer = sequence_currentTimer + 1;
    
        --get the current clip data
        
        --calculate the variable name according to the shot index that we are on
        local sequenceClipVariableName = "clip" .. tostring(sequence_currentShotIndex);
        
        --get the clip from the sequence
        currentSequence_clip = sequence_clips[sequenceClipVariableName];

        --get the clip data we need
        currentSequence_clipInfo_duration = currentSequence_clip["shotDuration"];
        currentSequence_clipInfo_angleIndex = currentSequence_clip["angleIndex"];

        --calculate the variable name for the angle that the current shot we are on referneces
        local angleVariableName = "angle" .. tostring(currentSequence_clipInfo_angleIndex);
        
        --get the angle object that the clip references
        currentSequence_angle = sequence_cameraAngles[angleVariableName];

        --if our timer is past the duration of the current shot, move on to the next shot
        if (sequence_currentTimer > currentSequence_clipInfo_duration) then
            RenderDelay(1);
            
            --increment the shot index since we reached the end of the current clip that we are on
            sequence_currentShotIndex = sequence_currentShotIndex + 1;
            sequence_currentTimer = 0; --reset the time for the next clip
        end

        --get the angle information
        local angleInfo_fov = currentSequence_angle["FieldOfView"];
        local angleInfo_pos = currentSequence_angle["CameraPosition"];
        local angleInfo_rot = currentSequence_angle["CameraRotation"];
        
        --add our handheld camera shake to the angle position/rotation
        angleInfo_rot = angleInfo_rot + ALIVE_Cutscene_HandheldCameraAnimation_CurrentRot;
        --angleInfo_pos = angleInfo_pos + ALIVE_Cutscene_HandheldCameraAnimation_CurrentPos;
        
        --apply the data to the camera
        ALIVE_AgentSetProperty(agent_name_cutsceneCamera, "Field Of View", angleInfo_fov, kScene);
        ALIVE_SetAgentWorldPosition(agent_name_cutsceneCamera, angleInfo_pos, kScene);
        ALIVE_SetAgentWorldRotation(agent_name_cutsceneCamera, angleInfo_rot, kScene);
    end
    
    local sunColor     = RGBColor(255, 230, 198, 255);
    local ambientColor = RGBColor(108, 150, 255, 255);
    local skyColor     = RGBColor(0, 80, 255, 255);
    local fogColor     = Desaturate_RGBColor(skyColor, 0.7);
    
    --adjust the colors a bit (yes there is a lot of tweaks... would be easier if we had a level editor... but we dont yet)
    skyColor = Desaturate_RGBColor(skyColor, 0.2);
    fogColor = Multiplier_RGBColor(fogColor, 0.8);
    fogColor = Desaturate_RGBColor(fogColor, 0.45);
    sunColor = Desaturate_RGBColor(sunColor, 0.15);
    skyColor = Desaturate_RGBColor(skyColor, 0.2);
    sunColor = Desaturate_RGBColor(sunColor, -0.99);
    ambientColor = Desaturate_RGBColor(ambientColor, 0.25);
    ambientColor = Multiplier_RGBColor(ambientColor, 1.0);

    ALIVE_AgentSetProperty("ZombieCombat01", "Runtime: Visible", false, kScene);
    ALIVE_AgentSetProperty("ZombieCombat02", "Runtime: Visible", false, kScene);
    ALIVE_AgentSetProperty("ZombieCombat03", "Runtime: Visible", false, kScene);
    ALIVE_AgentSetProperty("ZombieCombat04", "Runtime: Visible", false, kScene);
    ALIVE_AgentSetProperty("ZombieCombat05", "Runtime: Visible", false, kScene);

    if (sequence_currentShotIndex == 1) then --black
        ALIVE_SetAgentWorldRotation("myLight_Sun", Vector(36.666, 113.1561, 0), kScene);
        ALIVE_AgentSetProperty("group_tile1", "Group - Visible", true, kScene);
        ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Intensity", 25, kScene);
        ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Shadow Type", 2, kScene);
        ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Wrap", 0.25, kScene);
        ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Intensity", 0.0, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Start Distance", 0.25, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Height", 3.45, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Density", 0.00025, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Max Opacity", 0.35, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "Ambient Color", ambientColor, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "LightEnv Shadow Max Distance", 20.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "LightEnv Dynamic Shadow Max Distance", 25.0, kScene);
    elseif (sequence_currentShotIndex == 2) then --forest wide
        ambientColor = Desaturate_RGBColor(ambientColor, 0.45);
    
        ALIVE_SetAgentWorldRotation("myLight_Sun", Vector(36.666, 113.1561, 0), kScene);
        ALIVE_AgentSetProperty("group_tile1", "Group - Visible", true, kScene);
        ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Intensity", 45, kScene);
        ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Shadow Type", 2, kScene);
        ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Wrap", 0.35, kScene);
        ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Intensity", 0.45, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Start Distance", 0.25, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Height", 3.45, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Falloff", 3.5, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Density", 0.00025, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Max Opacity", 0.65, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "Ambient Color", Multiplier_RGBColor(ambientColor, 1.35), kScene);
        ALIVE_AgentSetProperty(kSceneObj, "LightEnv Shadow Max Distance", 17.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "LightEnv Dynamic Shadow Max Distance", 17.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Intensity", 1.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap White Point", 16.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Black Point", 0.012, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Filmic Toe Intensity", 1.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Filmic Shoulder Intensity", 0.75, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Type", 2, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Filmic Pivot", 0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Filmic Shoulder Intensity", 0.7, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Enabled", true, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Intensity", 3.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Radius", 0.8, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Max Radius Percent", 0.76, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Max Distance", 35.5, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Distance Falloff", 0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Hemisphere Bias", -0.2, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Bloom Threshold", -0.65, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Bloom Intensity", 0.35, kScene);
    elseif (sequence_currentShotIndex == 3) then --zombie shadows
        ALIVE_SetAgentWorldRotation("myLight_Sun", Vector(9.666, 90, 0), kScene);
        ALIVE_SetAgentWorldPosition("procedualGrassGroup", Vector(-144.57, -3.340749, -2.59), kScene);
        ALIVE_AgentSetProperty("group_tile1", "Group - Visible", true, kScene);
        ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Intensity", 15, kScene);
        ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Shadow Type", 2, kScene);
        ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Wrap", 0.0, kScene);
        ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Intensity", 0.25, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Start Distance", 0.25, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Height", 3.45, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Density", 0.00025, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Max Opacity", 0.35, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Falloff", 3.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "Ambient Color", Multiplier_RGBColor(ambientColor, 0.25), kScene);
        ALIVE_AgentSetProperty(kSceneObj, "LightEnv Shadow Max Distance", 30.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "LightEnv Dynamic Shadow Max Distance", 35.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Intensity", 1.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap White Point", 10.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Black Point", 0.005, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Filmic Toe Intensity", 1.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Filmic Shoulder Intensity", 0.75, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Type", 2, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Filmic Pivot", 0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Filmic Shoulder Intensity", 0.8, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Enabled", true, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Intensity", 2.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Radius", 0.5, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Max Radius Percent", 0.5, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Max Distance", 35.5, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Distance Falloff", 0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Hemisphere Bias", -0.2, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Bloom Threshold", -0.45, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Bloom Intensity", 0.45, kScene);
   elseif (sequence_currentShotIndex == 4) then --barn wide 1
        ALIVE_SetAgentWorldRotation("myLight_Sun", Vector(36.666, 113.1561, 0), kScene);
        ALIVE_SetAgentWorldPosition("procedualGrassGroup", Vector(-13.57, -0.013749, 12.59), kScene);
        ALIVE_AgentSetProperty("group_tile1", "Group - Visible", false, kScene);
        ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Intensity", 25, kScene);
        ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Shadow Type", 3, kScene);
        ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Wrap", 0.05, kScene);
        ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Intensity", 0.5, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Start Distance", 0.25, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Height", 3.45, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Density", 0.00025, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Max Opacity", 0.45, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Falloff", 1.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "LightEnv Shadow Max Distance", 20.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "LightEnv Dynamic Shadow Max Distance", 25.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Intensity", 1.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap White Point", 10.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Black Point", 0.005, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Filmic Toe Intensity", 1.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Filmic Shoulder Intensity", 0.75, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Type", 2, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Filmic Pivot", 0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Filmic Shoulder Intensity", 0.8, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Enabled", true, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Intensity", 2.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Radius", 0.5, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Max Radius Percent", 0.5, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Max Distance", 35.5, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Distance Falloff", 0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Hemisphere Bias", -0.2, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Bloom Threshold", -0.45, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Bloom Intensity", 0.25, kScene);
    elseif (sequence_currentShotIndex == 5) then --barn wide 2
        ALIVE_SetAgentWorldRotation("myLight_Sun", Vector(36.666, 113.1561, 0), kScene);
        ALIVE_SetAgentWorldPosition("procedualGrassGroup", Vector(-0.57, -0.340749, 12.59), kScene);
        ALIVE_SetAgentWorldRotation("procedualGrassGroup", Vector(0, 0, -2), kScene);
        ALIVE_AgentSetProperty("group_tile1", "Group - Visible", false, kScene);
        ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Intensity", 25, kScene);
        ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Shadow Type", 3, kScene);
        ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Wrap", 0.05, kScene);
        ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Intensity", 0.5, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Start Distance", 0.25, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Height", 3.45, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Density", 0.00025, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Max Opacity", 0.45, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Falloff", 1.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "LightEnv Shadow Max Distance", 20.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "LightEnv Dynamic Shadow Max Distance", 25.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Intensity", 1.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap White Point", 14.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Black Point", 0.005, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Filmic Toe Intensity", 1.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Filmic Shoulder Intensity", 0.75, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Type", 2, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Filmic Pivot", 0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Filmic Shoulder Intensity", 0.8, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Enabled", true, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Intensity", 2.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Radius", 0.5, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Max Radius Percent", 0.5, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Max Distance", 35.5, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Distance Falloff", 0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Hemisphere Bias", -0.2, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Bloom Threshold", -0.45, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Bloom Intensity", 0.45, kScene);
    elseif (sequence_currentShotIndex == 6) then --black
    elseif (sequence_currentShotIndex == 7) then --aj reverse
        ALIVE_SetAgentWorldRotation("myLight_Sun", Vector(41.33, 166.406, 0), kScene);
        ALIVE_SetAgentWorldPosition("procedualGrassGroup", Vector(0, -3, 0), kScene);
        ALIVE_AgentSetProperty("group_tile1", "Group - Visible", false, kScene);
        ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Intensity", 45, kScene);
        ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Shadow Type", 2, kScene);
        ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Wrap", 0.0, kScene);
        ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Intensity", 0.0, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Start Distance", 0.25, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Height", 3.45, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Density", 0.00025, kScene);
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Max Opacity", 0.35, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "LightEnv Shadow Max Distance", 10.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "LightEnv Dynamic Shadow Max Distance", 10.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Intensity", 1.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap White Point", 10.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Black Point", 0.009, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Filmic Toe Intensity", 1.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Filmic Shoulder Intensity", 0.75, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Type", 2, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Filmic Pivot", 0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Tonemap Filmic Shoulder Intensity", 0.8, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Enabled", true, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Intensity", 2.0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Radius", 0.5, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Max Radius Percent", 0.5, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Max Distance", 35.5, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Distance Falloff", 0, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "HBAO Hemisphere Bias", -0.2, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Bloom Threshold", -0.45, kScene);
        ALIVE_AgentSetProperty(kSceneObj, "FX Bloom Intensity", 0.45, kScene);
    elseif (sequence_currentShotIndex == 8) then --black
    end
end

local zombie01Move = Vector(0,0,0);
local zombie02Move = Vector(0,0,0);
local zombie03Move = Vector(0,0,0);
local zombie04Move = Vector(0,0,0);
local zombie05Move = Vector(0,0,0);
local zombie06Move = Vector(0,0,0);
local zombie07Move = Vector(0,0,0);
local zombie08Move = Vector(0,0,0);
local zombie09Move = Vector(0,0,0);
local zombie10Move = Vector(0,0,0);
local zombie11Move = Vector(0,0,0);
local zombie12Move = Vector(0,0,0);
local zombie13Move = Vector(0,0,0);
local zombie14Move = Vector(0,0,0);
local zombie15Move = Vector(0,0,0);
local zombie16Move = Vector(0,0,0);
local zombie17Move = Vector(0,0,0);
local zombie18Move = Vector(0,0,0);
local zombie19Move = Vector(0,0,0);
local zombie20Move = Vector(0,0,0);
local zombie21Move = Vector(0,0,0);
local zombie22Move = Vector(0,0,0);
local zombie23Move = Vector(0,0,0);
local zombie24Move = Vector(0,0,0);
local zombie25Move = Vector(0,0,0);

local zombie01_offset = Vector(0,0,0);
local zombie02_offset = Vector(0,0,0);
local zombie03_offset = Vector(0,0,0);
local zombie04_offset = Vector(0,0,0);
local zombie05_offset = Vector(0,0,0);
local zombie06_offset = Vector(0,0,0);
local zombie07_offset = Vector(0,0,0);
local zombie08_offset = Vector(0,0,0);
local zombie09_offset = Vector(0,0,0);
local zombie10_offset = Vector(0,0,0);
local zombie11_offset = Vector(0,0,0);
local zombie12_offset = Vector(0,0,0);
local zombie13_offset = Vector(0,0,0);
local zombie14_offset = Vector(0,0,0);
local zombie15_offset = Vector(0,0,0);
local zombie16_offset = Vector(0,0,0);
local zombie17_offset = Vector(0,0,0);
local zombie18_offset = Vector(0,0,0);
local zombie19_offset = Vector(0,0,0);
local zombie20_offset = Vector(0,0,0);
local zombie21_offset = Vector(0,0,0);
local zombie22_offset = Vector(0,0,0);
local zombie23_offset = Vector(0,0,0);
local zombie24_offset = Vector(0,0,0);
local zombie25_offset = Vector(0,0,0);
local zombiesStartPos = Vector(0,0,0);

local MoveZombie = function(zombieAgent, zombieAgentName, mover, offsetVec)
    local localDirection = AgentLocalToWorld(zombieAgent, Vector(0,0,1));
    local worldPos = AgentGetWorldPos(zombieAgent);

    mover.x = mover.x + 0.0065;
    
    local finalPos = VectorAdd(offsetVec, mover);
    
    ALIVE_SetAgentPosition(zombieAgentName, finalPos, kScene);

    local zombieRotationGlobal = Vector(0, 90, 0)
    ALIVE_SetAgentRotation(zombieAgentName, zombieRotationGlobal, kScene);
end

local ZeroZombieMoveValues = function()
    zombie01Move = Vector(0,0,0);
    zombie02Move = Vector(0,0,0);
    zombie03Move = Vector(0,0,0);
    zombie04Move = Vector(0,0,0);
    zombie05Move = Vector(0,0,0);
    zombie06Move = Vector(0,0,0);
    zombie07Move = Vector(0,0,0);
    zombie08Move = Vector(0,0,0);
    zombie09Move = Vector(0,0,0);
    zombie10Move = Vector(0,0,0);
    zombie11Move = Vector(0,0,0);
    zombie12Move = Vector(0,0,0);
    zombie13Move = Vector(0,0,0);
    zombie14Move = Vector(0,0,0);
    zombie15Move = Vector(0,0,0);
    zombie16Move = Vector(0,0,0);
    zombie17Move = Vector(0,0,0);
    zombie18Move = Vector(0,0,0);
    zombie19Move = Vector(0,0,0);
    zombie20Move = Vector(0,0,0);
    zombie21Move = Vector(0,0,0);
    zombie22Move = Vector(0,0,0);
    zombie23Move = Vector(0,0,0);
    zombie24Move = Vector(0,0,0);
    zombie25Move = Vector(0,0,0);

    zombie01_offset = Vector(0,0,0);
    zombie02_offset = Vector(0,0,0);
    zombie03_offset = Vector(0,0,0);
    zombie04_offset = Vector(0,0,0);
    zombie05_offset = Vector(0,0,0);
    zombie06_offset = Vector(0,0,0);
    zombie07_offset = Vector(0,0,0);
    zombie08_offset = Vector(0,0,0);
    zombie09_offset = Vector(0,0,0);
    zombie10_offset = Vector(0,0,0);
    zombie11_offset = Vector(0,0,0);
    zombie12_offset = Vector(0,0,0);
    zombie13_offset = Vector(0,0,0);
    zombie14_offset = Vector(0,0,0);
    zombie15_offset = Vector(0,0,0);
    zombie16_offset = Vector(0,0,0);
    zombie17_offset = Vector(0,0,0);
    zombie18_offset = Vector(0,0,0);
    zombie19_offset = Vector(0,0,0);
    zombie20_offset = Vector(0,0,0);
    zombie21_offset = Vector(0,0,0);
    zombie22_offset = Vector(0,0,0);
    zombie23_offset = Vector(0,0,0);
    zombie24_offset = Vector(0,0,0);
    zombie25_offset = Vector(0,0,0);
    zombiesStartPos = Vector(0,0,0);
end

local randomX_max = 2;
local randomX_min = -2;
local randomZ_max = 6;
local randomZ_min = -6;
local decimalValue = 100;

Cutscene_UpdateMoveShitAround = function()
    ALIVE_SetAgentPosition("Clementine", Vector(-0.6152, 0, -2.19), kScene);
    ALIVE_SetAgentPosition("AJ", Vector(-0.71, 0.13, -1.59), kScene);
    ALIVE_SetAgentRotation("AJ", Vector(0, 180, 0), kScene);

    if (sequence_currentShotIndex == 3) then
        if (sequence_currentTimer == 0) then
            ZeroZombieMoveValues();

            randomX_max = 2;
            randomX_min = -4;
            randomZ_max = 4;
            randomZ_min = -4;
            decimalValue = 100;
            
            zombiesStartPos = Vector(-157, 0, 0);
            
            zombie01_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie02_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie03_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie04_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie05_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie06_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie07_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie08_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie09_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie10_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie11_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie12_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie13_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie14_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie15_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie16_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie17_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie18_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie19_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie20_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie21_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie22_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie23_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie24_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie25_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
        end
        
        local newVecSpeed = Vector(0.004, 0, 0);
        zombie01Move = VectorAdd(zombie01Move, newVecSpeed);
        zombie02Move = VectorAdd(zombie02Move, newVecSpeed);
        zombie03Move = VectorAdd(zombie03Move, newVecSpeed);
        zombie04Move = VectorAdd(zombie04Move, newVecSpeed);
        zombie05Move = VectorAdd(zombie05Move, newVecSpeed);
        zombie06Move = VectorAdd(zombie06Move, newVecSpeed);
        zombie07Move = VectorAdd(zombie07Move, newVecSpeed);
        zombie08Move = VectorAdd(zombie08Move, newVecSpeed);
        zombie09Move = VectorAdd(zombie09Move, newVecSpeed);
        zombie10Move = VectorAdd(zombie10Move, newVecSpeed);
        zombie11Move = VectorAdd(zombie11Move, newVecSpeed);
        zombie12Move = VectorAdd(zombie12Move, newVecSpeed);
        zombie13Move = VectorAdd(zombie13Move, newVecSpeed);
        zombie14Move = VectorAdd(zombie14Move, newVecSpeed);
        zombie15Move = VectorAdd(zombie15Move, newVecSpeed);
        zombie16Move = VectorAdd(zombie16Move, newVecSpeed);
        zombie17Move = VectorAdd(zombie17Move, newVecSpeed);
        zombie18Move = VectorAdd(zombie18Move, newVecSpeed);
        zombie19Move = VectorAdd(zombie19Move, newVecSpeed);
        zombie20Move = VectorAdd(zombie20Move, newVecSpeed);
        zombie21Move = VectorAdd(zombie21Move, newVecSpeed);
        zombie22Move = VectorAdd(zombie22Move, newVecSpeed);
        zombie23Move = VectorAdd(zombie23Move, newVecSpeed);
        zombie24Move = VectorAdd(zombie24Move, newVecSpeed);
        zombie25Move = VectorAdd(zombie25Move, newVecSpeed);
        
    elseif (sequence_currentShotIndex == 4) then
        if (sequence_currentTimer == 0) then
            ZeroZombieMoveValues();
            
            randomX_max = 4;
            randomX_min = -4;
            randomZ_max = 1;
            randomZ_min = -1;
            decimalValue = 100;
            
            zombiesStartPos = Vector(-17, 0.15, 12);
            
            zombie01_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie02_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie03_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie04_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie05_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie06_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie07_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie08_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie09_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie10_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie11_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie12_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie13_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie14_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie15_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie16_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie17_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie18_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie19_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie20_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie21_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie22_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie23_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie24_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie25_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
        end
    elseif (sequence_currentShotIndex == 5) then
        if (sequence_currentTimer == 0) then
            ZeroZombieMoveValues();
            
            randomX_max = 5;
            randomX_min = -5;
            randomZ_max = 3;
            randomZ_min = -3;
            decimalValue = 100;
            
            zombiesStartPos = Vector(-7, 0, 9.5);
            
            zombie01_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie02_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie03_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie04_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie05_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie06_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie07_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie08_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie09_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie10_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie11_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie12_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie13_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie14_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie15_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie16_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie17_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie18_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie19_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie20_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie21_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie22_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie23_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie24_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie25_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
        end
    elseif (sequence_currentShotIndex == 7) then
        if (sequence_currentTimer == 0) then
            ZeroZombieMoveValues();
            
            randomX_max = 5;
            randomX_min = -5;
            randomZ_max = 3;
            randomZ_min = -3;
            decimalValue = 100;
            
            zombiesStartPos = Vector(-7, 0, 9.5);
            
            zombie01_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie02_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie03_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie04_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie05_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie06_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie07_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie08_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie09_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie10_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie11_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie12_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie13_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie14_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie15_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie16_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie17_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie18_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie19_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie20_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie21_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie22_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie23_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie24_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie25_offset = Vector(ALIVE_RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, ALIVE_RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
        end
    end
    
    MoveZombie(agent_zombie01, "Zombie01", zombie01Move, zombie01_offset);
    MoveZombie(agent_zombie02, "Zombie02", zombie02Move, zombie02_offset);
    MoveZombie(agent_zombie03, "Zombie03", zombie03Move, zombie03_offset);
    MoveZombie(agent_zombie04, "Zombie04", zombie04Move, zombie04_offset);
    MoveZombie(agent_zombie05, "Zombie05", zombie05Move, zombie05_offset);
    MoveZombie(agent_zombie06, "Zombie06", zombie06Move, zombie06_offset);
    MoveZombie(agent_zombie07, "Zombie07", zombie07Move, zombie07_offset);
    MoveZombie(agent_zombie08, "Zombie08", zombie08Move, zombie08_offset);
    MoveZombie(agent_zombie09, "Zombie09", zombie09Move, zombie09_offset);
    MoveZombie(agent_zombie10, "Zombie10", zombie10Move, zombie10_offset);
    MoveZombie(agent_zombie11, "Zombie11", zombie11Move, zombie11_offset);
    MoveZombie(agent_zombie12, "Zombie12", zombie12Move, zombie12_offset);
    MoveZombie(agent_zombie13, "Zombie13", zombie13Move, zombie13_offset);
    MoveZombie(agent_zombie14, "Zombie14", zombie14Move, zombie14_offset);
    MoveZombie(agent_zombie15, "Zombie15", zombie15Move, zombie15_offset);
    MoveZombie(agent_zombie16, "Zombie16", zombie16Move, zombie16_offset);
    MoveZombie(agent_zombie17, "Zombie17", zombie17Move, zombie17_offset);
    MoveZombie(agent_zombie18, "Zombie18", zombie18Move, zombie18_offset);
    MoveZombie(agent_zombie19, "Zombie19", zombie19Move, zombie19_offset);
    MoveZombie(agent_zombie20, "Zombie20", zombie20Move, zombie20_offset);
    MoveZombie(agent_zombie21, "Zombie21", zombie21Move, zombie21_offset);
    MoveZombie(agent_zombie22, "Zombie22", zombie22Move, zombie22_offset);
    MoveZombie(agent_zombie23, "Zombie23", zombie23Move, zombie23_offset);
    MoveZombie(agent_zombie24, "Zombie24", zombie24Move, zombie24_offset);
    MoveZombie(agent_zombie25, "Zombie25", zombie25Move, zombie25_offset);
end

local ajBlinkTick = 0;
local ajBlinkMax = 110;

AJBlinks = function()
    ajBlinkTick = ajBlinkTick + 1;
    
    if (ajBlinkTick >= ajBlinkMax) then
        local cnt = ALIVE_ChorePlayOnAgent("aJ_face_blink.chore", agent_aj, nil, nil);
        --local cnt = PlayAnimation(agent_aj, "wd400GM_face_eyesClosed_add.anm");
        ControllerSetLooping(cnt, false);
                 
        ajBlinkTick = 0;
    end
end

local lookDownCnt = nil;
local aj_emotion1 = nil;
local aj_emotion2 = nil;
local aj_emotion3 = nil;

Cutscene_UpdateCharacterActing = function()
    agent_aj = AgentFindInScene("AJ", kScene);

    if (sequence_currentShotIndex == 1) then 
    elseif (sequence_currentShotIndex == 2) then 
    elseif (sequence_currentShotIndex == 6) then 
       if (sequence_currentTimer == 30) then
           lookDownCnt = ALIVE_ChorePlayOnAgent("aj_headGesture_lookDownLeft", agent_aj, nil, nil);
           aj_emotion1 = ALIVE_ChorePlayOnAgent("aJ_face_moodSadA.chore", agent_aj, nil, nil);
           ControllerSetLooping(aj_emotion1, true);
       end
    elseif (sequence_currentShotIndex == 7) then 
        if (sequence_currentTimer == 25) then
            ControllerFadeOut(lookDownCnt, 2.5);
        end
        
        if (sequence_currentTimer == 5) then
            local cnt1 = PlayAnimation(agent_aj, "batmanGM_headEyeGesture_browsDownLong_add.anm");
            ControllerSetContribution(cnt1, 2);
            ControllerSetPriority(cnt1, 100);
        end
         
        if (sequence_currentTimer == 130) then
            PlayAnimation(agent_aj, "sk61_wd400GMStandA_tiltFwd_add.anm");
        end
        
        if (sequence_currentTimer == 80) then
            local cnt1 = PlayAnimation(agent_aj, "batmanGM_headEyeGesture_browsUp_add.anm");

            ControllerSetContribution(cnt1, 2);
            ControllerSetPriority(cnt1, 100);
        end

        if (sequence_currentTimer == 205) then
            PlayAnimation(agent_aj, "aj_eyes_eyeRLookAtDownToUp_add.anm");
            PlayAnimation(agent_aj, "aj_eyes_eyeLLookAtDownToUp_add.anm");
        end
        
        if (sequence_currentTimer == 235) then
            local cnt1 = PlayAnimation(agent_aj, "batmanGM_headEyeGesture_browsDownLong_add.anm");
            ControllerSetContribution(cnt1, 2);
            ControllerSetPriority(cnt1, 100);
        end
        
        if (sequence_currentTimer == 305) then
            local cnt1 = PlayAnimation(agent_aj, "batmanGM_headEyeGesture_browsDownLong_add.anm");
            ControllerSetContribution(cnt1, 2);
            ControllerSetPriority(cnt1, 100);
        end
         
        if (sequence_currentTimer == 315) then
            ALIVE_ChorePlayOnAgent("aj_headGesture_lookDownLeft", agent_aj, nil, nil);
        end
    end
end

local voiceLineTick = 0;
local maxVoiceLineTick = 19200;

local AJVoiceLines = function()
    voiceLineTick = voiceLineTick + 1;

    if(voiceLineTick == 300) then
        ALIVE_Cutscene_CharacterVoiceLine_Play(agent_aj, "396767243", 1.0, 100); --I always listened to Clem, always. But I've been thinking more...
    end
    
    if(voiceLineTick == 850) then
        ALIVE_Cutscene_CharacterVoiceLine_Play(agent_aj, "396767275", 1.0, 100); --She told me way back, to shoot her if she got bit...
    end
    
    if(voiceLineTick == 1150) then
        ALIVE_Cutscene_CharacterVoiceLine_Play(agent_aj, "396730926", 1.0, 100); --I thought a lot about it, and I felt a lotta ways about it...
    end

    if(voiceLineTick == 1600) then
        ALIVE_Cutscene_CharacterVoiceLine_Play(agent_aj, "396706038", 1.0, 100); --sigh
    end
    
    if(voiceLineTick == 1700) then
        ALIVE_Cutscene_CharacterVoiceLine_Play(agent_aj, "396542111", 1.0, 100); --clem 2
    end
    
    if(voiceLineTick == 1900) then
        ALIVE_Cutscene_CharacterVoiceLine_Play(agent_aj, "396722851", 1.0, 100); --I can't let you turn into a monster.
    end
    
    if(voiceLineTick == 2400) then
        voiceLineTick = 0;
    end
end

--main level script, this function gets called when the scene loads
--its important we call everything here and set up everything so our work doesn't go to waste
ALIVE_Level_Cutscene_Teaser1 = function()
    ----------------------------------------------------------------
    --scene setup (call all of our scene setup functions)
    ALIVE_Core_Project_SetProjectSettings();
    ALIVE_Scene_LevelCleanup_404_ForestBarn_Teaser(kScene);
    ALIVE_Scene_LevelRelight_404_ForestBarn_Teaser_AddProcedualGrass(kScene);
    ALIVE_Scene_LevelRelight_404_ForestBarn_Teaser_AddAdditionalParticleEffects(kScene);
    ALIVE_Scene_LevelRelight_404_ForestBarn_Teaser(kScene);

    GetExistingZombieAgents();
    SetupClementineAndAJ();
    ALIVE_Character_AJ_Teaser(kScene);
    ALIVE_Character_Clementine_Sick(kScene);
    
    --cutscene setup (start calling our cutscene setup functions)
    Cutscene_CreateSoundtrack(); --start playing our custom soundtrack and have it loop

    --if we are not in freecam mode, go ahead and create the cutscene camera
    if (EnableFreecamTools == false) then
        Cutscene_CreateCutsceneCamera(); --create our cutscene camera in the scene
    end

    ALIVE_Gameplay_Shared_HideCusorInGame(); --hide the cursor during the cutscene

    ----------------------------------------------------------------
    --cutscene update functions (these run every single frame, and this is where the magic happens)
    
    --add all of our update functions, and these will run for every single frame that is rendered
    Callback_OnPostUpdate:Add(Cutscene_UpdateSequence);
    Callback_OnPostUpdate:Add(Cutscene_UpdateCharacterActing);
    --Callback_OnPostUpdate:Add(AJBlinks);
    
    Callback_OnPostUpdate:Add(AJVoiceLines);
    Callback_OnPostUpdate:Add(Cutscene_UpdateMoveShitAround);
    
    --add depth of field
    ALIVE_Camera_DepthOfFieldAutofocus_SetupDOF(kScene)
    Callback_OnPostUpdate:Add(ALIVE_Camera_DepthOfFieldAutofocus_PerformAutofocus);

    --add a procedual handheld camera animation
    ALIVE_Cutscene_HandheldCameraAnimation_TotalShakeAmount = 0.35;
    ALIVE_Cutscene_HandheldCameraAnimation_TotalSpeedMultiplier = 0.55;
    ALIVE_Cutscene_HandheldCameraAnimation_ShakeLevel = 4;
    Callback_OnPostUpdate:Add(ALIVE_Cutscene_HandheldCameraAnimation_Update);
    Callback_OnPostUpdate:Add(ApplyHandheldCameraAnimation);
    
    ----------------------------------------------------------------
    --CUTSCENE DEVELOPMENT

    if (ALIVE_Core_Project_IsDebugMode) then
        if(EnablePerformanceMetrics) then
            ALIVE_Development_PerformanceMetrics_Initalize();
            Callback_OnPostUpdate:Add(ALIVE_Development_PerformanceMetrics_Update);
        end

        if (EnableFreecamTools) then
            --commented out on purpose, but when the scene starts this prints all of the scene agents to a text file that is saved in the game directory.
            --ALIVE_PrintSceneListToTXT(kScene, "adv_forestBarn404.txt");
       
            --create our free camera and our cutscene dev tools
            ALIVE_Development_CreateFreeCamera();
            ALIVE_Development_InitalizeCutsceneTools();

            --add these development update functions, and have them run every frame
            Callback_OnPostUpdate:Add(ALIVE_Development_UpdateFreeCamera);
            Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Input);
            Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Main);
        end
    end
end

--open the scene with this script
SceneOpen(kScene, kScript)