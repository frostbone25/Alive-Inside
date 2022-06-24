--|||||||||||||||||||||||||||||||||||||||||||||| AI ZOMBIE ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| AI ZOMBIE ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| AI ZOMBIE ||||||||||||||||||||||||||||||||||||||||||||||

--note to self: agent raycast function is very expensive
--note to self: agent find in scene is also rather expensive

-------------------------- ZOMBIES - GLOBAL --------------------------
local cutscene_zombie_name_character = "ZombieCutscene";
local cutscene_zombie_name_characterParent = cutscene_zombie_name_character .. "_Parent";

local cutscene_zombie_props = 
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

local cutscene_zombie_animations_idle = 
{
    "sk61_idle_zombieStandA.anm",
    "sk61_idle_zombieStandB.anm",
    "sk61_idle_zombieStandD.anm",
    "sk61_idle_zombieStandF.anm"
};

local cutscene_zombie_profiles_walk = 
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

local cutscene_zombie_profiles_walkCount = 11;

-------------------------- ZOMBIE OBJECT - VARIABLE NAMES --------------------------
cutscene_zombie_agent_name =                        "Agent Name";
cutscene_zombie_agent_parent_name =                 "Agent Name Parent";
cutscene_zombie_agent =                             "Agent";
cutscene_zombie_agent_parent =                      "Agent Parent";
cutscene_zombie_controller_anim_walk =              "Controller Animation Walk";
cutscene_zombie_controller_anim_idle =              "Controller Animation Idle";
cutscene_zombie_controller_anim_walk_contribution = "Controller Animation Walk Contribution";
cutscene_zombie_controller_anim_idle_contribution = "Controller Animation Idle Contribution";
cutscene_zombie_distance_stopping =                 "Zombie Stopping Distance";
cutscene_zombie_profile_walk =                      "Zombie Speed Walk";
cutscene_zombie_profile_walk_animation =            "Zombie Animation Walk";
cutscene_zombie_profile_idle_animation =            "Zombie Animation Idle";
cutscene_zombie_look_position =                     "Zombie Look Position";
cutscene_zombie_state_moving =                      "Zombie State Moving";

ALIVE_Cutscene_ZombieCrowd_ZombiesArray = {}; --Zombie Object Array
ALIVE_Cutscene_ZombieCrowd_TargetPosition = Vector(0, 0, 0);

