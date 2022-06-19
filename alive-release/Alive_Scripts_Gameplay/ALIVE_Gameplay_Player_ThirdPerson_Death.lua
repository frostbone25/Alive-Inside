local deathAnimationTick = 0;
local fxColorOpacity = 0;

ResourceSetEnable("WalkingDead201")

ALIVE_Gameplay_Player_ThirdPerson_Death_Main = function()
    if (thirdperson_state_dying) then

        if(deathAnimationTick == 0) then
            RenderDelay(1);

            local agent_character = AgentFindInScene(thirdperson_name_character, ThirdPerson_kScene); --Agent type
            local agent_zombie = AgentFindInScene(ALIVE_Gameplay_AI_Zombies_CurrentStationedZombieObject[zombie_agent_name], ThirdPerson_kScene); --Agent type
            local agent_zombieParent = AgentFindInScene(ALIVE_Gameplay_AI_Zombies_CurrentStationedZombieObject[zombie_agent_parent_name], ThirdPerson_kScene); --Agent type

            local vector_character_position = AgentGetWorldPos(agent_character); --Vector type
            local vector_zombie_position = AgentGetWorldPos(agent_zombieParent); --Vector type
            local vector_zombie_rotation = AgentGetWorldRot(agent_zombieParent); --Vector type
            local vector_zombie_forward = AgentGetForwardVec(agent_zombieParent, true); --Vector type
            local vector_zombie_right = AgentGetRightVec(agent_zombieParent, true); --Vector type
            
            local zombieControllers = AgentGetControllers(agent_zombie);

            for i, cnt in ipairs(zombieControllers) do
                ControllerKill(cnt);
            end

            local character_anim_controller = PlayAnimation(agent_character, "sk56_action_clementine200KilledZombieFrontA.anm");
            local zombie_anim_controller = PlayAnimation(agent_zombie, "sk54_zombieAverage200_sk56_action_clementine200KilledZombieFrontA.anm");

            ControllerSetLooping(character_anim_controller, false);
            ControllerSetLooping(zombie_anim_controller, false);

            ControllerSetPriority(character_anim_controller, 100);
            ControllerSetPriority(zombie_anim_controller, 100);

            AgentSetPos(agent_character, Vector(0, 0, 0));
            AgentSetRot(agent_character, vector_zombie_rotation);

            local character_deathPos = vector_zombie_position;
            character_deathPos = character_deathPos + (vector_zombie_forward * 1.0);
            character_deathPos = character_deathPos + (vector_zombie_right * 0.2);
            character_deathPos = character_deathPos + Vector(0, 0.245, 0);

            ALIVE_SetAgentWorldPosition(thirdperson_name_characterParent, character_deathPos, ThirdPerson_kScene);
            ALIVE_SetAgentWorldRotation(thirdperson_name_characterParent, vector_zombie_rotation, ThirdPerson_kScene);

            ALIVE_SetAgentPosition(thirdperson_name_camera, Vector(0,0,0), ThirdPerson_kScene);
            ALIVE_SetAgentPosition(thirdperson_name_groupCamera, vector_zombie_position + Vector(0.2, 0.85, -0.18), ThirdPerson_kScene);
            ALIVE_SetAgentRotation(thirdperson_name_groupCamera, Vector(-15, -15, 15), ThirdPerson_kScene);

            ALIVE_AgentSetProperty(thirdperson_name_camera, "Field Of View", 160, ThirdPerson_kScene);
        end

        if (deathAnimationTick == 1) then
            SoundPlay("mus_sting_shock_13.wav");
            SoundPlay("mus_sting_eerie_03.wav");
        end

        if (deathAnimationTick == 2) then
            SoundPlay("vox_zomb_seanF_oneshot_attack_bigger_4.wav");
            SoundPlay("396539353.wav");
        end

        if (deathAnimationTick == 20) then
            SoundPlay("comp_violence_zombie_10.wav");
        end

        if (deathAnimationTick == 89) then
            SoundPlay("fol_bodyfall_dirt_09.wav");
        end

        if (deathAnimationTick == 95) then
            SoundPlay("396523117.wav");
        end

        if (deathAnimationTick == 119) then
            SoundPlay("mus_sting_shock_13.wav");
            SoundPlay("fol_bodyfall_02.wav");
        end

        if (deathAnimationTick == 170) then
            SoundPlay("vox_zomb_seanF_oneshot_attack_bigger_3.wav");
        end

        if (deathAnimationTick == 230) then
            SoundPlay("comp_violence_zombie_10.wav");
        end

        if (deathAnimationTick > 70) then
            fxColorOpacity = ALIVE_NumberLerp(fxColorOpacity, 1.0, thirdperson_frameTime * 2.5);
            ALIVE_AgentSetProperty(thirdperson_name_camera, "FX Color Enabled", true, ThirdPerson_kScene);
            ALIVE_AgentSetProperty(thirdperson_name_camera, "FX Color Opacity", fxColorOpacity, ThirdPerson_kScene);
            ALIVE_AgentSetProperty(thirdperson_name_camera, "FX Color Tint", Color(1, 0, 0, 1), ThirdPerson_kScene);
        end
        
        deathAnimationTick = deathAnimationTick + 1;
    end
end