--|||||||||||||||||||||||||||||||||||||||||||||| AI ALLIES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| AI ALLIES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| AI ALLIES ||||||||||||||||||||||||||||||||||||||||||||||

--note to self: agent raycast function is very expensive
--note to self: agent find in scene is also rather expensive

-------------------------- ALLY - GLOBAL --------------------------
local ai_ally_name_character = "AllyAI";
local ai_ally_name_characterParent = ai_ally_name_character .. "_Parent";

local ally_profilesCount = 1;
local ally_profiles = 
{
    Aasim = 
    {
        PropName = "sk61_aasim.prop",
        Speed_Walk = 0.25,
        Animation_Walk = "sk61_wd400GM_walk.anm",
        Animation_Idle = "sk61_idle_louisStandA.anm"
    }
};

--sk61_marlon_walk.anm
--sk61_wd400GM_walk.anm
--sk61_louis_crouchWalk.anm
--sk61_idle_marlonCrouch.anm
--sk61_idle_wd400GMCrouchA.anm
--sk61_idle_jamesCrouch.anm
--sk61_idle_jamesStandA.anm
--sk61_idle_louisStandA.anm


--local ai_ally_name_characterProp = "sk62_brodyally.prop";
--local ai_ally_name_characterProp = "sk61_aasim.prop";
--local ai_ally_name_characterProp = "sk61_abel.prop";
--local ai_ally_name_characterProp = "sk61_louis.prop";
--local ai_ally_name_characterProp = "sk61_marlon.prop";
--local ai_ally_name_characterProp = "sk61_mitch.prop";
--local ai_ally_name_characterProp = "sk62_brody.prop";
--local ai_ally_name_characterProp = "sk62_clementine400.prop";
--local ai_ally_name_characterProp = "sk62_violet.prop";
--local ai_ally_name_characterProp = "sk63_aj.prop";
--local ai_ally_name_characterProp = "sk63_omar.prop";
--local ai_ally_name_characterProp = "sk63_ruby.prop";
--local ai_ally_name_characterProp = "sk63_tennyson.prop";
--local ai_ally_name_characterProp = "sk63_willy.prop";

-------------------------- ALLY OBJECT - SHARED VARIABLE NAMES --------------------------
ally_agent_name =                        "Agent Name";
ally_agent_parent_name =                 "Agent Name Parent";
ally_agent =                             "Agent";
ally_agent_parent =                      "Agent Parent";
ally_agent_target =                      "Target Agent";
ally_agent_target_name =                 "Target Agent Name";
ally_controller_anim_walk =              "Controller Animation Walk";
ally_controller_anim_idle =              "Controller Animation Idle";
ally_controller_anim_walk_contribution = "Controller Animation Walk Contribution";
ally_controller_anim_idle_contribution = "Controller Animation Idle Contribution";
ally_distance_stopping =                 "Stopping Distance";
ally_profile_walk =                      "Speed Walk";
ally_profile_walk_animation =            "Animation Walk";
ally_profile_idle_animation =            "Animation Idle";
ally_look_position =                     "Look Position";
ally_state_moving =                      "State Moving";

ALIVE_Gameplay_AI_AlliesArray = {}; --Ally Object Array

