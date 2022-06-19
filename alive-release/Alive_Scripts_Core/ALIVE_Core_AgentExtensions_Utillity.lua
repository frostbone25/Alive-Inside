--============ UTILLITY ============
--============ UTILLITY ============
--============ UTILLITY ============

--hides an agent by name
ALIVE_HideAgent = function(agentName, sceneObject)
    local agent = AgentFindInScene(agentName, sceneObject)
    AgentHide(agent)
end

--sets an agents visibility by name
ALIVE_SetAgentVisibillity = function(agentName, visibilityValue, sceneObject)
    ALIVE_AgentSetProperty(agentName, "Runtime: Visible", visibilityValue, sceneObject)
end

--sets an agents culling mode
ALIVE_SetAgentCulling = function(agentName, cullValue, sceneObject)
    ALIVE_AgentSetProperty(agentName, "Render Cull", cullValue, sceneObject)
end

--sets an agent render scale
ALIVE_SetAgentScale = function(agentName, scaleValue, sceneObject)
    ALIVE_AgentSetProperty(agentName, "Render Global Scale", scaleValue, sceneObject)
end

--sets an agent shadow casting
ALIVE_SetAgentShadowCasting = function(agentName, castsShadows, sceneObject)
    ALIVE_AgentSetProperty(agentName, "Render EnvLight Shadow Cast Enable", castsShadows, sceneObject)
    ALIVE_AgentSetProperty(agentName, "Render Shadow Force Visible", castsShadows, sceneObject)
end

--checks if an agent exists, then removes an agent by name
ALIVE_RemoveAgent = function(agentName, sceneObj)
   if AgentExists(AgentGetName(agentName)) then
       local agent = AgentFindInScene(agentName, sceneObj)
       AgentDestroy(agent)
   end
end

--removes agents in a scene with a prefix
ALIVE_RemovingAgentsWithPrefix = function(sceneObject, prefixString)
    --get all agents in the scene
    local scene_agents = SceneGetAgents(sceneObject)
    
    --initalize an empty list that will contain all the agents we found by name
    local agents_names = {}
    
    --fill out rig agents list
    for i, agent_object in pairs(scene_agents) do
        --get the agent name
        local agent_name = tostring(AgentGetName(agent_object))
        
        --check if the agent name contains the prefix, if it does then add it to our agent_names table
        if (string.match)(agent_name, prefixString) then
            table.insert(agents_names, agent_name)
        end
    end
    
    --start removing agents in the list
    for x, list_agent_name in pairs(agents_names) do
        ALIVE_RemoveAgent(list_agent_name, sceneObject)
    end
end

--removes agents in a scene with a prefix
ALIVE_ReplaceAgentsWithPrefixWithDummy = function(sceneObject, prefixString)
    --get all agents in the scene
    local scene_agents = SceneGetAgents(sceneObject)
    
    --initalize an empty list that will contain all the agents we found by name
    local agents_names = {}
    
    --fill out rig agents list
    for i, agent_object in pairs(scene_agents) do
        --get the agent name
        local agent_name = tostring(AgentGetName(agent_object))
        
        --check if the agent name contains the prefix, if it does then add it to our agent_names table
        if (string.match)(agent_name, prefixString) then
            table.insert(agents_names, agent_name)
        end
    end
    
    --start removing agents in the list
    for x, list_agent_name in pairs(agents_names) do
        ALIVE_RemoveAgent(list_agent_name, sceneObject)
        
        local dummyAgent = AgentCreate(list_agent_name, "group.prop", Vector(0,0,0), Vector(0,0,0), sceneObject, false, false)
    end
end

--using a comparison agent, returns the nearest agent of the two given
ALIVE_GetNearestAgent = function(comparisonAgent, agentOne, agentTwo)
    local distance_agentOne = AgentDistanceToAgent(comparisonAgent, agentOne); --number type
    local distance_agentTwo = AgentDistanceToAgent(comparisonAgent, agentTwo); --number type
    
    if (distance_agentOne < distance_agentTwo) then
        return agentOne;
    else
        return agentTwo;
    end
end

--using a comparison agent, returns the farthest agent of the two given
ALIVE_GetFarthestAgent = function(comparisonAgent, agentOne, agentTwo)
    local distance_agentOne = AgentDistanceToAgent(comparisonAgent, agentOne); --number type
    local distance_agentTwo = AgentDistanceToAgent(comparisonAgent, agentTwo); --number type
    
    if (distance_agentOne > distance_agentTwo) then
        return agentOne;
    else
        return agentTwo;
    end
end

--performs a raycast from a given agent, to another agent
--returns true when raycast intersects with scene geometry
--returns false when raycast doesn't intersect with geometry
ALIVE_RaycastFromAgentToAgent = function(fromAgent, toAgent)
	--calculate ray origin
	local rayOrigin = AgentGetWorldPos(fromAgent);
	
	if AgentHasNode(fromAgent, "eye_L") and AgentHasNode(fromAgent, "eye_R") then
		rayOrigin = AgentGetWorldPosBetweenNodes(fromAgent, "eye_R", "eye_L");
	else
		if AgentHasNode(fromAgent, "Head") then
			rayOrigin = AgentGetWorldPos(fromAgent, "Head");
		end
	end
	
	--calculate ray direction
	local rayDirection = AgentGetWorldPos(toAgent) - rayOrigin;
	
	if AgentHasNode(toAgent, "Root") then
		rayDirection = AgentGetWorldPos(toAgent, "Root") - rayOrigin;
    else
		if AgentHasNode(toAgent, "Head") then
			rayDirection = AgentGetWorldPos(toAgent, "Head") - rayOrigin;
		end
    end
	
	--perform a raycast
	if MathRaySceneIntersect(rayOrigin, rayDirection, AgentGetScene(fromAgent)) then
		return true;
    else
		return false;
	end
end

--plays a .chore specifically on an agent
ALIVE_ChorePlayOnAgent = function(chore, agentName, priority, bWait)
    --if a priority value is not given (nil)
    if not priority then
        priority = 100;
    end

    if bWait then --if bWait value is given
        ChorePlayAndWait(chore, priority, "default", agentName);
    else --if there is no bWait value given (nil)
        return ChorePlay(chore, priority, "default", agentName);
    end
end