--|||||||||||||||||||||||||||||||||||||||||||||| RICHMOND OVERPASS S3 ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| RICHMOND OVERPASS S3 ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| RICHMOND OVERPASS S3 ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Scene_LevelCleanup_305_RichmondOverpass = function(kScene)
    ALIVE_RemovingAgentsWithPrefix(kScene, "light_CHAR_CC");
    ALIVE_RemovingAgentsWithPrefix(kScene, "lightrig");
    ALIVE_RemovingAgentsWithPrefix(kScene, "audio_");
    ALIVE_RemovingAgentsWithPrefix(kScene, "fx_");
    ALIVE_RemovingAgentsWithPrefix(kScene, "fxg_");
    ALIVE_RemovingAgentsWithPrefix(kScene, "obj_lookAt");
    ALIVE_RemovingAgentsWithPrefix(kScene, "obj_logical");
    
    --remove characters
    ALIVE_RemoveAgent("Clementine", kScene);
    ALIVE_RemoveAgent("David", kScene);
    ALIVE_RemoveAgent("Gabe", kScene);
    ALIVE_RemoveAgent("Javier", kScene);
    ALIVE_RemoveAgent("Kate", kScene);
    ALIVE_RemoveAgent("Ava", kScene);
    ALIVE_RemoveAgent("Tripp", kScene);
    ALIVE_RemoveAgent("Zombie1", kScene);
    ALIVE_RemoveAgent("Zombie2", kScene);
    ALIVE_RemoveAgent("Zombie3", kScene);
    ALIVE_RemoveAgent("ZombieLow1", kScene);
    ALIVE_RemoveAgent("ZombieLow2", kScene);
    ALIVE_RemoveAgent("ZombieLow3", kScene);
    ALIVE_RemoveAgent("Zombie4", kScene);
    ALIVE_RemoveAgent("Zombie5", kScene);
    ALIVE_RemoveAgent("ZombieOverpass", kScene);

    --remove misc
    ALIVE_RemoveAgent("module_post_effect", kScene);
    --ALIVE_RemoveAgent("module_lightprobe", kScene);
    --ALIVE_RemoveAgent("module_environment", kScene);
    ALIVE_RemoveAgent("dummy_choredMoveAxis", kScene);
    ALIVE_RemoveAgent("charLightComposer_keylight", kScene);
    ALIVE_RemoveAgent("qte_richmondOverpass", kScene);

    --remove objects
    --ALIVE_RemoveAgent("obj_skyDome", kScene);
    --ALIVE_RemoveAgent("obj_matteRichmondRooftopsWaterTower", kScene);
    --ALIVE_RemoveAgent("obj_matteRichmondRooftops360Vista", kScene);
    --ALIVE_RemoveAgent("obj_billboardRooftops", kScene);
    --ALIVE_RemoveAgent("obj_vehicleTaxiOvergrownStreetTile", kScene);
    --ALIVE_RemoveAgent("obj_vehicleTruckDumpOvergrownStreetTile", kScene);
    --ALIVE_RemoveAgent("obj_vehicleTruckMovingOvergrownStreetTile", kScene);
    --ALIVE_RemoveAgent("obj_overpassZombieLower", kScene);
    --ALIVE_RemoveAgent("obj_vehicleHelicopterDamaged", kScene);
    --ALIVE_RemoveAgent("obj_vehicleCarRichmondOverpassA", kScene);
    --ALIVE_RemoveAgent("obj_zombieOverpassWire", kScene);
    --ALIVE_RemoveAgent("obj_rebarOverpass", kScene);
    --ALIVE_RemoveAgent("obj_rebarOverpassBloody", kScene);
    ALIVE_RemoveAgent("obj_batAluminum", kScene);
    ALIVE_RemoveAgent("obj_knifeKABAR_clem", kScene);
    ALIVE_RemoveAgent("obj_gunM1911_David", kScene);
    ALIVE_RemoveAgent("obj_gunM1911_tripp", kScene);
    ALIVE_RemoveAgent("obj_knifeKaBar_tripp", kScene);
    ALIVE_RemoveAgent("obj_knifeKaBar_ava", kScene);
    ALIVE_RemoveAgent("obj_gunM9_javier", kScene);
    ALIVE_RemoveAgent("obj_crowbarJunkyard_kate", kScene);
    ALIVE_RemoveAgent("obj_knifeKaBar_david", kScene);

    --lights
    --ALIVE_RemoveAgent("light_ENV_DIR_SunKey", kScene);
    --ALIVE_RemoveAgent("light_ENV_AMB", kScene);
    --ALIVE_RemoveAgent("light_SKY_amb", kScene);
    ALIVE_RemoveAgent("light_DIR_AMB", kScene);
    --ALIVE_RemoveAgent("light_AMB", kScene); --matte ambient

    --extra scene lights
    ALIVE_RemoveAgent("light_ENV_sunHotSpot06", kScene);
    ALIVE_RemoveAgent("light_ENV_sunHotSpot07", kScene);
    ALIVE_RemoveAgent("light_ENV_sunHotSpot03", kScene);
    ALIVE_RemoveAgent("light_ENV_sunHotSpot08", kScene);
    ALIVE_RemoveAgent("light_ENV_godrayJitter", kScene);
    ALIVE_RemoveAgent("light_SKY_pointSun", kScene);
    ALIVE_RemoveAgent("light_SKY_pointSun01", kScene);
    ALIVE_RemoveAgent("light_SKY_pointSun02", kScene);
    ALIVE_RemoveAgent("light_SKY_pointSun04", kScene);
    ALIVE_RemoveAgent("light_SKY_pointSun05", kScene);
    ALIVE_RemoveAgent("light_SKY_pointSun06", kScene);
    ALIVE_RemoveAgent("light_ENV_helicopterSpec", kScene);
    ALIVE_RemoveAgent("light_ENV_helicopterSpec01", kScene);
    ALIVE_RemoveAgent("light_fx_water", kScene);
    ALIVE_RemoveAgent("light_fx_water01", kScene);
    ALIVE_RemoveAgent("light_ENV_sunHotSpot", kScene);
    ALIVE_RemoveAgent("light_ENV_sunHotSpot01", kScene);
    ALIVE_RemoveAgent("light_ENV_sunHotSpot02", kScene);
    ALIVE_RemoveAgent("light_ENV_sunHotSpot04", kScene);
    ALIVE_RemoveAgent("light_ENV_sunHotSpot05", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce75", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce76", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce77", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce78", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce79", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce80", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce25", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce58", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce73", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce74", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce16", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce27", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce30", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce34", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce17", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce36", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce18", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce24", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce38", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce39", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce40", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce41", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce42", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce43", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce46", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce47", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce48", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce49", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce50", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce51", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce52", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce53", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce54", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce56", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce57", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce59", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce60", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce62", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce64", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce65", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce67", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce68", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce69", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce70", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce71", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce72", kScene);
end