--|||||||||||||||||||||||||||||||||||||||||||||| 3RD PERSON CONTROLLER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| 3RD PERSON CONTROLLER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| 3RD PERSON CONTROLLER ||||||||||||||||||||||||||||||||||||||||||||||

require("ALIVE_Gameplay_Player_ThirdPerson_Camera.lua")
require("ALIVE_Gameplay_Player_ThirdPerson_Character.lua")
require("ALIVE_Gameplay_Player_ThirdPerson_Death.lua")
require("ALIVE_Gameplay_Player_ThirdPerson_Zombat.lua")

-------------------------- PROPERTIES - OBJECT NAMES --------------------------
thirdperson_name_character = "AJ";
thirdperson_name_characterProp = "sk63_aj.prop";
thirdperson_name_characterParent = thirdperson_name_character .. "_Parent"; 
--thirdperson_name_camera = "Player_ThirdPersonCamera";
--thirdperson_name_groupCamera = "Player_ThirdPersonParentCamera";
--thirdperson_name_animGroupCamera = "Player_ThirdPersonAnimationParentCamera";
--thirdperson_name_desiredCameraPositionObject = "Player_ThirdPersonDesiredCameraObject";
--thirdperson_name_dummyObject = "Player_ThirdPersonDummyObject";
thirdperson_name_knife = "Player_KnifeObject";
thirdperson_sceneWbox = "adv_boardingSchoolExterior.wbox";

-------------------------- PROPERTIES - STATES --------------------------
thirdperson_state_moving = false;
thirdperson_state_running = false;
thirdperson_state_crouching = false;
thirdperson_state_zombieStation = false;
thirdperson_state_dying = false;

-------------------------- PROPERTIES - CHARACTER ANIMATION --------------------------
thirdperson_controller_anim_idle = nil;
thirdperson_controller_anim_walking = nil;
thirdperson_controller_anim_running = nil;
thirdperson_controller_anim_crouchIdle = nil;
thirdperson_controller_anim_crouchMoving = nil;
thirdperson_controller_anim_blinking = nil;
local thirdperson_controller_anim_idle_contribution = 0;
local thirdperson_controller_anim_walk_contribution = 0;
local thirdperson_controller_anim_running_contribution = 0;
local thirdperson_controller_anim_crouch_contribution = 0;
local thirdperson_controller_anim_crouchWalk_contribution = 0;

-------------------------- PROPERTIES - INPUT --------------------------
local thirdperson_inputHorizontalValue = 0;
local thirdperson_inputVerticalValue = 0;
local thirdperson_inputHeightValue = 0;
--local thirdperson_inputMouseAmountX = 0;
--local thirdperson_inputMouseAmountY = 0;

-------------------------- PROPERTIES - CONTROLLER --------------------------
--local thirdperson_prevCamPos = Vector(0,0,0);
--local thirdperson_prevCamRot = Vector(0,0,0);
--local thirdperson_prevCursorPos = Vector(0,0,0);
--local thirdperson_cameraRotLerp = 5.0
--local thirdperson_cameraPosLerp = 5.0
local thirdperson_characterDirection = Vector(0, 0, 0);
local thirdperson_characterOffset = Vector(0, 0, 0);
local thirdperson_movementVector = Vector(0,0,0);
local thirdperson_movementSpeed = 0.0;
local thirdperson_constrainToWBOX = false;

thirdperson_frameTime = 0.0;

-------------------------- PROPERTIES - AGENTS --------------------------
--to reduce the amount of AgentFindInScene calls we make, which can be expensive
thirdperson_agent_character = nil;
thirdperson_agent_characterParent = nil;
--thirdperson_agent_camera = nil;
--thirdperson_agent_cameraParent = nil;
--thirdperson_agent_cameraAnimParent = nil;
--thirdperson_agent_cameraDummy = nil;
thirdperson_agent_knife = nil;

