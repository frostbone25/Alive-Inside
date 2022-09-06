--thirdperson_state_zombieStation
--ALIVE_Gameplay_AI_ZombiesArray = {}; --Zombie Object Array

ai_zombie_name_target = "AJ";
ai_zombie_sceneWbox = "adv_boardingSchoolExterior.wbox";
ai_zombie_constrainToWBOX = false;
ai_zombie_stoppingDistance = 1.0; --number type
ai_zombie_stoppingDistanceSameTeam = 0.75; --number type

ai_ally_name_target = "AJ";
ai_ally_sceneWbox = "adv_boardingSchoolExterior.wbox";
ai_ally_constrainToWBOX = false;
ai_ally_stoppingDistance = 1.0; --number type
ai_ally_stoppingDistanceSameTeam = 0.75; --number type

ALIVE_Gameplay_Shared_HideCusorInGame = function()
    CursorHide(true);
    CursorEnable(true);
end