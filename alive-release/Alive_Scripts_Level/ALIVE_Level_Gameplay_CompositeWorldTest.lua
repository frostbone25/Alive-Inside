require("ALIVE_Core_Math.lua");
require("ALIVE_Core_Utilities.lua");
require("ALIVE_Core_AgentExtensions_Properties.lua");
require("ALIVE_Core_AgentExtensions_Transform.lua");
require("ALIVE_Core_AgentExtensions_Utillity.lua");
require("ALIVE_Core_Color.lua");
require("ALIVE_Core_Strings.lua");
require("ALIVE_Core_Printing.lua");
require("ALIVE_Core_PropertyKeys.lua");
require("ALIVE_Development_Freecam.lua");
require("ALIVE_Development_AgentBrowser.lua");
require("ALIVE_Gameplay_Shared.lua");
require("ALIVE_Gameplay_Player_ThirdPerson_Base.lua");
require("ALIVE_Gameplay_AI_Zombies.lua");
require("ALIVE_Scene_LevelCleanup_403_BoardingSchoolExterior_CompositeWorldTest.lua");
--require("ALIVE_Scene_LevelRelight_403_BoardingSchoolExterior.lua");
require("ALIVE_Character_AJ.lua");
require("ALIVE_Character_Clementine.lua");
require("ALIVE_Core_Project.lua");

--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||

--main level variables
local kScript = "ALIVE_Level_Gameplay_CompositeWorldTest";
local kScene = "adv_boardingSchoolExterior"; --401/402/403/404
local agent_name_scene = "adv_boardingSchoolExterior.scene";  --401/402/403/404
--local kScene = "adv_boardingSchoolExteriorGate"; --401/402/404
--local agent_name_scene = "adv_boardingSchoolExteriorGate.scene"; --401/402/404
--local kScene = "adv_bellTower"; --402
--local agent_name_scene = "adv_bellTower.scene";  --402
--local kScene = "adv_dormRoom"; --402
--local agent_name_scene = "adv_dormRoom.scene";  --402
--local kScene = "adv_boardingSchoolInterior"; --401/402/403
--local agent_name_scene = "adv_boardingSchoolInterior.scene";  --401/402/403
--local kScene = "adv_boardingSchoolBasement"; --401/403
--local agent_name_scene = "adv_boardingSchoolBasement.scene";  --401/403
--local kScene = "adv_boardingSchoolDorm"; --401/402/403/404
--local agent_name_scene = "adv_boardingSchoolDorm.scene"; --401/402/403/404
--local kScene = "adv_roadTile"; --401
--local agent_name_scene = "adv_roadTile.scene"; --401

ThirdPerson_kScene = kScene;
ZombieAI_kScene = kScene;

ALIVE_Development_SceneObject = kScene;
ALIVE_Development_SceneObjectAgentName = agent_name_scene;
ALIVE_Development_UseSeasonOneAPI = false;
ALIVE_Development_FreecamUseFOVScale = false;

local EnableFreecam = true;

--|||||||||||||||||||||||||||||||||||||||||||||| SCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||

ResourceSetEnable("UISeason4");
ResourceSetEnable("ProjectSeason4");
ResourceSetEnable("WalkingDead401", 950);
ResourceSetEnable("WalkingDead402");
ResourceSetEnable("WalkingDead403");
ResourceSetEnable("WalkingDead404");