--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER SETUP ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Gameplay_CreateThirdPersonController = function(startingPosition)
    -----------------------------------------------
    --local cam_prop = "module_camera.prop";
    local group_prop = "group.prop";

    --local cameraParentAgent = AgentCreate(thirdperson_name_groupCamera, group_prop, Vector(0,0,0), Vector(0,0,0), ThirdPerson_kScene, false, false);
    --local cameraAnimParentAgent = AgentCreate(thirdperson_name_animGroupCamera, group_prop, Vector(0,0,0), Vector(0,0,0), ThirdPerson_kScene, false, false);
    --local cameraDummyAgent = AgentCreate(thirdperson_name_dummyObject, group_prop, Vector(0,0,0), Vector(0,0,0), ThirdPerson_kScene, false, false);
    --local cameraDesiredPositionAgent = AgentCreate(thirdperson_name_desiredCameraPositionObject, group_prop, Vector(0,0,0), Vector(0,0,0), ThirdPerson_kScene, false, false);
    --local cameraAgent = AgentCreate(thirdperson_name_camera, cam_prop, Vector(0,0,0), Vector(0,0,0), ThirdPerson_kScene, false, false);

    --AgentAttach(cameraAgent, cameraAnimParentAgent);
    --AgentAttach(cameraDummyAgent, cameraAnimParentAgent);
    --AgentAttach(cameraDesiredPositionAgent, cameraAnimParentAgent);
    --AgentAttach(cameraAnimParentAgent, cameraParentAgent);

    --ALIVE_AgentSetProperty(thirdperson_name_camera, "Clip Plane - Far", 1500, ThirdPerson_kScene);
    --ALIVE_AgentSetProperty(thirdperson_name_camera, "Clip Plane - Near", 0.05, ThirdPerson_kScene);
    --ALIVE_AgentSetProperty(thirdperson_name_camera, "Field Of View", 90, ThirdPerson_kScene);

    --ALIVE_RemovingAgentsWithPrefix(ThirdPerson_kScene, "cam_");

    --CameraPush(thirdperson_name_camera);
    
    -----------------------------------------------
    local agent_character = AgentFindInScene(thirdperson_name_character, ThirdPerson_kScene);

    if (agent_character == nil) then
        agent_character = AgentCreate(thirdperson_name_character, thirdperson_name_characterProp, Vector(0,0,0), Vector(0,0,0), ThirdPerson_kScene, false, false);
    end

    local agent_characterGroup = AgentCreate(thirdperson_name_characterParent, group_prop, Vector(0,0,0), Vector(0,0,0), ThirdPerson_kScene, false, false);
    
    AgentAttach(agent_character, agent_characterGroup);
    
    ALIVE_SetAgentWorldPosition(thirdperson_name_character, Vector(0, 0, 0), ThirdPerson_kScene);
    ALIVE_SetAgentWorldRotation(thirdperson_name_character, Vector(0, 0, 0), ThirdPerson_kScene);
    -----------------------------------------------
    --local knife_prop = "obj_knifeAJ.prop";
    --local knife_prop = "obj_knifePallette.prop";
    --local knife_prop = "obj_knifeTenn.prop";
    local knife_prop = "obj_knifeKaBar.prop";

    local knifeAgent = AgentCreate(thirdperson_name_knife, knife_prop, Vector(0,0,0), Vector(0,0,0), ThirdPerson_kScene, false, false);
    ALIVE_AgentSetProperty(thirdperson_name_knife, "Render Global Scale", 2, ThirdPerson_kScene);
    ALIVE_AgentSetProperty(thirdperson_name_knife, "Render Cull", false, ThirdPerson_kScene);
    ALIVE_AgentSetProperty(thirdperson_name_knife, "Runtime: Visible", true, ThirdPerson_kScene);

    --spine3
    --wrist_L
    --wrist_R
    local nodeName = "wrist_L";

    --ALIVE_PrintValidNodeNames(agent_character);

    if AgentHasNode(agent_character, nodeName) then
        AgentAttachToNode(agent_character, knifeAgent, nodeName);

        AgentSetPos(knifeAgent, Vector(-0.175, -0.045, 0.111));
        AgentSetRot(knifeAgent, Vector(-15, -49, 65));
    end

    -----------------------------------------------
    local controllersTable_character = AgentGetControllers(agent_character);
    
    for i, cnt in ipairs(controllersTable_character) do
        ControllerKill(cnt);
    end
    
    -----------------------------------------------
    thirdperson_controller_anim_idle = PlayAnimation(agent_character, "sk63_idle_ajStandA.anm");
    thirdperson_controller_anim_walking = PlayAnimation(agent_character, "sk63_aj_walk.anm");
    thirdperson_controller_anim_running = PlayAnimation(agent_character, "sk63_aj_run.anm");
    thirdperson_controller_anim_crouchIdle = PlayAnimation(agent_character, "sk63_idle_ajCrouch.anm");
    thirdperson_controller_anim_crouchMoving = PlayAnimation(agent_character, "sk62_clementine400_crouchWalk.anm");

    --local testing = PlayAnimation(agent_character, "sk62_idle_clementineHoldKnifeReady.anm");
    --ControllerSetPriority(testing, 200);
    --ControllerSetLooping(testing, true);

    --thirdperson_controller_anim_idle = PlayAnimation(agent_character, "sk62_idle_clementine400StandAHoldKnife.anm");
    --thirdperson_controller_anim_idle = PlayAnimation(agent_character, "sk62_idle_clementineHoldKnifeReady.anm");
    --thirdperson_controller_anim_walking = PlayAnimation(agent_character, "sk63_aj_walk.anm");
    --thirdperson_controller_anim_running = PlayAnimation(agent_character, "sk62_clementine400_runHoldPackKnife.anm");
    --thirdperson_controller_anim_crouchIdle = PlayAnimation(agent_character, "sk63_idle_ajCrouch.anm");
    --thirdperson_controller_anim_crouchMoving = PlayAnimation(agent_character, "sk62_clementine400_crouchWalk.anm");
    
    ControllerSetLooping(thirdperson_controller_anim_idle, true);
    ControllerSetLooping(thirdperson_controller_anim_walking, true);
    ControllerSetLooping(thirdperson_controller_anim_running, true);
    ControllerSetLooping(thirdperson_controller_anim_crouchIdle, true);
    ControllerSetLooping(thirdperson_controller_anim_crouchMoving, true);
    
    ControllerSetPriority(thirdperson_controller_anim_idle, 100);
    ControllerSetPriority(thirdperson_controller_anim_crouchIdle, 100);
    ControllerSetPriority(thirdperson_controller_anim_walking, 100);
    ControllerSetPriority(thirdperson_controller_anim_crouchMoving, 100);
    ControllerSetPriority(thirdperson_controller_anim_running, 100);
    
    ALIVE_SetAgentWorldPosition(thirdperson_name_characterParent, startingPosition, ThirdPerson_kScene);

    -----------------------------------------------

    --thirdperson_agent_camera = AgentFindInScene(thirdperson_name_camera, ThirdPerson_kScene); --Agent type
    --thirdperson_agent_cameraParent = AgentFindInScene(thirdperson_name_groupCamera, ThirdPerson_kScene); --Agent type
    --thirdperson_agent_cameraDummy = AgentFindInScene(thirdperson_name_dummyObject, ThirdPerson_kScene); --Agent type
    thirdperson_agent_character = AgentFindInScene(thirdperson_name_character, ThirdPerson_kScene); --Agent type
    thirdperson_agent_characterParent = AgentFindInScene(thirdperson_name_characterParent, ThirdPerson_kScene); --Agent type
    thirdperson_agent_knife = AgentFindInScene(thirdperson_name_knife, ThirdPerson_kScene); --Agent type

    --ALIVE_AgentSetProperty(ThirdPerson_kScene .. ".scene", "Active Camera", thirdperson_agent_camera, ThirdPerson_kScene);
    --ALIVE_AgentSetProperty(ThirdPerson_kScene .. ".scene", "Scene - Camera Idle", thirdperson_agent_camera, ThirdPerson_kScene);

    -----------------------------------------------
    ALIVE_Gameplay_Player_ThirdPerson_Camera_CreateCamera(ThirdPerson_kScene, thirdperson_agent_characterParent);

    Callback_OnPostUpdate:Add(ALIVE_Gameplay_Player_ThirdPerson_Camera_UpdateInput);
    Callback_OnPostUpdate:Add(ALIVE_Gameplay_Player_ThirdPerson_Camera_UpdateCamera);
    Callback_OnPostUpdate:Add(ALIVE_Gameplay_Player_ThirdPerson_Camera_UpdateCameraAnimation);


    Callback_OnPostUpdate:Add(ALIVE_Gameplay_UpdateThirdPerson_Input);
    --Callback_OnPostUpdate:Add(ALIVE_Gameplay_UpdateThirdPerson_Camera);
    --Callback_OnPostUpdate:Add(ALIVE_Gameplay_UpdateThirdPerson_CameraAnimation);
    Callback_OnPostUpdate:Add(ALIVE_Gameplay_UpdateThirdPerson_Character);
    Callback_OnPostUpdate:Add(ALIVE_Gameplay_UpdateThirdPerson_CharacterAnimation);
    Callback_OnPostUpdate:Add(ALIVE_Gameplay_UpdateThirdPerson_Zombat_SetZombieStation);
    Callback_OnPostUpdate:Add(ALIVE_Gameplay_UpdateThirdPerson_Zombat_Main);
    Callback_OnPostUpdate:Add(ALIVE_Gameplay_UpdateThirdPerson_Death_Main);
