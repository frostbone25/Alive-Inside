require("MenuUtils.lua")

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

ALIVE_Menu_UpdateLegend = function()
  Legend_Clear()
  Legend_Add("faceButtonDown", "legend_select")
  if IsPlatformXboxOne() then
    Legend_Add("faceButtonUp", MenuUtils_LegendStringForProfileUser(Menu_Text("legend_changeProfile")), "PlatformOpenAccountPickerUI()")
  end
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