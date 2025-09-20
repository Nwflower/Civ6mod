--	FILE: 千川白浪MOD核心
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025-9-19 20:16:26
--------------------------------------------------------------------------------
--  作者： 千川白浪
--  特别鸣谢： 优妮
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Utils.sql
CREATE TABLE IF NOT EXISTS Nw_ModCore_Table
(
    file_name TEXT    NOT NULL,
    Version   INTEGER NOT NULL DEFAULT 1,
    PRIMARY KEY (file_name, Version)
);

BEGIN TRANSACTION;
INSERT OR IGNORE INTO Nw_ModCore_Table (file_name, Version) VALUES ('Utils.sql', 0);
SELECT CASE
           WHEN changes() = 0
               THEN RAISE(ABORT, 'Utils.sql already executed')
           END;
COMMIT;

------------------------------------------------------------------------------
-- 区域类
------------------------------------------------------------------------------

-- 条件集：城市拥有某区域
INSERT OR IGNORE INTO RequirementSets(RequirementSetId, RequirementSetType)
SELECT 'NW_CITY_HAS_' || DistrictType, 'REQUIREMENTSET_TEST_ALL'
FROM Districts;
INSERT OR IGNORE INTO RequirementSetRequirements(RequirementSetId, RequirementId)
SELECT 'NW_CITY_HAS_' || DistrictType, 'NW_CITY_HAS_' || DistrictType || '_REQUIREMENT'
FROM Districts;
INSERT OR IGNORE INTO Requirements(RequirementId, RequirementType)
SELECT 'NW_CITY_HAS_' || DistrictType || '_REQUIREMENT', 'REQUIREMENT_CITY_HAS_DISTRICT'
FROM Districts;
INSERT OR IGNORE INTO RequirementArguments(RequirementId, Name, Value)
SELECT 'NW_CITY_HAS_' || DistrictType || '_REQUIREMENT', 'DistrictType', DistrictType
FROM Districts;

-- 条件集：区域是任意专业化区域
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('NW_IS_SPECIALTY_DISTRICT', 'REQUIREMENTSET_TEST_ANY');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
SELECT 'NW_IS_SPECIALTY_DISTRICT', 'NW_DISTRICT_IS_' || DistrictType || '_REQUIREMENT'
FROM Districts
WHERE RequiresPopulation = 1;

-- 条件集：区域类型匹配
INSERT OR IGNORE INTO RequirementSets(RequirementSetId, RequirementSetType)
SELECT 'NW_DISTRICT_IS_' || DistrictType, 'REQUIREMENTSET_TEST_ALL'
FROM Districts;
INSERT OR IGNORE INTO RequirementSetRequirements(RequirementSetId, RequirementId)
SELECT 'NW_DISTRICT_IS_' || DistrictType, 'NW_DISTRICT_IS_' || DistrictType || '_REQUIREMENT'
FROM Districts;
INSERT OR IGNORE INTO Requirements(RequirementId, RequirementType)
SELECT 'NW_DISTRICT_IS_' || DistrictType || '_REQUIREMENT', 'REQUIREMENT_DISTRICT_TYPE_MATCHES'
FROM Districts;
INSERT OR IGNORE INTO RequirementArguments(RequirementId, Name, Value)
SELECT 'NW_DISTRICT_IS_' || DistrictType || '_REQUIREMENT', 'DistrictType', DistrictType
FROM Districts;


------------------------------------------------------------------------------
-- 城市类
------------------------------------------------------------------------------

-- 城市拥有某改良资源
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
SELECT 'NW_CITY_HAS_IMPROVED_' || Resources.ResourceType || '_REQ',
       'REQUIREMENT_CITY_HAS_RESOURCE_TYPE_IMPROVED'
FROM Resources
WHERE NOT Resources.ResourceType = 'NW_DUMMY_RESOURCE_MACEDON';
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value)
SELECT 'NW_CITY_HAS_IMPROVED_' || Resources.ResourceType || '_REQ',
       'ResourceType',
       Resources.ResourceType
