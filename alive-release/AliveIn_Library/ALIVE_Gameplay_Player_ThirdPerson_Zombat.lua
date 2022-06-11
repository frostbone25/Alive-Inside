ALIVE_Gameplay_Player_ThirdPerson_Zombat_SetZombieStation = function()
    for i = 1, #ALIVE_Gameplay_AI_ZombiesArray do
        local zombieObject = ALIVE_Gameplay_AI_ZombiesArray[i];

        local zombieObject_state_stationedWithPlayer = zombieObject[zombie_state_stationedWithPlayer];

        if (zombieObject_state_stationedWithPlayer == true) then
            ALIVE_Gameplay_AI_Zombies_CurrentStationedZombieObject = zombieObject;

            if (thirdperson_state_zombatReady) then
                thirdperson_state_zombieStation = true;
            else
                thirdperson_state_dying = true;
            end
        end
    end
end

ALIVE_Gameplay_Player_ThirdPerson_Zombat_Main = function()
    if (ALIVE_Gameplay_AI_Zombies_CurrentStationedZombieObject == nil) then do return end end

    local zombieObject = ALIVE_Gameplay_AI_Zombies_CurrentStationedZombieObject;

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