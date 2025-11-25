-- BUG修复：凯撒DLC未成功加载时
INSERT OR IGNORE INTO Types( Type, Kind )
VALUES ( 'TRAIT_LEADER_CAESAR', 'KIND_TRAIT' );
INSERT OR IGNORE INTO Traits( TraitType, Name, Description )
VALUES ( 'TRAIT_LEADER_CAESAR', 'LOC_TRAIT_LEADER_CAESAR_NAME', 'LOC_TRAIT_LEADER_CAESAR_DESCRIPTION' );

--============================================================
-- Lua Support
--============================================================
CREATE TABLE IF NOT EXISTS Nwflower_MOD_Traits
    (
        TraitType TEXT NOT NULL,
        PRIMARY KEY (TraitType),
        FOREIGN KEY (TraitType) REFERENCES Traits (TraitType) ON DELETE CASCADE ON UPDATE CASCADE
    );

INSERT OR IGNORE INTO Nwflower_MOD_Traits( TraitType )
SELECT TraitType
  FROM Traits
 WHERE Description IS NOT NULL;

INSERT OR IGNORE INTO TraitModifiers( TraitType, ModifierId )
SELECT TraitType, 'MODFEAT_TRAIT_PROPERTY_' || TraitType
  FROM Nwflower_MOD_Traits;

INSERT OR IGNORE INTO Modifiers( ModifierId, ModifierType )
SELECT 'MODFEAT_TRAIT_PROPERTY_' || TraitType, 'MODIFIER_PLAYER_ADJUST_PROPERTY'
  FROM Nwflower_MOD_Traits;

INSERT OR IGNORE INTO ModifierArguments( ModifierId, Name, Value )
SELECT 'MODFEAT_TRAIT_PROPERTY_' || TraitType, 'Key', 'PROPERTY_' || TraitType
  FROM Nwflower_MOD_Traits
 UNION
SELECT 'MODFEAT_TRAIT_PROPERTY_' || TraitType, 'Amount', 1
  FROM Nwflower_MOD_Traits;

--============================================================
-- RequirementSet
--============================================================
-- 条件集：城市拥有某区域
INSERT OR IGNORE INTO RequirementSets( RequirementSetId, RequirementSetType )
SELECT 'NW_CITY_HAS_' || DistrictType, 'REQUIREMENTSET_TEST_ALL'
  FROM Districts;
INSERT OR IGNORE INTO RequirementSetRequirements( RequirementSetId, RequirementId )
SELECT 'NW_CITY_HAS_' || DistrictType, 'NW_CITY_HAS_' || DistrictType || '_REQUIREMENT'
  FROM Districts;
INSERT OR IGNORE INTO Requirements( RequirementId, RequirementType )
SELECT 'NW_CITY_HAS_' || DistrictType || '_REQUIREMENT', 'REQUIREMENT_CITY_HAS_DISTRICT'
  FROM Districts;
INSERT OR IGNORE INTO RequirementArguments( RequirementId, Name, Value )
SELECT 'NW_CITY_HAS_' || DistrictType || '_REQUIREMENT', 'DistrictType', DistrictType
  FROM Districts;

-- 条件集：区域是任意专业化区域
INSERT OR IGNORE INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'NW_IS_SPECIALTY_DISTRICT', 'REQUIREMENTSET_TEST_ANY' );
INSERT OR IGNORE INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
SELECT 'NW_IS_SPECIALTY_DISTRICT', 'NW_DISTRICT_IS_' || DistrictType || '_REQUIREMENT'
  FROM Districts
 WHERE RequiresPopulation = 1;

-- 条件集：区域类型匹配
INSERT OR IGNORE INTO RequirementSets( RequirementSetId, RequirementSetType )
SELECT 'NW_DISTRICT_IS_' || DistrictType, 'REQUIREMENTSET_TEST_ALL'
  FROM Districts;
INSERT OR IGNORE INTO RequirementSetRequirements( RequirementSetId, RequirementId )
SELECT 'NW_DISTRICT_IS_' || DistrictType, 'NW_DISTRICT_IS_' || DistrictType || '_REQUIREMENT'
  FROM Districts;
INSERT OR IGNORE INTO Requirements( RequirementId, RequirementType )
SELECT 'NW_DISTRICT_IS_' || DistrictType || '_REQUIREMENT', 'REQUIREMENT_DISTRICT_TYPE_MATCHES'
  FROM Districts;
INSERT OR IGNORE INTO RequirementArguments( RequirementId, Name, Value )
SELECT 'NW_DISTRICT_IS_' || DistrictType || '_REQUIREMENT', 'DistrictType', DistrictType
  FROM Districts;


-- 城市拥有某改良资源
INSERT OR IGNORE INTO Requirements ( RequirementId, RequirementType )
SELECT 'NW_CITY_HAS_IMPROVED_' || Resources.ResourceType || '_REQ', 'REQUIREMENT_CITY_HAS_RESOURCE_TYPE_IMPROVED'
  FROM Resources
 WHERE NOT Resources.ResourceType = 'NW_DUMMY_RESOURCE_MACEDON';
INSERT OR IGNORE INTO RequirementArguments ( RequirementId, Name, Value )
SELECT 'NW_CITY_HAS_IMPROVED_' || Resources.ResourceType || '_REQ', 'ResourceType', Resources.ResourceType
  FROM Resources
 WHERE NOT Resources.ResourceType = 'NW_DUMMY_RESOURCE_MACEDON';

-- 城市拥有任意改良战略
INSERT OR IGNORE INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'NW_CITY_HAS_IMPROVED_STRAT_REQSET', 'REQUIREMENTSET_TEST_ANY' );
INSERT OR IGNORE INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
SELECT 'NW_CITY_HAS_IMPROVED_STRAT_REQSET', 'NW_CITY_HAS_IMPROVED_' || Resources.ResourceType || '_REQ'
  FROM Resources
 WHERE ResourceClassType = 'RESOURCECLASS_STRATEGIC';
-- 城市拥有任意改良加成
INSERT OR IGNORE INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'NW_CITY_HAS_IMPROVED_BONUS_REQSET', 'REQUIREMENTSET_TEST_ANY' );
INSERT OR IGNORE INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
SELECT 'NW_CITY_HAS_IMPROVED_BONUS_REQSET', 'NW_CITY_HAS_IMPROVED_' || Resources.ResourceType || '_REQ'
  FROM Resources
 WHERE ResourceClassType = 'RESOURCECLASS_BONUS';
-- 城市拥有任意改良奢侈
INSERT OR IGNORE INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'NW_CITY_HAS_IMPROVED_LUX_REQSET', 'REQUIREMENTSET_TEST_ANY' );
INSERT OR IGNORE INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
SELECT 'NW_CITY_HAS_IMPROVED_LUX_REQSET', 'NW_CITY_HAS_IMPROVED_' || Resources.ResourceType || '_REQ'
  FROM Resources
 WHERE ResourceClassType = 'RESOURCECLASS_LUXURY';

-- 玩家拥有某科技
INSERT OR IGNORE INTO RequirementSets( RequirementSetId, RequirementSetType )
SELECT 'NW_PLAYER_HAS_' || TechnologyType, 'REQUIREMENTSET_TEST_ALL'
  FROM Technologies;
INSERT OR IGNORE INTO Requirements( RequirementId, RequirementType )
SELECT 'NW_UTILS_PLAYER_HAS_' || TechnologyType || '_REQUIREMENT', 'REQUIREMENT_PLAYER_HAS_TECHNOLOGY'
  FROM Technologies;
INSERT OR IGNORE INTO RequirementArguments( RequirementId, Name, Value )
SELECT 'NW_UTILS_PLAYER_HAS_' || TechnologyType || '_REQUIREMENT', 'TechnologyType', TechnologyType
  FROM Technologies;
INSERT OR IGNORE INTO RequirementSetRequirements( RequirementSetId, RequirementId )
SELECT 'NW_PLAYER_HAS_' || TechnologyType, 'NW_UTILS_PLAYER_HAS_' || TechnologyType || '_REQUIREMENT'
  FROM Technologies;

-- 玩家拥有某市政
INSERT OR IGNORE INTO RequirementSets( RequirementSetId, RequirementSetType )
SELECT 'NW_PLAYER_HAS_' || CivicType, 'REQUIREMENTSET_TEST_ALL'
  FROM Civics;
INSERT OR IGNORE INTO Requirements( RequirementId, RequirementType )
SELECT 'NW_UTILS_PLAYER_HAS_' || CivicType || '_REQUIREMENT', 'REQUIREMENT_PLAYER_HAS_CIVIC'
  FROM Civics;
INSERT OR IGNORE INTO RequirementArguments( RequirementId, Name, Value )
SELECT 'NW_UTILS_PLAYER_HAS_' || CivicType || '_REQUIREMENT', 'CivicType', CivicType
  FROM Civics;
INSERT OR IGNORE INTO RequirementSetRequirements( RequirementSetId, RequirementId )
SELECT 'NW_PLAYER_HAS_' || CivicType, 'NW_UTILS_PLAYER_HAS_' || CivicType || '_REQUIREMENT'
  FROM Civics;


-- 玩家拥有某建筑
INSERT OR IGNORE INTO RequirementSets ( RequirementSetId, RequirementSetType )
SELECT 'NW_PLAYER_HAS_' || BuildingType, 'REQUIREMENTSET_TEST_ALL'
  FROM Buildings;
INSERT OR IGNORE INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
SELECT 'NW_PLAYER_HAS_' || BuildingType, 'REQ_NW_PLAYER_HAS_' || BuildingType
  FROM Buildings;
INSERT OR IGNORE INTO Requirements ( RequirementId, RequirementType )
SELECT 'REQ_NW_PLAYER_HAS_' || BuildingType, 'REQUIREMENT_PLAYER_HAS_BUILDING'
  FROM Buildings;
INSERT OR IGNORE INTO RequirementArguments ( RequirementId, Name, Value )
SELECT 'REQ_NW_PLAYER_HAS_' || BuildingType, 'BuildingType', BuildingType
  FROM Buildings;

-- 城市拥有某建筑
INSERT OR IGNORE INTO RequirementSets ( RequirementSetId, RequirementSetType )
SELECT 'NW_CITY_HAS_' || BuildingType, 'REQUIREMENTSET_TEST_ALL'
  FROM Buildings;
INSERT OR IGNORE INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
SELECT 'NW_CITY_HAS_' || BuildingType, 'REQ_NW_CITY_HAS_' || BuildingType
  FROM Buildings;
INSERT OR IGNORE INTO Requirements ( RequirementId, RequirementType )
SELECT 'REQ_NW_CITY_HAS_' || BuildingType, 'REQUIREMENT_CITY_HAS_BUILDING'
  FROM Buildings;
INSERT OR IGNORE INTO RequirementArguments ( RequirementId, Name, Value )
SELECT 'REQ_NW_CITY_HAS_' || BuildingType, 'BuildingType', BuildingType
  FROM Buildings;

-- 玩家是某指定领袖
INSERT OR IGNORE INTO RequirementSets( RequirementSetId, RequirementSetType )
SELECT 'NW_PLAYER_IS_' || LeaderType, 'REQUIREMENTSET_TEST_ANY'
  FROM Leaders
 WHERE InheritFrom = 'LEADER_DEFAULT';
INSERT OR IGNORE INTO RequirementSetRequirements( RequirementSetId, RequirementId )
SELECT 'NW_PLAYER_IS_' || LeaderType, 'NW_PLAYER_IS_' || LeaderType || '_REQUIREMENT'
  FROM Leaders
 WHERE InheritFrom = 'LEADER_DEFAULT';
INSERT OR IGNORE INTO Requirements( RequirementId, RequirementType )
SELECT 'NW_PLAYER_IS_' || LeaderType || '_REQUIREMENT', 'REQUIREMENT_PLAYER_LEADER_TYPE_MATCHES'
  FROM Leaders
 WHERE InheritFrom = 'LEADER_DEFAULT';
INSERT OR IGNORE INTO RequirementArguments( RequirementId, Name, Value )
SELECT 'NW_PLAYER_IS_' || LeaderType || '_REQUIREMENT', 'LeaderType', LeaderType
  FROM Leaders
 WHERE InheritFrom = 'LEADER_DEFAULT';

-- 玩家可见某资源
INSERT OR IGNORE INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'NW_PLAYER_CAN_SEE_HORSES', 'REQUIREMENTSET_TEST_ALL' ),
       ( 'NW_PLAYER_CAN_SEE_IRON', 'REQUIREMENTSET_TEST_ALL' ),
       ( 'NW_PLAYER_CAN_SEE_NITER', 'REQUIREMENTSET_TEST_ALL' ),
       ( 'NW_PLAYER_CAN_SEE_COAL', 'REQUIREMENTSET_TEST_ALL' ),
       ( 'NW_PLAYER_CAN_SEE_ALUMINUM', 'REQUIREMENTSET_TEST_ALL' ),
       ( 'NW_PLAYER_CAN_SEE_OIL', 'REQUIREMENTSET_TEST_ALL' ),
       ( 'NW_PLAYER_CAN_SEE_URANIUM', 'REQUIREMENTSET_TEST_ALL' );
INSERT OR IGNORE INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'NW_PLAYER_CAN_SEE_HORSES', 'REQUIRES_PLAYER_CAN_SEE_HORSES' ),
       ( 'NW_PLAYER_CAN_SEE_IRON', 'REQUIRES_PLAYER_CAN_SEE_IRON' ),
       ( 'NW_PLAYER_CAN_SEE_NITER', 'REQUIRES_PLAYER_CAN_SEE_NITER' ),
       ( 'NW_PLAYER_CAN_SEE_COAL', 'REQUIRES_PLAYER_CAN_SEE_COAL' ),
       ( 'NW_PLAYER_CAN_SEE_ALUMINUM', 'REQUIRES_PLAYER_CAN_SEE_ALUMINUM' ),
       ( 'NW_PLAYER_CAN_SEE_OIL', 'REQUIRES_PLAYER_CAN_SEE_OIL' ),
       ( 'NW_PLAYER_CAN_SEE_URANIUM', 'REQUIRES_PLAYER_CAN_SEE_URANIUM' );

-- 游戏所处时代
INSERT OR IGNORE INTO Requirements( RequirementId, RequirementType )
SELECT 'NW_GAME_IS_IN_' || EraType || '_REQUIREMENT', 'REQUIREMENT_GAME_ERA_IS'
  FROM Eras;
INSERT OR IGNORE INTO RequirementArguments( RequirementId, Name, Value )
SELECT 'NW_GAME_IS_IN_' || EraType || '_REQUIREMENT', 'EraType', EraType
  FROM Eras;
INSERT OR IGNORE INTO RequirementSets( RequirementSetId, RequirementSetType )
SELECT 'NW_GAME_IS_IN_' || EraType, 'REQUIREMENTSET_TEST_ALL'
  FROM Eras;
INSERT OR IGNORE INTO RequirementSetRequirements( RequirementSetId, RequirementId )
SELECT 'NW_GAME_IS_IN_' || EraType, 'NW_GAME_IS_IN_' || EraType || '_REQUIREMENT'
  FROM Eras;

-- 玩家所处某某时代及之后
INSERT OR IGNORE INTO Requirements( RequirementId, RequirementType )
SELECT 'NW_PLAYER_IS_IN_' || EraType || '_REQUIREMENT', 'REQUIREMENT_PLAYER_ERA_AT_LEAST'
  FROM Eras;
INSERT OR IGNORE INTO RequirementArguments( RequirementId, Name, Value )
SELECT 'NW_PLAYER_IS_IN_' || EraType || '_REQUIREMENT', 'EraType', EraType
  FROM Eras;
INSERT OR IGNORE INTO RequirementSets( RequirementSetId, RequirementSetType )
SELECT 'NW_PLAYER_IS_IN_' || EraType, 'REQUIREMENTSET_TEST_ALL'
  FROM Eras;
INSERT OR IGNORE INTO RequirementSetRequirements( RequirementSetId, RequirementId )
SELECT 'NW_PLAYER_IS_IN_' || EraType, 'NW_PLAYER_IS_IN_' || EraType || '_REQUIREMENT'
  FROM Eras;

-- 玩家所处某某时代之前
INSERT OR IGNORE INTO Requirements( RequirementId, RequirementType, Inverse )
SELECT 'NW_PLAYER_IS_NOT_IN_' || EraType || '_REQUIREMENT', 'REQUIREMENT_PLAYER_ERA_AT_LEAST', 1
  FROM Eras;
INSERT OR IGNORE INTO RequirementArguments( RequirementId, Name, Value )
SELECT 'NW_PLAYER_IS_NOT_IN_' || EraType || '_REQUIREMENT', 'EraType', EraType
  FROM Eras;
INSERT OR IGNORE INTO RequirementSets( RequirementSetId, RequirementSetType )
SELECT 'NW_PLAYER_IS_NOT_IN_' || EraType, 'REQUIREMENTSET_TEST_ALL'
  FROM Eras;
INSERT OR IGNORE INTO RequirementSetRequirements( RequirementSetId, RequirementId )
SELECT 'NW_PLAYER_IS_NOT_IN_' || EraType, 'NW_PLAYER_IS_NOT_IN_' || EraType || '_REQUIREMENT'
  FROM Eras;

-- 单位在丘陵上
INSERT OR IGNORE INTO RequirementSets
VALUES ( 'NW_UNIT_ON_HILL_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL' );
INSERT OR IGNORE INTO RequirementSetRequirements
VALUES ( 'NW_UNIT_ON_HILL_REQUIREMENTS', 'PLOT_IS_HILLS_REQUIREMENT' );

-- 单元格有加成资源
INSERT OR IGNORE INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'NW_REQUIRES_PLOT_HAS_IMPROVED_BONUS', 'REQUIREMENT_PLOT_IMPROVED_RESOURCE_CLASS_TYPE_MATCHES' );
INSERT OR IGNORE INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'NW_REQUIRES_PLOT_HAS_IMPROVED_BONUS', 'ResourceClassType', 'RESOURCECLASS_BONUS' );

-- 单元格有奢侈资源
INSERT OR IGNORE INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'NW_REQUIRES_PLOT_HAS_IMPROVED_LUXURY', 'REQUIREMENT_PLOT_IMPROVED_RESOURCE_CLASS_TYPE_MATCHES' );
INSERT OR IGNORE INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'NW_REQUIRES_PLOT_HAS_IMPROVED_LUXURY', 'ResourceClassType', 'RESOURCECLASS_LUXURY' );

-- 单元格被改良
INSERT OR IGNORE INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'NW_TILE_HAS_ANY_IMPROVEMENT', 'REQUIREMENT_PLOT_HAS_ANY_IMPROVEMENT' );

-- 玩家拥有已改良的奢侈资源
INSERT OR IGNORE INTO RequirementSets ( RequirementSetId, RequirementSetType )
SELECT 'NW_PLAYER_HAS_IMPROVED_' || ResourceType, 'REQUIREMENTSET_TEST_ALL'
  FROM Resources
 WHERE ResourceClassType = 'RESOURCECLASS_LUXURY';
INSERT OR IGNORE INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
SELECT 'NW_PLAYER_HAS_IMPROVED_' || ResourceType, 'REQUIREMENT_NW_PLAYER_HAS_IMPROVED_' || ResourceType
  FROM Resources
 WHERE ResourceClassType = 'RESOURCECLASS_LUXURY';
INSERT OR IGNORE INTO Requirements ( RequirementId, RequirementType )
SELECT 'REQUIREMENT_NW_PLAYER_HAS_IMPROVED_' || ResourceType, 'REQUIREMENT_PLAYER_HAS_RESOURCE_IMPROVED'
  FROM Resources
 WHERE ResourceClassType = 'RESOURCECLASS_LUXURY';
INSERT OR IGNORE INTO RequirementArguments ( RequirementId, Name, Value )
SELECT 'REQUIREMENT_NW_PLAYER_HAS_IMPROVED_' || ResourceType, 'ResourceType', ResourceType
  FROM Resources
 WHERE ResourceClassType = 'RESOURCECLASS_LUXURY';

--MODIFIER TYPES
INSERT OR IGNORE INTO Types( Type, Kind )
VALUES ( 'MODIFIER_SINGLE_PLAYER_ATTACH_MODIFIER', 'KIND_MODIFIER' ),
       ( 'MODIFIER_PLAYER_DISTRICTS_ATTACH_MODIFIER', 'KIND_MODIFIER' );
INSERT OR IGNORE INTO DynamicModifiers( ModifierType, CollectionType, EffectType )
VALUES ( 'MODIFIER_SINGLE_PLAYER_ATTACH_MODIFIER', 'COLLECTION_OWNER', 'EFFECT_ATTACH_MODIFIER' ),
       ( 'MODIFIER_PLAYER_DISTRICTS_ATTACH_MODIFIER', 'COLLECTION_PLAYER_DISTRICTS', 'EFFECT_ATTACH_MODIFIER' );

-- 单元格相邻地形匹配
INSERT OR IGNORE INTO Requirements ( RequirementId, RequirementType )
SELECT 'REQUIREMENT_NW_PLOT_ADJACENT_' || TerrainType, 'REQUIREMENT_PLOT_ADJACENT_TERRAIN_TYPE_MATCHES'
  FROM Terrains;
INSERT OR IGNORE INTO RequirementArguments ( RequirementId, Name, Value )
SELECT 'REQUIREMENT_NW_PLOT_ADJACENT_' || TerrainType, 'TerrainType', TerrainType
  FROM Terrains
 UNION
SELECT 'REQUIREMENT_NW_PLOT_ADJACENT_' || TerrainType, 'MinRange', 1
  FROM Terrains
 UNION
SELECT 'REQUIREMENT_NW_PLOT_ADJACENT_' || TerrainType, 'MaxRange', 1
  FROM Terrains;

-- 玩家的宗教拥有某信条
INSERT OR IGNORE INTO RequirementSets ( RequirementSetId, RequirementSetType )
SELECT DISTINCT 'NW_RELIGION_HAS_' || BeliefClassType, 'REQUIREMENTSET_TEST_ANY'
  FROM Beliefs;
INSERT OR IGNORE INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
SELECT 'NW_RELIGION_HAS_' || BeliefClassType, 'REQUIRES_NW_RELIGION_HAS_' || BeliefType
  FROM Beliefs;
INSERT OR IGNORE INTO Requirements ( RequirementId, RequirementType )
SELECT 'REQUIRES_NW_RELIGION_HAS_' || BeliefType, 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF'
  FROM Beliefs;
INSERT OR IGNORE INTO RequirementArguments ( RequirementId, Name, Value )
SELECT 'REQUIRES_NW_RELIGION_HAS_' || BeliefType, 'BeliefType', 'BELIEF_CHURCH_PROPERTY'
  FROM Beliefs;

-- 单位是某类伟人
INSERT OR IGNORE INTO RequirementSets ( RequirementSetId, RequirementSetType )
SELECT 'NW_REQS_UNIT_IS_' || GreatPersonClassType, 'REQUIREMENTSET_TEST_ALL'
  FROM GreatPersonClasses;
INSERT OR IGNORE INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
SELECT 'NW_REQS_UNIT_IS_' || GreatPersonClassType, 'NW_REQ_UNIT_IS_' || GreatPersonClassType
  FROM GreatPersonClasses;
INSERT OR IGNORE INTO Requirements ( RequirementId, RequirementType )
SELECT 'NW_REQ_UNIT_IS_' || GreatPersonClassType, 'REQUIREMENT_GREAT_PERSON_TYPE_MATCHES'
  FROM GreatPersonClasses;
INSERT OR IGNORE INTO RequirementArguments ( RequirementId, Name, Value )
SELECT 'NW_REQ_UNIT_IS_' || GreatPersonClassType, 'GreatPersonClassType', GreatPersonClassType
  FROM GreatPersonClasses;


-- 玩家是某类城邦的宗主国
INSERT OR IGNORE INTO Requirements( RequirementId, RequirementType )
SELECT 'NW_PLAYER_IS_SUZERAIN_OF_' || LeaderType, 'REQUIREMENT_PLAYER_IS_SUZERAIN_OF_X'
  FROM Leaders
 WHERE InheritFrom IN ('LEADER_MINOR_CIV_CULTURAL', 'LEADER_MINOR_CIV_INDUSTRIAL', 'LEADER_MINOR_CIV_MILITARISTIC',
                       'LEADER_MINOR_CIV_RELIGIOUS', 'LEADER_MINOR_CIV_SCIENTIFIC', 'LEADER_MINOR_CIV_TRADE');

INSERT OR IGNORE INTO RequirementArguments( RequirementId, Name, Type, Value )
SELECT 'NW_PLAYER_IS_SUZERAIN_OF_' || LeaderType, 'LeaderType', 'ARGTYPE_IDENTITY', LeaderType
  FROM Leaders
 WHERE InheritFrom IN ('LEADER_MINOR_CIV_CULTURAL', 'LEADER_MINOR_CIV_INDUSTRIAL', 'LEADER_MINOR_CIV_MILITARISTIC',
                       'LEADER_MINOR_CIV_RELIGIOUS', 'LEADER_MINOR_CIV_SCIENTIFIC', 'LEADER_MINOR_CIV_TRADE');

INSERT OR IGNORE INTO RequirementSets( RequirementSetId, RequirementSetType )
SELECT 'NW_PLAYER_IS_SUZERAIN_OF_' || LeaderType || '_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL'
  FROM Leaders
 WHERE InheritFrom IN ('LEADER_MINOR_CIV_CULTURAL', 'LEADER_MINOR_CIV_INDUSTRIAL', 'LEADER_MINOR_CIV_MILITARISTIC',
                       'LEADER_MINOR_CIV_RELIGIOUS', 'LEADER_MINOR_CIV_SCIENTIFIC', 'LEADER_MINOR_CIV_TRADE');

INSERT OR IGNORE INTO RequirementSetRequirements( RequirementSetId, RequirementId )
SELECT 'NW_PLAYER_IS_SUZERAIN_OF_' || LeaderType || '_REQUIREMENTS', 'NW_PLAYER_IS_SUZERAIN_OF_' || LeaderType
  FROM Leaders
 WHERE InheritFrom IN ('LEADER_MINOR_CIV_CULTURAL', 'LEADER_MINOR_CIV_INDUSTRIAL', 'LEADER_MINOR_CIV_MILITARISTIC',
                       'LEADER_MINOR_CIV_RELIGIOUS', 'LEADER_MINOR_CIV_SCIENTIFIC', 'LEADER_MINOR_CIV_TRADE');


-- needed for players without nfp
INSERT OR IGNORE INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'REQUIRES_PLOT_HAS_GRASS_FLOODPLAINS', 'REQUIREMENT_PLOT_FEATURE_TYPE_MATCHES' ),
       ( 'REQUIRES_PLOT_HAS_PLAINS_FLOODPLAINS', 'REQUIREMENT_PLOT_FEATURE_TYPE_MATCHES' );
INSERT OR IGNORE INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'REQUIRES_PLOT_HAS_GRASS_FLOODPLAINS', 'FeatureType', 'FEATURE_FLOODPLAINS_GRASSLAND' ),
       ( 'REQUIRES_PLOT_HAS_PLAINS_FLOODPLAINS', 'FeatureType', 'FEATURE_FLOODPLAINS_PLAINS' );


CREATE TEMPORARY TABLE IF NOT EXISTS temp_numbers
    (
        number INT NOT NULL,
        PRIMARY KEY (number)
    );
INSERT INTO temp_numbers ( number )
  WITH x AS (SELECT 1 AS id UNION ALL SELECT id + 1 AS id FROM x WHERE id <= 6)
SELECT *
  FROM x;

INSERT OR IGNORE INTO RequirementSets ( RequirementSetId, RequirementSetType )
SELECT 'NW_OWNER_' || number || '_PLOTS_AWAY', 'REQUIREMENTSET_TEST_ALL'
  FROM temp_numbers
 WHERE number < 6;
INSERT OR IGNORE INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
SELECT 'NW_OWNER_' || number || '_PLOTS_AWAY', 'REQUIREMENT_NW_OWNER_' || number || '_PLOTS_AWAY'
  FROM temp_numbers
 WHERE number < 6;
-- Requirements
INSERT OR IGNORE INTO Requirements ( RequirementId, RequirementType )
SELECT 'REQUIREMENT_NW_OWNER_' || number || '_PLOTS_AWAY', 'REQUIREMENT_PLOT_ADJACENT_TO_OWNER'
  FROM temp_numbers
 WHERE number < 6;
INSERT OR IGNORE INTO RequirementArguments ( RequirementId, Name, Value )
SELECT 'REQUIREMENT_NW_OWNER_' || number || '_PLOTS_AWAY', 'MaxDistance', number
  FROM temp_numbers
 WHERE number < 6
 UNION
SELECT 'REQUIREMENT_NW_OWNER_' || number || '_PLOTS_AWAY', 'MinDistance', number
  FROM temp_numbers
 WHERE number < 6;

--============================================================
-- Civilizations
--============================================================
-- =============================================================
-- AMERICA	美国

-- 美国 外交支持
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_FOUNDING_FATHERS' AND ModifierId = 'TRAIT_WILD_CARD_FAVOR';

-- 文美
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_ANTIQUES_AND_PARKS' AND
     ModifierId IN ('TRAIT_ANTIQUES_AND_PARKS_CULTURE_FORESTS_OR_WONDERS',
                    'TRAIT_ANTIQUES_AND_PARKS_SCIENCE_NATIONAL_WONDERS_OR_MOUNTAINS');

-- 惊艳未改良+1科技值
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_ANTIQUES_AND_PARKS', 'MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_ADJUST_PLOT_YIELD' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_ADJUST_PLOT_YIELD', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 0, 0, 0,
         'NW_PLAYER_HAS_CIVIC_MYSTICISM', 'NW_PLOT_IS_BREATHTAKING' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_ADJUST_PLOT_YIELD', 'Amount', '1,1' ),
       ( 'MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_ADJUST_PLOT_YIELD', 'YieldType', 'YIELD_SCIENCE,YIELD_GOLD' );

-- 惊艳单元格
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'NW_PLOT_IS_BREATHTAKING', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'NW_PLOT_IS_BREATHTAKING', 'REQUIREMENT_NW_PLOT_IS_BREATHTAKING' ),
       ( 'NW_PLOT_IS_BREATHTAKING', 'REQUIREMENT_NW_PLOT_IS_UNIMPROVED' );
INSERT INTO Requirements ( RequirementId, RequirementType, Inverse )
VALUES ( 'REQUIREMENT_NW_PLOT_IS_UNIMPROVED', 'REQUIREMENT_PLOT_HAS_ANY_IMPROVEMENT', 1 ),
       ( 'REQUIREMENT_NW_PLOT_IS_BREATHTAKING', 'REQUIREMENT_PLOT_IS_APPEAL_BETWEEN', 0 );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'REQUIREMENT_NW_PLOT_IS_BREATHTAKING', 'MinimumAppeal', '4' );


-- 单元格相邻任意山脉
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'NW_PLOT_ADJACENT_ANY_MOUNTAIN', 'REQUIREMENTSET_TEST_ANY' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
SELECT 'NW_PLOT_ADJACENT_ANY_MOUNTAIN', 'REQUIREMENT_NW_PLOT_ADJACENT_' || TerrainType
  FROM Terrains
 WHERE Mountain = 1;

-- 保护区赠送自然学家
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_ANTIQUES_AND_PARKS', 'MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_GRANT_UNIT' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_GRANT_UNIT', 'MODIFIER_PLAYER_GRANT_UNIT_IN_CAPITAL', 0, 0, 0,
         'NW_PLAYER_HAS_DISTRICT_PRESERVE', NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_GRANT_UNIT', 'AllowUniqueOverride', '1' ),
       ( 'MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_GRANT_UNIT', 'Amount', '1' ),
       ( 'MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_GRANT_UNIT', 'UnitType', 'UNIT_NATURALIST' );

-- RequirementSets
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'NW_PLAYER_HAS_DISTRICT_PRESERVE', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'NW_PLAYER_HAS_DISTRICT_PRESERVE', 'REQ_NW_PLAYER_HAS_DISTRICT_PRESERVE' );
-- Requirements
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'REQ_NW_PLAYER_HAS_DISTRICT_PRESERVE', 'REQUIREMENT_PLAYER_HAS_DISTRICT' );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'REQ_NW_PLAYER_HAS_DISTRICT_PRESERVE', 'DistrictType', 'DISTRICT_PRESERVE' );


INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_ANTIQUES_AND_PARKS', 'MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_FEATURE_UNLOCK_NW' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_FEATURE_UNLOCK_NW', 'MODIFIER_PLAYER_ADJUST_FEATURE_UNLOCK', 0, 0, 0,
         NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_FEATURE_UNLOCK_NW', 'FeatureType', 'FEATURE_FOREST' ),
       ( 'MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_FEATURE_UNLOCK_NW', 'CivicType', 'CIVIC_MYSTICISM' );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_ANTIQUES_AND_PARKS', 'MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_BUILDER_ABILITY' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_BUILDER_ABILITY', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 0, 0, 0,
         'REQS_NW_PLAYER_HAS_NOT_CIVIC_CONSERVATION', NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_BUILDER_ABILITY', 'AbilityType',
         'ABILITY_NW_CANNOT_PLANT_FOREST_BUT_ADJACENT_PRESERVE' );

-- 如果建造者不相邻保护区，则禁止人工林（保护地球前）
INSERT INTO Types ( Type, Kind )
VALUES ( 'ABILITY_NW_CANNOT_PLANT_FOREST_BUT_ADJACENT_PRESERVE', 'KIND_ABILITY' );
INSERT INTO TypeTags ( Type, Tag )
VALUES ( 'ABILITY_NW_CANNOT_PLANT_FOREST_BUT_ADJACENT_PRESERVE', 'CLASS_BUILDER' );
INSERT INTO UnitAbilities ( UnitAbilityType, Name, Inactive, Description )
VALUES ( 'ABILITY_NW_CANNOT_PLANT_FOREST_BUT_ADJACENT_PRESERVE', 'LOC_TRAIT_LEADER_ANTIQUES_AND_PARKS_NAME', 1,
         'LOC_ABILITY_NW_CANNOT_PLANT_FOREST_BUT_ADJACENT_PRESERVE_DESCRIPTION' );

INSERT INTO UnitAbilityModifiers ( UnitAbilityType, ModifierId )
VALUES ( 'ABILITY_NW_CANNOT_PLANT_FOREST_BUT_ADJACENT_PRESERVE', 'MODFEAT_NW_WENMEI_BUILDER_DISABLE_PLANT_FOREST' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODFEAT_NW_WENMEI_BUILDER_DISABLE_PLANT_FOREST', 'MODTYPE_NW_WENMEI_BUILDER_DISABLE_OPERATION', 0, 0, 0, NULL,
         'REQS_NW_UNIT_NOT_ADJACENT_PRESERVE' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODFEAT_NW_WENMEI_BUILDER_DISABLE_PLANT_FOREST', 'OperationType', 'UNITOPERATION_PLANT_FOREST' ),
       ( 'MODFEAT_NW_WENMEI_BUILDER_DISABLE_PLANT_FOREST', 'Available', '0' );

INSERT INTO Types ( Type, Kind )
VALUES ( 'MODTYPE_NW_WENMEI_BUILDER_DISABLE_OPERATION', 'KIND_MODIFIER' );
INSERT INTO DynamicModifiers ( ModifierType, CollectionType, EffectType )
VALUES ( 'MODTYPE_NW_WENMEI_BUILDER_DISABLE_OPERATION', 'COLLECTION_OWNER', 'EFFECT_CHANGE_UNIT_OPERATION_AVAILABILITY' );


-- RequirementSets
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'REQS_NW_PLAYER_HAS_NOT_CIVIC_CONSERVATION', 'REQUIREMENTSET_TEST_ALL' ),
       ( 'REQS_NW_UNIT_NOT_ADJACENT_PRESERVE', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'REQS_NW_PLAYER_HAS_NOT_CIVIC_CONSERVATION', 'REQ_NW_PLAYER_HAS_NOT_CIVIC_CONSERVATION' ),
       ( 'REQS_NW_UNIT_NOT_ADJACENT_PRESERVE', 'REQ_NW_UNIT_NOT_ADJACENT_PRESERVE' );
-- Requirements
INSERT INTO Requirements ( RequirementId, RequirementType, Inverse )
VALUES ( 'REQ_NW_PLAYER_HAS_NOT_CIVIC_CONSERVATION', 'REQUIREMENT_PLAYER_HAS_CIVIC', 1 ),
       ( 'REQ_NW_UNIT_NOT_ADJACENT_PRESERVE', 'REQUIREMENT_PLOT_ADJACENT_DISTRICT_TYPE_MATCHES', 1 );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'REQ_NW_PLAYER_HAS_NOT_CIVIC_CONSERVATION', 'CivicType', 'CIVIC_CONSERVATION' ),
       ( 'REQ_NW_UNIT_NOT_ADJACENT_PRESERVE', 'DistrictType', 'DISTRICT_PRESERVE' ),
       ( 'REQ_NW_UNIT_NOT_ADJACENT_PRESERVE', 'MaxRange', '1' ),
       ( 'REQ_NW_UNIT_NOT_ADJACENT_PRESERVE', 'MinRange', '1' );
----------------------------------------------------------------------------------
-- 武美
-- 通配卡
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_ROOSEVELT_COROLLARY', 'TRAIT_WILDCARD_GOVERNMENT_SLOT_ROOSEVELT' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'TRAIT_WILDCARD_GOVERNMENT_SLOT_ROOSEVELT', 'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER',
         'NW_PLAYER_HAS_CIVIC_HUMANISM' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_WILDCARD_GOVERNMENT_SLOT_ROOSEVELT', 'GovernmentSlotType', 'SLOT_WILDCARD' );

UPDATE ModifierArguments
   SET Name = 'Key', Value = 'ROOSEVELT_COMBAT_BONUS_HOME_CONTINENT'
 WHERE ModifierId = 'ROOSEVELT_COMBAT_BONUS_HOME_CONTINENT' AND Name = 'Amount';


