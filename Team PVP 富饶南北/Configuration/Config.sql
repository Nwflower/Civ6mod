--==============================================================================
--******					全局参数与主流文明出生关联						  ******
--==============================================================================
-- 全局参数 (Original 2 / 3 / 7 / 6)
UPDATE GlobalParameters SET Value='5' WHERE Name='START_DISTANCE_MAJOR_NATURAL_WONDER';
UPDATE GlobalParameters SET Value='3' WHERE Name='START_DISTANCE_MINOR_NATURAL_WONDER';

-- 城邦、玩家距离
UPDATE GlobalParameters SET Value='10' WHERE Name='START_DISTANCE_MINOR_MAJOR_CIVILIZATION';
-- 城邦、城邦距离
UPDATE GlobalParameters SET Value='8' WHERE Name='START_DISTANCE_MINOR_CIVILIZATION_START';

UPDATE GlobalParameters SET Value='0' WHERE Name='NATURAL_WONDER_ADJACENT_FERTILITY';


-- 地图
--2人 1250
UPDATE Maps SET GridHeight='50'  WHERE MapSizeType='MAPSIZE_DUEL';
UPDATE Maps SET GridWidth='50' WHERE MapSizeType='MAPSIZE_DUEL';
UPDATE Maps SET NumNaturalWonders='3' WHERE MapSizeType='MAPSIZE_DUEL';
UPDATE Maps SET Continents='1' WHERE MapSizeType='MAPSIZE_DUEL';
--4人 784
UPDATE Maps SET GridHeight='56'  WHERE MapSizeType='MAPSIZE_GIGANTIC';
UPDATE Maps SET GridWidth='56' WHERE MapSizeType='MAPSIZE_GIGANTIC';
UPDATE Maps SET NumNaturalWonders='3' WHERE MapSizeType='MAPSIZE_GIGANTIC';
UPDATE Maps SET Continents='2' WHERE MapSizeType='MAPSIZE_GIGANTIC';
--6人 640
UPDATE Maps SET GridHeight='62'  WHERE MapSizeType='MAPSIZE_TINY';
UPDATE Maps SET GridWidth='62' WHERE MapSizeType='MAPSIZE_TINY';
UPDATE Maps SET NumNaturalWonders='4' WHERE MapSizeType='MAPSIZE_TINY';
UPDATE Maps SET Continents='3' WHERE MapSizeType='MAPSIZE_TINY';
--8人 612
UPDATE Maps SET GridHeight='70'  WHERE MapSizeType='MAPSIZE_SMALL';
UPDATE Maps SET GridWidth='70' WHERE MapSizeType='MAPSIZE_SMALL';
UPDATE Maps SET NumNaturalWonders='5' WHERE MapSizeType='MAPSIZE_SMALL';
UPDATE Maps SET Continents='4' WHERE MapSizeType='MAPSIZE_SMALL';
--10 577
UPDATE Maps SET GridHeight='76' WHERE MapSizeType='MAPSIZE_STANDARD';
UPDATE Maps SET GridWidth='76' WHERE MapSizeType='MAPSIZE_STANDARD';
UPDATE Maps SET NumNaturalWonders='6' WHERE MapSizeType='MAPSIZE_STANDARD';
UPDATE Maps SET Continents='5' WHERE MapSizeType='MAPSIZE_STANDARD';
--12 560
UPDATE Maps SET GridHeight='82' WHERE MapSizeType='MAPSIZE_LARGE';
UPDATE Maps SET GridWidth='82' WHERE MapSizeType='MAPSIZE_LARGE';
UPDATE Maps SET NumNaturalWonders='7'  WHERE MapSizeType='MAPSIZE_LARGE';
UPDATE Maps SET Continents='6' WHERE MapSizeType='MAPSIZE_LARGE';
--14 528
UPDATE Maps SET GridHeight='86' WHERE MapSizeType='MAPSIZE_HUGE';
UPDATE Maps SET GridWidth='86' WHERE MapSizeType='MAPSIZE_HUGE';
UPDATE Maps SET NumNaturalWonders='8'  WHERE MapSizeType='MAPSIZE_HUGE';
UPDATE Maps SET Continents='6' WHERE MapSizeType='MAPSIZE_HUGE';
--16 484
UPDATE Maps SET GridHeight='88' WHERE MapSizeType='MAPSIZE_HUGE_16';
UPDATE Maps SET GridWidth='88' WHERE MapSizeType='MAPSIZE_HUGE_16';
UPDATE Maps SET NumNaturalWonders='9'  WHERE MapSizeType='MAPSIZE_HUGE_16';
UPDATE Maps SET Continents='7' WHERE MapSizeType='MAPSIZE_HUGE_16';
--18 470
UPDATE Maps SET GridHeight='92' WHERE MapSizeType='MAPSIZE_HUGE_18';
UPDATE Maps SET GridWidth='92' WHERE MapSizeType='MAPSIZE_HUGE_18';
UPDATE Maps SET NumNaturalWonders='10'  WHERE MapSizeType='MAPSIZE_HUGE_18';
UPDATE Maps SET Continents='7' WHERE MapSizeType='MAPSIZE_HUGE_18';


