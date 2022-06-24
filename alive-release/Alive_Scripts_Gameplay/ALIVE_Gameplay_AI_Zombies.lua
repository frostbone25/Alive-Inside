--|||||||||||||||||||||||||||||||||||||||||||||| AI ZOMBIE ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| AI ZOMBIE ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| AI ZOMBIE ||||||||||||||||||||||||||||||||||||||||||||||

--note to self: agent raycast function is very expensive
--note to self: agent find in scene is also rather expensive

-------------------------- ZOMBIES - GLOBAL --------------------------
local ai_zombie_name_character = "ZombieAI";

local zombie_props = 
{
    "sk61_zombie400Sherak.prop",
    "sk61_zombie400ChoppedFingers.prop",
    "sk61_zombie400ClemHeadCrush.prop",
    "sk61_zombie400CoupleFemale.prop",
    "sk61_zombie400CoupleMale.prop",
    "sk61_zombie400DeathByRosie.prop",
    "sk61_zombie400EyeStab.prop",
    "sk61_zombie400Incapacitated.prop"
};

--[[
local zombie_props = 
{
    "sk62_clementine400.prop"
};
]]--

--local ai_zombie_name_characterProp = "sk62_brodyZombie.prop";
--local ai_zombie_name_characterProp = "sk61_aasim.prop";
--local ai_zombie_name_characterProp = "sk61_abel.prop";
--local ai_zombie_name_characterProp = "sk61_louis.prop";
--local ai_zombie_name_characterProp = "sk61_marlon.prop";
--local ai_zombie_name_characterProp = "sk61_mitch.prop";
--local ai_zombie_name_characterProp = "sk62_brody.prop";
--local ai_zombie_name_characterProp = "sk62_clementine400.prop";
--local ai_zombie_name_characterProp = "sk62_violet.prop";
--local ai_zombie_name_characterProp = "sk63_aj.prop";
--local ai_zombie_name_characterProp = "sk63_omar.prop";
--local ai_zombie_name_characterProp = "sk63_ruby.prop";
--local ai_zombie_name_characterProp = "sk63_tennyson.prop";
--local ai_zombie_name_characterProp = "sk63_willy.prop";

local ai_zombie_name_characterParent = ai_zombie_name_character .. "_Parent";
local ai_zombie_sceneWbox = "adv_boardingSchoolExterior.wbox";
local ai_zombie_name_target = "AJ";
--local ai_zombie_name_target = "ClemYoung";
local ai_zombie_constrainToWBOX = false;

local zombie_idleAnimations = 
{
    "sk61_idle_zombieStandA.anm",
    "sk61_idle_zombieStandB.anm",
    "sk61_idle_zombieStandD.anm",
    "sk61_idle_zombieStandF.anm"
};

local zombie_walkProfiles = 
{
    profile1 = 
    {
        animationName = "sk61_zombie400_walkA",
        moveSpeed = 0.425
    },
    profile2 = 
    {
        animationName = "sk61_zombie400_walkC",
        moveSpeed = 0.45
    },
    profile3 = 
    {
        animationName = "sk61_zombie400_walkD",
        moveSpeed = 0.225
    },
    profile4 = 
    {
        animationName = "sk61_zombie_walkC",
        moveSpeed = 0.45
    },
    profile5 = 
    {
        animationName = "sk61_zombie_walkE",
        moveSpeed = 0.45
    },
    profile6 = 
    {
        animationName = "sk61_zombie400_walkAttackA",
        moveSpeed = 0.675
    },
    profile7 = 
    {
        animationName = "sk61_zombie400_walkAttackAArmsUp",
        moveSpeed = 0.675
    },
    profile8 = 
    {
        animationName = "sk61_zombie400_walkAttackB",
        moveSpeed = 0.675
    },
    profile9 = 
    {
        animationName = "sk61_zombie400_walkAttackBArmsUp",
        moveSpeed = 0.675
    },
    profile10 = 
    {
        animationName = "sk61_zombie_walkSlowA",
        moveSpeed = 0.275
    },
    profile11 = 
    {
        animationName = "sk61_zombie_walkSlowB",
        moveSpeed = 0.275
    }
};

--[[
local zombie_walkProfiles = 
{
    profile1 = 
    {
        animationName = "sk61_zombie_walkSlowB",
        moveSpeed = 0.275
    }
};
]]--

local zombie_walkProfilesCount = 11;

