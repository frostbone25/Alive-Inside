ALIVE_Cutscene_HandheldCameraAnimation_CurrentPos = Vector(0, 0, 0);
ALIVE_Cutscene_HandheldCameraAnimation_CurrentRot = Vector(0, 0, 0);
ALIVE_Cutscene_HandheldCameraAnimation_TotalShakeAmount = 0.0;
ALIVE_Cutscene_HandheldCameraAnimation_TotalSpeedMultiplier = 0.0;
ALIVE_Cutscene_HandheldCameraAnimation_ShakeLevel = 4;

--proceudal handheld animation variables
local handheld_x_level1 = 0;
local handheld_x_level2 = 0;
local handheld_x_level3 = 0;
local handheld_x_level4 = 0;

local handheld_y_level1 = 0;
local handheld_y_level2 = 0;
local handheld_y_level3 = 0;
local handheld_y_level4 = 0;

local handheld_z_level1 = 0;
local handheld_z_level2 = 0;
local handheld_z_level3 = 0;
local handheld_z_level4 = 0;

--proceudal handheld animation
--worth noting that while it does work, its definetly not perfect and jumps around more than I'd like.
--if the values are kept low then it works fine
--procedual handheld camera animation (adds a bit of extra life and motion to the camera throughout the sequence)
ALIVE_Cutscene_HandheldCameraAnimation_Update = function()
    ------------------------------------------
    handheld_x_level1 = handheld_x_level1 + (GetFrameTime() * 2.0 * ALIVE_Cutscene_HandheldCameraAnimation_TotalSpeedMultiplier);
    handheld_x_level2 = handheld_x_level2 + (GetFrameTime() * 5.0 * ALIVE_Cutscene_HandheldCameraAnimation_TotalSpeedMultiplier);
    handheld_x_level3 = handheld_x_level3 + (GetFrameTime() * 3.5 * ALIVE_Cutscene_HandheldCameraAnimation_TotalSpeedMultiplier);
    handheld_x_level4 = handheld_x_level4 + (GetFrameTime() * 12.0 * ALIVE_Cutscene_HandheldCameraAnimation_TotalSpeedMultiplier);
    
    local level1_x = math.sin(handheld_x_level1) * 0.3;
    local level2_x = math.sin(handheld_x_level2) * 0.25;
    local level3_x = math.sin(handheld_x_level3) * 0.15;
    local level4_x = math.sin(handheld_x_level4) * 0.05;

    local totalX = 0;

    if (ALIVE_Cutscene_HandheldCameraAnimation_ShakeLevel == 1) then
        totalX = level1_x;
    elseif (ALIVE_Cutscene_HandheldCameraAnimation_ShakeLevel == 2) then
        totalX = level1_x - level2_x;
    elseif (ALIVE_Cutscene_HandheldCameraAnimation_ShakeLevel == 3) then
        totalX = level1_x - level2_x + level3_x;
    elseif (ALIVE_Cutscene_HandheldCameraAnimation_ShakeLevel == 4) then
        totalX = level1_x - level2_x + level3_x + level4_x;
    end

    totalX = totalX * ALIVE_Cutscene_HandheldCameraAnimation_TotalShakeAmount;

    ------------------------------------------
    handheld_y_level1 = handheld_y_level1 + (GetFrameTime() * 2.0 * ALIVE_Cutscene_HandheldCameraAnimation_TotalSpeedMultiplier);
    handheld_y_level2 = handheld_y_level2 + (GetFrameTime() * 4.5 * ALIVE_Cutscene_HandheldCameraAnimation_TotalSpeedMultiplier);
    handheld_y_level3 = handheld_y_level3 + (GetFrameTime() * 3.5 * ALIVE_Cutscene_HandheldCameraAnimation_TotalSpeedMultiplier);
    handheld_y_level4 = handheld_y_level4 + (GetFrameTime() * 12.5 * ALIVE_Cutscene_HandheldCameraAnimation_TotalSpeedMultiplier);
    
    local level1_y = math.sin(handheld_y_level1) * 0.3;
    local level2_y = math.sin(handheld_y_level2) * 0.25;
    local level3_y = math.sin(handheld_y_level3) * 0.15;
    local level4_y = math.sin(handheld_y_level4) * 0.05;

    local totalY = 0;

    if (ALIVE_Cutscene_HandheldCameraAnimation_ShakeLevel == 1) then
        totalY = level1_y;
    elseif (ALIVE_Cutscene_HandheldCameraAnimation_ShakeLevel == 2) then
        totalY = level1_y - level2_y;
    elseif (ALIVE_Cutscene_HandheldCameraAnimation_ShakeLevel == 3) then
        totalY = level1_y - level2_y + level3_y;
    elseif (ALIVE_Cutscene_HandheldCameraAnimation_ShakeLevel == 4) then
        totalY = level1_y - level2_y + level3_y + level4_y;
    end

    totalY = totalY * ALIVE_Cutscene_HandheldCameraAnimation_TotalShakeAmount;

    ------------------------------------------
    handheld_z_level1 = handheld_z_level1 + (GetFrameTime() * 1.5 * ALIVE_Cutscene_HandheldCameraAnimation_TotalSpeedMultiplier);
    handheld_z_level2 = handheld_z_level2 + (GetFrameTime() * 4.0 * ALIVE_Cutscene_HandheldCameraAnimation_TotalSpeedMultiplier);
    handheld_z_level3 = handheld_z_level3 + (GetFrameTime() * 3.5 * ALIVE_Cutscene_HandheldCameraAnimation_TotalSpeedMultiplier);
    handheld_z_level4 = handheld_z_level4 + (GetFrameTime() * 10.5 * ALIVE_Cutscene_HandheldCameraAnimation_TotalSpeedMultiplier);
    
    local level1_z = math.sin(handheld_z_level1) * 0.15;
    local level2_z = math.sin(handheld_z_level2) * 0.1;
    local level3_z = math.sin(handheld_z_level3) * 0.05;
    local level4_z = math.sin(handheld_z_level4) * 0.01;

    local totalZ = 0;

    if (ALIVE_Cutscene_HandheldCameraAnimation_ShakeLevel == 1) then
        totalZ = level1_z;
    elseif (ALIVE_Cutscene_HandheldCameraAnimation_ShakeLevel == 2) then
        totalZ = level1_z - level2_z;
    elseif (ALIVE_Cutscene_HandheldCameraAnimation_ShakeLevel == 3) then
        totalZ = level1_z - level2_z + level3_z;
    elseif (ALIVE_Cutscene_HandheldCameraAnimation_ShakeLevel == 4) then
        totalZ = level1_z - level2_z + level3_z + level4_z;
    end

    totalZ = totalZ * ALIVE_Cutscene_HandheldCameraAnimation_TotalShakeAmount;

    ------------------------------------------
    ALIVE_Cutscene_HandheldCameraAnimation_CurrentPos = Vector(totalX, totalY, totalZ);
    ALIVE_Cutscene_HandheldCameraAnimation_CurrentRot = Vector(totalX, totalY, totalZ);
end