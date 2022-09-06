local CutsceneSequenceMarkersStartTime = 0.0;
local CutsceneSequenceMarkersCount = 1;
local CutsceneSequenceMarkers = 
{
    marker1
    {
        time = 0.0,
        runCount = 0,
        executed = false,
        run = false
    }
};

ALIVE_Cutscene_SequenceMarkers_Update = function()
    local currentFrameTime = GetFrameTime();
    local currentTotalTime = GetTotalTime();

    for i = 1, CutsceneSequenceMarkersCount do
        local CutsceneSequenceMarkerItemName = "marker" .. tostring(i);
        local CutsceneSequenceMarkerItem = CutsceneSequenceMarkers[CutsceneSequenceMarkerItemName];

        local absoluteTime = CutsceneSequenceMarkersStartTime + CutsceneSequenceMarkerItem["time"];
        local itemRunCount = CutsceneSequenceMarkerItem["runCount"];

        if absoluteTime > currentTotalTime then
            CutsceneSequenceMarkerItem["runCount"] = itemRunCount + 1;
            CutsceneSequenceMarkerItem["run"] = true;
        end

        if itemRunCount > 0 then
            CutsceneSequenceMarkerItem["executed"] = true;
        end

        if itemRunCount > 1 then
            CutsceneSequenceMarkerItem["run"] = false;
        end
    end
end