-------------------------- PROPERTIES - OBJECT NAMES---------------------------
local thirdperson_name_camera = "Player_ThirdPersonCamera";
local thirdperson_name_groupCamera = "Player_ThirdPersonParentCamera";
local thirdperson_name_animGroupCamera = "Player_ThirdPersonAnimationParentCamera";
local thirdperson_name_desiredCameraPositionObject = "Player_ThirdPersonDesiredCameraObject";
local thirdperson_name_dummyObject = "Player_ThirdPersonDummyObject";
local thirdperson_sceneWbox = "adv_boardingSchoolExterior.wbox";

-------------------------- PROPERTIES - CAMERA ANIMATION --------------------------
local thirdperson_camera_currentCameraFOV = 80;
local thirdperson_camera_defaultFOV = 70;
local thirdperson_camera_runningFOV = 80;
local thirdperson_camera_bobbingX = 0.0;
local thirdperson_camera_bobbingXAmount_Walk = 0.15;
local thirdperson_camera_bobbingXSpeed_Walk = 6.5;
local thirdperson_camera_bobbingXAmount_Run = 0.25;
local thirdperson_camera_bobbingXSpeed_Run = 11.5;
local thirdperson_camera_desiredRotation = Vector(0.0, 0.0, 0.0);
local thirdperson_camera_localPosition = Vector(0,0,0);

-------------------------- PROPERTIES - INPUT --------------------------
local thirdperson_inputMouseAmountX = 0;
local thirdperson_inputMouseAmountY = 0;

-------------------------- PROPERTIES - CONTROLLER --------------------------
local thirdperson_prevCamPos = Vector(0,0,0);
local thirdperson_prevCamRot = Vector(0,0,0);
local thirdperson_prevCursorPos = Vector(0,0,0);
local thirdperson_cameraRotLerp = 5.0
local thirdperson_cameraPosLerp = 5.0

local thirdperson_frameTime = 0.0;

-------------------------- PROPERTIES - AGENTS --------------------------
--to reduce the amount of AgentFindInScene calls we make, which can be expensive
local thirdperson_agent_camera = nil;
local thirdperson_agent_cameraParent = nil;
local thirdperson_agent_cameraAnimParent = nil;
local thirdperson_agent_cameraDummy = nil;


local thirdperson_shared_agent_characterParent = nil;
local thirdperson_shared_movementVector = Vector(0, 0, 0);
local thirdperson_shared_state_dying = false;
local thirdperson_shared_state_zombieStation = false;
local thirdperson_shared_state_running = false;
local thirdperson_shared_state_moving = false;


local ThirdPerson_Camera_kScene = nil;

--|||||||||||||||||||||||||||||||||||||||||||||| THIRD PERSON CAMERA - UPDATE SHARED VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| THIRD PERSON CAMERA - UPDATE SHARED VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| THIRD PERSON CAMERA - UPDATE SHARED VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
ALIVE_Gameplay_Player_ThirdPerson_Camera_UpdateShared = function(playerMovementVector, playerStateDying, playerStateZombieStation, playerStateRunning, playerStateMoving)

    thirdperson_shared_state_dying = playerStateDying;
    thirdperson_shared_state_zombieStation = playerStateZombieStation;
    thirdperson_shared_state_running = playerStateRunning;
    thirdperson_shared_state_moving = playerStateMoving;

    thirdperson_shared_movementVector = playerMovementVector;

end

