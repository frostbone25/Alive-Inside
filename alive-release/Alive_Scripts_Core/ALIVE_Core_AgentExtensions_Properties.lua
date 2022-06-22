--============ PROPERTIES - BOOL ============
--============ PROPERTIES - BOOL ============
--============ PROPERTIES - BOOL ============

--checks if an agent has a property by name
ALIVE_AgentHasProperty = function(agentName, propertyString, kScene)
    local agent = AgentFindInScene(agentName, kScene)
    return AgentHasProperty(agent, propertyString)
end

--============ PROPERTIES - SET ============
--============ PROPERTIES - SET ============
--============ PROPERTIES - SET ============

--sets a property by an agent object
ALIVE_PropertySet = function(agent, propertyString, propertyValue)
    local agent_props = AgentGetRuntimeProperties(agent)
    PropertySet(agent_props, propertyString, propertyValue)
end

--sets a property on an agent by name
ALIVE_AgentSetProperty = function(agentName, propertyString, propertyValue, kScene)
    local agent = AgentFindInScene(agentName, kScene)
    ALIVE_PropertySet(agent, propertyString, propertyValue)
end

--forcibly sets a property on an agent by name
ALIVE_AgentForceSetProperty = function(agentName, propertyString, propertyValueType, propertyValue, kScene)
    local agent = AgentFindInScene(agentName, kScene)
    local agent_props = AgentGetProperties(agent)
	--local agent_props = AgentGetRuntimeProperties(agent)

	if not (AgentHasProperty(agent, propertyString)) then
        PropertyCreate(agent_props, propertyString, propertyValueType, propertyValue)
	end

    PropertySet(agent_props, propertyString, propertyValue)
end

--sets a property on all agents with the given prefix in a scene
ALIVE_SetPropertyOnAgentsWithPrefix = function(kScene, prefixString, propertyString, propertyValue)
    --get all agents in the scene
    local scene_agents = SceneGetAgents(kScene)

    --fill out rig agents list
    for i, agent_object in pairs(scene_agents) do
        --get the agent name
        local agent_name = tostring(AgentGetName(agent_object))
        
        --check if the agent name contains the prefix, if it does then add it to our agent_names table
        if (string.match)(agent_name, prefixString) then
            ALIVE_AgentSetProperty(agent_name, propertyString, propertyValue, kScene)
        end
    end
end

--sets a property on all cameras in a scene
ALIVE_SetPropertyOnAllCameras = function(kScene, propertyString, propertyValue)
    --get all agents in the scene
    local scene_agents = SceneGetAgents(kScene)

    --fill out rig agents list
    for i, agent_object in pairs(scene_agents) do
        --get the agent name
        local agent_name = tostring(AgentGetName(agent_object))
        
        --check if the agent name contains the prefix, if it does then add it to our agent_names table
        if (string.match)(agent_name, "cam_") then
            ALIVE_AgentSetProperty(agent_name, propertyString, propertyValue, kScene)
        end
    end
end

ALIVE_SetTexturesOnAgentWithNamePrefix = function(agentName, texturePrefixString, newPropertyValue, cacheObjectListName, kScene)
    local agent = AgentFindInScene(agentName, kScene);
    local properties = AgentGetProperties(agent);
    local propertyKeys = PropertyGetKeys(properties);
    
    local texturePropertyKeys = {};

    for index1, key in ipairs(propertyKeys) do
        local propertyValue = PropertyGet(properties, key);

        if (propertyValue) then
            local propertyValueString = tostring(propertyValue);

            if (string.match)(propertyValueString, "Cached Object") then
                local shortenedString = propertyValueString:gsub("Cached Object: ", "");
                local shortenedString2 = shortenedString:gsub('"','');

                local readTxtFile = io.open(cacheObjectListName, "r")

                for line in readTxtFile:lines() do
                    if (string.find)(line, shortenedString2) then
                        if (string.find)(line, ".d3dtx") then
                            if (string.find)(line, texturePrefixString) then
                                table.insert(texturePropertyKeys, key);
                            end
                        end
                    end
                end

                readTxtFile:close()
            end
        end
    end

    for index2, textureKey in ipairs(texturePropertyKeys) do
        PropertySet(properties, textureKey, newPropertyValue);
    end