INSERT INTO Types ( Type, Kind )
VALUES ( 'MODIFIER_NW_PLAYER_UNITS_ADJUST_PROPERTY', 'KIND_MODIFIER' );
INSERT INTO DynamicModifiers ( ModifierType, CollectionType, EffectType )
VALUES ( 'MODIFIER_NW_PLAYER_UNITS_ADJUST_PROPERTY', 'COLLECTION_PLAYER_UNITS', 'EFFECT_ADJUST_UNIT_PROPERTY' );


INSERT INTO Modifiers ( ModifierId, ModifierType )
VALUES ( 'MODIFIER_TRAIT_LEADER_ROOSEVELT_COROLLARY_ADD_JUST_PROPERTY', 'MODIFIER_NW_PLAYER_UNITS_ADJUST_PROPERTY' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_ROOSEVELT_COROLLARY_ADD_JUST_PROPERTY', 'Key', 'ROOSEVELT_COMBAT_BONUS_HOME_CONTINENT' ),
       ( 'MODIFIER_TRAIT_LEADER_ROOSEVELT_COROLLARY_ADD_JUST_PROPERTY', 'Amount', '1' );

INSERT INTO DistrictModifiers( DistrictType, ModifierId )
VALUES ( 'DISTRICT_GOVERNMENT', 'MODIFIER_TRAIT_LEADER_ROOSEVELT_COROLLARY_ADD_JUST_PROPERTY' );
INSERT INTO BuildingModifiers( BuildingType, ModifierId )
SELECT BuildingType, 'MODIFIER_TRAIT_LEADER_ROOSEVELT_COROLLARY_ADD_JUST_PROPERTY'
  FROM Buildings
 WHERE PrereqDistrict = 'DISTRICT_GOVERNMENT';

INSERT INTO Modifiers ( ModifierId, ModifierType )
VALUES ( 'MODIFIER_TRAIT_LEADER_ROOSEVELT_COROLLARY_ADD_JUST_PROPERTY2', 'MODIFIER_NW_PLAYER_UNITS_ADJUST_PROPERTY' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_ROOSEVELT_COROLLARY_ADD_JUST_PROPERTY2', 'Key',
         'ROOSEVELT_COMBAT_BONUS_NOT_HOME_CONTINENT' ),
       ( 'MODIFIER_TRAIT_LEADER_ROOSEVELT_COROLLARY_ADD_JUST_PROPERTY2', 'Amount', '1' );


INSERT INTO DistrictModifiers( DistrictType, ModifierId )
VALUES ( 'DISTRICT_DIPLOMATIC_QUARTER', 'MODIFIER_TRAIT_LEADER_ROOSEVELT_COROLLARY_ADD_JUST_PROPERTY2' );
INSERT INTO BuildingModifiers( BuildingType, ModifierId )
SELECT BuildingType, 'MODIFIER_TRAIT_LEADER_ROOSEVELT_COROLLARY_ADD_JUST_PROPERTY2'
  FROM Buildings
 WHERE PrereqDistrict = 'DISTRICT_DIPLOMATIC_QUARTER';


INSERT INTO UnitAbilityModifiers ( UnitAbilityType, ModifierId )
VALUES ( 'ABILITY_ROOSEVELT_COMBAT_BONUS_HOME_CONTINENT', 'ROOSEVELT_COMBAT_BONUS_FOREIGN_CONTINENT' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'ROOSEVELT_COMBAT_BONUS_FOREIGN_CONTINENT', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH',
         'REDCOAT_PLOT_IS_FOREIGN_CONTINENT' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'ROOSEVELT_COMBAT_BONUS_FOREIGN_CONTINENT', 'Key', 'ROOSEVELT_COMBAT_BONUS_NOT_HOME_CONTINENT' );
INSERT INTO ModifierStrings ( ModifierId, Context, Text )
VALUES ( 'ROOSEVELT_COMBAT_BONUS_FOREIGN_CONTINENT', 'Preview', 'LOC_ROOSEVELT_COMBAT_BONUS_FOREIGN_CONTINENT' );


INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_ROOSEVELT_COROLLARY', 'MODIFIER_TRAIT_LEADER_ROOSEVELT_COROLLARY_ADD_ROUTE' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_ROOSEVELT_COROLLARY_ADD_ROUTE', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_TRADE_ROUTE_CAPACITY',
         0, 0, 0, NULL, 'NW_DISTRICT_IS_DISTRICT_DIPLOMATIC_QUARTER_OR_DISTRICT_GOVERNMENT' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_ROOSEVELT_COROLLARY_ADD_ROUTE', 'Amount', '1' );

-- RequirementSets
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'NW_DISTRICT_IS_DISTRICT_DIPLOMATIC_QUARTER_OR_DISTRICT_GOVERNMENT', 'REQUIREMENTSET_TEST_ANY' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'NW_DISTRICT_IS_DISTRICT_DIPLOMATIC_QUARTER_OR_DISTRICT_GOVERNMENT',
         'NW_DISTRICT_IS_DISTRICT_GOVERNMENT_REQUIREMENT' ),
       ( 'NW_DISTRICT_IS_DISTRICT_DIPLOMATIC_QUARTER_OR_DISTRICT_GOVERNMENT',
         'NW_DISTRICT_IS_DISTRICT_DIPLOMATIC_QUARTER_REQUIREMENT' );

----------------------------------------------------------------------------------
-- 林肯

DELETE
  FROM TraitModifiers
 WHERE ModifierId = 'INDUSTRIAL_ZONE_ADDAMENITIES';
DELETE
  FROM TraitModifiers
 WHERE ModifierId = 'TRAIT_LINCOLN_INDUSTRIAL_ZONE_LOYALTY';
DELETE
  FROM ImprovementModifiers
 WHERE ModifierID = 'PLANTATION_NEGATIVE_LOYALTY';

-- 相邻工业区的种植园额外提供+2 [ICON_Amenities] 宜居度、+1住房，否则-2忠诚度。
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_LINCOLN', 'MODIFIER_LINCOLN_AMEN_TO_PLANTER' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_LINCOLN_AMEN_TO_PLANTER', 'MODIFIER_NW_DTSM_PLAYER_IMPROVEMENT_ADJUST_TRAIT_AMENITY', 0, 0, 0, NULL,
         'NW_REQS_PLOT_ADJACENT_DISTRICT_INDUSTRIAL_ZONE' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_LINCOLN_AMEN_TO_PLANTER', 'Amount', 2 );

-- Custom ModifierType
INSERT INTO Types ( Type, Kind )
VALUES ( 'MODIFIER_NW_DTSM_PLAYER_IMPROVEMENT_ADJUST_TRAIT_AMENITY', 'KIND_MODIFIER' );
INSERT INTO DynamicModifiers ( ModifierType, CollectionType, EffectType )
VALUES ( 'MODIFIER_NW_DTSM_PLAYER_IMPROVEMENT_ADJUST_TRAIT_AMENITY', 'COLLECTION_PLAYER_IMPROVEMENTS',
         'EFFECT_ADJUST_IMPROVEMENT_AMENITY' );


INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_LINCOLN', 'MODIFIER_LINCOLN_HOUSING_TO_PLANTER' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_LINCOLN_HOUSING_TO_PLANTER', 'MODIFIER_NW_DTSM_PLAYER_IMPROVEMENT_ADJUST_IMPROVEMENT_HOUSING', 0, 0,
         0, NULL, 'NW_REQS_PLOT_ADJACENT_DISTRICT_INDUSTRIAL_ZONE' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_LINCOLN_HOUSING_TO_PLANTER', 'Amount', '1' );
-- Custom ModifierType
INSERT INTO Types ( Type, Kind )
VALUES ( 'MODIFIER_NW_DTSM_PLAYER_IMPROVEMENT_ADJUST_IMPROVEMENT_HOUSING', 'KIND_MODIFIER' );
INSERT INTO DynamicModifiers ( ModifierType, CollectionType, EffectType )
VALUES ( 'MODIFIER_NW_DTSM_PLAYER_IMPROVEMENT_ADJUST_IMPROVEMENT_HOUSING', 'COLLECTION_PLAYER_IMPROVEMENTS',
         'EFFECT_ADJUST_IMPROVEMENT_HOUSING' );

-- RequirementSets
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'NW_REQS_PLOT_ADJACENT_DISTRICT_INDUSTRIAL_ZONE', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'NW_REQS_PLOT_ADJACENT_DISTRICT_INDUSTRIAL_ZONE', 'NW_REQ_PLOT_ADJACENT_DISTRICT_INDUSTRIAL_ZONE' );
-- Requirements
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'NW_REQ_PLOT_ADJACENT_DISTRICT_INDUSTRIAL_ZONE', 'REQUIREMENT_PLOT_ADJACENT_DISTRICT_TYPE_MATCHES' );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'NW_REQ_PLOT_ADJACENT_DISTRICT_INDUSTRIAL_ZONE', 'DistrictType', 'DISTRICT_INDUSTRIAL_ZONE' ),
       ( 'NW_REQ_PLOT_ADJACENT_DISTRICT_INDUSTRIAL_ZONE', 'MaxRange', '1' ),
       ( 'NW_REQ_PLOT_ADJACENT_DISTRICT_INDUSTRIAL_ZONE', 'MinRange', '1' );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_LINCOLN', 'MODIFIER_LINCOLN_IDENTITY_TO_PLANTER' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_LINCOLN_IDENTITY_TO_PLANTER', 'MODIFIER_NW_DTSM_PLAYER_IMPROVEMENT_ADJUST_IDENTITY_PER_TURN', 0, 0, 0,
         NULL, 'NW_REQS_PLOT_NOT_ADJACENT_DISTRICT_INDUSTRIAL_ZONE' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_LINCOLN_IDENTITY_TO_PLANTER', 'Amount', '-2' );
-- Custom ModifierType
INSERT INTO Types ( Type, Kind )
VALUES ( 'MODIFIER_NW_DTSM_PLAYER_IMPROVEMENT_ADJUST_IDENTITY_PER_TURN', 'KIND_MODIFIER' );
INSERT INTO DynamicModifiers ( ModifierType, CollectionType, EffectType )
VALUES ( 'MODIFIER_NW_DTSM_PLAYER_IMPROVEMENT_ADJUST_IDENTITY_PER_TURN', 'COLLECTION_OWNER',
         'EFFECT_ADJUST_CITY_IDENTITY_PER_TURN' );
-- RequirementSets
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'NW_REQS_PLOT_NOT_ADJACENT_DISTRICT_INDUSTRIAL_ZONE', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'NW_REQS_PLOT_NOT_ADJACENT_DISTRICT_INDUSTRIAL_ZONE', 'NW_REQ_PLOT_NOT_ADJACENT_DISTRICT_INDUSTRIAL_ZONE' );
-- Requirements
INSERT INTO Requirements ( RequirementId, RequirementType, Inverse )
VALUES ( 'NW_REQ_PLOT_NOT_ADJACENT_DISTRICT_INDUSTRIAL_ZONE', 'REQUIREMENT_PLOT_ADJACENT_DISTRICT_TYPE_MATCHES', 1 );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'NW_REQ_PLOT_NOT_ADJACENT_DISTRICT_INDUSTRIAL_ZONE', 'DistrictType', 'DISTRICT_INDUSTRIAL_ZONE' ),
       ( 'NW_REQ_PLOT_NOT_ADJACENT_DISTRICT_INDUSTRIAL_ZONE', 'MaxRange', '1' ),
       ( 'NW_REQ_PLOT_NOT_ADJACENT_DISTRICT_INDUSTRIAL_ZONE', 'MinRange', '1' );


INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_LINCOLN', 'MODIFIER_LINCOLN_ALL_MELEE_BUFF' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_LINCOLN_ALL_MELEE_BUFF', 'MODIFIER_NW_DTMS_GRANT_ABILITY_FOR_ALL_TRAINED_UNITS', 0, 1, 0, NULL,
         'REQUIRES_CITY_HAS_INDUSTRIAL_ZONE' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_LINCOLN_ALL_MELEE_BUFF', 'AbilityType', 'ABILITY_LINCOLN_MELEE_UNITS' );

INSERT INTO Types ( Type, Kind )
VALUES ( 'MODIFIER_NW_DTMS_GRANT_ABILITY_FOR_ALL_TRAINED_UNITS', 'KIND_MODIFIER' );
INSERT INTO DynamicModifiers ( ModifierType, CollectionType, EffectType )
VALUES ( 'MODIFIER_NW_DTMS_GRANT_ABILITY_FOR_ALL_TRAINED_UNITS', 'COLLECTION_PLAYER_TRAINED_UNITS',
         'EFFECT_GRANT_ABILITY' );

UPDATE ModifierArguments
   SET Value = 3
 WHERE ModifierId = 'LINCOLN_MELEE_BUFF' AND Name = 'Amount';

-- 工业区
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_LINCOLN', 'TRAIT_GANGKOU_AQUEDUCT_PRODUCTION_LINKEN2' );
INSERT INTO Modifiers ( ModifierId, ModifierType )
VALUES ( 'TRAIT_GANGKOU_AQUEDUCT_PRODUCTION_LINKEN2', 'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_GANGKOU_AQUEDUCT_PRODUCTION_LINKEN2', 'DistrictType', 'DISTRICT_INDUSTRIAL_ZONE' ),
       ( 'TRAIT_GANGKOU_AQUEDUCT_PRODUCTION_LINKEN2', 'Amount', '100' );
-- 水渠
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_LINCOLN', 'TRAIT_BOOST_AQUEDUCT_PRODUCTION_LINKEN_SHUIQU' );
INSERT INTO Modifiers ( ModifierId, ModifierType )
VALUES ( 'TRAIT_BOOST_AQUEDUCT_PRODUCTION_LINKEN_SHUIQU', 'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_BOOST_AQUEDUCT_PRODUCTION_LINKEN_SHUIQU', 'DistrictType', 'DISTRICT_AQUEDUCT' ),
       ( 'TRAIT_BOOST_AQUEDUCT_PRODUCTION_LINKEN_SHUIQU', 'Amount', '100' );


-- =============================================================
-- ARABIA	阿拉伯
DELETE
  FROM TraitModifiers
 WHERE ModifierId = 'TRAIT_GUARANTEE_ONE_PROPHET' AND TraitType = 'TRAIT_CIVILIZATION_LAST_PROPHET';

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_LAST_PROPHET', 'MODIFIER_TRAIT_CIVILIZATION_LAST_PROPHET_TR' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_CIVILIZATION_LAST_PROPHET_TR', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY', 0, 0, 0, NULL,
         'NW_PLAYER_HAS_FOUNDED_A_RELIGION' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_CIVILIZATION_LAST_PROPHET_TR', 'Amount', '1' );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_LAST_PROPHET', 'MODIFIER_TRAIT_CIVILIZATION_LAST_PROPHET_GPP' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_CIVILIZATION_LAST_PROPHET_GPP', 'MODIFIER_NW_CAPITAL_GRANT_GREAT_PERSON_CLASS_IN_CITY', 0, 0, 0,
         NULL, 'NW_PLAYER_HAS_FOUNDED_A_RELIGION' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_CIVILIZATION_LAST_PROPHET_GPP', 'Amount', '1' ),
       ( 'MODIFIER_TRAIT_CIVILIZATION_LAST_PROPHET_GPP', 'GreatPersonClassType', 'GREAT_PERSON_CLASS_WRITER' );

-- RequirementSets
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'NW_PLAYER_HAS_FOUNDED_A_RELIGION', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'NW_PLAYER_HAS_FOUNDED_A_RELIGION', 'REQ_NW_PLAYER_HAS_FOUNDED_A_RELIGION' );
-- Requirements
INSERT INTO Requirements ( RequirementId, RequirementType, Inverse )
VALUES ( 'REQ_NW_PLAYER_HAS_FOUNDED_A_RELIGION', 'REQUIREMENT_PLAYER_FOUNDED_NO_RELIGION', 1 );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_LAST_PROPHET', 'MODIFIER_TRAIT_CIVILIZATION_LAST_PROPHET_GKY' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_CIVILIZATION_LAST_PROPHET_GKY', 'MODIFIER_PLAYER_CITIES_ADJUST_GREATWORK_YIELD', 0, 0, 0, NULL,
         NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_CIVILIZATION_LAST_PROPHET_GKY', 'GreatWorkObjectType', 'GREATWORKOBJECT_WRITING' ),
       ( 'MODIFIER_TRAIT_CIVILIZATION_LAST_PROPHET_GKY', 'YieldChange', '2' ),
       ( 'MODIFIER_TRAIT_CIVILIZATION_LAST_PROPHET_GKY', 'YieldType', 'YIELD_FAITH' );

-- 文阿拉伯
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_RIGHTEOUSNESS_OF_FAITH', 'TRAIT_BONUS_GREAT_PROPHET_POINT_Z' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'TRAIT_BONUS_GREAT_PROPHET_POINT_Z', 'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS',
         'NW_PLAYER_HAS_CIVIC_CODE_OF_LAWS' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_BONUS_GREAT_PROPHET_POINT_Z', 'GreatPersonClassType', 'GREAT_PERSON_CLASS_PROPHET' ),
       ( 'TRAIT_BONUS_GREAT_PROPHET_POINT_Z', 'Amount', '1' );

UPDATE ModifierArguments
   SET Value = 100
 WHERE ModifierId = 'TRAIT_RELIGIOUS_BUILDING_DISCOUNT';

-- 武阿拉伯
-- 1.军营+信仰
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'ALABO_SUDAN_JUNYING_JIA_XINYANG', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE', 'DISTRICT_IS_ENCAMPMENT' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'ALABO_SUDAN_JUNYING_JIA_XINYANG', 'Amount', '3' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'ALABO_SUDAN_JUNYING_JIA_XINYANG', 'YieldType', 'YIELD_FAITH' );
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_SALADIN_ALT', 'ALABO_SUDAN_JUNYING_JIA_XINYANG' );

-- 2.军营建筑+信仰
INSERT INTO TraitModifiers ( TraitType, ModifierId )
SELECT 'TRAIT_LEADER_SALADIN_ALT', 'TRAIT_WUALABO_' || BuildingType || '_FAITH_TEAMPVP'
  FROM Buildings
 WHERE PrereqDistrict = 'DISTRICT_ENCAMPMENT' AND TraitType IS NULL;
INSERT INTO Modifiers ( ModifierId, ModifierType )
SELECT 'TRAIT_WUALABO_' || BuildingType || '_FAITH_TEAMPVP', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE'
  FROM Buildings
 WHERE PrereqDistrict = 'DISTRICT_ENCAMPMENT' AND TraitType IS NULL;
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'TRAIT_WUALABO_' || BuildingType || '_FAITH_TEAMPVP', 'BuildingType', BuildingType
  FROM Buildings
 WHERE PrereqDistrict = 'DISTRICT_ENCAMPMENT' AND TraitType IS NULL
 UNION
SELECT 'TRAIT_WUALABO_' || BuildingType || '_FAITH_TEAMPVP', 'YieldType', 'YIELD_FAITH'
  FROM Buildings
 WHERE PrereqDistrict = 'DISTRICT_ENCAMPMENT' AND TraitType IS NULL
 UNION
SELECT 'TRAIT_WUALABO_' || BuildingType || '_FAITH_TEAMPVP', 'Amount', 1
  FROM Buildings
 WHERE PrereqDistrict = 'DISTRICT_ENCAMPMENT' AND TraitType IS NULL;

-- 3.信仰购买奴隶骑
--购买
INSERT INTO TraitModifiers( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_SALADIN_ALT', 'ALABO_SUDAN_GOUMAI_NULIQIBING' );
INSERT INTO Modifiers ( ModifierId, ModifierType )
VALUES ( 'ALABO_SUDAN_GOUMAI_NULIQIBING', 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'ALABO_SUDAN_GOUMAI_NULIQIBING', 'Tag', 'CLASS_MAMLUK' );
--打折
INSERT INTO TraitModifiers( TraitType, ModifierId )
SELECT 'TRAIT_LEADER_SALADIN_ALT', 'ALABO_SUDAN_PURCHASE_COST' || UnitType
  FROM Units
 WHERE PromotionClass = 'PROMOTION_CLASS_HEAVY_CAVALRY';
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectStackLimit )
SELECT 'ALABO_SUDAN_PURCHASE_COST' || UnitType, 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_PURCHASE_COST', 1
  FROM Units
 WHERE PromotionClass = 'PROMOTION_CLASS_HEAVY_CAVALRY';
INSERT INTO ModifierArguments( ModifierId, Name, Value )
SELECT 'ALABO_SUDAN_PURCHASE_COST' || UnitType, 'UnitType', UnitType
  FROM Units
 WHERE PromotionClass = 'PROMOTION_CLASS_HEAVY_CAVALRY';
INSERT INTO ModifierArguments( ModifierId, Name, Value )
SELECT 'ALABO_SUDAN_PURCHASE_COST' || UnitType, 'Amount', '15'
  FROM Units
 WHERE PromotionClass = 'PROMOTION_CLASS_HEAVY_CAVALRY';


-- =============================================================
-- AUSTRALIA	澳大利亚
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_CITADEL_CIVILIZATION'
   AND ModifierId = 'TRAIT_CITADELCIVILIZATION_DEFENSIVE_PRODUCTION';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_CITADEL_CIVILIZATION'
   AND ModifierId = 'TRAIT_CITADELCIVILIZATION_LIBERATION_PRODUCTION';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_CITADEL_CIVILIZATION'
   AND ModifierId = 'TRAIT_CITADELCIVILIZATION_LIBERATION_PRODUCTION_XP2';


-- 满足前置科技或市政要求时，您的所有城市将可以生产所有相邻过您任意市中心的特色单位。为其他文明的特色单位+20% [ICON_PRODUCTION] 生产力。
-- 原创By千川白浪
INSERT INTO TraitModifiers ( TraitType, ModifierId )
SELECT 'TRAIT_LEADER_CITADEL_CIVILIZATION', 'MODFEAT_AUSTRALIA_VALID_BUILD_' || UnitType
  FROM Units;
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
SELECT 'MODFEAT_AUSTRALIA_VALID_BUILD_' || UnitType, 'MODIFIER_NW_DTMS_PLAYER_CITIES_ADJUST_VALID_UNIT_BUILD', 0, 1, 0,
       NULL, 'REQS_NW_DTMS_ADJACENT_CITY_' || UnitType
  FROM Units;
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'MODFEAT_AUSTRALIA_VALID_BUILD_' || UnitType, 'UnitType', UnitType
  FROM Units;
INSERT INTO Types ( Type, Kind )
VALUES ( 'MODIFIER_NW_DTMS_PLAYER_CITIES_ADJUST_VALID_UNIT_BUILD', 'KIND_MODIFIER' );
INSERT INTO DynamicModifiers ( ModifierType, CollectionType, EffectType )
VALUES ( 'MODIFIER_NW_DTMS_PLAYER_CITIES_ADJUST_VALID_UNIT_BUILD', 'COLLECTION_PLAYER_CITIES', 'EFFECT_ADJUST_PLAYER_VALID_UNIT_BUILD' );
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
SELECT 'REQS_NW_DTMS_ADJACENT_CITY_' || UnitType, 'REQUIREMENTSET_TEST_ALL'
  FROM Units;
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
SELECT 'REQS_NW_DTMS_ADJACENT_CITY_' || UnitType, 'REQ_NW_DTMS_ADJACENT_CITY_' || UnitType
  FROM Units;
INSERT INTO Requirements ( RequirementId, RequirementType )
SELECT 'REQ_NW_DTMS_ADJACENT_CITY_' || UnitType, 'REQUIREMENT_PLOT_ADJACENT_UNIT_TYPE_MATCHES'
  FROM Units;
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
SELECT 'REQ_NW_DTMS_ADJACENT_CITY_' || UnitType, 'MaxRange', '1'
  FROM Units
 UNION
SELECT 'REQ_NW_DTMS_ADJACENT_CITY_' || UnitType, 'MinRange', '0'
  FROM Units
 UNION
SELECT 'REQ_NW_DTMS_ADJACENT_CITY_' || UnitType, 'UnitType', UnitType
  FROM Units;

INSERT INTO TraitModifiers ( TraitType, ModifierId )
SELECT 'TRAIT_LEADER_CITADEL_CIVILIZATION', 'MODFEAT_AUSTRALIA_BUILD_PRODUCTION_' || UnitType
  FROM Units
 WHERE TraitType IS NOT NULL AND TraitType IS NOT 'TRAIT_CIVILIZATION_UNIT_DIGGER';
INSERT INTO Modifiers ( ModifierId, ModifierType )
SELECT 'MODFEAT_AUSTRALIA_BUILD_PRODUCTION_' || UnitType, 'MODIFIER_PLAYER_UNITS_ADJUST_UNIT_PRODUCTION'
  FROM Units
 WHERE TraitType IS NOT NULL AND TraitType IS NOT 'TRAIT_CIVILIZATION_UNIT_DIGGER';
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'MODFEAT_AUSTRALIA_BUILD_PRODUCTION_' || UnitType, 'UnitType', UnitType
  FROM Units
 WHERE TraitType IS NOT NULL AND TraitType IS NOT 'TRAIT_CIVILIZATION_UNIT_DIGGER'
 UNION
SELECT 'MODFEAT_AUSTRALIA_BUILD_PRODUCTION_' || UnitType, 'Amount', 20
  FROM Units
 WHERE TraitType IS NOT NULL AND TraitType IS NOT 'TRAIT_CIVILIZATION_UNIT_DIGGER';


-- 沿海城市+8%生产力
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'AODALIYA_PLOT_IS_COASTAL_LAND_TEAMPVP', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER',
         'PLOT_IS_COASTAL_LAND_REQUIREMENTS' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'AODALIYA_PLOT_IS_COASTAL_LAND_TEAMPVP', 'YieldType', 'YIELD_PRODUCTION' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'AODALIYA_PLOT_IS_COASTAL_LAND_TEAMPVP', 'Amount', '8' );
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_LAND_DOWN_UNDER', 'AODALIYA_PLOT_IS_COASTAL_LAND_TEAMPVP' );

-- 迷人的圣地、学院、商业中心和剧院广场获得大量相邻加成。
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_LAND_DOWN_UNDER' AND ModifierId IN ('TRAIT_BREATHTAKING_CAMPUS',
                                                                           'TRAIT_BREATHTAKING_THEATER_DISTRICT',
                                                                           'TRAIT_BREATHTAKING_HOLY_SITE',
                                                                           'TRAIT_BREATHTAKING_COMMERCIAL_HUB'
     );

UPDATE ModifierArguments
   SET Value='2'
 WHERE ModifierId = 'TRAIT_CHARMING_CAMPUS' AND Name = 'YieldChange';
UPDATE ModifierArguments
   SET Value='2'
 WHERE ModifierId = 'TRAIT_CHARMING_THEATER_DISTRICT' AND Name = 'YieldChange';
UPDATE ModifierArguments
   SET Value='2'
 WHERE ModifierId = 'TRAIT_CHARMING_HOLY_SITE' AND Name = 'YieldChange';
UPDATE ModifierArguments
   SET Value='2'
 WHERE ModifierId = 'TRAIT_CHARMING_COMMERCIAL_HUB' AND Name = 'YieldChange';

UPDATE Units
   SET BaseMoves=3
 WHERE UnitType = 'UNIT_DIGGER';

-- =============================================================
-- AZTEC	阿兹特克
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_GIFTS_FOR_TLATOANI' AND ModifierId = 'TRAIT_COMBAT_BONUS_PER_LUXURY';

INSERT INTO TraitModifiers( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_GIFTS_FOR_TLATOANI', 'MODIFIER_TRAIT_LEADER_GIFTS_FOR_TLATOANI_OWNER_UNIT_GRANT_ABILITY' );
INSERT INTO Modifiers( ModifierId, ModifierType )
VALUES ( 'MODIFIER_TRAIT_LEADER_GIFTS_FOR_TLATOANI_OWNER_UNIT_GRANT_ABILITY', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY' );
INSERT INTO ModifierArguments( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_GIFTS_FOR_TLATOANI_OWNER_UNIT_GRANT_ABILITY', 'AbilityType',
         'ABILITY_NW_AZTK' );

INSERT INTO Types ( Type, Kind )
VALUES ( 'ABILITY_NW_AZTK', 'KIND_ABILITY' );
INSERT INTO TypeTags ( Type, Tag )
VALUES ( 'ABILITY_NW_AZTK', 'CLASS_ALL_UNITS' );
INSERT INTO UnitAbilities ( UnitAbilityType, Name, Description, Inactive )
VALUES ( 'ABILITY_NW_AZTK',
         'LOC_TRAIT_LEADER_GIFTS_FOR_TLATOANI_NAME',
         'LOC_ABILITY_NW_AZTK_DESCRIPTION',
         1 );

INSERT INTO UnitAbilityModifiers ( UnitAbilityType, ModifierId )
VALUES ( 'ABILITY_NW_AZTK', 'MODIFIER_ABILITY_NW_AZTK_ADD_COMBAT' );
INSERT INTO Modifiers ( ModifierId, ModifierType,
    SubjectRequirementSetId )
VALUES ( 'MODIFIER_ABILITY_NW_AZTK_ADD_COMBAT', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH',
         'UNIT_STRONG_WHEN_ATTACKING_REQUIREMENTS' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_ABILITY_NW_AZTK_ADD_COMBAT', 'Key', 'ABILITY_NW_AZTK' ),
       ( 'MODIFIER_ABILITY_NW_AZTK_ADD_COMBAT', 'Max', 4 );
INSERT INTO ModifierStrings ( ModifierId, Context, Text )
VALUES ( 'MODIFIER_ABILITY_NW_AZTK_ADD_COMBAT', 'Preview', 'LOC_MODIFIER_ABILITY_NW_AZTK_ADD_COMBAT' );


INSERT INTO TraitModifiers ( TraitType, ModifierId )
SELECT 'TRAIT_LEADER_GIFTS_FOR_TLATOANI',
       'MODIFIER_TRAIT_LEADER_GIFTS_FOR_TLATOANI_ADJUST_PROPERTY_WHEN_' || ResourceType
  FROM Resources
 WHERE ResourceClassType = 'RESOURCECLASS_LUXURY';
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
SELECT 'MODIFIER_TRAIT_LEADER_GIFTS_FOR_TLATOANI_ADJUST_PROPERTY_WHEN_' || ResourceType,
       'MODIFIER_NW_PLAYER_UNITS_ADJUST_PROPERTY', 0, 0, 0, NULL, 'NW_PLAYER_HAS_IMPROVED_' || ResourceType
  FROM Resources
 WHERE ResourceClassType = 'RESOURCECLASS_LUXURY';

INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'MODIFIER_TRAIT_LEADER_GIFTS_FOR_TLATOANI_ADJUST_PROPERTY_WHEN_' || ResourceType, 'Key', 'ABILITY_NW_AZTK'
  FROM Resources
 WHERE ResourceClassType = 'RESOURCECLASS_LUXURY'
 UNION
SELECT 'MODIFIER_TRAIT_LEADER_GIFTS_FOR_TLATOANI_ADJUST_PROPERTY_WHEN_' || ResourceType, 'Amount', '1'
  FROM Resources
 WHERE ResourceClassType = 'RESOURCECLASS_LUXURY';

-- =============================================================
-- BABYLON_STK	巴比伦

INSERT INTO Building_YieldChanges ( BuildingType, YieldType, YieldChange )
VALUES ( 'BUILDING_PALGUM', 'YIELD_FOOD', '1' );


DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_HAMMURABI' AND ModifierId = 'TRAIT_FREE_BUILDING_WHEN_DISTRICT_MADE';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_HAMMURABI' AND ModifierId = 'TRAIT_FREE_BUILDING_WHEN_DISTRICT_MADE_EXCEPT';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_BABYLON' AND ModifierId = 'TRAIT_EUREKA_INCREASE';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_BABYLON' AND ModifierId = 'TRAIT_SCIENCE_DECREASE';

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_BABYLON', 'MODIFIER_TRAIT_CIVILIZATION_BABYLON_PRODUCTION' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_CIVILIZATION_BABYLON_PRODUCTION', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 0, 0, 0, 'NW_PLAYER_HAS_CIVIC_POLITICAL_PHILOSOPHY',
         'NW_DTMS_REQS_PLOTS_HAS_FW' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_CIVILIZATION_BABYLON_PRODUCTION', 'Amount', '1' ),
       ( 'MODIFIER_TRAIT_CIVILIZATION_BABYLON_PRODUCTION', 'YieldType', 'YIELD_PRODUCTION' );
-- RequirementSets
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'NW_DTMS_REQS_PLOTS_HAS_FW', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'NW_DTMS_REQS_PLOTS_HAS_FW', 'NW_DTMS_REQ_PLOTS_HAS_FW' );
-- Requirements
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'NW_DTMS_REQ_PLOTS_HAS_FW', 'REQUIREMENT_PLOT_IS_FRESH_WATER' );


INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_BABYLON', 'MODIFIER_TRAIT_CIVILIZATION_BABYLON_TECHNOLOGY_BOOST_NW' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_CIVILIZATION_BABYLON_TECHNOLOGY_BOOST_NW',
         'MODIFIER_NW_DTMS_PLAYER_CITIES_ADJUST_TECHNOLOGY_BOOST', 0, 0, 0, NULL, 'NW_DTMS_REQS_PLOTS_NEXT_RIVER' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_CIVILIZATION_BABYLON_TECHNOLOGY_BOOST_NW', 'Amount', '1' );
-- Custom ModifierType
INSERT INTO Types ( Type, Kind )
VALUES ( 'MODIFIER_NW_DTMS_PLAYER_CITIES_ADJUST_TECHNOLOGY_BOOST', 'KIND_MODIFIER' );
INSERT INTO DynamicModifiers ( ModifierType, CollectionType, EffectType )
VALUES ( 'MODIFIER_NW_DTMS_PLAYER_CITIES_ADJUST_TECHNOLOGY_BOOST', 'COLLECTION_PLAYER_CITIES',
         'EFFECT_ADJUST_TECHNOLOGY_BOOST' );
-- RequirementSets
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'NW_DTMS_REQS_PLOTS_NEXT_RIVER', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'NW_DTMS_REQS_PLOTS_NEXT_RIVER', 'NW_DTMS_REQ_PLOTS_NEXT_RIVER' );
-- Requirements
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'NW_DTMS_REQ_PLOTS_NEXT_RIVER', 'REQUIREMENT_PLOT_ADJACENT_TO_RIVER' );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'NW_DTMS_REQ_PLOTS_NEXT_RIVER', 'MaxDistance', '1' ),
       ( 'NW_DTMS_REQ_PLOTS_NEXT_RIVER', 'MinDistance', '0' );


-- =============================================================
-- BRAZIL	巴西

--巴西 雨林的加成对工业区也有效果
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_AMAZON', 'TRAIT_AMAZON_RAINFOREST_THEATER_ADJACENCY_GYQ' );

INSERT INTO Modifiers ( ModifierId, ModifierType )
VALUES ( 'TRAIT_AMAZON_RAINFOREST_THEATER_ADJACENCY_GYQ', 'MODIFIER_PLAYER_CITIES_FEATURE_ADJACENCY' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_AMAZON_RAINFOREST_THEATER_ADJACENCY_GYQ', 'DistrictType', 'DISTRICT_INDUSTRIAL_ZONE' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_AMAZON_RAINFOREST_THEATER_ADJACENCY_GYQ', 'FeatureType', 'FEATURE_JUNGLE' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_AMAZON_RAINFOREST_THEATER_ADJACENCY_GYQ', 'YieldType', 'YIELD_PRODUCTION' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_AMAZON_RAINFOREST_THEATER_ADJACENCY_GYQ', 'Amount', '1' );

-- 解锁“帝国初期”市政后，雨林+1 [ICON_PRODUCTION] 生产力。
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId, OwnerRequirementSetId )
VALUES ( 'TRAIT_BAXI_PRODUCTION_RAINFOREST', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'PLOT_HAS_JUNGLE_REQUIREMENTS',
         'NW_PLAYER_HAS_CIVIC_EARLY_EMPIRE' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_BAXI_PRODUCTION_RAINFOREST', 'YieldType', 'YIELD_PRODUCTION' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_BAXI_PRODUCTION_RAINFOREST', 'Amount', '1' );
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_AMAZON', 'TRAIT_BAXI_PRODUCTION_RAINFOREST' );


-- =============================================================
-- BYZANTIUM	拜占庭
-- 建造首都已建成的区域时+35%生产力。区域产出的伟人点数+100%。

-- 删除圣城加力和圣地伟人点
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_BYZANTIUM' AND ModifierId = 'TRAIT_HOLY_CITIES_RELIGIOUS_COMBAT';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_BYZANTIUM' AND ModifierId = 'BYZANTIUM_GREATPROPHETPOINTS';


INSERT INTO TraitModifiers ( TraitType, ModifierId )
SELECT 'TRAIT_CIVILIZATION_BYZANTIUM', 'MODIFIER_TRAIT_CIVILIZATION_BYZANTIUM_DIS_PRODUCTION_' || DistrictType
  FROM Districts
 WHERE MaxPerPlayer != 1 AND TraitType IS NULL;
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
SELECT 'MODIFIER_TRAIT_CIVILIZATION_BYZANTIUM_DIS_PRODUCTION_' || DistrictType,
       'MODIFIER_PLAYER_CAPITAL_CITY_ATTACH_MODIFIER', 'NW_CITY_HAS_' || DistrictType
  FROM Districts
 WHERE MaxPerPlayer != 1 AND TraitType IS NULL;
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'MODIFIER_TRAIT_CIVILIZATION_BYZANTIUM_DIS_PRODUCTION_' || DistrictType, 'ModifierId',
       'MODIFIER_TRAIT_CIVILIZATION_BYZANTIUM_DIS_PRODUCTION_ATTACH_' || DistrictType
  FROM Districts
 WHERE MaxPerPlayer != 1 AND TraitType IS NULL;
INSERT INTO Modifiers ( ModifierId, ModifierType )
SELECT 'MODIFIER_TRAIT_CIVILIZATION_BYZANTIUM_DIS_PRODUCTION_ATTACH_' || DistrictType,
       'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION'
  FROM Districts
 WHERE MaxPerPlayer != 1 AND TraitType IS NULL;
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'MODIFIER_TRAIT_CIVILIZATION_BYZANTIUM_DIS_PRODUCTION_ATTACH_' || DistrictType, 'Amount', '35'
  FROM Districts
 WHERE MaxPerPlayer != 1 AND TraitType IS NULL
 UNION