end

--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - INPUT ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - INPUT ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - INPUT ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Gameplay_UpdateThirdPerson_Input = function()
    thirdperson_frameTime = GetFrameTime();

    ------------------------------INPUT------------------------------
    local key_moveForward = Input_IsVKeyPressed(87); --key w
    local key_moveBackward = Input_IsVKeyPressed(83); --key s
    local key_moveLeft = Input_IsVKeyPressed(65); --key a
    local key_moveRight = Input_IsVKeyPressed(68); --key d
    local key_running = Input_IsVKeyPressed(16); --key shift
    local key_crouch1 = Input_IsVKeyPressed(67); --key c
    local key_crouch2 = Input_IsVKeyPressed(17); --key ctrl

    ------------------------------MOVEMENT------------------------------
    local walkSpeed = 0.013;
    local crouchWalkSpeed = 0.01;
    local runSpeed = 0.06;
    thirdperson_movementSpeed = walkSpeed;
    
    --moving
    if key_moveForward or key_moveBackward or key_moveLeft or key_moveRight then
        thirdperson_state_moving = true;
    else
        thirdperson_state_moving = false;
    end

    --crouching
    if key_crouch1 or key_crouch2 then
        thirdperson_state_crouching = true;
    else
        thirdperson_state_crouching = false;
    end
    
    --running (can only run if we are not crouching and we are moving)
    if (thirdperson_state_crouching == false) and (thirdperson_state_moving == true) then
        if key_running then
            thirdperson_state_running = true;
            thirdperson_movementSpeed = runSpeed;
        else
            thirdperson_state_running = false;
            thirdperson_movementSpeed = walkSpeed;
        end
    else
        thirdperson_state_running = false;
        thirdperson_movementSpeed = crouchWalkSpeed;
    end

    local movementVector_x = 0.0;
    local movementVector_y = 0.0;
    local movementVector_z = 0.0;

    if key_moveForward then
        movementVector_z = 1.0;
    elseif key_moveBackward then
        movementVector_z = -1.0;
    end
    
    if key_moveLeft then
        movementVector_x = -1.0;
    elseif key_moveRight then
        movementVector_x = 1.0;
    end
    
    thirdperson_movementVector = Vector(movementVector_x, movementVector_y, movementVector_z);

    ------------------------------MOUSELOOK------------------------------
    --local currCursorPos = CursorGetPos();
    
    --how close to the edges of the screen the cusor can be
    --local minThreshold = 0.01;
    --local maxThreshold = 0.99;
    
    --reset the cursor pos to the center of the screen when they get near the edges of the screen
    --if (currCursorPos.x > maxThreshold) or (currCursorPos.x < minThreshold) or (currCursorPos.y > maxThreshold) or (currCursorPos.y < minThreshold) then
        --CursorSetPos(Vector(0.5, 0.5, 0));
    --end
    
    --get the delta (how fast they are moving the cusor)
    --local xCursorDifference = currCursorPos.x - thirdperson_prevCursorPos.x;
    --local yCursorDifference = currCursorPos.y - thirdperson_prevCursorPos.y;
    
    --local sensitivity = 180.0;
    --thirdperson_inputMouseAmountX = thirdperson_inputMouseAmountX - (xCursorDifference * sensitivity);
    --thirdperson_inputMouseAmountY = thirdperson_inputMouseAmountY + (yCursorDifference * sensitivity);