ALIVE_Level_Gameplay_SpawnBellTower402 = function()
    local advBellTower402_position = Vector(-25, 0, -20);
    local advBellTower402_rotation = Vector(0, -90, 0);

    local advBellTower402_1 = AgentCreate("adv_bellTower402_1", "adv_bellSectionBellTower.prop", advBellTower402_position, advBellTower402_rotation, kScene, false, false);
    local advBellTower402_2 = AgentCreate("adv_bellTower402_2", "adv_churchBellTower.prop", advBellTower402_position, advBellTower402_rotation, kScene, false, false);
    local advBellTower402_3 = AgentCreate("adv_bellTower402_3", "adv_towerBellTower.prop", advBellTower402_position, advBellTower402_rotation, kScene, false, false);
    local advBellTower402_4 = AgentCreate("adv_bellTower402_4", "adv_towerInteriorBellTower.prop", advBellTower402_position, advBellTower402_rotation, kScene, false, false);
    --local advBellTower402_5 = AgentCreate("adv_bellTower402_5", "adv_groundBellTower.prop", advBellTower402_position, advBellTower402_rotation, kScene, false, false);
    local advBellTower402_6 = AgentCreate("adv_bellTower402_6", "adv_bellTower_foliageGround.prop", advBellTower402_position, advBellTower402_rotation, kScene, false, false);
    local advBellTower402_7 = AgentCreate("adv_bellTower402_7", "adv_bellTower_foliageRoof.prop", advBellTower402_position, advBellTower402_rotation, kScene, false, false);
    local advBellTower402_8 = AgentCreate("adv_bellTower402_8", "adv_belltower_bell.prop", advBellTower402_position, advBellTower402_rotation, kScene, false, false);
    local advBellTower402_9 = AgentCreate("adv_bellTower402_9", "adv_towerInteriorBBellTower.prop", advBellTower402_position, advBellTower402_rotation, kScene, false, false);
    local advBellTower402_10 = AgentCreate("adv_bellTower402_10", "adv_bellTower_treesA.prop", advBellTower402_position, advBellTower402_rotation, kScene, false, false);
    local advBellTower402_11 = AgentCreate("adv_bellTower402_11", "adv_bellTower_treesB.prop", advBellTower402_position, advBellTower402_rotation, kScene, false, false);

    --[[
    local advBellTower402_Group = AgentCreate("adv_bellTower402_Group", "group.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);

    AgentSetWorldPos(advBellTower402_1, advBellTower402_position);
    AgentSetWorldPos(advBellTower402_2, advBellTower402_position);
    AgentSetWorldPos(advBellTower402_3, advBellTower402_position);
    AgentSetWorldPos(advBellTower402_4, advBellTower402_position);
    AgentSetWorldPos(advBellTower402_5, advBellTower402_position);
    AgentSetWorldPos(advBellTower402_6, advBellTower402_position);
    AgentSetWorldPos(advBellTower402_7, advBellTower402_position);
    AgentSetWorldPos(advBellTower402_8, advBellTower402_position);
    AgentSetWorldPos(advBellTower402_9, advBellTower402_position);
    AgentSetWorldPos(advBellTower402_10, advBellTower402_position);
    AgentSetWorldPos(advBellTower402_11, advBellTower402_position);

    ]]--
end

ALIVE_Level_Gameplay_SpawnExteriorGate = function()
    local advExteriorGate_position = Vector(0, -0.001, 56.40);
    local advExteriorGate_rotation = Vector(0, 0, 0);

    local advExteriorGate_1 = AgentCreate("advExteriorGate_1", "adv_boardingSchoolExteriorGate_meshesATerrain.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    --local advExteriorGate_2 = AgentCreate("advExteriorGate_2", "adv_boardingSchoolExteriorGate_meshesARocks.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    --local advExteriorGate_3 = AgentCreate("advExteriorGate_3", "adv_boardingSchoolExteriorGate_meshesAShrubs.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    local advExteriorGate_4 = AgentCreate("advExteriorGate_4", "adv_boardingSchoolExteriorGate_meshesATrees.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    local advExteriorGate_5 = AgentCreate("advExteriorGate_5", "adv_boardingSchoolExteriorGate_meshesBGrass.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    --local advExteriorGate_6 = AgentCreate("advExteriorGate_6", "adv_boardingSchoolExteriorGate_meshesBMatteFill.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false); --too big, intersects with borading school exterior
    local advExteriorGate_7 = AgentCreate("advExteriorGate_7", "adv_boardingSchoolExteriorGate_meshesBTerrain.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    local advExteriorGate_8 = AgentCreate("advExteriorGate_8", "adv_boardingSchoolExteriorGate_meshesBTreeFlats.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false); --flat tree mattes, directly to the right of the gate
    local advExteriorGate_9 = AgentCreate("advExteriorGate_9", "adv_boardingSchoolExteriorGate_meshesBTrees.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    --local advExteriorGate_10 = AgentCreate("advExteriorGate_10", "adv_boardingSchoolExteriorGate_meshesCGrass.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    --local advExteriorGate_11 = AgentCreate("advExteriorGate_11", "adv_boardingSchoolExteriorGate_meshesCMattefill.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false); --flat tree mattes that intersect with boarding school dorm building and block the road
    local advExteriorGate_12 = AgentCreate("advExteriorGate_12", "adv_boardingSchoolExteriorGate_meshesCTerrain.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    --local advExteriorGate_13 = AgentCreate("advExteriorGate_13", "adv_boardingSchoolExteriorGate_meshesCTreeFlats.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false); --flat tree mattes that intersect with boarding school dorm building and block the road
    local advExteriorGate_14 = AgentCreate("advExteriorGate_14", "adv_boardingSchoolExteriorGate_meshesCTrees.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    local advExteriorGate_15 = AgentCreate("advExteriorGate_15", "adv_boardingSchoolExteriorGate_meshesCVehicles.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    local advExteriorGate_16 = AgentCreate("advExteriorGate_16", "adv_boardingSchoolExteriorGate_meshesDGrass.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    local advExteriorGate_17 = AgentCreate("advExteriorGate_17", "adv_boardingSchoolExteriorGate_meshesDMatteFill.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    local advExteriorGate_18 = AgentCreate("advExteriorGate_18", "adv_boardingSchoolExteriorGate_meshesDTerrain.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    local advExteriorGate_19 = AgentCreate("advExteriorGate_19", "adv_boardingSchoolExteriorGate_meshesDTreeFlats.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    local advExteriorGate_20 = AgentCreate("advExteriorGate_20", "adv_boardingSchoolExteriorGate_meshesDTrees.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    --local advExteriorGate_21 = AgentCreate("advExteriorGate_21", "adv_boardingSchoolExteriorGate_meshesEGrass.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    local advExteriorGate_22 = AgentCreate("advExteriorGate_22", "adv_boardingSchoolExteriorGate_meshesETerrain.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    --local advExteriorGate_23 = AgentCreate("advExteriorGate_23", "adv_boardingSchoolExteriorGate_meshesETreeFlats.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false); --looks good except it has a matte that blocks the road
    local advExteriorGate_24 = AgentCreate("advExteriorGate_24", "adv_boardingSchoolExteriorGate_meshesETrees.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    local advExteriorGate_25 = AgentCreate("advExteriorGate_25", "adv_boardingSchoolExteriorGate_meshesFGrass.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    local advExteriorGate_26 = AgentCreate("advExteriorGate_26", "adv_boardingSchoolExteriorGate_meshesFMatteFill.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    local advExteriorGate_27 = AgentCreate("advExteriorGate_27", "adv_boardingSchoolExteriorGate_meshesFTerrain.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    local advExteriorGate_28 = AgentCreate("advExteriorGate_28", "adv_boardingSchoolExteriorGate_meshesFTreeFlats.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    local advExteriorGate_29 = AgentCreate("advExteriorGate_29", "adv_boardingSchoolExteriorGate_meshesFTrees.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    local advExteriorGate_30 = AgentCreate("advExteriorGate_30", "adv_boardingSchoolExteriorGate_meshesGGrass.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    local advExteriorGate_31 = AgentCreate("advExteriorGate_31", "adv_boardingSchoolExteriorGate_meshesGMatteFill.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false); --this might work, but might be bit close to the road.
    local advExteriorGate_32 = AgentCreate("advExteriorGate_32", "adv_boardingSchoolExteriorGate_meshesGTerrain.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    --local advExteriorGate_33 = AgentCreate("advExteriorGate_33", "adv_boardingSchoolExteriorGate_meshesGTreeFlats.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false); --to close to road for comfort
    local advExteriorGate_34 = AgentCreate("advExteriorGate_34", "adv_boardingSchoolExteriorGate_meshesGTrees.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    local advExteriorGate_35 = AgentCreate("advExteriorGate_35", "adv_boardingSchoolExteriorGate_meshesHTerrain.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    local advExteriorGate_36 = AgentCreate("advExteriorGate_36", "adv_boardingSchoolExteriorGate_meshesITerrain.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    local advExteriorGate_37 = AgentCreate("advExteriorGate_37", "adv_boardingSchoolExteriorGate_meshesJTerrain.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    local advExteriorGate_38 = AgentCreate("advExteriorGate_38", "adv_boardingSchoolExteriorGate_meshesAGate.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    local advExteriorGate_39 = AgentCreate("advExteriorGate_39", "adv_boardingSchoolExteriorGate_meshesETreeBackground.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false); --might work?
    local advExteriorGate_40 = AgentCreate("advExteriorGate_40", "adv_boardingSchoolExteriorGate_meshesBVehicles.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    --local advExteriorGate_41 = AgentCreate("advExteriorGate_41", "adv_boardingSchoolExteriorGate_meshesDTreesNoCast.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    --local advExteriorGate_42 = AgentCreate("advExteriorGate_42", "adv_boardingSchoolExteriorGate_meshesCTreesNoCast.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);
    --local advExteriorGate_43 = AgentCreate("advExteriorGate_43", "adv_boardingSchoolExteriorGate_meshesBTreesNoCast.prop", advExteriorGate_position, advExteriorGate_rotation, kScene, false, false);

end

ALIVE_Level_Gameplay_SpawnBasement401 = function()
    local advBasement_position = Vector(21.5, -2.1, 32.75);
    local advBasement_rotation = Vector(0, 0, 0);

    local advBasement_1 = AgentCreate("advBasement_1", "adv_boardingSchoolBasement_meshesA.prop", advBasement_position, advBasement_rotation, kScene, false, false);
    local advBasement_2 = AgentCreate("advBasement_2", "adv_boardingSchoolBasement_meshesB.prop", advBasement_position, advBasement_rotation, kScene, false, false);
    local advBasement_3 = AgentCreate("advBasement_3", "adv_boardingSchoolBasement_meshesC.prop", advBasement_position, advBasement_rotation, kScene, false, false); --also has outer wall
    local advBasement_4 = AgentCreate("advBasement_4", "adv_boardingSchoolBasement_meshesD.prop", advBasement_position, advBasement_rotation, kScene, false, false);
    local advBasement_5 = AgentCreate("advBasement_5", "adv_boardingSchoolBasement_meshesA_alphas.prop", advBasement_position, advBasement_rotation, kScene, false, false);
    local advBasement_6 = AgentCreate("advBasement_6", "adv_boardingSchoolBasement_meshesA_exterior.prop", advBasement_position, advBasement_rotation, kScene, false, false);

end

ALIVE_Level_Gameplay_SpawnDorms401 = function()
    local advDorms_position = Vector(32.6, 0.001, 29.65);
    local advDorms_rotation = Vector(0, 0, 0);

    local advDorms_1 = AgentCreate("advDorms_1", "adv_boardingSchoolDorm_meshesACeiling.prop", advDorms_position, advDorms_rotation, kScene, false, false);
    local advDorms_2 = AgentCreate("advDorms_2", "adv_boardingSchoolDorm_meshesAClem.prop", advDorms_position, advDorms_rotation, kScene, false, false);
    local advDorms_3 = AgentCreate("advDorms_3", "adv_boardingSchoolDorm_meshesAFloor.prop", advDorms_position, advDorms_rotation, kScene, false, false);
    local advDorms_4 = AgentCreate("advDorms_4", "adv_boardingSchoolDorm_meshesAPipes.prop", advDorms_position, advDorms_rotation, kScene, false, false);
    local advDorms_5 = AgentCreate("advDorms_5", "adv_boardingSchoolDorm_meshesAWalls.prop", advDorms_position, advDorms_rotation, kScene, false, false);
    local advDorms_6 = AgentCreate("advDorms_6", "adv_boardingSchoolDorm_meshesAWallsExterior.prop", advDorms_position, advDorms_rotation, kScene, false, false);
    local advDorms_7 = AgentCreate("advDorms_7", "adv_boardingSchoolDorm_meshesAWindowsDoors.prop", advDorms_position, advDorms_rotation, kScene, false, false);
    local advDorms_8 = AgentCreate("advDorms_8", "adv_boardingSchoolDorm_meshesAClemFurniture.prop", advDorms_position, advDorms_rotation, kScene, false, false);
    local advDorms_9 = AgentCreate("advDorms_9", "adv_boardingSchoolDorm_meshesAFoliage.prop", advDorms_position, advDorms_rotation, kScene, false, false);
    local advDorms_10 = AgentCreate("advDorms_10", "adv_boardingSchoolDorm_meshesAGlass.prop", advDorms_position, advDorms_rotation, kScene, false, false);
    local advDorms_11 = AgentCreate("advDorms_11", "adv_boardingSchoolDorm_meshesAClemCloth.prop", advDorms_position, advDorms_rotation, kScene, false, false);
    local advDorms_12 = AgentCreate("advDorms_12", "adv_boardingSchoolDorm_meshesAClemCobwebs.prop", advDorms_position, advDorms_rotation, kScene, false, false);
    local advDorms_13 = AgentCreate("advDorms_13", "adv_boardingSchoolDorm_meshesAClemPipes.prop", advDorms_position, advDorms_rotation, kScene, false, false);
    local advDorms_14 = AgentCreate("advDorms_14", "adv_boardingSchoolDorm_meshesAClemCeiling.prop", advDorms_position, advDorms_rotation, kScene, false, false);
    local advDorms_15 = AgentCreate("advDorms_15", "adv_boardingSchoolDorm_meshesAClemFloor.prop", advDorms_position, advDorms_rotation, kScene, false, false);

end

local AgentCreate_RoadTile401 = function(name, prop, pos, rot, scene, bool1, bool2)
    local agentGroup = AgentFindInScene("advRoadTile_Group", kScene);

    local newAgent = AgentCreate(name, prop, pos, rot, scene, bool1, bool2);

    AgentAttach(agentGroup, newAgent);
end

ALIVE_Level_Gameplay_SpawnRoadTile401 = function()
    local advRoadTile_position = Vector(0, 0, 0);
    local advRoadTile_rotation = Vector(0, 0, 0);

    local advRoadTile_Group = AgentCreate("advRoadTile_Group", "group.prop", Vector(0, 0, 0), Vector(0, 0, 0), kScene, false, false);

    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesACarA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_2", "adv_roadTile_meshesAFencesPowerLinesA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_3", "adv_roadTile_meshesAFencesPowerLinesB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_4", "adv_roadTile_meshesAFencesPowerLinesD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_5", "adv_roadTile_meshesAGrassA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_6", "adv_roadTile_meshesAGrassB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_7", "adv_roadTile_meshesAGrassC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_8", "adv_roadTile_meshesAGrassD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_9", "adv_roadTile_meshesARocksA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_10", "adv_roadTile_meshesARocksB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_11", "adv_roadTile_meshesARocksC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_12", "adv_roadTile_meshesARocksD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_13", "adv_roadTile_meshesATerrainA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_14", "adv_roadTile_meshesATerrainB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_15", "adv_roadTile_meshesATerrainC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_16", "adv_roadTile_meshesATerrainD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_17", "adv_roadTile_meshesATreeFlatsA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_18", "adv_roadTile_meshesATreeFlatsB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_19", "adv_roadTile_meshesATreeFlatsC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_20", "adv_roadTile_meshesATreeFlatsD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_21", "adv_roadTile_meshesATreesA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_22", "adv_roadTile_meshesATreesB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_23", "adv_roadTile_meshesATreesC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_24", "adv_roadTile_meshesATreesD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_25", "adv_roadTile_meshesBGrassA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_26", "adv_roadTile_meshesBGrassB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_27", "adv_roadTile_meshesBGrassC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_28", "adv_roadTile_meshesBGrassD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_29", "adv_roadTile_meshesBHouse.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_30", "adv_roadTile_meshesBPuddles.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_31", "adv_roadTile_meshesBRocksA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_32", "adv_roadTile_meshesBRocksB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_33", "adv_roadTile_meshesBRocksC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_34", "adv_roadTile_meshesBRocksD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_35", "adv_roadTile_meshesBTerrainA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_36", "adv_roadTile_meshesBTerrainB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_37", "adv_roadTile_meshesBTerrainC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_38", "adv_roadTile_meshesBTerrainD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_39", "adv_roadTile_meshesBTreeFlatsA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_40", "adv_roadTile_meshesBTreeFlatsB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_41", "adv_roadTile_meshesBTreeFlatsC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_42", "adv_roadTile_meshesBTreeFlatsD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_43", "adv_roadTile_meshesBTreesA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_44", "adv_roadTile_meshesBTreesB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_45", "adv_roadTile_meshesBTreesC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_46", "adv_roadTile_meshesBTreesD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_47", "adv_roadTile_meshesCBushesA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_48", "adv_roadTile_meshesCBushesB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_49", "adv_roadTile_meshesCGrassA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_50", "adv_roadTile_meshesCGrassB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_51", "adv_roadTile_meshesCGrassC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_52", "adv_roadTile_meshesCGrassD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_53", "adv_roadTile_meshesCRocksA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_54", "adv_roadTile_meshesCRocksB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_55", "adv_roadTile_meshesCRocksC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_56", "adv_roadTile_meshesCRocksD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_57", "adv_roadTile_meshesCSignsA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_58", "adv_roadTile_meshesCTerrainA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_59", "adv_roadTile_meshesCTerrainB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_60", "adv_roadTile_meshesCTerrainC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_61", "adv_roadTile_meshesCTerrainD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_62", "adv_roadTile_meshesCTreeFlatsA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_63", "adv_roadTile_meshesCTreeFlatsB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_64", "adv_roadTile_meshesCTreeFlatsC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_65", "adv_roadTile_meshesCTreeFlatsD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_66", "adv_roadTile_meshesCTreesA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_67", "adv_roadTile_meshesCTreesB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_68", "adv_roadTile_meshesCTreesC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_69", "adv_roadTile_meshesCTreesD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_70", "adv_roadTile_meshesDFencesB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_71", "adv_roadTile_meshesDFencesD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_72", "adv_roadTile_meshesDGrassA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_73", "adv_roadTile_meshesDGrassB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_74", "adv_roadTile_meshesDGrassC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_75", "adv_roadTile_meshesDGrassD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_76", "adv_roadTile_meshesDHouse.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_77", "adv_roadTile_meshesDRocksA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_78", "adv_roadTile_meshesDRocksB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_79", "adv_roadTile_meshesDRocksC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_80", "adv_roadTile_meshesDRocksD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_81", "adv_roadTile_meshesDSignsA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_82", "adv_roadTile_meshesDTerrainA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_83", "adv_roadTile_meshesDTerrainB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_84", "adv_roadTile_meshesDTerrainC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_85", "adv_roadTile_meshesDTerrainD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_86", "adv_roadTile_meshesDTreeFlatsA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_87", "adv_roadTile_meshesDTreeFlatsB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_88", "adv_roadTile_meshesDTreeFlatsC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_89", "adv_roadTile_meshesDTreeFlatsD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_90", "adv_roadTile_meshesDTreesA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_91", "adv_roadTile_meshesDTreesB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_92", "adv_roadTile_meshesDTreesC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_93", "adv_roadTile_meshesDTreesD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_94", "adv_roadTile_meshesDTreesE.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_95", "adv_roadTile_meshesDTreesF.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_96", "adv_roadTile_meshesEFencesPowerLinesA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_97", "adv_roadTile_meshesEFencesPowerLinesC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_98", "adv_roadTile_meshesEFencesPowerLinesD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_99", "adv_roadTile_meshesEGrassA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_100", "adv_roadTile_meshesEGrassB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_101", "adv_roadTile_meshesEGrassC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_102", "adv_roadTile_meshesEGrassD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_103", "adv_roadTile_meshesEHouse.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_104", "adv_roadTile_meshesERocksA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_105", "adv_roadTile_meshesERocksB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesERocksC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesERocksD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesETerrainA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesETerrainB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesETerrainC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesETerrainD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesETreeFlatsA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesETreeFlatsB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesETreeFlatsC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesETreeFlatsD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesETreesA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesETreesB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesETreesC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesETreesD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesETreesE.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesETreesF.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFBushesA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFBushesB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFBushesD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFBushesE.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFBushesF.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFFencesSignsA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFFencesSignsB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFFencesSignsC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFFencesSignsE.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFFencesSignsF.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFGrassA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFGrassB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFGrassC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFGrassD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFGrassE.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFGrassF.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFHouse.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFRocksA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFRocksB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFRocksC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFRocksD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFRocksE.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFRocksF.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFTerrainA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFTerrainB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFTerrainC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFTerrainD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFTerrainE.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFTerrainF.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFTreeFlatsA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFTreeFlatsB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFTreeFlatsC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFTreeFlatsD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFTreeFlatsE.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFTreeFlatsF.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFTreesA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFTreesB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFTreesC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFTreesD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFTreesE.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesFTreesF.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesGBushesA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesGBushesB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesGBushesD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesGBushesE.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesGBushesF.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesGFencesSignsA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesGFencesSignsB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesGFencesSignsD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesGFencesSignsE.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesGFencesSignsF.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesGGrassA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesGGrassB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesGGrassC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesGGrassD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    AgentCreate_RoadTile401("advRoadTile_1", "adv_roadTile_meshesGGrassE.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_178 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGGrassF.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_179 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGRocksA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_180 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGRocksB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_181 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGRocksC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_182 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGRocksD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_183 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGRocksE.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_184 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGRocksF.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_185 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGTerrainA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_186 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGTerrainB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_187 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGTerrainC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_188 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGTerrainD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_189 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGTerrainE.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_190 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGTerrainF.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_191 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGTreeFlatsA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_192 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGTreeFlatsB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_193 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGTreeFlatsC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_194 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGTreeFlatsD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_195 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGTreeFlatsE.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_196 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGTreeFlatsF.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_197 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGTreesA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_198 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGTreesB.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_199 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGTreesC.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_200 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGTreesD.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_201 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGTreesE.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_202 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesGTreesF.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_203 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesCCarA.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_204 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesCGroundFoliage.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);
    local advRoadTile_205 = AgentCreate("advRoadTile_1", "adv_roadTile_meshesCGrassOpening.prop", advRoadTile_position, advRoadTile_rotation, kScene, false, false);

    AgentSetWorldPos(advRoadTile_Group, Vector(0,15,0));
    AgentSetWorldRot(advRoadTile_Group, Vector(0,90,0));
    --AgentSetPos(advRoadTile_Group, Vector(0,5,0));
    --AgentSetRot(advRoadTile_Group, Vector(0,90,0));
end

ALIVE_Level_Gameplay_UpdateCompositeWorld = function()
    --local cameraAgentName = ALIVE_AgentGetProperty(agent_name_scene, "Scene - Current Camera", kScene);
    --local cameraAgentName = "Player_ThirdPersonCamera";
    --local cameraAgentName = "myNewFreecamera";
    --Active Camera
    --Scene - Current Camera
    --z = 36

    local cameraAgent = AgentFindInScene("myNewFreecamera", kScene);

    if(cameraAgent == nil) then do return end end

    local cameraPos = AgentGetWorldPos(cameraAgent);

    if (cameraPos.z > 36) then
        ALIVE_AgentSetProperty("advExteriorGate_12", "Runtime: Visible", true, kScene); 
        ALIVE_AgentSetProperty("advExteriorGate_38", "Runtime: Visible", true, kScene);

        ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesATerrain", "Runtime: Visible", false, kScene);
        ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesDTerrainClutter", "Runtime: Visible", false, kScene);
        ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesCTerrainClutter", "Runtime: Visible", false, kScene);
    else
        if (cameraPos.x > 20) then
            ALIVE_AgentSetProperty("advExteriorGate_12", "Runtime: Visible", false, kScene); 
            ALIVE_AgentSetProperty("advExteriorGate_38", "Runtime: Visible", false, kScene);

            ALIVE_AgentSetProperty("advDorms_1", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("advDorms_2", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("advDorms_3", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("advDorms_4", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("advDorms_5", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("advDorms_6", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("advDorms_7", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("advDorms_8", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("advDorms_9", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("advDorms_10", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("advDorms_11", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("advDorms_12", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("advDorms_13", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("advDorms_14", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("advDorms_15", "Runtime: Visible", true, kScene);

            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesAGrass", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesAShrubs", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesATrees", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesABuildingBackground", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesARocks", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesATreeBackground", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesATerrain", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesAIvy", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesAGrassGraveyard", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesABuildingFront", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesABuildingLeft", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesABuildingIvy", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesATerrainClutter", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesABuilding", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesATreeFlats", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesBBuildingBackground", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesBTrees", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesBGrass", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesBRocks", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesBShrubs", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesBTreeBackground", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesBBuildingIvy", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesBTerrainClutter", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesBBuilding", "Runtime: Visible", false, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesCTrees", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesCGrass", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesCRocks", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesCShrubs", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesCBuildingIvy", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesCTreeBackground", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesCTerrainClutter", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesCBuilding", "Runtime: Visible", false, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesDGrass", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesDRocks", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesDShrubs", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesDTreeBackground", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesDTrees", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesDGate", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesDTerrainClutter", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesDBuilding", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesDIvy", "Runtime: Visible", true, kScene);
        else
            ALIVE_AgentSetProperty("advExteriorGate_12", "Runtime: Visible", false, kScene); 
            ALIVE_AgentSetProperty("advExteriorGate_38", "Runtime: Visible", false, kScene);

            ALIVE_AgentSetProperty("advDorms_1", "Runtime: Visible", false, kScene);
            ALIVE_AgentSetProperty("advDorms_2", "Runtime: Visible", false, kScene);
            ALIVE_AgentSetProperty("advDorms_3", "Runtime: Visible", false, kScene);
            ALIVE_AgentSetProperty("advDorms_4", "Runtime: Visible", false, kScene);
            ALIVE_AgentSetProperty("advDorms_5", "Runtime: Visible", false, kScene);
            ALIVE_AgentSetProperty("advDorms_6", "Runtime: Visible", false, kScene);
            ALIVE_AgentSetProperty("advDorms_7", "Runtime: Visible", false, kScene);
            ALIVE_AgentSetProperty("advDorms_8", "Runtime: Visible", false, kScene);
            ALIVE_AgentSetProperty("advDorms_9", "Runtime: Visible", false, kScene);
            ALIVE_AgentSetProperty("advDorms_10", "Runtime: Visible", false, kScene);
            ALIVE_AgentSetProperty("advDorms_11", "Runtime: Visible", false, kScene);
            ALIVE_AgentSetProperty("advDorms_12", "Runtime: Visible", false, kScene);
            ALIVE_AgentSetProperty("advDorms_13", "Runtime: Visible", false, kScene);
            ALIVE_AgentSetProperty("advDorms_14", "Runtime: Visible", false, kScene);
            ALIVE_AgentSetProperty("advDorms_15", "Runtime: Visible", false, kScene);

            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesAGrass", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesAShrubs", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesATrees", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesABuildingBackground", "Runtime: Visible", false, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesARocks", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesATreeBackground", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesATerrain", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesAIvy", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesAGrassGraveyard", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesABuildingFront", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesABuildingLeft", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesABuildingIvy", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesATerrainClutter", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesABuilding", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesATreeFlats", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesBBuildingBackground", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesBTrees", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesBGrass", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesBRocks", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesBShrubs", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesBTreeBackground", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesBBuildingIvy", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesBTerrainClutter", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesBBuilding", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesCTrees", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesCGrass", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesCRocks", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesCShrubs", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesCBuildingIvy", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesCTreeBackground", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesCTerrainClutter", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesCBuilding", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesDGrass", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesDRocks", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesDShrubs", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesDTreeBackground", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesDTrees", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesDGate", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesDTerrainClutter", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesDBuilding", "Runtime: Visible", true, kScene);
            ALIVE_AgentSetProperty("adv_boardingSchoolExterior_meshesDIvy", "Runtime: Visible", true, kScene);
        end
    end
end

ALIVE_Level_Gameplay_CompositeWorldTest = function()
    --ALIVE_PrintSceneListToTXT(kScene, "adv_boardingSchoolExterior403.txt");
    --ALIVE_PrintSceneListToTXT(kScene, "adv_boardingSchoolExteriorGate401.txt");
    --ALIVE_PrintSceneListToTXT(kScene, "adv_bellTower402.txt");
    --ALIVE_PrintSceneListToTXT(kScene, "adv_boardingSchoolInterior401.txt");
    --ALIVE_PrintSceneListToTXT(kScene, "adv_boardingSchoolBasement401.txt");
    --ALIVE_PrintSceneListToTXT(kScene, "adv_boardingSchoolDorm401.txt");
    --ALIVE_PrintSceneListToTXT(kScene, "adv_roadTile401.txt");

    ALIVE_Core_Project_SetProjectSettings();
    ALIVE_Scene_LevelCleanup_403_BoardingSchoolExterior_CompositeWorldTest(kScene);
    --ALIVE_Scene_LevelRelight_403_BoardingSchoolExterior(kScene);

    ALIVE_Level_Gameplay_SpawnBellTower402();
    ALIVE_Level_Gameplay_SpawnExteriorGate();
    --ALIVE_Level_Gameplay_SpawnBasement401();
    ALIVE_Level_Gameplay_SpawnDorms401();
    --ALIVE_Level_Gameplay_SpawnRoadTile401();

    ALIVE_Gameplay_Shared_HideCusorInGame();

    if (EnableFreecam == true) then
        ALIVE_Development_CreateFreeCamera();
        ALIVE_Development_InitalizeCutsceneTools();

        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateFreeCamera);
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Input);
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Main);
    else
        SceneAdd(ThirdPerson_UI_kScene);
        ALIVE_Gameplay_CreateThirdPersonController(Vector(15, 0, 0));
        ALIVE_Gameplay_AI_CreateZombies(10, Vector(0, 0, 17), Vector(15, 0, 15));
    end

    Callback_OnPostUpdate:Add(ALIVE_Level_Gameplay_UpdateCompositeWorld);

    ALIVE_Character_AJ_Jackets(kScene);
    ALIVE_Character_AJ_KennyHat(kScene);
    ALIVE_Character_Clementine_Sick(kScene);
end

SceneOpen(kScene, kScript)