SELECT 'MODIFIER_TRAIT_CIVILIZATION_BYZANTIUM_DIS_PRODUCTION_ATTACH_' || DistrictType, 'DistrictType', DistrictType
  FROM Districts
 WHERE MaxPerPlayer != 1 AND TraitType IS NULL;


INSERT INTO TraitModifiers ( TraitType, ModifierId )
SELECT 'TRAIT_CIVILIZATION_BYZANTIUM',
       'MODIFIER_TRAIT_CIVILIZATION_BYZANTIUM_DIS_ADJUST_GREAT_PERSON_POINTS_' || DistrictType || '_' ||
       GreatPersonClassType
  FROM District_GreatPersonPoints
 WHERE DistrictType IN (SELECT DistrictType FROM Districts WHERE TraitType IS NULL);
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
SELECT 'MODIFIER_TRAIT_CIVILIZATION_BYZANTIUM_DIS_ADJUST_GREAT_PERSON_POINTS_' || DistrictType || '_' ||
       GreatPersonClassType, 'MODIFIER_PLAYER_DISTRICTS_ADJUST_GREAT_PERSON_POINTS', 0, 0, 0, NULL,
       'NW_DISTRICT_IS_' || DistrictType
  FROM District_GreatPersonPoints
 WHERE DistrictType IN (SELECT DistrictType FROM Districts WHERE TraitType IS NULL);

INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'MODIFIER_TRAIT_CIVILIZATION_BYZANTIUM_DIS_ADJUST_GREAT_PERSON_POINTS_' || DistrictType || '_' ||
       GreatPersonClassType, 'Amount', PointsPerTurn
  FROM District_GreatPersonPoints
 WHERE DistrictType IN (SELECT DistrictType FROM Districts WHERE TraitType IS NULL)
 UNION
SELECT 'MODIFIER_TRAIT_CIVILIZATION_BYZANTIUM_DIS_ADJUST_GREAT_PERSON_POINTS_' || DistrictType || '_' ||
       GreatPersonClassType, 'GreatPersonClassType', GreatPersonClassType
  FROM District_GreatPersonPoints
 WHERE DistrictType IN (SELECT DistrictType FROM Districts WHERE TraitType IS NULL);

-- 男拜
DELETE
  FROM UnitAbilityModifiers
 WHERE UnitAbilityType = 'ABILITY_BYZANTIUM_COMBAT_UNITS' AND ModifierId = 'BYZANTIUM_COMBAT_HOLY_CITIES';
UPDATE TraitModifiers
   SET TraitType = 'TRAIT_LEADER_BASIL'
 WHERE TraitType = 'TRAIT_CIVILIZATION_BYZANTIUM' AND ModifierId = 'TRAIT_HOLY_CITIES_COMBAT';


--拜占庭 狄奥多拉
--移除原版为圣地加文化
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_THEODORA' AND ModifierId = 'THEODORA_CULTURE_HOLY_SITE';

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_THEODORA', 'MODIFIER_TRAIT_LEADER_THEODORA_HOLY_CULTURE' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_THEODORA_HOLY_CULTURE', 'MODIFIER_PLAYER_CITIES_DISTRICT_ADJACENCY', 0, 0, 0, NULL,
         NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_THEODORA_HOLY_CULTURE', 'Amount', '1' ),
       ( 'MODIFIER_TRAIT_LEADER_THEODORA_HOLY_CULTURE', 'Description',
         'LOC_MODIFIER_TRAIT_LEADER_THEODORA_HOLY_CULTURE' ),
       ( 'MODIFIER_TRAIT_LEADER_THEODORA_HOLY_CULTURE', 'DistrictType', 'DISTRICT_HOLY_SITE' ),
       ( 'MODIFIER_TRAIT_LEADER_THEODORA_HOLY_CULTURE', 'YieldType', 'YIELD_CULTURE' );


INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_THEODORA', 'MODIFIER_TRAIT_LEADER_THEODORA_FARM_YIELD' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_THEODORA_FARM_YIELD', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 0, 0, 0, NULL,
         'NW_REQS_PLOT_NEXT_HOLY_AND_HAS_FARM' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_THEODORA_FARM_YIELD', 'Amount', '1,1' ),
       ( 'MODIFIER_TRAIT_LEADER_THEODORA_FARM_YIELD', 'YieldType', 'YIELD_CULTURE,YIELD_FAITH' );
-- RequirementSets
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'NW_REQS_PLOT_NEXT_HOLY_AND_HAS_FARM', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'NW_REQS_PLOT_NEXT_HOLY_AND_HAS_FARM', 'NW_DTMS_REQ_PLOT_NEXT_HOLY' ),
       ( 'NW_REQS_PLOT_NEXT_HOLY_AND_HAS_FARM', 'NW_DTMS_REQ_PLOT_HAS_FARM' );
-- Requirements
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'NW_DTMS_REQ_PLOT_NEXT_HOLY', 'REQUIREMENT_PLOT_ADJACENT_DISTRICT_TYPE_MATCHES' ),
       ( 'NW_DTMS_REQ_PLOT_HAS_FARM', 'REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES' );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'NW_DTMS_REQ_PLOT_NEXT_HOLY', 'DistrictType', 'DISTRICT_HOLY_SITE' ),
       ( 'NW_DTMS_REQ_PLOT_NEXT_HOLY', 'MaxRange', '1' ),
       ( 'NW_DTMS_REQ_PLOT_NEXT_HOLY', 'MinRange', '1' ),
       ( 'NW_DTMS_REQ_PLOT_HAS_FARM', 'ImprovementType', 'IMPROVEMENT_FARM' );


--拜占庭 娱乐区
UPDATE Districts
   SET Entertainment=2
 WHERE DistrictType = 'DISTRICT_HIPPODROME';

-- =============================================================
-- CANADA	加拿大

--加拿大 宫殿+1粮
INSERT INTO Modifiers( ModifierId, ModifierType )
VALUES ( 'JIANADA_GONGDIAN_JIASHIWU', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE' );

INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'JIANADA_GONGDIAN_JIASHIWU', 'BuildingType', 'BUILDING_PALACE' ),
       ( 'JIANADA_GONGDIAN_JIASHIWU', 'YieldType', 'YIELD_FOOD' ),
       ( 'JIANADA_GONGDIAN_JIASHIWU', 'Amount', '1' );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_FACES_OF_PEACE', 'JIANADA_GONGDIAN_JIASHIWU' );

--修复官方加拿大BUG
UPDATE ModifierArguments
   SET Value='2'
 WHERE ModifierId = 'TUNDRA_HILLS_LUMBER_MILLS_PRODUCTION' AND Name = 'Amount';

--加拿大 冰球场
UPDATE Adjacency_YieldChanges
   SET TilesRequired='2'
 WHERE ID = 'Hockey_TundraAdjacency';
UPDATE Adjacency_YieldChanges
   SET TilesRequired='2'
 WHERE ID = 'Hockey_TundraHillsAdjacency';
UPDATE Adjacency_YieldChanges
   SET TilesRequired='2'
 WHERE ID = 'Hockey_SnowAdjacency';
UPDATE Adjacency_YieldChanges
   SET TilesRequired='2'
 WHERE ID = 'Hockey_SnowHillsAdjacency';

--加拿大 骑警
UPDATE ModifierArguments
   SET Value=1
 WHERE ModifierId = 'ALL_PARK_COMBAT_BONUS' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value=2
 WHERE ModifierId = 'OWNER_PARK_COMBAT_BONUS' AND Name = 'Amount';

INSERT INTO UnitReplaces ( CivUniqueUnitType, ReplacesUnitType )
VALUES ( 'UNIT_CANADA_MOUNTIE', 'UNIT_CAVALRY' );

UPDATE Units
   SET StrategicResource='RESOURCE_HORSES'
 WHERE UnitType = 'UNIT_CANADA_MOUNTIE';
INSERT INTO Units_XP2 ( UnitType, ResourceCost )
VALUES ( 'UNIT_CANADA_MOUNTIE', '20' );
INSERT INTO UnitUpgrades ( Unit, UpgradeUnit )
VALUES ( 'UNIT_CANADA_MOUNTIE', 'UNIT_HELICOPTER' );
UPDATE Units
   SET Combat=64, PrereqCivic='CIVIC_HUMANISM', Cost=330
 WHERE UnitType = 'UNIT_CANADA_MOUNTIE';

-- =============================================================
-- CHINA	中国
-- 朝代更替
UPDATE ModifierArguments
   SET Value='8'
 WHERE ModifierId = 'TRAIT_CIVIC_BOOST' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='8'
 WHERE ModifierId = 'TRAIT_TECHNOLOGY_BOOST' AND Name = 'Amount';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_DYNASTIC_CYCLE' AND ModifierId = 'TRAIT_CIVIC_BOOST_WONDER_ERA';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_DYNASTIC_CYCLE' AND ModifierId = 'TRAIT_TECHNOLOGY_BOOST_WONDER_ERA';

INSERT INTO TraitModifiers ( TraitType, ModifierId )
SELECT 'TRAIT_CIVILIZATION_DYNASTIC_CYCLE', 'MODIFIER_TRAIT_CIVILIZATION_DYNASTIC_CYCLE_TB_' || EraType
  FROM Eras;
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
SELECT 'MODIFIER_TRAIT_CIVILIZATION_DYNASTIC_CYCLE_TB_' || EraType,
       'MODIFIER_PLAYER_GRANT_RANDOM_TECHNOLOGY_BOOST_BY_ERA', 0, 0, 0, NULL, 'NW_PLAYER_IS_IN_' || EraType
  FROM Eras;
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'MODIFIER_TRAIT_CIVILIZATION_DYNASTIC_CYCLE_TB_' || EraType, 'Amount', '1'
  FROM Eras
 UNION
SELECT 'MODIFIER_TRAIT_CIVILIZATION_DYNASTIC_CYCLE_TB_' || EraType, 'EndEraType', EraType
  FROM Eras
 UNION
SELECT 'MODIFIER_TRAIT_CIVILIZATION_DYNASTIC_CYCLE_TB_' || EraType, 'StartEraType', EraType
  FROM Eras;

INSERT INTO TraitModifiers ( TraitType, ModifierId )
SELECT 'TRAIT_CIVILIZATION_DYNASTIC_CYCLE', 'MODIFIER_TRAIT_CIVILIZATION_DYNASTIC_CYCLE_CB_' || EraType
  FROM Eras;
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
SELECT 'MODIFIER_TRAIT_CIVILIZATION_DYNASTIC_CYCLE_CB_' || EraType, 'MODIFIER_PLAYER_GRANT_RANDOM_CIVIC_BOOST_BY_ERA',
       0, 0, 0, NULL, 'NW_PLAYER_IS_IN_' || EraType
  FROM Eras;
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'MODIFIER_TRAIT_CIVILIZATION_DYNASTIC_CYCLE_CB_' || EraType, 'Amount', '1'
  FROM Eras
 UNION
SELECT 'MODIFIER_TRAIT_CIVILIZATION_DYNASTIC_CYCLE_CB_' || EraType, 'EndEraType', EraType
  FROM Eras
 UNION
SELECT 'MODIFIER_TRAIT_CIVILIZATION_DYNASTIC_CYCLE_CB_' || EraType, 'StartEraType', EraType
  FROM Eras;


-- 虎蹲炮近战+7力
INSERT INTO UnitReplaces ( CivUniqueUnitType, ReplacesUnitType )
VALUES ( 'UNIT_CHINESE_CROUCHING_TIGER', 'UNIT_CROSSBOWMAN' );
UPDATE Units
   SET Cost=190, Combat=34, RangedCombat=44, Range=2
 WHERE UnitType = 'UNIT_CHINESE_CROUCHING_TIGER';

INSERT INTO Tags ( Tag, Vocabulary )
VALUES ( 'CLASS_CROUCHING_TIGER', 'ABILITY_CLASS' );
INSERT INTO TypeTags ( Type, Tag )
VALUES ( 'UNIT_CHINESE_CROUCHING_TIGER', 'CLASS_CROUCHING_TIGER' );
INSERT INTO Types ( Type, Kind )
VALUES ( 'ABILITY_TIGER_ADJACENCY_DAMAGE_CPLMOD', 'KIND_ABILITY' );
INSERT INTO TypeTags ( Type, Tag )
VALUES ( 'ABILITY_TIGER_ADJACENCY_DAMAGE_CPLMOD', 'CLASS_CROUCHING_TIGER' );
INSERT INTO UnitAbilities ( UnitAbilityType, Name, Description )
VALUES ( 'ABILITY_TIGER_ADJACENCY_DAMAGE_CPLMOD', 'LOC_ABILITY_TIGER_ADJACENCY_NAME',
         'LOC_ABILITY_TIGER_ADJACENCY_DESCRIPTION' );
INSERT INTO UnitAbilityModifiers ( UnitAbilityType, ModifierId )
VALUES ( 'ABILITY_TIGER_ADJACENCY_DAMAGE_CPLMOD', 'TIGER_ADJACENCY_DAMAGE' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'TIGER_ADJACENCY_DAMAGE', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'TIGER_ADJACENCY_REQUIREMENTS' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TIGER_ADJACENCY_DAMAGE', 'Amount', '3' );
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'TIGER_ADJACENCY_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'TIGER_ADJACENCY_REQUIREMENTS', 'PLAYER_IS_ATTACKER_REQUIREMENTS' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'TIGER_ADJACENCY_REQUIREMENTS', 'ADJACENT_UNIT_REQUIREMENT' );
INSERT INTO ModifierStrings ( ModifierId, Context, Text )
VALUES ( 'TIGER_ADJACENCY_DAMAGE', 'Preview', 'LOC_ABILITY_TIGER_ADJACENCY_DESCRIPTION' );


UPDATE Adjacency_YieldChanges
   SET YieldChange=1
 WHERE ID = 'GreatWall_Culture';

INSERT INTO Improvement_BonusYieldChanges ( Id, ImprovementType, YieldType, BonusYieldChange, PrereqTech )
VALUES ( 'IMPROVEMENT_STEPWELL_china', 'IMPROVEMENT_GREAT_WALL', 'YIELD_CULTURE', '1', 'TECH_CASTLES' );

-- 文秦
UPDATE ModifierArguments
   SET Value=18
 WHERE ModifierId = 'TRAIT_BUILDER_WONDER_PERCENT' AND Name = 'Amount';

INSERT INTO TraitModifiers ( TraitType, ModifierId )
SELECT 'FIRST_EMPEROR_TRAIT', 'TRAIT_FIRST_EMPEROR_TRAIT_GOLD_FROM_' || BuildingType
  FROM Buildings
 WHERE IsWonder = 1;
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
SELECT 'TRAIT_FIRST_EMPEROR_TRAIT_GOLD_FROM_' || BuildingType, 'MODIFIER_PLAYER_GRANT_YIELD', 0, 1, 0, NULL,
       'NW_PLAYER_HAS_' || BuildingType
  FROM Buildings
 WHERE IsWonder = 1;
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'TRAIT_FIRST_EMPEROR_TRAIT_GOLD_FROM_' || BuildingType, 'Amount', '50'
  FROM Buildings
 WHERE IsWonder = 1
 UNION
SELECT 'TRAIT_FIRST_EMPEROR_TRAIT_GOLD_FROM_' || BuildingType, 'YieldType', 'YIELD_GOLD'
  FROM Buildings
 WHERE IsWonder = 1;

-- 永乐皇帝
UPDATE Project_YieldConversions
   SET PercentOfProductionRate=100
 WHERE ProjectType = 'PROJECT_LIJIA_FAITH';
UPDATE Project_YieldConversions
   SET PercentOfProductionRate=70
 WHERE ProjectType = 'PROJECT_LIJIA_FOOD';
UPDATE Project_YieldConversions
   SET PercentOfProductionRate=150
 WHERE ProjectType = 'PROJECT_LIJIA_GOLD';
UPDATE ModifierArguments
   SET Value='0.4'
 WHERE ModifierId = 'YONGLE_SCIENCE_POPULATION' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='0.2'
 WHERE ModifierId = 'YONGLE_CULTURE_POPULATION' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='0.6'
 WHERE ModifierId = 'YONGLE_GOLD_POPULATION' AND Name = 'Amount';

-- 武则天
-- 解锁“防御战术”获得1个间谍容量，解锁“行政部门”获得1个间谍和1个间谍容量
UPDATE Modifiers
   SET OwnerRequirementSetId='NW_PLAYER_HAS_CIVIC_CIVIL_SERVICE'
 WHERE ModifierId = 'WU_ZETIAN_FREE_SPY';
INSERT INTO TraitModifiers( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_WU_ZETIAN', 'WU_ZETIAN_FREE_SPY_CAPACITY_WANGQUAN' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'WU_ZETIAN_FREE_SPY_CAPACITY_WANGQUAN', 'MODIFIER_PLAYER_GRANT_SPY', 'NW_PLAYER_HAS_CIVIC_CIVIL_SERVICE' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'WU_ZETIAN_FREE_SPY_CAPACITY_WANGQUAN', 'Amount', '1' );

-- 间谍百分比
UPDATE ModifierArguments
   SET Value=50
 WHERE ModifierId = 'WU_ZETIAN_OFFENSIVE_SPY_SCIENCE' AND Name = 'Percent';
UPDATE ModifierArguments
   SET Value=50
 WHERE ModifierId = 'WU_ZETIAN_OFFENSIVE_SPY_CULTURE' AND Name = 'Percent';
UPDATE ModifierArguments
   SET Value=50
 WHERE ModifierId = 'WU_ZETIAN_OFFENSIVE_SPY_FAITH' AND Name = 'Percent';

-- 信仰购买间谍
UPDATE Modifiers
   SET OwnerRequirementSetId='NW_PLAYER_HAS_CIVIC_CIVIL_SERVICE'
 WHERE ModifierId = 'WU_ZETIAN_PURCHASE_SPY';


-- 武秦始皇

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_QIN', 'TRAIT_WUQING_COMBAT_BONUS_TEAMPVP' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'TRAIT_WUQING_COMBAT_BONUS_TEAMPVP', 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH', 'UNIT_STRONG_WHEN_ATTACKING_REQUIREMENTS' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_WUQING_COMBAT_BONUS_TEAMPVP', 'Amount', '1' );
INSERT INTO ModifierStrings ( ModifierId, Context, Text )
VALUES ( 'TRAIT_WUQING_COMBAT_BONUS_TEAMPVP', 'Preview', 'LOC_ABILITY_WUQING_NAME' );

INSERT INTO TraitModifiers( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_QIN', 'TRAIT_WUQING_COMBAT_BONUS_2_TEAMPVP' );
INSERT INTO Modifiers( ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'TRAIT_WUQING_COMBAT_BONUS_2_TEAMPVP', 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH', 'NW_PLAYER_HAS_CIVIC_DEFENSIVE_TACTICS', 'UNIT_STRONG_WHEN_ATTACKING_REQUIREMENTS' );
INSERT INTO ModifierArguments( ModifierId, Name, Value )
VALUES ( 'TRAIT_WUQING_COMBAT_BONUS_2_TEAMPVP', 'Amount', '1' );
INSERT INTO ModifierStrings( ModifierId, Context, Text )
VALUES ( 'TRAIT_WUQING_COMBAT_BONUS_2_TEAMPVP', 'Preview', 'LOC_ABILITY_WUQING_2_NAME' );

INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'ATTACKING_REQUIREMENT_SET1', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'ATTACKING_REQUIREMENT_SET1', 'UNIT_CLASS_123_REQUIREMENT' );
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'UNIT_CLASS_123_REQUIREMENT', 'REQUIREMENT_UNIT_TAG_MATCHES' );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'UNIT_CLASS_123_REQUIREMENT', 'Tag', 'CLASS_MELEE' );

--移除原技能
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_QIN' AND ModifierId = 'QIN_MELEE_UNIT_ABILITY';

--赋予近战能力
INSERT INTO TraitModifiers( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_QIN', 'WU_QINSHIHUANG_JINZHAN_ZHUAREN' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'WU_QINSHIHUANG_JINZHAN_ZHUAREN', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'PLAYER_WU_QINSHIHUANG_UNIT_IS_JINZHAN' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'WU_QINSHIHUANG_JINZHAN_ZHUAREN', 'ModifierId', 'WU_QINSHIHUANG_JINZHAN_ZHUAREN_MODIFIER' );
-- 单位为近战单位
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'PLAYER_WU_QINSHIHUANG_UNIT_IS_JINZHAN', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'PLAYER_WU_QINSHIHUANG_UNIT_IS_JINZHAN', 'UNIT_IS_JINZHAN_WU_QINSHIHUANG' );
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'UNIT_IS_JINZHAN_WU_QINSHIHUANG', 'REQUIREMENT_UNIT_PROMOTION_CLASS_MATCHES' );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'UNIT_IS_JINZHAN_WU_QINSHIHUANG', 'UnitPromotionClass', 'PROMOTION_CLASS_MELEE' );
--击杀俘虏
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'WU_QINSHIHUANG_JINZHAN_ZHUAREN_MODIFIER', 'MODIFIER_UNIT_ADJUST_COMBAT_UNIT_CAPTURE', 'PLAYER_ATTACKER_OPPONENT_IS_WU_QINSHIHUANG' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'WU_QINSHIHUANG_JINZHAN_ZHUAREN_MODIFIER', 'CanCapture', 1 ),
       ( 'WU_QINSHIHUANG_JINZHAN_ZHUAREN_MODIFIER', 'UnitType', 'UNIT_MILITARY_ENGINEER' );
-- 进攻判定
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'PLAYER_ATTACKER_OPPONENT_IS_WU_QINSHIHUANG', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'PLAYER_ATTACKER_OPPONENT_IS_WU_QINSHIHUANG', 'PLAYER_IS_ATTACKER_REQUIREMENTS' );
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'OPPONENT_IS_WU_QINGSHIHUANG_REQUIREMENTS_MET', 'REQUIREMENT_REQUIREMENTSET_IS_MET' );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'OPPONENT_IS_WU_QINGSHIHUANG_REQUIREMENTS_MET', 'RequirementSetId', 'OPPONENT_IS_WU_QINGSHIHUANG_UNIT_REQUIREMENTS' );

-- 忽中
UPDATE ModifierArguments
   SET Value='1'
 WHERE ModifierId = 'TRAIT_TRADING_POST_TECH_BOOST' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='1'
 WHERE ModifierId = 'TRAIT_TRADING_POST_CIVIC_BOOST' AND Name = 'Amount';


-- 黄卡
UPDATE Modifiers
   SET OwnerRequirementSetId='CITY_HAS_GOVERNOR_REQUIREMENTS',
       ModifierType = 'MODIFIER_NW_DTMS_CAPITAL_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER'
 WHERE ModifierId = 'TRAIT_ECONOMIC_GOVERNMENT_SLOT';
INSERT INTO Types ( Type, Kind )
VALUES ( 'MODIFIER_NW_DTMS_CAPITAL_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER', 'KIND_MODIFIER' );
INSERT INTO DynamicModifiers ( ModifierType, CollectionType, EffectType )
VALUES ( 'MODIFIER_NW_DTMS_CAPITAL_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER', 'COLLECTION_PLAYER_CAPITAL_CITY', 'EFFECT_ADJUST_PLAYER_GOVERNMENT_SLOT_TYPE' );


-- 商路+1
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_KUBLAI', 'MODIFIER_TRAIT_LEADER_KUBLAI_TR' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_KUBLAI_TR', 'MODIFIER_NW_DTMS_PLAYER_CAPITAL_CITY_ADJUST_TRADE_ROUTE_CAPACITY', 0, 0, 0, NULL, 'CITY_HAS_GOVERNOR_REQUIREMENTS' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_KUBLAI_TR', 'Amount', '1' );
INSERT INTO Types ( Type, Kind )
VALUES ( 'MODIFIER_NW_DTMS_PLAYER_CAPITAL_CITY_ADJUST_TRADE_ROUTE_CAPACITY', 'KIND_MODIFIER' );
INSERT INTO DynamicModifiers ( ModifierType, CollectionType, EffectType )
VALUES ( 'MODIFIER_NW_DTMS_PLAYER_CAPITAL_CITY_ADJUST_TRADE_ROUTE_CAPACITY', 'COLLECTION_PLAYER_CAPITAL_CITY', 'EFFECT_ADJUST_TRADE_ROUTE_CAPACITY' );

-- 外商
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_KUBLAI', 'TRAIT_INTERNATIONAL_TRADE_GAIN_GOLD_HBL2' );
INSERT INTO Modifiers ( ModifierId, ModifierType )
VALUES ( 'TRAIT_INTERNATIONAL_TRADE_GAIN_GOLD_HBL2', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_INTERNATIONAL_TRADE_GAIN_GOLD_HBL2', 'YieldType', 'YIELD_FOOD' ),
       ( 'TRAIT_INTERNATIONAL_TRADE_GAIN_GOLD_HBL2', 'Amount', 1 ),
       ( 'TRAIT_INTERNATIONAL_TRADE_GAIN_GOLD_HBL2', 'Intercontinental', 0 );
-- 内商
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_KUBLAI', 'TRAIT_DOMESTIC_TRADE_GAIN_PHBL' );
INSERT INTO Modifiers ( ModifierId, ModifierType )
VALUES ( 'TRAIT_DOMESTIC_TRADE_GAIN_PHBL', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_DOMESTIC' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_DOMESTIC_TRADE_GAIN_PHBL', 'YieldType', 'YIELD_GOLD' ),
       ( 'TRAIT_DOMESTIC_TRADE_GAIN_PHBL', 'Amount', '2' );

-- =============================================================
-- CREE	克里
--克里 商路加成需要政治哲学
UPDATE Modifiers
   SET SubjectRequirementSetId='NW_PLAYER_HAS_CIVIC_POLITICAL_PHILOSOPHY'
 WHERE ModifierId = 'TRAIT_TRADE_FOOD_FROM_CAMPS';
UPDATE Modifiers
   SET SubjectRequirementSetId='NW_PLAYER_HAS_CIVIC_POLITICAL_PHILOSOPHY'
 WHERE ModifierId = 'TRAIT_TRADE_FOOD_FROM_PASTURES';
--克里 移除棚屋行政+住房
UPDATE ModifierArguments
   SET Value='0'
 WHERE ModifierId = 'MEKEWAP_HOUSING_WITHCIVILSERVICE' AND Name = 'Amount';

-- =============================================================
-- EGYPT	埃及
UPDATE Units
   SET Cost=98
 WHERE UnitType = 'UNIT_EGYPTIAN_CHARIOT_ARCHER';
UPDATE ModifierArguments
   SET Value = 15
 WHERE ModifierId = 'TRAIT_RIVER_FASTER_BUILDTIME_DISTRICT' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value = 0
 WHERE ModifierId = 'TRAIT_RIVER_FASTER_BUILDTIME_WONDER' AND Name = 'Amount';

-- 河边区域加产
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_MEDITERRANEAN', 'MODIFIER_TRAIT_LEADER_MEDITERRANEAN_SCIENCE' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_MEDITERRANEAN_SCIENCE', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE', 'NW_DTMS_REQS_PLOTS_NEXT_RIVER' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_MEDITERRANEAN_SCIENCE', 'Amount', 1 ),
       ( 'MODIFIER_TRAIT_LEADER_MEDITERRANEAN_SCIENCE', 'YieldType', 'YIELD_SCIENCE' );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_RAMSES', 'MODIFIER_TRAIT_LEADER_RAMSES_PRODUCTION' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_RAMSES_PRODUCTION', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE', 'NW_DTMS_REQS_PLOTS_NEXT_RIVER' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_RAMSES_PRODUCTION', 'Amount', 1 ),
       ( 'MODIFIER_TRAIT_LEADER_RAMSES_PRODUCTION', 'YieldType', 'YIELD_PRODUCTION' );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_CLEOPATRA_ALT', 'MODIFIER_TRAIT_LEADER_CLEOPATRA_ALT_GOLD' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_CLEOPATRA_ALT_GOLD', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE', 'NW_DTMS_REQS_PLOTS_NEXT_RIVER' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_CLEOPATRA_ALT_GOLD', 'Amount', 3 ),
       ( 'MODIFIER_TRAIT_LEADER_CLEOPATRA_ALT_GOLD', 'YieldType', 'YIELD_GOLD' );

-- 拉美西斯
UPDATE ModifierArguments
   SET Value=25
 WHERE ModifierId = 'RAMSES_CULTURE_POSITIVE_WONDERS_BUILDINGS' AND Name = 'BuildingProductionPercent';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_RAMSES' AND ModifierId = 'RAMSES_CULTURE_NEGATIVE_BUILDINGS';


-- =============================================================
-- ENGLAND	英国
-- 世界工厂
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_INDUSTRIAL_REVOLUTION' AND ModifierId = 'TRAIT_ACCUMULATE_MORE_COAL';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_INDUSTRIAL_REVOLUTION' AND ModifierId = 'TRAIT_ACCUMULATE_MORE_IRON';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_INDUSTRIAL_REVOLUTION'
   AND ModifierId = 'TRAIT_ADJUST_MILITARY_ENGINEER_PRODUCTION';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_INDUSTRIAL_REVOLUTION'
   AND ModifierId = 'TRAIT_ADJUST_INDUSTRIAL_ZONE_BUILDINGS_PRODUCTION';

UPDATE TraitModifiers
   SET TraitType = 'TRAIT_CIVILIZATION_ROYAL_NAVY_DOCKYARD'
 WHERE ModifierId IN ('TRAIT_ADJUST_LIGHTHOUSE_STOCKPILE_CAP',
                      'TRAIT_ADJUST_SHIPYARD_STOCKPILE_CAP',
                      'TRAIT_ADJUST_SEAPORT_STOCKPILE_CAP')
   AND TraitType = 'TRAIT_CIVILIZATION_INDUSTRIAL_REVOLUTION';

-- 帝英
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_PAX_BRITANNICA', 'MODIFIER_TRAIT_LEADER_PAX_BRITANNICA_CAPITAL_TR' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_PAX_BRITANNICA_CAPITAL_TR', 'MODIFIER_PLAYER_CITIES_ADJUST_TRADE_ROUTE_CAPACITY', 0, 0, 0, NULL, 'BUILDING_IS_PALACE' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_PAX_BRITANNICA_CAPITAL_TR', 'Amount', '1' );


INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_PAX_BRITANNICA', 'MODIFIER_TRAIT_LEADER_PAX_BRITANNICA_CAPITAL_GU' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_PAX_BRITANNICA_CAPITAL_GU', 'MODIFIER_PLAYER_CITIES_GRANT_UNIT_BY_CLASS', 0, 1, 0, NULL, 'BUILDING_IS_PALACE' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_PAX_BRITANNICA_CAPITAL_GU', 'UnitPromotionClassType', 'PROMOTION_CLASS_MELEE' );


-- 埃莉诺
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_ELEANOR_LOYALTY', 'TRAIT_LEADER_ELEANOR_LOYALTY_FREE_BUILDING_AMPHITHEATER' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'TRAIT_LEADER_ELEANOR_LOYALTY_FREE_BUILDING_AMPHITHEATER', 'MODIFIER_NW_DTMS_PLAYER_CITIES_GRANT_BUILDING_IN_CITY_IGNORE', 0, 1, 0, NULL, 'NW_CITY_HAS_DISTRICT_THEATER' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_LEADER_ELEANOR_LOYALTY_FREE_BUILDING_AMPHITHEATER', 'BuildingType', 'BUILDING_AMPHITHEATER' );
-- Custom ModifierType
INSERT INTO Types ( Type, Kind )
VALUES ( 'MODIFIER_NW_DTMS_PLAYER_CITIES_GRANT_BUILDING_IN_CITY_IGNORE', 'KIND_MODIFIER' );
INSERT INTO DynamicModifiers ( ModifierType, CollectionType, EffectType )
VALUES ( 'MODIFIER_NW_DTMS_PLAYER_CITIES_GRANT_BUILDING_IN_CITY_IGNORE', 'COLLECTION_PLAYER_CITIES', 'EFFECT_GRANT_BUILDING_IN_CITY_IGNORE' );


-- 蒸英
-- 建造工业区时+35% [ICON_PRODUCTION] 生产力。
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_VICTORIA_ALT', 'TRAIT_GANGYEQU_AQUEDUCT_PRODUCTION_ZHENGQI_YINGGUO' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId, OwnerRequirementSetId )
VALUES ( 'TRAIT_GANGYEQU_AQUEDUCT_PRODUCTION_ZHENGQI_YINGGUO', 'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION', NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_GANGYEQU_AQUEDUCT_PRODUCTION_ZHENGQI_YINGGUO', 'DistrictType', 'DISTRICT_INDUSTRIAL_ZONE' ),
       ( 'TRAIT_GANGYEQU_AQUEDUCT_PRODUCTION_ZHENGQI_YINGGUO', 'Amount', '35' );

-- 拥有工业区的城市+8% [ICON_PRODUCTION] 生产力，该加成在拥有电力供给时翻倍。
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_VICTORIA_ALT' AND ModifierId = 'VICTORIA_PRODUCTION_WORKSHOP';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_VICTORIA_ALT' AND ModifierId = 'VICTORIA_PRODUCTION_FACTORY';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_VICTORIA_ALT' AND ModifierId = 'VICTORIA_PRODUCTION_POWER_PLANT';

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_VICTORIA_ALT', 'MODIFIER_TRAIT_LEADER_VICTORIA_ALT_EXTR_PRODUCTION' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_VICTORIA_ALT_EXTR_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', 0, 0, 0, NULL, 'NW_CITY_HAS_DISTRICT_INDUSTRIAL_ZONE' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_VICTORIA_ALT_EXTR_PRODUCTION', 'Amount', '8' ),
       ( 'MODIFIER_TRAIT_LEADER_VICTORIA_ALT_EXTR_PRODUCTION', 'YieldType', 'YIELD_PRODUCTION' );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_VICTORIA_ALT', 'MODIFIER_TRAIT_LEADER_VICTORIA_ALT_EXTR_PRODUCTION_POWERED' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_VICTORIA_ALT_EXTR_PRODUCTION_POWERED', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', 0, 0, 0, 'NW_PLAYER_HAS_TECH_INDUSTRIALIZATION', 'NW_CITY_HAS_DISTRICT_INDUSTRIAL_ZONE_AND_POWERED' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_VICTORIA_ALT_EXTR_PRODUCTION_POWERED', 'Amount', '8' ),
       ( 'MODIFIER_TRAIT_LEADER_VICTORIA_ALT_EXTR_PRODUCTION_POWERED', 'YieldType', 'YIELD_PRODUCTION' );
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'NW_CITY_HAS_DISTRICT_INDUSTRIAL_ZONE_AND_POWERED', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'NW_CITY_HAS_DISTRICT_INDUSTRIAL_ZONE_AND_POWERED', 'NW_REQ_CITY_IS_POWERED' ),
       ( 'NW_CITY_HAS_DISTRICT_INDUSTRIAL_ZONE_AND_POWERED', 'NW_CITY_HAS_DISTRICT_INDUSTRIAL_ZONE_REQUIREMENT' );
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'NW_REQ_CITY_IS_POWERED', 'REQUIREMENT_CITY_IS_POWERED' );

-- 所有可见的战略资源+1 [ICON_PRODUCTION] 生产力，解锁“批量生产”后额外+1 [ICON_PRODUCTION] 生产力。
UPDATE ModifierArguments
   SET Value='1'
 WHERE ModifierId = 'VICTORIA_STRATEGIC_RESOURCE' AND Name = 'Amount';

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_VICTORIA_ALT', 'VICTORIA_STRATEGIC_RESOURCE_IMPROVEMENT_TEAMPVP' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'VICTORIA_STRATEGIC_RESOURCE_IMPROVEMENT_TEAMPVP', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'PLAYER_PLOT_HAS_ANY_IMPROVEMENT_TEAMPVP' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'VICTORIA_STRATEGIC_RESOURCE_IMPROVEMENT_TEAMPVP', 'YieldType', 'YIELD_PRODUCTION' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'VICTORIA_STRATEGIC_RESOURCE_IMPROVEMENT_TEAMPVP', 'Amount', '1' );
--要求有任意改良
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'REQUIRES_PLOT_HAS_ANY_IMPROVEMENT_TEAMPVP', 'REQUIREMENT_PLOT_HAS_ANY_IMPROVEMENT' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'PLAYER_PLOT_HAS_ANY_IMPROVEMENT_TEAMPVP', 'NW_UTILS_PLAYER_HAS_TECH_MASS_PRODUCTION_REQUIREMENT' ),
       ( 'PLAYER_PLOT_HAS_ANY_IMPROVEMENT_TEAMPVP', 'REQUIRES_PLOT_HAS_ANY_IMPROVEMENT_TEAMPVP' ),
       ( 'PLAYER_PLOT_HAS_ANY_IMPROVEMENT_TEAMPVP', 'REQUIRES_PLOT_HAS_STRATEGIC' ),
       ( 'PLAYER_PLOT_HAS_ANY_IMPROVEMENT_TEAMPVP', 'REQUIRES_PLOT_HAS_VISIBLE_RESOURCE' );
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'PLAYER_PLOT_HAS_ANY_IMPROVEMENT_TEAMPVP', 'REQUIREMENTSET_TEST_ALL' );

-- 商英
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_ELIZABETH' AND ModifierId = 'ELIZABETH_TRADE_ROUTES_MODIFIER';
UPDATE Modifiers
   SET OwnerRequirementSetId = NULL, OwnerStackLimit = 4, SubjectStackLimit = 4
 WHERE ModifierId = 'ELIZABETH_TRADE_ROUTES_MODIFIER';
UPDATE ModifierArguments
   SET Value='1'
 WHERE ModifierId = 'ELIZABETH_TRADE_ROUTES_MODIFIER' AND Name = 'Amount';

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_ELIZABETH', 'MODIFIER_TRAIT_LEADER_ELIZABETH_TR' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_ELIZABETH_TR', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 0, 0, 0, NULL, 'NW_REQS_UNIT_IS_GREAT_PERSON_CLASS_ADMIRAL' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_ELIZABETH_TR', 'ModifierId', 'ELIZABETH_TRADE_ROUTES_MODIFIER' );

-- =============================================================
-- ETHIOPIA	埃塞俄比亚

