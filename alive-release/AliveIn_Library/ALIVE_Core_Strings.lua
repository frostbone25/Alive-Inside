--|||||||||||||||||||||||||||||||||||||||||||||| TYPES TO STRING ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| TYPES TO STRING ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| TYPES TO STRING ||||||||||||||||||||||||||||||||||||||||||||||

ALIVE_TablePrint = function(tbl, indent)
    if not indent then 
        indent = 0;
    end
  
    local toprint = string.rep(" ", indent) .. "{\r\n";
    
    indent = indent + 2;
    
    for k, v in pairs(tbl) do
        toprint = toprint .. string.rep(" ", indent);
        
        --print key
        if (type(k) == "number") then
            toprint = toprint .. "[" .. k .. "] = ";
        elseif (type(k) == "string") then
            toprint = toprint  .. k ..  " = "   ;
        end
        
        --print value
        if (type(v) == "number") then
            toprint = toprint .. v .. ",\r\n";
        elseif (type(v) == "string") then
            toprint = toprint .. "\"" .. v .. "\",\r\n";
        elseif (type(v) == "table") then
            toprint = toprint .. ALIVE_TablePrint(v, indent + 2) .. ",\r\n";
        else
            toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n";
        end
    end
    
    toprint = toprint .. string.rep(" ", indent - 2) .. "}";
    
    return toprint;
end

ALIVE_VectorToString = function(vectorValue)
    local stringValue = "";
    
    local xValue = string.format("%.6f", vectorValue.x);
    local yValue = string.format("%.6f", vectorValue.y);
    local zValue = string.format("%.6f", vectorValue.z);

    stringValue = stringValue .. "x: " .. xValue;
    stringValue = stringValue .. " y: " .. yValue;
    stringValue = stringValue .. " z: " .. zValue;
    
    return stringValue;
end

ALIVE_ColorToString = function(colorValue)
    local stringValue = "";
    
    local rValue = string.format("%.6f", colorValue.r);
    local gValue = string.format("%.6f", colorValue.g);
    local bValue = string.format("%.6f", colorValue.b);
    local aValue = string.format("%.6f", colorValue.a);
    
    stringValue = stringValue .. "r: " .. rValue;
    stringValue = stringValue .. " g: " .. gValue;
    stringValue = stringValue .. " b: " .. bValue;
    stringValue = stringValue .. " a: " .. aValue;
    
    return stringValue;
end

ALIVE_ColorToRGBColorToString = function(colorValue)
    local stringValue = "";
    
    local scalar = 255
    local rValue = string.format("%.0f", colorValue.r * scalar);
    local gValue = string.format("%.0f", colorValue.g * scalar);
    local bValue = string.format("%.0f", colorValue.b * scalar);
    local aValue = string.format("%.0f", colorValue.a * scalar);
    
    stringValue = stringValue .. "r: " .. rValue;
    stringValue = stringValue .. " g: " .. gValue;
    stringValue = stringValue .. " b: " .. bValue;
    stringValue = stringValue .. " a: " .. aValue;
    
    return stringValue;
end

ALIVE_Enum_TonemapType_ToString = function(valueType)
    local stringValue = "";

    if (valueType == 1) then
        stringValue = stringValue .. "eTonemapType_Default";
    elseif (valueType == 2) then
        stringValue = stringValue .. "eTonemapType_Filmic";
    end

    stringValue = stringValue .. " ( " .. tostring(valueType) .. " )";
    
    return stringValue;
end

ALIVE_Enum_T3LightEnvType_ToString = function(valueType)
    local stringValue = "";

    if (valueType == 0) then
        stringValue = stringValue .. "eLightEnvType_Point";
    elseif (valueType == 1) then
        stringValue = stringValue .. "eLightEnvType_Spot";
    elseif (valueType == 2) then
        stringValue = stringValue .. "eLightEnvType_DirectionalKey";
    elseif (valueType == 3) then
        stringValue = stringValue .. "eLightEnvType_Ambient";
    elseif (valueType == 4) then
        stringValue = stringValue .. "eLightEnvType_DirectionalAmbient";
    end

    stringValue = stringValue .. " ( " .. tostring(valueType) .. " )";
    
    return stringValue;
end

ALIVE_Enum_T3LightEnvShadowType_ToString = function(valueType)
    local stringValue = "";

    if (valueType == 0) then
        stringValue = stringValue .. "eLightEnvShadowType_None";
    elseif (valueType == 1) then
        stringValue = stringValue .. "eLightEnvShadowType_Static_Depreceated";
    elseif (valueType == 2) then
        stringValue = stringValue .. "eLightEnvShadowType_PerLight";
    elseif (valueType == 3) then
        stringValue = stringValue .. "eLightEnvShadowType_Modulated";
    end

    stringValue = stringValue .. " ( " .. tostring(valueType) .. " )";
    
    return stringValue;