--|||||||||||||||||||||||||||||||||||||||||||||| ZOMBIE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| ZOMBIE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| ZOMBIE SETUP ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Cutscene_ZombieCrowd_CreateZombies = function(zombieCount, startingPosition, startingBoundsSize)
    -----------------------------------------------
    local group_prop = "group.prop";

    for i = 1, zombieCount do
        local newZombieObject = {};
        local newZombieName = cutscene_zombie_name_character .. tostring(i);
        local newZombieGroupName = cutscene_zombie_name_characterParent .. tostring(i);

        -----------------------------------------------
        local newZombiePropIndex = math.random(1, #cutscene_zombie_props);
        local newZombieProp = cutscene_zombie_props[newZombiePropIndex];

        local agent_zombie = AgentCreate(newZombieName, newZombieProp, Vector(0,0,0), Vector(0,0,0), ALIVE_Cutscene_ZombieCrowd_kScene, false, false);
        local agent_zombieParent = AgentCreate(newZombieGroupName, group_prop, Vector(0,0,0), Vector(0,0,0), ALIVE_Cutscene_ZombieCrowd_kScene, false, false);
    
        AgentAttach(agent_zombie, agent_zombieParent);

        ALIVE_AgentSetProperty(newZombieName, "Render Global Scale", 1.0, ALIVE_Cutscene_ZombieCrowd_kScene);
    
        -----------------------------------------------
        local controllers_array_zombie = AgentGetControllers(agent_zombie);
    
        for i, controller in ipairs(controllers_array_zombie) do
            ControllerKill(cnt);
        end

        -----------------------------------------------
        local zombieWalkProfile_index = math.random(1, cutscene_zombie_profiles_walkCount);
        local zombieWalkProfileName = "profile" .. tostring(zombieWalkProfile_index);

        local zombieWalkProfile = cutscene_zombie_profiles_walk[zombieWalkProfileName];
        local zombieWalkProfile_variableName_anim = zombieWalkProfile["animationName"];
        local zombieWalkProfile_variableName_moveSpeed = zombieWalkProfile["moveSpeed"];

        local zombieIdleAnmIndex = math.random(1, #cutscene_zombie_animations_idle);
        local zombieIdleAnm = cutscene_zombie_animations_idle[zombieIdleAnmIndex];

        local controller_anim_idle = PlayAnimation(agent_zombie, zombieIdleAnm);
        local controller_anim_walking = PlayAnimation(agent_zombie, zombieWalkProfile_variableName_anim);

        ControllerSetLooping(controller_anim_idle, true);
        ControllerSetLooping(controller_anim_walking, true);
    
        ControllerSetPriority(controller_anim_idle, 100);
        ControllerSetPriority(controller_anim_walking, 100);

        -----------------------------------------------
        ALIVE_SetAgentWorldPosition(newZombieName, Vector(0, 0, 0), ALIVE_Cutscene_ZombieCrowd_kScene);
        ALIVE_SetAgentWorldRotation(newZombieName, Vector(0, 0, 0), ALIVE_Cutscene_ZombieCrowd_kScene);
        ALIVE_SetAgentPosition(newZombieName, Vector(0, 0, 0), ALIVE_Cutscene_ZombieCrowd_kScene);
        ALIVE_SetAgentRotation(newZombieName, Vector(0, 0, 0), ALIVE_Cutscene_ZombieCrowd_kScene);

        local decimals = 100;
        local random_x = ALIVE_RandomFloatValue(-startingBoundsSize.x, startingBoundsSize.x, decimals);
        local random_y = ALIVE_RandomFloatValue(-startingBoundsSize.y, startingBoundsSize.y, decimals);
        local random_z = ALIVE_RandomFloatValue(-startingBoundsSize.z, startingBoundsSize.z, decimals);
        local randomVector = Vector(random_x, random_y, random_z);

        local newZombiePosition = startingPosition + randomVector;

        ALIVE_SetAgentWorldPosition(newZombieGroupName, newZombiePosition, ALIVE_Cutscene_ZombieCrowd_kScene);

        -----------------------------------------------
        newZombieObject[cutscene_zombie_agent] = AgentFindInScene(newZombieName, ALIVE_Cutscene_ZombieCrowd_kScene);
        newZombieObject[cutscene_zombie_agent_parent] = AgentFindInScene(newZombieGroupName, ALIVE_Cutscene_ZombieCrowd_kScene);
        newZombieObject[cutscene_zombie_agent_name] = newZombieName;
        newZombieObject[cutscene_zombie_agent_parent_name] = newZombieGroupName;
        newZombieObject[cutscene_zombie_controller_anim_idle] = controller_anim_idle;
        newZombieObject[cutscene_zombie_controller_anim_walk] = controller_anim_walking;
        newZombieObject[cutscene_zombie_controller_anim_idle_contribution] = 1;
        newZombieObject[cutscene_zombie_controller_anim_walk_contribution] = 0;
        newZombieObject[cutscene_zombie_state_moving] = false;
        newZombieObject[cutscene_zombie_distance_stopping] = cutscene_zombie_stoppingDistance;
        newZombieObject[cutscene_zombie_profile_walk] = zombieWalkProfile_variableName_moveSpeed;
        newZombieObject[cutscene_zombie_profile_walk_animation] = zombieWalkProfile_variableName_anim;
        newZombieObject[cutscene_zombie_profile_idle_animation] = zombieIdleAnm;
        newZombieObject[cutscene_zombie_look_position] = Vector(0,0,0);

        table.insert(ALIVE_Cutscene_ZombieCrowd_ZombiesArray, newZombieObject);
    end

    Callback_OnPostUpdate:Add(ALIVE_Cutscene_ZombieCrowd_UpdateZombies_Character);
    Callback_OnPostUpdate:Add(ALIVE_Cutscene_ZombieCrowd_UpdateZombies_CharacterAnimation);
end

ALIVE_Cutscene_ZombieCrowd_MoveZombies = function(newPosition, newBoundsSize)
    for i = 1, #ALIVE_Cutscene_ZombieCrowd_ZombiesArray do
        local zombieObject = ALIVE_Cutscene_ZombieCrowd_ZombiesArray[i];
        local zombieObject_agentName = zombieObject[cutscene_zombie_agent_name];
        local zombieObject_agentParentName = zombieObject[cutscene_zombie_agent_parent_name];
        local zombieObject_agentZombie = zombieObject[zombie_agent]; --Agent type
        local zombieObject_agentZombieParent = zombieObject[cutscene_zombie_agent_parent]; --Agent type

        -----------------------------------------------
        ALIVE_SetAgentWorldPosition(zombieObject_agentName, Vector(0, 0, 0), ALIVE_Cutscene_ZombieCrowd_kScene);
        ALIVE_SetAgentWorldRotation(zombieObject_agentName, Vector(0, 0, 0), ALIVE_Cutscene_ZombieCrowd_kScene);
        ALIVE_SetAgentPosition(zombieObject_agentName, Vector(0, 0, 0), ALIVE_Cutscene_ZombieCrowd_kScene);
        ALIVE_SetAgentRotation(zombieObject_agentName, Vector(0, 0, 0), ALIVE_Cutscene_ZombieCrowd_kScene);

        local decimals = 100;
        local random_x = ALIVE_RandomFloatValue(-newBoundsSize.x, newBoundsSize.x, decimals);
        local random_y = ALIVE_RandomFloatValue(-newBoundsSize.y, newBoundsSize.y, decimals);
        local random_z = ALIVE_RandomFloatValue(-newBoundsSize.z, newBoundsSize.z, decimals);
        local randomVector = Vector(random_x, random_y, random_z);

        local newZombiePosition = newPosition + randomVector;

        ALIVE_SetAgentWorldPosition(zombieObject_agentParentName, newZombiePosition, ALIVE_Cutscene_ZombieCrowd_kScene);

        -----------------------------------------------
        newZombieObject[cutscene_zombie_look_position] = newZombiePosition;
    end
end

--|||||||||||||||||||||||||||||||||||||||||||||| ZOMBIE - CHARACTER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| ZOMBIE - CHARACTER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| ZOMBIE - CHARACTER ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Cutscene_ZombieCrowd_UpdateZombies_Character = function()
    local frameTime = GetFrameTime();

    for i = 1, #ALIVE_Cutscene_ZombieCrowd_ZombiesArray do
        local zombieObject = ALIVE_Cutscene_ZombieCrowd_ZombiesArray[i];

        local zombieObject_agentName = zombieObject[cutscene_zombie_agent_name];
        local zombieObject_agentParentName = zombieObject[cutscene_zombie_agent_parent_name];
        local zombieObject_distanceStop = zombieObject[cutscene_zombie_distance_stopping];
        local zombieObject_walkSpeed = zombieObject[cutscene_zombie_profile_walk];
        local zombieObject_state_moving = zombieObject[cutscene_zombie_state_moving];

        -----------------------------------------------
        local agent_zombie = zombieObject[cutscene_zombie_agent]; --Agent type
        local agent_zombieParent = zombieObject[cutscene_zombie_agent_parent]; --Agent type

        AgentFacePos(agent_zombieParent, zombieObject[zombie_look_position]);

        local vector_target_position = ALIVE_Cutscene_ZombieCrowd_TargetPosition; --Vector type
        local vector_zombie_position = AgentGetWorldPos(agent_zombieParent); --Vector type
        local vector_zombie_forward = AgentGetForwardVec(agent_zombieParent); --Vector type
        local vector_target_direction = VectorNormalize(vector_target_position - vector_zombie_position);

        local distance_target = VectorDistance(vector_target_position, vector_zombie_position);

        local movementVector = vector_zombie_forward * zombieObject_walkSpeed * frameTime;
        local newLookPosition = Vector(vector_target_position.x, vector_zombie_position.y, vector_target_position.z);

        local lockedPos = VectorScale(Vector(0,0,0), AgentGetForwardAnimVelocity(agent_zombie));
        local newCharacterPosition = vector_zombie_position;

        local case1_targetDistance = distance_target > zombieObject_distanceStop;
 
        if (case1_targetDistance) then
            zombieObject[zombie_state_moving] = true;

            newCharacterPosition = newCharacterPosition + movementVector;

            zombieObject[zombie_look_position] = ALIVE_VectorLerp(zombieObject[zombie_look_position], newLookPosition, frameTime * 2.0);
        else
            zombieObject[zombie_state_moving] = false;
        end

        ALIVE_SetAgentPosition(zombieObject_agentName, lockedPos, ALIVE_Cutscene_ZombieCrowd_kScene);
        ALIVE_SetAgentPosition(zombieObject_agentParentName, newCharacterPosition, ALIVE_Cutscene_ZombieCrowd_kScene);
    end
end


--|||||||||||||||||||||||||||||||||||||||||||||| ZOMBIE - CHARACTER ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| ZOMBIE - CHARACTER ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| ZOMBIE - CHARACTER ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Cutscene_ZombieCrowd_UpdateZombies_CharacterAnimation = function()
    local frameTime = GetFrameTime();
    local animationFadeTime = 7.5;

    for i = 1, #ALIVE_Cutscene_ZombieCrowd_ZombiesArray do
        local zombieObject = ALIVE_Cutscene_ZombieCrowd_ZombiesArray[i];

        local zombieObject_agentName = zombieObject[cutscene_zombie_agent_name];
        local zombieObject_agentParentName = zombieObject[cutscene_zombie_agent_parent_name];
        local zombieObject_state_moving = zombieObject[cutscene_zombie_state_moving];
        local zombieObject_cntIdle = zombieObject[cutscene_zombie_controller_anim_idle];
        local zombieObject_cntWalk = zombieObject[cutscene_zombie_controller_anim_walk];
        local zombieObject_cntIdleAmount = zombieObject[cutscene_zombie_controller_anim_idle_contribution];
        local zombieObject_cntWalkAmount = zombieObject[cutscene_zombie_controller_anim_walk_contribution];
        -----------------------------------------------

        local idle_contribution_target = 1;
        local walk_contribution_target = 0;

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