-------------------------- ZOMBIE OBJECT - VARIABLE NAMES --------------------------
zombie_agent_name =                        "Agent Name";
zombie_agent_parent_name =                 "Agent Name Parent";
zombie_agent =                             "Agent";
zombie_agent_parent =                      "Agent Parent";
zombie_agent_target =                      "Target Agent";
zombie_agent_target_name =                 "Target Agent Name";
zombie_controller_anim_walk =              "Controller Animation Walk";
zombie_controller_anim_idle =              "Controller Animation Idle";
zombie_controller_anim_walk_contribution = "Controller Animation Walk Contribution";
zombie_controller_anim_idle_contribution = "Controller Animation Idle Contribution";
zombie_distance_stopping =                 "Zombie Stopping Distance";
zombie_distance_stoppingTeam =             "Zombie Stopping Distance For Other Zombies";
zombie_profile_walk =                      "Zombie Speed Walk";
zombie_profile_walk_animation =            "Zombie Animation Walk";
zombie_profile_idle_animation =            "Zombie Animation Idle";
zombie_look_position =                     "Zombie Look Position";
zombie_state_moving =                      "Zombie State Moving";
zombie_state_blockedPath =                 "Zombie State Path Blocked";
zombie_state_stationedWithPlayer =         "Zombie State Stationed With Player"
zombie_state_killingPlayer =               "Zombie State Killing Player";
zombie_state_dead =                        "Zombie State Dead";

ALIVE_Gameplay_AI_ZombiesArray = {}; --Zombie Object Array