--|||||||||||||||||||||||||||||||||||||||||||||| ALLY SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| ALLY SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| ALLY SETUP ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Gameplay_AI_CreateAllies = function(activeAllyNames, startingPosition, startingBoundsSize)
    -----------------------------------------------
    local group_prop = "group.prop";

    for i = 1, #activeAllyNames do
        local newAllyObject = {};

        local newAllyName = ai_ally_name_character .. tostring(i);
        local newAllyGroupName = ai_ally_name_characterParent .. tostring(i);

        -----------------------------------------------
        local newAllyProfileName = activeAllyNames[i];
        local newAllyProfile = ally_profiles[newAllyProfileName];
        local newAllyProfile_PropName = newAllyProfile["PropName"];
        local newAllyProfile_Speed_Walk = newAllyProfile["Speed_Walk"];
        local newAllyProfile_Animation_Walk = newAllyProfile["Animation_Walk"];
        local newAllyProfile_Animation_Idle = newAllyProfile["Animation_Idle"];

        -----------------------------------------------
        local agent_ally = nil;

        --if AgentExistsInScene(newAllyName, AllyAI_kScene) then
            --agent_ally = AgentFindInScene(newAllyName, AllyAI_kScene);
        --else
            agent_ally = AgentCreate(newAllyName, newAllyProfile_PropName, Vector(0,0,0), Vector(0,0,0), AllyAI_kScene, false, false);
        --end

        local agent_allyParent = AgentCreate(newAllyGroupName, group_prop, Vector(0,0,0), Vector(0,0,0), AllyAI_kScene, false, false);
    
        AgentAttach(agent_ally, agent_allyParent);
        ALIVE_AgentSetProperty(newAllyName, "Render Global Scale", 1.0, AllyAI_kScene);
    
        -----------------------------------------------
        local controllers_array_ally = AgentGetControllers(agent_ally);
    
        for i, controller in ipairs(controllers_array_ally) do
            ControllerKill(controller);
        end

        -----------------------------------------------
        local controller_anim_idle = PlayAnimation(agent_ally, newAllyProfile_Animation_Idle);
        local controller_anim_walking = PlayAnimation(agent_ally, newAllyProfile_Animation_Walk);

        ControllerSetLooping(controller_anim_idle, true);
        ControllerSetLooping(controller_anim_walking, true);
    
        ControllerSetPriority(controller_anim_idle, 100);
        ControllerSetPriority(controller_anim_walking, 100);

        -----------------------------------------------
        ALIVE_SetAgentWorldPosition(newAllyName, Vector(0, 0, 0), AllyAI_kScene);
        ALIVE_SetAgentWorldRotation(newAllyName, Vector(0, 0, 0), AllyAI_kScene);
        ALIVE_SetAgentPosition(newAllyName, Vector(0, 0, 0), AllyAI_kScene);
        ALIVE_SetAgentRotation(newAllyName, Vector(0, 0, 0), AllyAI_kScene);

        local decimals = 100;
        local random_x = ALIVE_RandomFloatValue(-startingBoundsSize.x, startingBoundsSize.x, decimals);
        local random_y = ALIVE_RandomFloatValue(-startingBoundsSize.y, startingBoundsSize.y, decimals);
        local random_z = ALIVE_RandomFloatValue(-startingBoundsSize.z, startingBoundsSize.z, decimals);
        local randomVector = Vector(random_x, random_y, random_z);

        local newAllyPosition = startingPosition + randomVector;

        ALIVE_SetAgentWorldPosition(newAllyGroupName, newAllyPosition, AllyAI_kScene);

        -----------------------------------------------
        newAllyObject[ally_agent] = AgentFindInScene(newAllyName, AllyAI_kScene);
        newAllyObject[ally_agent_parent] = AgentFindInScene(newAllyGroupName, AllyAI_kScene);
        newAllyObject[ally_agent_target] = AgentFindInScene(ai_ally_name_target, AllyAI_kScene);
        newAllyObject[ally_agent_name] = newAllyName;
        newAllyObject[ally_agent_parent_name] = newAllyGroupName;
        newAllyObject[ally_agent_target_name] = ai_ally_name_target;
        newAllyObject[ally_controller_anim_idle] = controller_anim_idle;
        newAllyObject[ally_controller_anim_walk] = controller_anim_walking;
        newAllyObject[ally_controller_anim_idle_contribution] = 1;
        newAllyObject[ally_controller_anim_walk_contribution] = 0;
        newAllyObject[ally_state_moving] = false;
        newAllyObject[ally_distance_stopping] = ai_ally_stoppingDistance;
        newAllyObject[ally_profile_walk] = newAllyProfile_Speed_Walk;
        newAllyObject[ally_profile_walk_animation] = newAllyProfile_Animation_Walk;
        newAllyObject[ally_profile_idle_animation] = newAllyProfile_Animation_Idle;
        newAllyObject[ally_look_position] = Vector(0,0,0);

        table.insert(ALIVE_Gameplay_AI_AlliesArray, newAllyObject);
    end

    --Callback_OnPostUpdate:Add(ALIVE_Gameplay_AI_UpdateAllies_Character);
    Callback_OnPostUpdate:Add(ALIVE_Gameplay_AI_UpdateAllies_CharacterAnimation);
end