UPDATE ModifierArguments
   SET Value=7
 WHERE ModifierId = 'TRAIT_FAITH_INTO_SCIENCE_HILLS' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value=7
 WHERE ModifierId = 'TRAIT_FAITH_INTO_CULTURE_HILLS' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value=3
 WHERE ModifierId = 'MENELIK_HILLS_COMBAT' AND Name = 'Amount';

-- UU
UPDATE Units
   SET Cost=200, BaseMoves=5
 WHERE UnitType = 'UNIT_ETHIOPIAN_OROMO_CAVALRY';

-- UI
UPDATE Improvements
   SET PrereqCivic='CIVIC_MYSTICISM'
 WHERE ImprovementType = 'IMPROVEMENT_ROCK_HEWN_CHURCH';
UPDATE Improvement_YieldChanges
   SET YieldChange = 0
 WHERE ImprovementType = 'IMPROVEMENT_ROCK_HEWN_CHURCH' AND YieldType = 'YIELD_FAITH';
-- 基础1锤/归正会+1信仰/神学+1信仰
INSERT INTO Improvement_YieldChanges ( ImprovementType, YieldType, YieldChange )
VALUES ( 'IMPROVEMENT_ROCK_HEWN_CHURCH', 'YIELD_PRODUCTION', '1' );
INSERT INTO Improvement_BonusYieldChanges ( Id, ImprovementType, YieldType, BonusYieldChange, PrereqCivic )
VALUES ( 'AS002', 'IMPROVEMENT_ROCK_HEWN_CHURCH', 'YIELD_FAITH', '1', 'CIVIC_REFORMED_CHURCH' ),
       ( 'AS001', 'IMPROVEMENT_ROCK_HEWN_CHURCH', 'YIELD_FAITH', '1', 'CIVIC_THEOLOGY' );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_MENELIK', 'STAVE_CHURCH_INCREASED_MOVEMENT_MODIFIER_AISAI' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'STAVE_CHURCH_INCREASED_MOVEMENT_MODIFIER_AISAI', 'FSS_MODIFIER_PLAYER_UNITS_ADJUST_IGNORE_TERRAIN_COST_AISAI', 'NW_REQS_UNIT_IS_CLASS_LANDCIVILIAN' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'STAVE_CHURCH_INCREASED_MOVEMENT_MODIFIER_AISAI', 'Ignore', 'true' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'STAVE_CHURCH_INCREASED_MOVEMENT_MODIFIER_AISAI', 'Type', 'HILLS' );
INSERT INTO Types ( Type, Kind )
VALUES ( 'FSS_MODIFIER_PLAYER_UNITS_ADJUST_IGNORE_TERRAIN_COST_AISAI', 'KIND_MODIFIER' );
INSERT INTO DynamicModifiers ( ModifierType, CollectionType, EffectType )
VALUES ( 'FSS_MODIFIER_PLAYER_UNITS_ADJUST_IGNORE_TERRAIN_COST_AISAI', 'COLLECTION_PLAYER_UNITS', 'EFFECT_ADJUST_UNIT_IGNORE_TERRAIN_COST' );
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'NW_REQS_UNIT_IS_CLASS_LANDCIVILIAN', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'NW_REQS_UNIT_IS_CLASS_LANDCIVILIAN', 'NW_REQ_UNIT_IS_CLASS_LANDCIVILIAN' );
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'NW_REQ_UNIT_IS_CLASS_LANDCIVILIAN', 'REQUIREMENT_UNIT_TAG_MATCHES' );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'NW_REQ_UNIT_IS_CLASS_LANDCIVILIAN', 'Tag', 'CLASS_LANDCIVILIAN' );

DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_ETHIOPIA' AND ModifierId = 'TRAIT_FAITH_RESOURCES';

-- 若有地块+1信仰
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_ETHIOPIA', 'AISAIEBIYA_RES_ADDFAITH' );
INSERT INTO Modifiers( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'AISAIEBIYA_RES_ADDFAITH', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'AISAIEBIYA_HAS_ANY_IMPROVEMENT' );
INSERT INTO ModifierArguments( ModifierId, Name, Value )
VALUES ( 'AISAIEBIYA_RES_ADDFAITH', 'YieldType', 'YIELD_FAITH' );
INSERT INTO ModifierArguments( ModifierId, Name, Value )
VALUES ( 'AISAIEBIYA_RES_ADDFAITH', 'Amount', '1' );
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'AISAIEBIYA_HAS_ANY_IMPROVEMENT', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'AISAIEBIYA_HAS_ANY_IMPROVEMENT', 'PLOT_HAS_ANY_IMPROVEMENT_TPB' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'AISAIEBIYA_HAS_ANY_IMPROVEMENT', 'PLOT_PLOT_HAS_ANY_TPB' );
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'PLOT_HAS_ANY_IMPROVEMENT_TPB', 'REQUIREMENT_PLOT_HAS_ANY_IMPROVEMENT' );
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'PLOT_PLOT_HAS_ANY_TPB', 'REQUIREMENT_PLOT_HAS_ANY_RESOURCE' );
-- =============================================================
-- FRANCE	法国

UPDATE Units
   SET Combat=65, BaseMoves=3
 WHERE UnitType = 'UNIT_FRENCH_GARDE_IMPERIALE';

-- 感谢O佬开源
-- 所有奇观提供的基础产出、住房、 宜居度、伟人点数和旅游业绩+100%。
CREATE TABLE IF NOT EXISTS NW_FRANCE_WONDERS
    (
        BuildingType TEXT NOT NULL,
        PRIMARY KEY (BuildingType),
        FOREIGN KEY (BuildingType) REFERENCES Buildings (BuildingType) ON DELETE CASCADE ON UPDATE CASCADE
    );
INSERT OR IGNORE INTO NW_FRANCE_WONDERS( BuildingType )
SELECT BuildingType
  FROM Buildings
 WHERE IsWonder = 1;

-- 基础产出
INSERT INTO TraitModifiers ( TraitType, ModifierId )
SELECT 'TRAIT_CIVILIZATION_WONDER_TOURISM', 'MODFEAT_FRANCE_DOUBLE_YIELD_' || BuildingType || '_' || YieldType ||
                                            '_GRANT'
  FROM Building_YieldChanges
 WHERE BuildingType IN NW_FRANCE_WONDERS;
INSERT INTO Modifiers ( ModifierId, ModifierType )
SELECT 'MODFEAT_FRANCE_DOUBLE_YIELD_' || BuildingType || '_' || YieldType || '_GRANT',
       'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER'
  FROM Building_YieldChanges
 WHERE BuildingType IN NW_FRANCE_WONDERS;
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'MODFEAT_FRANCE_DOUBLE_YIELD_' || BuildingType || '_' || YieldType || '_GRANT', 'ModifierId',
       'MODFEAT_FRANCE_DOUBLE_YIELD_' || BuildingType || '_' || YieldType
  FROM Building_YieldChanges
 WHERE BuildingType IN NW_FRANCE_WONDERS;

INSERT INTO TraitModifiers ( TraitType, ModifierId )
SELECT 'TRAIT_CIVILIZATION_WONDER_TOURISM',
       'MODFEAT_FRANCE_DOUBLE_YIELD_' || BuildingType || '_' || YieldType || '_GRANT_CAPTURE'
  FROM Building_YieldChanges
 WHERE BuildingType IN NW_FRANCE_WONDERS;
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent )
SELECT 'MODFEAT_FRANCE_DOUBLE_YIELD_' || BuildingType || '_' || YieldType || '_GRANT_CAPTURE',
       'MODIFIER_PLAYER_CAPTURED_CITY_ATTACH_MODIFIER', 0, 1
  FROM Building_YieldChanges
 WHERE BuildingType IN NW_FRANCE_WONDERS;
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'MODFEAT_FRANCE_DOUBLE_YIELD_' || BuildingType || '_' || YieldType || '_GRANT_CAPTURE', 'ModifierId',
       'MODFEAT_FRANCE_DOUBLE_YIELD_' || BuildingType || '_' || YieldType
  FROM Building_YieldChanges
 WHERE BuildingType IN NW_FRANCE_WONDERS;

INSERT INTO Modifiers ( ModifierId, ModifierType )
SELECT 'MODFEAT_FRANCE_DOUBLE_YIELD_' || BuildingType || '_' || YieldType, 'MODIFIER_BUILDING_YIELD_CHANGE'
  FROM Building_YieldChanges
 WHERE BuildingType IN NW_FRANCE_WONDERS;
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'MODFEAT_FRANCE_DOUBLE_YIELD_' || BuildingType || '_' || YieldType, 'YieldType', YieldType
  FROM Building_YieldChanges
 WHERE BuildingType IN NW_FRANCE_WONDERS
 UNION
SELECT 'MODFEAT_FRANCE_DOUBLE_YIELD_' || BuildingType || '_' || YieldType, 'BuildingType', BuildingType
  FROM Building_YieldChanges
 WHERE BuildingType IN NW_FRANCE_WONDERS
 UNION
SELECT 'MODFEAT_FRANCE_DOUBLE_YIELD_' || BuildingType || '_' || YieldType, 'Amount', YieldChange
  FROM Building_YieldChanges
 WHERE BuildingType IN NW_FRANCE_WONDERS;

-- 住房
INSERT INTO TraitModifiers ( TraitType, ModifierId )
SELECT 'TRAIT_CIVILIZATION_WONDER_TOURISM', 'MODIFIER_TRAIT_CIVILIZATION_WONDER_TOURISM_HOUSING_' || BuildingType
  FROM Buildings
 WHERE IsWonder AND Housing > 0;
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
SELECT 'MODIFIER_TRAIT_CIVILIZATION_WONDER_TOURISM_HOUSING_' || BuildingType,
       'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_HOUSING', 0, 0, 0, NULL, 'NW_CITY_HAS_' || BuildingType
  FROM Buildings
 WHERE IsWonder AND Housing > 0;
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'MODIFIER_TRAIT_CIVILIZATION_WONDER_TOURISM_HOUSING_' || BuildingType, 'Amount', Housing
  FROM Buildings
 WHERE IsWonder AND Housing > 0;

-- 宜居度
INSERT INTO TraitModifiers ( TraitType, ModifierId )
SELECT 'TRAIT_CIVILIZATION_WONDER_TOURISM', 'MODIFIER_TRAIT_CIVILIZATION_WONDER_TOURISM_AMEN_' || BuildingType
  FROM Buildings
 WHERE IsWonder AND Entertainment > 0;
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
SELECT 'MODIFIER_TRAIT_CIVILIZATION_WONDER_TOURISM_AMEN_' || BuildingType,
       'MODIFIER_PLAYER_CITIES_ADJUST_TRAIT_AMENITY', 0, 0, 0, NULL, 'NW_CITY_HAS_' || BuildingType
  FROM Buildings
 WHERE IsWonder AND Entertainment > 0;
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'MODIFIER_TRAIT_CIVILIZATION_WONDER_TOURISM_AMEN_' || BuildingType, 'Amount', Entertainment
  FROM Buildings
 WHERE IsWonder AND Entertainment > 0;

-- 伟人点数
INSERT INTO TraitModifiers ( TraitType, ModifierId )
SELECT 'TRAIT_CIVILIZATION_WONDER_TOURISM',
       'MODIFIER_TRAIT_CIVILIZATION_WONDER_TOURISM_' || BuildingType || '_' || GreatPersonClassType
  FROM Building_GreatPersonPoints
 WHERE BuildingType IN NW_FRANCE_WONDERS;
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
SELECT 'MODIFIER_TRAIT_CIVILIZATION_WONDER_TOURISM_' || BuildingType || '_' || GreatPersonClassType,
       'MODIFIER_NW_DTMS_CITIES_ADJUST_GREAT_PERSON_POINTS', 0, 0, 0, NULL, 'NW_CITY_HAS_' || BuildingType
  FROM Building_GreatPersonPoints
 WHERE BuildingType IN NW_FRANCE_WONDERS;
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'MODIFIER_TRAIT_CIVILIZATION_WONDER_TOURISM_' || BuildingType || '_' || GreatPersonClassType, 'Amount',
       PointsPerTurn
  FROM Building_GreatPersonPoints
 WHERE BuildingType IN NW_FRANCE_WONDERS
 UNION
SELECT 'MODIFIER_TRAIT_CIVILIZATION_WONDER_TOURISM_' || BuildingType || '_' || GreatPersonClassType,
       'GreatPersonClassType', GreatPersonClassType
  FROM Building_GreatPersonPoints
 WHERE BuildingType IN NW_FRANCE_WONDERS;

INSERT INTO Types ( Type, Kind )
VALUES ( 'MODIFIER_NW_DTMS_CITIES_ADJUST_GREAT_PERSON_POINTS', 'KIND_MODIFIER' );
INSERT INTO DynamicModifiers ( ModifierType, CollectionType, EffectType )
VALUES ( 'MODIFIER_NW_DTMS_CITIES_ADJUST_GREAT_PERSON_POINTS', 'COLLECTION_PLAYER_CITIES', 'EFFECT_ADJUST_DISTRICT_GREAT_PERSON_POINTS' );

-- 黑法
--间谍
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'FLYING_SQUADRON_TRAIT' AND ModifierId = 'UNIQUE_LEADER_SPIES_START_PROMOTED';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'FLYING_SQUADRON_TRAIT' AND ModifierId = 'UNIQUE_LEADER_ADD_SPY_CAPACITY';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'FLYING_SQUADRON_TRAIT' AND ModifierId = 'UNIQUE_LEADER_ADD_SPY_UNIT';

--能见度
UPDATE Modifiers
   SET OwnerRequirementSetId = 'NW_PLAYER_HAS_CIVIC_CIVIL_SERVICE'
 WHERE ModifierId = 'UNIQUE_LEADER_ADD_VISIBILITY';
UPDATE ModifierArguments
   SET Value=1
 WHERE ModifierId = 'UNIQUE_LEADER_ADD_VISIBILITY' AND Name = 'Amount';

DELETE
  FROM NW_FRANCE_WONDERS
 WHERE BuildingType IN (SELECT b.BuildingType
                          FROM Buildings b
                                   LEFT JOIN Civics c
                                   ON b.PrereqCivic = c.CivicType
                                   LEFT JOIN Technologies t
                                   ON b.PrereqTech = t.TechnologyType
                         WHERE b.IsWonder = 1 AND (c.EraType = 'ERA_ANCIENT' OR t.EraType = 'ERA_ANCIENT'));

INSERT INTO TraitModifiers ( TraitType, ModifierId )
SELECT 'FLYING_SQUADRON_TRAIT', 'UNIQUE_LEADER_ADD_SPY_CAPACITY_' || BuildingType
  FROM NW_FRANCE_WONDERS;
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
SELECT 'UNIQUE_LEADER_ADD_SPY_CAPACITY_' || BuildingType, 'MODIFIER_PLAYER_GRANT_UNIT_IN_CAPITAL', 1, 1, 0,
       'NW_PLAYER_HAS_' || BuildingType, NULL
  FROM NW_FRANCE_WONDERS;
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'UNIQUE_LEADER_ADD_SPY_CAPACITY_' || BuildingType, 'AllowUniqueOverride', '0'
  FROM NW_FRANCE_WONDERS
 UNION
SELECT 'UNIQUE_LEADER_ADD_SPY_CAPACITY_' || BuildingType, 'Amount', '1'
  FROM NW_FRANCE_WONDERS
 UNION
SELECT 'UNIQUE_LEADER_ADD_SPY_CAPACITY_' || BuildingType, 'UnitType', 'UNIT_SPY'
  FROM NW_FRANCE_WONDERS;

-- 埃莉诺（法国）
-- 同爱英

-- 金法
-- 解锁写作时也解锁剧院广场。剧院广场从相邻奢侈品资源获得大量相邻加成。可在拥有剧院广场区域的任意城市中开展“宫廷盛会”项目。建造剧院广场建筑时+70%生产力。

--白法 寻欢作乐
UPDATE Projects
   SET Cost='142', CostProgressionParam1='0'
 WHERE ProjectType = 'PROJECT_COURT_FESTIVAL';
UPDATE ModifierArguments
   SET Value='0'
 WHERE ModifierId = 'PROJECT_COMPLETION_GRANT_CULTURE_BASED_ON_EXCESS_LUXURIES' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='4'
 WHERE ModifierId = 'PROJECT_COMPLETION_GRANT_TOURISM_BASED_ON_EXCESS_LUXURIES' AND Name = 'Amount';
--宫廷盛会 文化
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent )
VALUES ( 'BAIFA_GONGTINGSHENGHU_ADD_CULTURE', 'MODIFIER_PLAYER_GRANT_YIELD', 1, 1 );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'BAIFA_GONGTINGSHENGHU_ADD_CULTURE', 'YieldType', 'YIELD_CULTURE' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'BAIFA_GONGTINGSHENGHU_ADD_CULTURE', 'Amount', '32' );
INSERT INTO ProjectCompletionModifiers ( ProjectType, ModifierId )
VALUES ( 'PROJECT_COURT_FESTIVAL', 'BAIFA_GONGTINGSHENGHU_ADD_CULTURE' );

-- 删除原效果
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_MAGNIFICENCES' AND
     ModifierId = 'MAGNIFICENCES_CULTURE_LUXURY_ADJACENT_TO_THEATER_SQUARE_OR_CHATEAU';

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_MAGNIFICENCES', 'MODIFIER_TRAIT_LEADER_MAGNIFICENCES_DIS' );
INSERT INTO Modifiers ( ModifierId, ModifierType )
VALUES ( 'MODIFIER_TRAIT_LEADER_MAGNIFICENCES_DIS', 'MODIFIER_PLAYER_ADJUST_DISTRICT_UNLOCK' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_MAGNIFICENCES_DIS', 'DistrictType', 'DISTRICT_THEATER' ),
       ( 'MODIFIER_TRAIT_LEADER_MAGNIFICENCES_DIS', 'CivicType', 'CIVIC_EARLY_EMPIRE' );

INSERT INTO Adjacency_YieldChanges( ID, Description, YieldType, AdjacentResourceClass, YieldChange )
VALUES ( 'TRAIT_LEADER_MAGNIFICENCES_THEATER', 'LOC_TRAIT_LEADER_MAGNIFICENCES_THEATER', 'YIELD_CULTURE',
         'RESOURCECLASS_LUXURY', 2 );
INSERT INTO District_Adjacencies( DistrictType, YieldChangeId )
VALUES ( 'DISTRICT_THEATER', 'TRAIT_LEADER_MAGNIFICENCES_THEATER' );

INSERT OR IGNORE INTO ExcludedAdjacencies( TraitType, YieldChangeId )
SELECT DISTINCT TraitType, 'TRAIT_LEADER_MAGNIFICENCES_THEATER'
  FROM LeaderTraits
 WHERE LeaderType NOT LIKE 'LEADER\_MINOR\_CIV\_%' ESCAPE '\'
 GROUP BY TraitType;
DELETE
  FROM ExcludedAdjacencies
 WHERE YieldChangeId IN ('TRAIT_LEADER_MAGNIFICENCES_THEATER') AND
     TraitType IN (SELECT TraitType FROM LeaderTraits WHERE LeaderType = 'LEADER_CATHERINE_DE_MEDICI_ALT');

-- 兼容新加入的特性
CREATE TRIGGER Nw_GoldFrance_District_Adjacencies
    AFTER INSERT
    ON LeaderTraits
    WHEN new.LeaderType NOT LIKE 'LEADER\_MINOR\_CIV\_%' ESCAPE '\'
BEGIN
    INSERT OR IGNORE INTO ExcludedAdjacencies( TraitType, YieldChangeId )
    VALUES ( new.TraitType, 'TRAIT_LEADER_MAGNIFICENCES_THEATER' );
    DELETE
      FROM ExcludedAdjacencies
     WHERE YieldChangeId IN ('TRAIT_LEADER_MAGNIFICENCES_THEATER') AND
         TraitType IN (SELECT TraitType FROM LeaderTraits WHERE LeaderType = 'LEADER_CATHERINE_DE_MEDICI_ALT');
END;

-- =============================================================
-- GAUL	高卢

UPDATE Modifiers
   SET OwnerRequirementSetId='NW_PLAYER_HAS_CIVIC_FEUDALISM'
 WHERE ModifierId = 'GAUL_MINE_CULTURE';

--文化比例
UPDATE Modifiers
   SET OwnerRequirementSetId='NW_PLAYER_HAS_CIVIC_CODE_OF_LAWS'
 WHERE ModifierId = 'TRAIT_GRANT_CULTURE_UNIT_TRAINED';
UPDATE ModifierArguments
   SET Value=8
 WHERE ModifierId = 'TRAIT_GRANT_CULTURE_UNIT_TRAINED' AND Name = 'UnitProductionPercent';


--相邻+1力
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_AMBIORIX' AND ModifierId = 'TRAIT_NEIGHBOR_COMBAT';

--高炉枪佣兵
UPDATE Units
   SET Cost=40
 WHERE UnitType = 'UNIT_GAUL_GAESATAE';
UPDATE ModifierArguments
   SET Value=5
 WHERE ModifierId = 'GAESATAE_STRONG_AGAINST_STRONGER_UNITS' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value=3
 WHERE ModifierId = 'GAESATAE_STRONG_AGAINST_DISTRICTS' AND Name = 'Amount';

-- +2
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_AMBIORIX', 'TRAIT_FALLBABYLON_COMBAT_BONUS1' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'TRAIT_FALLBABYLON_COMBAT_BONUS1', 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH', 'ATTACKING_REQUIREMENT_SET1' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_FALLBABYLON_COMBAT_BONUS1', 'Amount', '2' );
INSERT INTO ModifierStrings ( ModifierId, Context, Text )
VALUES ( 'TRAIT_FALLBABYLON_COMBAT_BONUS1', 'Preview', 'LOC_ABILITY_AMBIORIX_NAME2' );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_AMBIORIX', 'TRAIT_FALLBABYLON_COMBAT_BONUS2' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'TRAIT_FALLBABYLON_COMBAT_BONUS2', 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH', 'ATTACKING_REQUIREMENT_SET2' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_FALLBABYLON_COMBAT_BONUS2', 'Amount', '2' );
INSERT INTO ModifierStrings ( ModifierId, Context, Text )
VALUES ( 'TRAIT_FALLBABYLON_COMBAT_BONUS2', 'Preview', 'LOC_ABILITY_AMBIORIX_NAME2' );
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'ATTACKING_REQUIREMENT_SET2', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'ATTACKING_REQUIREMENT_SET2', 'UNIT_CLASS_1231_REQUIREMENT' );
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'UNIT_CLASS_1231_REQUIREMENT', 'REQUIREMENT_UNIT_TAG_MATCHES' );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'UNIT_CLASS_1231_REQUIREMENT', 'Tag', 'CLASS_RANGED' );

-- +3
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_AMBIORIX', 'TRAIT_FALLBABYLON_COMBAT_BONUS3' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'TRAIT_FALLBABYLON_COMBAT_BONUS3', 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH', 'ATTACKING_REQUIREMENT_SET3' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_FALLBABYLON_COMBAT_BONUS3', 'Amount', '3' );
INSERT INTO ModifierStrings ( ModifierId, Context, Text )
VALUES ( 'TRAIT_FALLBABYLON_COMBAT_BONUS3', 'Preview', 'LOC_ABILITY_AMBIORIX_NAME' );
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'ATTACKING_REQUIREMENT_SET3', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'ATTACKING_REQUIREMENT_SET3', 'UNIT_CLASS_1232_REQUIREMENT' );
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'UNIT_CLASS_1232_REQUIREMENT', 'REQUIREMENT_UNIT_TAG_MATCHES' );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'UNIT_CLASS_1232_REQUIREMENT', 'Tag', 'CLASS_ANTI_CAVALRY' );

-- =============================================================
-- GEORGIA	格鲁吉亚
-- 移除原有特性
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_RELIGION_CITY_STATES' AND ModifierId = 'TRAIT_PROTECTORATE_WAR_FAITH';
-- 格鲁吉亚 击杀+信仰
UPDATE ModifierArguments
   SET Value=100
 WHERE ModifierId = 'TRAIT_LEADER_FAITH_KILLS' AND Name = 'PercentDefeatedStrength';

-- 格鲁吉亚 塔玛丽
UPDATE Units
   SET Combat=48, Cost=170
 WHERE UnitType = 'UNIT_GEORGIAN_KHEVSURETI';
UPDATE ModifierArguments
   SET Value='3'
 WHERE ModifierId = 'KHEVSURETI_HILLS_BUFF' AND Name = 'Amount';

DELETE
  FROM BuildingPrereqs
 WHERE Building = 'BUILDING_TSIKHE';
UPDATE BuildingReplaces
   SET ReplacesBuildingType='BUILDING_WALLS'
 WHERE CivUniqueBuildingType = 'BUILDING_TSIKHE';
UPDATE Buildings
   SET Cost=35, PrereqTech='TECH_MASONRY', OuterDefenseHitPoints=60, OuterDefenseStrength=2
 WHERE BuildingType = 'BUILDING_TSIKHE';
UPDATE Building_YieldChanges
   SET YieldChange='3'
 WHERE BuildingType = 'BUILDING_TSIKHE' AND YieldType = 'YIELD_FAITH';

UPDATE Buildings
   SET PrereqTech='TECH_MINING'
 WHERE BuildingType = 'BUILDING_TSIKHE';

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_RELIGION_CITY_STATES', 'TRAIT_FREE_TECH_MINING_TAMALI' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent )
VALUES ( 'TRAIT_FREE_TECH_MINING_TAMALI', 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY', 1, 1 );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_FREE_TECH_MINING_TAMALI', 'TechType', 'TECH_MINING' );

-- =============================================================
-- GERMANY	德国

-- 文德 路德维希二世
-- 世界奇观为所在城市+1 [ICON_Amenities] 宜居度。6个单元格内尚无世界奇观的城市建造世界奇观时+25% [ICON_PRODUCTION] 生产力。
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_LUDWIG' AND ModifierId = 'LUDWIG_WONDER_ADJACENCY';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_LUDWIG' AND ModifierId = 'LUDWIG_CULTURE_TOURISM_DISTRICTS';

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_LUDWIG', 'MODIFIER_TRAIT_LEADER_LUDWIG_AMEN' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_LUDWIG_AMEN', 'MODIFIER_PLAYER_CITIES_ADJUST_TRAIT_AMENITY', 0, 0, 0, NULL, 'REQS_NW_CITY_HAS_ANY_WONDER' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_LUDWIG_AMEN', 'Amount', '1' );
-- RequirementSets
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'REQS_NW_CITY_HAS_ANY_WONDER', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'REQS_NW_CITY_HAS_ANY_WONDER', 'REQ_NW_CITY_HAS_ANY_WONDER' );
-- Requirements
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'REQ_NW_CITY_HAS_ANY_WONDER', 'REQUIREMENT_CITY_HAS_ANY_WONDER' );


INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_LUDWIG', 'MODIFIER_TRAIT_LEADER_LUDWIG_WP' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_LUDWIG_WP', 'MODIFIER_PLAYER_CITIES_ADJUST_WONDER_PRODUCTION', 0, 0, 0, NULL, 'REQS_NW_CITY_NOT_ADJACENT_ANY_WONDER_IN_6TILES' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_LUDWIG_WP', 'Amount', '25' );
-- RequirementSets
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'REQS_NW_CITY_NOT_ADJACENT_ANY_WONDER_IN_6TILES', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
SELECT 'REQS_NW_CITY_NOT_ADJACENT_ANY_WONDER_IN_6TILES', 'REQ_NW_CITY_NOT_ADJACENT_' || BuildingType || '_IN_6TILES'
  FROM Buildings
 WHERE IsWonder = 1;
INSERT INTO Requirements ( RequirementId, RequirementType, Inverse )
SELECT 'REQ_NW_CITY_NOT_ADJACENT_' || BuildingType || '_IN_6TILES', 'REQUIREMENT_PLOT_ADJACENT_BUILDING_TYPE_MATCHES', 1
  FROM Buildings
 WHERE IsWonder = 1;
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
SELECT 'REQ_NW_CITY_NOT_ADJACENT_' || BuildingType || '_IN_6TILES', 'BuildingType', BuildingType
  FROM Buildings
 WHERE IsWonder = 1
 UNION
SELECT 'REQ_NW_CITY_NOT_ADJACENT_' || BuildingType || '_IN_6TILES', 'MaxRange', '6'
  FROM Buildings
 WHERE IsWonder = 1
 UNION
SELECT 'REQ_NW_CITY_NOT_ADJACENT_' || BuildingType || '_IN_6TILES', 'MinRange', '0'
  FROM Buildings
 WHERE IsWonder = 1;

-- 武德
-- 额外的军事政策槽位。单位在 [ICON_Capital] 首都5个单元格内作战时，每距离 [ICON_Capital] 首都1个单元格便+1 [ICON_Strength] 战斗力。
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_HOLY_ROMAN_EMPEROR' AND ModifierId = 'TRAIT_COMBAT_BONUS_CITY_STATES';

INSERT INTO TraitModifiers ( TraitType, ModifierId )
SELECT 'TRAIT_LEADER_HOLY_ROMAN_EMPEROR', 'MODIFIER_TRAIT_LEADER_HOLY_ROMAN_EMPEROR_ATTACH_' || number
  FROM temp_numbers
 WHERE number <= 5;
INSERT INTO Modifiers ( ModifierId, ModifierType )
SELECT 'MODIFIER_TRAIT_LEADER_HOLY_ROMAN_EMPEROR_ATTACH_' || number, 'MODIFIER_PLAYER_CAPITAL_CITY_ATTACH_MODIFIER'
  FROM temp_numbers
 WHERE number <= 5;
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'MODIFIER_TRAIT_LEADER_HOLY_ROMAN_EMPEROR_ATTACH_' || number, 'ModifierId',
       'MODIFIER_UNIT_PROPERTY_' || number || '_CAPITAL_AWAY'
  FROM temp_numbers
 WHERE number <= 5;
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
SELECT 'MODIFIER_UNIT_PROPERTY_' || number || '_CAPITAL_AWAY', 'MODIFIER_NW_PLAYER_UNITS_ADJUST_PROPERTY',
       'NW_OWNER_' || number || '_PLOTS_AWAY'
  FROM temp_numbers
 WHERE number <= 5;
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'MODIFIER_UNIT_PROPERTY_' || number || '_CAPITAL_AWAY', 'Key', 'UNIT_PROPERTY_CAPITAL_AWAY'
  FROM temp_numbers
 WHERE number <= 5
 UNION
SELECT 'MODIFIER_UNIT_PROPERTY_' || number || '_CAPITAL_AWAY', 'Amount', 1
  FROM temp_numbers
 WHERE number <= 5;

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_HOLY_ROMAN_EMPEROR', 'MODIFIER_TRAIT_LEADER_HOLY_ROMAN_EMPEROR_ADJUST_COMBAT_STRENGTH_ATTACH' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_HOLY_ROMAN_EMPEROR_ADJUST_COMBAT_STRENGTH_ATTACH', 'MODIFIER_PLAYER_CAPITAL_CITY_ATTACH_MODIFIER', 0, 0, 0, NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_HOLY_ROMAN_EMPEROR_ADJUST_COMBAT_STRENGTH_ATTACH', 'ModifierId', 'MODIFIER_TRAIT_LEADER_HOLY_ROMAN_EMPEROR_ADJUST_COMBAT_STRENGTH' );

INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_HOLY_ROMAN_EMPEROR_ADJUST_COMBAT_STRENGTH', 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH', 0, 0, 0, NULL, 'NW_OWNER_MIN5_PLOTS_AWAY' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_HOLY_ROMAN_EMPEROR_ADJUST_COMBAT_STRENGTH', 'Key', 'UNIT_PROPERTY_CAPITAL_AWAY' );
INSERT INTO ModifierStrings ( ModifierId, Context, Text )
VALUES ( 'MODIFIER_TRAIT_LEADER_HOLY_ROMAN_EMPEROR_ADJUST_COMBAT_STRENGTH', 'Preview', 'LOC_MODIFIER_TRAIT_LEADER_HOLY_ROMAN_EMPEROR_ADJUST_COMBAT_STRENGTH' );
-- RequirementSets
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'NW_OWNER_MIN5_PLOTS_AWAY', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'NW_OWNER_MIN5_PLOTS_AWAY', 'REQ_NW_OWNER_MIN5_PLOTS_AWAY' );
-- Requirements
INSERT INTO Requirements ( RequirementId, RequirementType, Inverse )
VALUES ( 'REQ_NW_OWNER_MIN5_PLOTS_AWAY', 'REQUIREMENT_PLOT_ADJACENT_TO_OWNER', 1 );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'REQ_NW_OWNER_MIN5_PLOTS_AWAY', 'MaxDistance', '5' ),
       ( 'REQ_NW_OWNER_MIN5_PLOTS_AWAY', 'MinDistance', '0' );

-- =============================================================
-- GRAN_COLOMBIA	大哥伦比亚

-- UI
UPDATE Improvements
   SET PrereqCivic='CIVIC_FEUDALISM'
 WHERE ImprovementType = 'IMPROVEMENT_HACIENDA';
UPDATE Improvement_YieldChanges
   SET YieldChange='2'
 WHERE ImprovementType = 'IMPROVEMENT_HACIENDA' AND YieldType = 'YIELD_PRODUCTION';
UPDATE Improvement_YieldChanges
   SET YieldChange='0'
 WHERE ImprovementType = 'IMPROVEMENT_HACIENDA' AND YieldType = 'YIELD_GOLD';
UPDATE Adjacency_YieldChanges
   SET TilesRequired='3'
 WHERE ID = 'Hacienda_HaciendaAdjacency';
UPDATE Adjacency_YieldChanges
   SET TilesRequired='2'
 WHERE ID = 'Hacienda_AdvancedHaciendaAdjacency';
-- 总指挥
UPDATE ModifierArguments
   SET Value='2'
 WHERE ModifierId = 'COMMANDANTE_CAVALRY_BUFF' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='2'
 WHERE ModifierId = 'COMMANDANTE_MELEE_ANTICAV_BUFF' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='2'
 WHERE ModifierId = 'COMMANDANTE_UNIT_STR_VS_DISTRICTS' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='4'
 WHERE ModifierId = 'ABILITY_COMMANDANTE_UNIT_STRENGTH_BUFF' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='25'
 WHERE ModifierId = 'GREAT_PERSON_INDIVIDUAL_RIBAS_DAMAGE_NEARBY_UNITS' AND Name = 'Amount';
-- 次数
UPDATE GreatPersonIndividuals
   SET ActionCharges='2'
 WHERE GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_COMMANDANTE_JOSE_DE_SUCRE';
UPDATE GreatPersonIndividuals
   SET ActionCharges='2'
 WHERE GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_COMMANDANTE_MACGREGOR';
UPDATE GreatPersonIndividuals
   SET ActionCharges='1'
 WHERE GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_COMMANDANTE_RIBAS';
UPDATE GreatPersonIndividuals
   SET ActionCharges='1'
 WHERE GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_COMMANDANTE_URDANETA';
UPDATE GreatPersonIndividuals
   SET ActionCharges='1'
 WHERE GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_COMMANDANTE_MARINO';
UPDATE ModifierArguments
   SET Value=1
 WHERE ModifierId = 'LLANERO_ADJACENCY_STRENGTH' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value=2
 WHERE ModifierId = 'COMANDANTE_AOE_STRENGTH' AND Name = 'Amount';

--牛仔骑
UPDATE Units
   SET Cost=310, Combat=61, BaseMoves=6
 WHERE UnitType = 'UNIT_COLOMBIAN_LLANERO';

INSERT INTO GreatPersonIndividualBirthModifiers ( GreatPersonIndividualType, ModifierId )
VALUES ( 'GREAT_PERSON_INDIVIDUAL_COMMANDANTE_JOSE_DE_SUCRE', 'GREATPERSON_COMANDANTE_MOVEMENT_AOE_LAND' );
INSERT INTO GreatPersonIndividualBirthModifiers ( GreatPersonIndividualType, ModifierId )
VALUES ( 'GREAT_PERSON_INDIVIDUAL_COMMANDANTE_PAULA_SANTANDER', 'GREATPERSON_COMANDANTE_MOVEMENT_AOE_LAND' );
INSERT INTO GreatPersonIndividualBirthModifiers ( GreatPersonIndividualType, ModifierId )
VALUES ( 'GREAT_PERSON_INDIVIDUAL_COMMANDANTE_ANTONIO_PAEZ', 'GREATPERSON_COMANDANTE_MOVEMENT_AOE_LAND' );
INSERT INTO GreatPersonIndividualBirthModifiers ( GreatPersonIndividualType, ModifierId )
VALUES ( 'GREAT_PERSON_INDIVIDUAL_COMMANDANTE_URDANETA', 'GREATPERSON_COMANDANTE_MOVEMENT_AOE_LAND' );
INSERT INTO GreatPersonIndividualBirthModifiers ( GreatPersonIndividualType, ModifierId )
VALUES ( 'GREAT_PERSON_INDIVIDUAL_COMMANDANTE_MARINO', 'GREATPERSON_COMANDANTE_MOVEMENT_AOE_LAND' );
INSERT INTO GreatPersonIndividualBirthModifiers ( GreatPersonIndividualType, ModifierId )
VALUES ( 'GREAT_PERSON_INDIVIDUAL_COMMANDANTE_MACGREGOR', 'GREATPERSON_COMANDANTE_MOVEMENT_AOE_LAND' );
INSERT INTO GreatPersonIndividualBirthModifiers ( GreatPersonIndividualType, ModifierId )
VALUES ( 'GREAT_PERSON_INDIVIDUAL_COMMANDANTE_PIAR', 'GREATPERSON_COMANDANTE_MOVEMENT_AOE_LAND' );
INSERT INTO GreatPersonIndividualBirthModifiers ( GreatPersonIndividualType, ModifierId )
VALUES ( 'GREAT_PERSON_INDIVIDUAL_COMMANDANTE_NARINO', 'GREATPERSON_COMANDANTE_MOVEMENT_AOE_LAND' );
INSERT INTO GreatPersonIndividualBirthModifiers ( GreatPersonIndividualType, ModifierId )
VALUES ( 'GREAT_PERSON_INDIVIDUAL_COMMANDANTE_MONTILLA', 'GREATPERSON_COMANDANTE_MOVEMENT_AOE_LAND' );
INSERT INTO GreatPersonIndividualBirthModifiers ( GreatPersonIndividualType, ModifierId )
VALUES ( 'GREAT_PERSON_INDIVIDUAL_COMMANDANTE_RIBAS', 'GREATPERSON_COMANDANTE_MOVEMENT_AOE_LAND' );

