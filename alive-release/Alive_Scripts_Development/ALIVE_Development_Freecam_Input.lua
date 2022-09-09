----------------------------------------------------------------------
ALIVE_Development_Freecam_Input_ForwardBegin = function()
    ALIVE_Development_Freecam_InputVerticalValue = 1;
end

ALIVE_Development_Freecam_Input_ForwardEnd = function()
    ALIVE_Development_Freecam_InputVerticalValue = 0;
end

----------------------------------------------------------------------
ALIVE_Development_Freecam_Input_BackwardBegin = function()
    ALIVE_Development_Freecam_InputVerticalValue = -1;
end

ALIVE_Development_Freecam_Input_BackwardEnd = function()
    ALIVE_Development_Freecam_InputVerticalValue = 0;
end

----------------------------------------------------------------------
ALIVE_Development_Freecam_Input_LeftBegin = function()
    ALIVE_Development_Freecam_InputHorizontalValue = 1;
end

ALIVE_Development_Freecam_Input_LeftEnd = function()
    ALIVE_Development_Freecam_InputHorizontalValue = 0;
end

----------------------------------------------------------------------
ALIVE_Development_Freecam_Input_RightBegin = function()
    ALIVE_Development_Freecam_InputHorizontalValue = -1;
end

ALIVE_Development_Freecam_Input_RightEnd = function()
    ALIVE_Development_Freecam_InputHorizontalValue = 0;
end

----------------------------------------------------------------------
ALIVE_Development_Freecam_Input_UpBegin = function()
    ALIVE_Development_Freecam_InputHeightValue = 1;
end

ALIVE_Development_Freecam_Input_UpEnd = function()
    ALIVE_Development_Freecam_InputHeightValue = 0;
end

----------------------------------------------------------------------
ALIVE_Development_Freecam_Input_DownBegin = function()
    ALIVE_Development_Freecam_InputHeightValue = -1;
end

ALIVE_Development_Freecam_Input_DownEnd = function()
    ALIVE_Development_Freecam_InputHeightValue = 0;
end

----------------------------------------------------------------------
ALIVE_Development_Freecam_Input_LeftMouseBegin = function()
    ALIVE_Development_Freecam_InputZoomingIn = true;
end

ALIVE_Development_Freecam_Input_LeftMouseEnd = function()
    ALIVE_Development_Freecam_InputZoomingIn = false;
end

----------------------------------------------------------------------
ALIVE_Development_Freecam_Input_RightMouseBegin = function()
    ALIVE_Development_Freecam_InputZoomingOut = true;
end

ALIVE_Development_Freecam_Input_RightMouseEnd = function()
    ALIVE_Development_Freecam_InputZoomingOut = false;
end

----------------------------------------------------------------------
ALIVE_Development_Freecam_Input_FreezeBegin = function()
    ALIVE_Development_Freecam_Frozen = not ALIVE_Development_Freecam_Frozen;
end

ALIVE_Development_Freecam_Input_FreezeEnd = function()

end

----------------------------------------------------------------------
ALIVE_Development_Freecam_Input_SprintBegin = function()
    ALIVE_Development_Freecam_InputSpeeding = true;
end

ALIVE_Development_Freecam_Input_SprintEnd = function()
    ALIVE_Development_Freecam_InputSpeeding = false;
end

----------------------------------------------------------------------
ALIVE_Development_Freecam_Input_SlowBegin = function()
    ALIVE_Development_Freecam_InputCrawling = true;
end

ALIVE_Development_Freecam_Input_SlowEnd = function()
    ALIVE_Development_Freecam_InputCrawling = false;
end