end

--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CAMERA ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CAMERA ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CAMERA ||||||||||||||||||||||||||||||||||||||||||||||
--[[
ALIVE_Gameplay_UpdateThirdPerson_Camera = function()
    if (thirdperson_state_dying) then do return end end

    local newRotation = Vector(thirdperson_inputMouseAmountY - 90, thirdperson_inputMouseAmountX, 0);
    newRotation.x = ALIVE_Clamp(newRotation.x, -90, 90);
    
    ------------------------------THIRD PERSON SHARED------------------------------
    local vector_character_position = AgentGetWorldPos(thirdperson_agent_characterParent); --Vector type
    local vector_character_forward = AgentGetForwardVec(thirdperson_agent_characterParent); --Vector type

    local vector_camera_worldRot = AgentGetWorldRot(thirdperson_agent_camera);
    
    ALIVE_SetAgentWorldRotation(thirdperson_name_dummyObject, Vector(0, vector_camera_worldRot.y, vector_camera_worldRot.z), ThirdPerson_kScene);

    local flippedMovementVector = Vector(-thirdperson_movementVector.x, thirdperson_movementVector.y, thirdperson_movementVector.z);

    ------------------------------THIRD PERSON CAMERA------------------------------
    local camPosLerpFactor = thirdperson_cameraPosLerp;
    local camRotLerpFactor = thirdperson_cameraRotLerp;
    local localLerpPosFactor = 2.0;

    if (thirdperson_state_crouching) then
        if(thirdperson_state_moving) then
            vector_character_position = vector_character_position + Vector(-0.0, 0.6, 0.0);
            thirdperson_camera_localPosition = ALIVE_VectorLerp(thirdperson_camera_localPosition, Vector(-0.25, 0.0, -1.0) + (flippedMovementVector * 0.1), thirdperson_frameTime * localLerpPosFactor);
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
    
    ALIVE_SetAgentPosition(thirdperson_name_desiredCameraPositionObject, thirdperson_camera_localPosition, ThirdPerson_kScene);
    ALIVE_SetAgentPosition(thirdperson_name_groupCamera, thirdperson_prevCamPos, ThirdPerson_kScene);
    ALIVE_SetAgentRotation(thirdperson_name_groupCamera, thirdperson_prevCamRot, ThirdPerson_kScene);

    local desiredCameraPositionAgent = AgentFindInScene(thirdperson_name_desiredCameraPositionObject, ThirdPerson_kScene);
    local desiredCameraWorldPosition = AgentGetWorldPos(desiredCameraPositionAgent);

    --ALIVE_SetAgentPosition(thirdperson_name_camera, thirdperson_camera_localPosition, ThirdPerson_kScene);
    --ALIVE_SetAgentWorldPosition(thirdperson_name_camera, desiredCameraWorldPosition, ThirdPerson_kScene);

    if (thirdperson_constrainToWBOX) then
        --local checkPos = Vector(desiredCameraWorldPosition.x, vector_character_position.y, desiredCameraWorldPosition.y);
        --local cameraWorldPosOnWBOX = WalkBoxesPosOnWalkBoxes(checkPos, 0, thirdperson_sceneWbox, 1);
        --local finalLegalizedPosition = Vector(cameraWorldPosOnWBOX.x, desiredCameraWorldPosition.y, cameraWorldPosOnWBOX.z);

        --ALIVE_SetAgentWorldPosition(thirdperson_name_camera, finalLegalizedPosition, ThirdPerson_kScene);
        ALIVE_SetAgentWorldPosition(thirdperson_name_camera, desiredCameraWorldPosition, ThirdPerson_kScene);
    else
        ALIVE_SetAgentWorldPosition(thirdperson_name_camera, desiredCameraWorldPosition, ThirdPerson_kScene);
    end

    ------------------------------STORE FOR NEXT FRAME------------------------------
    thirdperson_prevCursorPos = CursorGetPos();
end
]]--
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CHARACTER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CHARACTER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CHARACTER ||||||||||||||||||||||||||||||||||||||||||||||