--|||||||||||||||||||||||||||||||||||||||||||||| THIRD PERSON CAMERA - CREATE CAMERA ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| THIRD PERSON CAMERA - CREATE CAMERA ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| THIRD PERSON CAMERA - CREATE CAMERA ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Gameplay_Player_ThirdPerson_Camera_CreateCamera = function(kScene, targetAgent)
    ThirdPerson_Camera_kScene = kScene;
    thirdperson_shared_agent_characterParent = targetAgent;

    -----------------------------------------------
    local cam_prop = "module_camera.prop";
    local group_prop = "group.prop";

    local cameraAgent = AgentCreate(thirdperson_name_camera, cam_prop, Vector(0,5,0), Vector(0,0,0), ThirdPerson_Camera_kScene, false, false);
    local cameraParentAgent = AgentCreate(thirdperson_name_groupCamera, group_prop, Vector(0,0,0), Vector(0,0,0), ThirdPerson_Camera_kScene, false, false);
    local cameraAnimParentAgent = AgentCreate(thirdperson_name_animGroupCamera, group_prop, Vector(0,0,0), Vector(0,0,0), ThirdPerson_Camera_kScene, false, false);
    local cameraDummyAgent = AgentCreate(thirdperson_name_dummyObject, group_prop, Vector(0,0,0), Vector(0,0,0), ThirdPerson_Camera_kScene, false, false);
    local cameraDesiredPositionAgent = AgentCreate(thirdperson_name_desiredCameraPositionObject, group_prop, Vector(0,0,0), Vector(0,0,0), ThirdPerson_Camera_kScene, false, false);

    AgentAttach(cameraAgent, cameraAnimParentAgent);
    AgentAttach(cameraDummyAgent, cameraAnimParentAgent);
    AgentAttach(cameraDesiredPositionAgent, cameraAnimParentAgent);
    AgentAttach(cameraAnimParentAgent, cameraParentAgent);

    ALIVE_AgentSetProperty(thirdperson_name_camera, "Clip Plane - Far", 1500, ThirdPerson_Camera_kScene);
    ALIVE_AgentSetProperty(thirdperson_name_camera, "Clip Plane - Near", 0.05, ThirdPerson_Camera_kScene);
    ALIVE_AgentSetProperty(thirdperson_name_camera, "Field Of View", 90, ThirdPerson_Camera_kScene);

    ALIVE_RemovingAgentsWithPrefix(ThirdPerson_Camera_kScene, "cam_");

    CameraPush(thirdperson_name_camera);

    -----------------------------------------------
    thirdperson_agent_camera = AgentFindInScene(thirdperson_name_camera, ThirdPerson_Camera_kScene); --Agent type
    thirdperson_agent_cameraParent = AgentFindInScene(thirdperson_name_groupCamera, ThirdPerson_Camera_kScene); --Agent type
    thirdperson_agent_cameraDummy = AgentFindInScene(thirdperson_name_dummyObject, ThirdPerson_Camera_kScene); --Agent type

    ALIVE_AgentSetProperty(ThirdPerson_Camera_kScene .. ".scene", "Active Camera", thirdperson_agent_camera, ThirdPerson_Camera_kScene);
    ALIVE_AgentSetProperty(ThirdPerson_Camera_kScene .. ".scene", "Scene - Camera Idle", thirdperson_agent_camera, ThirdPerson_Camera_kScene);

    -----------------------------------------------
    Callback_OnPostUpdate:Add(ALIVE_Gameplay_Player_ThirdPerson_Camera_UpdateInput);
    Callback_OnPostUpdate:Add(ALIVE_Gameplay_Player_ThirdPerson_Camera_UpdateCamera);
    --Callback_OnPostUpdate:Add(ALIVE_Gameplay_Player_ThirdPerson_Camera_UpdateCameraAnimation);
end

--|||||||||||||||||||||||||||||||||||||||||||||| THIRD PERSON CAMERA - CAMERA INPUT ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| THIRD PERSON CAMERA - CAMERA INPUT ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| THIRD PERSON CAMERA - CAMERA INPUT ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Gameplay_Player_ThirdPerson_Camera_UpdateInput = function()
    local currCursorPos = CursorGetPos();
    
    --how close to the edges of the screen the cusor can be
    local minThreshold = 0.01;
    local maxThreshold = 0.99;
    
    --reset the cursor pos to the center of the screen when they get near the edges of the screen
    if (currCursorPos.x > maxThreshold) or (currCursorPos.x < minThreshold) or (currCursorPos.y > maxThreshold) or (currCursorPos.y < minThreshold) then
        CursorSetPos(Vector(0.5, 0.5, 0));
    end
    
    --get the delta (how fast they are moving the cusor)
    local xCursorDifference = currCursorPos.x - thirdperson_prevCursorPos.x;
    local yCursorDifference = currCursorPos.y - thirdperson_prevCursorPos.y;
    
    local sensitivity = 180.0;
    thirdperson_inputMouseAmountX = thirdperson_inputMouseAmountX - (xCursorDifference * sensitivity);
    thirdperson_inputMouseAmountY = thirdperson_inputMouseAmountY + (yCursorDifference * sensitivity);
end