--宗教
UPDATE Map_GreatPersonClasses SET MaxWorldInstances='5' WHERE MapSizeType='MAPSIZE_STANDARD';
UPDATE Map_GreatPersonClasses SET MaxWorldInstances='5' WHERE MapSizeType='MAPSIZE_LARGE';
UPDATE Map_GreatPersonClasses SET MaxWorldInstances='5' WHERE MapSizeType='MAPSIZE_HUGE';

--地脉
UPDATE Resources SET Frequency='10' WHERE ResourceType='RESOURCE_LEY_LINE';
--铝 
UPDATE Resources SET Frequency='13' Where ResourceType='RESOURCE_ALUMINUM';
--油
UPDATE Resources SET Frequency='21' Where ResourceType='RESOURCE_OIL';
--硝石
UPDATE Resources SET Frequency='16' Where ResourceType='RESOURCE_NITER';
--煤
UPDATE Resources SET Frequency='16' Where ResourceType='RESOURCE_COAL';

--关联

--马关联马里沙漠泛滥平原
INSERT INTO Resource_ValidFeatures (ResourceType, FeatureType)
VALUES ('RESOURCE_HORSES', 'FEATURE_FLOODPLAINS');
--马关联加拿大或俄罗斯冻土丘陵
INSERT INTO Resource_ValidTerrains (ResourceType, TerrainType)
VALUES ('RESOURCE_HORSES', 'TERRAIN_TUNDRA');

--加拿大
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_CANADA' AND TerrainType='TERRAIN_TUNDRA';
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_CANADA' AND TerrainType='TERRAIN_TUNDRA_HILLS';
--俄罗斯--
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_RUSSIA' AND TerrainType='TERRAIN_TUNDRA';
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_RUSSIA' AND TerrainType='TERRAIN_TUNDRA_HILLS';

-- 海岸绑定
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
--迦太基--
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_PHOENICIA' AND TerrainType='TERRAIN_COAST';


-- 资源绑定
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

--==============================================================================
--******			自建出生关联表		  	  ******
--==============================================================================

-- 相同条件下，领袖优先覆盖文明的关联表
CREATE TABLE IF NOT EXISTS NW_StartBias
(
    Type        TEXT    NOT NULL PRIMARY KEY,
    Flag        INTEGER NOT NULL DEFAULT 0,
    ActiveTerrains    TEXT,
    NegativeTerrains  TEXT,
    ActiveFeatures    TEXT,
    NegativeFeatures  TEXT,
    ActiveResources   TEXT,
    NegativeResources TEXT
);

INSERT OR IGNORE INTO NW_StartBias(Type, Flag)
SELECT CivilizationType,
       1
FROM StartBiasTerrains
WHERE TerrainType IN ('TERRAIN_TUNDRA','TERRAIN_TUNDRA_HILLS')
   AND Tier = 1;

INSERT OR IGNORE INTO NW_StartBias(Type, Flag)
SELECT CivilizationType,
       2
FROM StartBiasTerrains
WHERE TerrainType IN ('TERRAIN_DESERT','TERRAIN_DESERT_HILLS')
   AND Tier = 1;

INSERT OR IGNORE INTO NW_StartBias(Type, Flag)
SELECT CivilizationType,
       3
