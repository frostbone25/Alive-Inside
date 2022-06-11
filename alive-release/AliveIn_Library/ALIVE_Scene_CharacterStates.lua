ALIVE_Scene_SetCharacterState_AJ_KennyHat = function(kScene)
    ALIVE_AgentSetProperty("AJ", "Mesh sk63_aj_hair - Visible", false, kScene);

    ResourceSetEnable("WalkingDead301");

    local agent_kennyHat = AgentCreate("KennyHat", "obj_hatKennyWellington.prop", Vector(0,0,0), Vector(0,0,0), ThirdPerson_kScene, false, false);
    ALIVE_AgentSetProperty("KennyHat", "Render Global Scale", 1, ThirdPerson_kScene);
    ALIVE_AgentSetProperty("KennyHat", "Render Cull", false, ThirdPerson_kScene);
    ALIVE_AgentSetProperty("KennyHat", "Runtime: Visible", true, ThirdPerson_kScene);

    --head
    --Head
    --HEAD
    local nodeName = "head";

    local charAgento = AgentFindInScene("AJ", ThirdPerson_kScene);

    if AgentHasNode(charAgento, nodeName) then
        AgentAttachToNode(agent_kennyHat, charAgento, nodeName);

        AgentSetPos(agent_kennyHat, Vector(0, 0.095, 0.055));
        AgentSetRot(agent_kennyHat, Vector(0, 0, 0));
    end
end

ALIVE_Scene_SetCharacterState_AJ = function(kScene)
    AgentSetState("AJ", "bodyJacketDisco");

    --local myTextureeee = "color_fff0000.d3dtx"; --red
    --local myTextureeee = "color_fff.d3dtx"; --white

    --[[
        NOTE TO SELF:
        for properties with Handle<T3Texture> type, typically they have cached object and then a string of numbers
        we could try perhaps by taking that single field and running strings.txt through it.
        basically getting the inital field value, then setting it, then getting the value again and printing it, then repeat
    ]]--

    --local ajProps = AgentGetProperties(agent_character);
    --local textureOverride = "color_000.d3dtx"; --black

    --adv_boardingSchoolExterior_module_lightprobe.d3dtx

    --local myTexture = "color_fff.d3dtx"; --white
    --local myTexture = "color_fff0000.d3dtx"; --red
    --local myTexture = "color_818181.d3dtx"; --grey
    --local myTexture = "color_666666.d3dtx"; --dark grey
    --local myTexture = "color_000.d3dtx"; --black
    --ALIVE_GetCacheObjectNamesFromProperties(AgentFindInScene("AJ", ThirdPerson_kScene), "cleanedCacheObjectsList404.txt");

    --set aj spec
    --local ajSpecOverride = "color_818181.d3dtx"; --grey
    --local ajSpecOverride = "color_fff.d3dtx"; --white
    --local ajSpecOverride = "color_666666.d3dtx"; --dark grey
    --local ajSpecOverride = "color_000.d3dtx"; --black
    --ALIVE_AgentSetPropertyBySymbol("AJ", "990463370724338236", ajSpecOverride, ThirdPerson_kScene);
    --ALIVE_AgentSetPropertyBySymbol("AJ", "1463902169883331120", ajSpecOverride, ThirdPerson_kScene);
    --ALIVE_AgentSetPropertyBySymbol("AJ", "5661132411227395665", ajSpecOverride, ThirdPerson_kScene);
    --ALIVE_AgentSetPropertyBySymbol("AJ", "11664515276069663068", ajSpecOverride, ThirdPerson_kScene);
    --ALIVE_AgentSetPropertyBySymbol("AJ", "13884686417410322160", ajSpecOverride, ThirdPerson_kScene);

    --ALIVE_AgentSetPropertyBySymbol("AJ", "16751189380505258298", myTexture, kScene);

    --ALIVE_AgentSetProperty("AJ", "obj_gunRevolverClothwrap_m - Diffuse Texture", myTexture, ThirdPerson_kScene);
    --ALIVE_AgentSetProperty("AJ", "obj_gunRevolver_m - Diffuse Texture", myTexture, ThirdPerson_kScene);
    --ALIVE_AgentSetProperty("AJ", "sk63_aj_bodyLower_m - Diffuse Texture", myTexture, ThirdPerson_kScene);
    --ALIVE_AgentSetProperty("AJ", "sk63_aj_bodyUpperJacket_m - Diffuse Texture", myTexture, ThirdPerson_kScene);
    --ALIVE_AgentSetProperty("AJ", "sk63_aj_head_m - Diffuse Texture", myTexture, ThirdPerson_kScene);

    --ALIVE_AgentSetProperty("AJ", "obj_gunRevolverClothwrap_m - Specular Map Texture", myTexture, ThirdPerson_kScene);
    --ALIVE_AgentSetProperty("AJ", "obj_gunRevolver_m - Specular Map Texture", myTexture, ThirdPerson_kScene);
    --ALIVE_AgentSetProperty("AJ", "sk63_aj_bodyLower_m - Specular Map Texture", myTexture, ThirdPerson_kScene);
    --ALIVE_AgentSetProperty("AJ", "sk63_aj_bodyUpperJacket_m - Specular Map Texture", myTexture, ThirdPerson_kScene);
    --ALIVE_AgentSetProperty("AJ", "sk63_aj_head_m - Specular Map Texture", myTexture, ThirdPerson_kScene);
    
    --local ajProps = AgentGetRuntimeProperties(agent_character);
    --local ajModels = AgentToModels(agent_character);
    --local testAJ = PropertyGet(ajProps, "Mesh sk63_aj_bodyLower");
    --local ajMesh = PropertyGet(ajProps, "D3D Mesh");
    --local ajMeshList = PropertyGet(ajProps, "D3D Mesh List");

    --for x, mesh in ipairs(ajMeshList) do
    --    MeshSetDiffuseTexture(mesh, "color_fff.d3dtx");
    --end



    --for x, mesh in ipairs(ajModels) do
    --   MeshSetDiffuseTexture(mesh, "color_fff.d3dtx");
    --end

    --MeshSetDiffuseTexture(ajMesh, "color_fff.d3dtx");
    --MeshSetDiffuseTexture(testAJ, "color_fff.d3dtx");

    --ShaderSwapTexture

    --PropertySet(ajProps, "", );

    --MeshSetDiffuseTexture

    --D3D Mesh
    --D3D Mesh List

    --PropertySet(ajProps, "Mesh sk63_aj_bodyLower - Visible", false);
    --PropertySet(ajProps, "Material sk63_aj_bodyLower - Texture", "color_fff.d3dtx");
    --PropertySet(ajProps, "sk63_aj_bodyLower - Texture", "color_fff.d3dtx");
    --PropertySet(ajProps, "material_sk63_aj_bodyLower - Texture", "color_fff.d3dtx");
    --PropertySet(ajProps, "material_sk63_aj_bodyLower - Diffuse Texture", "color_fff.d3dtx");
    --ALIVE_PrintProperties(agent_character)
end

ALIVE_Scene_SetCharacterState_Clementine = function(kScene)
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

ALIVE_Scene_SetCharacterState_AJ_Teaser = function(kScene)
    AgentSetState("AJ", "bodyJacketDisco");
end