end

ALIVE_Enum_T3LightEnvShadowQuality_ToString = function(valueType)
    local stringValue = "";

    if (valueType == 0) then
        stringValue = stringValue .. "eLightEnvShadowQuality_Low";
    elseif (valueType == 1) then
        stringValue = stringValue .. "eLightEnvShadowQuality_Medium";
    elseif (valueType == 2) then
        stringValue = stringValue .. "eLightEnvShadowQuality_High";
    elseif (valueType == 3) then
        stringValue = stringValue .. "eLightEnvShadowQuality_MAX";
    end

    stringValue = stringValue .. " ( " .. tostring(valueType) .. " )";
    
    return stringValue;
end

ALIVE_Enum_T3LightEnvLODBehavior_ToString = function(valueType)
    local stringValue = "";

    if (valueType == 0) then
        stringValue = stringValue .. "eLightEnvLOD_Disable";
    elseif (valueType == 1) then
        stringValue = stringValue .. "eLightEnvLOD_BakeOnly";
    end

    stringValue = stringValue .. " ( " .. tostring(valueType) .. " )";
    
    return stringValue;
end

ALIVE_Enum_HBAOParticipationType_ToString = function(valueType)
    local stringValue = "";

    if (valueType == 0) then
        stringValue = stringValue .. "eHBAOParticipationTypeAuto";
    elseif (valueType == 1) then
        stringValue = stringValue .. "eHBAOParticipationTypeForceOn";
    elseif (valueType == 2) then
        stringValue = stringValue .. "eHBAOParticipationTypeForceOff";
    end

    stringValue = stringValue .. " ( " .. tostring(valueType) .. " )";
    
    return stringValue;
end

ALIVE_Enum_T3LightEnvEnlightenBakeBehavior_ToString = function(valueType)
    local stringValue = "";

    if (valueType == 0) then
        stringValue = stringValue .. "eLightEnvEnlightenBake_Auto";
    elseif (valueType == 1) then
        stringValue = stringValue .. "eLightEnvEnlightenBake_Enable";
    elseif (valueType == 2) then
        stringValue = stringValue .. "eLightEnvEnlightenBake_Disable";
    end

    stringValue = stringValue .. " ( " .. tostring(valueType) .. " )";
    
    return stringValue;
end

ALIVE_Enum_T3LightEnvMobility_ToString = function(valueType)
    local stringValue = "";

    if (valueType == 0) then
        stringValue = stringValue .. "eLightEnvMobility_Static";
    elseif (valueType == 1) then
        stringValue = stringValue .. "eLightEnvMobility_Stationary";
    elseif (valueType == 2) then
        stringValue = stringValue .. "eLightEnvMobility_Moveable";
    elseif (valueType == 3) then
        stringValue = stringValue .. "eLightEnvMobility_Count";
    end

    stringValue = stringValue .. " ( " .. tostring(valueType) .. " )";
    
    return stringValue;
end

ALIVE_Enum_T3LightEnvGroup_ToString = function(valueType)
    local stringValue = "";

    if (valueType == 0) then
        stringValue = stringValue .. "eLightEnvGroup_Group0";
    elseif (valueType == 1) then
        stringValue = stringValue .. "eLightEnvGroup_Group1";
    elseif (valueType == 2) then
        stringValue = stringValue .. "eLightEnvGroup_Group2";
    elseif (valueType == 3) then
        stringValue = stringValue .. "eLightEnvGroup_Group3";
    elseif (valueType == 4) then
        stringValue = stringValue .. "eLightEnvGroup_Group4";
    elseif (valueType == 5) then
        stringValue = stringValue .. "eLightEnvGroup_Group5";
    elseif (valueType == 6) then
        stringValue = stringValue .. "eLightEnvGroup_Group6";
    elseif (valueType == 7) then
        stringValue = stringValue .. "eLightEnvGroup_Group7";
    elseif (valueType == 8) then
        stringValue = stringValue .. "eLightEnvGroup_CountWithNoAmbient";
    elseif (valueType == 8) then
        stringValue = stringValue .. "eLightEnvGroup_Group8_Unused";
    elseif (valueType == 9) then
        stringValue = stringValue .. "eLightEnvGroup_Group9_Unused";
    elseif (valueType == 10) then
        stringValue = stringValue .. "eLightEnvGroup_Group10_Unused";
    elseif (valueType == 11) then
        stringValue = stringValue .. "eLightEnvGroup_Group11_Unused";
    elseif (valueType == 12) then
        stringValue = stringValue .. "eLightEnvGroup_Group12_Unused";
    elseif (valueType == 13) then
        stringValue = stringValue .. "eLightEnvGroup_Group13_Unused";
    elseif (valueType == 14) then
        stringValue = stringValue .. "eLightEnvGroup_Group14_Unused";
    elseif (valueType == 15) then
        stringValue = stringValue .. "eLightEnvGroup_Group15_Unused";
    elseif (valueType == 16) then
        stringValue = stringValue .. "eLightEnvGroup_AmbientGroup0";
    elseif (valueType == 17) then
        stringValue = stringValue .. "eLightEnvGroup_AmbientGroup1";
    elseif (valueType == 18) then
        stringValue = stringValue .. "eLightEnvGroup_AmbientGroup2";
    elseif (valueType == 19) then
        stringValue = stringValue .. "eLightEnvGroup_AmbientGroup3";
    elseif (valueType == 20) then
        stringValue = stringValue .. "eLightEnvGroup_Count";
    elseif (valueType == 4294967294) then
        stringValue = stringValue .. "eLightEnvGroup_None";
    elseif (valueType == 4294967295) then
        stringValue = stringValue .. "eLightEnvGroup_Default";
    end

    stringValue = stringValue .. " ( " .. tostring(valueType) .. " )";
    
    return stringValue;