--|||||||||||||||||||||||||||||||||||||||||||||| THIRD PERSON CAMERA - CAMERA UPDATE ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| THIRD PERSON CAMERA - CAMERA UPDATE ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| THIRD PERSON CAMERA - CAMERA UPDATE ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Gameplay_Player_ThirdPerson_Camera_UpdateCamera = function()
    --if (thirdperson_state_dying) then do return end end
    if(thirdperson_agent_characterParent == nil) then do return end end

    thirdperson_frameTime = GetFrameTime();

    local newRotation = Vector(thirdperson_inputMouseAmountY - 90, thirdperson_inputMouseAmountX, 0);
    newRotation.x = ALIVE_Clamp(newRotation.x, -90, 90);
    
    ------------------------------THIRD PERSON SHARED------------------------------
    local vector_character_position = AgentGetWorldPos(thirdperson_agent_characterParent); --Vector type
    local vector_character_forward = AgentGetForwardVec(thirdperson_agent_characterParent); --Vector type
    local vector_camera_worldRot = AgentGetWorldRot(thirdperson_agent_camera);
    
    ALIVE_SetAgentWorldRotation(thirdperson_name_dummyObject, Vector(0, vector_camera_worldRot.y, vector_camera_worldRot.z), ThirdPerson_Camera_kScene);

    --local flippedMovementVector = Vector(-thirdperson_movementVector.x, thirdperson_movementVector.y, thirdperson_movementVector.z);

    ------------------------------THIRD PERSON CAMERA------------------------------
    local camPosLerpFactor = thirdperson_cameraPosLerp;
    local camRotLerpFactor = thirdperson_cameraRotLerp;
    local localLerpPosFactor = 2.0;

    if (thirdperson_state_crouching) then
        if(thirdperson_state_moving) then
            vector_character_position = vector_character_position + Vector(-0.0, 0.6, 0.0);
            --thirdperson_camera_localPosition = ALIVE_VectorLerp(thirdperson_camera_localPosition, Vector(-0.25, 0.0, -1.0) + (flippedMovementVector * 0.1), thirdperson_frameTime * localLerpPosFactor);
            thirdperson_camera_localPosition = ALIVE_VectorLerp(thirdperson_camera_localPosition, Vector(-0.25, 0.0, -1.0), thirdperson_frameTime * localLerpPosFactor);
        else
            vector_character_position = vector_character_position + Vector(-0.0, 0.5, 0.0);
            thirdperson_camera_localPosition = ALIVE_VectorLerp(thirdperson_camera_localPosition, Vector(-0.25, 0.0, -0.9), thirdperson_frameTime * localLerpPosFactor);
        end
    else
        if (thirdperson_state_moving) then
            if(thirdperson_state_running) then
                vector_character_position = vector_character_position + Vector(-0.0, 0.95, 0.0);
                thirdperson_camera_localPosition = ALIVE_VectorLerp(thirdperson_camera_localPosition, Vector(-0.25, 0.0, -0.9), thirdperson_frameTime * localLerpPosFactor);
            else
                vector_character_position = vector_character_position + Vector(-0.0, 0.95, 0.0);
                thirdperson_camera_localPosition = ALIVE_VectorLerp(thirdperson_camera_localPosition, Vector(-0.25, 0.0, -0.9), thirdperson_frameTime * localLerpPosFactor);
            end
        else
            vector_character_position = vector_character_position + Vector(-0.0, 0.95, 0.0);
            thirdperson_camera_localPosition = ALIVE_VectorLerp(thirdperson_camera_localPosition, Vector(-0.25, 0.0, -0.9), thirdperson_frameTime * localLerpPosFactor);
        end
    end
    
    thirdperson_prevCamPos = ALIVE_VectorLerp(thirdperson_prevCamPos, vector_character_position, thirdperson_frameTime * camPosLerpFactor);
    thirdperson_prevCamRot = ALIVE_VectorLerp(thirdperson_prevCamRot, newRotation, thirdperson_frameTime * camRotLerpFactor);
    --thirdperson_prevCamPos = vector_character_position;
    --thirdperson_prevCamRot = newRotation;
    
    ALIVE_SetAgentPosition(thirdperson_name_desiredCameraPositionObject, thirdperson_camera_localPosition, ThirdPerson_Camera_kScene);
    ALIVE_SetAgentPosition(thirdperson_name_groupCamera, thirdperson_prevCamPos, ThirdPerson_Camera_kScene);
    ALIVE_SetAgentRotation(thirdperson_name_groupCamera, thirdperson_prevCamRot, ThirdPerson_Camera_kScene);

    local desiredCameraPositionAgent = AgentFindInScene(thirdperson_name_desiredCameraPositionObject, ThirdPerson_Camera_kScene);
    local desiredCameraWorldPosition = AgentGetWorldPos(desiredCameraPositionAgent);

    --ALIVE_SetAgentPosition(thirdperson_name_camera, thirdperson_camera_localPosition, ThirdPerson_Camera_kScene);
    --ALIVE_SetAgentWorldPosition(thirdperson_name_camera, desiredCameraWorldPosition, ThirdPerson_Camera_kScene);

    --if (thirdperson_constrainToWBOX) then
        --local checkPos = Vector(desiredCameraWorldPosition.x, vector_character_position.y, desiredCameraWorldPosition.y);
        --local cameraWorldPosOnWBOX = WalkBoxesPosOnWalkBoxes(checkPos, 0, thirdperson_sceneWbox, 1);
        --local finalLegalizedPosition = Vector(cameraWorldPosOnWBOX.x, desiredCameraWorldPosition.y, cameraWorldPosOnWBOX.z);

        --ALIVE_SetAgentWorldPosition(thirdperson_name_camera, finalLegalizedPosition, ThirdPerson_Camera_kScene);
        --ALIVE_SetAgentWorldPosition(thirdperson_name_camera, desiredCameraWorldPosition, ThirdPerson_Camera_kScene);
    --else
        ALIVE_SetAgentWorldPosition(thirdperson_name_camera, desiredCameraWorldPosition, ThirdPerson_Camera_kScene);
    --end

    ------------------------------STORE FOR NEXT FRAME------------------------------
    thirdperson_prevCursorPos = CursorGetPos();
