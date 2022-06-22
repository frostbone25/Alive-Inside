--adds additional grass meshes to make the enviorment/ground look more pleasing and not so flat/barren/low quality
ALIVE_Scene_LevelRelight_404_ForestBarn_Teaser_AddProcedualGrass = function(kScene)
    --the amount of grass objects placed on the x and z axis (left and right, forward and back)
    local grassCountX = 40;
    local grassCountZ = 40;
    
    --the spacing between the grass objects
    local grassPlacementIncrement = 0.375;
    
    --the starting point for the grass placement
    local grassPositionStart = Vector(-(grassCountX / 2) * grassPlacementIncrement, 0.0, -(grassCountZ / 2) * grassPlacementIncrement);

    --the base name of a grass object
    local grassAgentName = "myObject_grass";

    --the prop (prefab) object file for the grass
    local grassPropFile = "obj_grassHIRiverCampWalk.prop"
    
    --and lets create a group object that we will attach all the spawned grass objects to, to make it easier to move the placement of the grass.
    local newGroup = AgentCreate("procedualGrassGroup", "group.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    
    --loop x amount of times for the x axis
    for x = 1, grassCountX, 1 do 
        --calculate our x position right now
        local newXPos = grassPositionStart.x + (x * grassPlacementIncrement);
        
        --loop z amount of times for the z axis
        for z = 1, grassCountZ, 1 do 
            --build the agent name for the current new grass object
            local xIndexString = tostring(x);
            local zIndexString = tostring(z);
            local newAgentName = grassAgentName .. "_x_" .. xIndexString .. "_z_" .. zIndexString;

            --claculate the z position
            local newZPos = grassPositionStart.z + (z * grassPlacementIncrement);
            
            --randomize the Y rotation
            local newYRot = math.random(0, 180);
            
            --randomize the scale
            local scaleOffset = math.random(0, 0.6);
            
            --combine our calculated position/rotation/scale values
            local newPosition = Vector(newXPos, grassPositionStart.y, newZPos);
            local newRotation = Vector(0, newYRot, 0);
            local newScale = 0.75 + scaleOffset;

            --instantiate the new grass object using our position/rotation
            local newGrassAgent = AgentCreate(newAgentName, grassPropFile, newPosition, newRotation, kScene, false, false);
            
            --scale the grass
            ALIVE_AgentSetProperty(newAgentName, "Render Global Scale", newScale, kScene);
                
            --attach it to the main grass group
            AgentAttach(newGrassAgent, newGroup);
        end
    end
end

--adds additional particle effects to the scene to help make it more lively
ALIVE_Scene_LevelRelight_404_ForestBarn_Teaser_AddAdditionalParticleEffects = function(kScene)
    --note: normally for modifying properties on an agent you would have the actual property name.
    --however after extracting all the strings we could get from the game exectuable, and also all of the lua scripts in the entire game
    --not every single property name was listed, and attempting to print all of the (keys) in the properties object throws out symbols instead.
    --so painfully, PAINFULLY through trial and error I found the right symbol keys I was looking for, and we basically set the given property like normal using the symbol.
    --note for telltale dev: yes I tried many times to use your dang SymbolToString on those property keys but it doesn't actually do anything!!!!!

    --create a dust particle effect that spawns dust particles where the camera looks (this effect is borrowed from S4)
    local fxDust1 = AgentCreate("myFX_dust1", "fx_camDustMotes.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    local fxDust1_props = AgentGetRuntimeProperties(fxDust1); --get the properties of the particle system, since we want to modify it.
    ALIVE_SetPropertyBySymbol(fxDust1_props, "689599953923669477", true); --enable emitter
    ALIVE_SetPropertyBySymbol(fxDust1_props, "4180975590232535326", 0.015); --particle size
    ALIVE_SetPropertyBySymbol(fxDust1_props, "2137029241144994061", 2.5); --particle count
    ALIVE_SetPropertyBySymbol(fxDust1_props, "907461805036530086", 0.55); --particle speed
    ALIVE_SetPropertyBySymbol(fxDust1_props, "459837671211266514", 0.2); --rain random size
    ALIVE_SetPropertyBySymbol(fxDust1_props, "2293817456966484758", 2.0); --rain diffuse intensity
    
    --create a leaves particle effect that spawns leaves particles where the camera looks (this effect is borrowed from S4)
    local fxLeaves1 = AgentCreate("myFX_leaves1", "fx_camLeaves.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    local fxLeaves1_props = AgentGetRuntimeProperties(fxLeaves1); --get the properties of the particle system, since we want to modify it.
    ALIVE_SetPropertyBySymbol(fxLeaves1_props, "689599953923669477", true); --enable emitter
    ALIVE_SetPropertyBySymbol(fxLeaves1_props, "4180975590232535326", 0.121); --particle size
    ALIVE_SetPropertyBySymbol(fxLeaves1_props, "2137029241144994061", 27.0); --particle count
    ALIVE_SetPropertyBySymbol(fxLeaves1_props, "907461805036530086", 1.35); --particle speed
    ALIVE_SetPropertyBySymbol(fxLeaves1_props, "459837671211266514", 0.5); --rain random size
    ALIVE_SetPropertyBySymbol(fxLeaves1_props, "2293817456966484758", 1.0); --rain diffuse intensity
end

ALIVE_Scene_LevelRelight_404_ForestBarn_Teaser = function(kScene)
    --remeber that we didn't delete every single light in the scene?
    --well now we need them because when creating new lights, by default their lighting groups (which basically mean what objects in the scene the lights will actually affect)
    --are not assigned (or at the very least, are not set to a value that affects the main lighting group of all objects in the scene)
    --and unfortunately the actual value is some kind of userdata object, so to get around that, we use an existing light as our crutch
    --and grab the actual group values/data from that object so that we can actually properly create our own lights that actually affect the scene
    
    --find the original sunlight in the scene
    local envlight  = AgentFindInScene("light_ENV_sunKey", kScene);
    local envlight_props = AgentGetRuntimeProperties(envlight);
    local envlight_groupEnabled = PropertyGet(envlight_props, "EnvLight - Enabled Group");
    local envlight_groups = PropertyGet(envlight_props, "EnvLight - Groups");
    
    --find the original sky light in the scene (note telltale dev, why do you use a light source for the skybox when you could've just had the sky be an (emmissive/unlit) shader?)
    local skyEnvlight  = AgentFindInScene("light_SKY_amb", kScene);
    local skyEnvlight_props = AgentGetRuntimeProperties(skyEnvlight);
    local skyEnvlight_groupEnabled = PropertyGet(skyEnvlight_props, "EnvLight - Enabled Group");
    local skyEnvlight_groups = PropertyGet(skyEnvlight_props, "EnvLight - Groups");
    
    local originalFogAgent  = AgentFindInScene("module_environment", kScene);
    local originalFogAgent_props = AgentGetRuntimeProperties(skyEnvlight);
    local originalFogAgent_groups = PropertyGet(skyEnvlight_props, "Env - Groups");
    
    --the main prop (like a prefab) file for a generic light
    local envlight_prop = "module_env_light.prop";
    
    --calculate some new colors
    local sunColor     = RGBColor(255, 220, 188, 255);
    local ambientColor = RGBColor(108, 150, 225, 255);
    local skyColor     = RGBColor(0, 80, 255, 255);
    local fogColor     = Desaturate_RGBColor(skyColor, 0.7);
    
    --adjust the colors a bit (yes there is a lot of tweaks... would be easier if we had a level editor... but we dont yet)
    skyColor = Desaturate_RGBColor(skyColor, 0.2);
    fogColor = Multiplier_RGBColor(fogColor, 0.8);
    fogColor = Desaturate_RGBColor(fogColor, 0.45);
    sunColor = Desaturate_RGBColor(sunColor, 0.15);
    skyColor = Desaturate_RGBColor(skyColor, 0.2);
    sunColor = Desaturate_RGBColor(sunColor, -0.99);
    ambientColor = Desaturate_RGBColor(ambientColor, 0.25);
    ambientColor = Multiplier_RGBColor(ambientColor, 1.0);
    
    --set the alpha value of the fog color to be fully opaque
    local finalFogColor = Color(fogColor.r, fogColor.g, fogColor.b, 1.0);
    
    --change the properties of the fog
    local fogName = "module_environment"
    --local myFogAgent = AgentCreate(fogName, "module_environment.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    --ALIVE_AgentSetProperty(fogName, "Env - Fog Color", finalFogColor, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Fog Color", sunColor, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Fog Start Distance", 0.25, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Fog Height", 3.45, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Fog Density", 0.00025, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Fog Max Opacity", 0.35, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Fog Enabled", true, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Enabled", true, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Enabled on High", true, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Enabled on Medium", true, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Enabled on Low", true, kScene);
    ALIVE_AgentSetProperty(fogName, "Env - Priority", 1000, kScene);
    --ALIVE_AgentSetProperty(fogName, "Env - Groups", originalFogAgent_groups, kScene);

    --create our sunlight and set the properties accordingly
    local myLight_Sun = AgentCreate("myLight_Sun", envlight_prop, Vector(0,0,0), Vector(36.666, 113.1561, 0), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Type", 2, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Intensity", 25, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Radius", 1, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Distance Falloff", 1, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Spot Angle Outer", 45, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Color", sunColor, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Shadow Type", 3, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Wrap", 0.05, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Shadow Quality", 3, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_Sun", "EnvLight - Mobility", 2, kScene);

    local myLight_SunAmb = AgentCreate("myLight_SunAmb", envlight_prop, Vector(0,0,0), Vector(36.666, 113.1561, 0), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Type", 4, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Intensity", 0.5, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Radius", 1, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Distance Falloff", 1, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Spot Angle Outer", 45, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Color", sunColor, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Shadow Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Wrap", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - Shadow Quality", 0, kScene);
    ALIVE_AgentSetProperty("myLight_SunAmb", "EnvLight - HBAO Participation Type", 1, kScene);

    --sky light/color
    ALIVE_AgentSetProperty("light_SKY_amb", "EnvLight - Intensity", 4, kScene);
    ALIVE_AgentSetProperty("light_SKY_amb", "EnvLight - Color", skyColor, kScene);
    
    --create a spotlight that emulates the sundisk in the sky
    local myLight_SkySun = AgentCreate("myLight_SkySun", envlight_prop, Vector(0,0,0), Vector(36.666 - 180, 113.1561, 0), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Intensity", 25, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Radius", 2555, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Distance Falloff", 9, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Spot Angle Outer", 65, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Color", sunColor, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Enabled Group", skyEnvlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Groups", skyEnvlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Shadow Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Wrap", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - Shadow Quality", 0, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun", "EnvLight - HBAO Participation Type", 1, kScene);
    
    local myLight_SkySun = AgentCreate("myLight_SkySun2", envlight_prop, Vector(0,0,0), Vector(36.666 - 180, 113.1561, 0), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Intensity", 85, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Radius", 2555, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Distance Falloff", 9, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Spot Angle Outer", 35, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Color", sunColor, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Enabled Group", skyEnvlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Groups", skyEnvlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Shadow Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Wrap", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - Shadow Quality", 0, kScene);
    ALIVE_AgentSetProperty("myLight_SkySun2", "EnvLight - HBAO Participation Type", 1, kScene);

    
    
    --local myLight_ajKey1 = AgentCreate("myLight_ajKey1", envlight_prop, Vector(-1.092463, 0.844435, -2.0329), Vector(18.6634, 43.12, 0), kScene, false, false);
    local myLight_ajKey1 = AgentCreate("myLight_ajKey1", envlight_prop, Vector(-1.138213, 0.928073, -1.825126), Vector(25.333347, 59.573139, 0), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Intensity", 13, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Radius", 1, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Distance Falloff", 1, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Spot Angle Outer", 75, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Color", sunColor, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Shadow Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Wrap", 0.20, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Shadow Quality", 3, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_ajKey1", "EnvLight - Mobility", 2, kScene);
    
    local myLight_ajRim1 = AgentCreate("myLight_ajRim1", envlight_prop, Vector(-0.107102, 1.102458, -1.078987), Vector(32.833637, -128.698929, 0), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Intensity", 1065, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Radius", 1, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Distance Falloff", 1, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Spot Angle Outer", 45, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Color", skyColor, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Shadow Type", 2, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Wrap", 0.20, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Shadow Quality", 3, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim1", "EnvLight - Mobility", 2, kScene);
    
    local myLight_ajRim2 = AgentCreate("myLight_ajRim2", envlight_prop, Vector(-1.2481, 0.93511, -1.359819), Vector(27.567850, 111.789520, 0), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Intensity", 95, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Radius", 1, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Distance Falloff", 1, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Spot Angle Outer", 55, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Color", sunColor, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Shadow Type", 2, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Wrap", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Shadow Quality", 3, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_ajRim2", "EnvLight - Mobility", 2, kScene);
    
    local myLight_clemRim1 = AgentCreate("myLight_clemRim1", envlight_prop, Vector(-0.643954, 0.728249, -1.893435), Vector(22.723915, 171.342987, 0), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Intensity", 45, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Radius", 5, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Distance Falloff", 1, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Spot Angle Outer", 65, kScene);
    --ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Color", sunColor, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Color", skyColor, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Shadow Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Wrap", 0.04, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Shadow Quality", 3, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_clemRim1", "EnvLight - Mobility", 2, kScene);
    
    local myLight_bgFill1 = AgentCreate("myLight_bgFill1", envlight_prop, Vector(-0.167297, 0.01, 6.068893), Vector(0, 0, 0), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Intensity", 6, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Radius", 9, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Distance Falloff", 4, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Spot Angle Outer", 65, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Color", sunColor, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Shadow Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Wrap", 1.0, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Shadow Quality", 0, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_bgFill1", "EnvLight - Mobility", 2, kScene);

    local myLight_barnZombieFill1 = AgentCreate("myLight_barnZombieFill1", envlight_prop, Vector(0.488498, 0.062159, 6.509029), Vector(-24.665478, -47.250046, 0), kScene, false, false);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Intensity", 45, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Enlighten Intensity", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Radius", 11, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Distance Falloff", 1, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Spot Angle Inner", 5, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Spot Angle Outer", 75, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Color", Color(1.0, 0.7, 0.5), kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Groups", envlight_groups, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Shadow Type", 0, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Wrap", 0.0, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Shadow Quality", 3, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - HBAO Participation Type", 1, kScene);
    ALIVE_AgentSetProperty("myLight_barnZombieFill1", "EnvLight - Mobility", 2, kScene);
    
    --local myLight_forestFill1 = AgentCreate("myLight_forestFill1", envlight_prop, Vector(-69.735634, 4.780668, -1.981040), Vector(25.57, 168, 0), kScene, false, false);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Type", 1, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Intensity", 65, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Enlighten Intensity", 0.0, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Radius", 18, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Distance Falloff", 1, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Spot Angle Inner", 5, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Spot Angle Outer", 85, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Color", Color(1.0, 0.7, 0.5), kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Groups", envlight_groups, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Shadow Type", 0, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Wrap", 0.0, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Shadow Quality", 3, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - HBAO Participation Type", 1, kScene);
    --ALIVE_AgentSetProperty("myLight_forestFill1", "EnvLight - Mobility", 2, kScene);
    
    
    
    local beamColor = RGBColor(255, 167, 0, 255);
    beamColor = Multiplier_RGBColor(beamColor, 2.0);
    beamColor = Desaturate_RGBColor(beamColor, 0.55);

    local myFX_lightshaft1 = AgentCreate("myALIVE_lightbeam1", "fx_lightBeamFlashlight.prop", Vector(-30.818979, 17.7374, 17.254467), Vector(59.043056, 117.22493, 0), kScene, false, false)
    local myFX_lightshaft1_props = AgentGetRuntimeProperties(myFX_lightshaft1)
    ALIVE_SetPropertyBySymbol(myFX_lightshaft1_props, "2911356150214956261", beamColor) --flashlight flare
    ALIVE_SetPropertyBySymbol(myFX_lightshaft1_props, "13322114906091202280", beamColor) --flashlight beam
    ALIVE_AgentSetProperty("myALIVE_lightbeam1", "Render Global Scale", 2.5, kScene)
    ALIVE_AgentSetProperty("myALIVE_lightbeam1", "Render Cull", false, kScene)
    --ALIVE_AgentSetProperty("myALIVE_lightbeam1", "Render After Anti-Aliasing", true, sceneObj)
    --ALIVE_AgentSetProperty("myALIVE_lightbeam1", "Render Layer", 1, sceneObj)
    --ALIVE_AgentSetProperty("myALIVE_lightbeam1", "Render Depth Test", false, sceneObj)
    --ALIVE_AgentSetProperty("myALIVE_lightbeam1", "Render Depth Write", false, sceneObj)
    --ALIVE_AgentSetProperty("myALIVE_lightbeam1", "Render Depth Write Alpha", false, sceneObj)
    --ALIVE_AgentSetProperty("myALIVE_lightbeam1", "Render 3D Alpha", false, sceneObj)
    ALIVE_AgentSetProperty("myALIVE_lightbeam1", "Render Force As Alpha", false, kScene)
    
    beamColor = Multiplier_RGBColor(beamColor, 0.35);
    local myFX_lightshaft2 = AgentCreate("myFX_lightshaft2", "fx_lightBeamFlashlight.prop", Vector(-0.706046, 3.453351, 3.873892), Vector(38.166641, -128.906036, 0), kScene, false, false)
    local myFX_lightshaft2_props = AgentGetRuntimeProperties(myFX_lightshaft2)
    ALIVE_SetPropertyBySymbol(myFX_lightshaft2_props, "2911356150214956261", beamColor) --flashlight flare
    ALIVE_SetPropertyBySymbol(myFX_lightshaft2_props, "13322114906091202280", beamColor) --flashlight beam
    ALIVE_AgentSetProperty("myFX_lightshaft2", "Render Global Scale", 0.5, kScene)
    ALIVE_AgentSetProperty("myFX_lightshaft2", "Render Cull", false, kScene)
    --ALIVE_AgentSetProperty("myFX_lightshaft2", "Render After Anti-Aliasing", true, sceneObj)
    --ALIVE_AgentSetProperty("myFX_lightshaft2", "Render Layer", 1, sceneObj)
    --ALIVE_AgentSetProperty("myFX_lightshaft2", "Render Depth Test", false, sceneObj)
    --ALIVE_AgentSetProperty("myFX_lightshaft2", "Render Depth Write", false, sceneObj)
    --ALIVE_AgentSetProperty("myFX_lightshaft2", "Render Depth Write Alpha", false, sceneObj)
    --ALIVE_AgentSetProperty("myFX_lightshaft2", "Render 3D Alpha", false, sceneObj)
    ALIVE_AgentSetProperty("myFX_lightshaft2", "Render Force As Alpha", false, kScene)
    
    local beamColor3 = RGBColor(255, 167, 0, 255);
    beamColor3 = Multiplier_RGBColor(beamColor3, 2.0);
    beamColor3 = Desaturate_RGBColor(beamColor3, 0.45);
    
    beamColor = Multiplier_RGBColor(beamColor, 4.0);
    local myFX_lightshaft3 = AgentCreate("myFX_lightshaft3", "fx_lightBeamFlashlight.prop", Vector(-100.651581, 17.00189, -2.948716), Vector(38.166687, 104.907486, 0), kScene, false, false)
    local myFX_lightshaft3_props = AgentGetRuntimeProperties(myFX_lightshaft3)
    ALIVE_SetPropertyBySymbol(myFX_lightshaft3_props, "2911356150214956261", beamColor3) --flashlight flare
    ALIVE_SetPropertyBySymbol(myFX_lightshaft3_props, "13322114906091202280", beamColor3) --flashlight beam
    ALIVE_AgentSetProperty("myFX_lightshaft3", "Render Global Scale", 5.5, kScene)
    ALIVE_AgentSetProperty("myFX_lightshaft3", "Render Cull", false, kScene)
    --ALIVE_AgentSetProperty("myFX_lightshaft3", "Render After Anti-Aliasing", true, sceneObj)
    --ALIVE_AgentSetProperty("myFX_lightshaft3", "Render Layer", 1, sceneObj)
    --ALIVE_AgentSetProperty("myFX_lightshaft3", "Render Depth Test", false, sceneObj)
    --ALIVE_AgentSetProperty("myFX_lightshaft3", "Render Depth Write", false, sceneObj)
    --ALIVE_AgentSetProperty("myFX_lightshaft3", "Render Depth Write Alpha", false, sceneObj)
    --ALIVE_AgentSetProperty("myFX_lightshaft3", "Render 3D Alpha", false, sceneObj)
    ALIVE_AgentSetProperty("myFX_lightshaft3", "Render Force As Alpha", false, kScene)


    --remove original sun since we created our own and only needed it for getting the correct lighting groups.
    ALIVE_RemoveAgent("light_ENV_sunKey", kScene);
    --ALIVE_RemoveAgent("module_environment", kScene);


    --modify the scene post processing
    ALIVE_AgentSetProperty(agent_name_scene, "FX anti-aliasing", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Sharp Shadows Enabled", true, kScene);
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
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Radius", 0.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Max Radius Percent", 0.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Max Distance", 35.5, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Distance Falloff", 0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "HBAO Hemisphere Bias", -0.2, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Bloom Threshold", -0.45, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Bloom Intensity", 0.45, kScene);
    --ALIVE_AgentSetProperty(agent_name_scene, "Ambient Color", RGBColor(0, 0, 0, 0), kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Ambient Color", ambientColor, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Shadow Color", RGBColor(0, 0, 0, 0), kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Tint Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Tint", RGBColor(0, 0, 0, 255), kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Falloff", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Center", 0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Vignette Corners", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Saturation", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Reflection Intensity Shadow", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Reflection Intensity", 1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Max Distance", 20.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Dynamic Shadow Max Distance", 25.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Position Offset Bias", 0.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Depth Bias", -1.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Auto Depth Bounds", false, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Light Bleed Reduction", 0.8, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "LightEnv Shadow Moment Bias", 0.0, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Specular Multiplier Enabled", true, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Specular Color Multiplier", 55, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Specular Intensity Multiplier", 1, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "Specular Exponent Multiplier", 1, kScene);
    ALIVE_AgentSetProperty(agent_name_scene, "FX Noise Scale", 1, kScene);
end