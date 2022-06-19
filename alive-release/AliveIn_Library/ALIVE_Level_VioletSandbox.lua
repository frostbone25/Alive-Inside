ResourceSetEnable("AliveIn_Library")

require("ALIVE_Utilities.lua");
require("ALIVE_AgentExtensions.lua");
require("ALIVE_Color.lua");
require("ALIVE_Printing.lua");
require("ALIVE_PropertyKeys.lua");
require("ALIVE_Development_Freecam.lua");
require("ALIVE_Development_AgentBrowser.lua");
require("ALIVE_DepthOfFieldAutofocus.lua");

--Enable requisite ResourceSets
ResourceSetEnable("ProjectSeason4")
ResourceSetEnable("WalkingDead401")
ResourceSetEnable("WalkingDeadM101");
ResourceSetEnable("WalkingDead203");
ResourceSetEnable("WalkingDead305")

--Engine Scene Variables
local kScript = "ALIVE_Level_VioletSandbox"
local kScene = "adv_roadTile"
local kSceneObj = kScene .. ".scene"

--Cutscene Development Variables
ALIVE_Development_SceneObject = kScene;
ALIVE_Development_SceneObjectAgentName = kSceneObj;
ALIVE_Development_UseSeasonOneAPI = false;
ALIVE_Development_FreecamUseFOVScale = false;

--DOF Autofocus Variables
ALIVE_DOF_AUTOFOCUS_SceneObject = kScene;
ALIVE_DOF_AUTOFOCUS_SceneObjectAgentName = kSceneObj;
ALIVE_DOF_AUTOFOCUS_UseCameraDOF = true;

local dancingAnimation = nil;
local kenny = nil;

local kennyBoatMoveSpeed = 50;
local kennyBoatMaxDist = -50;
local kennyBoatMaxRot = 360;
local numOfBoats = 5;
local kennyBoatScale = 2;
local kennyBoatMoveLocation = 0; --DontTouchThis :)
local kennyBoatMoveRotation = 0; --DontTouchThis :)

ALIVE_DOF_AUTOFOCUS_GameplayCameraNames = 
{
    "FuckinDontRemoveThis"
};

ALIVE_DOF_AUTOFOCUS_ObjectEntries =
{
    "kenny"
};

Scene_SetupAnimations = function()
    dancingAnimation = PlayAnimation(kenny, "sk55_idle_fionaGuybrushDance.anm")
    ControllerSetLooping(dancingAnimation, true)
end

Scene_CreateRequisiteProps = function()
    
    local kennyBoatName = nil;
    local boat = nil;

    local boatParent = AgentCreate("boatParent", "obj_boatMotorChesapeake.prop", Vector(0, 50, 0), Vector(0, 0, 0), kScene, false, false);
    local prevBoatLocation = 0;

    for i = 0,numOfBoats,1 do
        --DialogBx_Okay("kennyBoat" .. i)
        kennyBoatName = "kennyBoat" .. i
        boat = AgentCreate(kennyBoatName, "obj_boatMotorChesapeake.prop", Vector((prevBoatLocation), 30,-10), Vector(90, 0, 0), kScene, false, false)
        ALIVE_AgentSetProperty(kennyBoatName, "Render Global Scale", kennyBoatScale, kScene);
        prevBoatLocation = prevBoatLocation+5;
        AgentAttach(boat, boatParent);
    end

    kenny = AgentCreate("kenny", "sk54_kenny203.prop", Vector(0, 0, 0), Vector(0, 0, 0), kScene, false, false)
    ALIVE_AgentSetProperty("kenny", "Render Global Scale", 20, kScene);

    --AgentAttach(kenny, boat);
end

Scene_Update = function()
    if (kennyBoatMoveLocation > kennyBoatMaxDist) then
        kennyBoatMoveLocation = 50
    end

    if (kennyBoatMoveRotation > kennyBoatMaxRot) then
        kennyBoatMoveRotation = 0;
    end

    kennyBoatMoveLocation = kennyBoatMoveLocation - (kennyBoatMoveSpeed * GetFrameTime());
    kennyBoatMoveRotation = kennyBoatMoveRotation + (kennyBoatMoveSpeed * GetFrameTime());
    
    ALIVE_SetAgentWorldPosition("boatParent", Vector(0, -500, 0), kScene);
    --ALIVE_SetAgentWorldPosition("boatParent", Vector(0, kennyBoatMoveLocation, 0), kScene);
    --ALIVE_SetAgentWorldRotation("boatParent", Vector(0, kennyBoatMoveRotation, 0), kScene);
end

ALIVE_Level_VioletSandbox = function()
    local prefs = GetPreferences();
    PropertySet(prefs, "Enable Graphic Black", false);
    PropertySet(prefs, "Render - Graphic Black Enabled", false);
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
    
    Scene_CreateRequisiteProps();
    Scene_SetupAnimations();

    local awesomeGod = SoundPlay("AwesomeGod.wav");
    ControllerSetLooping(awesomeGod, true);

    --Initialize tools
    ALIVE_Development_CreateFreeCamera();
    ALIVE_Development_InitalizeCutsceneTools();

    --Add required callbacks
    Callback_OnPostUpdate:Add(ALIVE_Development_UpdateFreeCamera);
    Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Input);
    Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Main);
    Callback_OnPostUpdate:Add(Scene_Update);

    --Scene_ScrollBoatForward();
end

SceneOpen(kScene,kScript)