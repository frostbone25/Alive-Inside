--Enable requisite ResourceSets
ResourceSetEnable("Project");
ResourceSetEnable("ProjectSeason1");
ResourceSetEnable("ProjectSeason4");
ResourceSetEnable("WalkingDead404");
ResourceSetEnable("Menu");

require("ALIVE_Core_Math.lua");
require("ALIVE_Core_Utilities.lua");
require("ALIVE_Core_AgentExtensions_Properties.lua");
require("ALIVE_Core_AgentExtensions_Transform.lua");
require("ALIVE_Core_AgentExtensions_Utillity.lua");
require("ALIVE_Core_Color.lua");
require("ALIVE_Core_Strings.lua");
require("ALIVE_Core_Printing.lua");
require("ALIVE_Core_PropertyKeys.lua");
require("ALIVE_Core_DepthOfFieldAutofocus.lua");
require("ALIVE_Development_Freecam.lua");
require("ALIVE_Development_AgentBrowser.lua");
require("ALIVE_Core_Project.lua");
require("ALIVE_Core_MenuUtils.lua");
require("ALIVE_Scene_LevelCleanup_404_BoardingSchoolDorm.lua");
require("ALIVE_Scene_LevelRelight_404_BoardingSchoolDorm.lua");

require("UI_ListButton.lua")
require("UI_ListButtonLite.lua")
require("UI_Legend.lua")
require("UI_Popup.lua")
require("Utilities.lua")
require("MenuUtils.lua")
require("RichPresence.lua")
require("AspectRatio.lua")

--Engine Scene Variables
local kScript = "ALIVE_Level_MainMenu"
local kScene = "ui_menuMain.scene" --adv_boardingSchoolDorm
local keyArtScene = "adv_boardingSchoolDorm.scene"
local kSceneObj = kScene .. ".scene"

local menuCamera = nil;

--Cutscene Development Variables
ALIVE_Development_SceneObject = keyArtScene;
ALIVE_Development_SceneObjectAgentName = keyArtScene;
ALIVE_Development_UseSeasonOneAPI = false;
ALIVE_Development_FreecamUseFOVScale = false;

local EnableFreecamTools = false;

--DOF Autofocus Variables
ALIVE_DOF_AUTOFOCUS_SceneObject = keyArtScene;
ALIVE_DOF_AUTOFOCUS_SceneObjectAgentName = keyArtScene;
ALIVE_DOF_AUTOFOCUS_UseCameraDOF = true;
ALIVE_DOF_AUTOFOCUS_UseLegacyDOF = false;
ALIVE_DOF_AUTOFOCUS_UseHighQualityDOF = true;
ALIVE_DOF_AUTOFOCUS_GameplayCameraNames = { "FuckinDontRemoveThis" };
ALIVE_DOF_AUTOFOCUS_ObjectEntries = { "ALIVE_MainMenuClemHat" };
ALIVE_DOF_AUTOFOCUS_Settings =
{
    TargetValidation_IsOnScreen = false,
    TargetValidation_IsVisible = true,
    TargetValidation_IsWithinDistance = false,
    TargetValidation_IsFacingCamera = false,
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
    ManualOnly = true,
    NearFocusDistance = 2.0,
    NearFallof = 0.25,
    NearMax = 0.5,
    FarFocusDistance = 2.25,
    FarFalloff = 0.25,
    FarMax = 0.25
};

--proceudal handheld animation variables
local camera_handheld_currentRot = Vector(0, 0, 0);
local camera_handheld_currentPos = Vector(0, 0, 0);
local cutscene_handheld_x_level1 = 0;
local cutscene_handheld_x_level2 = 0;
local cutscene_handheld_x_level3 = 0;
local cutscene_handheld_x_level4 = 0;
local cutscene_handheld_y_level1 = 0;
local cutscene_handheld_y_level2 = 0;
local cutscene_handheld_y_level3 = 0;
local cutscene_handheld_y_level4 = 0;
local cutscene_handheld_z_level1 = 0;
local cutscene_handheld_z_level2 = 0;
local cutscene_handheld_z_level3 = 0;
local cutscene_handheld_z_level4 = 0;