end

--prints a number to a string
--now with the way this telltale lua is...
--some of these numbers also obviously represent enums, this function encapsulates those different enums
--if and only if the property name matches, if not then its just a regular number value
ALIVE_Number_ToString = function(propertyName, propertyValue)
    local stringValue = "";

    if (propertyName == "EnvLight - Type") then
        stringValue = stringValue .. ALIVE_Enum_T3LightEnvType_ToString(propertyValue);
    elseif (propertyName == "EnvLight - HBAO Participation Type") then
        stringValue = stringValue .. ALIVE_Enum_HBAOParticipationType_ToString(propertyValue);
    elseif (propertyName == "EnvLight - Mobility") then
        stringValue = stringValue .. ALIVE_Enum_T3LightEnvMobility_ToString(propertyValue);
    elseif (propertyName == "EnvLight - Shadow Type") then
        stringValue = stringValue .. ALIVE_Enum_T3LightEnvShadowType_ToString(propertyValue);
    elseif (propertyName == "EnvLight - Shadow Quality") then
        stringValue = stringValue .. ALIVE_Enum_T3LightEnvShadowQuality_ToString(propertyValue);
    else
        stringValue = stringValue .. tostring(propertyValue);
    end

    return stringValue;
end

ALIVE_PropertiesListToStringList = function(agentName, givenPropertyNamesList)
    local stringValueList = {};
    
    --iterate through the list of given property names
    for i, givenPropertyName in ipairs(givenPropertyNamesList) do
        --print out the property name
        local stringValue = givenPropertyName .. ": ";
    
        --get the property value and its type
        local sceneAgentPropertyValue = ALIVE_AgentGetProperty(agentName, givenPropertyName, ALIVE_RelightDev_SceneObject);
        local sceneAgentPropertyValueType = tostring(TypeName(sceneAgentPropertyValue));

        --print out the value
        if (sceneAgentPropertyValueType == "number") then
            stringValue = stringValue .. ALIVE_Number_ToString(givenPropertyName, sceneAgentPropertyValue);
        elseif (sceneAgentPropertyValueType == "table") then
            local tableType = ALIVE_GetTableType(sceneAgentPropertyValue);
        
            if (tableType == "color") then
                 stringValue = stringValue .. ALIVE_ColorToRGBColorToString(sceneAgentPropertyValue);
            else
                 stringValue = stringValue .. tableType;
            end
        elseif (sceneAgentPropertyValueType == "boolean") then
            stringValue = stringValue .. tostring(sceneAgentPropertyValue);
        else
            stringValue = stringValue .. tostring(sceneAgentPropertyValue);
        end

        --add it to the string value list
        table.insert(stringValueList, stringValue);
    end
    
    return stringValueList;
end

--gets the key and if it's a symbol it removes the symbol: tag and quotations
ALIVE_KeyToString = function(key)
    --convert the key to a string
    local keyAsString = tostring(key)
    
    --if the string contains symbol: then remove it, otherwise keep the string as is
    if (string.match)(keyAsString, "symbol: ") then
        keyAsString = (string.sub)(keyAsString, 9)
    else
        keyAsString = keyAsString
    end
    
    --remove any leftover quotations from the string
    keyAsString = keyAsString:gsub('"','')

    --return the final result
    return keyAsString
end