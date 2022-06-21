--Enable requisite ResourceSets
ResourceSetEnable("ProjectSeason4");
ResourceSetEnable("Project");
ResourceSetEnable("Menu");
ResourceSetEnable("WalkingDead404");

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
require("ALIVE_Core_Project.lua");

--Project//Menu
require("UI_ListButton.lua")
require("UI_ListButtonLite.lua")
require("UI_Legend.lua")
require("UI_Popup.lua")
require("Utilities.lua")
require("MenuUtils.lua")
require("RichPresence.lua")
require("AspectRatio.lua")

local bgMain = {isMenuMain = true}

--Engine Scene Variables
local kScript = "ALIVE_Level_MainMenu"
local kScene = "ui_menuMain.scene" --adv_boardingSchoolDorm
local keyArtScene = "adv_boardingSchoolDorm"
local kSceneObj = kScene .. ".scene"

--Cutscene Development Variables
ALIVE_Development_SceneObject = kScene;
ALIVE_Development_SceneObjectAgentName = kSceneObj;
ALIVE_Development_UseSeasonOneAPI = false;
ALIVE_Development_FreecamUseFOVScale = false;

local EnableFreecamTools = false;

--DOF Autofocus Variables
ALIVE_DOF_AUTOFOCUS_SceneObject = kScene;
ALIVE_DOF_AUTOFOCUS_SceneObjectAgentName = kSceneObj;
ALIVE_DOF_AUTOFOCUS_UseCameraDOF = false;

ALIVE_DOF_AUTOFOCUS_GameplayCameraNames = 
{
    "FuckinDontRemoveThis"
};

ALIVE_DOF_AUTOFOCUS_ObjectEntries =
{
    "FuckinDontRemoveThis"
};

ALIVE_MainMenu_PrepareCamera = function()
    local camProp = "module_camera.prop";
    local camPosition = Vector(15.05, 1, -4.32);
    local camRotation = Vector(0, 90, 0);

    local menuCamera = AgentCreate("ALIVE_MainMenuCamera", camProp, camPosition, camRotation, keyArtScene, false, false);
    
    ALIVE_AgentSetProperty("ALIVE_MainMenuCamera", "Clip Plane - Far", 2500, keyArtScene);
    ALIVE_AgentSetProperty("ALIVE_MainMenuCamera", "Clip Plane - Near", 0.05, keyArtScene);
    ALIVE_AgentSetProperty("ALIVE_MainMenuCamera", "Lens - Current Lens", nil, keyArtScene);
    ALIVE_RemovingAgentsWithPrefix(keyArtScene, "cam_");

    CameraPush("ALIVE_MainMenuCamera");
end

ALIVE_MainMenu_PrepareAgents = function()
    --Prepare all scene agents
    local clemHat = AgentCreate("ALIVE_MainMenuClemHat", "obj_capClementine400.prop", Vector(17.12, 0.82, -4.32), Vector(-5, -65.7, 0), keyArtScene, false, false)
end

ALIVE_MainMenu_CreateAndPopulateMenu = function()
    if not SceneIsActive(keyArtScene) then
        MenuUtils_AddScene(keyArtScene)
    end
    SceneHide(keyArtScene, false)
    SceneHide("ui_menuMain", false)

    local menu = Menu_Create(ListMenu, "ui_menuMain", kScene)
    menu.align = "left"
    menu.background = bgMain

    menu.Show = function(self, direction)
        if direction and direction < 0 then
            ChorePlay("ui_alphaGradient_show")
        end
        ;
        (Menu.Show)(self)
        RichPresence_Set("richPresence_mainMenu", false)
    end

    menu.Hide = function(self, direction)
        ChorePlay("ui_alphaGradient_hide")
        ;
        (Menu.Hide)(self)
    end

    menu.Populate = function(self)
         Menu_Add(ListButtonLite, "exit", "label_exitGame", "UI_Confirm( \"popup_quit_header\", \"popup_quit_message\", \"EngineQuit()\" )")
        local legendWidget = Menu_Add(Legend)
            legendWidget.Place = function(self)
            self:AnchorToAgent(menu.agent, "left", "bottom")
        end
    end
    
    Menu_Show(menu);
end

ALIVE_MainMenu_PrepareMenu = function()
    if Input_UseTouch() then
        ClickText_Enable(true)
    end
    local prefs = GetPreferences()
    if PropertyIsLocal(prefs, "Menu - User Gamma Setting") then
        RenderSetIntensity(PropertyGet(prefs, "Menu - User Gamma Setting"))
        PropertyRemove(prefs, "Menu - User Gamma Setting")
        SavePrefs()
    end
    RenderForce_16_by_9_AspectRatio(true)
    RenderDelay(1)
    WaitForNextFrame()
    ALIVE_MainMenu_CreateAndPopulateMenu();
end

ALIVE_Level_MainMenu = function()

    ALIVE_MainMenu_PrepareMenu();
    ALIVE_MainMenu_PrepareAgents();

    if (ALIVE_Core_Project_IsDebugMode) and (EnableFreecamTools) then
        --Initialize tools
        ALIVE_Development_CreateFreeCamera();
        ALIVE_Development_InitalizeCutsceneTools();
    
        --Add required callbacks
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateFreeCamera);
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Input);
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Main);
    else
        ALIVE_MainMenu_PrepareCamera();
    end
end

SceneOpen(kScene,kScript)