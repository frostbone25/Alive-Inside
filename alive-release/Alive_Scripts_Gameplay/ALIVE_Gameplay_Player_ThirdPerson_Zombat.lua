ALIVE_Gameplay_Player_ThirdPerson_Zombat_SetZombieStation = function()
    for i = 1, #ALIVE_Gameplay_AI_ZombiesArray do
        local zombieObject = ALIVE_Gameplay_AI_ZombiesArray[i];

        local zombieObject_state_stationedWithPlayer = zombieObject[zombie_state_stationedWithPlayer];
        local zombieObject_state_dead = zombieObject[zombie_state_dead];

        if (zombieObject_state_stationedWithPlayer == true) and (zombieObject_state_dead == false) then
            ALIVE_Gameplay_AI_Zombies_CurrentStationedZombieObject = zombieObject;

            if (thirdperson_state_zombatReady) then
                thirdperson_state_zombieStation = true;
            else
                thirdperson_state_dying = true;
            end
        end
    end
end

local currentZombieController = nil;
local currentPlayerController = nil;
local startTime = 0.0;
local endTime = 0.0;

ALIVE_Gameplay_Player_ThirdPerson_Zombat_Main = function()
    if (ALIVE_Gameplay_AI_Zombies_CurrentStationedZombieObject == nil) then do return end end

    local zombieObject = ALIVE_Gameplay_AI_Zombies_CurrentStationedZombieObject;

    --zombie properties
    local zombieObject_agent = zombieObject[zombie_agent];
    local zombieObject_agentParent = zombieObject[zombie_agent_parent];
    local zombieObject_agentName = zombieObject[zombie_agent_name];
    local zombieObject_agentParentName = zombieObject[zombie_agent_parent_name];
    local zombieObject_agentTargetName = zombieObject[zombie_agent_target_name];
    local zombieObject_distanceStop = zombieObject[zombie_distance_stopping];
    local zombieObject_distanceStopTeam = zombieObject[zombie_distance_stoppingTeam];
    local zombieObject_walkSpeed = zombieObject[zombie_profile_walk];
    local zombieObject_state_stationedWithPlayer = zombieObject[zombie_state_stationedWithPlayer];
    local zombieObject_state_dead = zombieObject[zombie_state_dead];

    if (zombieObject_state_dead == true) then 
        ALIVE_Gameplay_AI_Zombies_CurrentStationedZombieObject = nil;
        
        do return end 
    end

    --player properties
    --thirdperson_agent_character
    --thirdperson_agent_characterParent
    --thirdperson_agent_knife

    thirdperson_state_moving = false;
    thirdperson_state_running = false;
    thirdperson_state_crouching = false;

    if(currentZombieController == nil) then
        startTime = GetTotalTime();

        local vector_zombie_position = AgentGetWorldPos(zombieObject_agent);
        local vector_zombie_rotation = AgentGetWorldRot(zombieObject_agent);
        local vector_zombie_forward = AgentGetForwardVec(zombieObject_agent);

        local randomIndex = math.random(1, 2);

        if (randomIndex > 1) then
            currentPlayerController = PlayAnimation(thirdperson_agent_character, "sk63_action_ajKillZombie02.anm");
            currentZombieController = PlayAnimation(zombieObject_agent, "sk61_zombie400_sk63_action_ajKillZombie02.anm");
        else
            currentPlayerController = PlayAnimation(thirdperson_agent_character, "sk63_action_ajKillZombie01.anm");
            currentZombieController = PlayAnimation(zombieObject_agent, "sk61_zombie400_sk63_action_ajKillZombie01.anm");
        end

        ControllerSetLooping(currentZombieController, false);
        ControllerSetLooping(currentPlayerController, false);

        ControllerSetPriority(currentZombieController, 100);
        ControllerSetPriority(currentPlayerController, 100);

        ControllerSetEndPause(currentZombieController, true);

        AgentSetWorldPos(thirdperson_agent_characterParent, vector_zombie_position);
        AgentSetWorldRot(thirdperson_agent_characterParent, vector_zombie_rotation);

        endTime = GetTotalTime() + ControllerGetLength(currentZombieController);
    else
        local currentTime = GetTotalTime();

        if (currentTime > endTime) then
            local prevPlayerZombatWorldPos = AgentGetWorldPos(thirdperson_agent_character);
            local prevPlayerZombatWorldRot = AgentGetWorldRot(thirdperson_agent_character);
            local prevPlayerZombatForward = AgentGetForwardVec(thirdperson_agent_character, true);

            thirdperson_state_zombieStation = false;
            zombieObject[zombie_state_dead] = true;
            zombieObject[zombie_state_stationedWithPlayer] = false;

            ControllerKill(currentPlayerController);
            ControllerKill(zombieObject[zombie_controller_anim_idle]);
            ControllerKill(zombieObject[zombie_controller_anim_walk]);

            AgentSetPos(thirdperson_agent_character, Vector(0,0,0));
            AgentSetRot(thirdperson_agent_character, Vector(0,0,0));
            AgentSetWorldPos(thirdperson_agent_characterParent, prevPlayerZombatWorldPos);
            AgentSetWorldRot(thirdperson_agent_characterParent, prevPlayerZombatWorldRot);

            thirdperson_characterDirection = (prevPlayerZombatWorldPos) + (prevPlayerZombatForward) * 10.0;

            currentZombieController = nil;
            currentPlayerController = nil;
            ALIVE_Gameplay_AI_Zombies_CurrentStationedZombieObject = nil;
            zombieObject = nil;
        end
    end
end