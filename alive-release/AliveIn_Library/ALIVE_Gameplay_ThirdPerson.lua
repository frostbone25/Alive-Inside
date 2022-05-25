--|||||||||||||||||||||||||||||||||||||||||||||| 3RD PERSON CONTROLLER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| 3RD PERSON CONTROLLER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| 3RD PERSON CONTROLLER ||||||||||||||||||||||||||||||||||||||||||||||

-------------------------- PROPERTIES - OBJECT NAMES --------------------------
local thirdperson_name_character = "AJ";
local thirdperson_name_characterProp = "sk63_aj.prop";
local thirdperson_name_characterParent = thirdperson_name_character .. "_Parent";
local thirdperson_name_camera = "Player_ThirdPersonCamera";
local thirdperson_name_groupCamera = "Player_ThirdPersonParentCamera";
local thirdperson_name_animGroupCamera = "Player_ThirdPersonAnimationParentCamera";
local thirdperson_name_dummyObject = "Player_ThirdPersonDummyObject";
local thirdperson_sceneWbox = "adv_boardingSchoolExterior.wbox";

-------------------------- PROPERTIES - CHARACTER ANIMATION --------------------------
local thirdperson_controller_anim_idle = nil;
local thirdperson_controller_anim_walking = nil;
local thirdperson_controller_anim_running = nil;
local thirdperson_controller_anim_crouchIdle = nil;
local thirdperson_controller_anim_crouchMoving = nil;
local thirdperson_controller_anim_idle_contribution = 0;
local thirdperson_controller_anim_walk_contribution = 0;
local thirdperson_controller_anim_running_contribution = 0;
local thirdperson_controller_anim_crouch_contribution = 0;
local thirdperson_controller_anim_crouchWalk_contribution = 0;

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
local thirdperson_inputHorizontalValue = 0;
local thirdperson_inputVerticalValue = 0;
local thirdperson_inputHeightValue = 0;
local thirdperson_inputMouseAmountX = 0;
local thirdperson_inputMouseAmountY = 0;

-------------------------- PROPERTIES - CONTROLLER --------------------------
local thirdperson_prevCamPos = Vector(0,0,0);
local thirdperson_prevCamRot = Vector(0,0,0);
local thirdperson_prevCursorPos = Vector(0,0,0);
local thirdperson_cameraRotLerp = 5.0
local thirdperson_cameraPosLerp = 5.0
local thirdperson_characterDirection = Vector(0, 0, 0);
local thirdperson_characterOffset = Vector(0, 0, 0);
local thirdperson_movementVector = Vector(0,0,0);
local thirdperson_movementSpeed = 0.0;
local thirdperson_constrainToWBOX = true;

-------------------------- PROPERTIES - STATES --------------------------
local thirdperson_state_moving = false;
local thirdperson_state_running = false;
local thirdperson_state_crouching = false;

