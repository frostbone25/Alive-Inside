ALIVE_Scene_LevelCleanup_401_ForestTile = function(kScene)
    --main scene agent (post processing, and other importance scene properties)
    --ALIVE_RemoveAgent("adv_forestTile.scene", kScene);

    ALIVE_RemoveAgent("Clementine", kScene);
    ALIVE_RemoveAgent("Violet", kScene);
    ALIVE_RemoveAgent("Louis", kScene);
    ALIVE_RemoveAgent("AJ", kScene);
    ALIVE_RemoveAgent("Aasim", kScene);
    ALIVE_RemoveAgent("Brody", kScene);
    ALIVE_RemoveAgent("RabbitBaby", kScene);
    ALIVE_RemoveAgent("Rabbit", kScene);
    ALIVE_RemoveAgent("Rabbit02", kScene);
    ALIVE_RemoveAgent("Rabbit03", kScene);
    ALIVE_RemoveAgent("Zombie01", kScene);
    ALIVE_RemoveAgent("Zombie02", kScene);

    ALIVE_RemoveAgent("light_NODE_exterior", kScene);
    --ALIVE_RemoveAgent("light_AMB_0", kScene);
    --ALIVE_RemoveAgent("light_ENV_dir", kScene);
    --ALIVE_RemoveAgent("light_ENV_Ambient", kScene);
    --ALIVE_RemoveAgent("light_ENV_treeCardAmbient", kScene);
    ALIVE_RemoveAgent("light_ENV_spotFill", kScene);
    ALIVE_RemoveAgent("light_ENV_spotFill01", kScene);
    ALIVE_RemoveAgent("light_ENV_spotFill02", kScene);
    ALIVE_RemoveAgent("light_ENV_spotFill03", kScene);
    ALIVE_RemoveAgent("light_ENV_spotFill04", kScene);
    ALIVE_RemoveAgent("light_ENV_spotFill05", kScene);
    ALIVE_RemoveAgent("light_ENV_spotFill07", kScene);
    ALIVE_RemoveAgent("light_ENV_exterior_sunGoboGround01", kScene);
    ALIVE_RemoveAgent("light_ENV_exterior_sunGoboGround02", kScene);
    ALIVE_RemoveAgent("light_ENV_exterior_sunGoboGround03", kScene);
    ALIVE_RemoveAgent("light_ENV_exterior_sunGoboGround04", kScene);
    --ALIVE_RemoveAgent("light_SKY_amb", kScene);
    --ALIVE_RemoveAgent("light_SKY_horizonSpot", kScene);
    --ALIVE_RemoveAgent("light_SKY_sunPoint", kScene);
    --ALIVE_RemoveAgent("light_SKY_sunBroadLight", kScene);
    --ALIVE_RemoveAgent("light_SKY_sunPoint01", kScene);