local prevFinalPlayerMovement = Vector(0,0,0);

ALIVE_Gameplay_UpdateThirdPerson_Character = function()
    if (thirdperson_state_dying) or (thirdperson_state_zombieStation) then do return end end

    thirdperson_agent_cameraDummy = AgentFindInScene(thirdperson_name_dummyObject, ThirdPerson_kScene);
    --local newRotation = Vector(thirdperson_inputMouseAmountY - 90, thirdperson_inputMouseAmountX, 0);
    --newRotation.x = ALIVE_Clamp(newRotation.x, -90, 90);
    
    ------------------------------THIRD PERSON SHARED------------------------------
    local vector_character_position = AgentGetWorldPos(thirdperson_agent_characterParent); --Vector type
    local vector_character_forward = AgentGetForwardVec(thirdperson_agent_characterParent); --Vector type

    ------------------------------THIRD PERSON MOVEMENT------------------------------
    local vector_camera_right = AgentGetRightVec(thirdperson_agent_cameraDummy, true); --Vector type
    local vector_camera_forward = AgentGetForwardVec(thirdperson_agent_cameraDummy, true); --Vector type
    vector_camera_forward = vector_camera_forward + Vector(0, 0);
    
    vector_camera_right = VectorScale(vector_camera_right, thirdperson_movementVector.x);
    vector_camera_forward = VectorScale(vector_camera_forward, thirdperson_movementVector.z);
    local finalPlayerMovement = VectorAdd(vector_camera_right, vector_camera_forward);
    finalPlayerMovement.y = 0;

    local flippedMovementVector = Vector(-thirdperson_movementVector.x, thirdperson_movementVector.y, thirdperson_movementVector.z);

    if (thirdperson_state_moving) then
        local newDirection = AgentLocalToWorld(thirdperson_agent_cameraDummy, flippedMovementVector * 10.0);

        local directionLerpFactor = 5.0;

        thirdperson_characterDirection = ALIVE_VectorLerp(thirdperson_characterDirection, newDirection, thirdperson_frameTime * directionLerpFactor);
    end
    
    local newCharacterPosition = AgentGetWorldPos(thirdperson_agent_characterParent);
    finalPlayerMovement = VectorScale(finalPlayerMovement, thirdperson_movementSpeed);

    if (thirdperson_state_running) then
        prevFinalPlayerMovement = ALIVE_VectorLerp(prevFinalPlayerMovement, finalPlayerMovement, thirdperson_frameTime * 2.0);
    else
        prevFinalPlayerMovement = ALIVE_VectorLerp(prevFinalPlayerMovement, finalPlayerMovement, thirdperson_frameTime * 7.5);
    end

    --local lockedPos = VectorScale(Vector(0,0,1), AgentGetForwardAnimVelocity(thirdperson_agent_character));
    local lockedPos = VectorScale(Vector(0,0,0), AgentGetForwardAnimVelocity(thirdperson_agent_character));

    --newCharacterPosition = newCharacterPosition + finalPlayerMovement;
    newCharacterPosition = newCharacterPosition + prevFinalPlayerMovement;

    if (thirdperson_constrainToWBOX) then
        newCharacterPosition = WalkBoxesPosOnWalkBoxes(newCharacterPosition, 0, thirdperson_sceneWbox, 1);
    end

    thirdperson_characterDirection.y = newCharacterPosition.y;

    ALIVE_SetAgentPosition(thirdperson_name_character, lockedPos, ThirdPerson_kScene);
    ALIVE_SetAgentPosition(thirdperson_name_characterParent, newCharacterPosition, ThirdPerson_kScene);

    AgentFacePos(thirdperson_agent_character, thirdperson_characterDirection);

    ------------------------------STORE FOR NEXT FRAME------------------------------
