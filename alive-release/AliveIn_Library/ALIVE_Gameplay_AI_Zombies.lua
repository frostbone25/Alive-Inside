--|||||||||||||||||||||||||||||||||||||||||||||| AI ZOMBIE ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| AI ZOMBIE ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| AI ZOMBIE ||||||||||||||||||||||||||||||||||||||||||||||

-------------------------- PROPERTIES - OBJECT NAMES --------------------------
local ai_zombie_name_character = "ZombieAI";
local ai_zombie_name_characterProp = "sk61_zombie400Sherak.prop";
local ai_zombie_name_characterParent = ai_zombie_name_character .. "_Parent";
local ai_zombie_sceneWbox = "adv_boardingSchoolExterior.wbox";

local ai_zombie_name_target = "AJ";

-------------------------- PROPERTIES - CHARACTER ANIMATION --------------------------
local ai_zombie_controller_anim_idle = nil;
local ai_zombie_controller_anim_walking = nil;
local ai_zombie_controller_anim_idle_contribution = 0;
local ai_zombie_controller_anim_walk_contribution = 0;

-------------------------- PROPERTIES - CONTROLLER --------------------------
local ai_zombie_characterDirection = Vector(0, 0, 0);
local ai_zombie_characterOffset = Vector(0, 0, 0);
local ai_zombie_movementVector = Vector(0,0,0);
local ai_zombie_movementSpeed = 0.0;
local ai_zombie_constrainToWBOX = false;

-------------------------- PROPERTIES - STATES --------------------------
local ai_zombie_state_moving = false;

--|||||||||||||||||||||||||||||||||||||||||||||| ZOMBIE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| ZOMBIE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| ZOMBIE SETUP ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Gameplay_AI_CreateZombie = function(startingPosition)
    -----------------------------------------------
    local group_prop = "group.prop";

    local agent_character = AgentCreate(ai_zombie_name_character, ai_zombie_name_characterProp, Vector(0,0,0), Vector(0,0,0), ZombieAI_kScene, false, false);
    local agent_characterGroup = AgentCreate(ai_zombie_name_characterParent, group_prop, Vector(0,0,0), Vector(0,0,0), ZombieAI_kScene, false, false);
    
    AgentAttach(agent_character, agent_characterGroup);
    
    ALIVE_SetAgentWorldPosition(ai_zombie_name_character, Vector(0, 0, 0), ZombieAI_kScene);
    ALIVE_SetAgentWorldRotation(ai_zombie_name_character, Vector(0, 0, 0), ZombieAI_kScene);
    
    -----------------------------------------------
    local controllersTable_character = AgentGetControllers(agent_character);
    
    for i, cnt in ipairs(controllersTable_character) do
        ControllerKill(cnt);
    end

    -----------------------------------------------
    ai_zombie_controller_anim_idle = PlayAnimation(agent_character, "sk61_idle_zombieStandA.anm");
    --ai_zombie_controller_anim_walking = PlayAnimation(agent_character, "sk61_zombie400_walkA.anm");
    ai_zombie_controller_anim_walking = PlayAnimation(agent_character, "sk61_zombie400_walkC.anm");
    
    ControllerSetLooping(ai_zombie_controller_anim_idle, true);
    ControllerSetLooping(ai_zombie_controller_anim_walking, true);
    
    ControllerSetPriority(ai_zombie_controller_anim_idle, 100);
    ControllerSetPriority(ai_zombie_controller_anim_walking, 100);

    ALIVE_SetAgentWorldPosition(ai_zombie_name_characterParent, startingPosition, ZombieAI_kScene);
end

--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CHARACTER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CHARACTER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CHARACTER ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Gameplay_AI_UpdateZombie_Character = function()
    local frameTime = GetFrameTime();

    local agent_character = AgentFindInScene(ai_zombie_name_character, ZombieAI_kScene); --Agent type
    local agent_characterParent = AgentFindInScene(ai_zombie_name_characterParent, ZombieAI_kScene); --Agent type
    local agent_target = AgentFindInScene(ai_zombie_name_target, ZombieAI_kScene); --Agent type



    local vector_target_position = AgentGetWorldPos(agent_target); --Vector type
    local vector_character_position = AgentGetWorldPos(agent_characterParent); --Vector type
    local vector_character_forward = AgentGetForwardVec(agent_characterParent); --Vector type

    local vector_targetDirection = VectorNormalize(vector_target_position - vector_character_position);

    local distance_target = VectorDistance(vector_target_position, vector_character_position);
    local stoppingDistance = 1.0;






    local movementVector = Vector(vector_targetDirection.x, vector_target_position.y, vector_targetDirection.z);
    local lookPosition = Vector(vector_target_position.x, vector_character_position.y, vector_target_position.z);

    local lockedPos = VectorScale(Vector(0,0,1), AgentGetForwardAnimVelocity(agent_character));
    local newCharacterPosition = vector_character_position;

    if (distance_target > stoppingDistance) then
        ai_zombie_state_moving = true;

        newCharacterPosition = newCharacterPosition + (movementVector * 0.0075);
        AgentFacePos(agent_character, lookPosition);
    else
        ai_zombie_state_moving = false;
    end






    if (ai_zombie_constrainToWBOX) then
        newCharacterPosition = WalkBoxesPosOnWalkBoxes(newCharacterPosition, 0, ai_zombie_sceneWbox, 1);
    end





    ALIVE_SetAgentPosition(ai_zombie_name_character, lockedPos, ThirdPerson_kScene);
    ALIVE_SetAgentPosition(ai_zombie_name_characterParent, newCharacterPosition, ZombieAI_kScene);
end


--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CHARACTER ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CHARACTER ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER UPDATES - CHARACTER ANIMATION ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Gameplay_AI_UpdateZombie_CharacterAnimation = function()
    local frameTime = GetFrameTime();
    local animationFadeTime = 7.5;

    local idle_contribution_target = 1;
    local walk_contribution_target = 0;
    
    if (ai_zombie_state_moving) then
        idle_contribution_target = 0;
        walk_contribution_target = 1;
    else
        idle_contribution_target = 1;
        walk_contribution_target = 0;
    end

    ai_zombie_controller_anim_idle_contribution = ALIVE_NumberLerp(ai_zombie_controller_anim_idle_contribution, idle_contribution_target, frameTime * animationFadeTime);
    ai_zombie_controller_anim_walk_contribution = ALIVE_NumberLerp(ai_zombie_controller_anim_walk_contribution, walk_contribution_target, frameTime * animationFadeTime);

    ControllerSetContribution(ai_zombie_controller_anim_idle, ai_zombie_controller_anim_idle_contribution);
    ControllerSetContribution(ai_zombie_controller_anim_walking, ai_zombie_controller_anim_walk_contribution);
end