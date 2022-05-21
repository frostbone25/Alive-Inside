--||||||||||||||||||||| CUSTOM UTILITIES |||||||||||||||||||||
--||||||||||||||||||||| CUSTOM UTILITIES |||||||||||||||||||||
--||||||||||||||||||||| CUSTOM UTILITIES |||||||||||||||||||||

ALIVE_Clamp = function(a, minimum, maximum)
	if (a > maximum) then
		return maximum;
	elseif (a < minimum) then
		return minimum;
	else
		return a;
	end
end

ALIVE_NumberLerp = function(a, b, t)
    return a + (b - a) * t;
end

ALIVE_Smoothstep = function(a, b, t)
	return a + (b - a) * ( (-2 * math.pow(t, 3)) + (3 * math.pow(t, 2)) );
end

ALIVE_VectorLerp = function(a, b, t)
    local newX = ALIVE_NumberLerp(a.x, b.x, t);
    local newY = ALIVE_NumberLerp(a.y, b.y, t);
    local newZ = ALIVE_NumberLerp(a.z, b.z, t);
    
    return Vector(newX, newY, newZ);
end

ALIVE_VectorSmoothstep = function(a, b, t)
    local newX = ALIVE_Smoothstep(a.x, b.x, t);
    local newY = ALIVE_Smoothstep(a.y, b.y, t);
    local newZ = ALIVE_Smoothstep(a.z, b.z, t);
    
    return Vector(newX, newY, newZ);
end

ColorLerp = function(colorA, colorB, t)
    local newColorR = ALIVE_NumberLerp(colorA.r, colorB.r, t);
    local newColorG = ALIVE_NumberLerp(colorA.g, colorB.g, t);
    local newColorB = ALIVE_NumberLerp(colorA.b, colorB.b, t);
    local newColorA = ALIVE_NumberLerp(colorA.a, colorB.a, t);

    return Color(newColorR, newColorG, newColorB, newColorA);
end

ALIVE_GetTableType = function(tableValue)
	local stringType = "table";
	
	local colorMatch = 0;
	
	for key, value in pairs(tableValue) do
		--if the key is a string type
		if (type(key) == "string") then
			--check if the key name matches the variables of the color type
			if (key == "r") or (key == "g") or (key == "b") or (key == "a") then
				colorMatch = colorMatch + 1
			end
		end
    end
	
	--if the color is a full match then this table is infact a color
	if (colorMatch == 4) then
		stringType = "color";
	end
	
	return stringType;
end