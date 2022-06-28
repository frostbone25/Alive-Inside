require("MenuUtils.lua")
require("Credits.lua")
require("ClickText.lua")
require("Menu_ListMenu.lua")

ResourceSetEnable("WalkingDead404");
ResourceSetEnable("ProjectSeason4");

ALIVE_Menu_AreCreditsRunning = false;

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

ALIVE_Menu_PlayCredits = function(menu, sound)
  local cScene = "ui_creditsClosing.scene";
  local cSpeed = 0.5;
  local cPos = -11.5;

  if ALIVE_Menu_AreCreditsRunning then
    return false
  end
  ALIVE_Menu_AreCreditsRunning = true;
  MenuUtils_AddScene(cScene);
  Menu_Pop();

  if sound ~= nil then
    ControllerSetVolume(sound, 0);
  end

  Sleep(0.25);

  local creditsMusic = SoundPlay("music_custom1.wav");
  ControllerSetLooping(creditsMusic, true);

  Sleep(0.5);

  ALIVE_Menu_CreateTextAgent("ALIVE_Credits_Text", ALIVE_Menu_CreditsText, 0, 0, 0, nil, nil, cScene)

  local CreditsUpdater = function()
    cPos = cPos + (cSpeed * GetFrameTime());
    ALIVE_SetAgentWorldPosition("ALIVE_Credits_Text", Vector(0, cPos, 0), cScene)
  end

  Callback_OnPostUpdate:Add(CreditsUpdater);
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
  

  DialogBox("Are you gay?", "Think about your past...", "Go Fuck Yourself", false, "GUILTY!!!!", true, "TitsAndBalls", "Tits and Balls")
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