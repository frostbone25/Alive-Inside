require("MenuUtils.lua")
require("Credits.lua")
require("ClickText.lua")
require("Menu_ListMenu.lua")

ResourceSetEnable("WalkingDead404");
ResourceSetEnable("ProjectSeason4");

ALIVE_Menu_AreCreditsRunning = false;
ALIVE_Menu_CreditsMusic = nil;

ALIVE_Menu_ExitToDefinitive = function() --Exit to Definitive Edition w/ popup modal
    WidgetInputHandler_EnableInput(false)
    
    local toReturn = DialogBox_YesNo("Are you sure you want to return to the Definitive Edition menu? All unsaved progress will be lost.", "Exit to Definitive Menu")
    
    if (toReturn) then
        ChorePlayAndWait("ui_alphaGradient_hide");
        SubProject_Switch("Menu", "Menu_Main");
    else
        WidgetInputHandler_EnableInput(true);
    end
end

local ALIVE_Menu_CreateTextAgent = function(name, text, posx, posy, posz, halign, valign, theScene)
  local pos = Vector(posx, posy, posz)
  local textAgent = AgentCreate(name, "ui_text.prop", pos, Vector(0, 0, 0), theScene)
  if halign then
    TextSetHorizAlign(textAgent, halign)
  end
  if valign then
    TextSetVertAlign(textAgent, valign)
  end
  TextSet(textAgent, text)
  return textAgent
end

local SetSelectableExtents = function(agent, extentX, extentY)
  local propSet = AgentGetRuntimeProperties(agent)
  if propSet then
    PropertySet(propSet, "Extents Min", Vector(-extentX, -extentY, 0))
    PropertySet(propSet, "Extents Max", Vector(extentX, extentY, 0))
  end
end

ALIVE_Menu_UpdateLegend = function()
  Legend_Clear()
  Legend_Add("faceButtonDown", "legend_select")
  if IsPlatformXboxOne() then
    Legend_Add("faceButtonUp", MenuUtils_LegendStringForProfileUser(Menu_Text("legend_changeProfile")), "PlatformOpenAccountPickerUI()")
  end
end

--Internal function used to clean up the credits.
--Checks for main menu, and if unavailable, switches to the Main Menu scene.
ALIVE_Menu_CleanUpCredits = function()
  print("Cleaning up credits!");
  Sleep(5);
  
  if ALIVE_Menu_CreditsMusic ~= nil then
    ControllerFadeOut(ALIVE_Menu_CreditsMusic, 0.5, true)
  end
  
  ALIVE_Menu_AreCreditsRunning = false;

  if ALIVE_MainMenu_MenuAgent == nil then
    print("No menu found. Running SubProject_Switch.")
    SubProject_Switch("Menu", "ALIVE_Level_MainMenu.lua");
    return
  end

  Sleep(1);
  CursorHide(false, "ui_creditsClosing");
  SceneRemove("ui_creditsClosing.scene");
  Sleep(0.5);
  if ALIVE_Menu_ActiveMenuSound ~= nil then
    ControllerFadeIn(ALIVE_Menu_ActiveMenuSound, 0.5, true)
  end
  Menu_Push(ALIVE_MainMenu_MenuAgent, "ui_menuMain.scene");
end


--Plays credits, with optional arguments for sound.
--If sound is provided, it will mute the sound controller.
ALIVE_Menu_PlayCredits = function()
  local cScene = "ui_creditsClosing.scene";
  local cSpeed = 0.5;
  
  --Remember to update these when you update the credits! -Violet
  local cPos = -16.5; --Determines the initial starting point
  local cPosMax = 9; --Determines where the credits *Stop* scrolling, eg. when the legal text is centered.

  local scrollCredits = true; --Don't touch me!

  if ALIVE_Menu_AreCreditsRunning then --Prevents credits from being run on top of one another.
    return false
  end

  ALIVE_Menu_AreCreditsRunning = true; 
  CursorHide(true, "ui_creditsClosing");  
  Menu_Pop(); --Removes any active menus.
  
  if ALIVE_Menu_ActiveMenuSound ~= nil then --Fades out the current menu music.
    ControllerFadeOut(ALIVE_Menu_ActiveMenuSound, 0.5, true)
  end

  Sleep(1);
  MenuUtils_AddScene(cScene); --Add credits scene for blank background.
  Sleep(0.25);

  ALIVE_Menu_CreditsMusic = SoundPlay("music_custom1.wav"); --Adds credits music and plays it.
  ControllerSetLooping(ALIVE_Menu_CreditsMusic, true);

  Sleep(0.5);

  ALIVE_Menu_CreateTextAgent("ALIVE_Credits_Text", ALIVE_Menu_CreditsText, 0, cPos, 0, nil, nil, cScene) --Create credits text

  local CreditsUpdater = function()
    if not scrollCredits then --If credits aren't to be scrolled, return.
      return false
    end

    if cPos >= cPosMax then --If the credits have reached their intended final position
      print("Reached max credits position.");
      ALIVE_SetAgentWorldPosition("ALIVE_Credits_Text", Vector(0, cPosMax, 0), cScene)
      scrollCredits = false;
      ThreadStart(ALIVE_Menu_CleanUpCredits);
      return
    end

    cPos = cPos + (cSpeed * GetFrameTime()); --Move credits according to frame time.
    ALIVE_SetAgentWorldPosition("ALIVE_Credits_Text", Vector(0, cPos, 0), cScene)
  end

  Callback_OnPostUpdate:Add(CreditsUpdater); --Add callback.
  return true; --Return true to prevent failed credits false-positives.
end

ALIVE_Menu_Configurator = function(menu, isRestarting)
  if isRestarting then
    local isOkToOverride = DialogBox_YesNo("This will overwrite your current save file! If you'd like to start a new file, head to Settings -> Saves.", "Are you sure?")

    if not isOkToOverride then
      Sleep(0.5)
      WidgetInputHandler_EnableInput(true)
      Menu_Push(menu)
      return
    end
  end
  
  Sleep(0.25);
end

ALIVE_Menu_CreditsText = [[
  Telltale Modding Group
  ALIVE INSIDE

  Created by
  Droyti


  Developed By
  David Matos
  Droyti


  Written By
  Liam "Denymeister" Denton
  Droyti
  David Matos


  Textures by
  FrankDP1


  Tools Developed By
  Ben O'Sullivan
  Lucas Saragosa


  Custom Music By
  FlashOfVolt


  Special Thanks
  ZealotTormounds
  InColdBlood
  DomTheBomb
  Lightning
  and You.













  Copyright (C) 2020-22 Telltale Modding Group. Alive Inside is a fan
  project, created wholly without profit.

  Telltale Modding Group is not endorsed by or otherwise associated
  with Telltale Games, Skybound Entertainment, or their affiliates.
]]