--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER SETUP ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Gameplay_CreateThirdPersonController = function(findExistingCharacter)
    -----------------------------------------------
    local cam_prop = "module_camera.prop";
    local group_prop = "group.prop";

    local cameraParentAgent = AgentCreate(thirdperson_name_groupCamera, group_prop, Vector(0,0,0), Vector(0,0,0), ThirdPerson_kScene, false, false);
    local cameraAnimParentAgent = AgentCreate(thirdperson_name_animGroupCamera, group_prop, Vector(0,0,0), Vector(0,0,0), ThirdPerson_kScene, false, false);
    local cameraDummyAgent = AgentCreate(thirdperson_name_dummyObject, group_prop, Vector(0,0,0), Vector(0,0,0), ThirdPerson_kScene, false, false);
    local cameraAgent = AgentCreate(thirdperson_name_camera, cam_prop, Vector(0,0,0), Vector(0,0,0), ThirdPerson_kScene, false, false);

    AgentAttach(cameraAgent, cameraAnimParentAgent);
    AgentAttach(cameraDummyAgent, cameraAnimParentAgent);
    AgentAttach(cameraAnimParentAgent, cameraParentAgent);

    ALIVE_AgentSetProperty(thirdperson_name_camera, "Clip Plane - Far", 1500, ThirdPerson_kScene);
    ALIVE_AgentSetProperty(thirdperson_name_camera, "Clip Plane - Near", 0.05, ThirdPerson_kScene);
    ALIVE_AgentSetProperty(thirdperson_name_camera, "Field Of View", 90, ThirdPerson_kScene);

    ALIVE_RemovingAgentsWithPrefix(ThirdPerson_kScene, "cam_");

    CameraPush(thirdperson_name_camera);
    
    -----------------------------------------------
    local agent_character = nil;

    if (findExistingCharacter) then
        agent_character = AgentFindInScene(thirdperson_name_character, ThirdPerson_kScene);
    else
        agent_character = AgentCreate(thirdperson_name_character, thirdperson_name_characterProp, Vector(0,0,0), Vector(0,0,0), ThirdPerson_kScene, false, false);
    end

    local agent_characterGroup = AgentCreate(thirdperson_name_characterParent, group_prop, Vector(0,0,0), Vector(0,0,0), ThirdPerson_kScene, false, false);
    
    AgentAttach(agent_character, agent_characterGroup);
    
    ALIVE_SetAgentWorldPosition(thirdperson_name_character, Vector(0, 0, 0), ThirdPerson_kScene);
    ALIVE_SetAgentWorldRotation(thirdperson_name_character, Vector(0, 0, 0), ThirdPerson_kScene);
    
    -----------------------------------------------
    local controllersTable_aj = AgentGetControllers(agent_character);
    
    for i, cnt in ipairs(controllersTable_aj) do
        ControllerKill(cnt);
    end
    
    -----------------------------------------------
    thirdperson_controller_anim_idle = PlayAnimation(agent_character, "sk63_idle_ajStandA.anm");
    --thirdperson_controller_anim_idle = PlayAnimation(agent_character, "sk61_action_louisJumpGap.anm");
    --thirdperson_controller_anim_idle = PlayAnimation(agent_character, "sk61_action_batmanJumpDownOneStoryToCatwoman.anm");
    --thirdperson_controller_anim_idle = PlayAnimation(agent_character, "sk61_action_javierJumpDownLedge.anm");
    thirdperson_controller_anim_walking = PlayAnimation(agent_character, "sk63_aj_walk.anm");
    --thirdperson_controller_anim_walking = PlayAnimation(agent_character, "sk61_zombie400_walkA.anm");
    thirdperson_controller_anim_running = PlayAnimation(agent_character, "sk63_aj_run.anm");
    --thirdperson_controller_anim_running = PlayAnimation(agent_character, "sk35_rosie_run.anm");
    --thirdperson_controller_anim_running = PlayAnimation(agent_character, "sk62_clementine400_run.anm");
    thirdperson_controller_anim_crouchIdle = PlayAnimation(agent_character, "sk63_idle_ajCrouch.anm");
    thirdperson_controller_anim_crouchMoving = PlayAnimation(agent_character, "sk62_clementine400_crouchWalk.anm");
    
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
    
    AgentSetState("AJ", "bodyJacketDisco");
    
    ALIVE_SetAgentWorldPosition(thirdperson_name_characterParent, Vector(0, 0, 11), ThirdPerson_kScene);
end

