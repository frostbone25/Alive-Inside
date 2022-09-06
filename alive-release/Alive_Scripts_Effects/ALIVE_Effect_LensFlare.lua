--[[
ALIVE_LensFlareEffect_kScene = kScene;
]]--



ALIVE_LensFlareEffect_Initalize = function()
  --local elementProp = "fx_glowWhite.prop";
  local elementProp = "fx_candleFlameNoWickWD.prop";

  local lensFlareElement1 = AgentCreate("lensFlareElement1", elementProp, Vector(0,0,0), Vector(0,0,0), ALIVE_LensFlareEffect_kScene, false, false)

  ALIVE_AgentSetProperty("lensFlareElement1", "Render Global Scale", 25.5, ALIVE_LensFlareEffect_kScene)
  ALIVE_AgentSetProperty("lensFlareElement1", "Render Cull", false, ALIVE_LensFlareEffect_kScene)
  ALIVE_AgentSetProperty("lensFlareElement1", "Render Layer", 25, ALIVE_LensFlareEffect_kScene)
  ALIVE_AgentSetProperty("lensFlareElement1", "Render Diffuse Color", Color(0,0,0,1), ALIVE_LensFlareEffect_kScene)
  ALIVE_AgentSetProperty("lensFlareElement1", "Render Constant Alpha Multiply", 1, ALIVE_LensFlareEffect_kScene)
  ALIVE_AgentSetProperty("lensFlareElement1", "Render After Anti-Aliasing", false, ALIVE_LensFlareEffect_kScene)
  ALIVE_AgentSetProperty("lensFlareElement1", "Render EnvLight Shadow Cast Enable", false, ALIVE_LensFlareEffect_kScene)
  ALIVE_AgentSetProperty("lensFlareElement1", "Motion Blur Enabled", false, ALIVE_LensFlareEffect_kScene)
  ALIVE_AgentSetProperty("lensFlareElement1", "Render Depth Test", false, ALIVE_LensFlareEffect_kScene)
  ALIVE_AgentSetProperty("lensFlareElement1", "Camera Facing", false, ALIVE_LensFlareEffect_kScene)
  ALIVE_AgentSetProperty("lensFlareElement1", "Render Static", false, ALIVE_LensFlareEffect_kScene)
  ALIVE_AgentSetProperty("lensFlareElement1", "Camera Facing Type", 0, ALIVE_LensFlareEffect_kScene)
  ALIVE_AgentSetProperty("lensFlareElement1", "Render Depth Write", false, ALIVE_LensFlareEffect_kScene)
  ALIVE_AgentSetProperty("lensFlareElement1", "Render Depth Write Alpha", false, ALIVE_LensFlareEffect_kScene)
  ALIVE_AgentSetProperty("lensFlareElement1", "Render 3D Alpha", false, ALIVE_LensFlareEffect_kScene)
  ALIVE_AgentSetProperty("lensFlareElement1", "Render Color Write", true, ALIVE_LensFlareEffect_kScene)
  ALIVE_AgentSetProperty("lensFlareElement1", "Render Force As Alpha", false, ALIVE_LensFlareEffect_kScene)
  ALIVE_AgentSetProperty("lensFlareElement1", "Render Depth Test Function", 4, ALIVE_LensFlareEffect_kScene)
  ALIVE_AgentSetProperty("lensFlareElement1", "Receive Shadows", false, ALIVE_LensFlareEffect_kScene)
  ALIVE_AgentSetProperty("lensFlareElement1", "Render FX Color Enabled", true, ALIVE_LensFlareEffect_kScene)
  ALIVE_AgentSetProperty("lensFlareElement1", "Render Shadow Force Visible", false, ALIVE_LensFlareEffect_kScene)
  ALIVE_AgentSetProperty("lensFlareElement1", "Render Enlighten Force Visible", false, ALIVE_LensFlareEffect_kScene)

  --ALIVE_AgentSetProperty("lensFlareElement1", "fx_candleFlameNoWickWD - Texture", "bokeh_circle", ALIVE_LensFlareEffect_kScene)
  ALIVE_AgentSetProperty("lensFlareElement1", "fx_candleFlameNoWickWD - Texture", "color_fFFFFF", ALIVE_LensFlareEffect_kScene)
  ALIVE_AgentSetProperty("lensFlareElement1", "fx_candleFlameNoWickWD - Light Color Diffuse", Color(0,1,0,1), ALIVE_LensFlareEffect_kScene)

  --ALIVE_PrintValidPropertyNames(AgentFindInScene("lensFlareElement1", ALIVE_LensFlareEffect_kScene));
end

ALIVE_LensFlareEffect_Update = function()
  local currentCamera_agent = SceneGetCamera(ALIVE_LensFlareEffect_kScene); --Agent type
  local currentCamera_position_vector = AgentGetWorldPos(currentCamera_agent); --Vector type
  local currentCamera_forward_vector = AgentGetForwardVec(currentCamera_agent); --Vector type
  local currentCamera_rotation_vector = AgentGetWorldRot(currentCamera_agent); --Vector type

  local lightAgent = AgentFindInScene("light_env_p_kindlingFire01", ALIVE_LensFlareEffect_kScene);
  --local lightAgent = AgentFindInScene("light_fire", ALIVE_LensFlareEffect_kScene);


  local elementAgent = AgentFindInScene("lensFlareElement1", ALIVE_LensFlareEffect_kScene);

  
end