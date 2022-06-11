--|||||||||||||||||||||||||||||||||||||||||||||| 3RD PERSON CONTROLLER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| 3RD PERSON CONTROLLER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| 3RD PERSON CONTROLLER ||||||||||||||||||||||||||||||||||||||||||||||

-------------------------- PROPERTIES - CHARACTER ANIMATION --------------------------
local thirdperson_controller_anim_idle = nil;
local thirdperson_controller_anim_walking = nil;
local thirdperson_controller_anim_running = nil;
local thirdperson_controller_anim_crouchIdle = nil;
local thirdperson_controller_anim_crouchMoving = nil;
local thirdperson_controller_anim_blinking = nil;
local thirdperson_controller_anim_idle_contribution = 0;
local thirdperson_controller_anim_walk_contribution = 0;
local thirdperson_controller_anim_running_contribution = 0;
local thirdperson_controller_anim_crouch_contribution = 0;
local thirdperson_controller_anim_crouchWalk_contribution = 0;

local thirdperson_controller_anim_zombat_idle = nil;
local thirdperson_controller_anim_zombat_idle_contribution = 0;

-------------------------- PROPERTIES - INPUT --------------------------
local thirdperson_inputHorizontalValue = 0;
local thirdperson_inputVerticalValue = 0;
local thirdperson_inputHeightValue = 0;

-------------------------- PROPERTIES - CONTROLLER --------------------------
local thirdperson_characterDirection = Vector(0, 0, 0);
local thirdperson_characterOffset = Vector(0, 0, 0);
local thirdperson_movementSpeed = 0.0;
local prevFinalPlayerMovement = Vector(0,0,0);

--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER SETUP ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Gameplay_Player_ThirdPerson_Character_CreateCharacter = function(startingPosition)
    -----------------------------------------------
    local group_prop = "group.prop";
    
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

    local agent_knife = AgentCreate(thirdperson_name_knife, knife_prop, Vector(0,0,0), Vector(0,0,0), ThirdPerson_kScene, false, false);
    ALIVE_AgentSetProperty(thirdperson_name_knife, "Render Global Scale", 1, ThirdPerson_kScene);
    ALIVE_AgentSetProperty(thirdperson_name_knife, "Render Cull", false, ThirdPerson_kScene);
    ALIVE_AgentSetProperty(thirdperson_name_knife, "Runtime: Visible", true, ThirdPerson_kScene);

    --spine3
    --wrist_L
    --wrist_R
    local nodeName = "wrist_R";

    --ALIVE_PrintValidNodeNames(agent_character);
    --AgentFindInScene(thirdperson_name_character, ThirdPerson_kScene);

    if AgentHasNode(agent_character, nodeName) then
        AgentAttachToNode(agent_knife, agent_character, nodeName);

        --kabar holding thumb at end of knife
        --AgentSetPos(agent_knife, Vector(-0.032, -0.025, 0.041)); --x (palm forward) y (palm distance) z (object height)
        --AgentSetRot(agent_knife, Vector(0, -90, 90));

        --kabar holding at base
        AgentSetPos(agent_knife, Vector(-0.00, -0.025, 0.045)); --x (palm forward) y (palm distance) z (object height)
        AgentSetRot(agent_knife, Vector(0, -90, 90));
    end

    -----------------------------------------------
    local controllersTable_character = AgentGetControllers(agent_character);
    
    for i, cnt in ipairs(controllersTable_character) do
        ControllerKill(cnt);
    end
    
    -----------------------------------------------
    thirdperson_controller_anim_idle = PlayAnimation(agent_character, "sk63_idle_ajStandA.anm");
    --thirdperson_controller_anim_walking = PlayAnimation(agent_character, "sk63_aj_walk.anm");
    thirdperson_controller_anim_running = PlayAnimation(agent_character, "sk63_aj_run.anm");
    thirdperson_controller_anim_crouchIdle = PlayAnimation(agent_character, "sk63_idle_ajCrouch.anm");
    thirdperson_controller_anim_crouchMoving = PlayAnimation(agent_character, "sk62_clementine400_crouchWalk.anm");

    --local testing = PlayAnimation(agent_character, "sk62_idle_clementineHoldKnifeReady.anm");
    --ControllerSetPriority(testing, 200);
    --ControllerSetLooping(testing, true);

    --thirdperson_controller_anim_idle = PlayAnimation(agent_character, "sk62_idle_clementine400StandAHoldKnife.anm");
    --thirdperson_controller_anim_idle = PlayAnimation(agent_character, "sk62_idle_clementineHoldKnifeReady.anm");
    --thirdperson_controller_anim_idle = PlayAnimation(agent_character, "sk63_idle_ajActionHoldKnife.anm");
    thirdperson_controller_anim_walking = PlayAnimation(agent_character, "sk63_aj_walk.anm");
    --thirdperson_controller_anim_running = PlayAnimation(agent_character, "sk62_clementine400_runHoldPackKnife.anm");
    --thirdperson_controller_anim_crouchIdle = PlayAnimation(agent_character, "sk63_idle_ajCrouch.anm");
    --thirdperson_controller_anim_crouchMoving = PlayAnimation(agent_character, "sk62_clementine400_crouchWalk.anm");

    thirdperson_controller_anim_zombat_idle = PlayAnimation(agent_character, "sk63_idle_ajActionHoldKnife.anm");

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

    ControllerSetLooping(thirdperson_controller_anim_zombat_idle, true);
    ControllerSetPriority(thirdperson_controller_anim_zombat_idle, 100);
    
    ALIVE_SetAgentWorldPosition(thirdperson_name_characterParent, startingPosition, ThirdPerson_kScene);

    -----------------------------------------------

    thirdperson_agent_character = AgentFindInScene(thirdperson_name_character, ThirdPerson_kScene); --Agent type
    thirdperson_agent_characterParent = AgentFindInScene(thirdperson_name_characterParent, ThirdPerson_kScene); --Agent type
    thirdperson_agent_knife = AgentFindInScene(thirdperson_name_knife, ThirdPerson_kScene); --Agent type
