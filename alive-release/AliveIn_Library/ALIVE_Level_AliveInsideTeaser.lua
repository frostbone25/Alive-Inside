--[[
-------------------------------------------------------------------------

]]--

require("ALIVE_Utilities.lua");
require("ALIVE_AgentExtensions.lua");
require("ALIVE_Color.lua");
require("ALIVE_Printing.lua");
require("ALIVE_PropertyKeys.lua");
require("ALIVE_Development_Freecam.lua");
require("ALIVE_Development_AgentBrowser.lua");
require("ALIVE_DepthOfFieldAutofocus.lua");

ResourceSetEnable("ProjectSeason4");
ResourceSetEnable("WalkingDead402");
ResourceSetEnable("WalkingDead404");
ResourceSetEnable("WalkingDead201");

--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||

--main level variables
local kScript = "ALIVE_Level_AliveInsideTeaser";
local kScene = "adv_forestBarn";

--scene agent name variable
local agent_name_scene = "adv_forestBarn.scene";

--cutscene development variables variables (these are variables required by the development scripts)
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
    "test"
};

--list of objects in the scene that are our targets for depth of field autofocusing
ALIVE_DOF_AUTOFOCUS_ObjectEntries =
{
    "AJ"
};

--cutscene variables
local MODE_FREECAM = false;
local agent_name_cutsceneCamera = "myCutsceneCamera";
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

--controller variables (these just store a reference to the animations/chores that are playing during the cutscene)
local controller_animation_clementineWalk = nil; --dont touch
local controller_animation_christaWalk = nil; --dont touch
local controller_animation_omidWalk = nil; --dont touch
local controller_animation_clementineBlink = nil; --dont touch
local controller_animation_clementineEyesLookUp = nil; --dont touch
local controller_animation_clementineEyesLookDown = nil; --dont touch
local controller_animation_clementineEyesDarting = nil; --dont touch
local controller_animation_clementineHeadLookUp = nil; --dont touch
local controller_animation_clementineHeadLookDown = nil; --dont touch
local controller_chore_clementineEmotion = nil; --dont touch

--update tick variables for clementine additive blinking animation
local maxTick_animation_clementine_blink = 100.0; --the (duration) that clem has her eyes open before she blinks
local tick_animation_clementine_blink = 0.0; --dont touch (main tick blink variable, this gets incremented 1 every frame and resets when we reach the maxtick for blink)

--enviorment scrolling variables
local enviorment_scroll_maxPositionZ = 25; --the maximum z position in which the enviorment scrolls to, when it reaches this it will reset back to 0 and go again.
local enviorment_scroll_positionZ = 0; --dont touch (the main z position that gets incremented every frame by the scroll speed)
local enviorment_scroll_speed = 0.01; --the speed at which the enviorment will scroll/move

