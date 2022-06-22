ALIVE_Scene_LevelCleanup_403_BoardingSchoolExterior_CompositeWorldTest = function(kScene)
    --ALIVE_RemoveAgent("Horse", kScene);

    --ALIVE_RemoveAgent("adv_boardingSchoolExterior.scene", kScene);

    --------------- A ---------------
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesAGrass", kScene); --grass boarding school front left side (infront of cementary)
    ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesAShrubs", kScene); --shrubs by bell tower gate
    ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesATrees", kScene); --fallen tree by bell tower gate
    ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesABuildingBackground", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesARocks", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesATreeBackground", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesATerrain", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesAIvy", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesAGrassGraveyard", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesABuildingFront", kScene); --front columns
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesABuildingLeft", kScene); --burned down building
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesABuildingIvy", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesATerrainClutter", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesABuilding", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesATreeFlats", kScene); --might work, but is too close to the bell tower

    --------------- B ---------------
    ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesBBuildingBackground", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesBTrees", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesBGrass", kScene); --grass boarding school front right side (infront of dorms but on left side)
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesBRocks", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesBShrubs", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesBTreeBackground", kScene); --might work, but again to close to bell tower
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesBBuildingIvy", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesBTerrainClutter", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesBBuilding", kScene); --dorm building left

    --------------- C ---------------
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesCTrees", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesCGrass", kScene); --grass boarding school front of basement entry
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesCRocks", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesCShrubs", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesCBuildingIvy", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesCTreeBackground", kScene); --intersect with exterior gate
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesCTerrainClutter", kScene); --boarding school wall gate left side + basement
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesCBuilding", kScene); --dorm building right

    --------------- D ---------------
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesDGrass", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesDRocks", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesDShrubs", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesDTreeBackground", kScene); --would work great except it also intersects with exterior gate
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesDTrees", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesDGate", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesDTerrainClutter", kScene); --boarding school wall gate right side
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesDBuilding", kScene); --background building behind dorms
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesDIvy", kScene);

    ALIVE_RemoveAgent("Violet", kScene);
    ALIVE_RemoveAgent("Tennyson", kScene);
    ALIVE_RemoveAgent("Marlon", kScene);
    ALIVE_RemoveAgent("Willy", kScene);
    ALIVE_RemoveAgent("Omar", kScene);
    ALIVE_RemoveAgent("Clementine", kScene);

    ALIVE_RemoveAgent("group_skydome", kScene);
    ALIVE_RemoveAgent("group_sun", kScene);

    ALIVE_RemoveAgent("fx_camPollen", kScene);
    ALIVE_RemoveAgent("fx_bloodFloorDecalsA", kScene);
    ALIVE_RemoveAgent("fx_lightShaft401", kScene);
    ALIVE_RemoveAgent("fxa_collisionFloorA", kScene);
    ALIVE_RemoveAgent("fxa_collisionDecalA", kScene);
    ALIVE_RemoveAgent("fxg_bloodBleedDirRad", kScene);
    ALIVE_RemoveAgent("fxg_bloodBleedDirRad01", kScene);
    ALIVE_RemoveAgent("fxg_bloodBleedDirRad02", kScene);
    ALIVE_RemoveAgent("fxg_cookingFire", kScene);
    ALIVE_RemoveAgent("fxg_campFire", kScene);

    ALIVE_RemoveAgent("module_post_effect", kScene);
    ALIVE_RemoveAgent("module_environment", kScene);
    ALIVE_RemoveAgent("module_lightprobe", kScene);

    ALIVE_RemoveAgent("keylight_node_exterior", kScene);
    ALIVE_RemoveAgent("keylight_node_DormDoor", kScene);

    ALIVE_RemoveAgent("trigger_cam_orbit", kScene);

    ALIVE_RemoveAgent("audio_eventEmitter_boardingSchoolExterior1", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_boardingSchoolExterior2", kScene);
    ALIVE_RemoveAgent("audio_eventPreloadInterface_boardingSchoolExterior", kScene);
    ALIVE_RemoveAgent("audio_listenerInterface_boardingSchoolExterior", kScene);
    ALIVE_RemoveAgent("audio_reverbInterface_boardingSchoolExterior", kScene);
    ALIVE_RemoveAgent("audio_sfxInterface_boardingSchoolExterior", kScene);
    ALIVE_RemoveAgent("audio_snapshotEmitter_boardingSchoolExterior", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_fire", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_ambSweetener_1", kScene);

    ALIVE_RemoveAgent("lightrig_CC_willy", kScene);
    ALIVE_RemoveAgent("lightrig_CC_violet", kScene);
    ALIVE_RemoveAgent("lightrig_CC_tennyson", kScene);
    ALIVE_RemoveAgent("lightrig_CC_marlon", kScene);
    ALIVE_RemoveAgent("lightrig_CC_omar", kScene);
    ALIVE_RemoveAgent("lightrig_CC_clementine", kScene);

    ALIVE_RemoveAgent("light_CHAR_CC_Willy_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Willy_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Willy_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Violet_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Violet_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Violet_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Tennyson_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Tennyson_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Tennyson_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Marlon_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Marlon_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Marlon_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Omar_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Omar_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Omar_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Clementine_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Clementine_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Clementine_Rim", kScene);

    --ALIVE_RemoveAgent("light_AMB_0", kScene);
    --ALIVE_RemoveAgent("light_AMB_grassIvy", kScene);
    --ALIVE_RemoveAgent("light_AMB_MatteTrees", kScene);
    --ALIVE_RemoveAgent("light_ENV_ambFill", kScene);
    --ALIVE_RemoveAgent("light_ENV_D_SunKey", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill01", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill02", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill03", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill04", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill05", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill06", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill07", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill08", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill09", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill10", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill11", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce01", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce02", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce03", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill12", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill13", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill14", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill15", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill16", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce04", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill17", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill18", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce05", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce06", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce07", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce08", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce09", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce10", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce11", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill19", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill20", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill21", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill22", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill23", kScene);

    --ALIVE_RemoveAgent("light_SKY_amb", kScene);
    --ALIVE_RemoveAgent("light_SKY_horizonSpot", kScene);
    --ALIVE_RemoveAgent("light_SKY_sunPoint", kScene);
    --ALIVE_RemoveAgent("light_SKY_sunBroadLight", kScene);
    --ALIVE_RemoveAgent("light_SKY_sunPoint01", kScene);

    ALIVE_RemoveAgent("light_gobo_trainStation_buildingStripe03", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingStripe04", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingLeafy", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingLeafy01", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingLeafyInvert", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingLeafyInvert01", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingStripe05", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingLeafyInvertStripes", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingLeafyInvertStripes01", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingLeafyInvertStripes02", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingLeafy02", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingStripe", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingStripe01", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingStripe02", kScene);

    ALIVE_RemoveAgent("cam_cutscene", kScene);
    ALIVE_RemoveAgent("cam_cutsceneChore", kScene);
    ALIVE_RemoveAgent("cam_clementine_CU", kScene);
    ALIVE_RemoveAgent("cam_clementine_MED", kScene);
    ALIVE_RemoveAgent("cam_clementine_OTS", kScene);
    ALIVE_RemoveAgent("cam_marlon_CU", kScene);
    ALIVE_RemoveAgent("cam_marlon_MED", kScene);
    ALIVE_RemoveAgent("cam_marlon_OTS", kScene);
    ALIVE_RemoveAgent("cam_willy_CU", kScene);
    ALIVE_RemoveAgent("cam_willy_MED", kScene);
    ALIVE_RemoveAgent("cam_willy_OTS", kScene);
    ALIVE_RemoveAgent("cam_walkTracking", kScene);
    ALIVE_RemoveAgent("cam_walkTracking_parent", kScene);

    ALIVE_RemoveAgent("obj_matteForestTileRing", kScene);
    ALIVE_RemoveAgent("obj_watchtowerBoardingSchoolExterior", kScene);
    ALIVE_RemoveAgent("obj_woodArrowSpearA", kScene);
    ALIVE_RemoveAgent("obj_picnicTableBoardingSchoolExterior", kScene);
    ALIVE_RemoveAgent("obj_gatePedestrianBoardingSchoolExterior", kScene);
    ALIVE_RemoveAgent("obj_doorBreezewayBoardingSchoolExterior", kScene);
    ALIVE_RemoveAgent("obj_doorDormRoomBoardingSchoolExterior", kScene);
    --ALIVE_RemoveAgent("obj_skydome", kScene);
    --ALIVE_RemoveAgent("obj_skydomeOverheadClouds", kScene);
    --ALIVE_RemoveAgent("obj_skydomeSun", kScene);
    ALIVE_RemoveAgent("obj_doorCellarBoardingSchoolLeft", kScene);
    ALIVE_RemoveAgent("obj_doorCellarBoardingSchoolRight", kScene);
    ALIVE_RemoveAgent("obj_bonfireBoardingSchoolExterior", kScene);
    ALIVE_RemoveAgent("obj_picnicTableBoardingSchoolExteriorB", kScene);
    ALIVE_RemoveAgent("obj_picnicTableBoardingSchoolExteriorC", kScene);
    ALIVE_RemoveAgent("obj_chairsBoardingSchoolExteriorA", kScene);
    ALIVE_RemoveAgent("obj_couchBoardingSchoolExteriorA", kScene);
    ALIVE_RemoveAgent("obj_couchBoardingSchoolExteriorB", kScene);
    ALIVE_RemoveAgent("obj_chairDeskBoardingSchoolExterior", kScene);
    ALIVE_RemoveAgent("obj_deskBoardingSchoolExterior", kScene);
    ALIVE_RemoveAgent("obj_logFireWoodForrestShackB", kScene);
    ALIVE_RemoveAgent("obj_logFireWoodForrestShackA", kScene);
    ALIVE_RemoveAgent("obj_poleFlagBoardingSchoolExterior", kScene);
    ALIVE_RemoveAgent("obj_puddleBoardingSchoolExterior", kScene);
    ALIVE_RemoveAgent("obj_lookAtClementine", kScene);
    ALIVE_RemoveAgent("obj_lookAtClementineEyes", kScene);
    ALIVE_RemoveAgent("obj_lookAtViolet", kScene);
    ALIVE_RemoveAgent("obj_lookAtVioletEyes", kScene);
    ALIVE_RemoveAgent("obj_lookAtTennyson", kScene);
    ALIVE_RemoveAgent("obj_lookAtTennysonEyes", kScene);
    ALIVE_RemoveAgent("obj_lookAtMarlon", kScene);
    ALIVE_RemoveAgent("obj_lookAtMarlonEyes", kScene);
    ALIVE_RemoveAgent("obj_lookAtWilly", kScene);
    ALIVE_RemoveAgent("obj_lookAtWillyEyes", kScene);
    ALIVE_RemoveAgent("obj_lookAtOmar", kScene);
    ALIVE_RemoveAgent("obj_lookAtOmarEyes", kScene);

end