--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CHARACTER ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CHARACTER ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CHARACTER ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Gameplay_UpdateThirdPerson_CharacterAnimation = function()
    local frameTime = GetFrameTime();
    local animationFadeTime = 7.5;

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

    thirdperson_controller_anim_idle_contribution = ALIVE_NumberLerp(thirdperson_controller_anim_idle_contribution, idle_contribution_target, frameTime * animationFadeTime);
    thirdperson_controller_anim_walk_contribution = ALIVE_NumberLerp(thirdperson_controller_anim_walk_contribution, walk_contribution_target, frameTime * animationFadeTime);
    thirdperson_controller_anim_running_contribution = ALIVE_NumberLerp(thirdperson_controller_anim_running_contribution, running_contribution_target, frameTime * animationFadeTime);
    thirdperson_controller_anim_crouch_contribution = ALIVE_NumberLerp(thirdperson_controller_anim_crouch_contribution, crouch_contribution_target, frameTime * animationFadeTime);
    thirdperson_controller_anim_crouchWalk_contribution = ALIVE_NumberLerp(thirdperson_controller_anim_crouchWalk_contribution, crouchWalk_contribution_target, frameTime * animationFadeTime);

    ControllerSetContribution(thirdperson_controller_anim_idle, thirdperson_controller_anim_idle_contribution);
    ControllerSetContribution(thirdperson_controller_anim_walking, thirdperson_controller_anim_walk_contribution);
    ControllerSetContribution(thirdperson_controller_anim_running, thirdperson_controller_anim_running_contribution);
    ControllerSetContribution(thirdperson_controller_anim_crouchIdle, thirdperson_controller_anim_crouch_contribution);
    ControllerSetContribution(thirdperson_controller_anim_crouchMoving, thirdperson_controller_anim_crouchWalk_contribution);
end

--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CAMERA ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CAMERA ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CAMERA ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Gameplay_UpdateThirdPerson_CameraAnimation = function()
    local frameTime = GetFrameTime();

    ------------------------------FOV KICK------------------------------
    if (thirdperson_state_moving) then
        if (thirdperson_state_running) then
            thirdperson_camera_currentCameraFOV = ALIVE_NumberLerp(thirdperson_camera_currentCameraFOV, thirdperson_camera_runningFOV, frameTime * 2.5);
        else
            thirdperson_camera_currentCameraFOV = ALIVE_NumberLerp(thirdperson_camera_currentCameraFOV, thirdperson_camera_defaultFOV, frameTime * 2.5);
        end
    else
        thirdperson_camera_currentCameraFOV = ALIVE_NumberLerp(thirdperson_camera_currentCameraFOV, thirdperson_camera_defaultFOV, frameTime * 2.5);
    end

    ALIVE_AgentSetProperty(thirdperson_name_camera, "Field Of View", thirdperson_camera_currentCameraFOV, ThirdPerson_kScene);

    ------------------------------CAMERA BOBBING------------------------------
    local newCamRotX = 0.0;

    if (thirdperson_state_moving) then
        if (thirdperson_state_running) then
            thirdperson_camera_bobbingX = thirdperson_camera_bobbingX + (GetFrameTime() * thirdperson_camera_bobbingXSpeed_Run);
            newCamRotX = math.sin(thirdperson_camera_bobbingX) * thirdperson_camera_bobbingXAmount_Run;
        else
            thirdperson_camera_bobbingX = thirdperson_camera_bobbingX + (GetFrameTime() * thirdperson_camera_bobbingXSpeed_Walk);
            newCamRotX = math.sin(thirdperson_camera_bobbingX) * thirdperson_camera_bobbingXAmount_Walk;
        end
    else
        thirdperson_camera_bobbingX = 0.0;
        newCamRotX = 0.0;
    end

    thirdperson_camera_desiredRotation = Vector(newCamRotX, thirdperson_camera_desiredRotation.y, thirdperson_camera_desiredRotation.z);

    ALIVE_SetAgentRotation(thirdperson_name_animGroupCamera, thirdperson_camera_desiredRotation, ThirdPerson_kScene);
end

--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - INPUT ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - INPUT ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - INPUT ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Gameplay_UpdateThirdPerson_Input = function()
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
    
    --running (can only run if we are not crouching)
    if (thirdperson_state_crouching == false) then
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