end

--|||||||||||||||||||||||||||||||||||||||||||||| THIRD PERSON CAMERA - CAMERA ANIMATION UPDATE ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| THIRD PERSON CAMERA - CAMERA ANIMATION UPDATE ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| THIRD PERSON CAMERA - CAMERA ANIMATION UPDATE ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Gameplay_Player_ThirdPerson_Camera_UpdateCameraAnimation = function()
    if (thirdperson_state_dying) or (thirdperson_state_zombieStation) then do return end end

    ------------------------------FOV KICK------------------------------
    if (thirdperson_state_running) then
        thirdperson_camera_currentCameraFOV = ALIVE_NumberLerp(thirdperson_camera_currentCameraFOV, thirdperson_camera_runningFOV, thirdperson_frameTime * 2.5);
    else
        thirdperson_camera_currentCameraFOV = ALIVE_NumberLerp(thirdperson_camera_currentCameraFOV, thirdperson_camera_defaultFOV, thirdperson_frameTime * 2.5);
    end

    ALIVE_AgentSetProperty(thirdperson_name_camera, "Field Of View", thirdperson_camera_currentCameraFOV, ThirdPerson_Camera_kScene);

    ------------------------------CAMERA BOBBING------------------------------
    local newCamRotX = 0.0;

    if (thirdperson_state_moving) then
        if (thirdperson_state_running) then
            thirdperson_camera_bobbingX = thirdperson_camera_bobbingX + (thirdperson_frameTime * thirdperson_camera_bobbingXSpeed_Run);
            newCamRotX = math.sin(thirdperson_camera_bobbingX) * thirdperson_camera_bobbingXAmount_Run;
        else
            thirdperson_camera_bobbingX = thirdperson_camera_bobbingX + (thirdperson_frameTime * thirdperson_camera_bobbingXSpeed_Walk);
            newCamRotX = math.sin(thirdperson_camera_bobbingX) * thirdperson_camera_bobbingXAmount_Walk;
        end
    else
        thirdperson_camera_bobbingX = 0.0;
        newCamRotX = 0.0;
    end

    thirdperson_camera_desiredRotation = Vector(newCamRotX, thirdperson_camera_desiredRotation.y, thirdperson_camera_desiredRotation.z);

    ALIVE_SetAgentRotation(thirdperson_name_animGroupCamera, thirdperson_camera_desiredRotation, ThirdPerson_Camera_kScene);
end