--[[
    ---------------------- A ----------------------
    ALIVE_RemoveAgent("adv_forestTile_meshesABackGroundGrass", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesAGrass", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesATreeCards", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesATrees", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesATerrain", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesATrees01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesATreeCards01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesATerrain01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesAGrass01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesABackGroundGrass01", kScene);

    ---------------------- B ----------------------
    ALIVE_RemoveAgent("adv_forestTile_meshesBGrass", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesBRocks", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesBTerrain", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesBTreesShort", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesBTreesTall", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesBTreesTall01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesBTreesShort01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesBTerrain01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesBRocks01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesBGrass01", kScene);

    ---------------------- C ----------------------
    ALIVE_RemoveAgent("adv_forestTile_meshesCBackGroundGrass", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesCGrass", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesCTerrain", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesCTreeCards", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesCTrees", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesCTrees01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesCTreeCards01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesCTerrain01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesCGrass01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesCBackGroundGrass01", kScene);

    ---------------------- D ----------------------
    ALIVE_RemoveAgent("adv_forestTile_meshesDBackGroundGrass", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesDGrass", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesDTerrain", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesDTreeCards", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesDTrees", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesDTrees01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesDTreeCards01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesDTerrain01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesDGrass01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesDBackGroundGrass01", kScene);

    ---------------------- E ----------------------
    ALIVE_RemoveAgent("adv_forestTile_meshesEGrass", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesERocks", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesETerrain", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesETreesShort", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesETreesTall", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesETreesTall01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesETreesShort01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesETerrain01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesERocks01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesEGrass01", kScene);

    ---------------------- F ----------------------
    ALIVE_RemoveAgent("adv_forestTile_meshesFBackGroundGrass", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesFTerrain", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesFTreeCards", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesFTrees", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesFTrees01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesFTreeCards01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesFTerrain01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesFBackGroundGrass01", kScene);

    ---------------------- G ----------------------
    ALIVE_RemoveAgent("adv_forestTile_meshesGBackGroundGrass", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesGGrass", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesGTerrain", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesGTreeCards", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesGTrees", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesGTrees01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesGTreeCards01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesGTerrain01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesGGrass01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesGBackGroundGrass01", kScene);

    ---------------------- H ----------------------
    ALIVE_RemoveAgent("adv_forestTile_meshesHGrass", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesHRocks", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesHTerrain", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesHTreesShort", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesHTreesTall", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesHTreesTall01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesHTreesShort01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesHTerrain01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesHRocks01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesHGrass01", kScene);

    ---------------------- I ----------------------
    ALIVE_RemoveAgent("adv_forestTile_meshesIBackGroundGrass", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesIGrass", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesITerrain", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesITreeCards", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesITrees", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesITrees01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesITreeCards01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesITerrain01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesIGrass01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesIBackGroundGrass01", kScene);

    ---------------------- J ----------------------
    ALIVE_RemoveAgent("adv_forestTile_meshesJBackGroundGrass", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesJGrass", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesJTerrain", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesJTreeCards", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesJTrees", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesJTrees01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesJTreeCards01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesJTerrain01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesJGrass01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesJBackGroundGrass01", kScene);

    ---------------------- K ----------------------
    ALIVE_RemoveAgent("adv_forestTile_meshesKGrass", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesKRocks", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesKTerrain", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesKTreeTall", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesKTreesShort", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesKTreesShort01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesKTreeTall01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesKTerrain01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesKRocks01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesKGrass01", kScene);

    ---------------------- L ----------------------
    ALIVE_RemoveAgent("adv_forestTile_meshesLBackGroundGrass", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesLGrass", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesLTerrain", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesLTreeCards", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesLTrees", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesLTrees01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesLTreeCards01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesLTerrain01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesLGrass01", kScene);
    ALIVE_RemoveAgent("adv_forestTile_meshesLBackGroundGrass01", kScene);
]]--

    ---------------------- ARENA ----------------------
    ALIVE_RemoveAgent("adv_forestArena_meshesAWalkBlocker", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesAGrass", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesAMatteFill", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesARocks", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesAShrubs", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesATerrain", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesATreeFlats", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesATrees", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesATreesSmall", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesBGrass", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesBRocks", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesBShrubs", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesBTerrain", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesBTreeFlats", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesBTrees", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesBTreesSmall", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesCGrass", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesCRocks", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesCShrubs", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesCTerrain", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesCTreeFlats", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesCTrees", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesCTreesSmall", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesDGrass", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesDRocks", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesDShrubs", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesDTerrain", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesDTreeFlats", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesDTrees", kScene);
    ALIVE_RemoveAgent("adv_forestArena_meshesDTreesSmall", kScene);

    ALIVE_RemoveAgent("group_ENV_L", kScene);
    ALIVE_RemoveAgent("group_ENV_L01", kScene);
    ALIVE_RemoveAgent("group_ENV_K", kScene);
    ALIVE_RemoveAgent("group_ENV_K01", kScene);
    ALIVE_RemoveAgent("group_ENV_J", kScene);
    ALIVE_RemoveAgent("group_ENV_J01", kScene);
    ALIVE_RemoveAgent("group_ENV_I", kScene);
    ALIVE_RemoveAgent("group_ENV_I01", kScene);
    ALIVE_RemoveAgent("group_ENV_H", kScene);
    ALIVE_RemoveAgent("group_ENV_H01", kScene);
    ALIVE_RemoveAgent("group_ENV_G", kScene);
    ALIVE_RemoveAgent("group_ENV_G01", kScene);
    ALIVE_RemoveAgent("group_ENV_F", kScene);
    ALIVE_RemoveAgent("group_ENV_F01", kScene);
    ALIVE_RemoveAgent("group_ENV_E", kScene);
    ALIVE_RemoveAgent("group_ENV_E01", kScene);
    ALIVE_RemoveAgent("group_ENV_D", kScene);
    ALIVE_RemoveAgent("group_ENV_D01", kScene);
    ALIVE_RemoveAgent("group_ENV_C", kScene);
    ALIVE_RemoveAgent("group_ENV_C01", kScene);
    ALIVE_RemoveAgent("group_ENV_B", kScene);
    ALIVE_RemoveAgent("group_ENV_B01", kScene);
    ALIVE_RemoveAgent("group_ENV_A", kScene);
    ALIVE_RemoveAgent("group_ENV_A01", kScene);
    
    ALIVE_RemoveAgent("group_lights", kScene);
    ALIVE_RemoveAgent("group_lights01", kScene);
    --ALIVE_RemoveAgent("group_tile1", kScene);
    --ALIVE_RemoveAgent("group_tile2", kScene);
    ALIVE_RemoveAgent("group_wabbits", kScene);
    ALIVE_RemoveAgent("group_freewalk", kScene);
    ALIVE_RemoveAgent("group_trapStation", kScene);
    ALIVE_RemoveAgent("group_skydome", kScene);
    ALIVE_RemoveAgent("group_sun", kScene);

    ALIVE_RemoveAgent("audio_eventEmitter_branchesMovement_1", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_branchesMovement_2", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_branchesMovement_3", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_louispoking", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_aasimwalking", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_Rope", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_hangingZombie_1", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_fallingLeaves_1", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_fallingLeaves_2", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_flySwarm_1", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_forestTile1", kScene);
    ALIVE_RemoveAgent("audio_eventEmitter_forestTile2", kScene);
    ALIVE_RemoveAgent("audio_eventPreloadInterface_forestTile", kScene);
    ALIVE_RemoveAgent("audio_listenerInterface_forestTile", kScene);
    ALIVE_RemoveAgent("audio_reverbInterface_forestTile", kScene);
    ALIVE_RemoveAgent("audio_sfxInterface_forestTile", kScene);
    ALIVE_RemoveAgent("audio_snapshotEmitter_forestTile", kScene);

    ALIVE_RemoveAgent("cam_cutscene", kScene);
    ALIVE_RemoveAgent("cam_cutsceneChore", kScene);
    ALIVE_RemoveAgent("cam_orbit_horizontal", kScene);
    ALIVE_RemoveAgent("cam_orbit_vertical", kScene);
    ALIVE_RemoveAgent("cam_orbit_parent", kScene);
    ALIVE_RemoveAgent("cam_orbit", kScene);
    ALIVE_RemoveAgent("cam_station_traps", kScene);
    ALIVE_RemoveAgent("cam_station_traps_parent", kScene);
    ALIVE_RemoveAgent("cam_station_map", kScene);
    ALIVE_RemoveAgent("cam_station_map_parent", kScene);
    ALIVE_RemoveAgent("cam_aJ_CU", kScene);
    ALIVE_RemoveAgent("cam_aJ_MED", kScene);
    ALIVE_RemoveAgent("cam_aJ_OTS", kScene);
    ALIVE_RemoveAgent("cam_aasim_CU", kScene);
    ALIVE_RemoveAgent("cam_aasim_MED", kScene);
    ALIVE_RemoveAgent("cam_aasim_OTS", kScene);
    ALIVE_RemoveAgent("cam_clementine_CU", kScene);
    ALIVE_RemoveAgent("cam_clementine_MED", kScene);
    ALIVE_RemoveAgent("cam_clementine_OTS", kScene);
    ALIVE_RemoveAgent("cam_louis_CU", kScene);
    ALIVE_RemoveAgent("cam_louis_MED", kScene);
    ALIVE_RemoveAgent("cam_louis_OTS", kScene);
    ALIVE_RemoveAgent("cam_violet_CU", kScene);
    ALIVE_RemoveAgent("cam_violet_MED", kScene);
    ALIVE_RemoveAgent("cam_violet_OTS", kScene);
    ALIVE_RemoveAgent("cam_station_wabbits", kScene);
    ALIVE_RemoveAgent("cam_station_wabbits_parent", kScene);
    ALIVE_RemoveAgent("cam_station_pinata", kScene);
    ALIVE_RemoveAgent("cam_station_pinata_parent", kScene);

    ALIVE_RemoveAgent("fx_lightShaft402", kScene);
    ALIVE_RemoveAgent("fx_lightShaft403", kScene);
    ALIVE_RemoveAgent("fx_lightShaft404", kScene);
    ALIVE_RemoveAgent("fx_camPollen", kScene);
    ALIVE_RemoveAgent("fx_camLeaves", kScene);
    ALIVE_RemoveAgent("fx_bloodFloorDecalsA", kScene);
    ALIVE_RemoveAgent("fx_camBloodMat", kScene);
    ALIVE_RemoveAgent("fxg_bloodBleedDirRad", kScene);
    ALIVE_RemoveAgent("fxg_bloodBleedDirRad01", kScene);
    ALIVE_RemoveAgent("fxg_bloodBleedDirRad02", kScene);
    ALIVE_RemoveAgent("fxa_collisionFloorA", kScene);
    ALIVE_RemoveAgent("fxa_collisionFloorA01", kScene);
    ALIVE_RemoveAgent("fxa_collisionDecalA", kScene);
    ALIVE_RemoveAgent("fxa_collisionDecalA01", kScene);
    
    ALIVE_RemoveAgent("lightrig_CC_rabbitbaby", kScene);
    ALIVE_RemoveAgent("lightrig_CC_rabbit03", kScene);
    ALIVE_RemoveAgent("lightrig_CC_rabbit02", kScene);
    ALIVE_RemoveAgent("lightrig_CC_rabbit", kScene);
    ALIVE_RemoveAgent("lightrig_CC_zombie02", kScene);
    ALIVE_RemoveAgent("lightrig_CC_zombie01", kScene);
    ALIVE_RemoveAgent("lightrig_CC_violet", kScene);
    ALIVE_RemoveAgent("lightrig_CC_louis", kScene);
    ALIVE_RemoveAgent("lightrig_CC_brody", kScene);
    ALIVE_RemoveAgent("lightrig_CC_aasim", kScene);
    ALIVE_RemoveAgent("lightrig_CC_aj", kScene);
    ALIVE_RemoveAgent("lightrig_CC_obj_mapboardingschool", kScene);
    ALIVE_RemoveAgent("lightrig_CC_clementine", kScene);

    ALIVE_RemoveAgent("light_CHAR_CC_RabbitBaby_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_RabbitBaby_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_RabbitBaby_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Rabbit03_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Rabbit03_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Rabbit03_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Rabbit02_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Rabbit02_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Rabbit02_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Rabbit_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Rabbit_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Rabbit_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Zombie02_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Zombie02_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Zombie02_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Zombie01_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Zombie01_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Zombie01_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Violet_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Violet_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Violet_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Louis_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Louis_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Louis_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Brody_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Brody_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Brody_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Aasim_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Aasim_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Aasim_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_AJ_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_AJ_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_AJ_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Clementine_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Clementine_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_Clementine_Rim", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_mapBoardingSchool_Fill", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_mapBoardingSchool_Key", kScene);
    ALIVE_RemoveAgent("light_CHAR_CC_obj_mapBoardingSchool_Rim", kScene);

    ALIVE_RemoveAgent("obj_logicalTrapEmpty", kScene);
    ALIVE_RemoveAgent("obj_logicalTrapBroken", kScene);
    ALIVE_RemoveAgent("obj_knifeKaBar_clem", kScene);
    ALIVE_RemoveAgent("obj_woodTableLegLouis", kScene);
    ALIVE_RemoveAgent("obj_mapBoardingSchool", kScene);
    ALIVE_RemoveAgent("obj_trapSnareRope", kScene);
    ALIVE_RemoveAgent("obj_trapSnareTree", kScene);
    ALIVE_RemoveAgent("obj_trapBear", kScene);
    ALIVE_RemoveAgent("obj_trapSnareRope01", kScene);
    ALIVE_RemoveAgent("obj_trapSnareTree01", kScene);
    ALIVE_RemoveAgent("obj_bowAasim", kScene);
    ALIVE_RemoveAgent("obj_logicalBlood", kScene);
    ALIVE_RemoveAgent("obj_logicalFootprint", kScene);
    --ALIVE_RemoveAgent("obj_skydome", kScene);
    ALIVE_RemoveAgent("obj_skydomeOverheadClouds", kScene);
    ALIVE_RemoveAgent("obj_skydomeSun", kScene);
    ALIVE_RemoveAgent("obj_trapSnareTree_empty", kScene);
    ALIVE_RemoveAgent("obj_trapSnareRope_broken", kScene);
    ALIVE_RemoveAgent("obj_trapSnareRope_empty", kScene);
    ALIVE_RemoveAgent("obj_arrowGeneric", kScene);
    ALIVE_RemoveAgent("obj_cigaretteAbelButt", kScene);
    ALIVE_RemoveAgent("obj_logicalCigaretteButt", kScene);
    ALIVE_RemoveAgent("obj_trapSnareTree_brokenFromShack", kScene);
    ALIVE_RemoveAgent("obj_trapSnareTree_emptyFromShack", kScene);
    ALIVE_RemoveAgent("obj_trapSnareRope_emptyFrom Shack", kScene);
    --ALIVE_RemoveAgent("obj_matteForestTileRing", kScene);
    ALIVE_RemoveAgent("obj_stickSharpened", kScene);
    ALIVE_RemoveAgent("obj_zombieJaw", kScene);
    ALIVE_RemoveAgent("obj_trapSnareTree_broken", kScene);
    ALIVE_RemoveAgent("obj_skullCat", kScene);
    ALIVE_RemoveAgent("obj_footPrints", kScene);
    ALIVE_RemoveAgent("obj_footPrints01", kScene);
    ALIVE_RemoveAgent("obj_loopTrapSnare", kScene);
    ALIVE_RemoveAgent("obj_trapSnareRopeSabotaged", kScene);
    ALIVE_RemoveAgent("obj_bloodStainForestTile", kScene);
    ALIVE_RemoveAgent("obj_logicalAction", kScene);
    ALIVE_RemoveAgent("obj_logicalTrainStation", kScene);
    ALIVE_RemoveAgent("obj_bucketFish", kScene);
    ALIVE_RemoveAgent("obj_lookAtClementine", kScene);
    ALIVE_RemoveAgent("obj_lookAtClementineEyes", kScene);
    ALIVE_RemoveAgent("obj_lookAtViolet", kScene);
    ALIVE_RemoveAgent("obj_lookAtVioletEyes", kScene);
    ALIVE_RemoveAgent("obj_lookAtLouis", kScene);
    ALIVE_RemoveAgent("obj_lookAtLouisEyes", kScene);
    ALIVE_RemoveAgent("obj_lookAtAJ", kScene);
    ALIVE_RemoveAgent("obj_lookAtAJEyes", kScene);
    ALIVE_RemoveAgent("obj_lookAtZombie02", kScene);
    ALIVE_RemoveAgent("obj_lookAtZombie02Eyes", kScene);
    ALIVE_RemoveAgent("obj_lookAtAasim", kScene);
    ALIVE_RemoveAgent("obj_lookAtAasimEyes", kScene);
    ALIVE_RemoveAgent("obj_lookAtBrody", kScene);
    ALIVE_RemoveAgent("obj_lookAtBrodyEyes", kScene);
    ALIVE_RemoveAgent("obj_lookAtRabbitBaby", kScene);
    ALIVE_RemoveAgent("obj_lookAtRabbitBabyEyes", kScene);
    ALIVE_RemoveAgent("obj_lookAtZombie01", kScene);
    ALIVE_RemoveAgent("obj_lookAtZombie01Eyes", kScene);

    --ALIVE_RemoveAgent("module_environment", kScene);
    ALIVE_RemoveAgent("module_post_effect", kScene);
    --ALIVE_RemoveAgent("module_lightprobe", kScene);

    ALIVE_RemoveAgent("ui_decal_skullCat", kScene);

    ALIVE_RemoveAgent("qte_forestTile", kScene);
end