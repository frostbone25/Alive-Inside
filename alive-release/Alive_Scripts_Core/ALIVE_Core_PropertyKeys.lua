--||||||||||||||||||||| PROPERTY KEY FUNCTIONS |||||||||||||||||||||
--||||||||||||||||||||| PROPERTY KEY FUNCTIONS |||||||||||||||||||||
--||||||||||||||||||||| PROPERTY KEY FUNCTIONS |||||||||||||||||||||
--Note: these were before we even knew most of the actual property names within objects.
--I've since compiled a txt document full of all of these prop names which can be extracted from the game exe.
--However, this is still in use because there are still alot of property names that are hashed.
--This still works, but you have to know the property by its symbol.
--I have a tool that one can use to identify and mess around with properties by symbol, but its not included here in the relight mod

--gets and sets a property value using a symbol key string
ALIVE_SetPropertyBySymbol = function(properties, symbolString, newValue)
    --check if the properties isn't null
    if properties then
        --get the property keys list
        local agent_property_keys = PropertyGetKeys(properties);
        
        --loop through each property key in the list
        for i, agent_property_key in ipairs(agent_property_keys) do
            --get the property key as a string
            local agent_propety_key_string = ALIVE_KeyToString(agent_property_key);
            
            --check if the property key string matches the user's symbol string
            if agent_propety_key_string == symbolString then
                --we have a match! so set the property with the new value
                PropertySet(properties, agent_property_key, newValue);
            end
        end
    end
end

ALIVE_AgentSetPropertyBySymbol = function(agentName, symbolString, newValue, sceneObj)
    local agent = AgentFindInScene(agentName, sceneObj);
    local properties = AgentGetProperties(agent);

    if properties then
        local agent_property_keys = PropertyGetKeys(properties);

        for i, agent_property_key in ipairs(agent_property_keys) do
            local agent_propety_key_string = ALIVE_KeyToString(agent_property_key);

            if agent_propety_key_string == symbolString then
                PropertySet(properties, agent_property_key, newValue);
            end
        end
    end
end

--newValue = Color(1.0, 1.0, 1.0, 1.0) [r, g, b, a]
--gets and sets a property color value table using a symbol key string
ALIVE_SetPropertyColorBySymbol = function(properties, symbolString, newValue)
    --check if the properties isn't null
    if properties then
        --get the property keys list
        local agent_property_keys = PropertyGetKeys(properties);

        --loop through each property key in the list
        for i, agent_property_key in ipairs(agent_property_keys) do
            --get the property key as a string
            local agent_propety_key_string = ALIVE_KeyToString(agent_property_key);

            --check if the property key string matches the user's symbol string
            if agent_propety_key_string == symbolString then
                
                --get the name type of the property value
                local agent_property_value_type = TypeName(PropertyGet(properties, agent_property_key));
                --throw the name type under another string conversion
                local agent_property_key_type_string = ALIVE_KeyToString(agent_property_value_type);
                
                --check if the key type is a table
                if agent_property_key_type_string == "table" then
                    --we have a match! so set the property with the new color value
                    PropertySet(properties, agent_property_key, newValue);
                end
            end
        end
    end
end