--ThirdPerson_UI_kScene = "ui_main.scene";
ThirdPerson_UI_kScene = "ui_vignette.scene";
--ThirdPerson_UI_kScene = "default.scene";

ALIVE_Gameplay_Player_ThirdPerson_UI_CreateUI = function()
    --local textAgent = AgentCreate("UITEXTTEST", "ui_text.prop", Vector(0.5,0.5,-1), Vector(0,0,0), ThirdPerson_UI_kScene, false, false);
    local textAgent = AgentCreate("UITEXTTEST", "ui_text.prop", Vector(0.5,0.5,-1));

    --if halign then
        --TextSetHorizAlign(textAgent, true)
    --end
    
    --if valign then
        --TextSetVertAlign(textAgent, valign)
    --end
    
    TextSet(textAgent, "TESTING");
    
    AgentSetProperty(textAgent, "Text Render Layer", 99)

    --ThirdPerson_UI_kScene
    ALIVE_PrintSceneListToTXT(ThirdPerson_UI_kScene, "uivingette404.txt");
end

ALIVE_Gameplay_Player_ThirdPerson_UI_UpdateUI = function()

end