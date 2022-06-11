ALIVE_Scene_LevelRelight_305_RichmondOverpass = function(kScene)
    local agent_name_scene = kScene .. ".scene";
    local maxDistance = 50.0;

    local envlight  = AgentFindInScene("light_ENV_DIR_SunKey", kScene);
    local envlight_props = AgentGetRuntimeProperties(envlight);
    local envlight_groupEnabled = PropertyGet(envlight_props, "EnvLight - Enabled Group");
    local envlight_groups = PropertyGet(envlight_props, "EnvLight - Groups");
    
    --find the original sky light in the scene (note telltale dev, why do you use a light source for the skybox when you could've just had the sky be an (emmissive/unlit) shader?)
    local skyEnvlight  = AgentFindInScene("light_SKY_amb", kScene);
    local skyEnvlight_props = AgentGetRuntimeProperties(skyEnvlight);
    local skyEnvlight_groupEnabled = PropertyGet(skyEnvlight_props, "EnvLight - Enabled Group");
    local skyEnvlight_groups = PropertyGet(skyEnvlight_props, "EnvLight - Groups");

    --the main prop (like a prefab) file for a generic light
    local envlight_prop = "module_env_light.prop";
    
    --calculate some new colors
    local sunColor     = RGBColor(255, 240, 188, 255);
    local ambientColor = RGBColor(108, 160, 225, 255);
    local skyColor     = RGBColor(0, 95, 255, 255);
    local fogColor     = Desaturate_RGBColor(skyColor, 0.5);
    
    --adjust the colors a bit (yes there is a lot of tweaks... would be easier if we had a level editor... but we dont yet)
    --skyColor = Desaturate_RGBColor(skyColor, 0.2);
    fogColor = Multiplier_RGBColor(fogColor, 3.8);
    fogColor = Desaturate_RGBColor(fogColor, 0.75);
    sunColor = Desaturate_RGBColor(sunColor, 0.05);
    skyColor = Desaturate_RGBColor(skyColor, 0.3);
    ambientColor = Desaturate_RGBColor(ambientColor, 0.4);
    ambientColor = Multiplier_RGBColor(ambientColor, 1.1);
    
    --set the alpha value of the fog color to be fully opaque
    local finalFogColor = Color(fogColor.r, fogColor.g, fogColor.b, 1.0);

    local sunRotation = Vector(20, 300, 0);
    --local sunRotation = Vector(20, 80, 0);

    ALIVE_SetAgentWorldRotation("obj_matteRichmondRooftops360Vista", Vector(0, sunRotation.y, 0), kScene);
    
    local buildingAgent1 = AgentCreate("building1", "adv_richmondSquare_meshesBBuildings.prop", Vector(21,-4,0), Vector(0, 0, 0), kScene, false, false);
    local buildingAgent2 = AgentCreate("building2", "adv_richmondSquare_meshesDBuildings.prop", Vector(21,-4,0), Vector(0, 0, 0), kScene, false, false);
    local buildingAgent3 = AgentCreate("building3", "adv_richmondSquare_meshesEBuildings.prop", Vector(21,-4,0), Vector(0, 0, 0), kScene, false, false);
    local buildingAgent4 = AgentCreate("building4", "adv_richmondSquare_meshesFBuildings.prop", Vector(51,-6, 2), Vector(0, 90, 0), kScene, false, false); 
    local buildingAgent5 = AgentCreate("building5", "adv_richmondSquare_meshesHBuildings.prop", Vector(28,-7,9), Vector(0, 90, 0), kScene, false, false); --church
    local buildingAgent6 = AgentCreate("building6", "adv_richmondSquare_meshesIBuildings.prop", Vector(18,-7,91), Vector(0, 90, 0), kScene, false, false); --medical building
    local buildingAgent7 = AgentCreate("building7", "adv_richmondSquare_meshesKABuildings.prop", Vector(21,-23,4), Vector(0, 180, 0), kScene, false, false);

    --change the properties of the fog
    local fogName = "module_environment";
    ALIVE_AgentSetProperty(fogName, "Env - Fog Color", finalFogColor, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Fog Start Distance", 5.25, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Fog Height", 12.45, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Fog Density", 0.0002, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Fog Max Opacity", 0.075, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Fog Enabled", true, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Enabled", true, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Enabled on High", true, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Enabled on Medium", true, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Enabled on Low", true, kScene);
    --ALIVE_AgentSetProperty(fogName, "Env - Priority", 1000, kScene);

    --create our sunlight
    --local myLight_Sun = AgentCreate("myLight_Sun", envlight_prop, Vector(0,0,0), sunRotation, kScene, false, false);
    ALIVE_SetAgentWorldRotation("light_ENV_DIR_SunKey", sunRotation, kScene);
    --ALIVE_AgentSetProperty("light_ENV_DIR_SunKey", "EnvLight - Type", 2, kScene);
    ALIVE_AgentSetProperty("light_ENV_DIR_SunKey", "EnvLight - Intensity", 4.5, kScene);
    ALIVE_AgentSetProperty("light_ENV_DIR_SunKey", "EnvLight - Intensity Specular", 1.0, kScene);
    ALIVE_AgentSetProperty("light_ENV_DIR_SunKey", "EnvLight - Enlighten Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty("light_ENV_DIR_SunKey", "EnvLight - Radius", 1, kScene);
    --ALIVE_AgentSetProperty("light_ENV_DIR_SunKey", "EnvLight - Distance Falloff", 1, kScene);
    --ALIVE_AgentSetProperty("light_ENV_DIR_SunKey", "EnvLight - Spot Angle Inner", 5, kScene);
    --ALIVE_AgentSetProperty("light_ENV_DIR_SunKey", "EnvLight - Spot Angle Outer", 45, kScene);
    ALIVE_AgentSetProperty("light_ENV_DIR_SunKey", "EnvLight - Color", sunColor, kScene);
    --ALIVE_AgentSetProperty("light_ENV_DIR_SunKey", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    --ALIVE_AgentSetProperty("light_ENV_DIR_SunKey", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("light_ENV_DIR_SunKey", "EnvLight - Shadow Type", 3, kScene);
    ALIVE_AgentSetProperty("light_ENV_DIR_SunKey", "EnvLight - Wrap", 0.025, kScene);
    ALIVE_AgentSetProperty("light_ENV_DIR_SunKey", "EnvLight - Shadow Quality", 3, kScene);
    ALIVE_AgentSetProperty("light_ENV_DIR_SunKey", "EnvLight - HBAO Participation Type", 2, kScene);
    ALIVE_AgentSetProperty("light_ENV_DIR_SunKey", "EnvLight - Mobility", 2, kScene);

    --create our ambient light
    --local myLight_Amb = AgentCreate("myLight_Amb", envlight_prop, Vector(0,0,0), Vector(0, 0, 0), kScene, false, false);
    --ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Type", 3, kScene);
    --ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Intensity", 2, kScene);
    --ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Intensity Specular", 0, kScene);
    --ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Enlighten Intensity", 0.0, kScene);
    --ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Radius", 1, kScene);
    --ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Distance Falloff", 1, kScene);
    --ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Spot Angle Inner", 5, kScene);
    --ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Spot Angle Outer", 45, kScene);
    --ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Color", ambientColor, kScene);
    --ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    --ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Groups", envlight_groups, kScene);
    --ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Shadow Type", 0, kScene);
    --ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Wrap", 0.0, kScene);
    --ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Shadow Quality", 0, kScene);
    --ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - HBAO Participation Type", 1, kScene);
    --ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Mobility", 2, kScene);

    --create our sun ambient light
    local myLight_SunAmb = AgentCreate("myLight_SunAmb", envlight_prop, Vector(0,0,0), sunRotation, kScene, false, false);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Type", 4, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Intensity", 2.25, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Intensity Specular", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Radius", 1, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Distance Falloff", 1, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Spot Angle Outer", 45, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Color", sunColor, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Shadow Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Wrap", 0.75, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Shadow Quality", 0, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Mobility", 2, kScene);

    --sky light/color
    ALIVE_AgentSetProperty("light_SKY_amb", "EnvLight - Intensity", 15, kScene);
    ALIVE_AgentSetProperty("light_SKY_amb", "EnvLight - Color", skyColor, kScene);

    ALIVE_AgentSetProperty("light_AMB", "EnvLight - Intensity", 7, kScene);
    --ALIVE_AgentSetProperty("light_AMB", "EnvLight - Color", sunColor, kScene);
    ALIVE_AgentSetProperty("light_AMB", "EnvLight - Color", skyColor, kScene);
    
    --create a spotlight that emulates the sundisk in the sky
    local myLight_SkySun = AgentCreate("myLight_SkySun", envlight_prop, Vector(0, 0, 0), Vector(sunRotation.x - 180, sunRotation.y, sunRotation.z), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Intensity", 725, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Radius", 2555, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Distance Falloff", 150, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Spot Angle Inner", 1, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Spot Angle Outer", 65, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Color", sunColor, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Enabled Group", skyEnvlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Groups", skyEnvlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Shadow Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Wrap", 0.85, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Shadow Quality", 0, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - HBAO Participation Type", 1, kScene);

    local myLight_SkySun = AgentCreate("myLight_SkyHorizon", envlight_prop, Vector(0, 500, 0), Vector(0, 0, 0), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_SkyHorizon", "EnvLight - Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_SkyHorizon", "EnvLight - Intensity", 5, kScene);
    ALIVE_AgentSetProperty("myLight_SkyHorizon", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_SkyHorizon", "EnvLight - Radius", 8555, kScene);
    ALIVE_AgentSetProperty("myLight_SkyHorizon", "EnvLight - Distance Falloff", 9, kScene);
    ALIVE_AgentSetProperty("myLight_SkyHorizon", "EnvLight - Spot Angle Inner", 90, kScene);
    ALIVE_AgentSetProperty("myLight_SkyHorizon", "EnvLight - Spot Angle Outer", 180, kScene);
    ALIVE_AgentSetProperty("myLight_SkyHorizon", "EnvLight - Color", skyColor, kScene);
    ALIVE_AgentSetProperty("myLight_SkyHorizon", "EnvLight - Enabled Group", skyEnvlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_SkyHorizon", "EnvLight - Groups", skyEnvlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_SkyHorizon", "EnvLight - Shadow Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_SkyHorizon", "EnvLight - Wrap", 1.0, kScene);
    ALIVE_AgentSetProperty("myLight_SkyHorizon", "EnvLight - Shadow Quality", 0, kScene);
    ALIVE_AgentSetProperty("myLight_SkyHorizon", "EnvLight - HBAO Participation Type", 1, kScene);
  
    --remove original sun since we created our own and only needed it for getting the correct lighting groups.
    --ALIVE_RemoveAgent("light_ENV_D_SunKey", kScene);
    --ALIVE_RemoveAgent("module_environment", kScene);

    ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "adv_", "Render EnvLight Shadow Cast Enable", true);
    ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "adv_", "Render Shadow Force Visible", true);
    ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "adv_", "Render Enlighten Force Visible", true);
    ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "obj_", "Render EnvLight Shadow Cast Enable", true);
    ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "obj_", "Render Shadow Force Visible", true);
    ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "obj_", "Render Enlighten Force Visible", true);

    ALIVE_AgentSetProperty("obj_skyDome", "Render EnvLight Shadow Cast Enable", false, kScene);
    ALIVE_AgentSetProperty("obj_skyDome", "Render Shadow Force Visible", false, kScene);
    ALIVE_AgentSetProperty("obj_skyDome", "Render Enlighten Force Visible", false, kScene);
    
    --local reflTexture = "adv_boardingSchoolExterior_module_lightprobe.d3dtx";
    local reflTexture = "adv_richmondFactoryExteriorBack_module_lightprobe.d3dtx";

    --modify the scene post processing
    ALIVE_AgentSetProperty(agent_name_scene, "FX anti-aliasing", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX TAA Weight", 0.75, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Color Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Color Tint", RGBColor(255, 255, 255, 255), kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Color Opacity", 0.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Glow Clear Color", RGBColor(255, 255, 255, 255), kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Glow Sigma Scale", 7.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Sharp Shadows Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Generate NPR Lines", false, kScene)
    ALIVE_AgentSetProperty(agent_name_scene, "Screen Space Lines - Enabled", false, kScene)
    ALIVE_AgentSetProperty(agent_name_scene, "FX Ambient Occlusion Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Intensity", 44.25, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap White Point", 100.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Black Point", 0.005, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Toe Intensity", 0.75, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Shoulder Intensity", 1.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Type", 2, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Pivot", 0.1, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Intensity", 2.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Radius", 1.35, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Max Radius Percent", 15.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Max Distance", maxDistance, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Distance Falloff", 1, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Hemisphere Bias", -0.1, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Occlusion Scale", 0.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Luminance Scale", 0.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Blur Sharpness", 7.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Bloom Threshold", -0.55, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Bloom Intensity", 0.15, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Ambient Color", ambientColor, kScene);
    --ALIVE_AgentSetProperty(agent_name_scene, "Ambient Color", RGBColor(0, 0, 0, 0), kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Shadow Color", RGBColor(0, 0, 0, 0), kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Tint Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Tint", RGBColor(0, 0, 0, 255), kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Falloff", 1.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Center", 0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Corners", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Reflection Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Reflection Texture", reflTexture, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Saturation", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Reflection Intensity Shadow", 0.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Reflection Intensity", 3.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Reflection Tint", RGBColor(170, 230, 255, 255), kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Max Distance", maxDistance, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Light Shadow Trace Max Distance", maxDistance / 3, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Min Distance", 0.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Cascade Split Bias", 0.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Max Updates", 8, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Dynamic Shadow Max Distance", maxDistance, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Position Offset Bias", 0.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Depth Bias", -1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Auto Depth Bounds", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Light Bleed Reduction", 0.4, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Moment Bias", 0.1, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Specular Multiplier Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Specular Color Multiplier", 1, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Specular Intensity Multiplier", 1, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Specular Exponent Multiplier", 1, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Noise Scale", 1, kScene);

    local newDistance = 1000.0;
    RenderSetDecalVisibleDistance(newDistance, StringToSymbol("Lowest"));
    RenderSetDecalVisibleDistance(newDistance, StringToSymbol("Low"));
    RenderSetDecalVisibleDistance(newDistance, StringToSymbol("Low+"));
    RenderSetDecalVisibleDistance(newDistance, StringToSymbol("Mid"));
    RenderSetDecalVisibleDistance(newDistance, StringToSymbol("High"));
    RenderSetDecalVisibleDistance(newDistance, StringToSymbol("None"));


    --ALIVE_PrintOutCacheObjectProperties(AgentFindInScene(agent_name_scene, kScene), "LightEnv Reflection Texture");

    --ALIVE_PrintValidPropertyNames(AgentFindInScene("obj_skyDome", kScene));
    --ALIVE_GetCacheObjectNamesFromProperties(AgentFindInScene("obj_skyDome", kScene), "cacheObjectNamesPart2Cleaned.txt");


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

    local skyTex1Override = "color_818181.d3dtx"; 
    ALIVE_AgentSetPropertyBySymbol("obj_skyDome", "1893731503509791374", skyTex1Override, kScene);
    ALIVE_AgentSetPropertyBySymbol("obj_skyDome", "8884887503322744022", skyTex1Override, kScene);
    ALIVE_AgentSetPropertyBySymbol("obj_skyDome", "10891831632055398974", skyTex1Override, kScene);
    ALIVE_AgentSetPropertyBySymbol("obj_skyDome", "14857997951386233173", skyTex1Override, kScene);
    ALIVE_AgentSetPropertyBySymbol("obj_skyDome", "17722002904829990873", skyTex1Override, kScene);

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
    --RenderSetFeatureEnabled("dof", true);
    RenderSetFeatureEnabled("glow", true);
    RenderSetFeatureEnabled("motionblur", false);
    --RenderSetFeatureEnabled("brush", true);
    --RenderSetFeatureEnabled("lowresalpha", true);
    RenderSetFeatureEnabled("finalresolve", true);
    RenderSetFeatureEnabled("bakelit", true);
    RenderSetFeatureEnabled("nprlines", false);
    --RenderSetFeatureEnabled("computecullshadows", true);
    --RenderSetFeatureEnabled("depthcullshadows", false);
    --RenderSetFeatureEnabled("optimizesdsm", true);
    RenderSetFeatureEnabled("bokeh", true);
    RenderSetFeatureEnabled("enlighten", true);
    --RenderSetFeatureEnabled("invertz", false);
    --RenderSetFeatureEnabled("occlusion", true);
    RenderSetFeatureEnabled("computelightcluster", true);
    --RenderSetFeatureEnabled("lowreslight", false);
    --RenderSetFeatureEnabled("lod", true);
    --RenderSetFeatureEnabled("computeskinning", true);
    --RenderSetFeatureEnabled("forcedepth", true);
    --RenderSetScaleForResolution(1.0);
    --RenderSetHDRColorBufferScale(5.0);
    RenderSetScale(4.0);
    --RenderSetHDRSurfaceFormat("srgb");
    --RenderSetHDRSurfaceFormat("rgb10");
    --RenderSetHDRSurfaceFormat("rgb10f");
    RenderSetHDRSurfaceFormat("rgb16f");
    --RenderSetHDRSurfaceFormat("default");
    --GameSetName("Telltale Tool (WD4 Project)")
end