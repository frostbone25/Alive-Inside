--[[
Developer Notes: Yes. I am very very very very very well aware that this is not an ideal implementation.
However, given the circumstances at the time of writing we have no access or no knowledge of how to extract and decompile the game shaders yet.
Trust me, if we had access I wouldn't have done it this way. 
There are alot of issues doing it this way, but I did it mostly out of experimentation.
And also the result of the experiment led to something that works roughly 60% of the time.

The issues of course is that when the camera is parallel with the light direction the "effect" can dissapear so to speak.
The reason for that being that the shadows "dissapear" because the plane does not act like a translucent object and doesn't recieve shadows on all sides.
There is also the other issue being that regular scene fog ALSO effects the result making it look very dense.
The other issue also is that every scene light affects the result as well, which in theory is actually physically correct but you don't have much artist control sadly.
]]--

--[[
ALIVE_HackyCameraVolumetrics_kScene = kScene;
ALIVE_HackyCameraVolumetrics_Settings = 
{
    Samples = 128,
    SampleOffset = 0.1,
    SampleStartOffset = 1.0,
    FogColor = Color(0.1, 0.1, 0.1, 0.1)
};
]]--

local ALIVE_HackyCameraVolumetrics_AgentParentName = "VolumetricParentGroup";
local ALIVE_HackyCameraVolumetrics_AgentParent = nil;
local ALIVE_HackyCameraVolumetrics_AgentChildName = "Volumetric_";

ALIVE_HackyCameraVolumetrics_Initalize = function()
  local elementPropFile = "fx_glowWhite.prop" -- in 201 data
  ALIVE_HackyCameraVolumetrics_AgentParent = AgentCreate(ALIVE_HackyCameraVolumetrics_AgentParentName, "group.prop", Vector(0,0,0), Vector(0,0,0), ALIVE_HackyCameraVolumetrics_kScene, false, false);

  for index = 1, ALIVE_HackyCameraVolumetrics_Settings.Samples, 1 do 

    local currentPosition = Vector(0,0,(index * ALIVE_HackyCameraVolumetrics_Settings.SampleOffset));
    local currentRotation = Vector(0,180,0);

    local currentElementAgentName = ALIVE_HackyCameraVolumetrics_AgentChildName .. tostring(index);
    local currentElementAgent = AgentCreate(currentElementAgentName, elementPropFile, currentPosition, currentRotation, ALIVE_HackyCameraVolumetrics_kScene, false, false);

    ALIVE_AgentSetProperty(currentElementAgentName, "Render Global Scale", 100.0, ALIVE_HackyCameraVolumetrics_kScene)
    ALIVE_AgentSetProperty(currentElementAgentName, "Render Cull", false, ALIVE_HackyCameraVolumetrics_kScene)
    ALIVE_AgentSetProperty(currentElementAgentName, "Render Layer", 25, ALIVE_HackyCameraVolumetrics_kScene)
    ALIVE_AgentSetProperty(currentElementAgentName, "Render Diffuse Color", ALIVE_HackyCameraVolumetrics_Settings.FogColor, ALIVE_HackyCameraVolumetrics_kScene)
    ALIVE_AgentSetProperty(currentElementAgentName, "Render Constant Alpha Multiply", 1, ALIVE_HackyCameraVolumetrics_kScene)
    ALIVE_AgentSetProperty(currentElementAgentName, "Render After Anti-Aliasing", false, ALIVE_HackyCameraVolumetrics_kScene)
    ALIVE_AgentSetProperty(currentElementAgentName, "Render EnvLight Shadow Cast Enable", false, ALIVE_HackyCameraVolumetrics_kScene)
    ALIVE_AgentSetProperty(currentElementAgentName, "Motion Blur Enabled", false, ALIVE_HackyCameraVolumetrics_kScene)
    ALIVE_AgentSetProperty(currentElementAgentName, "Render Depth Test", true, ALIVE_HackyCameraVolumetrics_kScene)
    ALIVE_AgentSetProperty(currentElementAgentName, "Camera Facing", false, ALIVE_HackyCameraVolumetrics_kScene)
    ALIVE_AgentSetProperty(currentElementAgentName, "Render Static", false, ALIVE_HackyCameraVolumetrics_kScene)
    ALIVE_AgentSetProperty(currentElementAgentName, "Camera Facing Type", 0, ALIVE_HackyCameraVolumetrics_kScene)
    ALIVE_AgentSetProperty(currentElementAgentName, "Render Depth Write", false, ALIVE_HackyCameraVolumetrics_kScene)
    ALIVE_AgentSetProperty(currentElementAgentName, "Render Depth Write Alpha", false, ALIVE_HackyCameraVolumetrics_kScene)
    ALIVE_AgentSetProperty(currentElementAgentName, "Render 3D Alpha", false, ALIVE_HackyCameraVolumetrics_kScene)
    ALIVE_AgentSetProperty(currentElementAgentName, "Render Color Write", true, ALIVE_HackyCameraVolumetrics_kScene)
    ALIVE_AgentSetProperty(currentElementAgentName, "Render Force As Alpha", false, ALIVE_HackyCameraVolumetrics_kScene)
    ALIVE_AgentSetProperty(currentElementAgentName, "Render Depth Test Function", 4, ALIVE_HackyCameraVolumetrics_kScene)
    ALIVE_AgentSetProperty(currentElementAgentName, "Receive Shadows", true, ALIVE_HackyCameraVolumetrics_kScene)
    ALIVE_AgentSetProperty(currentElementAgentName, "Render FX Color Enabled", true, ALIVE_HackyCameraVolumetrics_kScene)
    ALIVE_AgentSetProperty(currentElementAgentName, "Render Shadow Force Visible", false, ALIVE_HackyCameraVolumetrics_kScene)
    ALIVE_AgentSetProperty(currentElementAgentName, "Render Enlighten Force Visible", false, ALIVE_HackyCameraVolumetrics_kScene)

    ALIVE_AgentSetProperty(currentElementAgentName, "fx_glowWhite - Texture", "color_fFFFFF", ALIVE_HackyCameraVolumetrics_kScene)
    ALIVE_AgentSetProperty(currentElementAgentName, "fx_glowWhite - Light Color Diffuse", ALIVE_HackyCameraVolumetrics_Settings.FogColor, ALIVE_HackyCameraVolumetrics_kScene)

    AgentAttach(currentElementAgent, ALIVE_HackyCameraVolumetrics_AgentParent);
  end
end

ALIVE_HackyCameraVolumetrics_Update = function()
  local currentCamera_agent = SceneGetCamera(ALIVE_HackyCameraVolumetrics_kScene); --Agent type
  local currentCamera_position_vector = AgentGetWorldPos(currentCamera_agent); --Vector type
  local currentCamera_forward_vector = AgentGetForwardVec(currentCamera_agent); --Vector type
  local currentCamera_rotation_vector = AgentGetWorldRot(currentCamera_agent); --Vector type

  local parentRotation = Vector(currentCamera_rotation_vector.x, currentCamera_rotation_vector.y, currentCamera_rotation_vector.z);
  local parentPosition = currentCamera_position_vector + (currentCamera_forward_vector * ALIVE_HackyCameraVolumetrics_Settings.SampleStartOffset);

  AgentSetWorldPos(ALIVE_HackyCameraVolumetrics_AgentParent, parentPosition);
  AgentSetWorldRot(ALIVE_HackyCameraVolumetrics_AgentParent, parentRotation);
end