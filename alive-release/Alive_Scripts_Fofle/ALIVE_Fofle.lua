print("Fofle - Load")
if not ALIVE_FileUtils_IsCurrentlyInitialized then
    print("Fofle - Init FileUtils")
    ALIVE_Core_FileUtils_Init();
end

if (FOFLE_SceneID == nil) then
    print("Fofle - Fatal Error, Scene ID is nil")
    Fofle_DialogBoxOkay("Please check your mod's " .. kScene .. " lua file and ensure FOFLE_SceneID is set. If you're not the author of this mod, report this bug.", "Scene ID is nil!")
    SubProject_Switch("Menu", "Menu_Main.lua")
    return
end

print("Fofle - Get Scene Info")
local sceneInfo = ALIVE_Core_FileUtils_DecodeJSONFile(ALIVE_FileUitls_SubDirectory .. "Data\\fofle_" .. FOFLE_SceneID .. ".json")

print("Fofle - Is Scene Supported Check")
if not (Fofle_IsSceneVersionSupported(sceneInfo.fofle.version)) then
    print("Fofle - Fatal Error, Scene NOT Supported")
    Fofle_DialogBoxOkay("This scene is too new for your version of Fofle! Please update the mod.", "Scene Version Not Supported")
    SubProject_Switch("Menu", "Menu_Main.lua")
    return
end

print("Fofle - Succesfully Initialized.")

--[[
Development Tools
]]--

if (sceneInfo.fofle.version >= 110) then
    print("Fofle 110 - Development Toolkit")

    if (sceneInfo.debug.useFreecamTools) then
        --Initialize tools
        ALIVE_Development_CreateFreeCamera();
        ALIVE_Development_InitalizeCutsceneTools();
        
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateFreeCamera);
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Input);
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Main);
    end

    if(sceneInfo.debug.showPerformanceMetrics) then
        ALIVE_Development_PerformanceMetrics_Initalize();
        Callback_OnPostUpdate:Add(ALIVE_Development_PerformanceMetrics_Update);
    end
end

--[[
Agent Modification
]]--

print("Fofle - Agent Modification")

if not (sceneInfo.agents.add == nil) then --If file contains agents to add, iterate through the array and add them.
    for k,v in ipairs(sceneInfo.agents.add) do
        print("Fofle - Creating Agent - " .. v.name)
        AgentCreate(v.name, v.propName, Vector(v.position[1], v.position[2], v.position[3]), Vector(v.rotation[1], v.rotation[2], v.rotation[3]), v.sceneObject, v.transient, v.hidden)
    end
end

if not (sceneInfo.agents.remove == nil) then --If file contains agents to be removed, iterate through the array and remove them.
    for k,v in ipairs(sceneInfo.agents.remove) do
       AgentHide(v, true)
       AgentDetach(v)
    end
end

--[[
Callbacks
]]--

print("Fofle - Callbacks")


--[[
Additional Lua
]]--

print("Fofle - Additional Lua")

if sceneInfo.fofle.useAdditionalLua then --If file contains additional lua files, iterate through the array and run them.
    for k,v in ipairs(sceneInfo.fofle.additionalLuaFiles) do
        dofile(v)
    end
end

print("Fofle - Complete")