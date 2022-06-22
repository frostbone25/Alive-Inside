ALIVE_Scene_LevelRelight_404_BoardingSchoolDorm_MainMenu = function(kScene)
    local agent_name_scene = kScene .. ".scene";
    local maxDistance = 2.75;

    local envlight = AgentFindInScene("light_ENV_clemsRoomNoon_sunKey", kScene);
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
    local sunColor     = RGBColor(255, 128, 0, 255);
    local ambientColor = RGBColor(0, 130, 255, 255);
    local skyColor     = RGBColor(0, 60, 255, 255);
    
    --adjust the colors a bit (yes there is a lot of tweaks... would be easier if we had a level editor... but we dont yet)
    --skyColor = Desaturate_RGBColor(skyColor, 0.2);
    sunColor = Desaturate_RGBColor(sunColor, 0.45);
    skyColor = Desaturate_RGBColor(skyColor, 0.5);
    ambientColor = Desaturate_RGBColor(ambientColor, 0.75);

    local sunRotation = Vector(13, -127, 0);

    --create our sunlight
    local myLight_Sun = AgentCreate("myLight_Sun", envlight_prop, Vector(0,0,0), sunRotation, kScene, false, false);
    ALIVE_SetAgentWorldRotation("myLight_Sun", sunRotation, kScene);

    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Type", 2, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Intensity", 85.0, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Intensity Specular", 1.0, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Enlighten Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Radius", 1, kScene);
    --ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Distance Falloff", 1, kScene);
    --ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Spot Angle Inner", 5, kScene);
    --ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Spot Angle Outer", 45, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Color", sunColor, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Shadow Type", 2, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Wrap", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Shadow Quality", 3, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - HBAO Participation Type", 2, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Mobility", 2, kScene);

    --create our ambient light
    local myLight_Amb = AgentCreate("myLight_Amb", envlight_prop, Vector(0,0,0), Vector(0, 0, 0), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Type", 3, kScene);
    ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Intensity", 0.35, kScene);
    ALIVE_AgentSetProperty("myLight_Amb", "EnvLight - Intensity Specular", 1.0, kScene);
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

    local myLight_GIBounce1 = AgentCreate("myLight_GIBounce1", envlight_prop, Vector(16.40, 0.97, -5.50), Vector(15, 35, 0), kScene, false, false); --room bounce
    ALIVE_AgentSetProperty("myLight_GIBounce1", "EnvLight - Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce1", "EnvLight - Intensity", 2.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce1", "EnvLight - Intensity Specular", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce1", "EnvLight - Enlighten Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce1", "EnvLight - Radius", 5, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce1", "EnvLight - Distance Falloff", 3, kScene);
    --ALIVE_AgentSetProperty("myLight_GIBounce1", "EnvLight - Spot Angle Inner", 5, kScene);
    --ALIVE_AgentSetProperty("myLight_GIBounce1", "EnvLight - Spot Angle Outer", 45, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce1", "EnvLight - Color", Desaturate_RGBColor(sunColor, 0.45), kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce1", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce1", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce1", "EnvLight - Shadow Type", 2, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce1", "EnvLight - Wrap", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce1", "EnvLight - Shadow Quality", 3, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce1", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce1", "EnvLight - Mobility", 2, kScene);

    local myLight_GIBounce2 = AgentCreate("myLight_GIBounce2", envlight_prop, Vector(17.63, 1.72, -4.36), Vector(0, 0, 0), kScene, false, false); --window bounce
    ALIVE_AgentSetProperty("myLight_GIBounce2", "EnvLight - Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce2", "EnvLight - Intensity", 4.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce2", "EnvLight - Intensity Specular", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce2", "EnvLight - Enlighten Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce2", "EnvLight - Radius", 4, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce2", "EnvLight - Distance Falloff", 5, kScene);
    --ALIVE_AgentSetProperty("myLight_GIBounce2", "EnvLight - Spot Angle Inner", 5, kScene);
    --ALIVE_AgentSetProperty("myLight_GIBounce2", "EnvLight - Spot Angle Outer", 45, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce2", "EnvLight - Color", Desaturate_RGBColor(sunColor, 0.6), kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce2", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce2", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce2", "EnvLight - Shadow Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce2", "EnvLight - Wrap", 1.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce2", "EnvLight - Shadow Quality", 3, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce2", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce2", "EnvLight - Mobility", 2, kScene);

    local myLight_GIBounce3 = AgentCreate("myLight_GIBounce3", envlight_prop, Vector(17.02, 1.25, -3.87), Vector(41, 171, 0), kScene, false, false); --hat accent light
    ALIVE_AgentSetProperty("myLight_GIBounce3", "EnvLight - Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce3", "EnvLight - Intensity", 15.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce3", "EnvLight - Intensity Specular", 1.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce3", "EnvLight - Enlighten Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce3", "EnvLight - Radius", 5, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce3", "EnvLight - Distance Falloff", 5, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce3", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce3", "EnvLight - Spot Angle Outer", 45, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce3", "EnvLight - Color", Desaturate_RGBColor(sunColor, 0.0), kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce3", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce3", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce3", "EnvLight - Shadow Type", 2, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce3", "EnvLight - Wrap", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce3", "EnvLight - Shadow Quality", 3, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce3", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce3", "EnvLight - Mobility", 2, kScene);

    local myLight_GIBounce4 = AgentCreate("myLight_GIBounce4", envlight_prop, Vector(17.176, 0.813, -4.624), Vector(-10.17, -17.72, 0), kScene, false, false); --hat left bounce light
    ALIVE_AgentSetProperty("myLight_GIBounce4", "EnvLight - Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce4", "EnvLight - Intensity", 15.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce4", "EnvLight - Intensity Specular", 1.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce4", "EnvLight - Enlighten Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce4", "EnvLight - Radius", 5, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce4", "EnvLight - Distance Falloff", 5, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce4", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce4", "EnvLight - Spot Angle Outer", 45, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce4", "EnvLight - Color", Desaturate_RGBColor(RGBColor(255, 128, 0, 255), 0.75), kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce4", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce4", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce4", "EnvLight - Shadow Type", 2, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce4", "EnvLight - Wrap", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce4", "EnvLight - Shadow Quality", 3, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce4", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce4", "EnvLight - Mobility", 2, kScene);

    local myLight_GIBounce5 = AgentCreate("myLight_GIBounce5", envlight_prop, Vector(17.373, 0.795, -4.011), Vector(-32.33, -23.06, 0), kScene, false, false); --lightbulb bounce
    ALIVE_AgentSetProperty("myLight_GIBounce5", "EnvLight - Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce5", "EnvLight - Intensity", 5.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce5", "EnvLight - Intensity Specular", 1.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce5", "EnvLight - Enlighten Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce5", "EnvLight - Radius", 5, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce5", "EnvLight - Distance Falloff", 5, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce5", "EnvLight - Spot Angle Inner", 45, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce5", "EnvLight - Spot Angle Outer", 100, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce5", "EnvLight - Color", Desaturate_RGBColor(RGBColor(255, 128, 0, 255), 0.5), kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce5", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce5", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce5", "EnvLight - Shadow Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce5", "EnvLight - Wrap", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce5", "EnvLight - Shadow Quality", 3, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce5", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce5", "EnvLight - Mobility", 2, kScene);

    local myLight_GIBounce6 = AgentCreate("myLight_GIBounce6", envlight_prop, Vector(16.734, 0.792, -4.883), Vector(-19.833, 88.593, 0), kScene, false, false); --window boards bounce
    ALIVE_AgentSetProperty("myLight_GIBounce6", "EnvLight - Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce6", "EnvLight - Intensity", 4.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce6", "EnvLight - Intensity Specular", 1.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce6", "EnvLight - Enlighten Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce6", "EnvLight - Radius", 5, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce6", "EnvLight - Distance Falloff", 5, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce6", "EnvLight - Spot Angle Inner", 0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce6", "EnvLight - Spot Angle Outer", 100, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce6", "EnvLight - Color", Desaturate_RGBColor(RGBColor(255, 128, 0, 255), 0.5), kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce6", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce6", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce6", "EnvLight - Shadow Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce6", "EnvLight - Wrap", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce6", "EnvLight - Shadow Quality", 3, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce6", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce6", "EnvLight - Mobility", 2, kScene);

    local myLight_GIBounce7 = AgentCreate("myLight_GIBounce7", envlight_prop, Vector(16.443, 0.996, -4.317), Vector(10, 90, 0), kScene, false, false); --window boards bounce
    ALIVE_AgentSetProperty("myLight_GIBounce7", "EnvLight - Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce7", "EnvLight - Intensity", 7.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce7", "EnvLight - Intensity Specular", 1.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce7", "EnvLight - Enlighten Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce7", "EnvLight - Radius", 5, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce7", "EnvLight - Distance Falloff", 5, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce7", "EnvLight - Spot Angle Inner", 0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce7", "EnvLight - Spot Angle Outer", 40, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce7", "EnvLight - Color", Desaturate_RGBColor(RGBColor(255, 128, 0, 255), 0.65), kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce7", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce7", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce7", "EnvLight - Shadow Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce7", "EnvLight - Wrap", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce7", "EnvLight - Shadow Quality", 3, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce7", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_GIBounce7", "EnvLight - Mobility", 2, kScene);

    --sky light/color
    ALIVE_AgentSetProperty("light_SKY_amb", "EnvLight - Intensity", 16.0, kScene);
    ALIVE_AgentSetProperty("light_SKY_amb", "EnvLight - Color", skyColor, kScene);

    --create a spotlight that emulates the sundisk in the sky
    local myLight_SkySun = AgentCreate("myLight_SkySun", envlight_prop, Vector(0, 0, 0), Vector(sunRotation.x - 180, sunRotation.y, sunRotation.z), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Intensity", 225, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Radius", 2555, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Distance Falloff", 150, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Spot Angle Inner", 1, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Spot Angle Outer", 90, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Color", RGBColor(255, 128, 0, 255), kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Enabled Group", skyEnvlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Groups", skyEnvlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Shadow Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Wrap", 0.85, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Shadow Quality", 0, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - HBAO Participation Type", 1, kScene);

    ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "adv_", "Render EnvLight Shadow Cast Enable", true);
    ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "adv_", "Render Shadow Force Visible", true);
    ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "adv_", "Render Enlighten Force Visible", true);
    ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "obj_", "Render EnvLight Shadow Cast Enable", true);
    ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "obj_", "Render Shadow Force Visible", true);
    ALIVE_SetPropertyOnAgentsWithPrefix(kScene, "obj_", "Render Enlighten Force Visible", true);

    ALIVE_AgentSetProperty("obj_skyDome", "Render EnvLight Shadow Cast Enable", false, kScene);
    ALIVE_AgentSetProperty("obj_skyDome", "Render Shadow Force Visible", false, kScene);
    ALIVE_AgentSetProperty("obj_skyDome", "Render Enlighten Force Visible", false, kScene);

    ALIVE_AgentSetProperty("obj_grassClumpA06", "Render EnvLight Shadow Cast Enable", false, kScene);
    ALIVE_AgentSetProperty("obj_grassClumpA06", "Render Shadow Force Visible", false, kScene);
    ALIVE_AgentSetProperty("obj_grassClumpA06", "Render Enlighten Force Visible", false, kScene);

    --modify the scene post processing
    ALIVE_AgentSetProperty(agent_name_scene, "FX anti-aliasing", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX TAA Weight", 0.01, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Color Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Color Tint", RGBColor(255, 255, 255, 255), kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Color Opacity", 0.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Glow Clear Color", RGBColor(255, 255, 255, 255), kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Glow Sigma Scale", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Sharp Shadows Enabled", false, kScene);
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
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Intensity", 3.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Radius", 0.15, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Max Radius Percent", 0.075, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Max Distance", maxDistance, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Distance Falloff", 0.05, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Hemisphere Bias", 0.05, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Occlusion Scale", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Luminance Scale", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Blur Sharpness", 7.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Bloom Threshold", -0.55, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Bloom Intensity", 0.175, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Ambient Color", RGBColor(0, 0, 0, 0), kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Shadow Color", RGBColor(0, 0, 0, 0), kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Tint Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Tint", RGBColor(0, 0, 0, 255), kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Falloff", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Center", 0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Corners", 1.0, kScene);

    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Reflection Enabled", true, kScene);

    --local reflTexture = "adv_boardingSchoolExterior_module_lightprobe.d3dtx";
    
    --ResourceSetEnable("WalkingDead303", 1400);
    --ResourceSetEnable("WalkingDead303");
    --local reflTexture = "adv_richmondFactoryExteriorBack_module_lightprobe.d3dtx";
    --ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Reflection Texture", reflTexture, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Reflection Intensity Shadow", 2.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Reflection Intensity", 2.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Reflection Tint", RGBColor(255, 200, 255, 255), kScene);

    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Saturation", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Max Distance", maxDistance, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Light Shadow Trace Max Distance", maxDistance / 3, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Min Distance", 0.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Cascade Split Bias", 0.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Max Updates", 8, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Dynamic Shadow Max Distance", maxDistance, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Position Offset Bias", 0.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Depth Bias", -1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Auto Depth Bounds", false, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Light Bleed Reduction", 0.4, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Moment Bias", 0.1, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Specular Multiplier Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Specular Color Multiplier", 1, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Specular Intensity Multiplier", 1, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Specular Exponent Multiplier", 1, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Noise Scale", 0.5, kScene);
    --ALIVE_AgentSetProperty(agent_name_scene, "FX Force Linear Depth Offset", 5.5, kScene);

    ALIVE_AgentSetProperty(agent_name_scene, "Frame Buffer Scale Override", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Frame Buffer Scale Factor", 1.0, kScene);


    --add additional dust motes
    local fxDust1 = AgentCreate("myFX_dust", "fx_camDustMotes.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false)
    local fxDust1_props = AgentGetRuntimeProperties(fxDust1)
    ALIVE_SetPropertyBySymbol(fxDust1_props, "689599953923669477", true) --enable emitter
    ALIVE_SetPropertyBySymbol(fxDust1_props, "4180975590232535326", 0.031) --particle size
    ALIVE_SetPropertyBySymbol(fxDust1_props, "2137029241144994061", 71.0) --particle count
    ALIVE_SetPropertyBySymbol(fxDust1_props, "907461805036530086", 0.15) --particle speed
    ALIVE_SetPropertyBySymbol(fxDust1_props, "459837671211266514", 0.0) --rain random size
    ALIVE_SetPropertyBySymbol(fxDust1_props, "2293817456966484758", 1.0) --rain diffuse intensity

    --ALIVE_PrintOutCacheObjectProperties(AgentFindInScene(agent_name_scene, kScene), "LightEnv Reflection Texture");
    --ALIVE_PrintValidPropertyNames(AgentFindInScene("obj_skyDome", kScene));
    --ALIVE_GetCacheObjectNamesFromProperties(AgentFindInScene("obj_skyDome", kScene), "cacheObjectNamesPart2Cleaned.txt");
    --ALIVE_PrintValidPropertyNames(AgentFindInScene("adv_boardingSchoolExteriorDusk_meshesATerrain", kScene));
    --ALIVE_PrintProperties(AgentFindInScene("adv_boardingSchoolExteriorDusk_meshesATerrain", kScene));
    --ALIVE_GetCacheObjectNamesFromProperties(AgentFindInScene("adv_boardingSchoolExteriorDusk_meshesATerrain", kScene), "cleanedCacheObjectsList404.txt");

    --local myTexture = "color_fff.d3dtx"; --white
    --local myTexture = "color_fff0000.d3dtx"; --red
    --local myTexture = "color_818181.d3dtx"; --grey
    --local myTexture = "color_666666.d3dtx"; --dark grey
    --local myTexture = "color_000.d3dtx"; --black
    local skyTex1Override = "color_fff.d3dtx"; --white
    ALIVE_AgentSetPropertyBySymbol("obj_skyDome", "1893731503509791374", skyTex1Override, kScene);
    ALIVE_AgentSetPropertyBySymbol("obj_skyDome", "8884887503322744022", skyTex1Override, kScene);
    ALIVE_AgentSetPropertyBySymbol("obj_skyDome", "10891831632055398974", skyTex1Override, kScene);
    ALIVE_AgentSetPropertyBySymbol("obj_skyDome", "14857997951386233173", skyTex1Override, kScene);
    ALIVE_AgentSetPropertyBySymbol("obj_skyDome", "17722002904829990873", skyTex1Override, kScene);

    --RenderPassDisable("");
    --RenderSetFeatureEnabled("dof", true);
    RenderSetFeatureEnabled("glow", true);
    RenderSetFeatureEnabled("motionblur", false);
    RenderSetFeatureEnabled("brush", false);
    RenderSetFeatureEnabled("lowresalpha", false);
    RenderSetFeatureEnabled("finalresolve", true);
    RenderSetFeatureEnabled("bakelit", false);
    RenderSetFeatureEnabled("nprlines", false);
    RenderSetFeatureEnabled("computecullshadows", false);
    RenderSetFeatureEnabled("depthcullshadows", false);
    RenderSetFeatureEnabled("optimizesdsm", false);
    RenderSetFeatureEnabled("bokeh", true);
    RenderSetFeatureEnabled("enlighten", false);
    RenderSetFeatureEnabled("invertz", false);
    RenderSetFeatureEnabled("occlusion", false);
    RenderSetFeatureEnabled("computelightcluster", false);
    RenderSetFeatureEnabled("lowreslight", false);
    RenderSetFeatureEnabled("lod", false);
    RenderSetFeatureEnabled("computeskinning", true);
    RenderSetFeatureEnabled("forcedepth", false);

    --RenderSetScaleForResolution(4.0);
    --RenderSetHDRColorBufferScale(5.0);
    --RenderSetScale(4.0);
    --RenderSetHDRSurfaceFormat("srgb");
    --RenderSetHDRSurfaceFormat("rgb10");
    --RenderSetHDRSurfaceFormat("rgb10f");
    RenderSetHDRSurfaceFormat("rgb16f");
    --RenderSetHDRSurfaceFormat("default");

    ALIVE_RemoveAgent("light_ENV_clemsRoomNoon_sunKey", kScene);
    ALIVE_RemoveAgent("light_ENV_clemsRoomNoon_sunHotspot", kScene);
    ALIVE_RemoveAgent("light_ENV_clemsRoomNoon_sunBounceDoor", kScene);
    ALIVE_RemoveAgent("light_ENV_clemsRoomNoon_sunBounceWindow", kScene);
    ALIVE_RemoveAgent("light_ENV_clemsRoomNoon", kScene);
    ALIVE_RemoveAgent("light_ENV_clemsRoomNoon_sunKeyNX", kScene);
    ALIVE_RemoveAgent("light_ENV_clemsRoomNoon_sunHotspotNX", kScene);
end