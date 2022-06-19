ALIVE_Clamp = function(a, minimum, maximum)
    if (a > maximum) then
        return maximum;
    elseif (a < minimum) then
        return minimum;
    else
        return a;
    end
end

ALIVE_Repeat = function(t, length)
    return ALIVE_Clamp(t - math.floor(t / length) * length, 0.0, length);
end

ALIVE_PingPong = function(t, length)
    t = ALIVE_Repeat(t, length * 2);
    return length - math.abs(t - length);
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

ALIVE_ColorLerp = function(colorA, colorB, t)
    local newColorR = ALIVE_NumberLerp(colorA.r, colorB.r, t);
    local newColorG = ALIVE_NumberLerp(colorA.g, colorB.g, t);
    local newColorB = ALIVE_NumberLerp(colorA.b, colorB.b, t);
    local newColorA = ALIVE_NumberLerp(colorA.a, colorB.a, t);

    return Color(newColorR, newColorG, newColorB, newColorA);
end

ALIVE_RandomFloatValue = function(min, max, decimals)
    local value = math.random(min * decimals, max * decimals);
    local valueAdjusted = value / decimals;

    return valueAdjusted;
end