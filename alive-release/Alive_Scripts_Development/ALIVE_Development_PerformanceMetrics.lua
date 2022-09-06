--[[

]]--

--(public) relight dev variables (public because these values need to be persistent)
ALIVE_Development_PerformanceMetrics_Text = nil;
ALIVE_Development_PerformanceMetrics_TextTitle = "[Performance Metrics]";

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
    local screenPos = Vector(0.0, 0.75, 0.0);
    AgentSetWorldPosFromLogicalScreenPos(ALIVE_Development_PerformanceMetrics_Text, screenPos);

    -------------------------------------------------------------
    local finalText = ALIVE_Development_PerformanceMetrics_TextTitle;

    -------------------------------------------------------------------------
    --common metrics
    local averageFrameTime = GetAverageFrameTime();
    local fpsValue = 1.0 / GetAverageFrameTime();

    finalText = finalText .. "\n"; --new line
    finalText = finalText .. "FPS: " .. fpsValue;

    finalText = finalText .. "\n"; --new line
    finalText = finalText .. "Average Frame Time: " .. averageFrameTime;

    finalText = finalText .. "\n"; --new line
    finalText = finalText .. "--------------------------";
    -------------------------------------------------------------------------
    --time metrics
    local frameTime = GetFrameTime();
    local frameNumber = GetFrameNumber();
    local totalTime = GetTotalTime();

    finalText = finalText .. "\n"; --new line
    finalText = finalText .. "Frame Time: " .. frameTime;

    finalText = finalText .. "\n"; --new line
    finalText = finalText .. "Frame Number: " .. frameNumber;

    finalText = finalText .. "\n"; --new line
    finalText = finalText .. "Total Time: " .. totalTime;

    finalText = finalText .. "\n"; --new line
    finalText = finalText .. "--------------------------";
    -------------------------------------------------------------------------
    --vram metrics
    local vramSize = GetVramSize();
    local vramSize_MB = math.floor(vramSize * 1e-6);
    local vramAllocated = GetVramAllocated();
    local vramAllocated_MB = math.floor(vramAllocated * 1e-6);
    local vramUsagePercent = (vramAllocated / vramSize) * 100;

    finalText = finalText .. "\n"; --new line
    finalText = finalText .. "Vram Size: " .. vramSize .. " (" .. vramSize_MB .. " MB)";

    finalText = finalText .. "\n"; --new line
    finalText = finalText .. "Vram Allocated: " .. vramAllocated .. " (" .. vramAllocated_MB .. " MB)";


    finalText = finalText .. "\n"; --new line
    finalText = finalText .. "Vram Usage: " .. vramUsagePercent .. "%";

    finalText = finalText .. "\n"; --new line
    finalText = finalText .. "--------------------------";
    -------------------------------------------------------------------------
    --heap metrics
    local heapSize_MB = GetHeapSizeMB();
    local heapSizeAllocated = GetHeapAllocated();
    local heapSizeAllocated_MB = math.floor(GetHeapAllocated() * 1e-6);
    local heapUsagePercent = (heapSizeAllocated_MB / heapSize_MB) * 100;

    finalText = finalText .. "\n"; --new line
    finalText = finalText .. "Heap Size MB: " .. heapSize_MB .. " MB";

    finalText = finalText .. "\n"; --new line
    finalText = finalText .. "Heap Allocated: " .. heapSizeAllocated .. " (" .. heapSizeAllocated_MB .. " MB)";

    finalText = finalText .. "\n"; --new line
    finalText = finalText .. "Heap Usage: " .. heapUsagePercent .. "%";

    TextSet(ALIVE_Development_PerformanceMetrics_Text, finalText);
end