--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CAMERA ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CAMERA ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CAMERA ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Gameplay_UpdateThirdPerson_Camera = function()
    local frameTime = GetFrameTime();

    local newRotation = Vector(thirdperson_inputMouseAmountY - 90, thirdperson_inputMouseAmountX, 0);
    newRotation.x = ALIVE_Clamp(newRotation.x, -90, 90);
    
    ------------------------------THIRD PERSON SHARED------------------------------
    local agent_camera = AgentFindInScene(thirdperson_name_camera, ThirdPerson_kScene); --Agent type
    local agent_cameraGroup = AgentFindInScene(thirdperson_name_groupCamera, ThirdPerson_kScene); --Agent type
    local agent_dummyCamera = AgentFindInScene(thirdperson_name_dummyObject, ThirdPerson_kScene); --Agent type

    local agent_character = AgentFindInScene(thirdperson_name_character, ThirdPerson_kScene); --Agent type
    local agent_characterParent = AgentFindInScene(thirdperson_name_characterParent, ThirdPerson_kScene); --Agent type
    local vector_character_position = AgentGetWorldPos(agent_characterParent); --Vector type
    local vector_character_forward = AgentGetForwardVec(agent_characterParent); --Vector type

    local vector_camera_worldRot = AgentGetWorldRot(agent_camera);
    
    ALIVE_SetAgentWorldRotation(thirdperson_name_dummyObject, Vector(0, vector_camera_worldRot.y, vector_camera_worldRot.z), ThirdPerson_kScene);

    local flippedMovementVector = Vector(-thirdperson_movementVector.x, thirdperson_movementVector.y, thirdperson_movementVector.z);

    ------------------------------THIRD PERSON CAMERA------------------------------
    local camPosLerpFactor = thirdperson_cameraPosLerp;
    local camRotLerpFactor = thirdperson_cameraRotLerp;
    local localLerpPosFactor = 2.0;

    if (thirdperson_state_crouching) then
        if(thirdperson_state_moving) then
            vector_character_position = vector_character_position + Vector(-0.0, 0.6, 0.0);
            thirdperson_camera_localPosition = ALIVE_VectorLerp(thirdperson_camera_localPosition, Vector(-0.25, 0.0, -1.0) + (flippedMovementVector * 0.1), frameTime * localLerpPosFactor);
        else
            vector_character_position = vector_character_position + Vector(-0.0, 0.5, 0.0);
            thirdperson_camera_localPosition = ALIVE_VectorLerp(thirdperson_camera_localPosition, Vector(-0.25, 0.0, -0.9), frameTime * localLerpPosFactor);
        end
    else
        if (thirdperson_state_moving) then
            if(thirdperson_state_running) then
                vector_character_position = vector_character_position + Vector(-0.0, 0.95, 0.0);
                thirdperson_camera_localPosition = ALIVE_VectorLerp(thirdperson_camera_localPosition, Vector(-0.25, 0.0, -0.9), frameTime * localLerpPosFactor);
            else
                vector_character_position = vector_character_position + Vector(-0.0, 0.95, 0.0);
                thirdperson_camera_localPosition = ALIVE_VectorLerp(thirdperson_camera_localPosition, Vector(-0.25, 0.0, -0.9), frameTime * localLerpPosFactor);
            end
        else
            vector_character_position = vector_character_position + Vector(-0.0, 0.95, 0.0);
            thirdperson_camera_localPosition = ALIVE_VectorLerp(thirdperson_camera_localPosition, Vector(-0.25, 0.0, -0.9), frameTime * localLerpPosFactor);
        end
    end
    
    thirdperson_prevCamPos = ALIVE_VectorLerp(thirdperson_prevCamPos, vector_character_position, frameTime * camPosLerpFactor);
    thirdperson_prevCamRot = ALIVE_VectorLerp(thirdperson_prevCamRot, newRotation, frameTime * camRotLerpFactor);
    --thirdperson_prevCamPos = vector_character_position;
    --thirdperson_prevCamRot = newRotation;
    
    ALIVE_SetAgentPosition(thirdperson_name_camera, thirdperson_camera_localPosition, ThirdPerson_kScene);
    ALIVE_SetAgentPosition(thirdperson_name_groupCamera, thirdperson_prevCamPos, ThirdPerson_kScene);
    ALIVE_SetAgentRotation(thirdperson_name_groupCamera, thirdperson_prevCamRot, ThirdPerson_kScene);

    ------------------------------STORE FOR NEXT FRAME------------------------------
    thirdperson_prevCursorPos = CursorGetPos();