end


--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CHARACTER ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CHARACTER ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CHARACTER ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||

local PlayBlinkAnimation = function()
    --thirdperson_controller_anim_blinking = ALIVE_ChorePlayOnAgent("aJ_face_blink.chore", agent_character, nil, nil);
    --thirdperson_controller_anim_blinking = PlayAnimation(agent_character, "wd400GM_face_eyesClosed_add.anm");
    --thirdperson_controller_anim_blinking = PlayAnimation(agent_character, "aj_face_eyesClosed.anm");
    thirdperson_controller_anim_blinking = PlayAnimation(thirdperson_agent_character, "aj_face_eyesClosed_add.anm");
    ControllerSetLooping(thirdperson_controller_anim_blinking, false);
    ControllerSetPriority(thirdperson_controller_anim_blinking, 100);
end

local ajBlinkTick = 0;
local ajBlinkMaxTick = 120;

ALIVE_Gameplay_UpdateThirdPerson_CharacterAnimation = function()
    local animationFadeTime = 7.5;

    if (thirdperson_state_dying) or (thirdperson_state_zombieStation) then 
        ControllerSetContribution(thirdperson_controller_anim_idle, 0);
        ControllerSetContribution(thirdperson_controller_anim_walking, 0);
        ControllerSetContribution(thirdperson_controller_anim_running, 0);
        ControllerSetContribution(thirdperson_controller_anim_crouchIdle, 0);
        ControllerSetContribution(thirdperson_controller_anim_crouchMoving, 0);
        
        do return end 
    end

    local idle_contribution_target = 1;
    local walk_contribution_target = 0;
    local running_contribution_target = 0;
    local crouch_contribution_target = 0;
    local crouchWalk_contribution_target = 0;
    
    if (thirdperson_state_moving) then
        if (thirdperson_state_running) then
            idle_contribution_target = 0;
            walk_contribution_target = 0;
            running_contribution_target = 1;
            crouch_contribution_target = 0;
            crouchWalk_contribution_target = 0;
        else
            if(thirdperson_state_crouching) then
                idle_contribution_target = 0;
                walk_contribution_target = 0;
                running_contribution_target = 0;
                crouch_contribution_target = 0;
                crouchWalk_contribution_target = 1;
            else
                idle_contribution_target = 0;
                walk_contribution_target = 1;
                running_contribution_target = 0;
                crouch_contribution_target = 0;
                crouchWalk_contribution_target = 0;
            end
        end
    else
        if (thirdperson_state_crouching) then
            idle_contribution_target = 0;
            walk_contribution_target = 0;
            running_contribution_target = 0;
            crouch_contribution_target = 1;
            crouchWalk_contribution_target = 0;
        else
            idle_contribution_target = 1;
            walk_contribution_target = 0;
            running_contribution_target = 0;
            crouch_contribution_target = 0;
            crouchWalk_contribution_target = 0;
        end
    end

    thirdperson_controller_anim_idle_contribution = ALIVE_NumberLerp(thirdperson_controller_anim_idle_contribution, idle_contribution_target, thirdperson_frameTime * animationFadeTime);
    thirdperson_controller_anim_walk_contribution = ALIVE_NumberLerp(thirdperson_controller_anim_walk_contribution, walk_contribution_target, thirdperson_frameTime * animationFadeTime);
    thirdperson_controller_anim_running_contribution = ALIVE_NumberLerp(thirdperson_controller_anim_running_contribution, running_contribution_target, thirdperson_frameTime * animationFadeTime);
    thirdperson_controller_anim_crouch_contribution = ALIVE_NumberLerp(thirdperson_controller_anim_crouch_contribution, crouch_contribution_target, thirdperson_frameTime * animationFadeTime);
    thirdperson_controller_anim_crouchWalk_contribution = ALIVE_NumberLerp(thirdperson_controller_anim_crouchWalk_contribution, crouchWalk_contribution_target, thirdperson_frameTime * animationFadeTime);

    ControllerSetContribution(thirdperson_controller_anim_idle, thirdperson_controller_anim_idle_contribution);
    ControllerSetContribution(thirdperson_controller_anim_walking, thirdperson_controller_anim_walk_contribution);
    ControllerSetContribution(thirdperson_controller_anim_running, thirdperson_controller_anim_running_contribution);
    ControllerSetContribution(thirdperson_controller_anim_crouchIdle, thirdperson_controller_anim_crouch_contribution);
    ControllerSetContribution(thirdperson_controller_anim_crouchMoving, thirdperson_controller_anim_crouchWalk_contribution);

    ajBlinkTick = ajBlinkTick + 1;

    if (ajBlinkTick > ajBlinkMaxTick) then
        PlayBlinkAnimation();
        ajBlinkTick = 0;
    end
