ALIVE_Scene_LevelCleanup_403_BoardingSchoolDorm = function(kScene)
    --main scene agent (post processing, and other importance scene properties)
    --ALIVE_RemoveAgent("adv_boardingSchoolDorm.scene", kScene);
    
    ALIVE_RemoveAgent("Clementine", kScene);
    ALIVE_RemoveAgent("AJ", kScene);
    ALIVE_RemoveAgent("Louis", kScene);
    ALIVE_RemoveAgent("Violet", kScene);
    ALIVE_RemoveAgent("Ruby", kScene);

    ALIVE_RemoveAgent("cam_cutscene", kScene);
    ALIVE_RemoveAgent("cam_cutsceneChore", kScene);
    ALIVE_RemoveAgent("cam_clementine_CU", kScene);
    ALIVE_RemoveAgent("cam_clementine_MED", kScene);
    ALIVE_RemoveAgent("cam_clementine_OTS", kScene);
    ALIVE_RemoveAgent("cam_orbit_horizontal", kScene);
    ALIVE_RemoveAgent("cam_orbit_vertical", kScene);
    ALIVE_RemoveAgent("cam_orbit_parent", kScene);
    ALIVE_RemoveAgent("cam_orbit", kScene);
    ALIVE_RemoveAgent("cam_louis_OTS", kScene);
    ALIVE_RemoveAgent("cam_aJ_CU", kScene);
    ALIVE_RemoveAgent("cam_aJ_MED", kScene);
    ALIVE_RemoveAgent("cam_aJ_OTS", kScene);
    ALIVE_RemoveAgent("cam_louis_CU", kScene);
    ALIVE_RemoveAgent("cam_louis_MED", kScene);
    ALIVE_RemoveAgent("cam_violet_CU", kScene);
    ALIVE_RemoveAgent("cam_violet_MED", kScene);
    ALIVE_RemoveAgent("cam_violet_OTS", kScene);
    ALIVE_RemoveAgent("cam_station_button", kScene);
    ALIVE_RemoveAgent("cam_station_button_parent", kScene);
    ALIVE_RemoveAgent("cam_ruby_CU", kScene);
    ALIVE_RemoveAgent("cam_ruby_MED", kScene);
    ALIVE_RemoveAgent("cam_ruby_OTS", kScene);
    ALIVE_RemoveAgent("cam_station_sketchpad", kScene);

    ALIVE_RemoveAgent("audio_eventEmitter_boardingSchoolDorm1", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_boardingSchoolDorm2", kScene);
    ALIVE_RemoveAgent("audio_eventPreloadInterface_boardingSchoolDorm", kScene);
    ALIVE_RemoveAgent("audio_listenerInterface_boardingSchoolDorm", kScene);
    ALIVE_RemoveAgent("audio_reverbInterface_boardingSchoolDorm", kScene);
    ALIVE_RemoveAgent("audio_sfxInterface_boardingSchoolDorm", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_windowWind_3D", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_windowWind_3D_1", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_dorm_room", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_chimes", kScene);

    --ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesACeiling", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAClem", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAFloor", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAPipes", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAWalls", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAWallsExterior", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAWindowsDoors", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAClemFurniture", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAFoliage", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAGlass", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAClemCloth", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAClemCobwebs", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAClemPipes", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAClemCeiling", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolDorm_meshesAClemFloor", kScene);

    ALIVE_RemoveAgent("fx_camDustMotes", kScene);
    ALIVE_RemoveAgent("fx_bloodFloorDecalsA", kScene);
    ALIVE_RemoveAgent("fx_lightShaft401", kScene);
    ALIVE_RemoveAgent("fx_lightShaft402", kScene);
    ALIVE_RemoveAgent("fx_lightShaft403", kScene);
    ALIVE_RemoveAgent("fx_forceBackBufferStaticObj", kScene);
    ALIVE_RemoveAgent("fx_matchOutSmoke", kScene);
    ALIVE_RemoveAgent("fx_etchASketchLine", kScene);
    ALIVE_RemoveAgent("fx_candleOutSmoke", kScene);

    ALIVE_RemoveAgent("fxa_collisionDecalA", kScene);
    ALIVE_RemoveAgent("fxa_collisionFloorA", kScene);

    ALIVE_RemoveAgent("fxg_bloodBleedDirRad", kScene);
    ALIVE_RemoveAgent("fxg_bloodBleedDirRad01", kScene);
    ALIVE_RemoveAgent("fxg_bloodBleedDirRad02", kScene);

    --ALIVE_RemoveAgent("module_lightprobe", kScene);
    ALIVE_RemoveAgent("module_post_effect", kScene);

    ALIVE_RemoveAgent("qte_boardingSchoolDorm", kScene);

    ALIVE_RemoveAgent("group_skydome", kScene);
    ALIVE_RemoveAgent("group_sun", kScene);
    ALIVE_RemoveAgent("group_collectibleSlots", kScene);

    ALIVE_RemoveAgent("light_NODE_clemsRoomNoon", kScene);
    ALIVE_RemoveAgent("light_NODE_dormHallway03Noon", kScene);
    ALIVE_RemoveAgent("light_NODE_dormHallway01Noon", kScene);
    ALIVE_RemoveAgent("light_NODE_dormHallway02Noon", kScene);

    --[[
    ALIVE_RemoveAgent("light_AMB_0", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon_sunHotspotMiddle", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon_sunHotspotLeft", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon_sunHotspotRight", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway02Noon_sunHotspotMiddle", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway02Noon_sunHotspotLeft", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway02Noon_sunHotspotRight", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway03Noon_sunHotspotMiddle", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway03Noon_sunHotspotLeft", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway03Noon_sunHotspotRight", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway02Noon_sunKeyLeft", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway02Noon_sunKeyMiddle", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway02Noon_sunKeyRight", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon_sunKeyMiddle", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon_sunKeyRight", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon_sunKeyLeft", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway03Noon_sunKeyLeft", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway03Noon_sunKeyMiddle", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway03Noon_sunKeyRight", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway02Noon_sunKeyCorner01", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway02Noon", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway03Noon", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway02Noon_sunKeyCorner02", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon_sunKeyCorner", kScene);
    ALIVE_RemoveAgent("light_ENV_clemsRoomNoon_sunKey", kScene);
    ALIVE_RemoveAgent("light_ENV_clemsRoomNoon_sunHotspot", kScene);
    ALIVE_RemoveAgent("light_ENV_clemsRoomNoon_sunBounceDoor", kScene);
    ALIVE_RemoveAgent("light_ENV_clemsRoomNoon_sunBounceWindow", kScene);
    ALIVE_RemoveAgent("light_ENV_clemsRoomNoon", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon_sunKeyCorner01", kScene);
    ALIVE_RemoveAgent("light_ENV_P_flame01", kScene);
    ALIVE_RemoveAgent("light_ENV_ambFIll", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon_sunBounce01", kScene);
    ALIVE_RemoveAgent("light_ENV_dormHallway01Noon_sunBounce02", kScene);
    ALIVE_RemoveAgent("light_ENV_clemsRoomNoon_sunBounceDoor01", kScene);
    ALIVE_RemoveAgent("light_ENV_clemsRoomNoon_sunBounceDoor02", kScene);
    ]]--

    --ALIVE_RemoveAgent("light_SKY_amb", kScene);
    ALIVE_RemoveAgent("light_SKY_horizonSpot", kScene);
    ALIVE_RemoveAgent("light_SKY_sunPoint", kScene);
    ALIVE_RemoveAgent("light_SKY_sunBroadLight", kScene);
    ALIVE_RemoveAgent("light_SKY_sunPoint01", kScene);
    ALIVE_RemoveAgent("light_SKY_sunPoint02", kScene);

    ALIVE_RemoveAgent("lightrig_CC_clementine", kScene);
    ALIVE_RemoveAgent("lightrig_CC_violet", kScene);
    ALIVE_RemoveAgent("lightrig_CC_ruby", kScene);
    ALIVE_RemoveAgent("lightrig_CC_louis", kScene);
    ALIVE_RemoveAgent("lightrig_CC_aj", kScene);
    ALIVE_RemoveAgent("lightrig_CC_obj_drawingajviolet", kScene);
    ALIVE_RemoveAgent("lightrig_CC_obj_buttonpinromance", kScene);
    ALIVE_RemoveAgent("lightrig_CC_obj_buttonpinfriendship", kScene);
    ALIVE_RemoveAgent("lightrig_CC_obj_chairwooda", kScene);
    ALIVE_RemoveAgent("lightrig_CC_obj_toybeet", kScene);
    ALIVE_RemoveAgent("lightrig_CC_obj_horseshoe", kScene);
    ALIVE_RemoveAgent("lightrig_CC_obj_rabbitsfoot", kScene);
    ALIVE_RemoveAgent("lightrig_CC_obj_ballbeach", kScene);
    ALIVE_RemoveAgent("lightrig_CC_obj_drawingajlouis", kScene);
    ALIVE_RemoveAgent("lightrig_CC_obj_pretzelsnack_clem", kScene);
    ALIVE_RemoveAgent("lightrig_CC_obj_pretzelsnack_louis", kScene);

    ALIVE_RemoveAgent("light_CHAR_CC_Clementine_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Clementine_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Clementine_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Violet_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Violet_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Violet_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Ruby_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Ruby_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Ruby_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Louis_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Louis_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Louis_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_AJ_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_AJ_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_AJ_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_drawingAJViolet_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_drawingAJViolet_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_drawingAJViolet_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_buttonPinRomance_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_buttonPinRomance_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_buttonPinRomance_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_buttonPinFriendship_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_buttonPinFriendship_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_buttonPinFriendship_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_chairWoodA_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_chairWoodA_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_chairWoodA_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_toyBeet_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_toyBeet_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_toyBeet_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_horseshoe_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_horseshoe_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_horseshoe_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_rabbitsFoot_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_rabbitsFoot_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_rabbitsFoot_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_ballBeach_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_ballBeach_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_ballBeach_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_drawingAJLouis_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_drawingAJLouis_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_drawingAJLouis_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_pretzelSnack_clem_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_pretzelSnack_clem_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_pretzelSnack_clem_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_pretzelSnack_louis_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_pretzelSnack_louis_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_pretzelSnack_louis_Fill", kScene);

    --ALIVE_RemoveAgent("obj_chairWoodA", kScene);
    --ALIVE_RemoveAgent("obj_chinaCabinetBoardingSchool", kScene);
    --ALIVE_RemoveAgent("obj_doorClemBoardingSchoolDorm", kScene);
    --ALIVE_RemoveAgent("obj_doorEntranceBoardingSchoolDorm", kScene);
    --ALIVE_RemoveAgent("obj_doorVestibuleABoardingSchoolDorm", kScene);
    --ALIVE_RemoveAgent("obj_doorVestibuleBBoardingSchoolDorm", kScene);
    --ALIVE_RemoveAgent("obj_doorClosetClemABoardingSchoolDorm", kScene);
    --ALIVE_RemoveAgent("obj_drawerBoardingSchoolDorm", kScene);
    --ALIVE_RemoveAgent("obj_drawerDeskABoardingSchoolDorm", kScene);
    --ALIVE_RemoveAgent("obj_pillowBoardingSchoolDorm1", kScene);
    --ALIVE_RemoveAgent("obj_matteBoardingSchoolWindowFillA05", kScene);
    --ALIVE_RemoveAgent("obj_skydome", kScene);
    ALIVE_RemoveAgent("obj_skydomeOverheadClouds", kScene);
    ALIVE_RemoveAgent("obj_skydomeSun", kScene);
    ALIVE_RemoveAgent("obj_grassClumpA", kScene);
    ALIVE_RemoveAgent("obj_grassClumpA01", kScene);
    ALIVE_RemoveAgent("obj_grassClumpA02", kScene);
    ALIVE_RemoveAgent("obj_grassClumpA03", kScene);
    ALIVE_RemoveAgent("obj_grassClumpA04", kScene);
    ALIVE_RemoveAgent("obj_grassClumpA05", kScene);
    ALIVE_RemoveAgent("obj_treeMapleHiRez", kScene);
    ALIVE_RemoveAgent("obj_treeMapleHiRez01", kScene);
    --ALIVE_RemoveAgent("obj_matteForestTileRing", kScene);
    ALIVE_RemoveAgent("obj_grassClumpA06", kScene);
    ALIVE_RemoveAgent("obj_treeMapleHiRez02", kScene);
    --ALIVE_RemoveAgent("obj_pillowBoardingSchoolDorm2", kScene);
    ALIVE_RemoveAgent("obj_jarBeans", kScene);
    ALIVE_RemoveAgent("obj_jarChickpeas", kScene);
    ALIVE_RemoveAgent("obj_jarCorn", kScene);
    ALIVE_RemoveAgent("obj_jarJam", kScene);
    ALIVE_RemoveAgent("obj_jarPeas", kScene);
    ALIVE_RemoveAgent("obj_jarRice", kScene);
    ALIVE_RemoveAgent("obj_bagDuffleCamo", kScene);
    ALIVE_RemoveAgent("obj_arrow", kScene);
    ALIVE_RemoveAgent("obj_arrowAlt", kScene);
    ALIVE_RemoveAgent("obj_arrowGeneric", kScene);
    ALIVE_RemoveAgent("obj_bowMarlon", kScene);
    ALIVE_RemoveAgent("obj_candle", kScene);
    ALIVE_RemoveAgent("obj_buttonPinFriendship", kScene);
    ALIVE_RemoveAgent("obj_buttonPinRomance", kScene);
    ALIVE_RemoveAgent("obj_bagChips", kScene);
    ALIVE_RemoveAgent("obj_ballBeach", kScene);
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
    ALIVE_RemoveAgent("obj_coffeeStation", kScene);
    ALIVE_RemoveAgent("obj_toyBeet", kScene);
    ALIVE_RemoveAgent("obj_horseshoe", kScene);
    ALIVE_RemoveAgent("obj_pennantSchoolEricson", kScene);
    ALIVE_RemoveAgent("obj_rabbitsFoot", kScene);
    ALIVE_RemoveAgent("obj_toySketchPad", kScene);
    ALIVE_RemoveAgent("obj_windChimesBroken", kScene);
    ALIVE_RemoveAgent("obj_logicalSlotHorseshoe", kScene);
    ALIVE_RemoveAgent("obj_logicalSlotBeetNick", kScene);
    ALIVE_RemoveAgent("obj_logicalSlotPennant", kScene);
    ALIVE_RemoveAgent("obj_logicalSlotRabbitFoot", kScene);
    ALIVE_RemoveAgent("obj_logicalSlotSketchPad", kScene);
    ALIVE_RemoveAgent("obj_logicalSlotWindChimes", kScene);
    ALIVE_RemoveAgent("obj_match", kScene);
    ALIVE_RemoveAgent("obj_matchbook", kScene);
    ALIVE_RemoveAgent("obj_gunRevolver", kScene);
    ALIVE_RemoveAgent("obj_pillowDormA", kScene);
    ALIVE_RemoveAgent("obj_pillowDormB", kScene);
    ALIVE_RemoveAgent("obj_pillowDormC", kScene);
    ALIVE_RemoveAgent("obj_pretzelSnack_clem", kScene);
    ALIVE_RemoveAgent("obj_pretzelSnack_louis", kScene);
    ALIVE_RemoveAgent("obj_pencilBlack", kScene);
    ALIVE_RemoveAgent("obj_drawingAJLouis", kScene);
    ALIVE_RemoveAgent("obj_drawingAJViolet", kScene);
    ALIVE_RemoveAgent("obj_lookAtClementine", kScene);
    ALIVE_RemoveAgent("obj_lookAtClementineEyes", kScene);
    ALIVE_RemoveAgent("obj_lookAtAJ", kScene);
    ALIVE_RemoveAgent("obj_lookAtAJEyes", kScene);
    ALIVE_RemoveAgent("obj_lookAtLouis", kScene);
    ALIVE_RemoveAgent("obj_lookAtLouisEyes", kScene);
    ALIVE_RemoveAgent("obj_lookAtViolet", kScene);
    ALIVE_RemoveAgent("obj_lookAtVioletEyes", kScene);
    ALIVE_RemoveAgent("obj_lookAtRuby", kScene);
    ALIVE_RemoveAgent("obj_lookAtRubyEyes", kScene);
end