--|||||||||||||||||||||||||||||||||||||||||||||| ZOMBIE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| ZOMBIE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| ZOMBIE SETUP ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Gameplay_AI_CreateZombies = function(zombieCount, startingPosition, startingBoundsSize)
    -----------------------------------------------
    local group_prop = "group.prop";
    --local group_prop = "module_physicsobject.prop";
    --local group_prop = "obj_rockC.prop";
    --PropertyHasGlobal(agent.mProps, "module_physicsobject.prop")
    --ALIVE_PrintValidPropertyNamesOnPropertySet("module_physicsobject", "module_physicsobject.prop");
    --ALIVE_PrintPropertiesFromPropertySet("module_physicsobject", "module_physicsobject.prop");
    

    for i = 1, zombieCount do
        local newZombieObject = {};

        local newZombieName = ai_zombie_name_character .. tostring(i);
        local newZombieGroupName = ai_zombie_name_characterParent .. tostring(i);

        -----------------------------------------------
        local newZombiePropIndex = math.random(1, #zombie_props);
        local newZombieProp = zombie_props[newZombiePropIndex];

        local agent_zombie = AgentCreate(newZombieName, newZombieProp, Vector(0,0,0), Vector(0,0,0), ZombieAI_kScene, false, false);
        local agent_zombieParent = AgentCreate(newZombieGroupName, group_prop, Vector(0,0,0), Vector(0,0,0), ZombieAI_kScene, false, false);
    
        AgentAttach(agent_zombie, agent_zombieParent);
        --PropertyMoveGlobalToFront
        --local agent_zombieParentProps = AgentGetProperties(agent_zombieParent);
        --PropertyAddGlobal(agent_zombieParentProps, "module_path_to");
        --PropertyAddGlobal(agent_zombieParent.mProps, "module_physicsobject");
        --PhysicsEnableCollision(agent_zombieParent, true);

        --ALIVE_AgentSetProperty(newZombieName, "Render Global Scale", 1.31, ThirdPerson_kScene);
        ALIVE_AgentSetProperty(newZombieName, "Render Global Scale", 1.0, ThirdPerson_kScene);
    
        -----------------------------------------------
        local controllers_array_zombie = AgentGetControllers(agent_zombie);
    
        for i, controller in ipairs(controllers_array_zombie) do
            ControllerKill(cnt);
        end

        -----------------------------------------------
        local zombieWalkProfile_index = math.random(1, zombie_walkProfilesCount);
        local zombieWalkProfileName = "profile" .. tostring(zombieWalkProfile_index);

        local zombieWalkProfile = zombie_walkProfiles[zombieWalkProfileName];
        local zombieWalkProfile_variableName_anim = zombieWalkProfile["animationName"];
        local zombieWalkProfile_variableName_moveSpeed = zombieWalkProfile["moveSpeed"];

        local zombieIdleAnmIndex = math.random(1, #zombie_idleAnimations);
        local zombieIdleAnm = zombie_idleAnimations[zombieIdleAnmIndex];

        local controller_anim_idle = PlayAnimation(agent_zombie, zombieIdleAnm);
        local controller_anim_walking = PlayAnimation(agent_zombie, zombieWalkProfile_variableName_anim);

        ControllerSetLooping(controller_anim_idle, true);
        ControllerSetLooping(controller_anim_walking, true);
    
        ControllerSetPriority(controller_anim_idle, 100);
        ControllerSetPriority(controller_anim_walking, 100);

        -----------------------------------------------
        ALIVE_SetAgentWorldPosition(newZombieName, Vector(0, 0, 0), ZombieAI_kScene);
        ALIVE_SetAgentWorldRotation(newZombieName, Vector(0, 0, 0), ZombieAI_kScene);
        ALIVE_SetAgentPosition(newZombieName, Vector(0, 0, 0), ZombieAI_kScene);
        ALIVE_SetAgentRotation(newZombieName, Vector(0, 0, 0), ZombieAI_kScene);

        local decimals = 100;
        local random_x = ALIVE_RandomFloatValue(-startingBoundsSize.x, startingBoundsSize.x, decimals);
        local random_y = ALIVE_RandomFloatValue(-startingBoundsSize.y, startingBoundsSize.y, decimals);
        local random_z = ALIVE_RandomFloatValue(-startingBoundsSize.z, startingBoundsSize.z, decimals);
        local randomVector = Vector(random_x, random_y, random_z);

        local newZombiePosition = startingPosition + randomVector;

        ALIVE_SetAgentWorldPosition(newZombieGroupName, newZombiePosition, ZombieAI_kScene);

        -----------------------------------------------
        newZombieObject[zombie_agent] = AgentFindInScene(newZombieName, ZombieAI_kScene);
        newZombieObject[zombie_agent_parent] = AgentFindInScene(newZombieGroupName, ZombieAI_kScene);
        newZombieObject[zombie_agent_target] = AgentFindInScene(ai_zombie_name_target, ZombieAI_kScene);
        newZombieObject[zombie_agent_name] = newZombieName;
        newZombieObject[zombie_agent_parent_name] = newZombieGroupName;
        newZombieObject[zombie_agent_target_name] = ai_zombie_name_target;
        newZombieObject[zombie_controller_anim_idle] = controller_anim_idle;
        newZombieObject[zombie_controller_anim_walk] = controller_anim_walking;
        newZombieObject[zombie_controller_anim_idle_contribution] = 1;
        newZombieObject[zombie_controller_anim_walk_contribution] = 0;
        newZombieObject[zombie_state_moving] = false;
        newZombieObject[zombie_state_blockedPath] = false;
        newZombieObject[zombie_state_stationedWithPlayer] = false;
        newZombieObject[zombie_state_dead] = false;
        newZombieObject[zombie_distance_stopping] = ai_zombie_stoppingDistance;
        newZombieObject[zombie_distance_stoppingTeam] = ai_zombie_stoppingDistanceSameTeam;
        --newZombieObject[zombie_distance_stopping] = 0.55;
        --newZombieObject[zombie_distance_stoppingTeam] = 0.35;
        newZombieObject[zombie_profile_walk] = zombieWalkProfile_variableName_moveSpeed;
        newZombieObject[zombie_profile_walk_animation] = zombieWalkProfile_variableName_anim;
        newZombieObject[zombie_profile_idle_animation] = zombieIdleAnm;
        newZombieObject[zombie_look_position] = Vector(0,0,0);

        --local targetPos = AgentGetWorldPos(newZombieObject[zombie_agent_target]);
        --PathAgentTo(agent_zombieParent, WalkBoxesPosOnWalkBoxes(targetPos, 0, ai_zombie_sceneWbox, 1), nil, nil);
        --PhysicsEnableCollision(mPlayer, true)
        --PhysicsEnableCollision(agent, true)
        --PhysicsRegisterCollision(agent, "AI_Player_OnCollide")
        --PropertyAddGlobal

        --PhysicsMoveAgentToBySpeed(agent_zombieParent, WalkBoxesPosOnWalkBoxes(targetPos, 0, ai_zombie_sceneWbox, 1), 0.5, true, false);
        --PhysicsEnableCollision(agent_zombieParent, true)

        table.insert(ALIVE_Gameplay_AI_ZombiesArray, newZombieObject);
    end

    Callback_OnPostUpdate:Add(ALIVE_Gameplay_AI_UpdateZombies_Character);
    Callback_OnPostUpdate:Add(ALIVE_Gameplay_AI_UpdateZombies_CharacterAnimation);
end

--|||||||||||||||||||||||||||||||||||||||||||||| ZOMBIE - CHARACTER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| ZOMBIE - CHARACTER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| ZOMBIE - CHARACTER ||||||||||||||||||||||||||||||||||||||||||||||

local ifZombieIsCurrentlyInStation = false;

local CheckIfZombieIsInStation = function()
    for i = 1, #ALIVE_Gameplay_AI_ZombiesArray do
        local zombieObject = ALIVE_Gameplay_AI_ZombiesArray[i];

        local zombieObject_state_moving = zombieObject[zombie_state_moving];
        local zombieObject_state_blockedPath = zombieObject[zombie_state_blockedPath];
        local zombieObject_state_stationedWithPlayer = zombieObject[zombie_state_stationedWithPlayer];
        local zombieObject_state_killingPlayer = zombieObject[zombie_state_killingPlayer];
        local zombieObject_state_dead = zombieObject[zombie_state_dead];

        if(zombieObject_state_dead == true) then
            ifZombieIsCurrentlyInStation = false;
        end

        if (zombieObject_state_stationedWithPlayer == true) then
            ifZombieIsCurrentlyInStation = true;
        end
    end
end

ALIVE_Gameplay_AI_UpdateZombies_Character = function()
    local frameTime = GetFrameTime();

    for i = 1, #ALIVE_Gameplay_AI_ZombiesArray do
        local zombieObject = ALIVE_Gameplay_AI_ZombiesArray[i];

        local zombieObject_agentName = zombieObject[zombie_agent_name];
        local zombieObject_agentParentName = zombieObject[zombie_agent_parent_name];
        local zombieObject_agentTargetName = zombieObject[zombie_agent_target_name];
        local zombieObject_distanceStop = zombieObject[zombie_distance_stopping];
        local zombieObject_distanceStopTeam = zombieObject[zombie_distance_stoppingTeam];
        local zombieObject_walkSpeed = zombieObject[zombie_profile_walk];

        local zombieObject_state_moving = zombieObject[zombie_state_moving];
        local zombieObject_state_blockedPath = zombieObject[zombie_state_blockedPath];
        local zombieObject_state_stationedWithPlayer = zombieObject[zombie_state_stationedWithPlayer];
        local zombieObject_state_killingPlayer = zombieObject[zombie_state_killingPlayer];
        local zombieObject_state_dead = zombieObject[zombie_state_dead];

        CheckIfZombieIsInStation();

        if (zombieObject_state_dead == false) then

            -----------------------------------------------
            local agent_zombie = zombieObject[zombie_agent]; --Agent type
            local agent_zombieParent = zombieObject[zombie_agent_parent]; --Agent type
            local agent_target = zombieObject[zombie_agent_target]; --Agent type


            if (zombieObject_state_stationedWithPlayer == true) then
            
            else
                --local nearestZombieAgent = nil;

                --for x, zombie in ipairs(ALIVE_Gameplay_AI_ZombiesArray) do
                    --local nearestZombieAgentObject = ALIVE_Gameplay_AI_ZombiesArray[x];
                    --local nearestZombieAgentObject_agentName = nearestZombieAgentObject[zombie_agent_name];

                    --local nearestZombieAgentContender = AgentFindInScene(nearestZombieAgentObject_agentName, ZombieAI_kScene);

                    --if (zombieObject_agentName ~= nearestZombieAgentObject_agentName) then
                        --if (nearestZombieAgent == nil) then
                            --nearestZombieAgent = nearestZombieAgentContender;
                        --else
                            --nearestZombieAgent = ALIVE_GetNearestAgent(agent_zombie, nearestZombieAgent, nearestZombieAgentContender);
                        --end
                    --end
                --end

                AgentFacePos(agent_zombieParent, zombieObject[zombie_look_position]);

                local vector_target_position = AgentGetWorldPos(agent_target); --Vector type
                local vector_zombie_position = AgentGetWorldPos(agent_zombieParent); --Vector type
                local vector_zombie_forward = AgentGetForwardVec(agent_zombieParent); --Vector type
                local vector_target_direction = VectorNormalize(vector_target_position - vector_zombie_position);

                local distance_target = VectorDistance(vector_target_position, vector_zombie_position);

                --local movementVector = Vector(vector_target_direction.x, vector_target_position.y, vector_target_direction.z);
                local movementVector = vector_zombie_forward * zombieObject_walkSpeed * frameTime;
                local newLookPosition = Vector(vector_target_position.x, vector_zombie_position.y, vector_target_position.z);

                local lockedPos = VectorScale(Vector(0,0,0), AgentGetForwardAnimVelocity(agent_zombie));
                local newCharacterPosition = vector_zombie_position;

                local case1_targetDistance = distance_target > zombieObject_distanceStop;
                --local case1_targetDistance = distance_target > thirdperson_player_zombieStationZombie;

                zombieObject[zombie_state_blockedPath] = false;

                if (case1_targetDistance) then
                    --if too far from target

                    if(zombieObject[zombie_state_blockedPath] == false) then
                        --if our path isn't blocked, then move towards target
                        zombieObject[zombie_state_moving] = true;

                        newCharacterPosition = newCharacterPosition + movementVector;

                        PhysicsEnableCollision(agent_zombieParent, true)

                        zombieObject[zombie_look_position] = ALIVE_VectorLerp(zombieObject[zombie_look_position], newLookPosition, frameTime * 2.0);
                    else
                        --if our path is blocked, then spin around

                        zombieObject[zombie_state_moving] = false;

                        --local rightVec = AgentGetRightVec(agent_zombieParent);

                        --newLookPosition = vector_zombie_position + rightVec;

                        zombieObject[zombie_look_position] = ALIVE_VectorLerp(zombieObject[zombie_look_position], newLookPosition, frameTime * 2.0);
                    end

                    --zombieObject[zombie_look_position] = ALIVE_VectorLerp(zombieObject[zombie_look_position], newLookPosition, frameTime * 2.0);
                    --zombieObject[zombie_look_position] = newLookPosition;
                else
                    --if within target stopping distance
                    zombieObject[zombie_state_moving] = false;

                    if (ifZombieIsCurrentlyInStation == false) then
                        zombieObject[zombie_state_stationedWithPlayer] = true;
                    end
                end

                if (ai_zombie_constrainToWBOX) then
                    newCharacterPosition = WalkBoxesPosOnWalkBoxes(newCharacterPosition, 0, ai_zombie_sceneWbox, 1);
                end

                ALIVE_SetAgentPosition(zombieObject_agentName, lockedPos, ThirdPerson_kScene);
                ALIVE_SetAgentPosition(zombieObject_agentParentName, newCharacterPosition, ZombieAI_kScene);
            end
        end
    end
end


--|||||||||||||||||||||||||||||||||||||||||||||| ZOMBIE - CHARACTER ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| ZOMBIE - CHARACTER ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| ZOMBIE - CHARACTER ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Gameplay_AI_UpdateZombies_CharacterAnimation = function()
    local frameTime = GetFrameTime();
    local animationFadeTime = 7.5;

    for i = 1, #ALIVE_Gameplay_AI_ZombiesArray do
        local zombieObject = ALIVE_Gameplay_AI_ZombiesArray[i];

        local zombieObject_agentName = zombieObject[zombie_agent_name];
        local zombieObject_agentParentName = zombieObject[zombie_agent_parent_name];
        local zombieObject_agentTargetName = zombieObject[zombie_agent_target_name];
        local zombieObject_state_moving = zombieObject[zombie_state_moving];
        local zombieObject_state_stationedWithPlayer = zombieObject[zombie_state_stationedWithPlayer];
        local zombieObject_state_dead = zombieObject[zombie_state_dead];
        local zombieObject_cntIdle = zombieObject[zombie_controller_anim_idle];
        local zombieObject_cntWalk = zombieObject[zombie_controller_anim_walk];
        local zombieObject_cntIdleAmount = zombieObject[zombie_controller_anim_idle_contribution];
        local zombieObject_cntWalkAmount = zombieObject[zombie_controller_anim_walk_contribution];
        -----------------------------------------------

        local idle_contribution_target = 1;
        local walk_contribution_target = 0;

        if (zombieObject_state_stationedWithPlayer) or (zombieObject_state_dead) then
            ControllerSetContribution(zombieObject_cntIdle, 0);
            ControllerSetContribution(zombieObject_cntWalk, 0);

            zombieObject[zombie_controller_anim_idle_contribution] = 0;
            zombieObject[zombie_controller_anim_walk_contribution] = 0;
        else
            if (zombieObject_state_moving) then
                idle_contribution_target = 0;
                walk_contribution_target = 1;
            else
                idle_contribution_target = 1;
                walk_contribution_target = 0;
            end

            zombieObject_cntIdleAmount = ALIVE_NumberLerp(zombieObject_cntIdleAmount, idle_contribution_target, frameTime * animationFadeTime);
            zombieObject_cntWalkAmount = ALIVE_NumberLerp(zombieObject_cntWalkAmount, walk_contribution_target, frameTime * animationFadeTime);

            ControllerSetContribution(zombieObject_cntIdle, zombieObject_cntIdleAmount);
            ControllerSetContribution(zombieObject_cntWalk, zombieObject_cntWalkAmount);

            -----------------------------------------------
            zombieObject[zombie_controller_anim_idle_contribution] = zombieObject_cntIdleAmount;
            zombieObject[zombie_controller_anim_walk_contribution] = zombieObject_cntWalkAmount;
        end
    end
end