FROM Resources
WHERE NOT Resources.ResourceType = 'NW_DUMMY_RESOURCE_MACEDON';

-- 城市拥有任意改良战略
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('NW_CITY_HAS_IMPROVED_STRAT_REQSET', 'REQUIREMENTSET_TEST_ANY');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
SELECT 'NW_CITY_HAS_IMPROVED_STRAT_REQSET',
       'NW_CITY_HAS_IMPROVED_' || Resources.ResourceType || '_REQ'
FROM Resources
WHERE ResourceClassType = 'RESOURCECLASS_STRATEGIC';
-- 城市拥有任意改良加成
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('NW_CITY_HAS_IMPROVED_BONUS_REQSET', 'REQUIREMENTSET_TEST_ANY');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
SELECT 'NW_CITY_HAS_IMPROVED_BONUS_REQSET',
       'NW_CITY_HAS_IMPROVED_' || Resources.ResourceType || '_REQ'
FROM Resources
WHERE ResourceClassType = 'RESOURCECLASS_BONUS';
-- 城市拥有任意改良奢侈
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('NW_CITY_HAS_IMPROVED_LUX_REQSET', 'REQUIREMENTSET_TEST_ANY');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
SELECT 'NW_CITY_HAS_IMPROVED_LUX_REQSET',
       'NW_CITY_HAS_IMPROVED_' || Resources.ResourceType || '_REQ'
FROM Resources
WHERE ResourceClassType = 'RESOURCECLASS_LUXURY';

------------------------------------------------------------------------------
-- 科技市政类
------------------------------------------------------------------------------
-- 玩家拥有某科技
INSERT OR IGNORE INTO RequirementSets(RequirementSetId, RequirementSetType)
SELECT 'NW_PLAYER_HAS_' || TechnologyType, 'REQUIREMENTSET_TEST_ALL'
FROM Technologies;
INSERT OR IGNORE INTO Requirements(RequirementId, RequirementType)
SELECT 'NW_UTILS_PLAYER_HAS_' || TechnologyType || '_REQUIREMENT', 'REQUIREMENT_PLAYER_HAS_TECHNOLOGY'
FROM Technologies;
INSERT OR IGNORE INTO RequirementArguments(RequirementId, Name, Value)
SELECT 'NW_UTILS_PLAYER_HAS_' || TechnologyType || '_REQUIREMENT', 'TechnologyType', TechnologyType
FROM Technologies;
INSERT OR IGNORE INTO RequirementSetRequirements(RequirementSetId, RequirementId)
SELECT 'NW_PLAYER_HAS_' || TechnologyType, 'NW_UTILS_PLAYER_HAS_' || TechnologyType || '_REQUIREMENT'
FROM Technologies;

-- 玩家拥有某市政
INSERT OR IGNORE INTO RequirementSets(RequirementSetId, RequirementSetType)
SELECT 'NW_PLAYER_HAS_' || CivicType, 'REQUIREMENTSET_TEST_ALL'
FROM Civics;
INSERT OR IGNORE INTO Requirements(RequirementId, RequirementType)
SELECT 'NW_UTILS_PLAYER_HAS_' || CivicType || '_REQUIREMENT', 'REQUIREMENT_PLAYER_HAS_CIVIC'
FROM Civics;
INSERT OR IGNORE INTO RequirementArguments(RequirementId, Name, Value)
SELECT 'NW_UTILS_PLAYER_HAS_' || CivicType || '_REQUIREMENT', 'CivicType', CivicType
FROM Civics;
INSERT OR IGNORE INTO RequirementSetRequirements(RequirementSetId, RequirementId)
SELECT 'NW_PLAYER_HAS_' || CivicType, 'NW_UTILS_PLAYER_HAS_' || CivicType || '_REQUIREMENT'
FROM Civics;


