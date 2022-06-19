ALIVE_Character_Clementine_Sick = function(kScene)
    AgentSetState("Clementine", "bodyLowerLegMissing");

    --local myTextureeee = "color_fff0000.d3dtx"; --red
    --local myTextureeee = "color_fff.d3dtx"; --white

    ALIVE_AgentSetProperty("Clementine", "sk62_clementine400_head_m - Diffuse Texture", "sk62_clementine400_headDyingD.d3dtx", kScene);
    ALIVE_AgentSetProperty("Clementine", "sk62_clementine400_eyes_m - Diffuse Texture", "sk62_clementine400_eyesDying.d3dtx", kScene);
    ALIVE_AgentSetProperty("Clementine", "sk62_clementine400_bodyLowerLegMissing_m - Diffuse Texture", myTextureeee, kScene);
    ALIVE_AgentSetProperty("Clementine", "sk62_clementine400_bodyLowerBitten_m - Diffuse Texture", myTextureeee, kScene);
    ALIVE_AgentSetProperty("Clementine", "sk62_clementine400_bodyLowerOutfitA_m - Diffuse Texture", myTextureeee, kScene);
    --texture_clementine_bloody_stump.d3dtx
    --ALIVE_PrintValidPropertyNames(AgentFindInScene("Clementine", ThirdPerson_kScene));
    --ALIVE_PrintProperties(AgentFindInScene("Clementine", ThirdPerson_kScene));

    --ALIVE_GetCacheObjectNameFromProperty(AgentFindInScene("Clementine", ThirdPerson_kScene), "sk62_clementine400_head_m - Diffuse Texture");
    --ALIVE_GetCacheObjectNamesFromProperties(AgentFindInScene("Clementine", ThirdPerson_kScene), "cleanedCacheObjectsList404.txt");



    --bodyLowerLegMissing

    --[[
        NOTE TO SELF:
        for properties with Handle<T3Texture> type, typically they have cached object and then a string of numbers
        we could try perhaps by taking that single field and running strings.txt through it.
        basically getting the inital field value, then setting it, then getting the value again and printing it, then repeat
    ]]--

    --local clemProps = AgentGetProperties(AgentFindInScene("Clementine", ThirdPerson_kScene));
    --local textureOverride = "color_000.d3dtx"; --black

    --adv_boardingSchoolExterior_module_lightprobe.d3dtx
    --ALIVE_SetPropertyBySymbol(clemProps, "98822971867575553", textureOverride);

    --local myTexture = "color_fff.d3dtx"; --white
    --local myTexture = "color_fff0000.d3dtx"; --red
    --local myTexture = "color_818181.d3dtx"; --grey
    --local myTexture = "color_666666.d3dtx"; --dark grey
    --local myTexture = "color_000.d3dtx"; --black

    --ALIVE_PrintProperties(agent_character)
end