FROM StartBiasTerrains
WHERE TerrainType IN (SELECT TerrainType FROM Terrains WHERE Mountain = 1) AND Tier = 1;

INSERT OR IGNORE INTO NW_StartBias(Type, Flag)
VALUES ('LEADER_T_ROOSEVELT',3),
       ('LEADER_PACHACUTI',3);


--==============================================================================
--******			城邦出生关联		  	  ******
--==============================================================================
INSERT INTO StartBiasResources (CivilizationType , ResourceType , Tier)	VALUES
('CIVILIZATION_JERUSALEM' , 'RESOURCE_INCENSE' , 5),
('CIVILIZATION_ZANZIBAR' , 'RESOURCE_DIAMONDS' , 5),
('CIVILIZATION_KUMASI' , 'RESOURCE_COCOA' , 5),
('CIVILIZATION_HATTUSA' , 'RESOURCE_WHEAT' , 5),
('CIVILIZATION_HATTUSA' , 'RESOURCE_SHEEP' , 5),
('CIVILIZATION_CARDIFF' , 'RESOURCE_DEER' , 5),
('CIVILIZATION_HONG_KONG' , 'RESOURCE_SILK' , 5),
('CIVILIZATION_FEZ' , 'RESOURCE_DYES' , 5),
('CIVILIZATION_AKKAD' , 'RESOURCE_OIL' , 5);
INSERT INTO StartBiasRivers (CivilizationType , Tier)	VALUES
('CIVILIZATION_ANTIOCH' , 3),
('CIVILIZATION_BOLOGNA' , 3),
('CIVILIZATION_KANDY' , 3),
('CIVILIZATION_VILNIUS' , 3),
('CIVILIZATION_HATTUSA' , 5),
('CIVILIZATION_PRESLAV' , 3),
('CIVILIZATION_GENEVA' , 3),
('CIVILIZATION_BRUSSELS' , 3),
('CIVILIZATION_JERUSALEM' , 3),
('CIVILIZATION_AKKAD' , 3);
INSERT INTO StartBiasTerrains (CivilizationType , TerrainType , Tier)	VALUES
('CIVILIZATION_PRESLAV' , 'TERRAIN_PLAINS' , 5),
('CIVILIZATION_FEZ' , 'TERRAIN_PLAINS' , 5),
('CIVILIZATION_FEZ' , 'TERRAIN_PLAINS_HILLS' , 5),
('CIVILIZATION_VALLETTA' , 'TERRAIN_COAST' , 3),
('CIVILIZATION_CAHOKIA' , 'TERRAIN_PLAINS' , 5),
('CIVILIZATION_BOLOGNA' , 'TERRAIN_PLAINS' , 5),
('CIVILIZATION_HATTUSA' , 'TERRAIN_PLAINS' , 5),
('CIVILIZATION_HATTUSA' , 'TERRAIN_PLAINS_HILLS' , 5),
('CIVILIZATION_BOLOGNA' , 'TERRAIN_GRASS' , 5),
('CIVILIZATION_BRUSSELS' , 'TERRAIN_GRASS' , 5),
('CIVILIZATION_MEXICO_CITY' , 'TERRAIN_PLAINS' , 5),
('CIVILIZATION_ANTIOCH' , 'TERRAIN_PLAINS_HILLS' , 5),
('CIVILIZATION_BABYLON' , 'TERRAIN_PLAINS_HILLS' , 5),
('CIVILIZATION_KANDY' , 'TERRAIN_PLAINS_HILLS' , 5),
('CIVILIZATION_KANDY' , 'TERRAIN_GRASS_HILLS' , 5),
('CIVILIZATION_JERUSALEM' , 'TERRAIN_PLAINS' , 5),
('CIVILIZATION_JERUSALEM' , 'TERRAIN_DESERT' , 4),
('CIVILIZATION_MOHENJO_DARO' , 'TERRAIN_PLAINS' , 5),
('CIVILIZATION_YEREVAN' , 'TERRAIN_PLAINS_HILLS' , 5),
('CIVILIZATION_VILNIUS' , 'TERRAIN_GRASS' , 5),
('CIVILIZATION_CAHOKIA' , 'TERRAIN_GRASS' , 5),
('CIVILIZATION_KABUL' , 'TERRAIN_PLAINS_MOUNTAIN' , 3),
('CIVILIZATION_KABUL' , 'TERRAIN_PLAINS' , 5),
('CIVILIZATION_KABUL' , 'TERRAIN_PLAINS_HILLS'  , 5),
('CIVILIZATION_ZANZIBAR' , 'TERRAIN_COAST' , 3),
('CIVILIZATION_BUENOS_AIRES' , 'TERRAIN_GRASS' , 5);
INSERT INTO StartBiasFeatures (CivilizationType , FeatureType , Tier)VALUES
('CIVILIZATION_PRESLAV' , 'FEATURE_FOREST' , 5),
('CIVILIZATION_FEZ' , 'FEATURE_FOREST' , 5),
('CIVILIZATION_VALLETTA' , 'FEATURE_FOREST' , 3),
('CIVILIZATION_CAHOKIA' , 'FEATURE_FOREST' , 5),
('CIVILIZATION_BOLOGNA' , 'FEATURE_FOREST' , 5),
('CIVILIZATION_HATTUSA' , 'FEATURE_FOREST' , 5),
('CIVILIZATION_BRUSSELS' , 'FEATURE_FOREST' , 5),
('CIVILIZATION_ANTIOCH' , 'FEATURE_OASIS' , 5),
('CIVILIZATION_BABYLON' , 'FEATURE_OASIS' , 5),
('CIVILIZATION_KANDY' , 'FEATURE_JUNGLE' , 5),
('CIVILIZATION_JERUSALEM' , 'FEATURE_FOREST' , 5),
('CIVILIZATION_YEREVAN' , 'FEATURE_FOREST' , 5),
('CIVILIZATION_CARDIFF' , 'FEATURE_FOREST' , 5),
('CIVILIZATION_GENEVA' , 'FEATURE_FOREST' , 5),
('CIVILIZATION_VILNIUS' , 'FEATURE_FOREST'  , 5),
('CIVILIZATION_KABUL' , 'FEATURE_FOREST' , 5),
('CIVILIZATION_ZANZIBAR' , 'FEATURE_JUNGLE' , 5),
('CIVILIZATION_KUMASI' , 'FEATURE_JUNGLE' , 5),
('CIVILIZATION_BUENOS_AIRES' , 'FEATURE_FOREST' , 5),
('CIVILIZATION_BABYLON' , 'FEATURE_FLOODPLAINS' , 4),
('CIVILIZATION_MOHENJO_DARO' , 'FEATURE_FLOODPLAINS' , 4),
('CIVILIZATION_MOHENJO_DARO' , 'FEATURE_FLOODPLAINS_PLAINS' , 4);



