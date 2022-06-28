require("ALIVE_Core_Inclusions.lua");

--Enable requisite ResourceSets
ResourceSetEnable("ProjectSeason4");
ResourceSetEnable("WalkingDead404");

--Engine Scene Variables
local kScript = "ALIVE_Level_VioletSandbox"
local kScene = "adv_forestBarn"
local kSceneObj = kScene .. ".scene"

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
ALIVE_DOF_AUTOFOCUS_ObjectEntries = { "FuckinDontRemoveThis" };
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

ALIVE_Level_VioletSandbox = function()
    if (ALIVE_Core_Project_IsDebugMode) then
        ALIVE_Menu_PlayCredits();
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
end

SceneOpen(kScene,kScript)