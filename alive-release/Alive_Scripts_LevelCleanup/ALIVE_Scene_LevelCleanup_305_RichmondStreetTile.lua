ALIVE_Scene_LevelCleanup_305_RichmondStreetTile = function(kScene)
    ALIVE_RemovingAgentsWithPrefix(kScene, "light_CHAR_CC");
    ALIVE_RemovingAgentsWithPrefix(kScene, "lightrig");
    ALIVE_RemovingAgentsWithPrefix(kScene, "audio_");
    ALIVE_RemovingAgentsWithPrefix(kScene, "fx_");
    ALIVE_RemovingAgentsWithPrefix(kScene, "fxg_");
    ALIVE_RemovingAgentsWithPrefix(kScene, "obj_lookAt");
    ALIVE_RemovingAgentsWithPrefix(kScene, "obj_logical");
    
    --remove characters
    ALIVE_RemoveAgent("Clementine", kScene);
    ALIVE_RemoveAgent("Zombie1", kScene);
    ALIVE_RemoveAgent("Zombie2", kScene);
    ALIVE_RemoveAgent("Zombie3", kScene);
    ALIVE_RemoveAgent("Zombie4", kScene);
    ALIVE_RemoveAgent("Zombie5", kScene);
    ALIVE_RemoveAgent("Javier", kScene);
    ALIVE_RemoveAgent("ZombieLow1", kScene);
    ALIVE_RemoveAgent("ZombieLow2", kScene);
    ALIVE_RemoveAgent("ZombieLow3", kScene);
    ALIVE_RemoveAgent("ZombieLow4", kScene);
    ALIVE_RemoveAgent("ZombieLow5", kScene);
    ALIVE_RemoveAgent("ZombieOverpass", kScene);
    ALIVE_RemoveAgent("ZombieOverpass", kScene);

    --remove misc
    ALIVE_RemoveAgent("module_post_effect", kScene);
    --ALIVE_RemoveAgent("module_lightprobe", kScene);
    --ALIVE_RemoveAgent("module_environment", kScene);
    ALIVE_RemoveAgent("charLightComposer_keylight", kScene);
    ALIVE_RemoveAgent("qte_richmondStreetTile", kScene);

    --remove objects
    --ALIVE_RemoveAgent("obj_skyDome", kScene);
    --ALIVE_RemoveAgent("obj_matteRichmondStreetHorizonTile", kScene);
    --ALIVE_RemoveAgent("obj_overpassZombieLower", kScene);
    --ALIVE_RemoveAgent("obj_bloodTiresCurvedRichmondStreetTile01", kScene);
    --ALIVE_RemoveAgent("obj_bloodTiresStraightRichmondStreetTile01", kScene);
    --ALIVE_RemoveAgent("obj_zombieCorpseA", kScene);
    --ALIVE_RemoveAgent("obj_zombieCorpseB", kScene);
    --ALIVE_RemoveAgent("obj_zombieCorpseC", kScene);
    --ALIVE_RemoveAgent("obj_zombieCorpseE", kScene);
    --ALIVE_RemoveAgent("obj_zombieCorpseF", kScene);
    --ALIVE_RemoveAgent("obj_bloodTiresCurvedRichmondStreetTile02", kScene);
    --ALIVE_RemoveAgent("obj_bloodTiresStraightRichmondStreetTile02", kScene);
    --ALIVE_RemoveAgent("obj_zombieCorpseD", kScene);
    ALIVE_RemoveAgent("obj_vehicleMotorcycle", kScene);
    ALIVE_RemoveAgent("obj_gunP250_Clementine", kScene);
    ALIVE_RemoveAgent("obj_batAluminum_javi", kScene);
    ALIVE_RemoveAgent("obj_zombieHeadPartD", kScene);
    --ALIVE_RemoveAgent("obj_bloodTiresCurvedRichmondStreetTile03", kScene);
    --ALIVE_RemoveAgent("obj_bloodTiresCurvedRichmondStreetTile04", kScene);
    --ALIVE_RemoveAgent("obj_bloodTiresCurvedRichmondStreetTile05", kScene);
    --ALIVE_RemoveAgent("obj_bloodTiresCurvedRichmondStreetTile06", kScene);
    --ALIVE_RemoveAgent("obj_bloodTiresStraightRichmondStreetTile03", kScene);
    --ALIVE_RemoveAgent("obj_bloodTiresStraightRichmondStreetTile04", kScene);
    --ALIVE_RemoveAgent("obj_bloodTiresStraightRichmondStreetTile05", kScene);
    --ALIVE_RemoveAgent("obj_bloodTiresStraightRichmondStreetTile06", kScene);

    --lights
    --ALIVE_RemoveAgent("light_ENV_SunKey", kScene);
    ALIVE_RemoveAgent("light_CHAR_amb", kScene);
    --ALIVE_RemoveAgent("light_ENV_Amb_Skydome", kScene);
    ALIVE_RemoveAgent("light_ENV_Amb01", kScene);
    --ALIVE_RemoveAgent("light_MAT_amb", kScene); --matte ambient

    --extra scene lights
    ALIVE_RemoveAgent("light_MAT_point01", kScene);
    ALIVE_RemoveAgent("light_MAT_point02", kScene);
    ALIVE_RemoveAgent("light_MAT_point03", kScene);
    ALIVE_RemoveAgent("light_ENV_yellowFakeSun", kScene);
    ALIVE_RemoveAgent("light_ENV_yellowFakeSun01", kScene);
    ALIVE_RemoveAgent("light_SKY_Point06", kScene);
    ALIVE_RemoveAgent("light_SKY_sunPoint", kScene);
    ALIVE_RemoveAgent("light_SKY_point01", kScene);
    ALIVE_RemoveAgent("light_SKY_point02", kScene);
    ALIVE_RemoveAgent("light_SKY_point03", kScene);
    ALIVE_RemoveAgent("light_VEH_motorcycleHeadlight", kScene);
    ALIVE_RemoveAgent("light_VEH_motorcycleHeadlight01", kScene);
    ALIVE_RemoveAgent("light_ENV_yellowFakeSun02", kScene);
    ALIVE_RemoveAgent("light_ENV_yellowFakeSun03", kScene);
    ALIVE_RemoveAgent("light_ENV_yellowFakeSun04", kScene);
    ALIVE_RemoveAgent("light_SKY_point04", kScene);
    ALIVE_RemoveAgent("light_SKY_point05", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill02", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill03", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill04", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill05", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill06", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill07", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill08", kScene);
    ALIVE_RemoveAgent("light_ENV_pointFill09", kScene);
    ALIVE_RemoveAgent("light_ENV_yellowFakeSun05", kScene);
    ALIVE_RemoveAgent("light_SKY_point", kScene);
    ALIVE_RemoveAgent("light_ENV_bounce", kScene);
end