DELETE
  FROM TypeTags
 WHERE Type = 'ABILITY_EJERCITO_PATRIOTA_EXTRA_MOVEMENT';
INSERT INTO TypeTags( Type, Tag )
VALUES ( 'ABILITY_EJERCITO_PATRIOTA_EXTRA_MOVEMENT', 'CLASS_LANDCIVILIAN' );

UPDATE Modifiers
   SET ModifierType = 'MODIFIER_PLAYER_UNITS_ADJUST_FRIENDLY_TERRITORY_START_MOVEMENT'
 WHERE ModifierId = 'EJERCITO_PATRIOTA_EXTRA_MOVEMENT';

-- =============================================================
-- GREECE	希腊
UPDATE Modifiers
   SET OwnerRequirementSetId='NW_PLAYER_HAS_CIVIC_EARLY_EMPIRE'
 WHERE ModifierId = 'TRAIT_WILDCARD_GOVERNMENT_SLOT';
-- 随机鼓舞
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_PLATOS_REPUBLIC', 'MODIFIER_TRAIT_CIVILIZATION_PLATOS_REPUBLIC_CIVIC_BOOST' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_CIVILIZATION_PLATOS_REPUBLIC_CIVIC_BOOST', 'MODIFIER_PLAYER_GRANT_RANDOM_CIVIC_BOOST_GOODY_HUT', 0, 0, 0, NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_CIVILIZATION_PLATOS_REPUBLIC_CIVIC_BOOST', 'Amount', '3' );

--希腊 军事+0力 UU回调
UPDATE Units
   SET MandatoryObsoleteTech='TECH_MILITARY_TACTICS'
 WHERE UnitType = 'UNIT_GREEK_HOPLITE';
UPDATE ModifierArguments
   SET Value='0'
 WHERE ModifierId = 'GORGO_POLICY_SLOT_COMBAT_BONUS' AND Name = 'Amount';
UPDATE Units
   SET Combat=25
 WHERE UnitType = 'UNIT_GREEK_HOPLITE';

-- 伯利克里
UPDATE ModifierArguments
   SET Value = 7
 WHERE ModifierId = 'TRAIT_CULTURE_PER_CITY_STATE_TRIBUTARY' AND Name = 'Amount';

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_SURROUNDED_BY_GLORY', 'MODIFIER_TRAIT_LEADER_SURROUNDED_BY_GLORY_ADD_PRODUCTION' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_SURROUNDED_BY_GLORY_ADD_PRODUCTION', 'MODIFIER_PLAYER_CITIES_DISTRICT_ADJACENCY', 0, 0,
         0, NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_SURROUNDED_BY_GLORY_ADD_PRODUCTION', 'Amount', 1 ),
       ( 'MODIFIER_TRAIT_LEADER_SURROUNDED_BY_GLORY_ADD_PRODUCTION', 'Description',
         'LOC_DISTRICT_ACROPOLIS_ADD_PRODUCTION' ),
       ( 'MODIFIER_TRAIT_LEADER_SURROUNDED_BY_GLORY_ADD_PRODUCTION', 'DistrictType', 'DISTRICT_ACROPOLIS' ),
       ( 'MODIFIER_TRAIT_LEADER_SURROUNDED_BY_GLORY_ADD_PRODUCTION', 'YieldType', 'YIELD_PRODUCTION' );

INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
SELECT 'NW_MODIFIER_PERICLES_SUZ_' || LeaderType, 'MODIFIER_PLAYER_ADJUST_TOURISM',
       'NW_PLAYER_IS_SUZERAIN_OF_' || LeaderType || '_REQUIREMENTS'
  FROM Leaders
 WHERE InheritFrom IN ('LEADER_MINOR_CIV_CULTURAL', 'LEADER_MINOR_CIV_INDUSTRIAL', 'LEADER_MINOR_CIV_MILITARISTIC',
                       'LEADER_MINOR_CIV_RELIGIOUS', 'LEADER_MINOR_CIV_SCIENTIFIC', 'LEADER_MINOR_CIV_TRADE');
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'NW_MODIFIER_PERICLES_SUZ_' || LeaderType, 'Amount', 6
  FROM Leaders
 WHERE InheritFrom IN ('LEADER_MINOR_CIV_CULTURAL', 'LEADER_MINOR_CIV_INDUSTRIAL', 'LEADER_MINOR_CIV_MILITARISTIC',
                       'LEADER_MINOR_CIV_RELIGIOUS', 'LEADER_MINOR_CIV_SCIENTIFIC', 'LEADER_MINOR_CIV_TRADE');
INSERT INTO TraitModifiers ( TraitType, ModifierId )
SELECT 'TRAIT_LEADER_SURROUNDED_BY_GLORY', 'NW_MODIFIER_PERICLES_SUZ_' || LeaderType
  FROM Leaders
 WHERE InheritFrom IN ('LEADER_MINOR_CIV_CULTURAL', 'LEADER_MINOR_CIV_INDUSTRIAL', 'LEADER_MINOR_CIV_MILITARISTIC',
                       'LEADER_MINOR_CIV_RELIGIOUS', 'LEADER_MINOR_CIV_SCIENTIFIC', 'LEADER_MINOR_CIV_TRADE');

--女希腊
UPDATE ModifierArguments
   SET Value=70
 WHERE ModifierId = 'UNIQUE_LEADER_CULTURE_KILLS' AND Name = 'PercentDefeatedStrength';

--女希腊 解锁政治哲学+1力
INSERT INTO TraitModifiers( TraitType, ModifierId )
VALUES ( 'CULTURE_KILLS_TRAIT', 'TRAIT_SAIMOPILAI_COMBAT_BONUS_TEAMPVP' );
INSERT INTO Modifiers( ModifierId, ModifierType, OwnerRequirementSetId )
VALUES ( 'TRAIT_SAIMOPILAI_COMBAT_BONUS_TEAMPVP', 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH', 'NW_PLAYER_HAS_CIVIC_POLITICAL_PHILOSOPHY' );
INSERT INTO ModifierArguments( ModifierId, Name, Value )
VALUES ( 'TRAIT_SAIMOPILAI_COMBAT_BONUS_TEAMPVP', 'Amount', '1' );
INSERT INTO ModifierStrings( ModifierId, Context, Text )
VALUES ( 'TRAIT_SAIMOPILAI_COMBAT_BONUS_TEAMPVP', 'Preview', 'LOC_TRAIT_SAIMOPILAI_TEAMPVP_COMBAT_BONUS_DESCRIPTION' );

INSERT INTO TraitModifiers( TraitType, ModifierId )
VALUES ( 'CULTURE_KILLS_TRAIT', 'TRAIT_SAIMOPILAI_COMBAT_BONUS_2_TEAMPVP' );
INSERT INTO Modifiers( ModifierId, ModifierType, OwnerRequirementSetId )
VALUES ( 'TRAIT_SAIMOPILAI_COMBAT_BONUS_2_TEAMPVP', 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH', 'NW_PLAYER_HAS_CIVIC_HUMANISM' );
INSERT INTO ModifierArguments( ModifierId, Name, Value )
VALUES ( 'TRAIT_SAIMOPILAI_COMBAT_BONUS_2_TEAMPVP', 'Amount', '1' );
INSERT INTO ModifierStrings( ModifierId, Context, Text )
VALUES ( 'TRAIT_SAIMOPILAI_COMBAT_BONUS_2_TEAMPVP', 'Preview', 'LOC_TRAIT_SAIMOPILAI_TEAMPVP_COMBAT_BONUS_2_DESCRIPTION' );

-- =============================================================
-- HUNGARY	匈牙利

-- 改动：银行业而非自然历史解锁匈牙利特色建筑温泉浴场
UPDATE Buildings
   SET PrereqTech = NULL, PrereqCivic = 'CIVIC_HUMANISM'
 WHERE BuildingType = 'BUILDING_THERMAL_BATH';

-- 新增：温泉浴场不替代动物园，但不能建造在已有动物园或其替代建筑的娱乐中心中
DELETE
  FROM BuildingReplaces
 WHERE CivUniqueBuildingType = 'BUILDING_THERMAL_BATH';
INSERT INTO MutuallyExclusiveBuildings( Building, MutuallyExclusiveBuilding )
VALUES ( 'BUILDING_THERMAL_BATH', 'BUILDING_ZOO' ),
       ( 'BUILDING_ZOO', 'BUILDING_THERMAL_BATH' );

INSERT INTO MutuallyExclusiveBuildings( Building, MutuallyExclusiveBuilding )
SELECT 'BUILDING_THERMAL_BATH', CivUniqueBuildingType
  FROM BuildingReplaces
 WHERE ReplacesBuildingType = 'BUILDING_ZOO' AND CivUniqueBuildingType IS NOT 'BUILDING_THERMAL_BATH'
 UNION
SELECT CivUniqueBuildingType, 'BUILDING_THERMAL_BATH'
  FROM BuildingReplaces
 WHERE ReplacesBuildingType = 'BUILDING_ZOO' AND CivUniqueBuildingType IS NOT 'BUILDING_THERMAL_BATH';


-- =============================================================
-- INCA	印加

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_PACHACUTI_QHAPAQ_NAN', 'MODIFIER_TRAIT_LEADER_PACHACUTI_QHAPAQ_NAN_ESCORT_MOBILITY' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_PACHACUTI_QHAPAQ_NAN_ESCORT_MOBILITY',
         'MODIFIER_NW_DMTS_PLAYER_UNITS_ADJUST_ESCORT_MOBILITY', 0, 0, 0, NULL,
         'REQS_UNIT_PROMOTION_IS_PROMOTION_CLASS_RECON' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_PACHACUTI_QHAPAQ_NAN_ESCORT_MOBILITY', 'EscortMobility', '1' );

-- Custom ModifierType
INSERT INTO Types ( Type, Kind )
VALUES ( 'MODIFIER_NW_DMTS_PLAYER_UNITS_ADJUST_ESCORT_MOBILITY', 'KIND_MODIFIER' );
INSERT INTO DynamicModifiers ( ModifierType, CollectionType, EffectType )
VALUES ( 'MODIFIER_NW_DMTS_PLAYER_UNITS_ADJUST_ESCORT_MOBILITY', 'COLLECTION_PLAYER_UNITS',
         'EFFECT_ADJUST_UNIT_ESCORT_MOBILITY' );

-- RequirementSets
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'REQS_UNIT_PROMOTION_IS_PROMOTION_CLASS_RECON', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'REQS_UNIT_PROMOTION_IS_PROMOTION_CLASS_RECON', 'REQ_UNIT_PROMOTION_IS_PROMOTION_CLASS_RECON' );
-- Requirements
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'REQ_UNIT_PROMOTION_IS_PROMOTION_CLASS_RECON', 'REQUIREMENT_UNIT_PROMOTION_CLASS_MATCHES' );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'REQ_UNIT_PROMOTION_IS_PROMOTION_CLASS_RECON', 'UnitPromotionClass', 'PROMOTION_CLASS_RECON' );


INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_PACHACUTI_QHAPAQ_NAN', 'MODIFIER_TRAIT_LEADER_PACHACUTI_QHAPAQ_NAN_GRANT_UNIT_IN_CAPITAL' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_PACHACUTI_QHAPAQ_NAN_GRANT_UNIT_IN_CAPITAL', 'MODIFIER_PLAYER_GRANT_UNIT_IN_CAPITAL', 1,
         1, 0, 'NW_PLAYER_HAS_CIVIC_CODE_OF_LAWS', NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_PACHACUTI_QHAPAQ_NAN_GRANT_UNIT_IN_CAPITAL', 'AllowUniqueOverride', '1' ),
       ( 'MODIFIER_TRAIT_LEADER_PACHACUTI_QHAPAQ_NAN_GRANT_UNIT_IN_CAPITAL', 'Amount', '1' ),
       ( 'MODIFIER_TRAIT_LEADER_PACHACUTI_QHAPAQ_NAN_GRANT_UNIT_IN_CAPITAL', 'UnitType', 'UNIT_SCOUT' );



-- =============================================================
-- INDIA	印度

--印度 梯田
UPDATE Improvements
   SET Housing='1'
 WHERE ImprovementType = 'IMPROVEMENT_STEPWELL';

--印度UI基础+1锤
--基础
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'STEPWELL_HOLYSITEADJACENCY_5_JICHU', 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS', 'PLOT_ADJACENT_TO_HOLYSITE_REQUIREMENTS' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'STEPWELL_HOLYSITEADJACENCY_5_JICHU', 'Amount', '1' ),
       ( 'STEPWELL_HOLYSITEADJACENCY_5_JICHU', 'YieldType', 'YIELD_PRODUCTION' );
INSERT INTO ImprovementModifiers ( ImprovementType, ModifierID )
VALUES ( 'IMPROVEMENT_STEPWELL', 'STEPWELL_HOLYSITEADJACENCY_5_JICHU' );


INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_DHARMA', 'MODIFIER_TRAIT_CIVILIZATION_DHARMA_CULTURE_BOMB' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_CIVILIZATION_DHARMA_CULTURE_BOMB', 'MODIFIER_PLAYER_ADD_CULTURE_BOMB_TRIGGER', 0, 0, 0, NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_CIVILIZATION_DHARMA_CULTURE_BOMB', 'CaptureOwnedTerritory', 0 ),
       ( 'MODIFIER_TRAIT_CIVILIZATION_DHARMA_CULTURE_BOMB', 'ImprovementType', 'IMPROVEMENT_STEPWELL' );



--印度 甘地
--梯井
UPDATE ModifierArguments
   SET Value='3'
 WHERE Name = 'Amount' AND ModifierId = 'STEPWELL_HOLYSITEADJACENCY_FAITH';
UPDATE ModifierArguments
   SET Value='1'
 WHERE Name = 'Amount' AND ModifierId = 'STEPWELL_FARMADJACENCY_FOOD';

UPDATE Improvement_YieldChanges
   SET YieldChange='0'
 WHERE ImprovementType = 'IMPROVEMENT_STEPWELL' AND YieldType = 'YIELD_FAITH';

INSERT INTO Improvement_YieldChanges ( ImprovementType, YieldType, YieldChange )
VALUES ( 'IMPROVEMENT_STEPWELL', 'YIELD_PRODUCTION', '0' );

--工人+1移动
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_SATYAGRAHA', 'GANDHI_FAST_BUILDERS' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'GANDHI_FAST_BUILDERS', 'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT', 'UNIT_IS_BUILDER' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'GANDHI_FAST_BUILDERS', 'Amount', '1' );

-- 文印度 厌战
UPDATE ModifierArguments
   SET Value='40'
 WHERE ModifierId = 'TRAIT_INCREASE_ENEMY_WAR_WEARINESS' AND Name = 'Amount';


-- 黑印度
UPDATE ModifierArguments
   SET Value='0'
 WHERE Name = 'Amount' AND ModifierId = 'TRAIT_TERRITORIAL_WAR_MOVEMENT';
UPDATE ModifierArguments
   SET Value='0'
 WHERE Name = 'Amount' AND ModifierId = 'TRAIT_TERRITORIAL_WAR_COMBAT';
---------政事论
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_ARTHASHASTRA', 'TRAIT_EXPANSION_COMBAT_BONUS_CPLMOD' );
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_ARTHASHASTRA', 'TRAIT_EXPANSION_MOVEMENT_BONUS_CPLMOD' );
INSERT INTO Modifiers ( ModifierId, ModifierType )
VALUES ( 'TRAIT_EXPANSION_COMBAT_BONUS_CPLMOD', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER' );
INSERT INTO Modifiers ( ModifierId, ModifierType )
VALUES ( 'TRAIT_EXPANSION_MOVEMENT_BONUS_CPLMOD', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER' );
INSERT INTO Modifiers ( ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'EXPANSION_COMBAT_BONUS_MODIFIER_CPLMOD', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQUIREMENTSET_LAND_MILITARY_CPLMOD', 'PLAYER_UNITS_WITHIN_TERRITORY_REQUIREMENTS_CPLMOD' );
INSERT INTO Modifiers ( ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'EXPANSION_MOVEMENT_BONUS_MODIFIER_CPLMOD', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 'REQUIREMENTSET_LAND_MILITARY_CPLMOD', 'PLAYER_UNITS_WITHIN_TERRITORY_REQUIREMENTS_CPLMOD' );

INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'REQUIREMENTS_LAND_MILITARY_CPLMOD', 'UnitFormationClass', 'FORMATION_CLASS_LAND_COMBAT' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_EXPANSION_COMBAT_BONUS_CPLMOD', 'ModifierId', 'EXPANSION_COMBAT_BONUS_MODIFIER_CPLMOD' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_EXPANSION_MOVEMENT_BONUS_CPLMOD', 'ModifierId', 'EXPANSION_MOVEMENT_BONUS_MODIFIER_CPLMOD' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'EXPANSION_COMBAT_BONUS_MODIFIER_CPLMOD', 'Amount', '1' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'EXPANSION_MOVEMENT_BONUS_MODIFIER_CPLMOD', 'Amount', '1' );
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'PLAYER_UNITS_WITHIN_TERRITORY_REQUIREMENTS_CPLMOD', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'REQUIREMENTSET_LAND_MILITARY_CPLMOD', 'REQUIREMENTSET_TEST_ANY' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'PLAYER_UNITS_WITHIN_TERRITORY_REQUIREMENTS_CPLMOD', 'CHANDRAGUPTA_WITHIN_TERRITORY_REQUIREMENTS_CPLMOD' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'REQUIREMENTSET_LAND_MILITARY_CPLMOD', 'REQUIREMENTS_LAND_MILITARY_CPLMOD' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'REQUIREMENTSET_LAND_MILITARY_CPLMOD', 'REQUIRES_UNIT_IS_RELIGIOUS_ALL' );
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'CHANDRAGUPTA_WITHIN_TERRITORY_REQUIREMENTS_CPLMOD', 'REQUIREMENT_UNIT_IN_OWNER_TERRITORY' );
INSERT INTO Requirements ( RequirementId, RequirementType, Inverse )
VALUES ( 'CHANDRAGUPTA_FOREIGN_TERRITORY_REQUIREMENTS_CPLMOD', 'REQUIREMENT_UNIT_IN_OWNER_TERRITORY', 1 );
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'REQUIREMENTS_LAND_MILITARY_CPLMOD', 'REQUIREMENT_UNIT_FORMATION_CLASS_MATCHES' );
INSERT INTO ModifierStrings ( ModifierId, Context, Text )
VALUES ( 'EXPANSION_COMBAT_BONUS_MODIFIER_CPLMOD', 'Preview', 'LOC_EXPANSION_COMBAT_BONUS_MODIFIER_WUYINDU_DESCRIPTION' );


-- =============================================================
-- INDONESIA	印度尼西亚

UPDATE ModifierArguments
   SET Value='3'
 WHERE ModifierId = 'JONG_BONUS_IN_FORMATION' AND Name = 'Amount';
-- 删除：戎克船-25%信仰值花费
-- 新增：沿海城市建造圣地+80%生产力。圣地从相邻海岸和礁石获得标准相邻加成，与相邻圣地的区域提供等同于其相邻加成的 [ICON_FAITH] 信仰值。可以-15%的花费用 [ICON_FAITH] 信仰值购买海军单位。
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_EXALTED_GODDESS', 'MODIFIER_TRAIT_LEADER_EXALTED_GODDESS_HALF_HOLYSITE' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_EXALTED_GODDESS_HALF_HOLYSITE', 'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION', 0,
         0, 0, NULL, 'PLOT_IS_COASTAL_LAND_REQUIREMENTS' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_EXALTED_GODDESS_HALF_HOLYSITE', 'Amount', 80 ),
       ( 'MODIFIER_TRAIT_LEADER_EXALTED_GODDESS_HALF_HOLYSITE', 'DistrictType', 'DISTRICT_HOLY_SITE' );


UPDATE ModifierArguments
   SET Value = 1
 WHERE Name = 'TilesRequired' AND ModifierId IN ('TRAIT_NUSANTARA_COAST_HOLY_SITE',
                                                 'TRAIT_NUSANTARA_COAST_CAMPUS',
                                                 'TRAIT_NUSANTARA_COAST_INDUSTRIAL_ZONE',
                                                 'TRAIT_NUSANTARA_COAST_THEATER');

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_EXALTED_GODDESS', 'MODIFIER_TRAIT_LEADER_EXALTED_GODDESS_HARBOR_GOLD_TO_FAITH' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_EXALTED_GODDESS_HARBOR_GOLD_TO_FAITH',
         'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS', 'REQS_NW_PLOT_NEXT_HOLY_SITE' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_EXALTED_GODDESS_HARBOR_GOLD_TO_FAITH', 'DistrictType', 'DISTRICT_HARBOR' ),
       ( 'MODIFIER_TRAIT_LEADER_EXALTED_GODDESS_HARBOR_GOLD_TO_FAITH', 'YieldTypeToGrant', 'YIELD_FAITH' ),
       ( 'MODIFIER_TRAIT_LEADER_EXALTED_GODDESS_HARBOR_GOLD_TO_FAITH', 'YieldTypeToMirror', 'YIELD_GOLD' );

-- RequirementSets
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'REQS_NW_PLOT_NEXT_HOLY_SITE', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'REQS_NW_PLOT_NEXT_HOLY_SITE', 'REQ_NW_PLOT_NEXT_HOLY_SITE' ),
       ( 'REQS_NW_PLOT_NEXT_HOLY_SITE', 'REQUIRES_DISTRICT_IS_HARBOR' );
-- Requirements
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'REQ_NW_PLOT_NEXT_HOLY_SITE', 'REQUIREMENT_PLOT_ADJACENT_DISTRICT_TYPE_MATCHES' );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'REQ_NW_PLOT_NEXT_HOLY_SITE', 'DistrictType', 'DISTRICT_HOLY_SITE' ),
       ( 'REQ_NW_PLOT_NEXT_HOLY_SITE', 'MaxRange', '1' ),
       ( 'REQ_NW_PLOT_NEXT_HOLY_SITE', 'MinRange', '1' );


INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_EXALTED_GODDESS', 'MODIFIER_TRAIT_LEADER_EXALTED_GODDESS_HARBOR' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_EXALTED_GODDESS_HARBOR', 'MODIFIER_PLAYER_CITIES_ENABLE_BUILDING_FAITH_PURCHASE', 0, 0, 0, NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_EXALTED_GODDESS_HARBOR', 'DistrictType', 'DISTRICT_HARBOR' );

DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_EXALTED_GODDESS' AND ModifierId IN ('TRAIT_NAVAL_MELEE_FAITH',
                                                                     'TRAIT_NAVAL_RANGED_FAITH',
                                                                     'TRAIT_NAVAL_RAIDER_FAITH',
                                                                     'TRAIT_NAVAL_CARRIER_FAITH'
     );

-- =============================================================
-- JAPAN	日本

-- 日本 武士
UPDATE Units
   SET Cost=170
 WHERE UnitType = 'UNIT_JAPANESE_SAMURAI';

-- 北条
-- 如果 [ICON_CAPITAL] 首都建于相邻海岸的陆地单元格，则所有城市建造港口时+80% [ICON_PRODUCTION] 生产力。如果 [ICON_CAPITAL] 首都不相邻海岸，则所有城市建造商业中心时+70% [ICON_PRODUCTION] 生产力。
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_DIVINE_WIND' AND ModifierId IN ('TRAIT_BOOST_ENCAMPMENT_PRODUCTION',
                                                                 'TRAIT_BOOST_HOLY_SITE_PRODUCTION',
                                                                 'TRAIT_BOOST_THEATER_DISTRICT_PRODUCTION',
                                                                 'TRAIT_HURRICANE_PREVENTION_CAT_4',
                                                                 'TRAIT_HURRICANE_PREVENTION_CAT_5',
                                                                 'TRAIT_HURRICANE_DOUBLE_DAMAGE_CAT_4',
                                                                 'TRAIT_HURRICANE_DOUBLE_DAMAGE_CAT_5');

--海岸+2
UPDATE ModifierArguments
   SET Value='2'
 WHERE ModifierId = 'HOJO_TOKIMUNE_COASTAL_COMBAT_BONUS' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='2'
 WHERE ModifierId = 'HOJO_TOKIMUNE_SHALLOW_WATER_COMBAT_BONUS' AND Name = 'Amount';

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_DIVINE_WIND', 'MODIFIER_TRAIT_LEADER_DIVINE_WIND_HARBOR_PRO_ATTACH' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_DIVINE_WIND_HARBOR_PRO_ATTACH', 'MODIFIER_PLAYER_CAPITAL_CITY_ATTACH_MODIFIER', 0, 0, 0,
         NULL, 'PLOT_IS_COASTAL_LAND_REQUIREMENTS' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_DIVINE_WIND_HARBOR_PRO_ATTACH', 'ModifierId',
         'MODIFIER_TRAIT_LEADER_DIVINE_WIND_HARBOR_PRO' );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_DIVINE_WIND', 'MODIFIER_TRAIT_LEADER_DIVINE_WIND_DISTRICT_COMMERCIAL_HUB_PRO_ATTACH' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_DIVINE_WIND_DISTRICT_COMMERCIAL_HUB_PRO_ATTACH',
         'MODIFIER_PLAYER_CAPITAL_CITY_ATTACH_MODIFIER', 0, 0, 0, NULL, 'REQS_NW_PLOT_NOTS_COASTAL_LAND_REQUIREMENTS' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_DIVINE_WIND_DISTRICT_COMMERCIAL_HUB_PRO_ATTACH', 'ModifierId',
         'MODIFIER_TRAIT_LEADER_DIVINE_WIND_DISTRICT_COMMERCIAL_HUB_PRO' );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_DIVINE_WIND', 'MODIFIER_TRAIT_LEADER_DIVINE_WIND_DISTRICT_HOLY_SITE_PRO_ATTACH' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_DIVINE_WIND_DISTRICT_HOLY_SITE_PRO_ATTACH',
         'MODIFIER_PLAYER_CAPITAL_CITY_ATTACH_MODIFIER', 0, 0, 0, NULL, 'REQS_NW_PLOT_NOTS_COASTAL_LAND_REQUIREMENTS' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_DIVINE_WIND_DISTRICT_HOLY_SITE_PRO_ATTACH', 'ModifierId',
         'MODIFIER_TRAIT_LEADER_DIVINE_WIND_DISTRICT_HOLY_SITE_PRO' );

-- Custom ModifierType
INSERT INTO Types ( Type, Kind )
VALUES ( 'MODIFIER_PLAYER_CAPITAL_CITY_ATTACH_MODIFIER', 'KIND_MODIFIER' );
INSERT INTO DynamicModifiers ( ModifierType, CollectionType, EffectType )
VALUES ( 'MODIFIER_PLAYER_CAPITAL_CITY_ATTACH_MODIFIER', 'COLLECTION_PLAYER_CAPITAL_CITY', 'EFFECT_ATTACH_MODIFIER' );

-- RequirementSets
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'REQS_NW_PLOT_NOTS_COASTAL_LAND_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'REQS_NW_PLOT_NOTS_COASTAL_LAND_REQUIREMENTS', 'REQ_NW_PLOT_NOTS_COASTAL_LAND_REQUIREMENTS' );
-- Requirements
INSERT INTO Requirements ( RequirementId, RequirementType, Inverse )
VALUES ( 'REQ_NW_PLOT_NOTS_COASTAL_LAND_REQUIREMENTS', 'REQUIREMENT_PLOT_IS_COASTAL_LAND', 1 );

INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_DIVINE_WIND_HARBOR_PRO', 'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION', 0, 0, 0,
         NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_DIVINE_WIND_HARBOR_PRO', 'Amount', 80 ),
       ( 'MODIFIER_TRAIT_LEADER_DIVINE_WIND_HARBOR_PRO', 'DistrictType', 'DISTRICT_HARBOR' );

INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_DIVINE_WIND_DISTRICT_COMMERCIAL_HUB_PRO',
         'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION', 0, 0, 0, NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_DIVINE_WIND_DISTRICT_COMMERCIAL_HUB_PRO', 'Amount', 55 ),
       ( 'MODIFIER_TRAIT_LEADER_DIVINE_WIND_DISTRICT_COMMERCIAL_HUB_PRO', 'DistrictType', 'DISTRICT_COMMERCIAL_HUB' );

INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_DIVINE_WIND_DISTRICT_HOLY_SITE_PRO', 'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION',
         0, 0, 0, NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_DIVINE_WIND_DISTRICT_HOLY_SITE_PRO', 'Amount', 55 ),
       ( 'MODIFIER_TRAIT_LEADER_DIVINE_WIND_DISTRICT_HOLY_SITE_PRO', 'DistrictType', 'DISTRICT_HOLY_SITE' );

-- 德川家康
UPDATE ModifierArguments
   SET Value=0.7
 WHERE ModifierId = 'TOKUGAWA_POSITIVE_DOMESTIC_CULTURE_DISTRICTS' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value=0.7
 WHERE ModifierId = 'TOKUGAWA_POSITIVE_DOMESTIC_SCIENCE_DISTRICTS' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value=1.2
 WHERE ModifierId = 'TOKUGAWA_POSITIVE_DOMESTIC_GOLD_DISTRICTS' AND Name = 'Amount';

-- =============================================================
-- KHMER	高棉
-- 寺庙
UPDATE Building_YieldChanges
   SET YieldChange=4
 WHERE BuildingType = 'BUILDING_PRASAT';

UPDATE Units
   SET Combat=35, Cost=150, BaseMoves=3, Bombard=50
 WHERE UnitType = 'UNIT_KHMER_DOMREY';

UPDATE ModifierArguments
   SET Value=1
 WHERE ModifierId = 'BARAYS_FAITH_POPULATION' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value=1
 WHERE ModifierId = 'TRAIT_FARM_AQUEDUCT_ADJECENCY_FOOD' AND Name = 'Amount';

-- LA
-- 从河流获得大量相邻加成
UPDATE ModifierArguments
   SET Value='2'
 WHERE ModifierId = 'TRAIT_MONASTERIES_KING_HOLY_SITE_RIVER_ADJACENCY' AND Name = 'Amount';
-- 1住房
UPDATE ModifierArguments
   SET Value=1
 WHERE ModifierId = 'TRAIT_HOLY_SITE_RIVER_2HOUSING' AND Name = 'Amount';
UPDATE Modifiers
   SET SubjectRequirementSetId = 'NW_DISTRICT_IS_DISTRICT_HOLY_SITE'
 WHERE ModifierId = 'TRAIT_HOLY_SITE_RIVER_2HOUSING';

UPDATE TraitModifiers
   SET ModifierId='TRAIT_HOLY_SITE_RIVER_FOOD'
 WHERE TraitType = 'TRAIT_LEADER_MONASTERIES_KING' AND ModifierId = 'TRAIT_MONASTERIES_KING_ADJACENCY_FOOD';
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'TRAIT_HOLY_SITE_RIVER_FOOD', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE', 'NW_DISTRICT_IS_DISTRICT_HOLY_SITE' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_HOLY_SITE_RIVER_FOOD', 'Amount', '1' ),
       ( 'TRAIT_HOLY_SITE_RIVER_FOOD', 'YieldType', 'YIELD_FOOD' );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_MONASTERIES_KING', 'TRAIT_BOOST_AQUEDUCT_PRODUCTION_CPLMOD2' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'TRAIT_BOOST_AQUEDUCT_PRODUCTION_CPLMOD2', 'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION', NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value, Extra, SecondExtra )
VALUES ( 'TRAIT_BOOST_AQUEDUCT_PRODUCTION_CPLMOD2', 'DistrictType', 'DISTRICT_AQUEDUCT', NULL, NULL ),
       ( 'TRAIT_BOOST_AQUEDUCT_PRODUCTION_CPLMOD2', 'Amount', '50', NULL, NULL );

--高棉教堂文化
UPDATE ModifierArguments
   SET Value='0.2'
 WHERE ModifierId = 'PRASAT_CULTURE_POPULATION' AND Name = 'Amount';

-- =============================================================
-- KONGO	刚果
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_NKISI' AND ModifierId = 'TRAIT_DOUBLE_MUSICIAN_POINTS';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_NKISI' AND ModifierId = 'TRAIT_DOUBLE_MERCHANT_POINTS';

UPDATE ModifierArguments
   SET Value= 100
 WHERE ModifierId = 'TRAIT_DOUBLE_ARTIST_POINTS' AND Name = 'Amount';

--刚果
--奥姆本巴
UPDATE ModifierArguments
   SET Value='3'
 WHERE ModifierId = 'NAGAO_RANGED_DEFENSE' AND Name = 'Amount';
UPDATE Units
   SET Cost=100
 WHERE UnitType = 'UNIT_KONGO_SHIELD_BEARER';
UPDATE Units_XP2
   SET ResourceCost=10
 WHERE UnitType = 'UNIT_KONGO_SHIELD_BEARER';
--精神实体
UPDATE ModifierArguments
   SET Value='3'
 WHERE ModifierId = 'TRAIT_GREAT_WORK_PRODUCTION_SCULPTURE' AND Name = 'Amount';

-- 每个大艺术家提供一个随机的鼓舞
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_NKISI', 'TRAIT_CIVILIZATION_NKISI_CB' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'TRAIT_CIVILIZATION_NKISI_CB', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 0, 0, 0, NULL, 'NW_REQS_UNIT_IS_GREAT_PERSON_CLASS_ARTIST' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_CIVILIZATION_NKISI_CB', 'ModifierId', 'GOODY_CULTURE_GRANT_ONE_CIVIC_BOOST' );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
SELECT 'TRAIT_CIVILIZATION_NKISI', 'TRAIT_CIVILIZATION_NKISI_RELIC_WHEN_' || GovernmentType
  FROM Governments
 WHERE Tier = 'Tier2';
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId, Permanent )
SELECT 'TRAIT_CIVILIZATION_NKISI_RELIC_WHEN_' || GovernmentType, 'MODIFIER_PLAYER_GRANT_RELIC',
       'NW_PLAYER_HAS_' || PrereqCivic, 1
  FROM Governments
 WHERE Tier = 'Tier2';
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'TRAIT_CIVILIZATION_NKISI_RELIC_WHEN_' || GovernmentType, 'Amount', '1'
  FROM Governments
 WHERE Tier = 'Tier2';

-- 男刚果
-- 原效果：无法建造圣地区、获得大预言家，或创建宗教。从已成为多数刚果城市信仰的宗教中获得信仰值。每次完成一个姆班赞或剧院广场区时获得一位（城市主流宗教的）使徒。解锁“政治哲学”、“雇佣兵”市政时获得1个遗物。所有近战单位在防御远程攻击时+3战斗力。
DELETE
  FROM ExcludedDistricts
 WHERE TraitType = 'TRAIT_LEADER_RELIGIOUS_CONVERT';
DELETE
  FROM ExcludedGreatPersonClasses
 WHERE TraitType = 'TRAIT_LEADER_RELIGIOUS_CONVERT';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_RELIGIOUS_CONVERT' AND ModifierId = 'TRAIT_FREE_APOSTLE_FINISH_MBANZA';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_RELIGIOUS_CONVERT' AND ModifierId = 'TRAIT_FREE_APOSTLE_FINISH_THEATER_DISTRICT';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_RELIGIOUS_CONVERT' AND ModifierId = 'TRAIT_GAINS_FOUNDER_BELIEF_MAJORITY_RELIGION';

-- 建成圣地时也建成神社。首次建成寺庙时分别获得一个遗物。城市信仰主流宗教后获得一个免费的使徒。
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_RELIGIOUS_CONVERT', 'TRAIT_LEADER_RELIGIOUS_CONVERT_GRANT_B_RELIC' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId, Permanent )
VALUES ( 'TRAIT_LEADER_RELIGIOUS_CONVERT_GRANT_B_RELIC', 'MODIFIER_PLAYER_GRANT_RELIC', 'NW_PLAYER_HAS_BUILDING_TEMPLE', 1 );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_LEADER_RELIGIOUS_CONVERT_GRANT_B_RELIC', 'Amount', '1' );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_RELIGIOUS_CONVERT', 'TRAIT_LEADER_RELIGIOUS_CONVERT_FREE_BUILDING_SHRINE' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'TRAIT_LEADER_RELIGIOUS_CONVERT_FREE_BUILDING_SHRINE', 'MODIFIER_NW_DTMS_PLAYER_CITIES_GRANT_BUILDING_IN_CITY_IGNORE', 0, 1, 0, NULL, 'NW_CITY_HAS_DISTRICT_HOLY_SITE' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_LEADER_RELIGIOUS_CONVERT_FREE_BUILDING_SHRINE', 'BuildingType', 'BUILDING_SHRINE' );

INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_LEADER_RELIGIOUS_CONVERT', 'MODIFIER_TRAIT_LEADER_RELIGIOUS_CONVERT_FREE_UNIT_APOSTLE');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_LEADER_RELIGIOUS_CONVERT_FREE_UNIT_APOSTLE', 'MODIFIER_PLAYER_DISTRICT_CREATE_UNIT', 0, 0, 0, NULL, 'CITY_FOLLOWS_RELIGION_REQUIREMENTS');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_RELIGIOUS_CONVERT_FREE_UNIT_APOSTLE', 'DistrictType', 'DISTRICT_CITY_CENTER'),
('MODIFIER_TRAIT_LEADER_RELIGIOUS_CONVERT_FREE_UNIT_APOSTLE', 'UnitType', 'UNIT_APOSTLE');


