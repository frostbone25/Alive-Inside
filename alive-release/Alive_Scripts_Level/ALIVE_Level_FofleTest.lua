require("ALIVE_Core_Inclusions.lua");

--Scene Specific ResourceSets
ResourceSetEnable("ProjectSeason4");    
ResourceSetEnable("WalkingDead404");

--Engine Scene Variables
kScript = "ALIVE_Level_FofleTest"
kScene = "adv_riverShorelineNight"
kSceneObj = kScene .. ".scene"

--Required ALIVE INSIDE variables
ALIVE_Development_SceneObject = kScene;
ThirdPerson_kScene = kScene;
ZombieAI_kScene = kScene;
ALIVE_Development_SceneObjectAgentName = kSceneObj;
ALIVE_Development_UseSeasonOneAPI = false;
ALIVE_Development_FreecamUseFOVScale = false;
FOFLE_SceneID = "fofleTest";

ALIVE_Level_FofleTest = function()
    dofile("ALIVE_Fofle.lua");
end

SceneOpen(kScene,kScript)