--proceudal handheld animation
--worth noting that while it does work, its definetly not perfect and jumps around more than I'd like.
--if the values are kept low then it works fine
--procedual handheld camera animation (adds a bit of extra life and motion to the camera throughout the sequence)
local DoHandheldCameraAnimation = function()
    local totalShakeAmount = 0.15;
    local totalSpeedMultiplier = 0.75;

    ------------------------------------------
    cutscene_handheld_x_level1 = cutscene_handheld_x_level1 + (GetFrameTime() * 2.0 * totalSpeedMultiplier);
    cutscene_handheld_x_level2 = cutscene_handheld_x_level2 + (GetFrameTime() * 5.0 * totalSpeedMultiplier);
    cutscene_handheld_x_level3 = cutscene_handheld_x_level3 + (GetFrameTime() * 3.5 * totalSpeedMultiplier);
    cutscene_handheld_x_level4 = cutscene_handheld_x_level4 + (GetFrameTime() * 12.0 * totalSpeedMultiplier);
    
    local level1_x = math.sin(cutscene_handheld_x_level1) * 0.3;
    local level2_x = math.sin(cutscene_handheld_x_level2) * 0.25;
    local level3_x = math.sin(cutscene_handheld_x_level3) * 0.15;
    local level4_x = math.sin(cutscene_handheld_x_level4) * 0.05;

    --local totalX = level1_x - level2_x + level3_x + level4_x;
    local totalX = level1_x - level2_x + level3_x;
    totalX = totalX * totalShakeAmount;

    ------------------------------------------
    cutscene_handheld_y_level1 = cutscene_handheld_y_level1 + (GetFrameTime() * 2.0 * totalSpeedMultiplier);
    cutscene_handheld_y_level2 = cutscene_handheld_y_level2 + (GetFrameTime() * 4.5 * totalSpeedMultiplier);
    cutscene_handheld_y_level3 = cutscene_handheld_y_level3 + (GetFrameTime() * 3.5 * totalSpeedMultiplier);
    cutscene_handheld_y_level4 = cutscene_handheld_y_level4 + (GetFrameTime() * 12.5 * totalSpeedMultiplier);
    
    local level1_y = math.sin(cutscene_handheld_y_level1) * 0.3;
    local level2_y = math.sin(cutscene_handheld_y_level2) * 0.25;
    local level3_y = math.sin(cutscene_handheld_y_level3) * 0.15;
    local level4_y = math.sin(cutscene_handheld_y_level4) * 0.05;

    --local totalY = level1_y + level2_y - level3_y - level4_y;
    local totalY = level1_y + level2_y - level3_y;
    totalY = totalY * totalShakeAmount;

    ------------------------------------------
    cutscene_handheld_z_level1 = cutscene_handheld_z_level1 + (GetFrameTime() * 1.5 * totalSpeedMultiplier);
    cutscene_handheld_z_level2 = cutscene_handheld_z_level2 + (GetFrameTime() * 4.0 * totalSpeedMultiplier);
    cutscene_handheld_z_level3 = cutscene_handheld_z_level3 + (GetFrameTime() * 3.5 * totalSpeedMultiplier);
    cutscene_handheld_z_level4 = cutscene_handheld_z_level4 + (GetFrameTime() * 10.5 * totalSpeedMultiplier);
    
    local level1_z = math.sin(cutscene_handheld_z_level1) * 0.15;
    local level2_z = math.sin(cutscene_handheld_z_level2) * 0.1;
    local level3_z = math.sin(cutscene_handheld_z_level3) * 0.05;
    local level4_z = math.sin(cutscene_handheld_z_level4) * 0.01;

    --local totalZ = level1_z - level2_z + level3_z - level4_z;
    local totalZ = level1_z - level2_z + level3_z;
    totalZ = totalZ * totalShakeAmount;

    ------------------------------------------
    camera_handheld_currentRot = Vector(totalX, totalY, totalZ);

    local camPosition = Vector(15.05, 1, -4.32);
    local camRotation = Vector(0, 90, 0);

    camPosition = camPosition + camera_handheld_currentPos;
    camRotation = camRotation + camera_handheld_currentRot;

    --ALIVE_SetAgentPosition("ALIVE_MainMenuCamera", camPosition, keyArtScene);
    ALIVE_SetAgentRotation("ALIVE_MainMenuCamera", camRotation, keyArtScene);
end

ALIVE_MainMenu_PrepareCamera = function()
    local camProp = "module_camera.prop";
    local camPosition = Vector(15.05, 1, -4.32);
    local camRotation = Vector(0, 90, 0);
    
    menuCamera = AgentCreate("ALIVE_MainMenuCamera", camProp, camPosition, camRotation, keyArtScene, false, false);
    
    ALIVE_SetAgentPosition("cam_ui_menuMain", camPosition)
    ALIVE_AgentSetProperty("ALIVE_MainMenuCamera", "Clip Plane - Far", 2500, keyArtScene);
    ALIVE_AgentSetProperty("ALIVE_MainMenuCamera", "Clip Plane - Near", 0.05, keyArtScene);
    ALIVE_AgentSetProperty("ALIVE_MainMenuCamera", "Lens - Current Lens", nil, keyArtScene);
    ALIVE_RemovingAgentsWithPrefix(keyArtScene, "cam_");
    CameraPush("ALIVE_MainMenuCamera");
end

ALIVE_MainMenu_PrepareAgents = function()
    local clemHat = AgentCreate("ALIVE_MainMenuClemHat", "obj_capClementine400.prop", Vector(17.12, 0.8125, -4.32), Vector(-2, -65.7, 0), keyArtScene, false, false)
    --local bgMusic = SoundPlay("mus_loop_clementine_04.wav");
    --local bgMusic = SoundPlay("mus_loop_clementine_03.wav");
    --local bgMusic = SoundPlay("mus_loop_clementine_01.wav"); --the real shit
    --local bgMusic = SoundPlay("music_custom1.wav"); --flashvolts "credits" track
    local bgMusic = SoundPlay("mus_loop_AJ_01a.wav"); --what it should be

    ControllerSetLooping(bgMusic, true);