-- 玩家是某指定领袖
INSERT OR IGNORE INTO RequirementSets(RequirementSetId, RequirementSetType)
SELECT 'NW_PLAYER_IS_' || LeaderType, 'REQUIREMENTSET_TEST_ANY'
FROM Leaders
WHERE InheritFrom = 'LEADER_DEFAULT';
INSERT OR IGNORE INTO RequirementSetRequirements(RequirementSetId, RequirementId)
SELECT 'NW_PLAYER_IS_' || LeaderType, 'NW_PLAYER_IS_' || LeaderType || '_REQUIREMENT'
FROM Leaders
WHERE InheritFrom = 'LEADER_DEFAULT';
INSERT OR IGNORE INTO Requirements(RequirementId, RequirementType)
SELECT 'NW_PLAYER_IS_' || LeaderType || '_REQUIREMENT', 'REQUIREMENT_PLAYER_LEADER_TYPE_MATCHES'
FROM Leaders
WHERE InheritFrom = 'LEADER_DEFAULT';
INSERT OR IGNORE INTO RequirementArguments(RequirementId, Name, Value)
SELECT 'NW_PLAYER_IS_' || LeaderType || '_REQUIREMENT', 'LeaderType', LeaderType
FROM Leaders
WHERE InheritFrom = 'LEADER_DEFAULT';