end

--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - INPUT ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - INPUT ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - INPUT ||||||||||||||||||||||||||||||||||||||||||||||

local zombatKeyTimeLag = 0;
--local zombatKeyPrevBool = true;

ALIVE_Gameplay_Player_ThirdPerson_Character_UpdateInput = function()
    thirdperson_frameTime = GetFrameTime();

    ------------------------------INPUT------------------------------
    local key_moveForward = Input_IsVKeyPressed(87); --key w
    local key_moveBackward = Input_IsVKeyPressed(83); --key s
    local key_moveLeft = Input_IsVKeyPressed(65); --key a
    local key_moveRight = Input_IsVKeyPressed(68); --key d
    local key_running = Input_IsVKeyPressed(16); --key shift
    local key_crouch1 = Input_IsVKeyPressed(67); --key c
    local key_crouch2 = Input_IsVKeyPressed(17); --key ctrl
    local key_zombatToggle = Input_IsVKeyPressed(82); --key R

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

    --ZOMBAT KEYS
    if key_zombatToggle then
        zombatKeyTimeLag = zombatKeyTimeLag + GetFrameTime();

        if(zombatKeyTimeLag > 0.25) then
            thirdperson_state_zombatReady = not thirdperson_state_zombatReady;
            zombatKeyTimeLag = 0;
        end
    end
end

--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CHARACTER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CHARACTER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CHARACTER ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Gameplay_Player_ThirdPerson_Character_UpdateCharacter = function()
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

    ALIVE_AgentSetProperty(thirdperson_name_knife, "Runtime: Visible", thirdperson_state_zombatReady, ThirdPerson_kScene);

    ------------------------------STORE FOR NEXT FRAME------------------------------
