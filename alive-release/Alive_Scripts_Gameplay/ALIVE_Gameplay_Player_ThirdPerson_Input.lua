----------------------------------------------------------------------
ALIVE_Gameplay_Player_ThirdPerson_Character_Input_MoveForward_Begin = function()
    thirdperson_inputDirection_z = 1.0;
    --thirdperson_inputDirection_z = thirdperson_inputDirection_z + 1.0;
end

ALIVE_Gameplay_Player_ThirdPerson_Character_Input_MoveForward_End = function()
    thirdperson_inputDirection_z = 0.0;
    --thirdperson_inputDirection_z = thirdperson_inputDirection_z - 1.0;
end
----------------------------------------------------------------------
ALIVE_Gameplay_Player_ThirdPerson_Character_Input_MoveBackward_Begin = function()
    thirdperson_inputDirection_z = -1.0;
    --thirdperson_inputDirection_z = thirdperson_inputDirection_z - 1.0;
end

ALIVE_Gameplay_Player_ThirdPerson_Character_Input_MoveBackward_End = function()
    thirdperson_inputDirection_z = 0.0;
    --thirdperson_inputDirection_z = thirdperson_inputDirection_z + 1.0;
end
----------------------------------------------------------------------
ALIVE_Gameplay_Player_ThirdPerson_Character_Input_MoveLeft_Begin = function()
    thirdperson_inputDirection_x = -1.0;
    --thirdperson_inputDirection_x = thirdperson_inputDirection_x - 1.0;
end

ALIVE_Gameplay_Player_ThirdPerson_Character_Input_MoveLeft_End = function()
    thirdperson_inputDirection_x = 0.0;
    --thirdperson_inputDirection_x = thirdperson_inputDirection_x + 1.0;
end
----------------------------------------------------------------------
ALIVE_Gameplay_Player_ThirdPerson_Character_Input_MoveRight_Begin = function()
    thirdperson_inputDirection_x = 1.0;
    --thirdperson_inputDirection_x = thirdperson_inputDirection_x + 1.0;
end

ALIVE_Gameplay_Player_ThirdPerson_Character_Input_MoveRight_End = function()
    thirdperson_inputDirection_x = 0.0;
    --thirdperson_inputDirection_x = thirdperson_inputDirection_x - 1.0;
end
----------------------------------------------------------------------
ALIVE_Gameplay_Player_ThirdPerson_Character_Input_Running_Begin = function()
    --On Left Shift Down
    thirdperson_state_running = true;
end

ALIVE_Gameplay_Player_ThirdPerson_Character_Input_Running_End = function()
    --On Left Shift Up
    thirdperson_state_running = false;
end

----------------------------------------------------------------------
ALIVE_Gameplay_Player_ThirdPerson_Character_Input_Crouching_Begin = function()
    --On (C)/(Left Control) Down
    thirdperson_state_crouching = true;
end

ALIVE_Gameplay_Player_ThirdPerson_Character_Input_Crouching_End = function()
    --On (C)/(Left Control) Up
    thirdperson_state_crouching = false;
end

----------------------------------------------------------------------
ALIVE_Gameplay_Player_ThirdPerson_Character_Input_ZombatToggle_Begin = function()
    --On R Down
    thirdperson_state_zombatReady = not thirdperson_state_zombatReady;
end

----------------------------------------------------------------------
ALIVE_Gameplay_Player_ThirdPerson_Character_Input_NoClipToggle_Begin = function()
    --On F Down

    if ALIVE_Core_Project_IsDebugMode then
        thirdperson_noclip = not thirdperson_noclip;
    end
end