-- 女刚果
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_NZINGA_MBANDE', 'TRAIT_LEADER_NZINGA_MBANDE_AMEN' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'TRAIT_LEADER_NZINGA_MBANDE_AMEN', 'MODIFIER_PLAYER_CITIES_ADJUST_TRAIT_AMENITY', 0, 0, 0, NULL, 'NW_REQS_CITY_NEXT_CAPITAL_IN_7_PLOTS' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_LEADER_NZINGA_MBANDE_AMEN', 'Amount', '1' );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_NZINGA_MBANDE', 'TRAIT_LEADER_NZINGA_MBANDE_INFLUENCE_POINTS_PER_TURN' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'TRAIT_LEADER_NZINGA_MBANDE_INFLUENCE_POINTS_PER_TURN', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 0, 0, 0, NULL, 'NW_REQS_CITY_NEXT_CAPITAL_IN_7_PLOTS' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_LEADER_NZINGA_MBANDE_INFLUENCE_POINTS_PER_TURN', 'Amount', '1' ),
       ( 'TRAIT_LEADER_NZINGA_MBANDE_INFLUENCE_POINTS_PER_TURN', 'YieldType', 'YIELD_GOLD' );

-- RequirementSets
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'NW_REQS_CITY_NEXT_CAPITAL_IN_7_PLOTS', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'NW_REQS_CITY_NEXT_CAPITAL_IN_7_PLOTS', 'NW_REQ_CITY_NEXT_CAPITAL_IN_7_PLOTS' );
-- Requirements
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'NW_REQ_CITY_NEXT_CAPITAL_IN_7_PLOTS', 'REQUIREMENT_PLOT_ADJACENT_BUILDING_TYPE_MATCHES' );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'NW_REQ_CITY_NEXT_CAPITAL_IN_7_PLOTS', 'BuildingType', 'BUILDING_PALACE' ),
       ( 'NW_REQ_CITY_NEXT_CAPITAL_IN_7_PLOTS', 'MaxRange', '7' ),
       ( 'NW_REQ_CITY_NEXT_CAPITAL_IN_7_PLOTS', 'MinRange', '0' );

CREATE TABLE IF NOT EXISTS NW_KG_TR
    (
        ModifierId TEXT NOT NULL
            PRIMARY KEY,
        OLDYield TEXT NOT NULL,
        NEWYield TEXT NOT NULL
    );
INSERT INTO NW_KG_TR( ModifierId, OLDYield, NEWYield )
SELECT ModifierId, 'FOOD', 'GOLD'
  FROM PolicyModifiers
 WHERE PolicyType = 'POLICY_WISSELBANKEN' AND ModifierId LIKE 'WISSELBANKEN_TRADEROUTEFOOD%';
INSERT INTO NW_KG_TR( ModifierId, OLDYield, NEWYield )
SELECT ModifierId, 'PRODUCTION', 'CULTURE'
  FROM PolicyModifiers
 WHERE PolicyType = 'POLICY_WISSELBANKEN' AND ModifierId LIKE 'WISSELBANKEN_TRADEROUTEPRODUCTION%';
INSERT INTO TraitModifiers( TraitType, ModifierId )
SELECT 'TRAIT_LEADER_NZINGA_MBANDE',
       'TRAIT_LEADER_NZINGA_MBANDE_' || REPLACE(nkt.ModifierId, nkt.OLDYield, nkt.NEWYield)
  FROM NW_KG_TR nkt
           JOIN Modifiers m
           ON nkt.ModifierId = m.ModifierId;
INSERT INTO Modifiers ( ModifierId, ModifierType )
SELECT 'TRAIT_LEADER_NZINGA_MBANDE_' || REPLACE(nkt.ModifierId, nkt.OLDYield, nkt.NEWYield), m.ModifierType
  FROM NW_KG_TR nkt
           JOIN Modifiers m
           ON nkt.ModifierId = m.ModifierId;
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'TRAIT_LEADER_NZINGA_MBANDE_' || REPLACE(nkt.ModifierId, nkt.OLDYield, nkt.NEWYield), ma.Name,
       REPLACE(ma.Value, nkt.OLDYield, nkt.NEWYield)
  FROM NW_KG_TR nkt
           JOIN ModifierArguments ma
           ON nkt.ModifierId = ma.ModifierId;

-- =============================================================
-- KOREA	朝鲜

--朝鲜 书院 相邻食物-》金
UPDATE Adjacency_YieldChanges
   SET YieldType='YIELD_GOLD'
 WHERE ID = 'Farm_FoodSeowonAdjacency' AND YieldType = 'YIELD_FOOD';

--朝鲜书院不需要维护费
UPDATE Districts
   SET Maintenance='0'
 WHERE DistrictType = 'DISTRICT_SEOWON';

--朝鲜
UPDATE Adjacency_YieldChanges
   SET YieldChange=3
 WHERE ID = 'BaseDistrict_Science';
UPDATE Units
   SET Cost=330, PrereqTech='TECH_METAL_CASTING'
 WHERE UnitType = 'UNIT_KOREAN_HWACHA';

--朝鲜 农场相邻书院+1金币
--条件
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'REQUIRES_PLOT_ADJACENT_TO_DISTRICT_SEOWON', 'REQUIREMENT_PLOT_ADJACENT_DISTRICT_TYPE_MATCHES' );
INSERT INTO RequirementArguments( RequirementId, Name, Value )
VALUES ( 'REQUIRES_PLOT_ADJACENT_TO_DISTRICT_SEOWON', 'DistrictType', 'DISTRICT_SEOWON' );

INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'PLOT_ADJACENT_TO_FARM_REQUIREMENTS_CHAOXIAN', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'PLOT_ADJACENT_TO_FARM_REQUIREMENTS_CHAOXIAN', 'REQUIRES_PLOT_HAS_FARM' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'PLOT_ADJACENT_TO_FARM_REQUIREMENTS_CHAOXIAN', 'REQUIRES_PLOT_ADJACENT_TO_DISTRICT_SEOWON' );


INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'TRAIT_FARM_FOOD_DISTRICT_SEOWON_CHAOXIAN', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'PLOT_ADJACENT_TO_FARM_REQUIREMENTS_CHAOXIAN' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_FARM_FOOD_DISTRICT_SEOWON_CHAOXIAN', 'YieldType', 'YIELD_GOLD' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_FARM_FOOD_DISTRICT_SEOWON_CHAOXIAN', 'Amount', '1' );
--实现
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_THREE_KINGDOMS', 'TRAIT_FARM_FOOD_DISTRICT_SEOWON_CHAOXIAN' );

-- 善德
UPDATE ModifierArguments
   SET Value = 6
 WHERE ModifierId = 'TRAIT_ADJUST_CITY_CULTURE_PER_GOVERNOR_TITLE_MODIFIER' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value = 4
 WHERE ModifierId = 'TRAIT_ADJUST_CITY_SCIENCE_PER_GOVERNOR_TITLE_MODIFIER' AND Name = 'Amount';

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_HWARANG', 'MODIFIER_TRAIT_LEADER_HWARANG_GOLD' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_HWARANG_GOLD', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER_PER_GOVERNOR_TITLE', 0,
         0, 0, NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_HWARANG_GOLD', 'Amount', 5 ),
       ( 'MODIFIER_TRAIT_LEADER_HWARANG_GOLD', 'YieldType', 'YIELD_GOLD' );


INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_HWARANG', 'MODIFIER_TRAIT_LEADER_HWARANG_FOOD' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_HWARANG_FOOD', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER_PER_GOVERNOR_TITLE', 0,
         0, 0, NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_HWARANG_FOOD', 'Amount', '1' ),
       ( 'MODIFIER_TRAIT_LEADER_HWARANG_FOOD', 'YieldType', 'YIELD_FOOD' );


INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_HWARANG', 'MODIFIER_TRAIT_LEADER_HWARANG_PRODUCTION' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_HWARANG_PRODUCTION',
         'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER_PER_GOVERNOR_TITLE', 0, 0, 0, NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_HWARANG_PRODUCTION', 'Amount', 2 ),
       ( 'MODIFIER_TRAIT_LEADER_HWARANG_PRODUCTION', 'YieldType', 'YIELD_PRODUCTION' );


INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_HWARANG', 'MODIFIER_TRAIT_LEADER_HWARANG_FAITH' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_HWARANG_FAITH', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER_PER_GOVERNOR_TITLE',
         0, 0, 0, NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_HWARANG_FAITH', 'Amount', 3 ),
       ( 'MODIFIER_TRAIT_LEADER_HWARANG_FAITH', 'YieldType', 'YIELD_FAITH' );

-- 新朝鲜 世宗大王
UPDATE ModifierArguments
   SET Value='1.2'
 WHERE ModifierId LIKE 'SEJONG_%_SCIENCE_INTO_CULTURE' AND Name = 'Multiplier';

--加金币

INSERT INTO TraitModifiers( TraitType, ModifierId )
SELECT 'TRAIT_LEADER_SEJONG', 'SEJONG_' || EraType || '_SCIENCE_INTO_GOLD_TEAMPVP'
  FROM Eras
 WHERE ChronologyIndex > 1;
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, SubjectRequirementSetId )
SELECT 'SEJONG_' || EraType || '_SCIENCE_INTO_GOLD_TEAMPVP', 'MODIFIER_PLAYER_GRANT_YIELD_BASED_ON_CURRENT_YIELD_RATE',
       1, 1, 'PLAYER_HAS_' || REPLACE(EraType, 'ERA_', '') || '_TECH'
  FROM Eras
 WHERE ChronologyIndex > 1;
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'SEJONG_' || EraType || '_SCIENCE_INTO_GOLD_TEAMPVP', 'YieldToGrant', 'YIELD_GOLD'
  FROM Eras
 WHERE ChronologyIndex > 1;
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'SEJONG_' || EraType || '_SCIENCE_INTO_GOLD_TEAMPVP', 'YieldToBaseOn', 'YIELD_SCIENCE'
  FROM Eras
 WHERE ChronologyIndex > 1;
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'SEJONG_' || EraType || '_SCIENCE_INTO_GOLD_TEAMPVP', 'Multiplier', 1.2
  FROM Eras
 WHERE ChronologyIndex > 1;


-- =============================================================
-- MACEDON	马其顿

INSERT INTO Types ( Type, Kind )
VALUES ( 'GREAT_PERSON_CLASS_ALEXANDER', 'KIND_GREAT_PERSON_CLASS' );
INSERT INTO Types ( Type, Kind )
VALUES ( 'PSEUDOYIELD_GPP_ALEXANDER', 'KIND_PSEUDOYIELD' );
INSERT INTO PseudoYields ( PseudoYieldType, DefaultValue )
VALUES ( 'PSEUDOYIELD_GPP_ALEXANDER', 0.5 );
INSERT INTO GreatPersonClasses ( GreatPersonClassType, Name, UnitType, DistrictType, AvailableInTimeline, GenerateDuplicateIndividuals, PseudoYieldType,
                                 IconString, ActionIcon )
VALUES ( 'GREAT_PERSON_CLASS_ALEXANDER',
         'LOC_GREAT_PERSON_CLASS_GENERAL_NAME',
         'UNIT_GREAT_GENERAL',
         'DISTRICT_CITY_CENTER',
         0,
         1,
         'PSEUDOYIELD_GPP_ALEXANDER',
         '[ICON_GreatGeneral]',
         'ICON_UNITOPERATION_GENERAL_ACTION' );

INSERT INTO CivilopediaPageGroupExcludes( SectionId, PageGroupId )
VALUES ( 'GREATPEOPLE', 'GREAT_PERSON_CLASS_ALEXANDER' );

CREATE TEMPORARY TABLE TEMP_ALEXANDER_NUMBERS
    (
        number INT NOT NULL,
        PRIMARY KEY (number)
    );
-- INSERT INTO TEMP_ALEXANDER_NUMBERS (number)VALUES (1);
INSERT INTO TEMP_ALEXANDER_NUMBERS ( number )
  WITH x AS (SELECT 1 AS id UNION ALL SELECT id + 1 AS id FROM x WHERE id < 20)
SELECT *
  FROM x;

INSERT INTO Types( Type, Kind )
SELECT 'GREAT_PERSON_INDIVIDUAL_ALEXANDER_' || number, 'KIND_GREAT_PERSON_INDIVIDUAL'
  FROM TEMP_ALEXANDER_NUMBERS;
INSERT INTO GreatPersonIndividuals ( GreatPersonIndividualType, Name, GreatPersonClassType, EraType, Gender,
                                     ActionCharges, AreaHighlightRadius, ActionRequiresCityStateTerritory,
                                     ActionRequiresOwnedTile, ActionNameTextOverride, ActionEffectTileHighlighting,
                                     ActionEffectTextOverride )
SELECT 'GREAT_PERSON_INDIVIDUAL_ALEXANDER_' || number, 'LOC_LEADER_NW_ALEXANDER_NAME', 'GREAT_PERSON_CLASS_ALEXANDER',
       'ERA_ANCIENT', 'F', 1, 2, 1, 0, 'LOC_GREATPERSON_ACTION_NAME_RETIRE', 1,
       'LOC_GREAT_PERSON_INDIVIDUAL_ALEXANDER_ACTION_TEXT'
  FROM TEMP_ALEXANDER_NUMBERS;

INSERT INTO GreatPersonIndividualIconModifiers( GreatPersonIndividualType, OverrideUnitIcon )
SELECT 'GREAT_PERSON_INDIVIDUAL_ALEXANDER_' || number, 'ICON_UNIT_ALEXANDER_THE_GREAT'
  FROM TEMP_ALEXANDER_NUMBERS;


INSERT INTO GreatPersonIndividualBirthModifiers( GreatPersonIndividualType, ModifierId )
SELECT 'GREAT_PERSON_INDIVIDUAL_ALEXANDER_' || number, 'GREATPERSON_COMBAT_STRENGTH_AOE_MEDIEVAL_LAND'
  FROM TEMP_ALEXANDER_NUMBERS
 UNION
SELECT 'GREAT_PERSON_INDIVIDUAL_ALEXANDER_' || number, 'GREATPERSON_MOVEMENT_AOE_MEDIEVAL_LAND'
  FROM TEMP_ALEXANDER_NUMBERS
 UNION
SELECT 'GREAT_PERSON_INDIVIDUAL_ALEXANDER_' || number, 'GREATPERSON_COMBAT_STRENGTH_AOE_CLASSICAL_LAND'
  FROM TEMP_ALEXANDER_NUMBERS
 UNION
SELECT 'GREAT_PERSON_INDIVIDUAL_ALEXANDER_' || number, 'GREATPERSON_MOVEMENT_AOE_CLASSICAL_LAND'
  FROM TEMP_ALEXANDER_NUMBERS;

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_TO_WORLDS_END', 'MODIFIER_TRAIT_LEADER_TO_WORLDS_END_GREAT_PERSON_GUARANTEE' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_TO_WORLDS_END_GREAT_PERSON_GUARANTEE', 'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_GUARANTEE',
         0, 0, 0, 'NW_PLAYER_HAS_BUILDING_BASILIKOI_PAIDES', NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_TO_WORLDS_END_GREAT_PERSON_GUARANTEE', 'GreatPersonClassType',
         'GREAT_PERSON_CLASS_ALEXANDER' );

------------------------------------------------------
-- 建表：将Trait对应的终端Modifier标记出来
-- Spacial Thanks: Pen's Team Suzerain
------------------------------------------------------
CREATE TABLE IF NOT EXISTS NW_TMPG_SUZERAIN
    (
        LeaderType TEXT NOT NULL,
        ModifierId TEXT NOT NULL,
        PRIMARY KEY (LeaderType, ModifierId)
    );

 INSERT OR
REPLACE INTO NW_TMPG_SUZERAIN ( LeaderType, ModifierId )
 SELECT l.LeaderType, ma.Value
   FROM Leaders l
            JOIN LeaderTraits lt
            JOIN TraitModifiers tm
            JOIN Modifiers m
            JOIN ModifierArguments ma
            JOIN RequirementSetRequirements RSR
            ON l.LeaderType = lt.LeaderType AND lt.TraitType = tm.TraitType AND m.ModifierId = tm.ModifierId AND
               m.ModifierId = ma.ModifierId AND RSR.RequirementSetId = m.SubjectRequirementSetId
  WHERE l.InheritFrom LIKE 'LEADER/_MINOR/_CIV/_%' ESCAPE '/' AND ma.Name = 'ModifierId' AND RSR.RequirementId IN
                                                                                             (SELECT RequirementId
                                                                                                FROM Requirements
                                                                                               WHERE RequirementType = 'REQUIREMENT_PLAYER_IS_SUZERAIN');

-- 虚拟单位（挂靠Trait显示）
INSERT INTO Units( UnitType, Domain, Name, Description, Cost, BaseMoves, BaseSightRange, FormationClass, CanTrain,
                   MustPurchase, TraitType )
SELECT 'UNIT_ALEXANDER_THE_GREAT', Domain, 'LOC_LEADER_NW_ALEXANDER_NAME', 'LOC_LEADER_NW_ALEXANDER_DESCRIPTION', Cost,
       BaseMoves, BaseSightRange, FormationClass, CanTrain, MustPurchase, 'TRAIT_UNIT_ALEXANDER_THE_GREAT'
  FROM Units
 WHERE UnitType = 'UNIT_GREAT_GENERAL';

INSERT INTO Types( Type, Kind )
VALUES ( 'UNIT_ALEXANDER_THE_GREAT', 'KIND_UNIT' ),
       ( 'TRAIT_UNIT_ALEXANDER_THE_GREAT', 'KIND_TRAIT' );
INSERT INTO Traits( TraitType )
VALUES ( 'TRAIT_UNIT_ALEXANDER_THE_GREAT' );
INSERT INTO LeaderTraits( LeaderType, TraitType )
SELECT LeaderType, 'TRAIT_UNIT_ALEXANDER_THE_GREAT'
  FROM LeaderTraits
 WHERE TraitType = 'TRAIT_LEADER_TO_WORLDS_END';

-- =============================================================
-- MALI	马里

--马里uu
UPDATE Units
   SET Combat=51
 WHERE UnitType = 'UNIT_MALI_MANDEKALU_CAVALRY';
UPDATE Units
   SET Cost=210
 WHERE UnitType = 'UNIT_MALI_MANDEKALU_CAVALRY';


--初始赋予2点信仰
INSERT INTO Modifiers ( ModifierId, ModifierType )
VALUES ( 'SCIENCE_PRESETTLEMENT_MAOLI_JINBI_MALI', 'MODIFIER_PLAYER_GRANT_YIELD' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'SCIENCE_PRESETTLEMENT_MAOLI_JINBI_MALI', 'YieldType', 'YIELD_FAITH' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'SCIENCE_PRESETTLEMENT_MAOLI_JINBI_MALI', 'Amount', '2' );
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_MALI_GOLD_DESERT', 'SCIENCE_PRESETTLEMENT_MAOLI_JINBI_MALI' );

DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_MALI_GOLD_DESERT' AND ModifierId = 'TRAIT_DESERT_CITY_CENTER_FAITH';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_MALI_GOLD_DESERT' AND ModifierId = 'TRAIT_DESERT_HILLS_CITY_CENTER_FAITH';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_MALI_GOLD_DESERT' AND ModifierId = 'TRAIT_MALI_MINES_GOLD';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_MALI_GOLD_DESERT' AND ModifierId = 'TRAIT_MALI_MINES_PRODUCTION';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_MALI_GOLD_DESERT'
   AND ModifierId = 'TRAIT_PURCHASE_COMMERCIAL_HUB_BUILDINGS_FAITH';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_MALI_GOLD_DESERT' AND ModifierId = 'TRAIT_LESS_BUILDING_PRODUCTION';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_MALI_GOLD_DESERT' AND ModifierId = 'TRAIT_LESS_UNIT_PRODUCTION';

--判断沙漠单元格
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'REQUIRES_CITY_HAS_SHAMO_QIULING', 'REQUIREMENT_PLOT_TERRAIN_CLASS_MATCHES' );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'REQUIRES_CITY_HAS_SHAMO_QIULING', 'TerrainClass', 'TERRAIN_CLASS_DESERT' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'CITY_HAS_SHAMO_QIULING', 'REQUIRES_CITY_HAS_SHAMO_QIULING' );
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'CITY_HAS_SHAMO_QIULING', 'REQUIREMENTSET_TEST_ALL' );
--沙漠丘陵给锤
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'TRAIT_INCREASED_SHAMO_CHUI', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'CITY_HAS_SHAMO_QIULING' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_INCREASED_SHAMO_CHUI', 'YieldType', 'YIELD_GOLD' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_INCREASED_SHAMO_CHUI', 'Amount', 2 );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_MALI_GOLD_DESERT', 'TRAIT_INCREASED_SHAMO_CHUI' );

--马里
UPDATE ModifierArguments
   SET Value='0'
 WHERE ModifierId = 'SUGUBA_CHEAPER_BUILDING_PURCHASE' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='5'
 WHERE ModifierId = 'SUGUBA_CHEAPER_DISTRICT_PURCHASE' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='0'
 WHERE ModifierId = 'SUGUBA_CHEAPER_UNIT_PURCHASE' AND Name = 'Amount';

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_SAHEL_MERCHANTS', 'TRAIT_INTERNATIONAL_TRADE_GAIN_GOLD_2' );
INSERT INTO Modifiers ( ModifierId, ModifierType )
VALUES ( 'TRAIT_INTERNATIONAL_TRADE_GAIN_GOLD_2', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_INTERNATIONAL_TRADE_GAIN_GOLD_2', 'YieldType', 'YIELD_FAITH' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_INTERNATIONAL_TRADE_GAIN_GOLD_2', 'Amount', 2 );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_INTERNATIONAL_TRADE_GAIN_GOLD_2', 'Intercontinental', 'false' );

--马里平沙外商不加金
UPDATE ModifierArguments
   SET Value='0'
 WHERE ModifierId = 'TRADE_ROUTE_GOLD_DESERT_ORIGIN' AND Name = 'Amount';

--马里商业区相邻圣地
UPDATE Adjacency_YieldChanges
   SET YieldChange='1'
 WHERE ID = 'Holy_Site_Gold' AND AdjacentDistrict = 'DISTRICT_HOLY_SITE' AND YieldType = 'YIELD_GOLD'
   AND YieldChange = '2';
UPDATE Adjacency_YieldChanges
   SET YieldChange='1'
 WHERE ID = 'Lavra_Gold' AND AdjacentDistrict = 'DISTRICT_LAVRA' AND YieldType = 'YIELD_GOLD' AND YieldChange = '2';

-- 新马里
UPDATE ModifierArguments
   SET Value=8
 WHERE ModifierId = 'SUNDIATA_KEITA_GREAT_WORK_GOLD_WRITING' AND Name = 'YieldChange';
UPDATE ModifierArguments
   SET Value=18
 WHERE ModifierId = 'SUNDIATA_KEITA_PURCHASE_GREAT_PEOPLE' AND Name = 'Amount';

-- =============================================================
-- MAORI	毛利
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_KUPES_VOYAGE' AND ModifierId = 'SCIENCE_PRESETTLEMENT';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_KUPES_VOYAGE' AND ModifierId = 'CULTURE_PRESETTLEMENT';
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_KUPES_VOYAGE' AND ModifierId = 'POPULATION_PRESETTLEMENT';

DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_MAORI_MANA' AND ModifierId = 'TRAIT_MAORI_MANA_OCEAN';

UPDATE ModifierArguments
   SET Value='1'
 WHERE ModifierId = 'MANA_EMBARKED_EXTRA_MOVEMENT' AND Name = 'Amount';

-- =============================================================
-- MAPUCHE	马普切

--黄金时代减忠诚度
UPDATE ModifierArguments
   SET Value='0'
 WHERE ModifierId = 'TRAIT_DIMINISH_LOYALTY_IN_ENEMY_CITY' AND Name = 'AdditionalGoldenAge';
UPDATE ModifierArguments
   SET Value='-20'
 WHERE ModifierId = 'TRAIT_DIMINISH_LOYALTY_IN_ENEMY_CITY' AND Name = 'Amount';
--黄金时代+3力
UPDATE ModifierArguments
   SET Value='3'
 WHERE ModifierId = 'TRAIT_TOQUI_COMBAT_BONUS_VS_GOLDEN_AGE_CIV';
--马普切UU
UPDATE Units
   SET Combat=56, BaseMoves=4, Cost=230
 WHERE UnitType = 'UNIT_MAPUCHE_MALON_RAIDER';
--追猎升级马普切
UPDATE UnitUpgrades
   SET UpgradeUnit='UNIT_CUIRASSIER'
 WHERE Unit = 'UNIT_ARABIAN_MAMLUK' AND UpgradeUnit = 'UNIT_TANK';
INSERT INTO UnitReplaces ( CivUniqueUnitType, ReplacesUnitType )
VALUES ( 'UNIT_MAPUCHE_MALON_RAIDER', 'UNIT_COURSER' );

--范围+3力->+1
UPDATE ModifierArguments
   SET Value='1'
 WHERE ModifierId = 'MALON_RAIDER_TERRITORY_COMBAT_BONUS' AND Name = 'Amount';

--距离
--木人最小2,50%
UPDATE Improvements
   SET MinimumAppeal=2, YieldFromAppealPercent=25
 WHERE ImprovementType = 'IMPROVEMENT_CHEMAMULL';
INSERT INTO Improvement_YieldChanges ( ImprovementType, YieldType, YieldChange )
VALUES ( 'IMPROVEMENT_CHEMAMULL', 'YIELD_CULTURE', '1' ),
       ( 'IMPROVEMENT_CHEMAMULL', 'YIELD_FOOD', '0' );
INSERT INTO Improvement_BonusYieldChanges ( Id, ImprovementType, YieldType, BonusYieldChange, PrereqCivic )
VALUES ( 'IMPROVEMENT_CHEMAMULL-01', 'IMPROVEMENT_CHEMAMULL', 'YIELD_FOOD', '1', 'CIVIC_CIVIL_SERVICE' );
INSERT INTO Improvement_BonusYieldChanges ( Id, ImprovementType, YieldType, BonusYieldChange, PrereqCivic )
VALUES ( 'IMPROVEMENT_CHEMAMULL-02', 'IMPROVEMENT_CHEMAMULL', 'YIELD_PRODUCTION', '1', 'CIVIC_MERCANTILISM' );
UPDATE Improvements
   SET SameAdjacentValid=0
 WHERE ImprovementType = 'IMPROVEMENT_CHEMAMULL';

--马普切
UPDATE ModifierArguments
   SET Value='7'
 WHERE ModifierId = 'TOQUI_CULTURE_FROM_GOVERNOR' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='7'
 WHERE ModifierId = 'TOQUI_PRODUCTION_FROM_GOVERNOR' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='14'
 WHERE ModifierId = 'TOQUI_CULTURE_GOVERNOR_NOT_FOUNDED' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='14'
 WHERE ModifierId = 'TOQUI_PRODUCTION_GOVERNOR_NOT_FOUNDED' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='50'
 WHERE ModifierId = 'TOQUI_GOVERNOR_UNIT_EXPERIENCE' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='100'
 WHERE ModifierId = 'TOQUI_GOVERNOR_UNIT_EXPERIENCE_NOT_FOUNDED' AND Name = 'Amount';

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_MAPUCHE_TOQUI', 'TRAIT_CIVILIZATION_MAPUCHE_TOQUI_APPEAL_FOUNDED' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'TRAIT_CIVILIZATION_MAPUCHE_TOQUI_APPEAL_FOUNDED', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_APPEAL', 0, 0, 0, NULL, 'CITY_HAS_GOVERNOR_FOUNDED' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_CIVILIZATION_MAPUCHE_TOQUI_APPEAL_FOUNDED', 'Amount', 1 );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_MAPUCHE_TOQUI', 'TRAIT_CIVILIZATION_MAPUCHE_TOQUI_APPEAL_NOT_FOUNDED' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'TRAIT_CIVILIZATION_MAPUCHE_TOQUI_APPEAL_NOT_FOUNDED', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_APPEAL', 0, 0, 0, NULL, 'CITY_HAS_GOVERNOR_NOT_FOUNDED' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_CIVILIZATION_MAPUCHE_TOQUI_APPEAL_NOT_FOUNDED', 'Amount', 2 );

INSERT INTO Types ( Type, Kind )
VALUES ( 'P0K_MAPUCHE_ABILITY_PATAGONIAN_HERITAGE', 'KIND_ABILITY' );
INSERT INTO TypeTags ( Type, Tag )
VALUES ( 'P0K_MAPUCHE_ABILITY_PATAGONIAN_HERITAGE', 'CLASS_ALL_UNITS' );
INSERT INTO UnitAbilities ( UnitAbilityType, Name, Description, Inactive )
VALUES ( 'P0K_MAPUCHE_ABILITY_PATAGONIAN_HERITAGE', 'LOC_P0K_MAPUCHE_ABILITY_PATAGONIAN_HERITAGE_NAME', 'LOC_P0K_MAPUCHE_ABILITY_PATAGONIAN_HERITAGE_DESCRIPTION', 1 );
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_MAPUCHE_TOQUI', 'P0K_TRAIT_ADJACENT_MOUNTAIN_MOVEMENT_ABILITY' );
INSERT INTO UnitAbilityModifiers ( UnitAbilityType, ModifierId )
VALUES ( 'P0K_MAPUCHE_ABILITY_PATAGONIAN_HERITAGE', 'P0K_PATAGONIAN_HERITAGE_ABILITY_EXTRA_MOVEMENT' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'P0K_PATAGONIAN_HERITAGE_ABILITY_EXTRA_MOVEMENT', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 'P0K_MAPUCHE_NEAR_MOUNTAIN' ),
       ( 'P0K_TRAIT_ADJACENT_MOUNTAIN_MOVEMENT_ABILITY', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 'P0K_MAPUCHE_NEAR_MOUNTAIN' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'P0K_PATAGONIAN_HERITAGE_ABILITY_EXTRA_MOVEMENT', 'Amount', 1 ),
       ( 'P0K_TRAIT_ADJACENT_MOUNTAIN_MOVEMENT_ABILITY', 'AbilityType', 'P0K_MAPUCHE_ABILITY_PATAGONIAN_HERITAGE' );
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'P0K_MAPUCHE_NEAR_MOUNTAIN', 'REQUIREMENTSET_TEST_ANY' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'P0K_MAPUCHE_NEAR_MOUNTAIN', 'P0K_MAPUCHE_REQUIRES_NEAR_MOUNTAIN_GRASS' ),
       ( 'P0K_MAPUCHE_NEAR_MOUNTAIN', 'P0K_MAPUCHE_REQUIRES_NEAR_MOUNTAIN_PLAINS' ),
       ( 'P0K_MAPUCHE_NEAR_MOUNTAIN', 'P0K_MAPUCHE_REQUIRES_NEAR_MOUNTAIN_DESERT' ),
       ( 'P0K_MAPUCHE_NEAR_MOUNTAIN', 'P0K_MAPUCHE_REQUIRES_NEAR_MOUNTAIN_TUNDRA' ),
       ( 'P0K_MAPUCHE_NEAR_MOUNTAIN', 'P0K_MAPUCHE_REQUIRES_NEAR_MOUNTAIN_SNOW' );
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'P0K_MAPUCHE_REQUIRES_NEAR_MOUNTAIN_GRASS', 'REQUIREMENT_PLOT_ADJACENT_TERRAIN_TYPE_MATCHES' ),
       ( 'P0K_MAPUCHE_REQUIRES_NEAR_MOUNTAIN_PLAINS', 'REQUIREMENT_PLOT_ADJACENT_TERRAIN_TYPE_MATCHES' ),
       ( 'P0K_MAPUCHE_REQUIRES_NEAR_MOUNTAIN_DESERT', 'REQUIREMENT_PLOT_ADJACENT_TERRAIN_TYPE_MATCHES' ),
       ( 'P0K_MAPUCHE_REQUIRES_NEAR_MOUNTAIN_TUNDRA', 'REQUIREMENT_PLOT_ADJACENT_TERRAIN_TYPE_MATCHES' ),
       ( 'P0K_MAPUCHE_REQUIRES_NEAR_MOUNTAIN_SNOW', 'REQUIREMENT_PLOT_ADJACENT_TERRAIN_TYPE_MATCHES' );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'P0K_MAPUCHE_REQUIRES_NEAR_MOUNTAIN_GRASS', 'TerrainType', 'TERRAIN_GRASS_MOUNTAIN' ),
       ( 'P0K_MAPUCHE_REQUIRES_NEAR_MOUNTAIN_PLAINS', 'TerrainType', 'TERRAIN_PLAINS_MOUNTAIN' ),
       ( 'P0K_MAPUCHE_REQUIRES_NEAR_MOUNTAIN_DESERT', 'TerrainType', 'TERRAIN_DESERT_MOUNTAIN' ),
       ( 'P0K_MAPUCHE_REQUIRES_NEAR_MOUNTAIN_TUNDRA', 'TerrainType', 'TERRAIN_TUNDRA_MOUNTAIN' ),
       ( 'P0K_MAPUCHE_REQUIRES_NEAR_MOUNTAIN_SNOW', 'TerrainType', 'TERRAIN_SNOW_MOUNTAIN' );
-- =============================================================
-- MAYA	玛雅

--玛雅不送工人
UPDATE ModifierArguments
   SET Value='0'
 WHERE ModifierId = 'TRAIT_LEADER_NEARBY_CITIES_GAIN_BUILDER' AND Name = 'Amount';

--玛雅
UPDATE Units
   SET Cost=60
 WHERE UnitType = 'UNIT_MAYAN_HULCHE';
UPDATE ModifierArguments
   SET Value=2
 WHERE ModifierId = 'HULCHE_BONUS_VS_WOUNDED_UNITS' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value=2
 WHERE ModifierId = 'MUTAL_NEAR_CAPITAL_COMBAT' AND Name = 'Amount';

--玛雅 天文台 相邻种植园+1科技
UPDATE Adjacency_YieldChanges
   SET YieldChange='1'
 WHERE ID = 'Plantation_Science';
UPDATE Adjacency_YieldChanges
   SET YieldType='YIELD_GOLD'
 WHERE ID = 'FARM_FOODOBSERVATORYADJACENCY';

DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_MUTAL' AND ModifierId = 'TRAIT_LEADER_NEARBY_CITIES_LOSE_YIELDS';

DELETE
  FROM StartBiasResources
 WHERE CivilizationType = 'CIVILIZATION_MAYA' AND ResourceType = 'RESOURCE_SPICES';
DELETE
  FROM StartBiasResources
 WHERE CivilizationType = 'CIVILIZATION_MAYA' AND ResourceType = 'RESOURCE_COFFEE';
DELETE
  FROM StartBiasResources
 WHERE CivilizationType = 'CIVILIZATION_MAYA' AND ResourceType = 'RESOURCE_SILK';
UPDATE StartBiasResources
   SET Tier=1
 WHERE CivilizationType = 'CIVILIZATION_MAYA' AND ResourceType = 'RESOURCE_CITRUS';
UPDATE StartBiasResources
   SET Tier=1
 WHERE CivilizationType = 'CIVILIZATION_MAYA' AND ResourceType = 'RESOURCE_COCOA';
UPDATE StartBiasResources
   SET Tier=1
 WHERE CivilizationType = 'CIVILIZATION_MAYA' AND ResourceType = 'RESOURCE_COTTON';
UPDATE StartBiasResources
   SET Tier=1
 WHERE CivilizationType = 'CIVILIZATION_MAYA' AND ResourceType = 'RESOURCE_DYES';
UPDATE StartBiasResources
   SET Tier=1
 WHERE CivilizationType = 'CIVILIZATION_MAYA' AND ResourceType = 'RESOURCE_SUGAR';
UPDATE StartBiasResources
   SET Tier=1
 WHERE CivilizationType = 'CIVILIZATION_MAYA' AND ResourceType = 'RESOURCE_TEA';
UPDATE StartBiasResources
   SET Tier=1
 WHERE CivilizationType = 'CIVILIZATION_MAYA' AND ResourceType = 'RESOURCE_TOBACCO';
UPDATE StartBiasResources
   SET Tier=1
 WHERE CivilizationType = 'CIVILIZATION_MAYA' AND ResourceType = 'RESOURCE_WINE';
UPDATE StartBiasResources
   SET Tier=1
 WHERE CivilizationType = 'CIVILIZATION_MAYA' AND ResourceType = 'RESOURCE_INCENSE';
UPDATE StartBiasResources
   SET Tier=1
 WHERE CivilizationType = 'CIVILIZATION_MAYA' AND ResourceType = 'RESOURCE_OLIVES';
UPDATE StartBiasResources
   SET Tier=1
 WHERE CivilizationType = 'CIVILIZATION_MAYA' AND ResourceType = 'RESOURCE_BANANAS';
UPDATE StartBiasTerrains
   SET Tier=5
 WHERE CivilizationType = 'CIVILIZATION_MAYA' AND TerrainType = 'TERRAIN_GRASS';
UPDATE StartBiasTerrains
   SET Tier=5
 WHERE CivilizationType = 'CIVILIZATION_MAYA' AND TerrainType = 'TERRAIN_PLAINS';
DELETE
  FROM StartBiasResources
 WHERE CivilizationType = 'CIVILIZATION_MAYA' AND ResourceType = 'RESOURCE_GYPSUM';
DELETE
  FROM StartBiasResources
 WHERE CivilizationType = 'CIVILIZATION_MAYA' AND ResourceType = 'RESOURCE_JADE';
DELETE
  FROM StartBiasResources
 WHERE CivilizationType = 'CIVILIZATION_MAYA' AND ResourceType = 'RESOURCE_MARBLE';
DELETE
  FROM StartBiasResources
 WHERE CivilizationType = 'CIVILIZATION_MAYA' AND ResourceType = 'RESOURCE_MERCURY';
DELETE
  FROM StartBiasResources
 WHERE CivilizationType = 'CIVILIZATION_MAYA' AND ResourceType = 'RESOURCE_SALT';
DELETE
  FROM StartBiasResources
 WHERE CivilizationType = 'CIVILIZATION_MAYA' AND ResourceType = 'RESOURCE_IVORY';

--玛雅 市中心相邻奢侈加宜居度
UPDATE Modifiers
   SET OwnerRequirementSetId='PLAYER_HAS_POLITICAL_PHILOSOPHY_FD_maya'
 WHERE ModifierId = 'TRAIT_ADD_AMENITY_PER_ADJACENT_LUXURY';

UPDATE ModifierArguments
   SET Value='5, 5, 5, 5, 5, 5'
 WHERE ModifierId = 'TRAIT_LEADER_NEARBY_CITIES_GAIN_YIELDS' AND Name = 'Amount';

-- =============================================================
-- MONGOLIA	蒙古

DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_MONGOLIAN_ORTOO' AND ModifierId = 'TRAIT_TRADING_POST_DIPLO_VISIBILITY';

DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_MONGOLIAN_ORTOO' AND ModifierId = 'TRAIT_EACH_DIPLO_VISIBILITY_COMBAT_MODIFIER';

--贸易战不再加外交
UPDATE Buildings
   SET Cost=100
 WHERE BuildingType = 'BUILDING_ORDU';

--蒙古UB
INSERT INTO Building_YieldChanges ( BuildingType, YieldType, YieldChange )
VALUES ( 'BUILDING_ORDU', 'YIELD_FOOD', '1' );

UPDATE Units
   SET Cost=160, Combat=32, RangedCombat=42
 WHERE UnitType = 'UNIT_MONGOLIAN_KESHIG';
INSERT INTO UnitReplaces( CivUniqueUnitType, ReplacesUnitType )
VALUES ( 'UNIT_MONGOLIAN_KESHIG', 'UNIT_CROSSBOWMAN' );

-- 加移动力改维护减免
UPDATE Modifiers
   SET ModifierType='MODIFIER_PLAYER_ADJUST_UNIT_MAINTENANCE_DISCOUNT'
 WHERE ModifierId = 'ORDU_ADJUST_MOVEMENT';

UPDATE ModifierArguments
   SET Value=10
 WHERE ModifierId = 'ORDU_ADJUST_MOVEMENT' AND Name = 'Amount';


INSERT INTO Types ( Type, Kind )
VALUES ( 'NW_MONGOLIA_ABILITY_GRASS_MOVEMENT', 'KIND_ABILITY' );
INSERT INTO TypeTags ( Type, Tag )
VALUES ( 'NW_MONGOLIA_ABILITY_GRASS_MOVEMENT', 'CLASS_ALL_UNITS' );
INSERT INTO UnitAbilities ( UnitAbilityType, Name, Description, Inactive )
VALUES ( 'NW_MONGOLIA_ABILITY_GRASS_MOVEMENT', 'LOC_TRAIT_CIVILIZATION_MONGOLIAN_ORTOO_NAME', 'LOC_NW_MONGOLIA_ABILITY_GRASS_MOVEMENT_DESCRIPTION', 1 );
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_MONGOLIAN_ORTOO', 'NW_TRAIT_GRASS_MOVEMENT_ABILITY' );
INSERT INTO UnitAbilityModifiers ( UnitAbilityType, ModifierId )
VALUES ( 'NW_MONGOLIA_ABILITY_GRASS_MOVEMENT', 'NW_MONGOLIA_ABILITY_GRASS_EXTRA_MOVEMENT' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'NW_MONGOLIA_ABILITY_GRASS_EXTRA_MOVEMENT', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', NULL ),
       ( 'NW_TRAIT_GRASS_MOVEMENT_ABILITY', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 'NW_REQS_TERRAIN_IS_TERRAIN_CLASS_GRASS' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'NW_MONGOLIA_ABILITY_GRASS_EXTRA_MOVEMENT', 'Amount', 1 ),
       ( 'NW_TRAIT_GRASS_MOVEMENT_ABILITY', 'AbilityType', 'NW_MONGOLIA_ABILITY_GRASS_MOVEMENT' );
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'NW_REQS_TERRAIN_IS_TERRAIN_CLASS_GRASS', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'NW_REQS_TERRAIN_IS_TERRAIN_CLASS_GRASS', 'NW_REQ_PLOT_IS_TERRAIN_CLASS_GRASS' );
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'NW_REQ_PLOT_IS_TERRAIN_CLASS_GRASS', 'REQUIREMENT_PLOT_TERRAIN_CLASS_MATCHES' );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'NW_REQ_PLOT_IS_TERRAIN_CLASS_GRASS', 'TerrainClass', 'TERRAIN_CLASS_GRASS' );

-- 成吉思汗
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_GENGHIS_KHAN_ABILITY' AND ModifierId = 'TRAIT_COMBAT_BONUS_FOR_CAVALRY';

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_GENGHIS_KHAN_ABILITY', 'MODFEAT_TRAIT_LEADER_GENGHIS_KHAN_ABILITY_GRANT_UNIT' );
INSERT INTO Modifiers ( ModifierId, ModifierType )
VALUES ( 'MODFEAT_TRAIT_LEADER_GENGHIS_KHAN_ABILITY_GRANT_UNIT', 'MODIFIER_PLAYER_GRANT_FREE_RESOURCE_VISIBILITY' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODFEAT_TRAIT_LEADER_GENGHIS_KHAN_ABILITY_GRANT_UNIT', 'ResourceType', 'RESOURCE_HORSES' );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_GENGHIS_KHAN_ABILITY', 'MODIFIER_TRAIT_LEADER_GENGHIS_KHAN_ABILITY_IMPROVEMENT_ADJACENCY' );
INSERT INTO Modifiers( ModifierId, ModifierType )
VALUES ( 'MODIFIER_TRAIT_LEADER_GENGHIS_KHAN_ABILITY_IMPROVEMENT_ADJACENCY', 'MODIFIER_PLAYER_CITIES_IMPROVEMENT_ADJACENCY' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_GENGHIS_KHAN_ABILITY_IMPROVEMENT_ADJACENCY', 'Amount', '2' ),
       ( 'MODIFIER_TRAIT_LEADER_GENGHIS_KHAN_ABILITY_IMPROVEMENT_ADJACENCY', 'Description', 'LOC_MODIFIER_TRAIT_LEADER_GENGHIS_KHAN_ABILITY_IMPROVEMENT_ADJACENCY' ),
       ( 'MODIFIER_TRAIT_LEADER_GENGHIS_KHAN_ABILITY_IMPROVEMENT_ADJACENCY', 'DistrictType', 'DISTRICT_COMMERCIAL_HUB' ),
       ( 'MODIFIER_TRAIT_LEADER_GENGHIS_KHAN_ABILITY_IMPROVEMENT_ADJACENCY', 'ImprovementType', 'IMPROVEMENT_MINE' ),
       ( 'MODIFIER_TRAIT_LEADER_GENGHIS_KHAN_ABILITY_IMPROVEMENT_ADJACENCY', 'TilesRequired', '1' ),
       ( 'MODIFIER_TRAIT_LEADER_GENGHIS_KHAN_ABILITY_IMPROVEMENT_ADJACENCY', 'YieldType', 'YIELD_GOLD' );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_GENGHIS_KHAN_ABILITY', 'MODIFIER_TRAIT_LEADER_GENGHIS_KHAN_ABILITY_PER_POST_IN_OWN_CITY' );
INSERT INTO Modifiers( ModifierId, ModifierType )
VALUES ( 'MODIFIER_TRAIT_LEADER_GENGHIS_KHAN_ABILITY_PER_POST_IN_OWN_CITY', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_PER_POST_IN_OWN_CITY' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_GENGHIS_KHAN_ABILITY_PER_POST_IN_OWN_CITY', 'Amount', '1' ),
       ( 'MODIFIER_TRAIT_LEADER_GENGHIS_KHAN_ABILITY_PER_POST_IN_OWN_CITY', 'YieldType', 'YIELD_SCIENCE' );

-- 忽蒙等于忽中

-- =============================================================
-- NETHERLANDS	荷兰

DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_RADIO_ORANJE' AND ModifierId IN ('TRAIT_IDENTITY_FROM_DOMESTIC_TRADE_ROUTES',
                                                           'TRAIT_CULTURE_FROM_INTERNATIONAL_TRADE_ROUTES',
                                                           'TRAIT_CULTURE_FROM_INCOMING_TRADE_ROUTES'
     );

-- 市政广场建筑额外提供等同于宫殿的基础产出。向城邦派遣的第一名 [ICON_ENVOY] 使者视为2名。
INSERT INTO TraitModifiers ( TraitType, ModifierId )
SELECT 'TRAIT_RADIO_ORANJE', 'MODIFIER_TRAIT_RADIO_ORANJE_' || Buildings.BuildingType || '_' || YieldType
  FROM Buildings
           JOIN Building_YieldChanges
 WHERE Building_YieldChanges.BuildingType = 'BUILDING_PALACE' AND Buildings.PrereqDistrict = 'DISTRICT_GOVERNMENT';

INSERT INTO Modifiers ( ModifierId, ModifierType )
SELECT 'MODIFIER_TRAIT_RADIO_ORANJE_' || Buildings.BuildingType || '_' || YieldType,
       'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE'
  FROM Buildings
           JOIN Building_YieldChanges
 WHERE Building_YieldChanges.BuildingType = 'BUILDING_PALACE' AND Buildings.PrereqDistrict = 'DISTRICT_GOVERNMENT';

INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'MODIFIER_TRAIT_RADIO_ORANJE_' || Buildings.BuildingType || '_' || YieldType, 'Amount', YieldChange
  FROM Buildings
           JOIN Building_YieldChanges
 WHERE Building_YieldChanges.BuildingType = 'BUILDING_PALACE' AND Buildings.PrereqDistrict = 'DISTRICT_GOVERNMENT'
 UNION
SELECT 'MODIFIER_TRAIT_RADIO_ORANJE_' || Buildings.BuildingType || '_' || YieldType, 'BuildingType',
       Buildings.BuildingType
  FROM Buildings
           JOIN Building_YieldChanges
 WHERE Building_YieldChanges.BuildingType = 'BUILDING_PALACE' AND Buildings.PrereqDistrict = 'DISTRICT_GOVERNMENT'
 UNION
SELECT 'MODIFIER_TRAIT_RADIO_ORANJE_' || Buildings.BuildingType || '_' || YieldType, 'YieldType', YieldType
  FROM Buildings
           JOIN Building_YieldChanges
 WHERE Building_YieldChanges.BuildingType = 'BUILDING_PALACE' AND Buildings.PrereqDistrict = 'DISTRICT_GOVERNMENT';

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_RADIO_ORANJE', 'MODIFIER_TRAIT_RADIO_ORANJE_EXTRA_TOKEN' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_RADIO_ORANJE_EXTRA_TOKEN', 'MODIFIER_PLAYER_ADJUST_DUPLICATE_FIRST_INFLUENCE_TOKEN', 0, 0, 0, NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_RADIO_ORANJE_EXTRA_TOKEN', 'Amount', '1' );

--荷兰85%
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_GROTE_RIVIEREN', 'TRAIT_GANGKOU_AQUEDUCT_PRODUCTION_' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId, OwnerRequirementSetId )
VALUES ( 'TRAIT_GANGKOU_AQUEDUCT_PRODUCTION_', 'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION', NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_GANGKOU_AQUEDUCT_PRODUCTION_', 'DistrictType', 'DISTRICT_HARBOR' ),
       ( 'TRAIT_GANGKOU_AQUEDUCT_PRODUCTION_', 'Amount', 100 );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_GROTE_RIVIEREN', 'MODIFIER_TRAIT_CIVILIZATION_GROTE_RIVIEREN_TRADER_GPP' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_CIVILIZATION_GROTE_RIVIEREN_TRADER_GPP', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 0, 0, 0, NULL, 'NW_DTMS_REQS_UNIT_IS_TRADER_IN_WATER' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_CIVILIZATION_GROTE_RIVIEREN_TRADER_GPP', 'ModifierId', 'MODIFIER_TRAIT_CIVILIZATION_GROTE_RIVIEREN_TRADER_GPP_ATTACH' );

INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_CIVILIZATION_GROTE_RIVIEREN_TRADER_GPP_ATTACH', 'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS', 0, 0, 0, NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_CIVILIZATION_GROTE_RIVIEREN_TRADER_GPP_ATTACH', 'Amount', '1' ),
       ( 'MODIFIER_TRAIT_CIVILIZATION_GROTE_RIVIEREN_TRADER_GPP_ATTACH', 'GreatPersonClassType', 'GREAT_PERSON_CLASS_MERCHANT' );

INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'NW_DTMS_REQS_UNIT_IS_TRADER_IN_WATER', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'NW_DTMS_REQS_UNIT_IS_TRADER_IN_WATER', 'NW_DTMS_REQ_UNIT_IS_TRADER' ),
       ( 'NW_DTMS_REQS_UNIT_IS_TRADER_IN_WATER', 'NW_DTMS_REQS_PLOT_IN_WATER' );
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'NW_DTMS_REQ_UNIT_IS_TRADER', 'REQUIREMENT_UNIT_TYPE_MATCHES' ),
       ( 'NW_DTMS_REQS_PLOT_IN_WATER', 'REQUIREMENT_PLOT_TERRAIN_CLASS_MATCHES' );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'NW_DTMS_REQ_UNIT_IS_TRADER', 'UnitType', 'UNIT_TRADER' ),
       ( 'NW_DTMS_REQS_PLOT_IN_WATER', 'TerrainClass', 'TERRAIN_CLASS_WATER' );



-- =============================================================
-- NORWAY	挪威

--木板教堂 减少花费
UPDATE Buildings
   SET Cost=65
 WHERE BuildingType = 'BUILDING_STAVE_CHURCH';

DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_EARLY_OCEAN_NAVIGATION' AND ModifierId IN ('TRAIT_IGNORE_EMBARK_DISEMBARK_COST',
                                                                                  'TRAIT_MELEE_NAVAL_HEAL_NEUTRAL');

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_EARLY_OCEAN_NAVIGATION', 'P0K_TRAIT_SEA_TO_SUMMIT_COAST_CITY_CENTER_FAITH' ),
       ( 'TRAIT_CIVILIZATION_EARLY_OCEAN_NAVIGATION', 'P0K_TRAIT_SEA_TO_SUMMIT_COAST_CITY_CENTER_PRODUCTION' ),
       ( 'TRAIT_CIVILIZATION_EARLY_OCEAN_NAVIGATION', 'P0K_TRAIT_BREATHTAKING_COASTAL_CULTURE' ),
       ( 'TRAIT_CIVILIZATION_EARLY_OCEAN_NAVIGATION', 'P0K_TRAIT_BREATHTAKING_COASTAL_FOOD' );

INSERT INTO Modifiers ( ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'P0K_TRAIT_SEA_TO_SUMMIT_COAST_CITY_CENTER_FAITH', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', NULL, 'P0K_NORWAY_COASTAL_CITY_CENTER' ),
       ( 'P0K_TRAIT_SEA_TO_SUMMIT_COAST_CITY_CENTER_PRODUCTION', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', NULL, 'P0K_NORWAY_COASTAL_CITY_CENTER' ),
       ( 'P0K_TRAIT_BREATHTAKING_COASTAL_CULTURE', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'NW_PLAYER_HAS_CIVIC_EARLY_EMPIRE', 'P0K_NORWAY_BREATHTAKING_ADJACENT_TO_WATER' ),
       ( 'P0K_TRAIT_BREATHTAKING_COASTAL_FOOD', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'NW_PLAYER_HAS_CIVIC_EARLY_EMPIRE', 'P0K_NORWAY_BREATHTAKING_ADJACENT_TO_WATER' );

INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'P0K_TRAIT_SEA_TO_SUMMIT_COAST_CITY_CENTER_FAITH', 'YieldType', 'YIELD_FAITH' ),
       ( 'P0K_TRAIT_SEA_TO_SUMMIT_COAST_CITY_CENTER_FAITH', 'Amount', 1 ),
       ( 'P0K_TRAIT_SEA_TO_SUMMIT_COAST_CITY_CENTER_PRODUCTION', 'YieldType', 'YIELD_PRODUCTION' ),
       ( 'P0K_TRAIT_SEA_TO_SUMMIT_COAST_CITY_CENTER_PRODUCTION', 'Amount', 1 ),
       ( 'P0K_TRAIT_BREATHTAKING_COASTAL_CULTURE', 'YieldType', 'YIELD_CULTURE' ),
       ( 'P0K_TRAIT_BREATHTAKING_COASTAL_CULTURE', 'Amount', 1 ),
       ( 'P0K_TRAIT_BREATHTAKING_COASTAL_FOOD', 'YieldType', 'YIELD_FOOD' ),
       ( 'P0K_TRAIT_BREATHTAKING_COASTAL_FOOD', 'Amount', 1 );

INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'P0K_NORWAY_COASTAL_CITY_CENTER', 'REQUIREMENTSET_TEST_ALL' ),
       ( 'P0K_NORWAY_BREATHTAKING_ADJACENT_TO_WATER', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'P0K_NORWAY_COASTAL_CITY_CENTER', 'P0K_NORWAY_REQUIRES_PLOT_HAS_CITY_CENTER' ),
       ( 'P0K_NORWAY_COASTAL_CITY_CENTER', 'REQUIRES_PLOT_ADJACENT_TO_COAST' ),
       ( 'P0K_NORWAY_BREATHTAKING_ADJACENT_TO_WATER', 'REQUIRES_PLOT_BREATHTAKING_APPEAL' ),
       ( 'P0K_NORWAY_BREATHTAKING_ADJACENT_TO_WATER', 'REQUIRES_PLOT_IS_ADJACENT_TO_COAST' );
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'P0K_NORWAY_REQUIRES_PLOT_HAS_CITY_CENTER', 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES' );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'P0K_NORWAY_REQUIRES_PLOT_HAS_CITY_CENTER', 'DistrictType', 'DISTRICT_CITY_CENTER' );


--挪威狂暴武士 游泳加速
INSERT INTO Types ( Type, Kind )
VALUES ( 'ABILITY_NUOWEI', 'KIND_ABILITY' );
INSERT INTO TypeTags ( Type, Tag )
VALUES ( 'ABILITY_NUOWEI', 'CLASS_MELEE' );
INSERT INTO UnitAbilities ( UnitAbilityType, Name, Description, Inactive )
VALUES ( 'ABILITY_NUOWEI', 'LOC_ABILITY_NUOWEI_NAME', 'LOC_ABILITY_NUOWEI_DESCRIPTION', 1 );
INSERT INTO UnitAbilityModifiers ( UnitAbilityType, ModifierId )
VALUES ( 'ABILITY_NUOWEI', 'NUOWEI_EMBARKED_EXTRA_MOVEMENT' );
INSERT INTO Modifiers ( ModifierId, ModifierType, OwnerRequirementSetId )
VALUES ( 'NUOWEI_EMBARKED_EXTRA_MOVEMENT', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 'REQUIREMENTS_UNIT_IS_EMBARKED' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'NUOWEI_EMBARKED_EXTRA_MOVEMENT', 'Amount', '1' );

INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'UNIT_IS_KUANGBAO', 'REQUIREMENT_UNIT_IS_kuangbao' );
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'UNIT_IS_KUANGBAO', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'REQUIREMENT_UNIT_IS_kuangbao', 'REQUIREMENT_UNIT_TYPE_MATCHES' );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'REQUIREMENT_UNIT_IS_kuangbao', 'UnitType', 'UNIT_NORWEGIAN_BERSERKER' );

INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId, Permanent )
VALUES ( 'TRAIT_NUOWEI_EMBARKED_ABILITY', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 'UNIT_IS_KUANGBAO', 1 );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_NUOWEI_EMBARKED_ABILITY', 'AbilityType', 'ABILITY_NUOWEI' );
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_EARLY_OCEAN_NAVIGATION', 'TRAIT_NUOWEI_EMBARKED_ABILITY' );

--挪威
UPDATE Units
   SET Combat=47, Cost=180, BaseMoves=3
 WHERE UnitType = 'UNIT_NORWEGIAN_BERSERKER';
UPDATE ModifierArguments
   SET Value='1'
 WHERE ModifierId = 'BERSERKER_FASTER_ENEMY_TERRITORY' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='-2'
 WHERE ModifierId = 'UNIT_WEAK_WHEN_DEFENDING' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='3'
 WHERE ModifierId = 'UNIT_STRONG_WHEN_ATTACKING' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='2'
 WHERE ModifierId = 'STAVECHURCH_SEARESOURCE_PRODUCTION' AND Name = 'Amount';
--信仰购买狂战士
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_UNIT_NORWEGIAN_BERSERKER', 'BERSERKER_FAITH_PURCHASE_CPLMOD' );
INSERT INTO Modifiers ( ModifierId, ModifierType )
VALUES ( 'BERSERKER_FAITH_PURCHASE_CPLMOD', 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'BERSERKER_FAITH_PURCHASE_CPLMOD', 'Tag', 'CLASS_MELEE_BERSERKER' );


-- 北方惊雷
DELETE
  FROM TraitModifiers
 WHERE TraitType AND ModifierId = 'TRAIT_LEADER_MELEE_COASTAL_RAIDS' LIKE 'TRAIT_%_NAVAL_MELEE_PRODUCTION';
DELETE
  FROM TraitModifiers
 WHERE TraitType AND ModifierId = 'TRAIT_LEADER_MELEE_COASTAL_RAIDS' LIKE 'TRAIT_LEADER_PILLAGE_%';
INSERT INTO TraitModifiers( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_MELEE_COASTAL_RAIDS', 'TRAIT_MELEE_NAVAL_HEAL_NEUTRAL' );

INSERT INTO TraitModifiers( TraitType, ModifierId )
SELECT 'TRAIT_LEADER_MELEE_COASTAL_RAIDS', 'TRAIT_LEADER_MELEE_COASTAL_RAIDS_PILLAGING_' || ImprovementType
  FROM Improvements
 WHERE PlunderAmount > 0;
INSERT INTO Modifiers ( ModifierId, ModifierType )
SELECT 'TRAIT_LEADER_MELEE_COASTAL_RAIDS_PILLAGING_' || ImprovementType, 'MODIFIER_PLAYER_ADJUST_ADDITIONAL_PILLAGING'
  FROM Improvements
 WHERE PlunderAmount > 0;
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'TRAIT_LEADER_MELEE_COASTAL_RAIDS_PILLAGING_' || ImprovementType, 'PlunderType', 'PLUNDER_SCIENCE'
  FROM Improvements
 WHERE PlunderAmount > 0
 UNION
SELECT 'TRAIT_LEADER_MELEE_COASTAL_RAIDS_PILLAGING_' || ImprovementType, 'ImprovementType', ImprovementType
  FROM Improvements
 WHERE PlunderAmount > 0
 UNION
SELECT 'TRAIT_LEADER_MELEE_COASTAL_RAIDS_PILLAGING_' || ImprovementType, 'Amount', 15
  FROM Improvements
 WHERE PlunderAmount > 0;

-- TRAIT_LEADER_HARALD_ALT
DELETE
  FROM TraitModifiers
 WHERE TraitType AND ModifierId = 'TRAIT_LEADER_HARALD_ALT' = 'HARALD_LEVY_DISCOUNT';
DELETE
  FROM TraitModifiers
 WHERE TraitType AND ModifierId = 'TRAIT_LEADER_HARALD_ALT' = 'HARALD_LEVY_UNITS_GRANT_ABILITY';
DELETE
  FROM TraitModifiers
 WHERE TraitType AND ModifierId = 'TRAIT_LEADER_HARALD_ALT' = 'ADD_ONE_INFLUENCE_TOKEN_XINNUOWEI_START';


--挪威新增获得使者
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_HARALD_ALT', 'ADD_ONE_INFLUENCE_TOKEN_XINNUOWEI' );
INSERT INTO Modifiers ( ModifierId, ModifierType, OwnerRequirementSetId )
VALUES ( 'ADD_ONE_INFLUENCE_TOKEN_XINNUOWEI', 'MODIFIER_PLAYER_GRANT_INFLUENCE_TOKEN', 'NW_PLAYER_HAS_CIVIC_EARLY_EMPIRE' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'ADD_ONE_INFLUENCE_TOKEN_XINNUOWEI', 'Amount', '1' );



-- =============================================================
-- NUBIA	努比亚
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_KANDAKE_OF_MEROE' AND ModifierId IN ('TRAIT_BASE_DISTRICT_PRODUCTION_MODIFIER',
                                                                      'TRAIT_PYRAMID_DISTRICT_PRODUCTION_MODIFIER'
     );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_KANDAKE_OF_MEROE', 'MODIFIER_TRAIT_LEADER_KANDAKE_OF_MEROE_DISTRICT_PRODUCTION_MODIFIER' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_KANDAKE_OF_MEROE_DISTRICT_PRODUCTION_MODIFIER', 'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION_MODIFIER', 0, 0, 0, NULL, 'CITY_HAS_0_SPECIALTY_DISTRICTS_REQUIREMENTS' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_KANDAKE_OF_MEROE_DISTRICT_PRODUCTION_MODIFIER', 'Amount', '100' );

DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_TA_SETI' AND ModifierId IN ('TRAIT_ANCIENT_RANGED_UNIT_PRODUCTION',
                                                                   'TRAIT_CLASSICAL_RANGED_UNIT_PRODUCTION',
                                                                   'TRAIT_MEDIEVAL_RANGED_UNIT_PRODUCTION',
                                                                   'TRAIT_RENAISSANCE_RANGED_UNIT_PRODUCTION',
                                                                   'TRAIT_INDUSTRIAL_RANGED_UNIT_PRODUCTION',
                                                                   'TRAIT_MODERN_RANGED_UNIT_PRODUCTION',
                                                                   'TRAIT_ATOMIC_RANGED_UNIT_PRODUCTION',
                                                                   'TRAIT_INFORMATION_RANGED_UNIT_PRODUCTION',
                                                                   'TRAIT_STRATEGIC_MINE_PRODUCTION',
                                                                   'TRAIT_BONUS_MINE_GOLD',
                                                                   'TRAIT_LUXURY_MINE_GOLD',
                                                                   'TRAIT_RANGED_EXPERIENCE_MODIFIER'
     );

--努比亚
INSERT INTO Types ( Type, Kind )
VALUES ( 'ABILITY_TA_SETI_RIVER_COMBAT', 'KIND_ABILITY' );
INSERT INTO TypeTags ( Type, Tag )
VALUES ( 'ABILITY_TA_SETI_RIVER_COMBAT', 'CLASS_ALL_UNITS' );
INSERT INTO UnitAbilities ( UnitAbilityType, Name, Description, Inactive )
VALUES ( 'ABILITY_TA_SETI_RIVER_COMBAT',
         'LOC_TRAIT_CIVILIZATION_TA_SETI_NAME',
         'LOC_ABILITY_TA_SETI_RIVER_COMBAT_DESCRIPTION',
         1 );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_TA_SETI', 'MODFEAT_GRANT_ABILITY_TA_SETI_RIVER_COMBAT' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODFEAT_GRANT_ABILITY_TA_SETI_RIVER_COMBAT', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 0, 0, 0, NULL, 'NW_DTMS_REQS_PLOTS_NEXT_RIVER' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODFEAT_GRANT_ABILITY_TA_SETI_RIVER_COMBAT', 'AbilityType', 'ABILITY_TA_SETI_RIVER_COMBAT' );

INSERT INTO UnitAbilityModifiers ( UnitAbilityType, ModifierId )
VALUES ( 'ABILITY_TA_SETI_RIVER_COMBAT', 'MODFEAT_ABILITY_TA_SETI_RIVER_COMBAT_COMBAT' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'MODFEAT_ABILITY_TA_SETI_RIVER_COMBAT_COMBAT', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'UNIT_STRONG_WHEN_ATTACKING_REQUIREMENTS' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODFEAT_ABILITY_TA_SETI_RIVER_COMBAT_COMBAT', 'Amount', 2 );
INSERT INTO ModifierStrings ( ModifierId, Context, Text )
VALUES ( 'MODFEAT_ABILITY_TA_SETI_RIVER_COMBAT_COMBAT', 'Preview', '{LOC_MODFEAT_ABILITY_TA_SETI_RIVER_COMBAT_COMBAT}' );

INSERT INTO UnitAbilityModifiers ( UnitAbilityType, ModifierId )
VALUES ( 'ABILITY_TA_SETI_RIVER_COMBAT', 'AMPHIBIOUS_BONUS_IGNORE_RIVERS' );

-- 如果区域相邻河流，则可以使用 [ICON_FAITH] 信仰值购买其中的建筑
INSERT INTO TraitModifiers ( TraitType, ModifierId )
SELECT 'TRAIT_CIVILIZATION_TA_SETI', 'MODIFIER_TRAIT_CIVILIZATION_TA_SETI_ATTACH_' || DistrictType
  FROM Districts;
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
SELECT 'MODIFIER_TRAIT_CIVILIZATION_TA_SETI_ATTACH_' || DistrictType, 'MODIFIER_PLAYER_DISTRICTS_ATTACH_MODIFIER', 0, 0,
       0, NULL, 'NW_DISTRICT_IS_NEXT_RIVER_' || DistrictType
  FROM Districts;
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'MODIFIER_TRAIT_CIVILIZATION_TA_SETI_ATTACH_' || DistrictType, 'ModifierId',
       'MODIFIER_TRAIT_CIVILIZATION_TA_SETI_FAITH_PURCHESE_' || DistrictType
  FROM Districts;

INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
SELECT 'MODIFIER_TRAIT_CIVILIZATION_TA_SETI_FAITH_PURCHESE_' || DistrictType,
       'MODIFIER_SINGLE_CITY_ENABLE_BUILDING_FAITH_PURCHASE', 0, 0, 0, NULL, NULL
  FROM Districts;
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'MODIFIER_TRAIT_CIVILIZATION_TA_SETI_FAITH_PURCHESE_' || DistrictType, 'DistrictType', DistrictType
  FROM Districts;

-- Custom ModifierType
INSERT INTO Types ( Type, Kind )
VALUES ( 'MODIFIER_SINGLE_CITY_ENABLE_BUILDING_FAITH_PURCHASE', 'KIND_MODIFIER' );
INSERT INTO DynamicModifiers ( ModifierType, CollectionType, EffectType )
VALUES ( 'MODIFIER_SINGLE_CITY_ENABLE_BUILDING_FAITH_PURCHASE', 'COLLECTION_OWNER', 'EFFECT_ENABLE_BUILDING_FAITH_PURCHASE' );


-- RequirementSets
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
SELECT 'NW_DISTRICT_IS_NEXT_RIVER_' || DistrictType, 'REQUIREMENTSET_TEST_ALL'
  FROM Districts;
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
SELECT 'NW_DISTRICT_IS_NEXT_RIVER_' || DistrictType, 'NW_DISTRICT_IS_' || DistrictType || '_REQUIREMENT'
  FROM Districts
 UNION
SELECT 'NW_DISTRICT_IS_NEXT_RIVER_' || DistrictType, 'NW_DTMS_REQ_PLOTS_NEXT_RIVER'
  FROM Districts;


-- =============================================================
-- OTTOMAN	奥斯曼

--奥斯曼
UPDATE BuildingReplaces
   SET ReplacesBuildingType='BUILDING_MARKET'
 WHERE CivUniqueBuildingType = 'BUILDING_GRAND_BAZAAR';
UPDATE Buildings
   SET Cost='60', PrereqTech='TECH_CURRENCY'
 WHERE BuildingType = 'BUILDING_GRAND_BAZAAR';
UPDATE Building_YieldChanges
   SET YieldChange='3'
 WHERE BuildingType = 'BUILDING_GRAND_BAZAAR';
DELETE
  FROM BuildingPrereqs
 WHERE Building = 'BUILDING_GRAND_BAZAAR';
INSERT INTO BuildingModifiers ( BuildingType, ModifierId )
VALUES ( 'BUILDING_GRAND_BAZAAR', 'MARKET_TRADE_ROUTE_CAPACITY' );
UPDATE ModifierArguments
   SET Value='4'
 WHERE ModifierId = 'HEAD_FALCONER_ADJUST_CITY_COMBAT_BONUS' AND Name = 'Amount';

--奥斯曼 提前送总督
UPDATE Modifiers
   SET SubjectRequirementSetId='NW_PLAYER_HAS_CIVIC_POLITICAL_PHILOSOPHY'
 WHERE ModifierId = 'SULEIMAN_GOVERNOR_POINTS';


--新奥斯曼 苏莱曼大帝
UPDATE ModifierArguments
   SET Value='2'
 WHERE ModifierId = 'SULEIMAN_COMBAT_BUFF' AND Name = 'Amount';
--黄金时代 瓶文加成
UPDATE ModifierArguments
   SET Value='7,7'
 WHERE ModifierId = 'TRAIT_SULEIMAN_ALT_SCIENCE_CULTURE_GOLDEN_AGE' AND Name = 'Amount';

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_SULEIMAN_ALT', 'MODIFIER_TRAIT_LEADER_SULEIMAN_ALT_GS' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_SULEIMAN_ALT_GS', 'MODIFIER_GOVERNMENT_ADJUST_SLOTS', 0, 0, 0, NULL, 'PLAYER_NO_GOLDEN_AGE_REQUIREMENTS' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_SULEIMAN_ALT_GS', 'Amount', '1' ),
       ( 'MODIFIER_TRAIT_LEADER_SULEIMAN_ALT_GS', 'GovernmentSlotType', 'SLOT_WILDCARD' );


-- =============================================================
-- PERSIA	波斯

UPDATE Modifiers
   SET SubjectRequirementSetId='NW_PLAYER_HAS_TECH_CURRENCY'
 WHERE ModifierId = 'TRAIT_SATRAPIES_POLITICAL_PHILOSOPHY_TRADE_ROUTE';


--波斯uu不再消耗铁,产能变60锤,移动+1,依旧是25/30力
UPDATE Units
   SET Cost=85, Combat=34, RangedCombat=26
 WHERE UnitType = 'UNIT_PERSIAN_IMMORTAL';
UPDATE Units_XP2
   SET ResourceCost=20
 WHERE UnitType = 'UNIT_PERSIAN_IMMORTAL';

-- 宣战+1商路
INSERT INTO TraitModifiers( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_FALL_BABYLON', 'TRAIT_SATRAPIES_POLITICAL_PHILOSOPHY_TRADE_ROUTE3' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'TRAIT_SATRAPIES_POLITICAL_PHILOSOPHY_TRADE_ROUTE3', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY', 'OWNER_OR_ALLY_IS_AT_WAR_REQUIREMENTS' );
INSERT INTO ModifierArguments( ModifierId, Name, Value )
VALUES ( 'TRAIT_SATRAPIES_POLITICAL_PHILOSOPHY_TRADE_ROUTE3', 'Amount', '1' );

--Improvement
UPDATE Improvement_YieldChanges
   SET YieldChange='1'
 WHERE ImprovementType = 'IMPROVEMENT_PAIRIDAEZA' AND YieldType = 'YIELD_GOLD';
INSERT INTO Improvement_YieldChanges ( ImprovementType, YieldType, YieldChange )
VALUES ( 'IMPROVEMENT_PAIRIDAEZA', 'YIELD_PRODUCTION', '0' );
INSERT INTO Improvement_BonusYieldChanges( Id, ImprovementType, YieldType, BonusYieldChange, PrereqCivic )
VALUES ( 'Courtyard_Gold_Coin', 'IMPROVEMENT_PAIRIDAEZA', 'YIELD_GOLD', '2', 'CIVIC_CIVIL_SERVICE' );


--新波斯 纳迪尔沙阿
--修复BUG
INSERT OR IGNORE INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'CITY_WAS_NOT_FOUNDED_BY_THEM_REQUIREMENTS', 'REQUIRES_CITY_WAS_NOT_FOUNDED_WARLORDS' );
--打满血+5-》+3
UPDATE ModifierArguments
   SET Value='3'
 WHERE ModifierId = 'NADER_SHAH_COMBAT_BUFF' AND Name = 'Amount';

UPDATE Modifiers
   SET SubjectRequirementSetId = 'NW_PLAYER_HAS_CIVIC_FEUDALISM'
 WHERE ModifierId = 'NADER_SHAH_TRADE_GOLD';
UPDATE Modifiers
   SET SubjectRequirementSetId = 'NW_PLAYER_HAS_CIVIC_FEUDALISM'
 WHERE ModifierId = 'NADER_SHAH_TRADE_FAITH';


-- =============================================================
-- PHOENICIA	腓尼基

-- 移民，海军速度20%
UPDATE ModifierArguments
   SET Value='20'
 WHERE ModifierId = 'COTHON_SETTLER_PRODUCTION' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='20'
 WHERE ModifierId = 'COTHON_NAVAL_UNIT_PRODUCTION' AND Name = 'Amount';

UPDATE Projects
   SET UnlocksFromEffect = 1
 WHERE ProjectType = 'PROJECT_COTHON_CAPITAL_MOVE';

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_FOUNDER_CARTHAGE', 'MODIFIER_TRAIT_LEADER_FOUNDER_CARTHAGE_POST' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_FOUNDER_CARTHAGE_POST', 'MODIFIER_PLAYER_CITIES_GRANT_TRADING_POST', 0, 0, 0, NULL, 'PLOT_IS_COASTAL_LAND_REQUIREMENTS' );

UPDATE ModifierArguments
   SET Value='1'
 WHERE ModifierId = 'MEDITERRANEAN_COLONIES_EXTRA_MOVEMENT' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='1'
 WHERE ModifierId = 'MEDITERRANEAN_COLONIES_EXTRA_SIGHT' AND Name = 'Amount';

-- =============================================================
-- POLAND	波兰

--波兰 UD减价
UPDATE Buildings
   SET Cost=80
 WHERE BuildingType = 'BUILDING_SUKIENNICE';
--纺织工坊
UPDATE Building_YieldChanges
   SET YieldChange = 5
 WHERE BuildingType = 'BUILDING_SUKIENNICE';

DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_LITHUANIAN_UNION' AND ModifierId = 'TRAIT_LITHUANIANUNION_FAITH_RELIC';
UPDATE ModifierArguments
   SET Value='3'
 WHERE ModifierId = 'TRAIT_LITHUANIANUNION_CULTURE_RELIC' AND Name = 'YieldChange';
UPDATE Units
   SET Combat=64, PrereqCivic='CIVIC_HUMANISM'
 WHERE UnitType = 'UNIT_POLISH_HUSSAR';

-- 波兰的创立或者完善一个宗教时获得遗物
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_LITHUANIAN_UNION', 'TRAIT_LITHUANIANUNION_FOUND_RELIGION_RELIC_CPLMOD' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId, RunOnce, Permanent )
VALUES ( 'TRAIT_LITHUANIANUNION_FOUND_RELIGION_RELIC_CPLMOD', 'MODIFIER_PLAYER_GRANT_RELIC', 'PLAYER_FOUNDED_RELIGION_RELIC_CPLMOD', 1, 1 );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_LITHUANIANUNION_FOUND_RELIGION_RELIC_CPLMOD', 'Amount', '1' );
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'PLAYER_FOUNDED_RELIGION_RELIC_CPLMOD', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'PLAYER_FOUNDED_RELIGION_RELIC_CPLMOD', 'REQUIRES_PLAYER_HAS_FOUNDED_A_RELIGION' );

