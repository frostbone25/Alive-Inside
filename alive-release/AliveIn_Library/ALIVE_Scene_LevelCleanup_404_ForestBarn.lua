ALIVE_Scene_LevelCleanup_404_ForestBarn_Teaser = function(kScene)
    ALIVE_RemovingAgentsWithPrefix(kScene, "light_CHAR_CC");
    ALIVE_RemovingAgentsWithPrefix(kScene, "lightrig");
    ALIVE_RemovingAgentsWithPrefix(kScene, "audio_");
    ALIVE_RemovingAgentsWithPrefix(kScene, "fx_");
    ALIVE_RemovingAgentsWithPrefix(kScene, "fxg_");
    ALIVE_RemovingAgentsWithPrefix(kScene, "fxa_");
    ALIVE_RemovingAgentsWithPrefix(kScene, "qte_");

    ALIVE_RemoveAgent("light_ENV_interior_amb", kScene);
    --ALIVE_RemoveAgent("light_ENV_exterior_amb", kScene);
    ALIVE_RemoveAgent("light_ENV_interior", kScene);
    --ALIVE_RemoveAgent("light_ENV_sunKey", kScene);
    ALIVE_RemoveAgent("light_ENV_exterior", kScene);
    ALIVE_RemoveAgent("light_ENV_exterior_modBarnShadow01", kScene);
    ALIVE_RemoveAgent("light_ENV_exterior_modBarnShadow02", kScene);
    ALIVE_RemoveAgent("light_ENV_highlight01", kScene);
    ALIVE_RemoveAgent("light_ENV_highlight05", kScene);
    ALIVE_RemoveAgent("light_ENV_sunKey01", kScene);
    ALIVE_RemoveAgent("light_ENV_ambGrassIvy", kScene);
    ALIVE_RemoveAgent("light_ENV_S_doorsFlood01", kScene);
    ALIVE_RemoveAgent("light_ENV_highlight02", kScene);
    ALIVE_RemoveAgent("light_ENV_P_ceilingBounce01", kScene);
    ALIVE_RemoveAgent("light_ENV_P_ceilingBounce02", kScene);
    ALIVE_RemoveAgent("light_ENV_P_ceilingBounce03", kScene);
    ALIVE_RemoveAgent("light_ENV_spotFill", kScene);
    ALIVE_RemoveAgent("light_NODE_exteriorA", kScene);
    --ALIVE_RemoveAgent("light_SKY_amb", kScene);
    --ALIVE_RemoveAgent("light_SKY_horizonSpot", kScene);
    --ALIVE_RemoveAgent("light_SKY_sunPoint", kScene);
    --ALIVE_RemoveAgent("light_SKY_sunBroadLight", kScene);
    --ALIVE_RemoveAgent("light_SKY_sunPoint01", kScene);
    ALIVE_RemoveAgent("light_SKY_sunPoint_MedQuality01", kScene);
    ALIVE_RemoveAgent("light_SKY_sunPoint_medQuality02", kScene);
    ALIVE_RemoveAgent("light_SKY_sunPoint02", kScene);
    ALIVE_RemoveAgent("light_NODE_exteriorTile", kScene);
    ALIVE_RemoveAgent("module_environment_med", kScene);
    ALIVE_RemoveAgent("light_ENV_ambtreeFlats", kScene);
    ALIVE_RemoveAgent("light_ENV_highlight03", kScene);
    ALIVE_RemoveAgent("light_S_sunRising01", kScene);
    ALIVE_RemoveAgent("light_S_sunRising02", kScene);
    ALIVE_RemoveAgent("light_ENV_highlight04", kScene);
    ALIVE_RemoveAgent("light_S_sunRising03", kScene);
    ALIVE_RemoveAgent("light_ENV_barnInterior01", kScene);
    ALIVE_RemoveAgent("light_ENV_barnInterior02", kScene);
    ALIVE_RemoveAgent("light_NODE_interior", kScene);
    ALIVE_RemoveAgent("light_ENV_P_fillTrees01", kScene);
    ALIVE_RemoveAgent("light_ENV_P_fillTrees02", kScene);
    ALIVE_RemoveAgent("light_ENV_P_fillTrees03", kScene);
    ALIVE_RemoveAgent("light_ENV_P_fillTrees04", kScene);
    ALIVE_RemoveAgent("light_ENV_P_fillTrees05", kScene);
    ALIVE_RemoveAgent("light_ENV_P_backLight01", kScene);
    ALIVE_RemoveAgent("light_ENV_P_backLight02", kScene);
    ALIVE_RemoveAgent("light_ENV_P_backLight03", kScene);
    ALIVE_RemoveAgent("light_ENV_P_backLight05", kScene);
    ALIVE_RemoveAgent("light_ENV_P_backLight06", kScene);
    ALIVE_RemoveAgent("light_ENV_P_backLight07", kScene);
    ALIVE_RemoveAgent("light_ENV_P_clemKey01", kScene);
    ALIVE_RemoveAgent("light_ENV_P_bounce01", kScene);
    ALIVE_RemoveAgent("light_ENV_S_pitchforkRopeKey01", kScene);
    ALIVE_RemoveAgent("light_ENV_S_backlightKey01", kScene);
    ALIVE_RemoveAgent("light_ENV_S_barnKey01", kScene);
    ALIVE_RemoveAgent("light_ENV_P_bounce02", kScene);
    ALIVE_RemoveAgent("light_ENV_C_bounce03", kScene);
    ALIVE_RemoveAgent("light_ENV_P_clemKey02", kScene);
    ALIVE_RemoveAgent("light_ENV_P_backLight04", kScene);
    ALIVE_RemoveAgent("light_ENV_P_clemKey01NX", kScene);
    ALIVE_RemoveAgent("light_ENV_P_gunShotBlast01", kScene);

    ALIVE_RemoveAgent("module_post_effect", kScene);

    ALIVE_RemoveAgent("group_tile1", kScene);

    ALIVE_RemoveAgent("Zombie01", kScene);
    ALIVE_RemoveAgent("Zombie02", kScene);
    ALIVE_RemoveAgent("Zombie03", kScene);
    ALIVE_RemoveAgent("Zombie04", kScene);
    ALIVE_RemoveAgent("Zombie05", kScene);
    ALIVE_RemoveAgent("Zombie06", kScene);
    ALIVE_RemoveAgent("Zombie07", kScene);
    ALIVE_RemoveAgent("Zombie08", kScene);
    ALIVE_RemoveAgent("Zombie09", kScene);
    ALIVE_RemoveAgent("Zombie10", kScene);
    ALIVE_RemoveAgent("Zombie11", kScene);
    ALIVE_RemoveAgent("Zombie12", kScene);
    ALIVE_RemoveAgent("Zombie13", kScene);
    ALIVE_RemoveAgent("Zombie14", kScene);
    ALIVE_RemoveAgent("Zombie15", kScene);
    ALIVE_RemoveAgent("Zombie16", kScene);
    ALIVE_RemoveAgent("Zombie17", kScene);
    ALIVE_RemoveAgent("Zombie18", kScene);
    ALIVE_RemoveAgent("Zombie19", kScene);
    ALIVE_RemoveAgent("Zombie20", kScene);
    ALIVE_RemoveAgent("Zombie21", kScene);
    ALIVE_RemoveAgent("Zombie22", kScene);
    ALIVE_RemoveAgent("Zombie23", kScene);
    ALIVE_RemoveAgent("Zombie24", kScene);
    ALIVE_RemoveAgent("Zombie25", kScene);
    ALIVE_RemoveAgent("ZombieCombat01", kScene);
    ALIVE_RemoveAgent("ZombieCombat02", kScene);
    ALIVE_RemoveAgent("ZombieCombat03", kScene);
    ALIVE_RemoveAgent("ZombieCombat04", kScene);
    ALIVE_RemoveAgent("ZombieCombat05", kScene);
end