end


--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CHARACTER ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CHARACTER ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CHARACTER ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||

--local PlayBlinkAnimation = function()
    --thirdperson_controller_anim_blinking = ALIVE_ChorePlayOnAgent("aJ_face_blink.chore", agent_character, nil, nil);
    --thirdperson_controller_anim_blinking = PlayAnimation(agent_character, "wd400GM_face_eyesClosed_add.anm");
    --thirdperson_controller_anim_blinking = PlayAnimation(agent_character, "aj_face_eyesClosed.anm");
    --thirdperson_controller_anim_blinking = PlayAnimation(thirdperson_agent_character, "aj_face_eyesClosed_add.anm");
    --ControllerSetLooping(thirdperson_controller_anim_blinking, false);
    --ControllerSetPriority(thirdperson_controller_anim_blinking, 100);
--end

--local ajBlinkTick = 0;
--local ajBlinkMaxTick = 120;

ALIVE_Gameplay_Player_ThirdPerson_Character_UpdateCharacterAnimation = function()
    local animationFadeTime = 7.5;

    if (thirdperson_state_dying) or (thirdperson_state_zombieStation) then 
        ControllerSetContribution(thirdperson_controller_anim_idle, 0);
        ControllerSetContribution(thirdperson_controller_anim_zombat_idle, 0);
        ControllerSetContribution(thirdperson_controller_anim_walking, 0);
        ControllerSetContribution(thirdperson_controller_anim_running, 0);
        ControllerSetContribution(thirdperson_controller_anim_crouchIdle, 0);
        ControllerSetContribution(thirdperson_controller_anim_crouchMoving, 0);
        
        do return end 
    end

    local idle_contribution_target = 1;
    local idle_zombat_contribution_target = 0;
    local walk_contribution_target = 0;
    local running_contribution_target = 0;
    local crouch_contribution_target = 0;
    local crouchWalk_contribution_target = 0;
    
    if (thirdperson_state_moving) then
        if (thirdperson_state_running) then
            idle_contribution_target = 0;
            idle_zombat_contribution_target = 0;
            walk_contribution_target = 0;
            running_contribution_target = 1;
            crouch_contribution_target = 0;
            crouchWalk_contribution_target = 0;
        else
            if(thirdperson_state_crouching) then
                idle_contribution_target = 0;
                idle_zombat_contribution_target = 0;
                walk_contribution_target = 0;
                running_contribution_target = 0;
                crouch_contribution_target = 0;
                crouchWalk_contribution_target = 1;
            else
                idle_contribution_target = 0;
                idle_zombat_contribution_target = 0;
                walk_contribution_target = 1;
                running_contribution_target = 0;
                crouch_contribution_target = 0;
                crouchWalk_contribution_target = 0;
            end
        end
    else
        if (thirdperson_state_crouching) then
            idle_contribution_target = 0;
            idle_zombat_contribution_target = 0;
            walk_contribution_target = 0;
            running_contribution_target = 0;
            crouch_contribution_target = 1;
            crouchWalk_contribution_target = 0;
        else
            if (thirdperson_state_zombatReady) then
                idle_contribution_target = 0;
                idle_zombat_contribution_target = 1;
            else
                idle_contribution_target = 1;
                idle_zombat_contribution_target = 0;
            end

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

    thirdperson_controller_anim_zombat_idle_contribution = ALIVE_NumberLerp(thirdperson_controller_anim_zombat_idle_contribution, idle_zombat_contribution_target, thirdperson_frameTime * animationFadeTime);
    ControllerSetContribution(thirdperson_controller_anim_zombat_idle, thirdperson_controller_anim_zombat_idle_contribution);

    --ajBlinkTick = ajBlinkTick + 1;

    --if (ajBlinkTick > ajBlinkMaxTick) then
    --    PlayBlinkAnimation();
    --    ajBlinkTick = 0;
    --end
end