end

--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CHARACTER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CHARACTER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CHARACTER ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Gameplay_UpdateThirdPerson_Character = function()
    local frameTime = GetFrameTime();

    local newRotation = Vector(thirdperson_inputMouseAmountY - 90, thirdperson_inputMouseAmountX, 0);
    newRotation.x = ALIVE_Clamp(newRotation.x, -90, 90);
    
    ------------------------------THIRD PERSON SHARED------------------------------
    local agent_camera = AgentFindInScene(thirdperson_name_camera, ThirdPerson_kScene); --Agent type
    local agent_cameraGroup = AgentFindInScene(thirdperson_name_groupCamera, ThirdPerson_kScene); --Agent type
    local agent_dummyCamera = AgentFindInScene(thirdperson_name_dummyObject, ThirdPerson_kScene); --Agent type

    local agent_character = AgentFindInScene(thirdperson_name_character, ThirdPerson_kScene); --Agent type
    local agent_characterParent = AgentFindInScene(thirdperson_name_characterParent, ThirdPerson_kScene); --Agent type
    local vector_character_position = AgentGetWorldPos(agent_characterParent); --Vector type
    local vector_character_forward = AgentGetForwardVec(agent_characterParent); --Vector type

    ------------------------------THIRD PERSON MOVEMENT------------------------------
    local vector_camera_right = AgentGetRightVec(agent_dummyCamera, true); --Vector type
    local vector_camera_forward = AgentGetForwardVec(agent_dummyCamera, true); --Vector type
    vector_camera_forward = vector_camera_forward + Vector(0, 0);
    
    vector_camera_right = VectorScale(vector_camera_right, thirdperson_movementVector.x);
    vector_camera_forward = VectorScale(vector_camera_forward, thirdperson_movementVector.z);
    local finalPlayerMovement = VectorAdd(vector_camera_right, vector_camera_forward);
    finalPlayerMovement.y = 0;

    local flippedMovementVector = Vector(-thirdperson_movementVector.x, thirdperson_movementVector.y, thirdperson_movementVector.z);

    if (thirdperson_state_moving) then
        local newDirection = AgentLocalToWorld(agent_dummyCamera, flippedMovementVector * 10.0);

        local directionLerpFactor = 5.0;

        thirdperson_characterDirection = ALIVE_VectorLerp(thirdperson_characterDirection, newDirection, frameTime * directionLerpFactor);
    end
    
    local newCharacterPosition = AgentGetWorldPos(agent_characterParent);
    finalPlayerMovement = VectorScale(finalPlayerMovement, thirdperson_movementSpeed);
    
    local lockedPos = VectorScale(Vector(0,0,1), AgentGetForwardAnimVelocity(agent_character));

    newCharacterPosition = newCharacterPosition + finalPlayerMovement;

    if (thirdperson_constrainToWBOX) then
        newCharacterPosition = WalkBoxesPosOnWalkBoxes(newCharacterPosition, 0, thirdperson_sceneWbox, 1);
    end

    thirdperson_characterDirection.y = newCharacterPosition.y;

    ALIVE_SetAgentPosition(thirdperson_name_character, lockedPos, ThirdPerson_kScene);
    ALIVE_SetAgentPosition(thirdperson_name_characterParent, newCharacterPosition, ThirdPerson_kScene);

    AgentFacePos(agent_character, thirdperson_characterDirection);

    ------------------------------STORE FOR NEXT FRAME------------------------------
end