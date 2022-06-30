require("ALIVE_Menu_MenuUtils.lua");

Credits_OnCancel = function(event)
  ALIVE_CancelCredits();
end

ALIVE_CancelCredits = function(event)
  print("Cancelling credits.");
  cancelCredits = true;
  ALIVE_Menu_CleanUpCredits(true);
end

ALIVE_Menu_CleanUpCredits = function(cancel)
  print("Cleaning up credits!");
  InputMapperDeactivate("Credits");
  if not cancel then
    Sleep(5);
  end
  
  if ALIVE_Menu_CreditsMusic ~= nil then
    ControllerFadeOut(ALIVE_Menu_CreditsMusic, 0.5, true)
  end
  
  ALIVE_Menu_AreCreditsRunning = false;

  if not ALIVE_Menu_IsMainMenuActive or ALIVE_Menu_ActiveMenuAgent == nil then
    print("No menu found. Running SubProject_Switch.")
    SubProject_Switch("Menu", "ALIVE_Level_MainMenu.lua");
    return
  end

  Sleep(1);
  CursorHide(false, "ui_creditsClosing");
  SceneRemove("ui_creditsClosing.scene");
  Sleep(0.5);
  if ALIVE_Menu_ActiveMenuSound ~= nil then
    ALIVE_Menu_ActiveMenuSound = SoundPlay(ALIVE_Menu_MenuMusicFile);
    ControllerSetVolume(ALIVE_Menu_ActiveMenuSound, 1);
    ControllerSetLooping(ALIVE_Menu_ActiveMenuSound, true);
  end
  Menu_Push(ALIVE_Menu_ActiveMenuAgent, "ui_menuMain.scene");
end

--Plays the credits
ALIVE_Menu_PlayCredits = function()
  print("---ALIVE_Menu_PlayCredits---")
  
  InputMapperActivate("Credits");
  local cScene = "ui_creditsClosing.scene";
  local cSpeed = 0.5; --0.5
  --Remember to update these when you update the credits! -Violet
  local cPos = -26; --Determines the initial starting point
  local cPosMax = 19.5; --Determines where the credits *Stop* scrolling, eg. when the legal text is centered.

  local scrollCredits = true; --Don't touch me!

  if ALIVE_Menu_AreCreditsRunning then --Prevents credits from being run on top of one another.
    return false
  end
  ALIVE_Menu_AreCreditsRunning = true; 
  CursorHide(true, "ui_creditsClosing");  
  
  if ALIVE_Menu_IsMainMenuActive and ALIVE_Menu_ActiveMenuSound ~= nil then --Fades out the current menu music.
    ControllerFadeOut(ALIVE_Menu_ActiveMenuSound, 0.5, true)
    Menu_Pop(); --Removes any active menus.
  else --There is not currently an active menu -- SAVE THE GAME instead.
    if not ALIVE_FileUtils_IsCurrentlyInitialized then
      ALIVE_Core_FileUtils_Init();
    end
    if not ALIVE_Core_FileUtils_SaveSetCheckpoint(99) then
      DialogBox_Okay("Save failed.")
    end
  end

  print("Reached Milestone: Add Credits Scene");

  Sleep(1);
  MenuUtils_AddScene(cScene); --Add credits scene for blank background.
  Sleep(0.25);

  ALIVE_Menu_CreditsMusic = SoundPlay(ALIVE_Menu_CreditsMusicFile); --Adds credits music and plays it.
  ControllerSetLooping(ALIVE_Menu_CreditsMusic, true);

  Sleep(0.5);

  print("Reached Milestone: Add text");
  ALIVE_Menu_CreateTextAgent("ALIVE_Credits_Text", ALIVE_Menu_CreditsText, 0, cPos, 0, nil, nil, cScene) --Create credits text

  local CreditsUpdater = function()
    if not scrollCredits then --If credits aren't to be scrolled, return.
      return false
    end

    if cancelCredits then
      cancelCredits = false;
      scrollCredits = false;
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

ALIVE_Menu_UpdateLegend = function()
  Legend_Clear()
  Legend_Add("faceButtonDown", "legend_select")
  if IsPlatformXboxOne() then
    Legend_Add("faceButtonUp", MenuUtils_LegendStringForProfileUser(Menu_Text("legend_changeProfile")), "PlatformOpenAccountPickerUI()")
  end
end

ALIVE_Menu_CreateTextAgent = function(name, text, posx, posy, posz, halign, valign, theScene)
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
  FlashOFvolt


  Telltale Modding Discord Staff
  BatuTH
  Ryuk
  Mihalache Dragos-Stefan
  Threefold Maker


  Special Thanks
  ZealotTormounds
  InColdBlood
  DomTheBomb
  Lightning
  Melora
  and You.

  
  OPEN SOURCE ATTRIBUTION


  JSON.lua
  Copyright (c) 2020 rxi


  Permission is hereby granted, free of charge, to any person obtaining a copy of
  this software and associated documentation files (the "Software"), to deal in
  the Software without restriction, including without limitation the rights to
  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
  of the Software, and to permit persons to whom the Software is furnished to do
  so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.


  Alive Inside is available under the MIT license.
  Copyright (c) 2020-22 Telltale Modding Group

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.













  Copyright (C) 2020-22 Telltale Modding Group. Alive Inside is a fan
  project, created wholly without profit.

  Telltale Modding Group is not endorsed by or otherwise associated
  with Telltale Games, Skybound Entertainment, or their affiliates.

  THANK YOU FOR PLAYING
]]