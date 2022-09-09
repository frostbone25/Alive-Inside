--|||||||||||||||||||||||||||||||||||||||||||||| 3RD PERSON CONTROLLER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| 3RD PERSON CONTROLLER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| 3RD PERSON CONTROLLER ||||||||||||||||||||||||||||||||||||||||||||||

require("ALIVE_Gameplay_Player_ThirdPerson_Input.lua");
require("ALIVE_Gameplay_Player_ThirdPerson_Camera.lua");
require("ALIVE_Gameplay_Player_ThirdPerson_Character.lua");
require("ALIVE_Gameplay_Player_ThirdPerson_Death.lua");
require("ALIVE_Gameplay_Player_ThirdPerson_Zombat.lua");
require("ALIVE_Gameplay_Player_ThirdPerson_UI.lua");

-------------------------- PROPERTIES - OBJECT NAMES --------------------------
thirdperson_name_character = "AJ";
--thirdperson_name_character = "ClemYoung";
thirdperson_name_characterProp = "sk63_aj.prop";
--thirdperson_name_characterProp = "sk63_clementineFlashback.prop";
thirdperson_name_characterParent = thirdperson_name_character .. "_Parent"; 
thirdperson_name_camera = "Player_ThirdPersonCamera";
thirdperson_name_groupCamera = "Player_ThirdPersonParentCamera";
thirdperson_name_animGroupCamera = "Player_ThirdPersonAnimationParentCamera";
thirdperson_name_desiredCameraPositionObject = "Player_ThirdPersonDesiredCameraObject";
thirdperson_name_dummyObject = "Player_ThirdPersonDummyObject";
thirdperson_name_dummyObjectHip = "Player_ThirdPersonDummyHipObject";
thirdperson_name_knife = "Player_KnifeObject";
thirdperson_sceneWbox = "";
--thirdperson_sceneWbox = "adv_riverShoreline.wbox";
--thirdperson_sceneWbox = "adv_riverShorelineNight.wbox";
--thirdperson_sceneWbox = "adv_riverShorelineNight_dock.wbox";

-------------------------- PROPERTIES - STATES --------------------------
thirdperson_state_moving = false;
thirdperson_state_running = false;
thirdperson_state_crouching = false;
thirdperson_state_zombieStation = false;
thirdperson_state_dying = false;
thirdperson_state_zombatReady = false;
thirdperson_noclip = false;

-------------------------- PROPERTIES - THIRD PERSON CONTROLLER --------------------------
thirdperson_constrainToWBOX = true;

-------------------------- PROPERTIES - AGENTS --------------------------
--to reduce the amount of AgentFindInScene calls we make, which can be expensive
thirdperson_agent_character = nil;
thirdperson_agent_characterParent = nil;
thirdperson_agent_camera = nil;
thirdperson_agent_cameraParent = nil;
thirdperson_agent_cameraAnimParent = nil;
thirdperson_agent_cameraDummy = nil;
thirdperson_agent_cameraHipDummy = nil;
thirdperson_agent_knife = nil;

-------------------------- PROPERTIES - SHARED VARIABLES --------------------------
thirdperson_frameTime = 0.0;
thirdperson_inputDirection_x = 0;
thirdperson_inputDirection_y = 0;
thirdperson_inputDirection_z = 0;
thirdperson_movementVector = Vector(0, 0, 0);
thirdperson_characterDirection = Vector(0, 0, 0);
ALIVE_Gameplay_AI_Zombies_CurrentStationedZombieObject = nil;

--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CONTROLLER SETUP ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Gameplay_CreateThirdPersonController = function(startingPosition, kScene, useWbox, wbox)

    if (useWbox ~= nil) and (wbox ~= nil) then
        thirdperson_constrainToWBOX = useWbox;
        thirdperson_sceneWbox = wbox;
    end

    -----------------------------------------------
    --base character
    ALIVE_Gameplay_Player_ThirdPerson_Character_CreateCharacter(startingPosition)

    Callback_OnPostUpdate:Add(ALIVE_Gameplay_Player_ThirdPerson_Character_UpdateInput);
    Callback_OnPostUpdate:Add(ALIVE_Gameplay_Player_ThirdPerson_Character_UpdateCharacter);
    Callback_OnPostUpdate:Add(ALIVE_Gameplay_Player_ThirdPerson_Character_UpdateCharacterAnimation);

    -----------------------------------------------
    --base camera
    ALIVE_Gameplay_Player_ThirdPerson_Camera_CreateCamera();

    Callback_OnPostUpdate:Add(ALIVE_Gameplay_Player_ThirdPerson_Camera_UpdateInput);
    Callback_OnPostUpdate:Add(ALIVE_Gameplay_Player_ThirdPerson_Camera_UpdateCamera);
    Callback_OnPostUpdate:Add(ALIVE_Gameplay_Player_ThirdPerson_Camera_UpdateCameraAnimation);

    -----------------------------------------------
    --base UI
    --ALIVE_Gameplay_Player_ThirdPerson_UI_CreateUI();

    if ALIVE_Gameplay_Player_ThirdPerson_UI_Init(kScene) then
        Callback_OnPostUpdate:Add(ALIVE_Gameplay_Player_ThirdPerson_UI_UpdateUI);
    end
    
    -----------------------------------------------
    --extra components
    Callback_OnPostUpdate:Add(ALIVE_Gameplay_Player_ThirdPerson_Zombat_SetZombieStation);
    Callback_OnPostUpdate:Add(ALIVE_Gameplay_Player_ThirdPerson_Zombat_Main);
    Callback_OnPostUpdate:Add(ALIVE_Gameplay_Player_ThirdPerson_Death_Main);

    print("TPC - InputMapperActivate")
    InputMapperActivate("Alive_Gameplay_Player_ThirdPerson.imap");
end