-- 完善一个宗教时获得遗物
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_LITHUANIAN_UNION', 'TRAIT_LITHUANIANUNION_COMPLETE_RELIGION_RELIC_CPLMOD' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId, RunOnce, Permanent )
VALUES ( 'TRAIT_LITHUANIANUNION_COMPLETE_RELIGION_RELIC_CPLMOD', 'MODIFIER_PLAYER_GRANT_RELIC', 'REQUIRES_PLAYER_COMPLETED_RELIGION_RELIC_CPLMOD', 1, 1 );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_LITHUANIANUNION_COMPLETE_RELIGION_RELIC_CPLMOD', 'Amount', '1' );
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'REQUIRES_PLAYER_COMPLETED_RELIGION_RELIC_CPLMOD', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'REQUIRES_PLAYER_COMPLETED_RELIGION_RELIC_CPLMOD', 'RELIGION_HAS_FOUNDER_BELIEF_CPLMOD' ),
       ( 'REQUIRES_PLAYER_COMPLETED_RELIGION_RELIC_CPLMOD', 'RELIGION_HAS_WORSHIP_BELIEF_CPLMOD' ),
       ( 'REQUIRES_PLAYER_COMPLETED_RELIGION_RELIC_CPLMOD', 'RELIGION_HAS_ENHANCER_BELIEF_CPLMOD' );
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'RELIGION_HAS_FOUNDER_BELIEF_CPLMOD', 'REQUIREMENT_REQUIREMENTSET_IS_MET' ),
       ( 'RELIGION_HAS_WORSHIP_BELIEF_CPLMOD', 'REQUIREMENT_REQUIREMENTSET_IS_MET' ),
       ( 'RELIGION_HAS_ENHANCER_BELIEF_CPLMOD', 'REQUIREMENT_REQUIREMENTSET_IS_MET' );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'RELIGION_HAS_FOUNDER_BELIEF_CPLMOD', 'RequirementSetId', 'NW_RELIGION_HAS_BELIEF_CLASS_FOUNDER' ),
       ( 'RELIGION_HAS_WORSHIP_BELIEF_CPLMOD', 'RequirementSetId', 'NW_RELIGION_HAS_BELIEF_CLASS_WORSHIP' ),
       ( 'RELIGION_HAS_ENHANCER_BELIEF_CPLMOD', 'RequirementSetId', 'NW_RELIGION_HAS_BELIEF_CLASS_ENHANCER' );


-- =============================================================
-- PORTUGAL	葡萄牙

UPDATE ModifierArguments
   SET Value='3'
 WHERE ModifierId = 'TRADE_GOLD_FROM_FEITORIA' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='0'
 WHERE ModifierId = 'TRAIT_JOAO_TRADE_ROUTE_ON_MEET' AND Name = 'Amount';
INSERT INTO Modifiers ( ModifierId, ModifierType )
VALUES ( 'TRAIT_JOAO_TRADE_ROUTE_ON_MEET_PUTAOYA', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY' );
INSERT INTO ModifierArguments( ModifierId, Name, Value )
VALUES ( 'TRAIT_JOAO_TRADE_ROUTE_ON_MEET_PUTAOYA', 'Amount', '2' );
INSERT INTO TraitModifiers( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_JOAO_III', 'TRAIT_JOAO_TRADE_ROUTE_ON_MEET_PUTAOYA' );


INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_JOAO_III', 'MODIFIER_TRAIT_LEADER_JOAO_III_TRADER_PRODUCTION' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_JOAO_III_TRADER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_PRODUCTION', 0, 0, 0, NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_JOAO_III_TRADER_PRODUCTION', 'Amount', '50' ),
       ( 'MODIFIER_TRAIT_LEADER_JOAO_III_TRADER_PRODUCTION', 'UnitType', 'UNIT_TRADER' );


-- =============================================================
-- ROME	罗马

UPDATE Units
   SET Combat=38, Cost=100
 WHERE UnitType = 'UNIT_ROMAN_LEGION';
UPDATE Districts
   SET PrereqTech = NULL, PrereqCivic = 'CIVIC_GAMES_RECREATION'
 WHERE DistrictType = 'DISTRICT_BATH';
UPDATE District_BuildChargeProductions
   SET PercentProductionPerCharge = 45
 WHERE DistrictType = 'DISTRICT_BATH';

UPDATE Modifiers
   SET OwnerRequirementSetId='NW_PLAYER_HAS_CIVIC_FOREIGN_TRADE'
 WHERE ModifierId = 'TRAIT_ADJUST_NON_CAPITAL_FREE_CHEAPEST_BUILDING';
-- 凯撒
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_CAESAR' AND ModifierId IN ('TRAIT_CAESAR_NO_XP_LIMIT',
                                                            'TRAIT_CAESAR_BARB_COMBAT',
                                                            'TRAIT_CAESAR_GOLD_CAPTURED_CITY_METAL_CASTING',
                                                            'TRAIT_CAESAR_GOLD_CAPTURED_CITY_STEEL',
                                                            'BARBARIAN_CAMP_GOLD_CAPTURED_CITY',
                                                            'BARBARIAN_CAMP_GOLD_CAPTURED_CITY_METAL_CASTING',
                                                            'BARBARIAN_CAMP_GOLD_CAPTURED_CITY_STEEL'
     );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_CAESAR', 'MODIFIER_TRAIT_LEADER_CAESAR_FREE_MELEE' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_CAESAR_FREE_MELEE', 'MODIFIER_PLAYER_CITIES_GRANT_UNIT_BY_CLASS', 0, 1, 0, NULL, 'NW_PLAYER_HAS_CIVIC_CODE_OF_LAWS' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_CAESAR_FREE_MELEE', 'UnitPromotionClassType', 'PROMOTION_CLASS_MELEE' );

UPDATE ModifierArguments
   SET Value = 300
 WHERE ModifierId = 'TRAIT_CAESAR_GOLD_CAPTURED_CITY_MODIFIER' AND Name = 'Amount';


-- =============================================================
-- RUSSIA	俄罗斯

--俄罗斯 冻土信仰需要圣地
UPDATE Modifiers
   SET SubjectRequirementSetId='REQUIRES_RUSSIA_HAS_HOLY_SITE_TUNDRA'
 WHERE ModifierId = 'TRAIT_INCREASED_TUNDRA_FAITH';
UPDATE Modifiers
   SET SubjectRequirementSetId='REQUIRES_RUSSIA_HAS_HOLY_SITE_TUNDRA_HILLS'
 WHERE ModifierId = 'TRAIT_INCREASED_TUNDRA_HILLS_FAITH';

INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'PLAYER_HAS_WANGQUAN_ELUOSI', 'REQUIREMENT_PLAYER_HAS_CIVIC' );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'PLAYER_HAS_WANGQUAN_ELUOSI', 'CivicType', 'CIVIC_REFORMED_CHURCH' );

INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'REQUIRES_RUSSIA_HAS_HOLY_SITE_TUNDRA', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'REQUIRES_RUSSIA_HAS_HOLY_SITE_TUNDRA', 'REQUIRES_CITY_HAS_HOLY_SITE' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'REQUIRES_RUSSIA_HAS_HOLY_SITE_TUNDRA', 'REQUIRES_PLOT_HAS_TUNDRA' );

INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'REQUIRES_RUSSIA_HAS_HOLY_SITE_TUNDRA_HILLS', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'REQUIRES_RUSSIA_HAS_HOLY_SITE_TUNDRA_HILLS', 'REQUIRES_CITY_HAS_HOLY_SITE' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'REQUIRES_RUSSIA_HAS_HOLY_SITE_TUNDRA_HILLS', 'PLAYER_HAS_WANGQUAN_ELUOSI' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'REQUIRES_RUSSIA_HAS_HOLY_SITE_TUNDRA_HILLS', 'REQUIRES_PLOT_HAS_TUNDRA_HILLS' );


--俄罗斯
UPDATE ModifierArguments
   SET Value='5'
 WHERE ModifierId = 'TRAIT_INCREASED_TILES' AND Name = 'Amount';
UPDATE District_GreatPersonPoints
   SET PointsPerTurn=1
 WHERE DistrictType = 'DISTRICT_LAVRA' AND GreatPersonClassType = 'GREAT_PERSON_CLASS_PROPHET';
UPDATE ModifierArguments
   SET Value='0'
 WHERE ModifierId = 'TRAIT_SHRINE_WRITING_POINTS' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='0'
 WHERE ModifierId = 'TRAIT_TEMPLE_ARTIST_POINTS' AND Name = 'Amount';
UPDATE Units
   SET Combat=62, Cost=340, BaseMoves=5
 WHERE UnitType = 'UNIT_RUSSIAN_COSSACK';
UPDATE ModifierArguments
   SET Value='2'
 WHERE ModifierId = 'COSSACK_LOCAL_COMBAT' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='0'
 WHERE ModifierId = 'TRAIT_INCREASED_TUNDRA_HILLS_FAITH' AND Name = 'Amount';



-- =============================================================
-- SCOTLAND	苏格兰

CREATE TABLE NW_SUGELAN_AMENITIES
    (
        PopulationThreshold INTEGER
            PRIMARY KEY,
        AmenityCorrection INTEGER NOT NULL
    );

-- 插入修正值数据（1-30人口）
  WITH RECURSIVE seq(k) AS (SELECT 1 UNION ALL SELECT k + 1 FROM seq WHERE k < 30),
                 total_corrections AS (SELECT k, (k + 1) / 2 - (k + 2) / 3 AS total_correction FROM seq),
                 corrections_with_prev
                     AS (SELECT a.k, a.total_correction, COALESCE(b.total_correction, 0) AS prev_total_correction
                           FROM total_corrections a
                                    LEFT JOIN total_corrections b
                                    ON a.k = b.k + 1)
INSERT
  INTO NW_SUGELAN_AMENITIES ( PopulationThreshold, AmenityCorrection )
SELECT k, total_correction - prev_total_correction AS amenity_correction
  FROM corrections_with_prev
 WHERE amenity_correction != 0;


INSERT INTO TraitModifiers ( TraitType, ModifierId )
SELECT 'TRAIT_CIVILIZATION_SCOTTISH_ENLIGHTENMENT',
       'TRAIT_CIVILIZATION_SCOTTISH_ENLIGHTENMENT_AMEN_' || PopulationThreshold
  FROM NW_SUGELAN_AMENITIES;
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
SELECT 'TRAIT_CIVILIZATION_SCOTTISH_ENLIGHTENMENT_AMEN_' || PopulationThreshold,
       'MODIFIER_PLAYER_CITIES_ADJUST_TRAIT_AMENITY', 'REQS_NW_CITY_HAS_' || PopulationThreshold || '_POPULATION'
  FROM NW_SUGELAN_AMENITIES;
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
SELECT 'TRAIT_CIVILIZATION_SCOTTISH_ENLIGHTENMENT_AMEN_' || PopulationThreshold, 'Amount', AmenityCorrection
  FROM NW_SUGELAN_AMENITIES;

-- RequirementSets
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
SELECT 'REQS_NW_CITY_HAS_' || PopulationThreshold || '_POPULATION', 'REQUIREMENTSET_TEST_ALL'
  FROM NW_SUGELAN_AMENITIES;
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
SELECT 'REQS_NW_CITY_HAS_' || PopulationThreshold || '_POPULATION',
       'REQ_NW_CITY_HAS_' || PopulationThreshold || '_POPULATION'
  FROM NW_SUGELAN_AMENITIES;
-- Requirements
INSERT INTO Requirements ( RequirementId, RequirementType )
SELECT 'REQ_NW_CITY_HAS_' || PopulationThreshold || '_POPULATION', 'REQUIREMENT_CITY_HAS_X_POPULATION'
  FROM NW_SUGELAN_AMENITIES;
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
SELECT 'REQ_NW_CITY_HAS_' || PopulationThreshold || '_POPULATION', 'Amount', PopulationThreshold
  FROM NW_SUGELAN_AMENITIES;

DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_SCOTTISH_ENLIGHTENMENT' AND
     ModifierId IN ('TRAIT_BOOST_AQUEDUCT_PRODUCTION_CPLMOD_SUGELAN',
                    'TRAIT_SCIENTIST_HAPPY',
                    'TRAIT_SCIENTIST_ECSTATIC',
                    'TRAIT_ENGINEER_HAPPY',
                    'TRAIT_ENGINEER_ECSTATIC');

UPDATE ModifierArguments
   SET Value = 3
 WHERE ModifierId = 'TRAIT_SCIENCE_HAPPY' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value = 3
 WHERE ModifierId = 'TRAIT_PRODUCTION_HAPPY' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value = 6
 WHERE ModifierId = 'TRAIT_SCIENCE_ECSTATIC' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value = 6
 WHERE ModifierId = 'TRAIT_PRODUCTION_ECSTATIC' AND Name = 'Amount';

-- 高尔夫球场
UPDATE Improvement_YieldChanges
   SET YieldChange = 3
 WHERE YieldType = 'YIELD_GOLD' AND ImprovementType = 'IMPROVEMENT_GOLF_COURSE';
DELETE
  FROM ImprovementModifiers
 WHERE ImprovementType = 'IMPROVEMENT_GOLF_COURSE' AND ModifierID = 'GOLFCOURSE_AMENITIES';

-- 班诺克本
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_BANNOCKBURN' AND ModifierId IN ('TRAIT_LIBERATION_WAR_PRODUCTION',
                                                                 'TRAIT_LIBERATION_WAR_MOVEMENT',
                                                                 'TRAIT_LIBERATION_WAR_PREREQ_OVERRIDE');

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_BANNOCKBURN', 'MODIFIER_TRAIT_LEADER_BANNOCKBURN_COMBAT' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'MODIFIER_TRAIT_LEADER_BANNOCKBURN_COMBAT', 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH', 0, 0, 0, NULL, 'REQSET_NW_IN_CAPITAL_3PLOTS' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_TRAIT_LEADER_BANNOCKBURN_COMBAT', 'Amount', '2' );
INSERT INTO ModifierStrings ( ModifierId, Context, Text )
VALUES ( 'MODIFIER_TRAIT_LEADER_BANNOCKBURN_COMBAT', 'Preview', '{LOC_MODIFIER_TRAIT_LEADER_BANNOCKBURN_COMBAT}' );

-- RequirementSets
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
VALUES ( 'REQSET_NW_IN_CAPITAL_3PLOTS', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
VALUES ( 'REQSET_NW_IN_CAPITAL_3PLOTS', 'REQ_NW_IN_CAPITAL_3PLOTS' );
-- Requirements
INSERT INTO Requirements ( RequirementId, RequirementType )
VALUES ( 'REQ_NW_IN_CAPITAL_3PLOTS', 'REQUIREMENT_PLOT_ADJACENT_BUILDING_TYPE_MATCHES' );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
VALUES ( 'REQ_NW_IN_CAPITAL_3PLOTS', 'BuildingType', 'BUILDING_PALACE' ),
       ( 'REQ_NW_IN_CAPITAL_3PLOTS', 'MaxRange', '3' ),
       ( 'REQ_NW_IN_CAPITAL_3PLOTS', 'MinRange', '0' );



-- =============================================================
-- SCYTHIA	斯基泰

--斯基泰
INSERT INTO Modifiers( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'SHIPHERDER_PATH_PASTURE_GOLD_MODIFIER2_SIJITAI', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'PLOT_HAS_PASTURE_REQUIREMENTS' );
INSERT INTO ModifierArguments( ModifierId, Name, Value )
VALUES ( 'SHIPHERDER_PATH_PASTURE_GOLD_MODIFIER2_SIJITAI', 'YieldType', 'YIELD_FAITH' );
INSERT INTO ModifierArguments( ModifierId, Name, Value )
VALUES ( 'SHIPHERDER_PATH_PASTURE_GOLD_MODIFIER2_SIJITAI', 'Amount', '1' );
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY', 'SHIPHERDER_PATH_PASTURE_GOLD_MODIFIER2_SIJITAI' );

INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId )
VALUES ( 'alabo_hasxueyuan_shengdi_SIJITAI', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE', 'DISTRICT_IS_ENCAMPMENT' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'alabo_hasxueyuan_shengdi_SIJITAI', 'Amount', '0' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'alabo_hasxueyuan_shengdi_SIJITAI', 'YieldType', 'YIELD_FAITH' );
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY', 'alabo_hasxueyuan_shengdi_SIJITAI' );

--斯基泰 弓骑手 移动后可攻击
INSERT INTO Tags( Tag, Vocabulary )
VALUES ( 'CLASS_SCYTHIAN_HORSE_ARCHER', 'ABILITY_CLASS' );
INSERT INTO TypeTags( Type, Tag )
VALUES ( 'UNIT_SCYTHIAN_HORSE_ARCHER', 'CLASS_SCYTHIAN_HORSE_ARCHER' );
INSERT INTO TypeTags( Type, Tag )
VALUES ( 'ABILITY_VOI_CHIEN', 'CLASS_SCYTHIAN_HORSE_ARCHER' );

--斯基泰 购买轻骑兵打折
INSERT INTO TraitModifiers( TraitType, ModifierId )
SELECT 'TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY', 'MODIFEAT_TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY_DISCOUNT_' || UnitType
  FROM Units
 WHERE PromotionClass = 'PROMOTION_CLASS_LIGHT_CAVALRY' OR UnitType = 'UNIT_SCYTHIAN_HORSE_ARCHER';
INSERT INTO Modifiers ( ModifierId, ModifierType )
SELECT 'MODIFEAT_TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY_DISCOUNT_' || UnitType,
       'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_PURCHASE_COST'
  FROM Units
 WHERE PromotionClass = 'PROMOTION_CLASS_LIGHT_CAVALRY' OR UnitType = 'UNIT_SCYTHIAN_HORSE_ARCHER';
INSERT INTO ModifierArguments( ModifierId, Name, Value )
SELECT 'MODIFEAT_TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY_DISCOUNT_' || UnitType, 'UnitType', UnitType
  FROM Units
 WHERE PromotionClass = 'PROMOTION_CLASS_LIGHT_CAVALRY' OR UnitType = 'UNIT_SCYTHIAN_HORSE_ARCHER'
 UNION
SELECT 'MODIFEAT_TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY_DISCOUNT_' || UnitType, 'Amount', '15'
  FROM Units
 WHERE PromotionClass = 'PROMOTION_CLASS_LIGHT_CAVALRY' OR UnitType = 'UNIT_SCYTHIAN_HORSE_ARCHER';


-- =============================================================
-- SPAIN	西班牙

DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_TREASURE_FLEET' AND ModifierId IN ('TRAIT_DOMESTIC_FAITH',
                                                                          'TRAIT_DOMESTIC_GOLD',
                                                                          'TRAIT_DOMESTIC_PRODUCTION',
                                                                          'TRAIT_INTERNATIONAL_FAITH',
                                                                          'TRAIT_INTERNATIONAL_GOLD',
                                                                          'TRAIT_INTERNATIONAL_PRODUCTION',
                                                                          'TRAIT_INTERCONTINENTAL_DISTRICT_PRODUCTION'
     );

UPDATE ModifierArguments
   SET Value = 1
 WHERE ModifierId = 'TRAIT_INTERCONTINENTAL_INTERNATIONAL_PRODUCTION' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value = 3
 WHERE ModifierId = 'TRAIT_INTERCONTINENTAL_INTERNATIONAL_FAITH' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value = 5
 WHERE ModifierId = 'TRAIT_INTERCONTINENTAL_INTERNATIONAL_GOLD' AND Name = 'Amount';

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_TREASURE_FLEET', 'TRAIT_CIVILIZATION_TREASURE_FLEET_BUY_TR' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'TRAIT_CIVILIZATION_TREASURE_FLEET_BUY_TR', 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE', 0, 0, 0, NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_CIVILIZATION_TREASURE_FLEET_BUY_TR', 'Tag', 'CLASS_TRADER' );


--西班牙 无敌舰队
UPDATE ModifierArguments
   SET Value='CIVIC_HUMANISM'
 WHERE ModifierId = 'TRAIT_NAVAL_CORPS_EARLY' AND Name = 'CivicType';
--西班牙 对宗教下调+3
UPDATE ModifierArguments
   SET Value='3'
 WHERE ModifierId = 'PHILIP_II_COMBAT_BONUS_OTHER_RELIGION' AND Name = 'Amount';



-- =============================================================
-- SUMERIA	苏美尔
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_LEADER_ADVENTURES_ENKIDU' AND ModifierId IN ('TRAIT_ADJUST_ALLIED_WAR_DISCOUNT',
                                                                       'TRAIT_ADJUST_JOINTWAR_EXPERIENCE',
                                                                       'TRAIT_ALLIANCE_POINTS_FROM_COMMON_FOE',
                                                                       'TRAIT_ATTACH_ALLIANCE_COMBAT_ADJUSTMENT'
     );

-- 同盟+力
UPDATE ModifierArguments
   SET Value='0'
 WHERE ModifierId = 'TRAIT_ADJUST_ALLIANCE_ADJUST_COMBAT_STRENGTH' AND Name = 'Amount';

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_LEADER_ADVENTURES_ENKIDU', 'TRAIT_LEADER_ADVENTURES_ENKIDU_COMBAT_FORM_ALLY' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'TRAIT_LEADER_ADVENTURES_ENKIDU_COMBAT_FORM_ALLY', 'MODIFIER_NW_DTMS_PLAYER_UNITS_ADJUST_COMBAT_FOR_NUMBER_ALLIES', 0, 0, 0, NULL, 'UNIT_STRONG_WHEN_ATTACKING_REQUIREMENTS' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_LEADER_ADVENTURES_ENKIDU_COMBAT_FORM_ALLY', 'Amount', '1' );
INSERT INTO ModifierStrings ( ModifierId, Context, Text )
VALUES ( 'TRAIT_LEADER_ADVENTURES_ENKIDU_COMBAT_FORM_ALLY', 'Preview', 'LOC_MODIFIER_TRAIT_LEADER_BANNOCKBURN_COMBAT' );

-- Custom ModifierType
INSERT INTO Types ( Type, Kind )
VALUES ( 'MODIFIER_NW_DTMS_PLAYER_UNITS_ADJUST_COMBAT_FOR_NUMBER_ALLIES', 'KIND_MODIFIER' );
INSERT INTO DynamicModifiers ( ModifierType, CollectionType, EffectType )
VALUES ( 'MODIFIER_NW_DTMS_PLAYER_UNITS_ADJUST_COMBAT_FOR_NUMBER_ALLIES', 'COLLECTION_PLAYER_UNITS', 'EFFECT_ADJUST_NUMBER_ALLIES_UNIT_COMBAT_BONUS' );

-- 当您占领一个蛮族哨站时，您会获得部落村庄奖励，以及 [ICON_Gold] 金币，初始便获得30 [ICON_Gold] 金币。征用城邦单位费用降低一半。初始便获得1个 [ICON_ENVOY] 使者，每回合获得1点影响力。
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_FIRST_CIVILIZATION' AND ModifierId = 'TRAIT_LEVY_DISCOUNT';

-- =============================================================
-- SWEDEN	瑞典
-- 北方的弥涅耳瓦
UPDATE ModifierArguments
   SET Value = 1
 WHERE Name = 'Amount' AND ModifierId = 'AUTO_THEME_AT_LEAST_3_SLOTS';
UPDATE ModifierArguments
   SET Value = 1
 WHERE Name = 'Amount' AND ModifierId = 'AUTO_THEME_AT_LEAST_2_SLOTS';

-- TRAIT_CIVILIZATION_NOBEL_PRIZE
-- 删除：伟人点
DELETE
  FROM TraitModifiers
 WHERE TraitType = 'TRAIT_CIVILIZATION_NOBEL_PRIZE' AND
     ModifierId IN ('TRAIT_GREAT_SCIENTIST_UNIVERSITY_MODIFIER', 'TRAIT_GREAT_ENGINEER_FACTORY_MODIFIER');

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_NOBEL_PRIZE', 'TRAIT_CIVILIZATION_NOBEL_PRIZE_GPP_ENGINEER' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'TRAIT_CIVILIZATION_NOBEL_PRIZE_GPP_ENGINEER', 'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS_PERCENT', 0, 0, 0, NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_CIVILIZATION_NOBEL_PRIZE_GPP_ENGINEER', 'Amount', '50' ),
       ( 'TRAIT_CIVILIZATION_NOBEL_PRIZE_GPP_ENGINEER', 'GreatPersonClassType', 'GREAT_PERSON_CLASS_ENGINEER' );

INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_NOBEL_PRIZE', 'TRAIT_CIVILIZATION_NOBEL_PRIZE_GPP_SCIENTIST' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId )
VALUES ( 'TRAIT_CIVILIZATION_NOBEL_PRIZE_GPP_SCIENTIST', 'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS_PERCENT', 0, 0, 0, NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_CIVILIZATION_NOBEL_PRIZE_GPP_SCIENTIST', 'Amount', '50' ),
       ( 'TRAIT_CIVILIZATION_NOBEL_PRIZE_GPP_SCIENTIST', 'GreatPersonClassType', 'GREAT_PERSON_CLASS_SCIENTIST' );


--瑞典
--学院区加速
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_NOBEL_PRIZE', 'THEATER_BUILDING_PRODUCTION_BONUS_MEDIQI_DISTRICT_CAMPUS' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId, OwnerRequirementSetId )
VALUES ( 'THEATER_BUILDING_PRODUCTION_BONUS_MEDIQI_DISTRICT_CAMPUS', 'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION', NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'THEATER_BUILDING_PRODUCTION_BONUS_MEDIQI_DISTRICT_CAMPUS', 'DistrictType', 'DISTRICT_CAMPUS' ),
       ( 'THEATER_BUILDING_PRODUCTION_BONUS_MEDIQI_DISTRICT_CAMPUS', 'Amount', '35' );
--学院区建筑加速
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_NOBEL_PRIZE', 'THEATER_BUILDING_PRODUCTION_BONUS_MEDIQI_DISTRICT_CAMPUS_BUILDING' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId, OwnerRequirementSetId )
VALUES ( 'THEATER_BUILDING_PRODUCTION_BONUS_MEDIQI_DISTRICT_CAMPUS_BUILDING', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION', NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'THEATER_BUILDING_PRODUCTION_BONUS_MEDIQI_DISTRICT_CAMPUS_BUILDING', 'DistrictType', 'DISTRICT_CAMPUS' ),
       ( 'THEATER_BUILDING_PRODUCTION_BONUS_MEDIQI_DISTRICT_CAMPUS_BUILDING', 'Amount', '35' );
--工业区加速
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_NOBEL_PRIZE', 'THEATER_BUILDING_PRODUCTION_BONUS_MEDIQI_DISTRICT_INDUSTRIAL_ZONE' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId, OwnerRequirementSetId )
VALUES ( 'THEATER_BUILDING_PRODUCTION_BONUS_MEDIQI_DISTRICT_INDUSTRIAL_ZONE', 'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION', NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'THEATER_BUILDING_PRODUCTION_BONUS_MEDIQI_DISTRICT_INDUSTRIAL_ZONE', 'DistrictType', 'DISTRICT_INDUSTRIAL_ZONE' ),
       ( 'THEATER_BUILDING_PRODUCTION_BONUS_MEDIQI_DISTRICT_INDUSTRIAL_ZONE', 'Amount', '35' );
--工业区建筑加速
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_NOBEL_PRIZE', 'THEATER_BUILDING_PRODUCTION_BONUS_MEDIQI_DISTRICT_INDUSTRIAL_ZONE_BUILDING' );
INSERT INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId, OwnerRequirementSetId )
VALUES ( 'THEATER_BUILDING_PRODUCTION_BONUS_MEDIQI_DISTRICT_INDUSTRIAL_ZONE_BUILDING', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION', NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'THEATER_BUILDING_PRODUCTION_BONUS_MEDIQI_DISTRICT_INDUSTRIAL_ZONE_BUILDING', 'DistrictType', 'DISTRICT_INDUSTRIAL_ZONE' ),
       ( 'THEATER_BUILDING_PRODUCTION_BONUS_MEDIQI_DISTRICT_INDUSTRIAL_ZONE_BUILDING', 'Amount', '35' );

-- 女王图书馆
-- 该建筑可以放置2个 [ICON_GreatWork_WRITING] 著作、3个 [ICON_GreatWork_Landscape] 艺术巨作。
DELETE
  FROM Building_GreatWorks
 WHERE BuildingType = 'BUILDING_QUEENS_BIBLIOTHEQUE';
INSERT INTO Building_GreatWorks( BuildingType, GreatWorkSlotType, NumSlots )
VALUES ( 'BUILDING_QUEENS_BIBLIOTHEQUE', 'GREATWORKSLOT_WRITING', 2 ),
       ( 'BUILDING_QUEENS_BIBLIOTHEQUE', 'GREATWORKSLOT_ART', 3 );

-- =============================================================
-- VIETNAM	越南

INSERT INTO District_GreatPersonPoints ( DistrictType, GreatPersonClassType, PointsPerTurn )
VALUES ( 'DISTRICT_THANH', 'GREAT_PERSON_CLASS_GENERAL', '1' );

UPDATE ModifierArguments
   SET Value=0
 WHERE ModifierId = 'TRIEU_FRIENDLY_MOVEMENT' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value=0
 WHERE ModifierId = 'TRIEU_UNFRIENDLY_MOVEMENT' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='2'
 WHERE ModifierId = 'TRIEU_FRIENDLY_COMBAT' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='2'
 WHERE ModifierId = 'TRIEU_UNFRIENDLY_COMBAT' AND Name = 'Amount';

INSERT INTO UnitAbilityModifiers ( UnitAbilityType, ModifierId )
VALUES ( 'ABILITY_TRIEU_FEATURES', 'MODIFIER_ABILITY_TRIEU_FEATURE_FOREST_IGNORE' );
INSERT INTO Modifiers ( ModifierId, ModifierType )
VALUES ( 'MODIFIER_ABILITY_TRIEU_FEATURE_FOREST_IGNORE', 'MODIFIER_PLAYER_UNIT_ADJUST_IGNORE_TERRAIN_COST' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_ABILITY_TRIEU_FEATURE_FOREST_IGNORE', 'Ignore', '1' ),
       ( 'MODIFIER_ABILITY_TRIEU_FEATURE_FOREST_IGNORE', 'Type', 'FOREST' );
INSERT INTO UnitAbilityModifiers ( UnitAbilityType, ModifierId )
VALUES ( 'ABILITY_TRIEU_FEATURES', 'MODIFIER_ABILITY_TRIEU_FEATURE_JUNGLE_IGNORE' );
INSERT INTO Modifiers ( ModifierId, ModifierType )
VALUES ( 'MODIFIER_ABILITY_TRIEU_FEATURE_JUNGLE_IGNORE', 'MODIFIER_PLAYER_UNIT_ADJUST_IGNORE_TERRAIN_COST' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_ABILITY_TRIEU_FEATURE_JUNGLE_IGNORE', 'Ignore', '1' ),
       ( 'MODIFIER_ABILITY_TRIEU_FEATURE_JUNGLE_IGNORE', 'Type', 'JUNGLE' );
INSERT INTO UnitAbilityModifiers ( UnitAbilityType, ModifierId )
VALUES ( 'ABILITY_TRIEU_FEATURES', 'MODIFIER_ABILITY_TRIEU_FEATURE_MARSH_IGNORE' );
INSERT INTO Modifiers ( ModifierId, ModifierType )
VALUES ( 'MODIFIER_ABILITY_TRIEU_FEATURE_MARSH_IGNORE', 'MODIFIER_PLAYER_UNIT_ADJUST_IGNORE_TERRAIN_COST' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_ABILITY_TRIEU_FEATURE_MARSH_IGNORE', 'Ignore', '1' ),
       ( 'MODIFIER_ABILITY_TRIEU_FEATURE_MARSH_IGNORE', 'Type', 'MARSH' );

--区域
UPDATE ModifierArguments
   SET Value='1'
 WHERE ModifierId = 'TRAIT_FOREST_BUILDINGS_CULTURE' AND Name = 'Amount';
UPDATE ModifierArguments
   SET Value='YIELD_PRODUCTION'
 WHERE ModifierId = 'TRAIT_FOREST_BUILDINGS_CULTURE' AND Name = 'YieldType';
UPDATE ModifierArguments
   SET Value='YIELD_SCIENCE'
 WHERE ModifierId = 'TRAIT_JUNGLE_BUILDINGS_SCIENCE' AND Name = 'YieldType';
UPDATE ModifierArguments
   SET Value='YIELD_PRODUCTION'
 WHERE ModifierId = 'TRAIT_MARSH_BUILDINGS_PRODUCTION' AND Name = 'YieldType';

--沼泽1金
INSERT INTO TraitModifiers ( TraitType, ModifierId )
VALUES ( 'TRAIT_CIVILIZATION_VIETNAM', 'TRAIT_MARSH_BUILDINGS_PRODUCTION_yljb' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_MARSH_BUILDINGS_PRODUCTION_yljb', 'YieldType', 'YIELD_GOLD' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_MARSH_BUILDINGS_PRODUCTION_yljb', 'Amount', '1' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'TRAIT_MARSH_BUILDINGS_PRODUCTION_yljb', 'FeatureType', 'FEATURE_MARSH' );
INSERT INTO Modifiers ( ModifierId, ModifierType )
VALUES ( 'TRAIT_MARSH_BUILDINGS_PRODUCTION_yljb', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_FEATURE_YIELD_CHANGE' );

--城池
UPDATE Districts
   SET Maintenance = 0, Appeal = 0
 WHERE DistrictType = 'DISTRICT_THANH';
DELETE
  FROM District_Adjacencies
 WHERE DistrictType = 'DISTRICT_THANH' AND YieldChangeId = 'District_Culture_Major';

INSERT INTO DistrictModifiers ( DistrictType, ModifierId )
VALUES ( 'DISTRICT_THANH', 'DISTRICT_CHENGSHI_SCIENCE_YIELD' );
INSERT INTO Modifiers ( ModifierId, ModifierType )
VALUES ( 'DISTRICT_CHENGSHI_SCIENCE_YIELD', 'MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'DISTRICT_CHENGSHI_SCIENCE_YIELD', 'YieldType', 'YIELD_SCIENCE' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'DISTRICT_CHENGSHI_SCIENCE_YIELD', 'Amount', '1' );

INSERT INTO DistrictModifiers ( DistrictType, ModifierId )
VALUES ( 'DISTRICT_THANH', 'DISTRICT_CHENGSHI_PRO_YIELD' );
INSERT INTO Modifiers ( ModifierId, ModifierType )
VALUES ( 'DISTRICT_CHENGSHI_PRO_YIELD', 'MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'DISTRICT_CHENGSHI_PRO_YIELD', 'YieldType', 'YIELD_PRODUCTION' );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'DISTRICT_CHENGSHI_PRO_YIELD', 'Amount', '1' );

--UU
UPDATE Units
   SET BaseMoves='2', Combat='32', RangedCombat='42'
 WHERE UnitType = 'UNIT_VIETNAMESE_VOI_CHIEN';

-- =============================================================
-- ZULU	祖鲁
-- TRAIT_LEADER_AMABUTHO

INSERT INTO DistrictModifiers ( DistrictType, ModifierId )
VALUES ( 'DISTRICT_IKANDA', 'MODIFIER_DISTRICT_IKANDA_GRANT_UNIT_IN_CITY' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_DISTRICT_IKANDA_GRANT_UNIT_IN_CITY', 'MODIFIER_SINGLE_CITY_GRANT_UNIT_IN_CITY', 1, 1, 0, NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_DISTRICT_IKANDA_GRANT_UNIT_IN_CITY', 'AllowUniqueOverride', '0' ),
       ( 'MODIFIER_DISTRICT_IKANDA_GRANT_UNIT_IN_CITY', 'Amount', '1' ),
       ( 'MODIFIER_DISTRICT_IKANDA_GRANT_UNIT_IN_CITY', 'UnitType', 'UNIT_SPEARMAN' );


INSERT INTO DistrictModifiers ( DistrictType, ModifierId )
VALUES ( 'DISTRICT_IKANDA', 'MODIFIER_DISTRICT_IKANDA_BUILDING_BARRACKS_YIELD_CHANGE' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_DISTRICT_IKANDA_BUILDING_BARRACKS_YIELD_CHANGE', 'MODIFIER_BUILDING_YIELD_CHANGE', 0, 0, 0, NULL,
         NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_DISTRICT_IKANDA_BUILDING_BARRACKS_YIELD_CHANGE', 'Amount', '1' ),
       ( 'MODIFIER_DISTRICT_IKANDA_BUILDING_BARRACKS_YIELD_CHANGE', 'BuildingType', 'BUILDING_BARRACKS' ),
       ( 'MODIFIER_DISTRICT_IKANDA_BUILDING_BARRACKS_YIELD_CHANGE', 'YieldType', 'YIELD_CULTURE' );


INSERT INTO DistrictModifiers ( DistrictType, ModifierId )
VALUES ( 'DISTRICT_IKANDA', 'MODIFIER_DISTRICT_IKANDA_BUILDING_STABLE_YIELD_CHANGE' );
INSERT INTO Modifiers ( ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                        SubjectRequirementSetId )
VALUES ( 'MODIFIER_DISTRICT_IKANDA_BUILDING_STABLE_YIELD_CHANGE', 'MODIFIER_BUILDING_YIELD_CHANGE', 0, 0, 0, NULL, NULL );
INSERT INTO ModifierArguments ( ModifierId, Name, Value )
VALUES ( 'MODIFIER_DISTRICT_IKANDA_BUILDING_STABLE_YIELD_CHANGE', 'Amount', '1' ),
       ( 'MODIFIER_DISTRICT_IKANDA_BUILDING_STABLE_YIELD_CHANGE', 'BuildingType', 'BUILDING_STABLE' ),
       ( 'MODIFIER_DISTRICT_IKANDA_BUILDING_STABLE_YIELD_CHANGE', 'YieldType', 'YIELD_SCIENCE' );

-- =============================================================



