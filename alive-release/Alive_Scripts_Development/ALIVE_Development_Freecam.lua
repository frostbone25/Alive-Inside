--[[
Custom Development Tools/Functions script

THIS SCRIPT IS FOR HANDLING FREECAM

KEYCODE VALUES - https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
Keycode values are in hexcode, so use this to convert them to decimal - https://www.rapidtables.com/convert/number/hex-to-decimal.html

This script also uses functions from the following lua scripts...
- ALIVE_AgentExtensions.lua
- ALIVE_Printing.lua

WHEN IMPLEMENTING THIS INTO A LEVEL, YOU MUST DO THE FOLLOWING...

1. At the top of the script, you must have a variable that is named
- ALIVE_Development_SceneObject
This will just simply contain a reference to the kScene variable so the function can reference object from the scene.

2. At the top of the script, you must have a variable that is named
- ALIVE_Development_SceneObjectAgentName
This will just simply contain a reference to the scene agent name.

3. In the main function of the level script you call this function before step 2
ALIVE_Development_CreateFreeCamera(kScene)

4. Lastly, also in the main function of the level script you add the functionality like so...

Callback_OnPostUpdate:Add(ALIVE_Development_UpdateFreeCamera)
]]--

--ALIVE_Development_SceneObject
--ALIVE_Development_SceneObjectAgentName
--ALIVE_Development_UseSeasonOneAPI
--ALIVE_Development_FreecamUseFOVScale

--(public) cutscene dev freecam variables (public because these values need to be persistent)
ALIVE_Development_Freecam_InputHorizontalValue = 0;
ALIVE_Development_Freecam_InputVerticalValue = 0;
ALIVE_Development_Freecam_InputHeightValue = 0;
ALIVE_Development_Freecam_PrevCamPos = Vector(0,0,0);
ALIVE_Development_Freecam_PrevCamRot = Vector(0,0,0);
ALIVE_Development_Freecam_PrevCursorPos = Vector(0,0,0);
ALIVE_Development_Freecam_InputMouseAmountX = 0;
ALIVE_Development_Freecam_InputMouseAmountY = 0;
ALIVE_Development_Freecam_InputFieldOfViewAmount = 110;
ALIVE_Development_Freecam_PrevTime = 0;
ALIVE_Development_Freecam_Frozen = false;
ALIVE_Development_Freecam_CameraName = "fofle_devtoolsFreecam";

--user configruable
ALIVE_Development_Freecam_SnappyMovement = false;
ALIVE_Development_Freecam_SnappyRotation = false;
ALIVE_Development_Freecam_PositionLerpFactor = 5.0;
ALIVE_Development_Freecam_RotationLerpFactor = 7.5;
ALIVE_Development_Freecam_PositionIncrementDefault = 0.025;
ALIVE_Development_Freecam_PositionIncrementShift = 0.25;
ALIVE_Development_Freecam_FovIncrement = 0.5;

require("ALIVE_Development_Freecam_Input.lua");

--input workaround because S1 has different API
local ALIVE_InputKeyPress = function(keyCode)
    if (ALIVE_Development_UseSeasonOneAPI == true) then
        return Input_IsPressed(keyCode);
    else
        return Input_IsVKeyPressed(keyCode);
    end
end

ALIVE_Development_CreateFreeCamera = function()
    local cam_prop = "module_camera.prop"
    
    local newPosition = Vector(0,0,0)
    local newRotation = Vector(90,0,0)
    
    local cameraAgent = AgentCreate(ALIVE_Development_Freecam_CameraName, cam_prop, newPosition, newRotation, ALIVE_Development_SceneObject, false, false)
    
    ALIVE_AgentSetProperty(ALIVE_Development_Freecam_CameraName, "Clip Plane - Far", 2500, ALIVE_Development_SceneObject)
    ALIVE_AgentSetProperty(ALIVE_Development_Freecam_CameraName, "Clip Plane - Near", 0.05, ALIVE_Development_SceneObject)
    ALIVE_AgentSetProperty(ALIVE_Development_Freecam_CameraName, "Lens - Current Lens", nil, ALIVE_Development_SceneObject)

    ALIVE_RemovingAgentsWithPrefix(sceneObj, "cam_")

    CameraPush(ALIVE_Development_Freecam_CameraName);

    InputMapperActivate("Alive_Development_Freecam.imap");
end