--==============================================================================
--******			DLC城邦出生关联			  	  ******
--==============================================================================
INSERT INTO StartBiasResources (CivilizationType, ResourceType, Tier)
SELECT CivilizationType, 'RESOURCE_SHEEP', 5
FROM Civilizations WHERE CivilizationType = 'CIVILIZATION_AUCKLAND'
UNION SELECT CivilizationType, 'RESOURCE_FISH', 3
FROM Civilizations WHERE CivilizationType = 'CIVILIZATION_AUCKLAND'
UNION SELECT CivilizationType, 'RESOURCE_CRABS', 3
FROM Civilizations WHERE CivilizationType = 'CIVILIZATION_AUCKLAND';

INSERT INTO StartBiasTerrains (CivilizationType, TerrainType, Tier)
SELECT CivilizationType, 'TERRAIN_COAST', 3
FROM Civilizations WHERE CivilizationType = 'CIVILIZATION_MUSCAT'
UNION SELECT CivilizationType, 'TERRAIN_GRASS', 5
FROM Civilizations WHERE CivilizationType = 'CIVILIZATION_MUSCAT';

INSERT INTO StartBiasFeatures (CivilizationType, FeatureType, Tier)
SELECT CivilizationType, 'FEATURE_JUNGLE', 3
FROM Civilizations WHERE CivilizationType = 'CIVILIZATION_PALENQUE';

INSERT INTO StartBiasRivers (CivilizationType, Tier)
SELECT CivilizationType, 5
FROM Civilizations WHERE CivilizationType = 'CIVILIZATION_PALENQUE';