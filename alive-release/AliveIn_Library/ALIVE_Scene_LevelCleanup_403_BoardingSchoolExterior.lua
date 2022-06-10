--|||||||||||||||||||||||||||||||||||||||||||||| BOARDING SCHOOL EXTERIOR 403 ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| BOARDING SCHOOL EXTERIOR 403 ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| BOARDING SCHOOL EXTERIOR 403 ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Scene_LevelCleanup_403_BoardingSchoolExterior = function(kScene)
    ALIVE_RemovingAgentsWithPrefix(kScene, "light_CHAR_CC");
    ALIVE_RemovingAgentsWithPrefix(kScene, "lightrig");
    ALIVE_RemovingAgentsWithPrefix(kScene, "audio_");
    ALIVE_RemovingAgentsWithPrefix(kScene, "fx_");
    ALIVE_RemovingAgentsWithPrefix(kScene, "fxg_");
    ALIVE_RemovingAgentsWithPrefix(kScene, "fxa_");
    ALIVE_RemovingAgentsWithPrefix(kScene, "obj_lookAt");
    
    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "Zombie", "Runtime: Visible", true)
    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "Zombie", "Runtime: Visible", false)

    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "adv_", "material_environment_diffuseTexture - Diffuse Texture", "color_fff.d3dtx");
    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "obj_", "material_environment_diffuseTexture - Diffuse Texture", "color_fff.d3dtx");
    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "adv_", "Mesh Material - Diffuse Texture", "color_fff.d3dtx");
    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "obj_", "Mesh Material - Diffuse Texture", "color_fff.d3dtx");

    --local myTexture = "color_fff.d3dtx"; --white
    --local myTexture = "color_fff0000.d3dtx"; --red
    --local myTexture = "color_818181.d3dtx"; --grey
    --local myTexture = "color_666666.d3dtx"; --dark grey
    --local myTexture = "color_000.d3dtx"; --black

    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "adv_", "material_environment_base - Specular Map Texture", myTexture);
    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "adv_", "material_environment_blend - Specular Map Texture", myTexture);
    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "obj_", "material_environment_base - Specular Map Texture", myTexture);
    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "obj_", "material_environment_blend - Specular Map Texture", myTexture);
    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "adv_", "material_environment_base - Diffuse Texture", myTexture);
    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "adv_", "material_environment_blend - Diffuse Texture", myTexture);
    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "obj_", "material_environment_base - Diffuse Texture", myTexture);
    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "obj_", "material_environment_blend - Diffuse Texture", myTexture);

    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "adv_", "color_ddd - Texture", myTexture);
    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "adv_", "color_ddd - Light Color Diffuse", myTexture);
    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "obj_", "color_ddd - Texture", myTexture);
    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "obj_", "color_ddd - Light Color Diffuse", myTexture);

    --material_environment_diffuseTexture - Diffuse Texture

    --ALIVE_RemoveAgent("AJ", kScene);
    --ALIVE_RemoveAgent("Clementine", kScene);
    ALIVE_RemoveAgent("Aasim", kScene);
    ALIVE_RemoveAgent("Louis", kScene);
    ALIVE_RemoveAgent("Omar", kScene);
    ALIVE_RemoveAgent("Rosie", kScene);
    ALIVE_RemoveAgent("Ruby", kScene);
    ALIVE_RemoveAgent("Tennyson", kScene);
    ALIVE_RemoveAgent("Violet", kScene);
    ALIVE_RemoveAgent("Willy", kScene);
    ALIVE_RemoveAgent("Hare", kScene);
    ALIVE_RemoveAgent("Horse", kScene);

    ALIVE_RemoveAgent("module_environment_med", kScene);
    ALIVE_RemoveAgent("module_post_effect", kScene);
    ALIVE_RemoveAgent("light_ENV_ambFill", kScene);
    ALIVE_RemoveAgent("light_ENV_D_SunKey", kScene);
    ALIVE_RemoveAgent("keylight_node_exterior", kScene);
    --ALIVE_RemoveAgent("light_AMB_0", kScene);
    --ALIVE_RemoveAgent("light_AMB_grassIvy", kScene);
    --ALIVE_RemoveAgent("light_AMB_MatteTrees", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingStripe", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingStripe01", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingStripe02", kScene);
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
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingStripe03", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingStripe04", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce02", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce03", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill12", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill13", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill14", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill15", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill16", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce04", kScene);
    ALIVE_RemoveAgent("light_ENV_C_characterBacklight01", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingLeafy01", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingLeafyInvert", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill17", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill18", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce06", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce07", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce08", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingStripe05", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingLeafyInvertStripes", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingLeafyInvertStripes01", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingLeafyInvertStripes02", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce09", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce10", kScene);
    ALIVE_RemoveAgent("light_ENV_pointSunBounce11", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill19", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill20", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingLeafy02", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill21", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill22", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill23", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill24", kScene);
    --ALIVE_RemoveAgent("light_SKY_amb", kScene);
    ALIVE_RemoveAgent("light_SKY_horizonSpot", kScene);
    ALIVE_RemoveAgent("light_SKY_sunPoint", kScene);
    ALIVE_RemoveAgent("light_SKY_sunBroadLight", kScene);
    ALIVE_RemoveAgent("light_SKY_sunPoint01", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingStripe06", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingStripe07", kScene);
    ALIVE_RemoveAgent("light_gobo_trainStation_buildingLeafy03", kScene);
    ALIVE_RemoveAgent("light_SKY_sunPointNX", kScene);
    ALIVE_RemoveAgent("light_ENV_D_sunKeyNX", kScene);

    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesABuildingBackground", kScene);
    --ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesBBuildingBackground", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesATreeFlats", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesATreeBackground", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesBTreeBackground", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesCTreeBackground", kScene);
    ALIVE_RemoveAgent("adv_boardingSchoolExterior_meshesDTreeBackground", kScene);

    ALIVE_RemoveAgent("obj_capClementine400", kScene);
    ALIVE_RemoveAgent("obj_bagDuffel", kScene);
    ALIVE_RemoveAgent("obj_candle", kScene);
    ALIVE_RemoveAgent("obj_targetSwinging", kScene);
    ALIVE_RemoveAgent("obj_bowlStew_louis", kScene);
    ALIVE_RemoveAgent("obj_bowlStew_violet", kScene);
    ALIVE_RemoveAgent("obj_plate_ruby", kScene);
    ALIVE_RemoveAgent("obj_plate_aasim", kScene);
    ALIVE_RemoveAgent("obj_plate_omar", kScene);
    ALIVE_RemoveAgent("obj_branchPiano", kScene);
    ALIVE_RemoveAgent("obj_treeTireSwing", kScene);
    ALIVE_RemoveAgent("obj_picnicTableBoardingSchoolExteriorC", kScene);
    ALIVE_RemoveAgent("obj_picnicTableBoardingSchoolExteriorB", kScene);
    ALIVE_RemoveAgent("obj_picnicTableBoardingSchoolExterior", kScene);
    ALIVE_RemoveAgent("obj_barricadeBoardingSchoolExteriorNightF", kScene);
    ALIVE_RemoveAgent("obj_barricadeBoardingSchoolExteriorNightADamaged", kScene);
    ALIVE_RemoveAgent("obj_graveMsMartin", kScene);
    ALIVE_RemoveAgent("obj_gravesBoardingSchoolExteriorNight", kScene);
    ALIVE_RemoveAgent("obj_barricadeBoardingSchoolExteriorNightE", kScene);
    ALIVE_RemoveAgent("obj_barricadeBoardingSchoolExteriorNightD", kScene);
    ALIVE_RemoveAgent("obj_bonfireBoardingSchoolExteriorNight", kScene);
    ALIVE_RemoveAgent("obj_barricadeBoardingSchoolExteriorNightC", kScene);
    ALIVE_RemoveAgent("obj_doorDormRoomBoardingSchoolExterior", kScene);
    ALIVE_RemoveAgent("obj_doorBreezewayBoardingSchoolExterior", kScene);
    ALIVE_RemoveAgent("obj_gatePedestrianBoardingSchoolExterior", kScene);
    ALIVE_RemoveAgent("obj_doorCellarBoardingSchoolRight", kScene);
    ALIVE_RemoveAgent("obj_doorCellarBoardingSchoolLeft", kScene);
    ALIVE_RemoveAgent("obj_chairWoodABoardingSchoolDorm", kScene);
    ALIVE_RemoveAgent("obj_watchtowerBoardingSchoolExterior", kScene);
    ALIVE_RemoveAgent("obj_axeFire", kScene);
    ALIVE_RemoveAgent("obj_deckPlayingCardA", kScene);
    ALIVE_RemoveAgent("obj_deckPlayingCardB", kScene);
    ALIVE_RemoveAgent("obj_playingCard", kScene);
    ALIVE_RemoveAgent("obj_trowel", kScene);
    ALIVE_RemoveAgent("obj_bucketFishAJ", kScene);
    ALIVE_RemoveAgent("obj_toyFireWoman", kScene);
    ALIVE_RemoveAgent("obj_toyPoliceMan", kScene);
    ALIVE_RemoveAgent("obj_woodenSpoonLarge", kScene);
    ALIVE_RemoveAgent("obj_crutchClem_left", kScene);
    ALIVE_RemoveAgent("obj_crutchClem_right", kScene);
    ALIVE_RemoveAgent("obj_mapBoardingSchool", kScene);
    ALIVE_RemoveAgent("obj_dogTreat", kScene);
    ALIVE_RemoveAgent("obj_bowlStew_aasim", kScene);
    ALIVE_RemoveAgent("obj_bowlStew_tenn", kScene);
    ALIVE_RemoveAgent("obj_bowlStew_willy", kScene);
    ALIVE_RemoveAgent("obj_bowlStew_aj", kScene);
    ALIVE_RemoveAgent("obj_spoon_aasim", kScene);
    ALIVE_RemoveAgent("obj_spoon_aj", kScene);
    ALIVE_RemoveAgent("obj_spoon_clem", kScene);
    ALIVE_RemoveAgent("obj_spoon_louis", kScene);
    ALIVE_RemoveAgent("obj_spoon_omar", kScene);
    ALIVE_RemoveAgent("obj_spoon_tenn", kScene);
    ALIVE_RemoveAgent("obj_spoon_willy", kScene);
    ALIVE_RemoveAgent("obj_spoon_violet", kScene);
    ALIVE_RemoveAgent("obj_spoon_ruby", kScene);
    ALIVE_RemoveAgent("obj_bowlStew_omar", kScene);
    ALIVE_RemoveAgent("obj_bowlStew_ruby", kScene);
    ALIVE_RemoveAgent("obj_bowlStew_clem", kScene);
    ALIVE_RemoveAgent("obj_toyFireTruck", kScene);
    ALIVE_RemoveAgent("obj_tireSwing404", kScene);
    ALIVE_RemoveAgent("obj_pencilBlack_aj", kScene);
    ALIVE_RemoveAgent("obj_pencilBlack_Tenn", kScene);
    ALIVE_RemoveAgent("obj_drawingBookTenn", kScene);
    ALIVE_RemoveAgent("obj_gunP250", kScene);
    ALIVE_RemoveAgent("obj_gunP250Magazine", kScene);
    ALIVE_RemoveAgent("obj_noteLouis", kScene);
    ALIVE_RemoveAgent("obj_graveMarkerLouis", kScene);
    ALIVE_RemoveAgent("obj_graveMarkerTenn", kScene);
    ALIVE_RemoveAgent("obj_graveMarkerViolet", kScene);
    ALIVE_RemoveAgent("obj_graveMarkerMitch", kScene);
    ALIVE_RemoveAgent("obj_graveMarkerJames", kScene);
    ALIVE_RemoveAgent("obj_drawingAJEyes", kScene);
    ALIVE_RemoveAgent("obj_drawingTennEyes", kScene);
    ALIVE_RemoveAgent("obj_drawingTennDreamHouse", kScene);
    ALIVE_RemoveAgent("obj_drawingTennSchoolGates", kScene);
    ALIVE_RemoveAgent("obj_pushPin_House", kScene);
    ALIVE_RemoveAgent("obj_pushPin_gates", kScene);
    ALIVE_RemoveAgent("obj_chunkSoup", kScene);
    ALIVE_RemoveAgent("obj_poleFlagRaidersBoardingSchoolExterior", kScene);
    ALIVE_RemoveAgent("obj_bannerRaiders", kScene);
    ALIVE_RemoveAgent("obj_poleFlagBoardingSchoolExterior", kScene);
    --ALIVE_RemoveAgent("obj_skydome", kScene);
    ALIVE_RemoveAgent("obj_skydomeOverheadClouds", kScene);
    --ALIVE_RemoveAgent("obj_skydomeSun", kScene);
    ALIVE_RemoveAgent("obj_chunkSoup_Ruby", kScene);
    ALIVE_RemoveAgent("obj_toyBroccoli", kScene);
    ALIVE_RemoveAgent("obj_pencilGreen", kScene);
    ALIVE_RemoveAgent("obj_pencilRed", kScene);
    ALIVE_RemoveAgent("obj_pencilYellow", kScene);
    ALIVE_RemoveAgent("obj_deckPlayingCardA01", kScene);
    ALIVE_RemoveAgent("obj_playingCard01", kScene);

end