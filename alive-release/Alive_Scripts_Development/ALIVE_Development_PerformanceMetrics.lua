--[[

]]--

--(public) relight dev variables (public because these values need to be persistent)
ALIVE_Development_PerformanceMetrics_Text = nil;
ALIVE_Development_PerformanceMetrics_TextTitle = "[Performance Metrics]";

local previousFrameNumber = 0;
local previousTime = 0;
local fpsValue = 0;

local CreateTextAgent = function(name, text, posx, posy, posz, halign, valign)
    local pos       = Vector(posx, posy, posz)
    local textAgent = AgentCreate(name, "ui_text.prop", pos)

    if halign then
        TextSetHorizAlign(textAgent, halign)
    end
    
    if valign then
        TextSetVertAlign(textAgent, valign)
    end
    
    TextSet(textAgent, text)
    
    AgentSetProperty(textAgent, "Text Render Layer", 99);
    AgentSetProperty(textAgent, "Text Render After Post-Effects", true);
    AgentSetProperty(textAgent, "Text Right To Left", true);
    AgentSetProperty(textAgent, "Text Color", Color(0.5, 1.0, 0.5, 1.0));

    return textAgent
end

ALIVE_Development_PerformanceMetrics_Initalize = function()
    -------------------------------------------------------------
    --initalize menu text

    --create our menu text
    ALIVE_Development_PerformanceMetrics_Text = CreateTextAgent("PerformanceMetricsText", "Performance Metrics Text Initalized", 0.0, 0.0, 0, 0, 0);

    --scale note
    --1.0 = default
    --0.5 = half
    --2.0 = double
    TextSetScale(ALIVE_Development_PerformanceMetrics_Text, 0.5);
end

ALIVE_Development_PerformanceMetrics_Update = function()  
    -------------------------------------------------------------
    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    local screenPos = Vector(0.0, 0.875, 0.0);
    AgentSetWorldPosFromLogicalScreenPos(ALIVE_Development_PerformanceMetrics_Text, screenPos);

    -------------------------------------------------------------
    local finalText = ALIVE_Development_PerformanceMetrics_TextTitle;

    finalText = finalText .. "\n"; --new line
    finalText = finalText .. "FPS: " .. 1.0 / GetAverageFrameTime();

    finalText = finalText .. "\n"; --new line
    finalText = finalText .. "Average Frame Time: " .. GetAverageFrameTime();

    finalText = finalText .. "\n"; --new line
    finalText = finalText .. "--------------------------";

    finalText = finalText .. "\n"; --new line
    finalText = finalText .. "Frame Time: " .. GetFrameTime();

    finalText = finalText .. "\n"; --new line
    finalText = finalText .. "Frame Number: " .. GetFrameNumber();

    finalText = finalText .. "\n"; --new line
    finalText = finalText .. "Total Time: " .. GetTotalTime();

    TextSet(ALIVE_Development_PerformanceMetrics_Text, finalText);
end