end

ALIVE_SetTexturesOnAgentsWithNamePrefixes = function(agentNamePrefix, texturePrefixString, newPropertyValue, cacheObjectListName, kScene)
    local scene_agents = SceneGetAgents(kScene)

    for i, agent_object in pairs(scene_agents) do
        local agent_name = tostring(AgentGetName(agent_object))

        if (string.match)(agent_name, agentNamePrefix) then
            ALIVE_SetTexturesOnAgentWithNamePrefix(agent_name, texturePrefixString, newPropertyValue, cacheObjectListName, kScene)
        end
    end
end

ALIVE_SetDiffuseTexturesOnAgentsWithNamePrefixes = function(agentNamePrefix, newPropertyValue, cacheObjectListName, kScene)
    local scene_agents = SceneGetAgents(kScene)

    for i, agent_object in pairs(scene_agents) do
        local agent_name = tostring(AgentGetName(agent_object))

        if (string.match)(agent_name, agentNamePrefix) then
            local agent = AgentFindInScene(agent_name, kScene);
            local properties = AgentGetProperties(agent);
            local propertyKeys = PropertyGetKeys(properties);
    
            local texturePropertyKeys = {};

            for index1, key in ipairs(propertyKeys) do
                local propertyValue = PropertyGet(properties, key);

                if (propertyValue) then
                    local propertyValueString = tostring(propertyValue);

                    if (string.match)(propertyValueString, "Cached Object") then
                        local shortenedString = propertyValueString:gsub("Cached Object: ", "");
                        local shortenedString2 = shortenedString:gsub('"','');

                        local readTxtFile = io.open(cacheObjectListName, "r")

                        for line in readTxtFile:lines() do
                            if (string.find)(line, shortenedString2) then
                                if (string.find)(line, ".d3dtx") then
                                    local case1 = (string.find)(line, "_detail");
                                    local case2 = (string.find)(line, "_ink");
                                    local case3 = (string.find)(line, "_nm");
                                    local case4 = (string.find)(line, "_bnm");
                                    local case5 = (string.find)(line, "_spec");
                                    local case6 = (string.find)(line, "_mask");
                                    local case7 = (string.find)(line, "_microdetail");
                                    local case8 = (string.find)(line, "_grime");
                                    local cases = (not case1) and (not case2) and (not case3) and (not case4) and (not case5) and (not case6) and (not case7) and (not case8)

                                    if cases then
                                        table.insert(texturePropertyKeys, key);
                                    end
                                end
                            end
                        end

                        readTxtFile:close()
                    end
                end
            end

            for index2, textureKey in ipairs(texturePropertyKeys) do
                PropertySet(properties, textureKey, newPropertyValue);
            end
        end
    end
end

--============ PROPERTIES - GET ============
--============ PROPERTIES - GET ============
--============ PROPERTIES - GET ============

--gets a property by an agent object
ALIVE_PropertyGet = function(agent, propertyString)
    local agent_props = AgentGetRuntimeProperties(agent)
    return PropertyGet(agent_props, propertyString)
end

--gets a property on an agent by name
ALIVE_AgentGetProperty = function(agentName, propertyString, kScene)
    local agent = AgentFindInScene(agentName, kScene)
    return ALIVE_PropertyGet(agent, propertyString)
end

--gets properties on an agent by name
ALIVE_AgentGetProperties = function(agentName, kScene)
    local agent = AgentFindInScene(agentName, kScene)
    return AgentGetProperties(agent)
end

--gets runtime properties on an agent by name
ALIVE_AgentGetRuntimeProperties = function(agentName, kScene)
    local agent = AgentFindInScene(agentName, kScene)
    return AgentGetRuntimeProperties(agent)
end