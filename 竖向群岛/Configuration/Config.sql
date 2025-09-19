--==============================================================================
--******			Global Parameters			  ******
--==============================================================================
-- Minimum Distances for CPL (Original 2 / 3 / 7 / 6)
UPDATE GlobalParameters SET Value='5' WHERE Name='START_DISTANCE_MAJOR_NATURAL_WONDER';
UPDATE GlobalParameters SET Value='3' WHERE Name='START_DISTANCE_MINOR_NATURAL_WONDER';
UPDATE GlobalParameters SET Value='7' WHERE Name='START_DISTANCE_MINOR_MAJOR_CIVILIZATION';--8
UPDATE GlobalParameters SET Value='5' WHERE Name='START_DISTANCE_MINOR_CIVILIZATION_START';--7

UPDATE GlobalParameters SET Value='0' WHERE Name='NATURAL_WONDER_ADJACENT_FERTILITY';

-- 地图
--2人			 -- 36x36 = 1296		648
UPDATE Maps SET GridHeight="36"  WHERE MapSizeType="MAPSIZE_DUEL";
UPDATE Maps SET GridWidth="58" WHERE MapSizeType="MAPSIZE_DUEL";
UPDATE Maps SET NumNaturalWonders="3" WHERE MapSizeType="MAPSIZE_DUEL";
UPDATE Maps SET Continents="1" WHERE MapSizeType="MAPSIZE_DUEL";
--4人  52 2700		-- 44x44 = 1936		484
UPDATE Maps SET GridHeight="46"  WHERE MapSizeType="MAPSIZE_GIGANTIC";
UPDATE Maps SET GridWidth="60" WHERE MapSizeType="MAPSIZE_GIGANTIC";
UPDATE Maps SET NumNaturalWonders="3" WHERE MapSizeType="MAPSIZE_GIGANTIC";
UPDATE Maps SET Continents="2" WHERE MapSizeType="MAPSIZE_GIGANTIC";
--6人 4100		-- 52x52 = 2704		451
UPDATE Maps SET GridHeight="66"  WHERE MapSizeType="MAPSIZE_TINY";
UPDATE Maps SET GridWidth="64" WHERE MapSizeType="MAPSIZE_TINY";
UPDATE Maps SET NumNaturalWonders="4" WHERE MapSizeType="MAPSIZE_TINY";
UPDATE Maps SET Continents="3" WHERE MapSizeType="MAPSIZE_TINY";
--8人 5200 		-- 56x56 = 3136		392
UPDATE Maps SET GridHeight="76"  WHERE MapSizeType="MAPSIZE_SMALL";
UPDATE Maps SET GridWidth="70" WHERE MapSizeType="MAPSIZE_SMALL";
UPDATE Maps SET NumNaturalWonders="5" WHERE MapSizeType="MAPSIZE_SMALL";
UPDATE Maps SET Continents="4" WHERE MapSizeType="MAPSIZE_SMALL"; 
--10 6400 		-- 62x62 = 3844		384
UPDATE Maps SET GridHeight="82" WHERE MapSizeType="MAPSIZE_STANDARD";
UPDATE Maps SET GridWidth="70" WHERE MapSizeType="MAPSIZE_STANDARD";
UPDATE Maps SET NumNaturalWonders="6" WHERE MapSizeType="MAPSIZE_STANDARD";
UPDATE Maps SET Continents="5" WHERE MapSizeType="MAPSIZE_STANDARD"; 
--12 7400 86 	-- 68x68 = 4624		385
UPDATE Maps SET GridHeight="88" WHERE MapSizeType="MAPSIZE_LARGE";
UPDATE Maps SET GridWidth="72" WHERE MapSizeType="MAPSIZE_LARGE";
UPDATE Maps SET NumNaturalWonders="7"  WHERE MapSizeType="MAPSIZE_LARGE";
UPDATE Maps SET Continents="6" WHERE MapSizeType="MAPSIZE_LARGE";
--14 8464 		-- 72x72 = 5184		370
UPDATE Maps SET GridHeight="96" WHERE MapSizeType="MAPSIZE_HUGE";
UPDATE Maps SET GridWidth="72" WHERE MapSizeType="MAPSIZE_HUGE";
UPDATE Maps SET NumNaturalWonders="7"  WHERE MapSizeType="MAPSIZE_HUGE";
UPDATE Maps SET Continents="6" WHERE MapSizeType="MAPSIZE_HUGE";
--16 10000		-- 74x74 = 5476		342
UPDATE Maps SET GridHeight="102" WHERE MapSizeType="MAPSIZE_HUGE_16";
UPDATE Maps SET GridWidth="72" WHERE MapSizeType="MAPSIZE_HUGE_16";
UPDATE Maps SET NumNaturalWonders="8"  WHERE MapSizeType="MAPSIZE_HUGE_16";
UPDATE Maps SET Continents="6" WHERE MapSizeType="MAPSIZE_HUGE_16";
--18 11200		76x76 = 5776		321
UPDATE Maps SET GridHeight="106" WHERE MapSizeType="MAPSIZE_HUGE_18";
UPDATE Maps SET GridWidth="72" WHERE MapSizeType="MAPSIZE_HUGE_18";
UPDATE Maps SET NumNaturalWonders="8"  WHERE MapSizeType="MAPSIZE_HUGE_18";
UPDATE Maps SET Continents="6" WHERE MapSizeType="MAPSIZE_HUGE_18";

--马关联马里沙漠泛滥平原
INSERT INTO Resource_ValidFeatures (ResourceType, FeatureType)
	VALUES ('RESOURCE_HORSES', 'FEATURE_FLOODPLAINS');