--procedual handheld camera animation (adds a bit of extra life and motion to the camera throughout the sequence)
local camera_handheld_rot_strength = 10; --the amount of (shake) for the camera rotation
local camera_handheld_pos_strength = 0.35; --the amount of (shake) for the camera position
local camera_handheld_rot_lerpFactor = 0.5; --how smooth/snappy the rotation shake will be
local camera_handheld_pos_lerpFactor = 0.5;--how smooth/snappy the position shake will be
local camera_handheld_desiredRot = Vector(0, 0, 0); --dont touch (the desired random calculated shake for rotational movement)
local camera_handheld_desiredPos = Vector(0, 0, 0); --dont touch (the desired random calculated shake for positional movement)
local camera_handheld_currentRot = Vector(0, 0, 0); --dont touch (the current rotation of the shake, overtime it tries to [match] the desired rotation)
local camera_handheld_currentPos = Vector(0, 0, 0); --dont touch (the current position of the shake, overtime it tries to [match] the desired position)
local camera_handheld_tick = 0; --dont touch (main handheld tick variable, this gets incremented 1 every frame until we reach the update level, and then the time resets (so we don't calculate a new shake every single frame, this spaces it out)
local camera_handheld_updateLevel = 30; --the (duration) until a new desired shake rotation/position is calculated

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

--hides the cursor in game
HideCusorInGame = function()
    --hide the cursor
    CursorHide(true);
    
    --enable cusor functionality
    CursorEnable(true);
end

local SetProjectSettings = function()
    local prefs = GetPreferences();
    --PropertySet(prefs, "Enable Graphic Black", false);
    --PropertySet(prefs, "Render - Graphic Black Enabled", false);
    PropertySet(prefs, "Camera Lens Engine", false);
    PropertySet(prefs, "Enable Dialog System 2.0", true);
    PropertySet(prefs, "Enable LipSync 2.0", true);
    PropertySet(prefs, "Legacy Light Limits", false);
    PropertySet(prefs, "Render - Feature Level", 1);
    PropertySet(prefs, "Use Legacy DOF", true);
    PropertySet(prefs, "Animated Lookats Active", false);
    PropertySet(prefs, "Camera Lens Engine", false);
    PropertySet(prefs, "Chore End Lipsync Buffer Time", -1);
    PropertySet(prefs, "Enable Callbacks For Unchanged Key Sets", true);
    PropertySet(prefs, "Enable Lipsync Line Buffers", false);
    PropertySet(prefs, "Fix Pop In Additive Idle Transitions", false);
    PropertySet(prefs, "Fix Recursive Animation Contribution (set to false before Thrones)", false);
    PropertySet(prefs, "Legacy Use Default Lighting Group", true);
    PropertySet(prefs, "Lipsync Line End Buffer", 0);
    PropertySet(prefs, "Lipsync Line Start Buffer", 0);
    PropertySet(prefs, "Mirror Non-skeletal Animations", false);
    PropertySet(prefs, "Project Generates Procedural Look At Targets", false);
    PropertySet(prefs, "Remap bad bones", true);
    PropertySet(prefs, "Set Default Intensity", false);
    PropertySet(prefs, "Strip action lines", true);
    PropertySet(prefs, "Text Leading Fix", true);
end

local PlayLoopingAnimation = function(agent, anmName)
    local controller_anm = PlayAnimation(agent, anmName);
    ControllerSetLooping(controller_anm, true);
end

local PlayRandomLoopingAnimation = function(agent, anmNameTable)
    local agentControllers = AgentGetControllers(agent);
    
    for i, cnt in ipairs(agentControllers) do
        ControllerStop(cnt);
        --ControllerPause(cnt);
        --ControllerSetLooping(cnt, false);
    end

    local randomIndex = math.random(1, #anmNameTable);
    local chosenAnmName = anmNameTable[randomIndex];

    local controller_anm = PlayAnimation(agent, chosenAnmName);
    ControllerSetLooping(controller_anm, true);
    --ControllerSetTimeScale(controller_anm, math.random(0.35, 1.0));
    
    --ControllerSetVolume(controller_anm, 0);
     --ControllerSetSoundVolume(controller_anm, 0);
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
    ALIVE_RemovingAgentsWithPrefix(kScene, "qte_");
    
    ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "Zombie", "Runtime: Visible", true)
    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "Zombie", "Runtime: Visible", false)
    --ALIVE_RemovingAgentsWithPrefix(kScene, "Zombie");
    
    --ALIVE_AgentSetProperty("group_tile1", "Group - Visible", false, kScene);
    
    ALIVE_RemoveAgent("light_ENV_interior_amb", kScene);
    --ALIVE_RemoveAgent("light_ENV_exterior_amb", kScene);
    ALIVE_RemoveAgent("light_ENV_interior", kScene);
    --ALIVE_RemoveAgent("light_ENV_sunKey", kScene);
    ALIVE_RemoveAgent("light_ENV_exterior", kScene);
    ALIVE_RemoveAgent("light_ENV_exterior_modBarnShadow01", kScene);
    ALIVE_RemoveAgent("light_ENV_exterior_modBarnShadow02", kScene);
    ALIVE_RemoveAgent("light_ENV_highlight01", kScene);
    ALIVE_RemoveAgent("light_ENV_highlight05", kScene);
    ALIVE_RemoveAgent("light_ENV_sunKey01", kScene);
    ALIVE_RemoveAgent("light_ENV_ambGrassIvy", kScene);
    ALIVE_RemoveAgent("light_ENV_S_doorsFlood01", kScene);
    ALIVE_RemoveAgent("light_ENV_highlight02", kScene);
    ALIVE_RemoveAgent("light_ENV_P_ceilingBounce01", kScene);
    ALIVE_RemoveAgent("light_ENV_P_ceilingBounce02", kScene);
    ALIVE_RemoveAgent("light_ENV_P_ceilingBounce03", kScene);
    ALIVE_RemoveAgent("light_ENV_spotFill", kScene);
    ALIVE_RemoveAgent("light_NODE_exteriorA", kScene);
    --ALIVE_RemoveAgent("light_SKY_amb", kScene);
    --ALIVE_RemoveAgent("light_SKY_horizonSpot", kScene);
    --ALIVE_RemoveAgent("light_SKY_sunPoint", kScene);
    --ALIVE_RemoveAgent("light_SKY_sunBroadLight", kScene);
    --ALIVE_RemoveAgent("light_SKY_sunPoint01", kScene);
    ALIVE_RemoveAgent("light_SKY_sunPoint_MedQuality01", kScene);
    ALIVE_RemoveAgent("light_SKY_sunPoint_medQuality02", kScene);
    ALIVE_RemoveAgent("light_SKY_sunPoint02", kScene);
    ALIVE_RemoveAgent("light_NODE_exteriorTile", kScene);
    ALIVE_RemoveAgent("module_environment_med", kScene);
    ALIVE_RemoveAgent("light_ENV_ambtreeFlats", kScene);
    ALIVE_RemoveAgent("light_ENV_highlight03", kScene);
    ALIVE_RemoveAgent("light_S_sunRising01", kScene);
    ALIVE_RemoveAgent("light_S_sunRising02", kScene);
    ALIVE_RemoveAgent("light_ENV_highlight04", kScene);
    ALIVE_RemoveAgent("light_S_sunRising03", kScene);
    ALIVE_RemoveAgent("light_ENV_barnInterior01", kScene);
    ALIVE_RemoveAgent("light_ENV_barnInterior02", kScene);
    ALIVE_RemoveAgent("light_NODE_interior", kScene);
    ALIVE_RemoveAgent("light_ENV_P_fillTrees01", kScene);
    ALIVE_RemoveAgent("light_ENV_P_fillTrees02", kScene);
    ALIVE_RemoveAgent("light_ENV_P_fillTrees03", kScene);
    ALIVE_RemoveAgent("light_ENV_P_fillTrees04", kScene);
    ALIVE_RemoveAgent("light_ENV_P_fillTrees05", kScene);
    ALIVE_RemoveAgent("light_ENV_P_backLight01", kScene);
    ALIVE_RemoveAgent("light_ENV_P_backLight02", kScene);
    ALIVE_RemoveAgent("light_ENV_P_backLight03", kScene);
    ALIVE_RemoveAgent("light_ENV_P_backLight05", kScene);
    ALIVE_RemoveAgent("light_ENV_P_backLight06", kScene);
    ALIVE_RemoveAgent("light_ENV_P_backLight07", kScene);
    ALIVE_RemoveAgent("light_ENV_P_clemKey01", kScene);
    ALIVE_RemoveAgent("light_ENV_P_bounce01", kScene);
    ALIVE_RemoveAgent("light_ENV_S_pitchforkRopeKey01", kScene);
    ALIVE_RemoveAgent("light_ENV_S_backlightKey01", kScene);
    ALIVE_RemoveAgent("light_ENV_S_barnKey01", kScene);
    ALIVE_RemoveAgent("light_ENV_P_bounce02", kScene);
    ALIVE_RemoveAgent("light_ENV_C_bounce03", kScene);
    ALIVE_RemoveAgent("light_ENV_P_clemKey02", kScene);
    ALIVE_RemoveAgent("light_ENV_P_backLight04", kScene);
    ALIVE_RemoveAgent("light_ENV_P_clemKey01NX", kScene);
    ALIVE_RemoveAgent("light_ENV_P_gunShotBlast01", kScene);
    ALIVE_RemoveAgent("module_post_effect", kScene);
    
    
    
    
    
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
    
    
    agent_aj = AgentFindInScene("AJ", kScene);
    --PlayLoopingAnimation(agent_aj, "sk63_idle_ajKneelL.anm");
    PlayLoopingAnimation(agent_aj, "sk63_idle_ajSitGround.anm");
    
    --local aj_sad_emotion = ALIVE_ChorePlayOnAgent("aJ_face_moodSadA.chore", agent_aj, nil, nil);
    --ControllerSetLooping(aj_sad_emotion, true);

    
    
    agent_clementine = AgentFindInScene("Clementine", kScene);
    PlayLoopingAnimation(agent_clementine, "sk62_idle_clementine400OnGroundWallHoldGun.anm");
    --PlayLoopingAnimation(agent_clementine, "sk62_idle_clementine400SitGroundB.anm");

    
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
    
     AgentSetState("AJ", "bodyJacketDisco");

end

--creates the enviorment that the cutscene will take place in
Scene_CreateEnviorment = function()
    --create a group object that the enviorment meshes/objects will be parented to (so we can scroll the enviorment later to make it look like characters are walking through the scene).
    local tile_group = AgentCreate("env_tile", "group.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    
    --instantiate our enviorment meshes/objects into the scene
    local tile1 = AgentCreate("env_tile1", "obj_riverShoreTrailTileLower_foliageBrushMeshesA.prop", Vector(0.000000,0.000000,24.000000), Vector(0,0,0), kScene, false, false);
    local tile2 = AgentCreate("env_tile2", "obj_riverShoreTrailTileLower_foliageBrushMeshesB.prop", Vector(0.119385,0.302429,0.314697), Vector(0,0,0), kScene, false, false);
    local tile3 = AgentCreate("env_tile3", "obj_riverShoreTrailTileLower_foliageBrushMeshesC.prop", Vector(12.000000,0.000000,-14.000000), Vector(0,0,0), kScene, false, false);
    local tile4 = AgentCreate("env_tile4", "obj_riverShoreTrailTileLower_foliageBrushMeshesD.prop", Vector(-0.357460,0.000000,48.000000), Vector(0,0,0), kScene, false, false);
    local tile5 = AgentCreate("env_tile5", "obj_riverShoreTrailTileLower_foliageBrushMeshesE.prop", Vector(-0.443689,0.000000,71.967827), Vector(0,0,0), kScene, false, false);
    local tile6 = AgentCreate("env_tile6", "obj_riverShoreTrailTileLower_foliageTreeMeshesA.prop", Vector(0.000000,0.000000,24.000000), Vector(0,0,0), kScene, false, false);
    local tile7 = AgentCreate("env_tile7", "obj_riverShoreTrailTileLower_foliageTreeMeshesB.prop", Vector(0.000000,0.000000,0.000000), Vector(0,0,0), kScene, false, false);
    local tile8 = AgentCreate("env_tile8", "obj_riverShoreTrailTileLower_foliageTreeMeshesC.prop", Vector(12.000000,0.000000,-14.000000), Vector(0,-90,0), kScene, false, false);
    local tile9 = AgentCreate("env_tile9", "obj_riverShoreTrailTileLower_foliageTreeMeshesD.prop", Vector(-0.357460,0.000000,48.000000), Vector(0,180,0), kScene, false, false);
    local tile10 = AgentCreate("env_tile10", "obj_riverShoreTrailTileLower_foliageTreeMeshesE.prop", Vector(-0.443689,0.000000,71.967827), Vector(0,0,0), kScene, false, false);
    local tile11 = AgentCreate("env_tile11", "obj_riverShoreTrailTileLowerA.prop", Vector(0.000000,0.000000,24.000000), Vector(0,0,0), kScene, false, false);
    local tile12 = AgentCreate("env_tile12", "obj_riverShoreTrailTileLowerB.prop", Vector(0.000000,0.000000,0.000000), Vector(0,0,0), kScene, false, false);
    local tile13 = AgentCreate("env_tile13", "obj_riverShoreTrailTileLowerC.prop", Vector(12.000000,0.000000,-14.000000), Vector(0,-90,0), kScene, false, false);
    local tile14 = AgentCreate("env_tile14", "obj_riverShoreTrailTileLowerD.prop", Vector(-0.357460,0.000000,48.000000), Vector(0,-180,0), kScene, false, false);
    local tile15 = AgentCreate("env_tile15", "obj_riverShoreTrailTileLowerE.prop", Vector(-0.443689,0.000000,71.967827), Vector(0,0,0), kScene, false, false);
    local tile16 = AgentCreate("env_tile16", "obj_riverShoreTrailTileLowerF.prop", Vector(0.000000,0.000000,71.967827), Vector(0,0,0), kScene, false, false);
    
    --attach it to the enviormnet group we created earlier
    AgentAttach(tile1, tile_group);
    AgentAttach(tile2, tile_group);
    AgentAttach(tile3, tile_group);
    AgentAttach(tile4, tile_group);
    AgentAttach(tile5, tile_group);
    AgentAttach(tile6, tile_group);
    AgentAttach(tile7, tile_group);
    AgentAttach(tile8, tile_group);
    AgentAttach(tile9, tile_group);
    AgentAttach(tile10, tile_group);
    AgentAttach(tile11, tile_group);
    AgentAttach(tile12, tile_group);
    AgentAttach(tile13, tile_group);
    AgentAttach(tile14, tile_group);
    AgentAttach(tile15, tile_group);
    AgentAttach(tile16, tile_group);
    
    --move the whole enviorment to a good starting point
    ALIVE_SetAgentWorldPosition("env_tile", Vector(1.35, 0, -34), kScene);
end

--adds additional grass meshes to make the enviorment/ground look more pleasing and not so flat/barren/low quality
Scene_AddProcedualGrass = function()
    --the amount of grass objects placed on the x and z axis (left and right, forward and back)
    local grassCountX = 40;
    local grassCountZ = 40;
    
    --the spacing between the grass objects
    local grassPlacementIncrement = 0.375;
    
    --the starting point for the grass placement
    local grassPositionStart = Vector(-(grassCountX / 2) * grassPlacementIncrement, 0.0, -(grassCountZ / 2) * grassPlacementIncrement);

    --the base name of a grass object
    local grassAgentName = "myObject_grass";

    --the prop (prefab) object file for the grass
    local grassPropFile = "obj_grassHIRiverCampWalk.prop"
    
    --and lets create a group object that we will attach all the spawned grass objects to, to make it easier to move the placement of the grass.
    local newGroup = AgentCreate("procedualGrassGroup", "group.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    
    --loop x amount of times for the x axis
    for x = 1, grassCountX, 1 do 
        --calculate our x position right now
        local newXPos = grassPositionStart.x + (x * grassPlacementIncrement);
        
        --loop z amount of times for the z axis
        for z = 1, grassCountZ, 1 do 
            --build the agent name for the current new grass object
            local xIndexString = tostring(x);
            local zIndexString = tostring(z);
            local newAgentName = grassAgentName .. "_x_" .. xIndexString .. "_z_" .. zIndexString;

            --claculate the z position
            local newZPos = grassPositionStart.z + (z * grassPlacementIncrement);
            
            --randomize the Y rotation
            local newYRot = math.random(0, 180);
            
            --randomize the scale
            local scaleOffset = math.random(0, 0.6);
            
            --combine our calculated position/rotation/scale values
            local newPosition = Vector(newXPos, grassPositionStart.y, newZPos);
            local newRotation = Vector(0, newYRot, 0);
            local newScale = 0.75 + scaleOffset;

            --instantiate the new grass object using our position/rotation
            local newGrassAgent = AgentCreate(newAgentName, grassPropFile, newPosition, newRotation, kScene, false, false);
            
            --scale the grass
            ALIVE_AgentSetProperty(newAgentName, "Render Global Scale", newScale, kScene);
                
            --attach it to the main grass group
            AgentAttach(newGrassAgent, newGroup);
        end
    end
end

--adds additional particle effects to the scene to help make it more lively
Scene_AddAdditionalParticleEffects = function()
    --note: normally for modifying properties on an agent you would have the actual property name.
    --however after extracting all the strings we could get from the game exectuable, and also all of the lua scripts in the entire game
    --not every single property name was listed, and attempting to print all of the (keys) in the properties object throws out symbols instead.
    --so painfully, PAINFULLY through trial and error I found the right symbol keys I was looking for, and we basically set the given property like normal using the symbol.
    --note for telltale dev: yes I tried many times to use your dang SymbolToString on those property keys but it doesn't actually do anything!!!!!

    --create a dust particle effect that spawns dust particles where the camera looks (this effect is borrowed from S4)
    local fxDust1 = AgentCreate("myFX_dust1", "fx_camDustMotes.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    local fxDust1_props = AgentGetRuntimeProperties(fxDust1); --get the properties of the particle system, since we want to modify it.
    ALIVE_SetPropertyBySymbol(fxDust1_props, "689599953923669477", true); --enable emitter
    ALIVE_SetPropertyBySymbol(fxDust1_props, "4180975590232535326", 0.015); --particle size
    ALIVE_SetPropertyBySymbol(fxDust1_props, "2137029241144994061", 2.5); --particle count
    ALIVE_SetPropertyBySymbol(fxDust1_props, "907461805036530086", 0.55); --particle speed
    ALIVE_SetPropertyBySymbol(fxDust1_props, "459837671211266514", 0.2); --rain random size
    ALIVE_SetPropertyBySymbol(fxDust1_props, "2293817456966484758", 2.0); --rain diffuse intensity
    
    --create a leaves particle effect that spawns leaves particles where the camera looks (this effect is borrowed from S4)
    local fxLeaves1 = AgentCreate("myFX_leaves1", "fx_camLeaves.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    local fxLeaves1_props = AgentGetRuntimeProperties(fxLeaves1); --get the properties of the particle system, since we want to modify it.
    ALIVE_SetPropertyBySymbol(fxLeaves1_props, "689599953923669477", true); --enable emitter
    ALIVE_SetPropertyBySymbol(fxLeaves1_props, "4180975590232535326", 0.121); --particle size
    ALIVE_SetPropertyBySymbol(fxLeaves1_props, "2137029241144994061", 27.0); --particle count
    ALIVE_SetPropertyBySymbol(fxLeaves1_props, "907461805036530086", 1.35); --particle speed
    ALIVE_SetPropertyBySymbol(fxLeaves1_props, "459837671211266514", 0.5); --rain random size
    ALIVE_SetPropertyBySymbol(fxLeaves1_props, "2293817456966484758", 1.0); --rain diffuse intensity
end

--relights the new enviorment so that it actually looks nice and is presentable
Scene_RelightScene = function()
    --remeber that we didn't delete every single light in the scene?
    --well now we need them because when creating new lights, by default their lighting groups (which basically mean what objects in the scene the lights will actually affect)
    --are not assigned (or at the very least, are not set to a value that affects the main lighting group of all objects in the scene)
    --and unfortunately the actual value is some kind of userdata object, so to get around that, we use an existing light as our crutch
    --and grab the actual group values/data from that object so that we can actually properly create our own lights that actually affect the scene
    
    --find the original sunlight in the scene
    local envlight  = AgentFindInScene("light_ENV_sunKey", kScene);
    local envlight_props = AgentGetRuntimeProperties(envlight);
    local envlight_groupEnabled = PropertyGet(envlight_props, "EnvLight - Enabled Group");
    local envlight_groups = PropertyGet(envlight_props, "EnvLight - Groups");
    
    --find the original sky light in the scene (note telltale dev, why do you use a light source for the skybox when you could've just had the sky be an (emmissive/unlit) shader?)
    local skyEnvlight  = AgentFindInScene("light_SKY_amb", kScene);
    local skyEnvlight_props = AgentGetRuntimeProperties(skyEnvlight);
    local skyEnvlight_groupEnabled = PropertyGet(skyEnvlight_props, "EnvLight - Enabled Group");
    local skyEnvlight_groups = PropertyGet(skyEnvlight_props, "EnvLight - Groups");
    
    local originalFogAgent  = AgentFindInScene("module_environment", kScene);
    local originalFogAgent_props = AgentGetRuntimeProperties(skyEnvlight);
    local originalFogAgent_groups = PropertyGet(skyEnvlight_props, "Env - Groups");
    
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
    sunColor = Desaturate_RGBColor(sunColor, -0.99);
    ambientColor = Desaturate_RGBColor(ambientColor, 0.25);
    ambientColor = Multiplier_RGBColor(ambientColor, 1.0);
    
    --set the alpha value of the fog color to be fully opaque
    local finalFogColor = Color(fogColor.r, fogColor.g, fogColor.b, 1.0);
    
    --change the properties of the fog
    local fogName = "module_environment"
    --local myFogAgent = AgentCreate(fogName, "module_environment.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    --ALIVE_AgentSetProperty(fogName, "Env - Fog Color", finalFogColor, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Fog Color", sunColor, kScene);
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
    --ALIVE_AgentSetProperty(fogName, "Env - Groups", originalFogAgent_groups, kScene);

    --create our sunlight and set the properties accordingly
    local myLight_Sun = AgentCreate("myLight_Sun", envlight_prop, Vector(0,0,0), Vector(36.666, 113.1561, 0), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Type", 2, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Intensity", 25, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Radius", 1, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Distance Falloff", 1, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Spot Angle Outer", 45, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Color", sunColor, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Shadow Type", 3, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Wrap", 0.05, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Shadow Quality", 3, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Mobility", 2, kScene);

    local myLight_SunAmb = AgentCreate("myLight_SunAmb", envlight_prop, Vector(0,0,0), Vector(36.666, 113.1561, 0), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Type", 4, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Intensity", 0.5, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Radius", 1, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Distance Falloff", 1, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Spot Angle Outer", 45, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Color", sunColor, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Shadow Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Wrap", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Shadow Quality", 0, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - HBAO Participation Type", 1, kScene);

    --sky light/color
    ALIVE_AgentSetProperty("light_SKY_amb", "EnvLight - Intensity", 4, kScene);
    ALIVE_AgentSetProperty("light_SKY_amb", "EnvLight - Color", skyColor, kScene);
    
    --create a spotlight that emulates the sundisk in the sky
    local myLight_SkySun = AgentCreate("myLight_SkySun", envlight_prop, Vector(0,0,0), Vector(36.666 - 180, 113.1561, 0), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Intensity", 25, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Radius", 2555, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Distance Falloff", 9, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Spot Angle Outer", 65, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Color", sunColor, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Enabled Group", skyEnvlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Groups", skyEnvlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Shadow Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Wrap", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Shadow Quality", 0, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - HBAO Participation Type", 1, kScene);
    
    local myLight_SkySun = AgentCreate("myLight_SkySun2", envlight_prop, Vector(0,0,0), Vector(36.666 - 180, 113.1561, 0), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Intensity", 85, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Radius", 2555, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Distance Falloff", 9, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Spot Angle Outer", 35, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Color", sunColor, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Enabled Group", skyEnvlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Groups", skyEnvlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Shadow Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Wrap", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Shadow Quality", 0, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - HBAO Participation Type", 1, kScene);

    
    
    --local myLight_ajKey1 = AgentCreate("myLight_ajKey1", envlight_prop, Vector(-1.092463, 0.844435, -2.0329), Vector(18.6634, 43.12, 0), kScene, false, false);
    local myLight_ajKey1 = AgentCreate("myLight_ajKey1", envlight_prop, Vector(-1.138213, 0.928073, -1.825126), Vector(25.333347, 59.573139, 0), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Intensity", 13, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Radius", 1, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Distance Falloff", 1, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Spot Angle Outer", 75, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Color", sunColor, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Shadow Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Wrap", 0.20, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Shadow Quality", 3, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Mobility", 2, kScene);
    
    local myLight_ajRim1 = AgentCreate("myLight_ajRim1", envlight_prop, Vector(-0.107102, 1.102458, -1.078987), Vector(32.833637, -128.698929, 0), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Intensity", 1065, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Radius", 1, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Distance Falloff", 1, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Spot Angle Outer", 45, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Color", skyColor, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Shadow Type", 2, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Wrap", 0.20, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Shadow Quality", 3, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Mobility", 2, kScene);
    
    local myLight_ajRim2 = AgentCreate("myLight_ajRim2", envlight_prop, Vector(-1.2481, 0.93511, -1.359819), Vector(27.567850, 111.789520, 0), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Intensity", 95, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Radius", 1, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Distance Falloff", 1, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Spot Angle Outer", 55, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Color", sunColor, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Shadow Type", 2, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Wrap", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Shadow Quality", 3, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Mobility", 2, kScene);
    
    local myLight_clemRim1 = AgentCreate("myLight_clemRim1", envlight_prop, Vector(-0.643954, 0.728249, -1.893435), Vector(22.723915, 171.342987, 0), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Intensity", 45, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Radius", 5, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Distance Falloff", 1, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Spot Angle Outer", 65, kScene);
    --ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Color", sunColor, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Color", skyColor, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Shadow Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Wrap", 0.04, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Shadow Quality", 3, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Mobility", 2, kScene);
    
    local myLight_bgFill1 = AgentCreate("myLight_bgFill1", envlight_prop, Vector(-0.167297, 0.01, 6.068893), Vector(0, 0, 0), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Intensity", 6, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Radius", 9, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Distance Falloff", 4, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Spot Angle Outer", 65, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Color", sunColor, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Shadow Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Wrap", 1.0, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Shadow Quality", 0, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Mobility", 2, kScene);

    local myLight_barnZombieFill1 = AgentCreate("myLight_barnZombieFill1", envlight_prop, Vector(0.488498, 0.062159, 6.509029), Vector(-24.665478, -47.250046, 0), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Intensity", 45, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Radius", 11, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Distance Falloff", 1, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Spot Angle Outer", 75, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Color", Color(1.0, 0.7, 0.5), kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Shadow Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Wrap", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Shadow Quality", 3, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Mobility", 2, kScene);
    
    --local myLight_forestFill1 = AgentCreate("myLight_forestFill1", envlight_prop, Vector(-69.735634, 4.780668, -1.981040), Vector(25.57, 168, 0), kScene, false, false);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Type", 1, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Intensity", 65, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Enlighten Intensity", 0.0, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Radius", 18, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Distance Falloff", 1, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Spot Angle Inner", 5, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Spot Angle Outer", 85, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Color", Color(1.0, 0.7, 0.5), kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Groups", envlight_groups, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Shadow Type", 0, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Wrap", 0.0, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Shadow Quality", 3, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - HBAO Participation Type", 1, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Mobility", 2, kScene);
    
    
    
    local beamColor = RGBColor(255, 167, 0, 255);
    beamColor = Multiplier_RGBColor(beamColor, 2.0);
    beamColor = Desaturate_RGBColor(beamColor, 0.55);

    local myFX_lightshaft1 = AgentCreate("myALIVE_lightbeam1", "fx_lightBeamFlashlight.prop", Vector(-30.818979, 17.7374, 17.254467), Vector(59.043056, 117.22493, 0), kScene, false, false)
    local myFX_lightshaft1_props = AgentGetRuntimeProperties(myFX_lightshaft1)
    ALIVE_SetPropertyBySymbol(myFX_lightshaft1_props, "2911356150214956261", beamColor) --flashlight flare
    ALIVE_SetPropertyBySymbol(myFX_lightshaft1_props, "13322114906091202280", beamColor) --flashlight beam
    ALIVE_AgentSetProperty("myALIVE_lightbeam1", "Render Global Scale", 2.5, kScene)
    ALIVE_AgentSetProperty("myALIVE_lightbeam1", "Render Cull", false, kScene)
    --ALIVE_AgentSetProperty("myALIVE_lightbeam1", "Render After Anti-Aliasing", true, sceneObj)
    --ALIVE_AgentSetProperty("myALIVE_lightbeam1", "Render Layer", 1, sceneObj)
    --ALIVE_AgentSetProperty("myALIVE_lightbeam1", "Render Depth Test", false, sceneObj)
    --ALIVE_AgentSetProperty("myALIVE_lightbeam1", "Render Depth Write", false, sceneObj)
    --ALIVE_AgentSetProperty("myALIVE_lightbeam1", "Render Depth Write Alpha", false, sceneObj)
    --ALIVE_AgentSetProperty("myALIVE_lightbeam1", "Render 3D Alpha", false, sceneObj)
    ALIVE_AgentSetProperty("myALIVE_lightbeam1", "Render Force As Alpha", false, kScene)
    
    beamColor = Multiplier_RGBColor(beamColor, 0.35);
    local myFX_lightshaft2 = AgentCreate("myFX_lightshaft2", "fx_lightBeamFlashlight.prop", Vector(-0.706046, 3.453351, 3.873892), Vector(38.166641, -128.906036, 0), kScene, false, false)
    local myFX_lightshaft2_props = AgentGetRuntimeProperties(myFX_lightshaft2)
    ALIVE_SetPropertyBySymbol(myFX_lightshaft2_props, "2911356150214956261", beamColor) --flashlight flare
    ALIVE_SetPropertyBySymbol(myFX_lightshaft2_props, "13322114906091202280", beamColor) --flashlight beam
    ALIVE_AgentSetProperty("myFX_lightshaft2", "Render Global Scale", 0.5, kScene)
    ALIVE_AgentSetProperty("myFX_lightshaft2", "Render Cull", false, kScene)
    --ALIVE_AgentSetProperty("myFX_lightshaft2", "Render After Anti-Aliasing", true, sceneObj)
    --ALIVE_AgentSetProperty("myFX_lightshaft2", "Render Layer", 1, sceneObj)
    --ALIVE_AgentSetProperty("myFX_lightshaft2", "Render Depth Test", false, sceneObj)
    --ALIVE_AgentSetProperty("myFX_lightshaft2", "Render Depth Write", false, sceneObj)
    --ALIVE_AgentSetProperty("myFX_lightshaft2", "Render Depth Write Alpha", false, sceneObj)
    --ALIVE_AgentSetProperty("myFX_lightshaft2", "Render 3D Alpha", false, sceneObj)
    ALIVE_AgentSetProperty("myFX_lightshaft2", "Render Force As Alpha", false, kScene)
    
    local beamColor3 = RGBColor(255, 167, 0, 255);
    beamColor3 = Multiplier_RGBColor(beamColor3, 2.0);
    beamColor3 = Desaturate_RGBColor(beamColor3, 0.45);
    
    beamColor = Multiplier_RGBColor(beamColor, 4.0);
    local myFX_lightshaft3 = AgentCreate("myFX_lightshaft3", "fx_lightBeamFlashlight.prop", Vector(-100.651581, 17.00189, -2.948716), Vector(38.166687, 104.907486, 0), kScene, false, false)
    local myFX_lightshaft3_props = AgentGetRuntimeProperties(myFX_lightshaft3)
    ALIVE_SetPropertyBySymbol(myFX_lightshaft3_props, "2911356150214956261", beamColor3) --flashlight flare
    ALIVE_SetPropertyBySymbol(myFX_lightshaft3_props, "13322114906091202280", beamColor3) --flashlight beam
    ALIVE_AgentSetProperty("myFX_lightshaft3", "Render Global Scale", 5.5, kScene)
    ALIVE_AgentSetProperty("myFX_lightshaft3", "Render Cull", false, kScene)
    --ALIVE_AgentSetProperty("myFX_lightshaft3", "Render After Anti-Aliasing", true, sceneObj)
    --ALIVE_AgentSetProperty("myFX_lightshaft3", "Render Layer", 1, sceneObj)
    --ALIVE_AgentSetProperty("myFX_lightshaft3", "Render Depth Test", false, sceneObj)
    --ALIVE_AgentSetProperty("myFX_lightshaft3", "Render Depth Write", false, sceneObj)
    --ALIVE_AgentSetProperty("myFX_lightshaft3", "Render Depth Write Alpha", false, sceneObj)
    --ALIVE_AgentSetProperty("myFX_lightshaft3", "Render 3D Alpha", false, sceneObj)
    ALIVE_AgentSetProperty("myFX_lightshaft3", "Render Force As Alpha", false, kScene)
    
    
    
    
    
    
    --remove original sun since we created our own and only needed it for getting the correct lighting groups.
    ALIVE_RemoveAgent("light_ENV_sunKey", kScene);
    --ALIVE_RemoveAgent("module_environment", kScene);
    
    
    
    
    
    
    
    
    
    
    
    
    

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
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Intensity", 2.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Radius", 0.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Max Radius Percent", 0.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Max Distance", 35.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Distance Falloff", 0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Hemisphere Bias", -0.2, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Bloom Threshold", -0.45, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Bloom Intensity", 0.45, kScene);
    --ALIVE_AgentSetProperty(agent_name_scene, "Ambient Color", RGBColor(0, 0, 0, 0), kScene);
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
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Max Distance", 20.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Dynamic Shadow Max Distance", 25.0, kScene);
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
    local controller_sound_soundtrack = SoundPlay("custom_soundtrack1.wav");
    
    --set it to loop
    ControllerSetLooping(controller_sound_soundtrack, true)
end

--sets up our cutscene objects
Cutscene_SetupCutsceneContent = function()
    --find the character objects in the scene, we are going to need them during the cutscene so we need to get them (you could also get them during update but that wouldn't be performance friendly)
    agent_clementine = AgentFindInScene("Clementine", kScene);
    agent_christa = AgentFindInScene("Christa", kScene);
    agent_omid = AgentFindInScene("Omid", kScene);

    ----------------------------------------------------------------
    --set up animations
    --note: there is a lot of commented out lines here, I'm purposefully keeping them in to show that you have to find the right animation to your liking.
    --but also there are tons of other animations and stuff that you can play
    
    --play a walk animation on our characters
    controller_animation_clementineWalk = PlayAnimation(agent_clementine, "sk56_clementine_walk.anm");
    --controller_animation_clementineWalk = PlayAnimation(agent_clementine, "sk54_wd200GM_walkHoldGun.anm");
    --controller_animation_clementineWalk = PlayAnimation(agent_clementine, "sk56_action_clementineGuiltRidden.anm");
    controller_animation_christaWalk = PlayAnimation(agent_christa, "sk56_clementine200_walk.anm");
    controller_animation_omidWalk = PlayAnimation(agent_omid, "sk54_lee_walk.anm");
    
    --play some eye dart animations on clem (so her eyeballs are not completely static)
    --controller_animation_clementineEyesDarting = PlayAnimation(agent_clementine, "clementine_face_eyesDartsA_add.anm");
    controller_animation_clementineEyesDarting = PlayAnimation(agent_clementine, "clementine_face_eyesDartsB_add.anm");
    --controller_animation_clementineEyesDarting = PlayAnimation(agent_clementine, "clementine_face_eyesDartsC_add.anm");

    --controller_animation_clementineEyesLookUp = PlayAnimation(agent_clementine, "clementine_face_blink_add.anm");
    --controller_animation_clementineHeadLookUp = PlayAnimation(agent_clementine, "clementine_headGesture_lookUp_add.anm");
    --controller_animation_clementineHeadLookDown = PlayAnimation(agent_clementine, "clementine_headGesture_lookDown_add.anm");

    --set clems facial expression (for these chores they are nice in that they only need to be called once and they basically (stick))
    controller_chore_clementineEmotion = ChorePlayOnAgent(agent_clementine, "sk56_clementine_toSadA.chore");
    --controller_chore_clementineEmotion = ChorePlayOnAgent(agent_clementine, "sk56_clementine_toSadB.chore");
    --controller_chore_clementineEmotion = ChorePlayOnAgent(agent_clementine, "sk56_clementine_toSadC.chore");
    --controller_chore_clementineEmotion = ChorePlayOnAgent(agent_clementine, "sk56_clementine_toSadD.chore");
    --controller_chore_clementineEmotion = ChorePlayOnAgent(agent_clementine, "sk56_clementine_toCryingA.chore");
    --controller_chore_clementineEmotion = ChorePlayOnAgent(agent_clementine, "sk56_clementine_toFearA.chore");
    --controller_chore_clementineEmotion = ChorePlayOnAgent(agent_clementine, "sk56_clementine_toFearB.chore");
    --controller_chore_clementineEmotion = ChorePlayOnAgent(agent_clementine, "sk56_clementine_toHappyA.chore");
    --controller_chore_clementineEmotion = ChorePlayOnAgent(agent_clementine, "sk56_clementine_toHappyB.chore");
    --controller_chore_clementineEmotion = ChorePlayOnAgent(agent_clementine, "sk56_clementine_toNormalA.chore");
    --controller_chore_clementineEmotion = ChorePlayOnAgent(agent_clementine, "sk56_clementine_toNormalB.chore");
    --controller_chore_clementineEmotion = ChorePlayOnAgent(agent_clementine, "sk56_clementine_toThinkingA.chore");

    --set some of our animations to loop
    ControllerSetLooping(controller_animation_clementineWalk, true);
    ControllerSetLooping(controller_animation_christaWalk, true);
    ControllerSetLooping(controller_animation_omidWalk, true);
    --ControllerSetLooping(controller_animation_clementineBlink, false);
    ControllerSetLooping(controller_animation_clementineEyesDarting, true);

    --set inital character positions
    --note: important to say that once we play the walking animations the engine likes to move them to world origin since most animations end up actually moving the root object.
    --so we need to play the animations first and then move the characters to where we need them.
    --they will move from their spots but we will fix this later when we lock their position in place.
    ALIVE_SetAgentWorldPosition("Clementine", Vector(0, 0, 0), kScene);
    ALIVE_SetAgentWorldPosition("Christa", Vector(-0.75, 0, 3), kScene);
    ALIVE_SetAgentWorldPosition("Omid", Vector(0.75, 0, 3), kScene);

end

--|||||||||||||||||||||||||||||||||||||||||||||| CUTSCENE UPDATE ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CUTSCENE UPDATE ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CUTSCENE UPDATE ||||||||||||||||||||||||||||||||||||||||||||||

--proceudal handheld animation
--worth noting that while it does work, its definetly not perfect and jumps around more than I'd like.
--if the values are kept low then it works fine
Cutscene_UpdateHandheldCameraValues = function()
    --update the tick rate by 1
    camera_handheld_tick = camera_handheld_tick + 1;
    
    --if we reached the max update tick rate, time to calculate a new shake position/rotation (this only gets called once during update until we hit the max update level again)
    if (camera_handheld_tick > camera_handheld_updateLevel) then
        --calculate a random rotation for the shake
        local newRotShakeX = math.random(-camera_handheld_rot_strength, camera_handheld_rot_strength);
        local newRotShakeY = math.random(-camera_handheld_rot_strength, camera_handheld_rot_strength);
        local newRotShakeZ = math.random(-camera_handheld_rot_strength, camera_handheld_rot_strength);
        --local newRotShakeZ = 0;
        
        --calculate a random position for the shake
        local newPosShakeX = math.random(-camera_handheld_pos_strength, camera_handheld_pos_strength);
        local newPosShakeY = math.random(-camera_handheld_pos_strength, camera_handheld_pos_strength);
        local newPosShakeZ = math.random(-camera_handheld_pos_strength, camera_handheld_pos_strength);
    
        --combine the corresponding values into vectors and assign them to the desired rot/pos
        camera_handheld_desiredRot = Vector(newRotShakeX, newRotShakeY, newRotShakeZ);
        camera_handheld_desiredPos = Vector(newPosShakeX, newPosShakeY, newPosShakeZ);
        
        --reset the tick counter
        camera_handheld_tick = 0;
    end
    
    --meanwhile, if we haven't reached our max update tick rate
    --lets use this to our advantage and start gradually matching the current position/rotation of the shake to the desired over time.
    
    --linear interpolation
    --camera_handheld_currentRot = ALIVE_VectorLerp(camera_handheld_currentRot, camera_handheld_desiredRot, GetFrameTime() * camera_handheld_rot_lerpFactor);
    --camera_handheld_currentPos = ALIVE_VectorLerp(camera_handheld_currentPos, camera_handheld_desiredPos, GetFrameTime() * camera_handheld_pos_lerpFactor);
    
    --smoothstep interpolation
    camera_handheld_currentRot = ALIVE_VectorSmoothstep(camera_handheld_currentRot, camera_handheld_desiredRot, GetFrameTime() * camera_handheld_rot_lerpFactor);
    camera_handheld_currentPos = ALIVE_VectorSmoothstep(camera_handheld_currentPos, camera_handheld_desiredPos, GetFrameTime() * camera_handheld_pos_lerpFactor);
end

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
        angleInfo_rot = angleInfo_rot + camera_handheld_currentRot;
        angleInfo_pos = angleInfo_pos + camera_handheld_currentPos;
        
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

    ALIVE_AgentSetProperty("ZombieCombat01", "Runtime: Visible", false, kScene)
    ALIVE_AgentSetProperty("ZombieCombat02", "Runtime: Visible", false, kScene)
    ALIVE_AgentSetProperty("ZombieCombat03", "Runtime: Visible", false, kScene)
    ALIVE_AgentSetProperty("ZombieCombat04", "Runtime: Visible", false, kScene)
    ALIVE_AgentSetProperty("ZombieCombat05", "Runtime: Visible", false, kScene)
    --ALIVE_AgentSetProperty("Zombie01", "Runtime: Visible", true, kScene)
    
    if (sequence_currentShotIndex == 1) then --black
        
        ALIVE_AgentSetProperty("group_tile1", "Group - Visible", true, kScene);
        ALIVE_SetAgentWorldRotation("myLight_Sun", Vector(36.666, 113.1561, 0), kScene);
        ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Intensity", 25, kScene);
        ALIVE_AgentSetProperty(agent_name_scene, "Ambient Color", ambientColor, kScene);
        ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Shadow Type", 2, kScene);
        ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Wrap", 0.25, kScene);
        ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Intensity", 0.0, kScene);
        ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Max Distance", 20.0, kScene);
        ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Dynamic Shadow Max Distance", 25.0, kScene);
        
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Start Distance", 0.25, kScene);
    ALIVE_AgentSetProperty("module_environment", "Env - Fog Height", 3.45, kScene);
    ALIVE_AgentSetProperty("module_environment", "Env - Fog Density", 0.00025, kScene);
    ALIVE_AgentSetProperty("module_environment", "Env - Fog Max Opacity", 0.35, kScene);
        
    elseif (sequence_currentShotIndex == 2) then --forest wide
        ambientColor = Desaturate_RGBColor(ambientColor, 0.45);
    
        ALIVE_AgentSetProperty("group_tile1", "Group - Visible", true, kScene);
        ALIVE_SetAgentWorldRotation("myLight_Sun", Vector(36.666, 113.1561, 0), kScene);
        ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Intensity", 45, kScene);
        ALIVE_AgentSetProperty(agent_name_scene, "Ambient Color", Multiplier_RGBColor(ambientColor, 1.35), kScene);
        ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Shadow Type", 2, kScene);
        ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Wrap", 0.35, kScene);
        ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Intensity", 0.45, kScene);
        ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Max Distance", 17.0, kScene);
        ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Dynamic Shadow Max Distance", 17.0, kScene);
        
            ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Intensity", 1.0, kScene);
            ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap White Point", 16.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Black Point", 0.012, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Toe Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Shoulder Intensity", 0.75, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Type", 2, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Pivot", 0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Shoulder Intensity", 0.7, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Intensity", 3.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Radius", 0.8, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Max Radius Percent", 0.76, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Max Distance", 35.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Distance Falloff", 0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Hemisphere Bias", -0.2, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Bloom Threshold", -0.65, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Bloom Intensity", 0.35, kScene);
    
    ALIVE_AgentSetProperty("module_environment", "Env - Fog Start Distance", 0.25, kScene);
    ALIVE_AgentSetProperty("module_environment", "Env - Fog Height", 3.45, kScene);
    ALIVE_AgentSetProperty("module_environment", "Env - Fog Falloff", 3.5, kScene);
    ALIVE_AgentSetProperty("module_environment", "Env - Fog Density", 0.00025, kScene);
    ALIVE_AgentSetProperty("module_environment", "Env - Fog Max Opacity", 0.65, kScene);
        
    elseif (sequence_currentShotIndex == 3) then --zombie shadows
        
        ALIVE_AgentSetProperty("group_tile1", "Group - Visible", true, kScene);
        ALIVE_SetAgentWorldRotation("myLight_Sun", Vector(9.666, 90, 0), kScene);
        ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Intensity", 15, kScene);
        ALIVE_AgentSetProperty(agent_name_scene, "Ambient Color", Multiplier_RGBColor(ambientColor, 0.25), kScene);
        ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Shadow Type", 2, kScene);
        ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Wrap", 0.0, kScene);
        ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Intensity", 0.25, kScene);
        ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Max Distance", 30.0, kScene);
        ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Dynamic Shadow Max Distance", 35.0, kScene);
        
        ALIVE_SetAgentWorldPosition("procedualGrassGroup", Vector(-144.57, -3.340749, -2.59), kScene);
        
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Start Distance", 0.25, kScene);
    ALIVE_AgentSetProperty("module_environment", "Env - Fog Height", 3.45, kScene);
    ALIVE_AgentSetProperty("module_environment", "Env - Fog Density", 0.00025, kScene);
    ALIVE_AgentSetProperty("module_environment", "Env - Fog Max Opacity", 0.35, kScene);
    ALIVE_AgentSetProperty("module_environment", "Env - Fog Falloff", 3.0, kScene);
        
            ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap White Point", 10.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Black Point", 0.005, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Toe Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Shoulder Intensity", 0.75, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Type", 2, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Pivot", 0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Shoulder Intensity", 0.8, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Intensity", 2.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Radius", 0.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Max Radius Percent", 0.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Max Distance", 35.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Distance Falloff", 0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Hemisphere Bias", -0.2, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Bloom Threshold", -0.45, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Bloom Intensity", 0.45, kScene);
        
   elseif (sequence_currentShotIndex == 4) then --barn wide 1
        
        ALIVE_AgentSetProperty("group_tile1", "Group - Visible", false, kScene);
        ALIVE_SetAgentWorldRotation("myLight_Sun", Vector(36.666, 113.1561, 0), kScene);
        ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Intensity", 25, kScene);
        ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Shadow Type", 3, kScene);
        ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Wrap", 0.05, kScene);
        ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Intensity", 0.5, kScene);
        ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Max Distance", 20.0, kScene);
        ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Dynamic Shadow Max Distance", 25.0, kScene);
        
        ALIVE_SetAgentWorldPosition("procedualGrassGroup", Vector(-13.57, -0.013749, 12.59), kScene);
        
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Start Distance", 0.25, kScene);
    ALIVE_AgentSetProperty("module_environment", "Env - Fog Height", 3.45, kScene);
    ALIVE_AgentSetProperty("module_environment", "Env - Fog Density", 0.00025, kScene);
    ALIVE_AgentSetProperty("module_environment", "Env - Fog Max Opacity", 0.45, kScene);
    ALIVE_AgentSetProperty("module_environment", "Env - Fog Falloff", 1.0, kScene);
        
            ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap White Point", 10.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Black Point", 0.005, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Toe Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Shoulder Intensity", 0.75, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Type", 2, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Pivot", 0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Shoulder Intensity", 0.8, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Intensity", 2.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Radius", 0.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Max Radius Percent", 0.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Max Distance", 35.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Distance Falloff", 0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Hemisphere Bias", -0.2, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Bloom Threshold", -0.45, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Bloom Intensity", 0.25, kScene);
        
    elseif (sequence_currentShotIndex == 5) then --barn wide 2
        
        ALIVE_AgentSetProperty("group_tile1", "Group - Visible", false, kScene);
        ALIVE_SetAgentWorldRotation("myLight_Sun", Vector(36.666, 113.1561, 0), kScene);
        ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Intensity", 25, kScene);
        ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Shadow Type", 3, kScene);
        ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Wrap", 0.05, kScene);
        ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Intensity", 0.5, kScene);
        ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Max Distance", 20.0, kScene);
        ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Dynamic Shadow Max Distance", 25.0, kScene);
        
        ALIVE_SetAgentWorldPosition("procedualGrassGroup", Vector(-0.57, -0.340749, 12.59), kScene);
        ALIVE_SetAgentWorldRotation("procedualGrassGroup", Vector(0, 0, -2), kScene);
        
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Start Distance", 0.25, kScene);
    ALIVE_AgentSetProperty("module_environment", "Env - Fog Height", 3.45, kScene);
    ALIVE_AgentSetProperty("module_environment", "Env - Fog Density", 0.00025, kScene);
    ALIVE_AgentSetProperty("module_environment", "Env - Fog Max Opacity", 0.45, kScene);
    ALIVE_AgentSetProperty("module_environment", "Env - Fog Falloff", 1.0, kScene);
    
            ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Intensity", 1.0, kScene);
            ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap White Point", 14.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Black Point", 0.005, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Toe Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Shoulder Intensity", 0.75, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Type", 2, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Pivot", 0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Shoulder Intensity", 0.8, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Intensity", 2.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Radius", 0.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Max Radius Percent", 0.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Max Distance", 35.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Distance Falloff", 0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Hemisphere Bias", -0.2, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Bloom Threshold", -0.45, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Bloom Intensity", 0.45, kScene);
        
    elseif (sequence_currentShotIndex == 6) then --black
    
    elseif (sequence_currentShotIndex == 7) then --aj reverse
    
        ALIVE_AgentSetProperty("group_tile1", "Group - Visible", false, kScene);
        ALIVE_SetAgentWorldRotation("myLight_Sun", Vector(41.33, 166.406, 0), kScene);
        ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Intensity", 45, kScene);
        ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Shadow Type", 2, kScene);
        ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Wrap", 0.0, kScene);
        ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Intensity", 0.0, kScene);
        ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Max Distance", 10.0, kScene);
        ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Dynamic Shadow Max Distance", 10.0, kScene);
        
        ALIVE_SetAgentWorldPosition("procedualGrassGroup", Vector(0, -3, 0), kScene);
        
        ALIVE_AgentSetProperty("module_environment", "Env - Fog Start Distance", 0.25, kScene);
    ALIVE_AgentSetProperty("module_environment", "Env - Fog Height", 3.45, kScene);
    ALIVE_AgentSetProperty("module_environment", "Env - Fog Density", 0.00025, kScene);
    ALIVE_AgentSetProperty("module_environment", "Env - Fog Max Opacity", 0.35, kScene);
        
            ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap White Point", 10.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Black Point", 0.009, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Toe Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Shoulder Intensity", 0.75, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Type", 2, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Pivot", 0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Shoulder Intensity", 0.8, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Intensity", 2.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Radius", 0.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Max Radius Percent", 0.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Max Distance", 35.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Distance Falloff", 0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Hemisphere Bias", -0.2, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Bloom Threshold", -0.45, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Bloom Intensity", 0.45, kScene);
    
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
    --local lockedPos = VectorScale(localDirection, AgentGetForwardAnimVelocity(zombieAgent));
    --local lockedPos = VectorScale(Vector(1,0,0), AgentGetForwardAnimVelocity(zombieAgent));
    local worldPos = AgentGetWorldPos(zombieAgent);
    --local startPos = Vector(-160, 0, 0);
    --local startPos = Vector(0, 0, 0);

    --zombie01Move = zombie01Move + 0.001;
    --zombie01Move = zombie01Move + AgentGetForwardAnimVelocity(agent_zombie01);
    
    --local zombie01_finalPos = startPos;

    --local zombieMoveVector = Vector(0, 0, AgentGetForwardAnimVelocity(agent_zombie01));
    --zombieMoveVector = VectorScale(zombieMoveVector, AgentGetForwardAnimVelocity(agent_zombie01));
    --local moveDirection = Vector(0, 0, 1);
    --worldPos = worldPos + moveDirection;
    --local finalPos = VectorAdd(worldPos, moveDirection);
    --testVec = testVec + lockedPos * 0.0065;
    --mover = mover + lockedPos * 0.0065;
    --mover = VectorAdd(mover, Vector(0.1065,0,0));
    mover.x = mover.x + 0.0065;
    
    local finalPos = VectorAdd(offsetVec, mover);
    
    ALIVE_SetAgentPosition(zombieAgentName, finalPos, kScene);
    --ALIVE_SetAgentPosition("Zombie01", AgentGetForwardAnimVelocity(agent_zombie01), kScene);
    
    
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

local RandomFloatValue = function(min, max, decimals)
    local value = math.random(min * decimals, max * decimals);
    local valueAdjusted = value / decimals;

    return valueAdjusted;
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
    

    --local zombie01_LockedPos = VectorScale(Vector(0,0,1), AgentGetForwardAnimVelocity(agent_zombie01));
    
    --local startPos = Vector(-160, 0, 0);
    --local startPos = Vector(0, 0, 0);

    --zombie01Move = zombie01Move + 0.001;
    --zombie01Move = zombie01Move + AgentGetForwardAnimVelocity(agent_zombie01);
    
    --local zombie01_finalPos = startPos;

    --local zombieMoveVector = Vector(0, 0, AgentGetForwardAnimVelocity(agent_zombie01));
    --zombieMoveVector = VectorScale(zombieMoveVector, AgentGetForwardAnimVelocity(agent_zombie01));
    --local zombieDirection = AgentLocalToWorld(agent_zombie01, AgentGetForwardAnimVelocity(agent_zombie01));
    --zombie01_finalPos = VectorAdd(zombie01_finalPos, zombieMoveSpeed);

    --ALIVE_SetAgentPosition("Zombie01", zombie01_LockedPos, kScene);
    --ALIVE_SetAgentPosition("Zombie01", AgentGetForwardAnimVelocity(agent_zombie01), kScene);
    
    

    
    if (sequence_currentShotIndex == 3) then
        if (sequence_currentTimer == 0) then
            ZeroZombieMoveValues();

            randomX_max = 2;
            randomX_min = -4;
            randomZ_max = 4;
            randomZ_min = -4;
            decimalValue = 100;
            
            zombiesStartPos = Vector(-157, 0, 0);
            
            
            zombie01_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie02_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie03_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie04_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie05_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie06_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie07_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie08_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie09_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie10_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie11_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie12_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie13_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie14_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie15_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie16_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie17_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie18_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie19_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie20_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie21_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie22_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie23_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie24_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie25_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
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
            
            zombie01_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie02_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie03_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie04_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie05_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie06_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie07_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie08_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie09_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie10_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie11_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie12_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie13_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie14_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie15_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie16_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie17_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie18_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie19_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie20_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie21_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie22_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie23_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie24_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie25_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
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
            
            zombie01_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie02_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie03_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie04_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie05_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie06_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie07_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie08_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie09_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie10_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie11_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie12_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie13_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie14_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie15_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie16_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie17_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie18_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie19_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie20_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie21_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie22_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie23_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie24_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie25_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
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
            
            zombie01_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie02_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie03_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie04_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie05_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie06_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie07_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie08_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie09_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie10_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie11_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie12_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie13_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie14_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie15_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie16_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie17_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie18_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie19_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie20_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie21_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie22_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie23_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie24_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
            zombie25_offset = Vector(RandomFloatValue(randomX_min, randomX_max, decimalValue) + zombiesStartPos.x, 0 + zombiesStartPos.y, RandomFloatValue(randomZ_min, randomZ_max, decimalValue) + zombiesStartPos.z);
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

       if (sequence_currentTimer == 1) then
           --local cnt = ALIVE_ChorePlayOnAgent("aJ_face_moodSadA.chore", agent_aj, nil, nil);
           --ControllerSetLooping(cnt, false);
        end
        
       if (sequence_currentTimer == 25) then
            --ALIVE_ChorePlayOnAgent("aj_headGesture_lookDownLeft", agent_aj, nil, nil);
            ControllerFadeOut(lookDownCnt, 2.5);
            
            --PlayAnimation(agent_aj, "batmanGM_headEyeGesture_browsUp_add.anm");
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
            --ControllerFadeOut(aj_emotion1, 1.0);
            --aj_emotion2 = ALIVE_ChorePlayOnAgent("wd400GM_face_moodSadA.chore", agent_aj, nil, nil);
            --aj_emotion2 = ALIVE_ChorePlayOnAgent("aJ_face_moodPoutA.chore", agent_aj, nil, nil);
            
            --local cnt1 = PlayAnimation(agent_aj, "batmanGM_headEyeGesture_browsUp_add.anm");
            local cnt1 = PlayAnimation(agent_aj, "batmanGM_headEyeGesture_browsUp_add.anm");

            ControllerSetContribution(cnt1, 2);
            ControllerSetPriority(cnt1, 100);
            --ControllerSetPriority(aj_emotion2, 100);
        end
         
        if (sequence_currentTimer == 110) then
            --aj_emotion2 = ALIVE_ChorePlayOnAgent("wd400GM_face_moodSadA.chore", agent_aj, nil, nil);
            --ControllerSetLooping(aj_emotion2, true);
            
            --ControllerFadeOut(aj_emotion1, 1.0);
            --ControllerFadeIn(aj_emotion2, 1.0);
        end
         

         
         if (sequence_currentTimer == 205) then
             --ALIVE_ChorePlayOnAgent("aJ_face_blink", agent_aj, nil, nil);
        end
         
         if (sequence_currentTimer == 205) then
            PlayAnimation(agent_aj, "aj_eyes_eyeRLookAtDownToUp_add.anm");
            PlayAnimation(agent_aj, "aj_eyes_eyeLLookAtDownToUp_add.anm");
        end
        
        if (sequence_currentTimer == 235) then
             --ALIVE_ChorePlayOnAgent("aJ_face_blink", agent_aj, nil, nil);
             --PlayAnimation(agent_aj, "batmanGM_headEyeGesture_browsDown_add.anm");
             
             local cnt1 = PlayAnimation(agent_aj, "batmanGM_headEyeGesture_browsDownLong_add.anm");
            ControllerSetContribution(cnt1, 2);
            ControllerSetPriority(cnt1, 100);
            --ControllerDrift(cnt1, true);
            --ControllerDrift(cnt1, 1.0);
        end
        
        if (sequence_currentTimer == 305) then
             --ALIVE_ChorePlayOnAgent("aJ_face_blink", agent_aj, nil, nil);
             --PlayAnimation(agent_aj, "batmanGM_headEyeGesture_browsDown_add.anm");
             
             local cnt1 = PlayAnimation(agent_aj, "batmanGM_headEyeGesture_browsDownLong_add.anm");
            ControllerSetContribution(cnt1, 2);
            ControllerSetPriority(cnt1, 100);
            --ControllerDrift(cnt1, true);
            --ControllerDrift(cnt1, 1.0);
        end
         
        if (sequence_currentTimer == 315) then
            ALIVE_ChorePlayOnAgent("aj_headGesture_lookDownLeft", agent_aj, nil, nil);
             --PlayAnimation(agent_aj, "batmanGM_headEyeGesture_browsDown_add.anm");
        end
         
        
        

         if (sequence_currentTimer == 55) then
            --PlayAnimation(agent_aj, "batmanGM_headEyeGesture_browsUpMiddleSlow_add.anm");
            --PlayAnimation(agent_aj, "batmanGM_headEyeGesture_browsUp_add.anm");
            --PlayAnimation(agent_aj, "batmanGM_headEyeGesture_browsUp_add.anm");
            --PlayAnimation(agent_aj, "aj_eyes_eyeRLookAtDownToUp_add.anm");
        end
        

        if (sequence_currentTimer == 120) then
            --PlayAnimation(agent_aj, "batmanGM_headEyeGesture_browsUpMiddleSlow_add.anm");
            --ALIVE_ChorePlayOnAgent("batmanGM_headEyeGesture_browsUpMiddleSlow_add.anm", agent_aj, nil, nil);
        end
        

        --if (sequence_currentTimer == 230) then
        --    ALIVE_ChorePlayOnAgent("sk56_clementine_toHappyA", agent_aj, nil, nil);
        --end
        
    end
end

local voiceLineTick = 0;
local maxVoiceLineTick = 19200;

local PlayAJVoiceLine = function(lineID, intensity)
    agent_aj = AgentFindInScene("AJ", kScene);

    local controller_voiceLineAnm = PlayAnimation(agent_aj, lineID);
    local controller_voiceLineSound = SoundPlay(lineID .. ".wav");
    
    ControllerSetContribution(controller_voiceLineAnm, intensity);
    ControllerSetLooping(controller_voiceLineAnm, false);
    ControllerSetLooping(controller_voiceLineSound, false);
end

local AJVoiceLines = function()
    voiceLineTick = voiceLineTick + 1;

    if(voiceLineTick == 300) then
        PlayAJVoiceLine("396767243", 1.0); --I always listened to Clem, always. But I've been thinking more...
    end
    
    if(voiceLineTick == 850) then
        PlayAJVoiceLine("396767275", 1.0); --She told me way back, to shoot her if she got bit...
    end
    
    if(voiceLineTick == 1150) then
        PlayAJVoiceLine("396730926", 1.0); --I thought a lot about it, and I felt a lotta ways about it...
    end
    
    if(voiceLineTick == 1400) then
        --PlayAJVoiceLine("396763530", 1.0);
    end
    
    if(voiceLineTick == 1600) then
        PlayAJVoiceLine("396706038", 1.0); --sigh
    end
    
    if(voiceLineTick == 1700) then
        --PlayAJVoiceLine("396542265", 2.0); --clem 1
        PlayAJVoiceLine("396542111", 1.0); --clem 2
        --PlayAJVoiceLine("396509204", 2.0); --clem 3
    end
    
    if(voiceLineTick == 1900) then
        PlayAJVoiceLine("396722851", 1.0); --I can't let you turn into a monster.
    end
    
    if(voiceLineTick == 2400) then
        voiceLineTick = 0;
    end
end

--main level script, this function gets called when the scene loads
--its important we call everything here and set up everything so our work doesn't go to waste
ALIVE_Level_AliveInsideTeaser = function()
    ----------------------------------------------------------------
    --scene setup (call all of our scene setup functions)
    SetProjectSettings();
    Scene_CleanUpOriginalScene();
    --Scene_CreateEnviorment();
    Scene_AddProcedualGrass();
    Scene_AddAdditionalParticleEffects();
    Scene_RelightScene();

    --cutscene setup (start calling our cutscene setup functions)
    Cutscene_CreateSoundtrack(); --start playing our custom soundtrack and have it loop

    --if we are not in freecam mode, go ahead and create the cutscene camera
    if (MODE_FREECAM == false) then
        Cutscene_CreateCutsceneCamera(); --create our cutscene camera in the scene
    end

    --Cutscene_SetupCutsceneContent();
    HideCusorInGame(); --hide the cursor during the cutscene
    
    --ALIVE_PrintValidAgentStateNames(agent_aj);
    
    ----------------------------------------------------------------
    --cutscene update functions (these run every single frame, and this is where the magic happens)
    
    --add all of our update functions, and these will run for every single frame that is rendered
    Callback_OnPostUpdate:Add(Cutscene_UpdateSequence);
    Callback_OnPostUpdate:Add(Cutscene_UpdateHandheldCameraValues);
    --Callback_OnPostUpdate:Add(Cutscene_UpdateScrollEnviorment);
    --Callback_OnPostUpdate:Add(Cutscene_UpdateLockCharacterPositions);
    --Callback_OnPostUpdate:Add(Cutscene_UpdateClementineBlinks);
    Callback_OnPostUpdate:Add(Cutscene_UpdateCharacterActing);
    Callback_OnPostUpdate:Add(AJBlinks);
    --Callback_OnPostUpdate:Add(Cutscene_OnCutsceneFinish);
    
    Callback_OnPostUpdate:Add(AJVoiceLines);
    Callback_OnPostUpdate:Add(Cutscene_UpdateMoveShitAround);
    
    --add depth of field
    Callback_OnPostUpdate:Add(PerformAutofocusDOF);
    
    ----------------------------------------------------------------
    --if freecam mode is not enabled, then don't continue on
    if (MODE_FREECAM == false) then
        do return end --the function will not continue past this point if freecam is disabled (we don't want our development tools interferring with the cutscene)
    end

    ----------------------------------------------------------------
    --CUTSCENE DEVELOPMENT
    --if freecam is enabled, these functions are run
    
    --commented out on purpose, but when the scene starts this prints all of the scene agents to a text file that is saved in the game directory.
    --ALIVE_PrintSceneListToTXT(kScene, "adv_forestBarn404.txt");

    --remove the DOF because it interferes with UI
    Callback_OnPostUpdate:Remove(PerformAutofocusDOF);
       
    --create our free camera and our cutscene dev tools
    ALIVE_Development_CreateFreeCamera();
    ALIVE_Development_InitalizeCutsceneTools();

    --add these development update functions, and have them run every frame
    Callback_OnPostUpdate:Add(ALIVE_Development_UpdateFreeCamera);
    Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Input);
    Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Main);
end

--open the scene with this script
SceneOpen(kScene, kScript)