--|||||||||||||||||||||||||||||||||||||||||||||| ALLY - CHARACTER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| ALLY - CHARACTER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| ALLY - CHARACTER ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Gameplay_AI_UpdateAllies_Character = function()
    local frameTime = GetFrameTime();

    for i = 1, #ALIVE_Gameplay_AI_AlliesArray do
        local allyObject = ALIVE_Gameplay_AI_AlliesArray[i];

        local allyObject_agentName = allyObject[ally_agent_name];
        local allyObject_agentParentName = allyObject[ally_agent_parent_name];
        local allyObject_agentTargetName = allyObject[ally_agent_target_name];
        local allyObject_distanceStop = allyObject[ally_distance_stopping];
        local allyObject_walkSpeed = allyObject[ally_profile_walk];

        local allyObject_state_moving = allyObject[ally_state_moving];

        -----------------------------------------------
        local agent_ally = allyObject[ally_agent]; --Agent type
        local agent_allyParent = allyObject[ally_agent_parent]; --Agent type
        local agent_target = allyObject[ally_agent_target]; --Agent type

        AgentFacePos(agent_allyParent, allyObject[ally_look_position]);

        local vector_target_position = AgentGetWorldPos(agent_target); --Vector type
        local vector_ally_position = AgentGetWorldPos(agent_allyParent); --Vector type
        local vector_ally_forward = AgentGetForwardVec(agent_allyParent); --Vector type
        local vector_target_direction = VectorNormalize(vector_target_position - vector_ally_position);

        local distance_target = VectorDistance(vector_target_position, vector_ally_position);

        --local movementVector = Vector(vector_target_direction.x, vector_target_position.y, vector_target_direction.z);
        local movementVector = vector_ally_forward * allyObject_walkSpeed * frameTime;
        local newLookPosition = Vector(vector_target_position.x, vector_ally_position.y, vector_target_position.z);

        local lockedPos = VectorScale(Vector(0,0,0), AgentGetForwardAnimVelocity(agent_ally));
        local newCharacterPosition = vector_ally_position;

        local case1_targetDistance = distance_target > allyObject_distanceStop;
        --local case1_targetDistance = distance_target > thirdperson_player_allyStationally;

        if (case1_targetDistance) then
            --if too far then move towards target

            allyObject[ally_state_moving] = true;

            newCharacterPosition = newCharacterPosition + movementVector;

            PhysicsEnableCollision(agent_allyParent, true)

            allyObject[ally_look_position] = ALIVE_VectorLerp(allyObject[ally_look_position], newLookPosition, frameTime * 2.0);

        else
            --if within target stopping distance
            allyObject[ally_state_moving] = false;
        end

        if (ai_ally_constrainToWBOX) then
            newCharacterPosition = WalkBoxesPosOnWalkBoxes(newCharacterPosition, 0, ai_ally_sceneWbox, 1);
        end

        ALIVE_SetAgentPosition(allyObject_agentName, lockedPos, ThirdPerson_kScene);
        ALIVE_SetAgentPosition(allyObject_agentParentName, newCharacterPosition, AllyAI_kScene);
    end
end


--|||||||||||||||||||||||||||||||||||||||||||||| ally - CHARACTER ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| ally - CHARACTER ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| ally - CHARACTER ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Gameplay_AI_UpdateAllies_CharacterAnimation = function()
    local frameTime = GetFrameTime();
    local animationFadeTime = 7.5;

    for i = 1, #ALIVE_Gameplay_AI_AlliesArray do
        local allyObject = ALIVE_Gameplay_AI_AlliesArray[i];

        local allyObject_agentName = allyObject[ally_agent_name];
        local allyObject_agentParentName = allyObject[ally_agent_parent_name];
        local allyObject_agentTargetName = allyObject[ally_agent_target_name];
        local allyObject_state_moving = allyObject[ally_state_moving];
        local allyObject_cntIdle = allyObject[ally_controller_anim_idle];
        local allyObject_cntWalk = allyObject[ally_controller_anim_walk];
        local allyObject_cntIdleAmount = allyObject[ally_controller_anim_idle_contribution];
        local allyObject_cntWalkAmount = allyObject[ally_controller_anim_walk_contribution];
        -----------------------------------------------

        local idle_contribution_target = 1;
        local walk_contribution_target = 0;

        if (allyObject_state_moving) then
            idle_contribution_target = 0;
            walk_contribution_target = 1;
        else
            idle_contribution_target = 1;
            walk_contribution_target = 0;
        end

        allyObject_cntIdleAmount = ALIVE_NumberLerp(allyObject_cntIdleAmount, idle_contribution_target, frameTime * animationFadeTime);
        allyObject_cntWalkAmount = ALIVE_NumberLerp(allyObject_cntWalkAmount, walk_contribution_target, frameTime * animationFadeTime);

        ControllerSetContribution(allyObject_cntIdle, allyObject_cntIdleAmount);
        ControllerSetContribution(allyObject_cntWalk, allyObject_cntWalkAmount);

        -----------------------------------------------
        allyObject[ally_controller_anim_idle_contribution] = allyObject_cntIdleAmount;
        allyObject[ally_controller_anim_walk_contribution] = allyObject_cntWalkAmount;
    end
end