end

--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CAMERA ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CAMERA ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CAMERA ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||
--[[
ALIVE_Gameplay_UpdateThirdPerson_CameraAnimation = function()
    if (thirdperson_state_dying) or (thirdperson_state_zombieStation) then do return end end

    ------------------------------FOV KICK------------------------------
    if (thirdperson_state_running) then
        thirdperson_camera_currentCameraFOV = ALIVE_NumberLerp(thirdperson_camera_currentCameraFOV, thirdperson_camera_runningFOV, thirdperson_frameTime * 2.5);
    else
        thirdperson_camera_currentCameraFOV = ALIVE_NumberLerp(thirdperson_camera_currentCameraFOV, thirdperson_camera_defaultFOV, thirdperson_frameTime * 2.5);
    end

    ALIVE_AgentSetProperty(thirdperson_name_camera, "Field Of View", thirdperson_camera_currentCameraFOV, ThirdPerson_kScene);

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

    ALIVE_SetAgentRotation(thirdperson_name_animGroupCamera, thirdperson_camera_desiredRotation, ThirdPerson_kScene);
end
]]--




local currentStationedZombieObject = nil;

ALIVE_Gameplay_UpdateThirdPerson_Zombat_SetZombieStation = function()
    for i = 1, #ALIVE_Gameplay_AI_ZombiesArray do
        local zombieObject = ALIVE_Gameplay_AI_ZombiesArray[i];

        local zombieObject_state_stationedWithPlayer = zombieObject[zombie_state_stationedWithPlayer];

        if (zombieObject_state_stationedWithPlayer == true) then
            currentStationedZombieObject = zombieObject;
            thirdperson_state_zombieStation = true;
        end
    end
end

ALIVE_Gameplay_UpdateThirdPerson_Zombat_Main = function()
    if (currentStationedZombieObject == nil) then do return end end

    local zombieObject_agent = zombieObject[zombie_agent];
    local zombieObject_agentParent = zombieObject[zombie_agent_parent];
    local zombieObject_agentName = zombieObject[zombie_agent_name];
    local zombieObject_agentParentName = zombieObject[zombie_agent_parent_name];
    local zombieObject_agentTargetName = zombieObject[zombie_agent_target_name];
    local zombieObject_distanceStop = zombieObject[zombie_distance_stopping];
    local zombieObject_distanceStopTeam = zombieObject[zombie_distance_stoppingTeam];
    local zombieObject_walkSpeed = zombieObject[zombie_profile_walk];
    local zombieObject_state_stationedWithPlayer = zombieObject[zombie_state_stationedWithPlayer];

    AgentSetWorldPos(zombieObject_agentParent, Vector(0, 5, 0));
    AgentSetWorldPos(thirdperson_agent_characterParent, Vector(0, 5, 0));
end