ALIVE_Scene_LevelCleanup_404_BoardingSchoolDorm = function(kScene)
    --main scene agent (post processing, and other importance scene properties)
    --ALIVE_RemoveAgent("adv_boardingSchoolDorm.scene", kScene);

    ALIVE_RemoveAgent("audio_eventPreloadInterface_boardingSchoolDorm", kScene);
    ALIVE_RemoveAgent("audio_listenerInterface_boardingSchoolDorm", kScene);
    ALIVE_RemoveAgent("audio_reverbInterface_boardingSchoolDorm", kScene);
    ALIVE_RemoveAgent("audio_sfxInterface_boardingSchoolDorm", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_windowWind_3D", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_windowWind_3D_1", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_boardingSchoolDorm1", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_boardingSchoolDorm2", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_windowWind_3D_2", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_windowWind_3D_3", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_windowWind_3D_4", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_windowWind_3D_5", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_windowWind_3D_6", kScene);

    ALIVE_RemoveAgent("cam_orbit_horizontal", kScene);
    ALIVE_RemoveAgent("cam_orbit_vertical", kScene);
    ALIVE_RemoveAgent("cam_orbit_parent", kScene);
    ALIVE_RemoveAgent("cam_orbit", kScene);
    ALIVE_RemoveAgent("cam_cutscene", kScene);
    ALIVE_RemoveAgent("cam_cutsceneChore", kScene);
    ALIVE_RemoveAgent("cam_aJ_CU", kScene);
    ALIVE_RemoveAgent("cam_aJ_MED", kScene);
    ALIVE_RemoveAgent("cam_aJ_OTS", kScene);
    ALIVE_RemoveAgent("cam_rosie_CU", kScene);
    ALIVE_RemoveAgent("cam_rosie_MED", kScene);
    ALIVE_RemoveAgent("cam_rosie_OTS", kScene);

    ALIVE_RemoveAgent("module_lightprobe", kScene);
    ALIVE_RemoveAgent("module_post_effect", kScene);

    ALIVE_RemoveAgent("fxa_collisionFloorA", kScene);
    ALIVE_RemoveAgent("fxa_collisionDecalA", kScene);
    ALIVE_RemoveAgent("fx_camDustMotes", kScene);
    ALIVE_RemoveAgent("fx_forceBackBufferStaticObj", kScene);
    ALIVE_RemoveAgent("fx_rosieCrumbs", kScene);
    ALIVE_RemoveAgent("fx_lightShaft401", kScene);
    ALIVE_RemoveAgent("fx_lightShaft402", kScene);
    ALIVE_RemoveAgent("fx_lightShaft403", kScene);
    ALIVE_RemoveAgent("fx_lightShaft404", kScene);
    ALIVE_RemoveAgent("fx_lightShaft405", kScene);
    ALIVE_RemoveAgent("fx_lightShaft406", kScene);

    ALIVE_RemoveAgent("group_skydome", kScene);
    ALIVE_RemoveAgent("group_sun", kScene);
    ALIVE_RemoveAgent("group_collectibleSlots", kScene);

    ALIVE_RemoveAgent("AJ", kScene);
    ALIVE_RemoveAgent("Rosie", kScene);

    ALIVE_RemoveAgent("ui_thankyou", kScene);

    ALIVE_RemoveAgent("trigger_dialog_hatTutorial", kScene);

    ALIVE_RemoveAgent("blocker_door1", kScene);
    ALIVE_RemoveAgent("blocker_door2", kScene);

    ALIVE_RemoveAgent("light_NODE_dormHallway01Noon", kScene);
    ALIVE_RemoveAgent("light_NODE_dormClemRoom", kScene);

    --ALIVE_RemoveAgent("light_AMB_0", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon_sunHotspotMiddle", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon_sunHotspotLeft", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon_sunHotspotRight", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway02Noon_sunHotspotMiddle", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway02Noon_sunHotspotLeft", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway02Noon_sunHotspotRight", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway02Noon_sunKeyLeft", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway02Noon_sunKeyMiddle", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway02Noon_sunKeyRight", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon_sunKeyMiddle", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon_sunKeyLeft", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway03Noon_sunKeyLeft", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway02Noon", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway03Noon", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway02Noon_sunKeyCorner02", kScene);
    --ALIVE_RemoveAgent("light_ENV_clemsRoomNoon_sunKey", kScene);
    --ALIVE_RemoveAgent("light_ENV_clemsRoomNoon_sunHotspot", kScene);
    --ALIVE_RemoveAgent("light_ENV_clemsRoomNoon_sunBounceDoor", kScene);
    --ALIVE_RemoveAgent("light_ENV_clemsRoomNoon_sunBounceWindow", kScene);
    --ALIVE_RemoveAgent("light_ENV_clemsRoomNoon", kScene);
    ALIVE_RemoveAgent("light_ENV_clemsRoomNoon_ajDrawing01", kScene);
    ALIVE_RemoveAgent("light_ENV_clemsRoomNoon_vase", kScene);
    ALIVE_RemoveAgent("light_ENV_clemsRoomNoon_deerSkull", kScene);
    ALIVE_RemoveAgent("light_ENV_clemsRoomNoon_rockLight", kScene);
    ALIVE_RemoveAgent("light_ENV_clemsRoomNoon_brocolliKey", kScene);
    --ALIVE_RemoveAgent("light_ENV_clemsRoomNoon_sunKeyNX", kScene);
    --ALIVE_RemoveAgent("light_ENV_clemsRoomNoon_sunHotspotNX", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon_sunHotspotLeft01", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon_sunKeyCorner02", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon_windowFrame01", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon_keyLight02", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway02Noon_sunKeyCorner03", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon_sunKeyRight", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway03Noon_sunKeyRight", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway03Noon_sunKeyMiddle", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon_windowFrame02", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon_sunKeyCorner01", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon_sunHotspotLeft01NX", kScene);
    --ALIVE_RemoveAgent("light_SKY_amb", kScene);
    ALIVE_RemoveAgent("light_SKY_horizonSpot", kScene);
    ALIVE_RemoveAgent("light_SKY_sunPoint", kScene);
    ALIVE_RemoveAgent("light_SKY_sunBroadLight", kScene);
    ALIVE_RemoveAgent("light_SKY_sunPoint01", kScene);
    ALIVE_RemoveAgent("light_SKY_sunPoint02", kScene);
    ALIVE_RemoveAgent("light_SKY_ambNX", kScene);
    ALIVE_RemoveAgent("light_SKY_sunPointNX", kScene);

    ALIVE_RemoveAgent("lightrig_CC_obj_gunrevolver", kScene);
    ALIVE_RemoveAgent("lightrig_CC_rosie", kScene);
    ALIVE_RemoveAgent("lightrig_CC_aj", kScene);
    ALIVE_RemoveAgent("lightrig_CC_obj_capclementine400", kScene);
    ALIVE_RemoveAgent("lightrig_CC_obj_toybroccoli", kScene);
    ALIVE_RemoveAgent("lightrig_CC_obj_vaseflowersreal", kScene);
    ALIVE_RemoveAgent("lightrig_CC_obj_flowersmeadowcranesbill", kScene);
    ALIVE_RemoveAgent("lightrig_CC_obj_chairwooda", kScene);

    ALIVE_RemoveAgent("light_CHAR_CC_obj_gunRevolver_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_gunRevolver_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_gunRevolver_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Rosie_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Rosie_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Rosie_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_AJ_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_AJ_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_AJ_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_capClementine400_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_capClementine400_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_capClementine400_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_toyBroccoli_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_toyBroccoli_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_toyBroccoli_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_vaseFlowersReal_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_vaseFlowersReal_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_vaseFlowersReal_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_flowersMeadowCranesbill_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_flowersMeadowCranesbill_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_flowersMeadowCranesbill_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_chairWoodA_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_chairWoodA_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_chairWoodA_Rim", kScene);

    ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesACeiling", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAWallsExterior", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAFoliage", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAGlass", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAWindowsDoors404", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAWalls404", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAPipes404", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAFloor404", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesACoatStand404", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAClem", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAClemCloth", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAClemCobwebs", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAClemPipes", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAClemCeiling", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAClemFloor", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAClemFurniture404", kScene);

    ALIVE_RemoveAgent("obj_chairWoodA", kScene);
    ALIVE_RemoveAgent("obj_chinaCabinetBoardingSchool", kScene);
    ALIVE_RemoveAgent("obj_doorClemBoardingSchoolDorm", kScene);
    ALIVE_RemoveAgent("obj_doorEntranceBoardingSchoolDorm", kScene);
    ALIVE_RemoveAgent("obj_doorVestibuleABoardingSchoolDorm", kScene);
    ALIVE_RemoveAgent("obj_doorVestibuleBBoardingSchoolDorm", kScene);
    ALIVE_RemoveAgent("obj_doorClosetClemABoardingSchoolDorm", kScene);
    --ALIVE_RemoveAgent("obj_drawerBoardingSchoolDorm", kScene);
    ALIVE_RemoveAgent("obj_drawerDeskABoardingSchoolDorm", kScene);
    ALIVE_RemoveAgent("obj_pillowBoardingSchoolDorm1", kScene);
    ALIVE_RemoveAgent("obj_matteBoardingSchoolWindowFillA", kScene);
    --ALIVE_RemoveAgent("obj_skydome", kScene);
    ALIVE_RemoveAgent("obj_skydomeOverheadClouds", kScene);
    ALIVE_RemoveAgent("obj_skydomeSun", kScene);
    ALIVE_RemoveAgent("obj_grassClumpA", kScene);
    ALIVE_RemoveAgent("obj_grassClumpA01", kScene);
    ALIVE_RemoveAgent("obj_grassClumpA02", kScene);
    ALIVE_RemoveAgent("obj_grassClumpA03", kScene);
    ALIVE_RemoveAgent("obj_grassClumpA04", kScene);
    ALIVE_RemoveAgent("obj_grassClumpA05", kScene);
    --ALIVE_RemoveAgent("obj_grassClumpA06", kScene); --grass by dorm window
    ALIVE_RemoveAgent("obj_treeMapleHiRez", kScene);
    --ALIVE_RemoveAgent("obj_matteForestTileRing", kScene); --main skybox forest tile matte
    ALIVE_RemoveAgent("obj_pillowBoardingSchoolDorm2", kScene);
    ALIVE_RemoveAgent("obj_drawingAJ", kScene);
    ALIVE_RemoveAgent("obj_drawingTenn", kScene);
    ALIVE_RemoveAgent("obj_drawingTennNoClem", kScene);
    ALIVE_RemoveAgent("obj_skullCat", kScene);
    ALIVE_RemoveAgent("obj_skullDeer", kScene);
    ALIVE_RemoveAgent("obj_vaseFlowersFake", kScene);
    ALIVE_RemoveAgent("obj_vaseFlowersReal", kScene);
    ALIVE_RemoveAgent("obj_flowersDaffodilFake", kScene);
    ALIVE_RemoveAgent("obj_flowersMeadowCranesbill", kScene);
    ALIVE_RemoveAgent("obj_plantVenusFlyTrap", kScene);
    ALIVE_RemoveAgent("obj_skullBoar", kScene);
    ALIVE_RemoveAgent("obj_mushroomPotted", kScene);
    ALIVE_RemoveAgent("obj_toyBeet", kScene);
    ALIVE_RemoveAgent("obj_horseshoe", kScene);
    ALIVE_RemoveAgent("obj_pennantSchoolEricson", kScene);
    ALIVE_RemoveAgent("obj_rabbitsFoot", kScene);
    ALIVE_RemoveAgent("obj_toySketchPad", kScene);
    ALIVE_RemoveAgent("obj_windChimesBroken", kScene);
    ALIVE_RemoveAgent("obj_logicalSlotCrystal", kScene);
    ALIVE_RemoveAgent("obj_logicalSlotCalypso", kScene);
    ALIVE_RemoveAgent("obj_logicalSlotHat", kScene);
    ALIVE_RemoveAgent("obj_logicalSlotMask", kScene);
    ALIVE_RemoveAgent("obj_logicalSlotSkull", kScene);
    ALIVE_RemoveAgent("obj_toyBroccoli", kScene);
    ALIVE_RemoveAgent("obj_toyCauliflower", kScene);
    ALIVE_RemoveAgent("obj_toyRhubarb", kScene);
    ALIVE_RemoveAgent("obj_gramophone", kScene);
    ALIVE_RemoveAgent("obj_recordGramophone", kScene);
    ALIVE_RemoveAgent("obj_jamesSkinMask", kScene);
    ALIVE_RemoveAgent("obj_capClementine400", kScene);
    ALIVE_RemoveAgent("obj_skullHuman", kScene);
    ALIVE_RemoveAgent("obj_crystal", kScene);
    ALIVE_RemoveAgent("obj_drawingAJLouis", kScene);
    ALIVE_RemoveAgent("obj_drawingAJViolet", kScene);
    ALIVE_RemoveAgent("obj_lookAtAJ", kScene);
    ALIVE_RemoveAgent("obj_lookAtAJEyes", kScene);
    ALIVE_RemoveAgent("obj_lookAtRosie", kScene);
    ALIVE_RemoveAgent("obj_lookAtRosieEyes", kScene);
end