--NOTE TO SELF: AgentFindInScene calls especially in bulk can be very expensive.

--============ TRANSFORMATION - SET ============
--============ TRANSFORMATION - SET ============
--============ TRANSFORMATION - SET ============
--for moving and rotating agents

--rotates an agent by name
ALIVE_SetAgentRotation = function(agentName, rotationValue, kScene)
    local agent = AgentFindInScene(agentName, kScene)
    AgentSetRot(agent, rotationValue)
end

--positions an agent by name
ALIVE_SetAgentPosition = function(agentName, positionValue, kScene)
    local agent = AgentFindInScene(agentName, kScene)
    AgentSetPos(agent, positionValue)
end

--rotates an agent in world space by name
ALIVE_SetAgentWorldRotation = function(agentName, rotationValue, kScene)
    local agent = AgentFindInScene(agentName, kScene)
    AgentSetWorldRot(agent, rotationValue)
end

--positions an agent in world space by name
ALIVE_SetAgentWorldPosition = function(agentName, positionValue, kScene)
    local agent = AgentFindInScene(agentName, kScene)
    AgentSetWorldPos(agent, positionValue)
end

--============ TRANSFORMATION - GET ============
--============ TRANSFORMATION - GET ============
--============ TRANSFORMATION - GET ============
--for getting rotation/position of agents

--gets an agents rotation by name
ALIVE_GetAgentRotation = function(agentName, kScene)
    local agent = AgentFindInScene(agentName, kScene)
    return AgentGetRot(agent)
end

--gets an agents position by name
ALIVE_GetAgentPosition = function(agentName, kScene)
    local agent = AgentFindInScene(agentName, kScene)
    return AgentGetPos(agent)
end

--gets an agents world rotation by name
ALIVE_GetAgentWorldRotation = function(agentName, kScene)
    local agent = AgentFindInScene(agentName, kScene)
    return AgentGetWorldRot(agent)
end

--gets an agents world position by name
ALIVE_GetAgentWorldPosition = function(agentName, kScene)
    local agent = AgentFindInScene(agentName, kScene)
    return AgentGetWorldPos(agent)
end