end

ALIVE_MainMenu_CreateAndPopulateMenu = function()
    local menu = Menu_Create(ListMenu, "ui_menuMain", kScene)
    menu.align = "left"
    menu.background = {}

    menu.Show = function(self, direction) --Ran on menu show.
        if direction and direction < 0 then
            ChorePlay("ui_alphaGradient_show")
        end
        ;
        (Menu.Show)(self)
        RichPresence_Set("richPresence_mainMenu", false)
        ALIVE_Menu_UpdateLegend();
    end

    menu.Hide = function(self, direction) --Ran on menu hide.
        ChorePlay("ui_alphaGradient_hide")
        ;
        (Menu.Hide)(self)
    end

    menu.Populate = function(self) --Populate the menu here. Add buttons & everything functional.
        local buttonPlay =  Menu_Add(ListButtonLite, "play", "Play", "ALIVE_PlayGame()")
        AgentSetProperty(buttonPlay.agent, "Text Glyph Scale", 1.5);

        Menu_Add(ListButtonLite, "settings", "Settings", "ALIVE_MainMenu_Settings()")
        Menu_Add(ListButtonLite, "credits", "Credits", "ALIVE_MainMenu_Credits()")
        Menu_Add(ListButtonLite, "definitive", "Definitive Menu", "ALIVE_Menu_ExitToDefinitive()")
        if IsPlatformPC() or IsPlatformMac() then
            Menu_Add(ListButtonLite, "exit", "label_exitGame", "UI_Confirm( \"popup_quit_header\", \"popup_quit_message\", \"EngineQuit()\" )")
        end

        local legendWidget = Menu_Add(Legend)
        legendWidget.Place = function(self)
            self:AnchorToAgent(menu.agent, "left", "bottom")
        end
        ALIVE_Menu_UpdateLegend();
    end

    menu.onModalPopped = function(self)
        (Menu.onModalPopped)(self)
        ALIVE_Menu_UpdateLegend()
    end

    Menu_Push(menu); --This is vitally important. Fixes alignment bug. -Violet 
    Menu_Show(menu);
end

ALIVE_MainMenu_PrepareMenu = function() --Boilerplate to ensure there are no scaling issues or visual inconsistencies.
    if Input_UseTouch() then
        ClickText_Enable(true)
    end

    local prefs = GetPreferences();

    if PropertyIsLocal(prefs, "Menu - User Gamma Setting") then
        RenderSetIntensity(PropertyGet(prefs, "Menu - User Gamma Setting"))
        PropertyRemove(prefs, "Menu - User Gamma Setting")
        SavePrefs()
    end

    RenderForce_16_by_9_AspectRatio(true)
    RenderDelay(1)
    WaitForNextFrame()
    MenuUtils_AddScene(keyArtScene);

    --perform the cleanup/relight on the key art scene
    ALIVE_Scene_LevelCleanup_404_BoardingSchoolDorm(keyArtScene);
    ALIVE_Scene_LevelRelight_404_BoardingSchoolDorm_MainMenu(keyArtScene);

    ALIVE_MainMenu_CreateAndPopulateMenu();
end

ALIVE_Level_MainMenu = function()
    ALIVE_Core_Project_SetProjectSettings();

    if (ALIVE_Core_Project_IsDebugMode) and (EnableFreecamTools) then
        --add the key art scene so we can fly around within it
        MenuUtils_AddScene(keyArtScene);
        ALIVE_MainMenu_PrepareAgents();

        --perform the cleanup/relight on the key art scene
        ALIVE_Scene_LevelCleanup_404_BoardingSchoolDorm(keyArtScene);
        ALIVE_Scene_LevelRelight_404_BoardingSchoolDorm_MainMenu(keyArtScene);

        --Initialize tools
        ALIVE_Development_CreateFreeCamera();
        ALIVE_Development_InitalizeCutsceneTools();

        --Add required callbacks
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateFreeCamera);
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Input);
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Main);

    else --Build menu as normal.
        ALIVE_MainMenu_PrepareMenu();
        ALIVE_MainMenu_PrepareAgents();
        ALIVE_MainMenu_PrepareCamera();

        --get DOF setup
        ALIVE_Camera_DepthOfFieldAutofocus_SetupDOF(keyArtScene);
        Callback_OnPostUpdate:Add(DoHandheldCameraAnimation); --add a procedual handheld camera animation
        Callback_OnPostUpdate:Add(ALIVE_Camera_DepthOfFieldAutofocus_PerformAutofocus); --do DOF
    end

    --ALIVE_PrintSceneListToTXT(keyArtScene, "adv_boardingSchoolDorm404.txt");
end

SceneOpen(kScene,kScript)