ALIVE_Development_UpdateFreeCamera = function()
    local currFrameTime = GetFrameTime();

    --freecamera freezing
    if ALIVE_InputKeyPress(ALIVE_Core_Keycodes_R) then
        ALIVE_Development_Freecam_Frozen = false;
    elseif ALIVE_InputKeyPress(ALIVE_Core_Keycodes_F) then
        ALIVE_Development_Freecam_Frozen = true;
    end

    --hide/show the cursor
    if (ALIVE_Development_Freecam_Frozen == true) then
        CursorHide(false);
        CursorEnable(true);
        do return end --don't conitnue with the rest of the function
    else
        CursorHide(true);
        CursorEnable(true);
    end

    ------------------------------MOVEMENT------------------------------
    local positionIncrement = ALIVE_Development_Freecam_PositionIncrementDefault;
    
    if ALIVE_InputKeyPress(ALIVE_Core_Keycodes_Shift) then
        positionIncrement = ALIVE_Development_Freecam_PositionIncrementShift;
    end
    
    if ALIVE_InputKeyPress(ALIVE_Core_Keycodes_Q) then
        ALIVE_Development_Freecam_InputHeightValue = -positionIncrement;
    elseif ALIVE_InputKeyPress(ALIVE_Core_Keycodes_E) then
        ALIVE_Development_Freecam_InputHeightValue = positionIncrement;
    else
        ALIVE_Development_Freecam_InputHeightValue = 0;
    end
    
    if ALIVE_InputKeyPress(ALIVE_Core_Keycodes_W) then
        ALIVE_Development_Freecam_InputVerticalValue = positionIncrement;
    elseif ALIVE_InputKeyPress(ALIVE_Core_Keycodes_S) then
        ALIVE_Development_Freecam_InputVerticalValue = -positionIncrement;
    else
        ALIVE_Development_Freecam_InputVerticalValue = 0;
    end
    
    if ALIVE_InputKeyPress(ALIVE_Core_Keycodes_A) then
        ALIVE_Development_Freecam_InputHorizontalValue = positionIncrement;
    elseif ALIVE_InputKeyPress(ALIVE_Core_Keycodes_D) then
        ALIVE_Development_Freecam_InputHorizontalValue = -positionIncrement;
    else
        ALIVE_Development_Freecam_InputHorizontalValue = 0;
    end
    
    ------------------------------ZOOMING------------------------------
    --local fovIncrement = ALIVE_Development_Freecam_FovIncrement
    
    --if ALIVE_InputKeyPress(ALIVE_Core_Keycodes_LeftMouse) then
        --ALIVE_Development_Freecam_InputFieldOfViewAmount = ALIVE_Development_Freecam_InputFieldOfViewAmount - fovIncrement;
    --elseif ALIVE_InputKeyPress(ALIVE_Core_Keycodes_RightMouse) then
        --ALIVE_Development_Freecam_InputFieldOfViewAmount = ALIVE_Development_Freecam_InputFieldOfViewAmount + fovIncrement;
    --end
    
    ------------------------------MOUSELOOK------------------------------
    local currCursorPos = CursorGetPos()
    
    local minThreshold = 0.01
    local maxThreshold = 0.99
    
    --reset the cursor pos to the center of the screen when they get near the edges of the screen
    if (currCursorPos.x > maxThreshold) or (currCursorPos.x < minThreshold) or (currCursorPos.y > maxThreshold) or (currCursorPos.y < minThreshold) then
        CursorSetPos(Vector(0.5, 0.5, 0));
    end
    
    local xCursorDifference = currCursorPos.x - ALIVE_Development_Freecam_PrevCursorPos.x
    local yCursorDifference = currCursorPos.y - ALIVE_Development_Freecam_PrevCursorPos.y
    
    local sensitivity = 180.0
    ALIVE_Development_Freecam_InputMouseAmountX = ALIVE_Development_Freecam_InputMouseAmountX - (xCursorDifference * sensitivity)
    ALIVE_Development_Freecam_InputMouseAmountY = ALIVE_Development_Freecam_InputMouseAmountY + (yCursorDifference * sensitivity)

    local newRotation = Vector(ALIVE_Development_Freecam_InputMouseAmountY - 90, ALIVE_Development_Freecam_InputMouseAmountX, 0);
    
    if newRotation.x > 90 then
        newRotation.x = 90;
    elseif newRotation.x < -90 then
        newRotation.x = -90;
    end
    
    ------------------------------BUILD FINAL MOVEMENT/ROTATION------------------------------
    local newPosition = Vector(ALIVE_Development_Freecam_InputHorizontalValue, ALIVE_Development_Freecam_InputHeightValue, ALIVE_Development_Freecam_InputVerticalValue);

    if (ALIVE_Development_Freecam_SnappyMovement == true) then
        ALIVE_Development_Freecam_PrevCamPos = newPosition;
    else
        ALIVE_Development_Freecam_PrevCamPos = ALIVE_VectorLerp(ALIVE_Development_Freecam_PrevCamPos, newPosition, currFrameTime * ALIVE_Development_Freecam_PositionLerpFactor);
    end
    
    if (ALIVE_Development_Freecam_SnappyRotation == true) then
        ALIVE_Development_Freecam_PrevCamRot = newRotation;
    else
        ALIVE_Development_Freecam_PrevCamRot = ALIVE_VectorLerp(ALIVE_Development_Freecam_PrevCamRot, newRotation, currFrameTime * ALIVE_Development_Freecam_RotationLerpFactor);
    end
    
    ------------------------------ASSIGNMENT------------------------------
    local myCameraAgent = AgentFindInScene(ALIVE_Development_Freecam_CameraName, ALIVE_Development_SceneObject); --Agent type
    local result = AgentLocalToWorld(myCameraAgent, ALIVE_Development_Freecam_PrevCamPos);
    
    ALIVE_SetAgentPosition(ALIVE_Development_Freecam_CameraName, result, ALIVE_Development_SceneObject)
    ALIVE_SetAgentRotation(ALIVE_Development_Freecam_CameraName, ALIVE_Development_Freecam_PrevCamRot, ALIVE_Development_SceneObject)

    if (ALIVE_Development_FreecamUseFOVScale == true) then
        local fovScale = ALIVE_Development_Freecam_InputFieldOfViewAmount / 50.0;

        ALIVE_AgentSetProperty(ALIVE_Development_Freecam_CameraName, "Field of View Scale", fovScale, ALIVE_Development_SceneObject);
    else
        ALIVE_AgentSetProperty(ALIVE_Development_Freecam_CameraName, "Field of View", ALIVE_Development_Freecam_InputFieldOfViewAmount, ALIVE_Development_SceneObject);
    end

    ALIVE_Development_Freecam_PrevCursorPos = CursorGetPos();
    ALIVE_Development_Freecam_PrevTime = GetFrameTime();
end