-- 玩家可见某资源
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('NW_PLAYER_CAN_SEE_HORSES', 'REQUIREMENTSET_TEST_ALL'),
       ('NW_PLAYER_CAN_SEE_IRON', 'REQUIREMENTSET_TEST_ALL'),
       ('NW_PLAYER_CAN_SEE_NITER', 'REQUIREMENTSET_TEST_ALL'),
       ('NW_PLAYER_CAN_SEE_COAL', 'REQUIREMENTSET_TEST_ALL'),
       ('NW_PLAYER_CAN_SEE_ALUMINUM', 'REQUIREMENTSET_TEST_ALL'),
       ('NW_PLAYER_CAN_SEE_OIL', 'REQUIREMENTSET_TEST_ALL'),
       ('NW_PLAYER_CAN_SEE_URANIUM', 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('NW_PLAYER_CAN_SEE_HORSES', 'REQUIRES_PLAYER_CAN_SEE_HORSES'),
       ('NW_PLAYER_CAN_SEE_IRON', 'REQUIRES_PLAYER_CAN_SEE_IRON'),
       ('NW_PLAYER_CAN_SEE_NITER', 'REQUIRES_PLAYER_CAN_SEE_NITER'),
       ('NW_PLAYER_CAN_SEE_COAL', 'REQUIRES_PLAYER_CAN_SEE_COAL'),
       ('NW_PLAYER_CAN_SEE_ALUMINUM', 'REQUIRES_PLAYER_CAN_SEE_ALUMINUM'),
       ('NW_PLAYER_CAN_SEE_OIL', 'REQUIRES_PLAYER_CAN_SEE_OIL'),
       ('NW_PLAYER_CAN_SEE_URANIUM', 'REQUIRES_PLAYER_CAN_SEE_URANIUM');

-- 游戏所处时代
INSERT OR IGNORE INTO Requirements(RequirementId, RequirementType)
SELECT 'NW_GAME_IS_IN_' || EraType || '_REQUIREMENT', 'REQUIREMENT_GAME_ERA_IS'
FROM Eras;
INSERT OR IGNORE INTO RequirementArguments(RequirementId, Name, Value)
SELECT 'NW_GAME_IS_IN_' || EraType || '_REQUIREMENT', 'EraType', EraType
FROM Eras;
INSERT OR IGNORE INTO RequirementSets(RequirementSetId, RequirementSetType)
SELECT 'NW_GAME_IS_IN_' || EraType, 'REQUIREMENTSET_TEST_ALL'
FROM Eras;
INSERT OR IGNORE INTO RequirementSetRequirements(RequirementSetId, RequirementId)
SELECT 'NW_GAME_IS_IN_' || EraType, 'NW_GAME_IS_IN_' || EraType || '_REQUIREMENT'
FROM Eras;

-- 玩家所处某某时代及之后
INSERT OR IGNORE INTO Requirements(RequirementId, RequirementType)
SELECT 'NW_PLAYER_IS_IN_' || EraType || '_REQUIREMENT', 'REQUIREMENT_PLAYER_ERA_AT_LEAST'
FROM Eras;
INSERT OR IGNORE INTO RequirementArguments(RequirementId, Name, Value)
SELECT 'NW_PLAYER_IS_IN_' || EraType || '_REQUIREMENT', 'EraType', EraType
FROM Eras;
INSERT OR IGNORE INTO RequirementSets(RequirementSetId, RequirementSetType)
SELECT 'NW_PLAYER_IS_IN_' || EraType, 'REQUIREMENTSET_TEST_ALL'
FROM Eras;
INSERT OR IGNORE INTO RequirementSetRequirements(RequirementSetId, RequirementId)
SELECT 'NW_PLAYER_IS_IN_' || EraType, 'NW_PLAYER_IS_IN_' || EraType || '_REQUIREMENT'
FROM Eras;


-- 玩家所处某某时代之前
INSERT OR IGNORE INTO Requirements(RequirementId, RequirementType, Inverse)
SELECT 'NW_PLAYER_IS_NOT_IN_' || EraType || '_REQUIREMENT', 'REQUIREMENT_PLAYER_ERA_AT_LEAST', 1
FROM Eras;
INSERT OR IGNORE INTO RequirementArguments(RequirementId, Name, Value)
SELECT 'NW_PLAYER_IS_NOT_IN_' || EraType || '_REQUIREMENT', 'EraType', EraType
FROM Eras;
INSERT OR IGNORE INTO RequirementSets(RequirementSetId, RequirementSetType)
SELECT 'NW_PLAYER_IS_NOT_IN_' || EraType, 'REQUIREMENTSET_TEST_ALL'
FROM Eras;
INSERT OR IGNORE INTO RequirementSetRequirements(RequirementSetId, RequirementId)
SELECT 'NW_PLAYER_IS_NOT_IN_' || EraType, 'NW_PLAYER_IS_NOT_IN_' || EraType || '_REQUIREMENT'
FROM Eras;


-- 单位在丘陵上
INSERT OR IGNORE INTO RequirementSets
VALUES ('NW_UNIT_ON_HILL_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements
VALUES ('NW_UNIT_ON_HILL_REQUIREMENTS', 'PLOT_IS_HILLS_REQUIREMENT');

-- 单元格有加成资源
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
VALUES ('NW_REQUIRES_PLOT_HAS_IMPROVED_BONUS', 'REQUIREMENT_PLOT_IMPROVED_RESOURCE_CLASS_TYPE_MATCHES');
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('NW_REQUIRES_PLOT_HAS_IMPROVED_BONUS', 'ResourceClassType', 'RESOURCECLASS_BONUS');

-- 单元格有奢侈资源
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
VALUES ('NW_REQUIRES_PLOT_HAS_IMPROVED_LUXURY', 'REQUIREMENT_PLOT_IMPROVED_RESOURCE_CLASS_TYPE_MATCHES');
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('NW_REQUIRES_PLOT_HAS_IMPROVED_LUXURY', 'ResourceClassType', 'RESOURCECLASS_LUXURY');

-- 单元格被改良
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
VALUES ('NW_TILE_HAS_ANY_IMPROVEMENT', 'REQUIREMENT_PLOT_HAS_ANY_IMPROVEMENT');

--modifier types
INSERT OR IGNORE INTO Types(Type, Kind)
VALUES ('MODIFIER_SINGLE_PLAYER_ATTACH_MODIFIER', 'KIND_MODIFIER'),
       ('MODIFIER_PLAYER_DISTRICTS_ATTACH_MODIFIER', 'KIND_MODIFIER');
INSERT OR IGNORE INTO DynamicModifiers(ModifierType, CollectionType, EffectType)
VALUES ('MODIFIER_SINGLE_PLAYER_ATTACH_MODIFIER', 'COLLECTION_OWNER', 'EFFECT_ATTACH_MODIFIER'),
       ('MODIFIER_PLAYER_DISTRICTS_ATTACH_MODIFIER', 'COLLECTION_PLAYER_DISTRICTS', 'EFFECT_ATTACH_MODIFIER');


-- 玩家是某类城邦的宗主国
INSERT OR IGNORE INTO Requirements(RequirementId, RequirementType)
SELECT 'NW_PLAYER_IS_SUZERAIN_OF_' || LeaderType, 'REQUIREMENT_PLAYER_IS_SUZERAIN_OF_X'
FROM Leaders
WHERE InheritFrom IN
      ('LEADER_MINOR_CIV_CULTURAL', 'LEADER_MINOR_CIV_INDUSTRIAL', 'LEADER_MINOR_CIV_MILITARISTIC',
       'LEADER_MINOR_CIV_RELIGIOUS', 'LEADER_MINOR_CIV_SCIENTIFIC', 'LEADER_MINOR_CIV_TRADE');

INSERT OR IGNORE INTO RequirementArguments(RequirementId, Name, Type, Value)
SELECT 'NW_PLAYER_IS_SUZERAIN_OF_' || LeaderType, 'LeaderType', 'ARGTYPE_IDENTITY', LeaderType
FROM Leaders
WHERE InheritFrom IN
      ('LEADER_MINOR_CIV_CULTURAL', 'LEADER_MINOR_CIV_INDUSTRIAL', 'LEADER_MINOR_CIV_MILITARISTIC',
       'LEADER_MINOR_CIV_RELIGIOUS', 'LEADER_MINOR_CIV_SCIENTIFIC', 'LEADER_MINOR_CIV_TRADE');

INSERT OR IGNORE INTO RequirementSets(RequirementSetId, RequirementSetType)
SELECT 'NW_PLAYER_IS_SUZERAIN_OF_' || LeaderType || '_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL'
FROM Leaders
WHERE InheritFrom IN
      ('LEADER_MINOR_CIV_CULTURAL', 'LEADER_MINOR_CIV_INDUSTRIAL', 'LEADER_MINOR_CIV_MILITARISTIC',
       'LEADER_MINOR_CIV_RELIGIOUS', 'LEADER_MINOR_CIV_SCIENTIFIC', 'LEADER_MINOR_CIV_TRADE');

INSERT OR IGNORE INTO RequirementSetRequirements(RequirementSetId, RequirementId)
SELECT 'NW_PLAYER_IS_SUZERAIN_OF_' || LeaderType || '_REQUIREMENTS', 'NW_PLAYER_IS_SUZERAIN_OF_' || LeaderType
FROM Leaders
WHERE InheritFrom IN
      ('LEADER_MINOR_CIV_CULTURAL', 'LEADER_MINOR_CIV_INDUSTRIAL', 'LEADER_MINOR_CIV_MILITARISTIC',
       'LEADER_MINOR_CIV_RELIGIOUS', 'LEADER_MINOR_CIV_SCIENTIFIC', 'LEADER_MINOR_CIV_TRADE');


-- needed for players without nfp
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
VALUES ('REQUIRES_PLOT_HAS_GRASS_FLOODPLAINS', 'REQUIREMENT_PLOT_FEATURE_TYPE_MATCHES'),
       ('REQUIRES_PLOT_HAS_PLAINS_FLOODPLAINS', 'REQUIREMENT_PLOT_FEATURE_TYPE_MATCHES');
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('REQUIRES_PLOT_HAS_GRASS_FLOODPLAINS', 'FeatureType', 'FEATURE_FLOODPLAINS_GRASSLAND'),
       ('REQUIRES_PLOT_HAS_PLAINS_FLOODPLAINS', 'FeatureType', 'FEATURE_FLOODPLAINS_PLAINS');