--马关联加拿大或俄罗斯冻土丘陵
INSERT INTO Resource_ValidTerrains (ResourceType, TerrainType)
	VALUES ('RESOURCE_HORSES', 'TERRAIN_TUNDRA');

--宗教
UPDATE Map_GreatPersonClasses SET MaxWorldInstances="5" WHERE MapSizeType="MAPSIZE_STANDARD";
UPDATE Map_GreatPersonClasses SET MaxWorldInstances="5" WHERE MapSizeType="MAPSIZE_LARGE";
UPDATE Map_GreatPersonClasses SET MaxWorldInstances="5" WHERE MapSizeType="MAPSIZE_HUGE";		-- 14

--资源
UPDATE Resources SET Frequency="10" WHERE ResourceType='RESOURCE_LEY_LINE';
--铝 
UPDATE Resources SET Frequency='13' Where ResourceType="RESOURCE_ALUMINUM";	
--油
UPDATE Resources SET Frequency='21' Where ResourceType="RESOURCE_OIL";
--硝石
UPDATE Resources SET Frequency='16' Where ResourceType="RESOURCE_NITER";
--煤
UPDATE Resources SET Frequency='16' Where ResourceType="RESOURCE_COAL";	

--关联

--加拿大
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_CANADA' AND TerrainType='TERRAIN_TUNDRA';
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_CANADA' AND TerrainType='TERRAIN_TUNDRA_HILLS';
--俄罗斯--
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_RUSSIA' AND TerrainType='TERRAIN_TUNDRA';
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_RUSSIA' AND TerrainType='TERRAIN_TUNDRA_HILLS';
--挪威--海边
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_NORWAY' AND TerrainType='TERRAIN_COAST';
--英国--海边
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_ENGLAND' AND TerrainType='TERRAIN_COAST';
--荷兰
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_NETHERLANDS' AND TerrainType='TERRAIN_COAST';
--澳大利亚
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_AUSTRALIA' AND TerrainType='TERRAIN_COAST';
--腓尼基
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_PHOENICIA' AND TerrainType='TERRAIN_COAST';
--日本
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_JAPAN' AND TerrainType='TERRAIN_COAST';
--印度尼西亚
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_INDONESIA' AND TerrainType='TERRAIN_COAST';

--英国--煤
--INSERT INTO StartBiasResources (CivilizationType,ResourceType,Tier)
--	VALUES ('CIVILIZATION_ENGLAND','RESOURCE_COAL','1');
--迦太基--
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_PHOENICIA' AND TerrainType='TERRAIN_COAST';
--努比亚--关联羊
UPDATE StartBiasResources SET Tier='1' WHERE CivilizationType='CIVILIZATION_NUBIA' AND ResourceType='RESOURCE_CATTLE';
--澳大利亚
UPDATE StartBiasResources SET Tier='2' WHERE CivilizationType='CIVILIZATION_AUSTRALIA' AND ResourceType='RESOURCE_CATTLE';
UPDATE StartBiasResources SET Tier='2' WHERE CivilizationType='CIVILIZATION_AUSTRALIA' AND ResourceType='RESOURCE_HORSES';
UPDATE StartBiasResources SET Tier='2' WHERE CivilizationType='CIVILIZATION_AUSTRALIA' AND ResourceType='RESOURCE_SHEEP';
--玛雅
DELETE FROM StartBiasResources WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_SPICES';
DELETE FROM StartBiasResources WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_COFFEE';
UPDATE StartBiasResources SET Tier=1 WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_CITRUS';
UPDATE StartBiasResources SET Tier=1 WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_COCOA';
UPDATE StartBiasResources SET Tier=1 WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_COTTON';
UPDATE StartBiasResources SET Tier=1 WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_DYES';
UPDATE StartBiasResources SET Tier=1 WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_SILK';
UPDATE StartBiasResources SET Tier=1 WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_SUGAR';
UPDATE StartBiasResources SET Tier=1 WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_TEA';
UPDATE StartBiasResources SET Tier=1 WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_TOBACCO';
UPDATE StartBiasResources SET Tier=1 WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_WINE';
UPDATE StartBiasResources SET Tier=1 WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_INCENSE';
UPDATE StartBiasResources SET Tier=1 WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_OLIVES';
UPDATE StartBiasResources SET Tier=1 WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_BANANAS';
UPDATE StartBiasTerrains  SET Tier=5 WHERE CivilizationType='CIVILIZATION_MAYA' AND TerrainType='TERRAIN_GRASS';
UPDATE StartBiasTerrains  SET Tier=5 WHERE CivilizationType='CIVILIZATION_MAYA' AND TerrainType='TERRAIN_PLAINS';
DELETE FROM StartBiasResources WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_GYPSUM';
DELETE FROM StartBiasResources WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_JADE';
DELETE FROM StartBiasResources WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_MARBLE';
DELETE FROM StartBiasResources WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_MERCURY';
DELETE FROM StartBiasResources WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_SALT';
DELETE FROM StartBiasResources WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_IVORY';


--马里 河流
UPDATE StartBiasRivers SET Tier='1' WHERE CivilizationType='CIVILIZATION_INDONESIA';
--匈牙利 河流
UPDATE StartBiasRivers SET Tier='1' WHERE CivilizationType='CIVILIZATION_INDONESIA';
--荷兰 河流
UPDATE StartBiasRivers SET Tier='1' WHERE CivilizationType='CIVILIZATION_INDONESIA';