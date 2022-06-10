--|||||||||||||||||||||||||||||||||||||||||||||| BOARDING SCHOOL EXTERIOR 403 ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| BOARDING SCHOOL EXTERIOR 403 ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| BOARDING SCHOOL EXTERIOR 403 ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_Scene_LevelRelight_403_BoardingSchoolExterior = function(kScene)
    local agent_name_scene = kScene .. ".scene";

    local envlight  = AgentFindInScene("light_ENV_D_SunKey", kScene);
    local envlight_props = AgentGetRuntimeProperties(envlight);
    local envlight_groupEnabled = PropertyGet(envlight_props, "EnvLight - Enabled Group");
    local envlight_groups = PropertyGet(envlight_props, "EnvLight - Groups");
    
    --find the original sky light in the scene (note telltale dev, why do you use a light source for the skybox when you could've just had the sky be an (emmissive/unlit) shader?)
    --local skyEnvlight  = AgentFindInScene("light_SKY_amb", kScene);
    --local skyEnvlight_props = AgentGetRuntimeProperties(skyEnvlight);
    --local skyEnvlight_groupEnabled = PropertyGet(skyEnvlight_props, "EnvLight - Enabled Group");
    --local skyEnvlight_groups = PropertyGet(skyEnvlight_props, "EnvLight - Groups");

    --the main prop (like a prefab) file for a generic light
    local envlight_prop = "module_env_light.prop";
    
    --calculate some new colors
    local sunColor     = RGBColor(255, 210, 188, 255);
    local ambientColor = RGBColor(108, 150, 225, 255);
    local skyColor     = RGBColor(0, 55, 255, 255);
    local fogColor     = Desaturate_RGBColor(skyColor, 0.7);
    
    --adjust the colors a bit (yes there is a lot of tweaks... would be easier if we had a level editor... but we dont yet)
    --skyColor = Desaturate_RGBColor(skyColor, 0.2);
    fogColor = Multiplier_RGBColor(fogColor, 3.8);
    fogColor = Desaturate_RGBColor(fogColor, 0.75);
    sunColor = Desaturate_RGBColor(sunColor, 0.55);
    --skyColor = Desaturate_RGBColor(skyColor, 0.2);
    sunColor = Desaturate_RGBColor(sunColor, 0.0);
    ambientColor = Desaturate_RGBColor(ambientColor, 0.45);
    ambientColor = Multiplier_RGBColor(ambientColor, 1.0);
    
    --set the alpha value of the fog color to be fully opaque
    local finalFogColor = Color(fogColor.r, fogColor.g, fogColor.b, 1.0);

    local sunRotation = Vector(36.666, 113.1561, 0);
    
    --change the properties of the fog
    local fogName = "module_environment";
    ALIVE_AgentSetProperty(fogName, "Env - Fog Color", finalFogColor, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Fog Start Distance", 3.25, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Fog Height", 3.45, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Fog Density", 0.0005, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Fog Max Opacity", 1.0, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Fog Enabled", true, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Enabled", true, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Enabled on High", true, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Enabled on Medium", true, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Enabled on Low", true, kScene);
    --ALIVE_AgentSetProperty(fogName, "Env - Priority", 1000, kScene);

    --create our sunlight
    --local myLight_Sun = AgentCreate("myLight_Sun", envlight_prop, Vector(0,0,0), sunRotation, kScene, false, false);
    ALIVE_SetAgentWorldRotation("light_ENV_D_SunKey", sunRotation, kScene);
    --ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Type", 2, kScene);
    ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Intensity", 5, kScene);
    ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Intensity Specular", 1, kScene);
    ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Enlighten Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Radius", 1, kScene);
    --ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Distance Falloff", 1, kScene);
    --ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Spot Angle Inner", 5, kScene);
    --ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Spot Angle Outer", 45, kScene);
    ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Color", sunColor, kScene);
    --ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    --ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Shadow Type", 2, kScene);
    --ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Wrap", 0.05, kScene);
    ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Shadow Quality", 3, kScene);
    ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - HBAO Participation Type", 2, kScene);
    ALIVE_AgentSetProperty("light_ENV_D_SunKey", "EnvLight - Mobility", 2, kScene);

    --create our ambient light
    local myLight_Amb = AgentCreate("myLight_Amb", envlight_prop, Vector(0,0,0), Vector(0, 0, 0), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Type", 3, kScene);
    ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Intensity", 2, kScene);
    ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Intensity Specular", 0, kScene);
    ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Radius", 1, kScene);
    ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Distance Falloff", 1, kScene);
    ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Spot Angle Outer", 45, kScene);
    ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Color", ambientColor, kScene);
    ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Shadow Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Wrap", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Shadow Quality", 0, kScene);
    ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Mobility", 2, kScene);

    --create our sun ambient light
    local myLight_SunAmb = AgentCreate("myLight_SunAmb", envlight_prop, Vector(0,0,0), sunRotation, kScene, false, false);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Type", 4, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Intensity", 0.25, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Intensity Specular", 1.0, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Radius", 1, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Distance Falloff", 1, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Spot Angle Outer", 45, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Color", sunColor, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Shadow Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Wrap", 0.5, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Shadow Quality", 0, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Mobility", 2, kScene);

    --sky light/color
    ALIVE_AgentSetProperty("light_SKY_amb", "EnvLight - Intensity", 5, kScene);
    ALIVE_AgentSetProperty("light_SKY_amb", "EnvLight - Color", skyColor, kScene);
    
    --create a spotlight that emulates the sundisk in the sky
    --local myLight_SkySun = AgentCreate("myLight_SkySun", envlight_prop, Vector(0,0,0), Vector(36.666 - 180, 113.1561, 0), kScene, false, false);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Type", 1, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Intensity", 25, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Enlighten Intensity", 0.0, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Radius", 2555, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Distance Falloff", 9, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Spot Angle Inner", 5, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Spot Angle Outer", 65, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Color", sunColor, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Enabled Group", skyEnvlight_groupEnabled, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Groups", skyEnvlight_groups, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Shadow Type", 0, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Wrap", 0.0, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Shadow Quality", 0, kScene);
    --ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - HBAO Participation Type", 1, kScene);
  
    --remove original sun since we created our own and only needed it for getting the correct lighting groups.
    --ALIVE_RemoveAgent("light_ENV_D_SunKey", kScene);
    --ALIVE_RemoveAgent("module_environment", kScene);

    ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "adv_", "Render EnvLight Shadow Cast Enable", true);
    ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "adv_", "Render Shadow Force Visible", true);
    ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "adv_", "Render Enlighten Force Visible", true);
    

    --modify the scene post processing
    ALIVE_AgentSetProperty(agent_name_scene, "FX anti-aliasing", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Sharp Shadows Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Generate NPR Lines", false, kScene)
    ALIVE_AgentSetProperty(agent_name_scene, "Screen Space Lines - Enabled", false, kScene)
    ALIVE_AgentSetProperty(agent_name_scene, "FX Ambient Occlusion Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap White Point", 10.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Black Point", 0.005, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Toe Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Shoulder Intensity", 0.75, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Type", 2, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Pivot", 0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Shoulder Intensity", 0.8, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Intensity", 2.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Radius", 0.75, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Max Radius Percent", 0.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Max Distance", 35.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Distance Falloff", 1, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Hemisphere Bias", 0.1, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Bloom Threshold", -0.45, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Bloom Intensity", 0.25, kScene);
    --ALIVE_AgentSetProperty(agent_name_scene, "Ambient Color", ambientColor, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Ambient Color", RGBColor(0, 0, 0, 0), kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Shadow Color", RGBColor(0, 0, 0, 0), kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Tint Enabled", false, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Tint", RGBColor(0, 0, 0, 255), kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Falloff", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Center", 0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Corners", 1.0, kScene);

    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Reflection Enabled", true, kScene);

    local reflTexture = "adv_boardingSchoolExterior_module_lightprobe.d3dtx";
    --local reflTexture = "adv_boardingSchoolExteriorNight_module_lightprobeWet.d3dtx";

    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Reflection Texture", reflTexture, kScene);


    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Saturation", 7.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Reflection Intensity Shadow", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Reflection Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Max Distance", 40.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Dynamic Shadow Max Distance", 45.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Position Offset Bias", 0.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Depth Bias", -1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Auto Depth Bounds", false, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Light Bleed Reduction", 0.8, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Moment Bias", 0.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Specular Multiplier Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Specular Color Multiplier", 1, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Specular Intensity Multiplier", 1, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Specular Exponent Multiplier", 1, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Noise Scale", 1, kScene);



    --ALIVE_PrintValidPropertyNames(AgentFindInScene(agent_name_scene, kScene));
    --ALIVE_GetCacheObjectNamesFromProperties(AgentFindInScene(agent_name_scene, kScene), "cleanedCacheObjectsList404.txt");


    --ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesABuilding", "Runtime: Visible", false, kScene);
    --ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesBBuilding", "Runtime: Visible", false, kScene);
    --ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesCBuilding", "Runtime: Visible", false, kScene);
    --ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesDBuilding", "Runtime: Visible", false, kScene);
    --ALIVE_AgentSetProperty("adv_boardingSchoolExteriorDusk_meshesATerrain", "Runtime: Visible", false, kScene);

    --ALIVE_PrintValidPropertyNames(AgentFindInScene("adv_boardingSchoolExteriorDusk_meshesATerrain", kScene));
    --ALIVE_PrintProperties(AgentFindInScene("adv_boardingSchoolExteriorDusk_meshesATerrain", kScene));
    --ALIVE_GetCacheObjectNamesFromProperties(AgentFindInScene("adv_boardingSchoolExteriorDusk_meshesATerrain", kScene), "cleanedCacheObjectsList404.txt");

    --ALIVE_AgentSetProperty("adv_boardingSchoolExteriorDusk_meshesATerrain", "material_environment_blend - Specular Map Texture", "color_818181.d3dtx", kScene);

    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "adv_", "material_environment_diffuseTexture - Diffuse Texture", "color_fff.d3dtx");
    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "obj_", "material_environment_diffuseTexture - Diffuse Texture", "color_fff.d3dtx");
    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "adv_", "Mesh Material - Diffuse Texture", "color_fff.d3dtx");
    --ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "obj_", "Mesh Material - Diffuse Texture", "color_fff.d3dtx");

    --local myTexture = "color_fff.d3dtx"; --white
    --local myTexture = "color_fff0000.d3dtx"; --red
    --local myTexture = "color_818181.d3dtx"; --grey
    --local myTexture = "color_666666.d3dtx"; --dark grey
    --local myTexture = "color_000.d3dtx"; --black

    --local detailOverride = "color_000.d3dtx"; 
    --ALIVE_AgentSetPropertyBySymbol("adv_boardingSchoolExteriorDusk_meshesATerrain", "1247179126748057115", detailOverride, kScene);
    --ALIVE_AgentSetPropertyBySymbol("adv_boardingSchoolExteriorDusk_meshesATerrain", "2309337447347687087", detailOverride, kScene);
    --ALIVE_AgentSetPropertyBySymbol("adv_boardingSchoolExteriorDusk_meshesATerrain", "3443824071635131902", detailOverride, kScene);
    --ALIVE_AgentSetPropertyBySymbol("adv_boardingSchoolExteriorDusk_meshesATerrain", "4739797867705960071", detailOverride, kScene);
    --ALIVE_AgentSetPropertyBySymbol("adv_boardingSchoolExteriorDusk_meshesATerrain", "9321315489835257788", detailOverride, kScene);
    --ALIVE_AgentSetPropertyBySymbol("adv_boardingSchoolExteriorDusk_meshesATerrain", "10180005244072756145", detailOverride, kScene);
    --ALIVE_AgentSetPropertyBySymbol("adv_boardingSchoolExteriorDusk_meshesATerrain", "12997142810228616495", detailOverride, kScene);
    --ALIVE_AgentSetPropertyBySymbol("adv_boardingSchoolExteriorDusk_meshesATerrain", "13006463388689406573", detailOverride, kScene);
    --ALIVE_AgentSetPropertyBySymbol("adv_boardingSchoolExteriorDusk_meshesATerrain", "14271606096665040967", detailOverride, kScene);
    --ALIVE_AgentSetPropertyBySymbol("adv_boardingSchoolExteriorDusk_meshesATerrain", "16554479606549996629", detailOverride, kScene);

    --local testTexture = "color_000.d3dtx"; --black
    --local testTexture = "color_818181.d3dtx"; --grey
    --local testTexture = "color_fff.d3dtx"; --white
    --ALIVE_SetTexturesOnAgentWithNamePrefix("adv_boardingSchoolExteriorDusk_meshesATerrain", "_ink", testTexture, "cleanedCacheObjectsList404.txt", kScene);
    --ALIVE_SetTexturesOnAgentWithNamePrefix("adv_boardingSchoolExteriorDusk_meshesATerrain", "_detail", testTexture, "cleanedCacheObjectsList404.txt", kScene);
    --ALIVE_SetTexturesOnAgentWithNamePrefix("adv_boardingSchoolExteriorDusk_meshesATerrain", "_height", testTexture, "cleanedCacheObjectsList404.txt", kScene);

    --ALIVE_SetTexturesOnAgentsWithNamePrefixes("adv_", "_ink", "color_000.d3dtx", "cleanedCacheObjectsList404.txt", kScene);
    --ALIVE_SetTexturesOnAgentsWithNamePrefixes("adv_", "_detail", "color_000.d3dtx", "cleanedCacheObjectsList404.txt", kScene);
    --ALIVE_SetTexturesOnAgentsWithNamePrefixes("adv_", "", testTexture, "cleanedCacheObjectsList404.txt", kScene);

    --ALIVE_SetDiffuseTexturesOnAgentsWithNamePrefixes("adv_", testTexture, "cleanedCacheObjectsList404.txt", kScene)

    --local heightOverride = "color_000.d3dtx";
    --ALIVE_AgentSetPropertyBySymbol("adv_boardingSchoolExteriorDusk_meshesATerrain", "1409753310992724431", heightOverride, kScene);
    --ALIVE_AgentSetPropertyBySymbol("adv_boardingSchoolExteriorDusk_meshesATerrain", "4166776517987211008", heightOverride, kScene);
    --ALIVE_AgentSetPropertyBySymbol("adv_boardingSchoolExteriorDusk_meshesATerrain", "7526614341553303821", heightOverride, kScene);
    --ALIVE_AgentSetPropertyBySymbol("adv_boardingSchoolExteriorDusk_meshesATerrain", "16797662907521473580", heightOverride, kScene);
    --ALIVE_AgentSetPropertyBySymbol("adv_boardingSchoolExteriorDusk_meshesATerrain", "17703505755361902902", heightOverride, kScene);

    --ALIVE_AgentSetPropertyBySymbol("adv_boardingSchoolExteriorDusk_meshesATerrain", "16751189380505258298", myTexture, kScene);
    --ALIVE_AgentSetPropertyBySymbol("adv_boardingSchoolExteriorDusk_meshesATerrain", "16473673868022238092", myTexture, kScene);
    --ALIVE_AgentSetPropertyBySymbol("adv_boardingSchoolExteriorDusk_meshesATerrain", "8556631463500348325", myTexture, kScene);
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

    --RenderPassDisable("");
    RenderSetFeatureEnabled("dof", true);
    RenderSetFeatureEnabled("glow", true);
    RenderSetFeatureEnabled("motionblur", false);
    RenderSetFeatureEnabled("brush", true);
    RenderSetFeatureEnabled("lowresalpha", true);
    RenderSetFeatureEnabled("finalresolve", true);
    RenderSetFeatureEnabled("bakelit", true);
    RenderSetFeatureEnabled("nprlines", false);
    RenderSetFeatureEnabled("computecullshadows", true);
    RenderSetFeatureEnabled("depthcullshadows", false);
    RenderSetFeatureEnabled("optimizesdsm", true);
    RenderSetFeatureEnabled("bokeh", true);
    RenderSetFeatureEnabled("enlighten", true);
    RenderSetFeatureEnabled("invertz", false);
    RenderSetFeatureEnabled("occlusion", true);
    RenderSetFeatureEnabled("computelightcluster", false);
    RenderSetFeatureEnabled("lowreslight", false);
    RenderSetFeatureEnabled("lod", true);
    RenderSetFeatureEnabled("computeskinning", true);
    RenderSetFeatureEnabled("forcedepth", true);
    --RenderSetScaleForResolution(1.0);
    RenderSetScale(1.0);
    --RenderSetHDRSurfaceFormat("srgb");
    --RenderSetHDRSurfaceFormat("rgb10");
    --RenderSetHDRSurfaceFormat("rgb10f");
    --RenderSetHDRSurfaceFormat("rgb16f");
    --RenderSetHDRSurfaceFormat("default");
    --GameSetName("Telltale Tool (WD4 Project)")
end