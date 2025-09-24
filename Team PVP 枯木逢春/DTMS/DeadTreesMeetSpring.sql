--============================================================
-- Lua Support
--============================================================
CREATE TABLE IF NOT EXISTS Nwflower_MOD_Traits
(
    TraitType TEXT NOT NULL,
    PRIMARY KEY (TraitType),
    FOREIGN KEY (TraitType) REFERENCES Traits (TraitType) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT OR IGNORE INTO Nwflower_MOD_Traits(TraitType)
SELECT TraitType
FROM Traits;

INSERT OR IGNORE INTO TraitModifiers(TraitType, ModifierId)
SELECT TraitType,
       'MODFEAT_TRAIT_PROPERTY_' || TraitType
FROM Nwflower_MOD_Traits;

INSERT OR IGNORE INTO Modifiers(ModifierId, ModifierType)
SELECT 'MODFEAT_TRAIT_PROPERTY_' || TraitType,
       'MODIFIER_PLAYER_ADJUST_PROPERTY'
FROM Nwflower_MOD_Traits;

INSERT OR IGNORE INTO ModifierArguments(ModifierId, Name, Value)
SELECT 'MODFEAT_TRAIT_PROPERTY_' || TraitType,
       'Key',
       'PROPERTY_' || TraitType
FROM Nwflower_MOD_Traits
UNION
SELECT 'MODFEAT_TRAIT_PROPERTY_' || TraitType,
       'Amount',
       1
FROM Nwflower_MOD_Traits;

--============================================================
-- RequirementSet
--============================================================
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


-- 玩家拥有某建筑
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
SELECT 'NW_PLAYER_HAS_' || BuildingType,
       'REQUIREMENTSET_TEST_ALL'
FROM Buildings;
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
SELECT 'NW_PLAYER_HAS_' || BuildingType,
       'REQ_NW_PLAYER_HAS_' || BuildingType
FROM Buildings;
INSERT INTO Requirements (RequirementId, RequirementType)
SELECT 'REQ_NW_PLAYER_HAS_' || BuildingType,
       'REQUIREMENT_PLAYER_HAS_BUILDING'
FROM Buildings;
INSERT INTO RequirementArguments (RequirementId, Name, Value)
SELECT 'REQ_NW_PLAYER_HAS_' || BuildingType,
       'BuildingType',
       BuildingType
FROM Buildings;

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


-- =============================================================
-- 文德 德国 路德维希二世
-- 市中心和每个专业化区域为该城的奇观+4% [ICON_PRODUCTION] 生产力。最多16%。
INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES ('TRAIT_LEADER_LUDWIG', 'MODIFIER_TRAIT_LEADER_LUDWIG_ADD_WONDER_PRODUCTION'),
       ('TRAIT_LEADER_LUDWIG', 'MODIFIER_TRAIT_LEADER_LUDWIG_ADD_WONDER_PRODUCTION1'),
       ('TRAIT_LEADER_LUDWIG', 'MODIFIER_TRAIT_LEADER_LUDWIG_ADD_WONDER_PRODUCTION2'),
       ('TRAIT_LEADER_LUDWIG', 'MODIFIER_TRAIT_LEADER_LUDWIG_ADD_WONDER_PRODUCTION3');
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
VALUES ('MODIFIER_TRAIT_LEADER_LUDWIG_ADD_WONDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_WONDER_PRODUCTION', NULL),
       ('MODIFIER_TRAIT_LEADER_LUDWIG_ADD_WONDER_PRODUCTION1', 'MODIFIER_PLAYER_CITIES_ADJUST_WONDER_PRODUCTION',
        'REQS_NW_DIS1'),
       ('MODIFIER_TRAIT_LEADER_LUDWIG_ADD_WONDER_PRODUCTION2', 'MODIFIER_PLAYER_CITIES_ADJUST_WONDER_PRODUCTION',
        'REQS_NW_DIS2'),
       ('MODIFIER_TRAIT_LEADER_LUDWIG_ADD_WONDER_PRODUCTION3', 'MODIFIER_PLAYER_CITIES_ADJUST_WONDER_PRODUCTION',
        'REQS_NW_DIS3');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_TRAIT_LEADER_LUDWIG_ADD_WONDER_PRODUCTION', 'Amount', '4'),
       ('MODIFIER_TRAIT_LEADER_LUDWIG_ADD_WONDER_PRODUCTION1', 'Amount', '4'),
       ('MODIFIER_TRAIT_LEADER_LUDWIG_ADD_WONDER_PRODUCTION2', 'Amount', '4'),
       ('MODIFIER_TRAIT_LEADER_LUDWIG_ADD_WONDER_PRODUCTION3', 'Amount', '4');


-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('REQS_NW_DIS1', 'REQUIREMENTSET_TEST_ALL'),
       ('REQS_NW_DIS2', 'REQUIREMENTSET_TEST_ALL'),
       ('REQS_NW_DIS3', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('REQS_NW_DIS1', 'REQ_NW_DIS1'),
       ('REQS_NW_DIS2', 'REQ_NW_DIS2'),
       ('REQS_NW_DIS3', 'REQ_NW_DIS3');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('REQ_NW_DIS1', 'REQUIREMENT_CITY_HAS_X_SPECIALTY_DISTRICTS'),
       ('REQ_NW_DIS2', 'REQUIREMENT_CITY_HAS_X_SPECIALTY_DISTRICTS'),
       ('REQ_NW_DIS3', 'REQUIREMENT_CITY_HAS_X_SPECIALTY_DISTRICTS');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('REQ_NW_DIS1', 'Amount', 1),
       ('REQ_NW_DIS2', 'Amount', 2),
       ('REQ_NW_DIS3', 'Amount', 3);

-- =============================================================
-- 埃塞俄比亚
-- 单位在丘陵上时+1视野，军事单位额外+3 [ICON_STRENGTH] 战斗力，平民单位+1 [ICON_MOVEMENT] 移动力。

INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES ('TRAIT_LEADER_MENELIK', 'MODIFIER_TRAIT_LEADER_MENELIK_SIGHT');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_TRAIT_LEADER_MENELIK_SIGHT', 'MODIFIER_NW_PLAYER_UNITS_ADJUST_SIGHT', 0, 0, 0, NULL,
        'REQS_MODIFIER_TRAIT_LEADER_MENELIK_MOVEMENT');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_TRAIT_LEADER_MENELIK_SIGHT', 'Amount', '1');

-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('REQS_NW_PLOT_IS_HILLS', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('REQS_NW_PLOT_IS_HILLS', 'REQ_NW_PLOT_IS_HILLS');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('REQ_NW_PLOT_IS_HILLS', 'REQUIREMENT_PLOT_IS_HILLS');

-- Custom ModifierType
INSERT INTO Types (Type, Kind)
VALUES ('MODIFIER_NW_PLAYER_UNITS_ADJUST_SIGHT', 'KIND_MODIFIER');
INSERT INTO DynamicModifiers (ModifierType, CollectionType, EffectType)
VALUES ('MODIFIER_NW_PLAYER_UNITS_ADJUST_SIGHT', 'COLLECTION_PLAYER_UNITS', 'EFFECT_ADJUST_UNIT_SIGHT');
INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES ('TRAIT_LEADER_MENELIK', 'MODIFIER_TRAIT_LEADER_MENELIK_MOVEMENT');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_TRAIT_LEADER_MENELIK_MOVEMENT', 'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT', 0, 0, 0, NULL,
        'REQS_MODIFIER_TRAIT_LEADER_MENELIK_MOVEMENT');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_TRAIT_LEADER_MENELIK_MOVEMENT', 'Amount', '1');
-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('REQS_MODIFIER_TRAIT_LEADER_MENELIK_MOVEMENT', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('REQS_MODIFIER_TRAIT_LEADER_MENELIK_MOVEMENT', 'REQ_NW_PLOT_IS_HILLS'),
       ('REQS_MODIFIER_TRAIT_LEADER_MENELIK_MOVEMENT', 'REQ_MODIFIER_TRAIT_LEADER_MENELIK_MOVEMENT2');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('REQ_MODIFIER_TRAIT_LEADER_MENELIK_MOVEMENT2', 'REQUIREMENT_UNIT_TAG_MATCHES');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('REQ_MODIFIER_TRAIT_LEADER_MENELIK_MOVEMENT2', 'Tag', 'CLASS_LANDCIVILIAN');


-- 科摩罗扩散
UPDATE Units
SET BaseSightRange = 2
WHERE UnitType = 'UNIT_ETHIOPIAN_OROMO_CAVALRY';

INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES ('TRAIT_LEADER_MENELIK', 'MODIFIER_TRAIT_LEADER_MENELIK_SIGHT2');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_TRAIT_LEADER_MENELIK_SIGHT2', 'MODIFIER_NW_PLAYER_UNITS_ADJUST_SIGHT', 0, 0, 0, NULL,
        'REQS_MODIFIER_TRAIT_LEADER_MENELIK_SIGHT2');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_TRAIT_LEADER_MENELIK_SIGHT2', 'Amount', '1');

-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('REQS_MODIFIER_TRAIT_LEADER_MENELIK_SIGHT2', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('REQS_MODIFIER_TRAIT_LEADER_MENELIK_SIGHT2', 'REQ_MODIFIER_TRAIT_LEADER_MENELIK_SIGHT2');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('REQ_MODIFIER_TRAIT_LEADER_MENELIK_SIGHT2', 'REQUIREMENT_UNIT_PROMOTION_CLASS_MATCHES');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('REQ_MODIFIER_TRAIT_LEADER_MENELIK_SIGHT2', 'UnitPromotionClass', 'PROMOTION_CLASS_LIGHT_CAVALRY');

-- =============================================================
-- 格鲁吉亚
UPDATE Buildings
SET PrereqTech='TECH_MINING'
WHERE BuildingType = 'BUILDING_TSIKHE';
INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES ('TRAIT_CIVILIZATION_GOLDEN_AGE_QUESTS', 'MODIFIER__TRAIT_CIVILIZATION_GOLDEN_AGE_QUESTS_BUILDING_GRANT');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER__TRAIT_CIVILIZATION_GOLDEN_AGE_QUESTS_BUILDING_GRANT',
        'MODIFIER_PLAYER_CITIES_GRANT_CHEAPEST_BUILDING_IN_CITY', 0, 0, 0, 'REQS_NW_PLAYER_HAS_CIVIC_DEFENSIVE_TACTICS',
        NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER__TRAIT_CIVILIZATION_GOLDEN_AGE_QUESTS_BUILDING_GRANT', 'Amount', '1');
-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('REQS_NW_PLAYER_HAS_CIVIC_DEFENSIVE_TACTICS', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('REQS_NW_PLAYER_HAS_CIVIC_DEFENSIVE_TACTICS', 'REQ_NW_PLAYER_HAS_CIVIC_DEFENSIVE_TACTICS');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('REQ_NW_PLAYER_HAS_CIVIC_DEFENSIVE_TACTICS', 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('REQ_NW_PLAYER_HAS_CIVIC_DEFENSIVE_TACTICS', 'CivicType', 'CIVIC_DEFENSIVE_TACTICS');


-- =============================================================
-- 阿拉伯
INSERT INTO Types(Type, Kind)
VALUES ('BUILDING_NW_ALBERT_HOLY_CITY', 'KIND_BUILDING');
INSERT INTO Buildings(BuildingType, Name, Cost, InternalOnly, MustPurchase)
VALUES ('BUILDING_NW_ALBERT_HOLY_CITY', 'LOC_BUILDING_NW_ALBERT_HOLY_CITY_NAME', 1, 1, 1);


-- 圣城训练的宗教单位具有一次额外的传教次数。
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_NW_ALBERT_HOLY_CITY', 'MODIFIER_BUILDING_NW_ALBERT_HOLY_CITY_RELIGIOUS_SPREADS');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_BUILDING_NW_ALBERT_HOLY_CITY_RELIGIOUS_SPREADS', 'MODIFIER_SINGLE_CITY_RELIGIOUS_SPREADS', 0, 1, 0,
        NULL, 'MOSQUE_RELIGIOUS_UNIT');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_BUILDING_NW_ALBERT_HOLY_CITY_RELIGIOUS_SPREADS', 'Amount', '1');

-- +1 [ICON_TRADEROUTE] 贸易路线容量。
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_NW_ALBERT_HOLY_CITY', 'MODIFIER_BUILDING_NW_ALBERT_HOLY_CITY_CAPACITY');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_BUILDING_NW_ALBERT_HOLY_CITY_CAPACITY', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY', 0, 0, 0, NULL,
        NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_BUILDING_NW_ALBERT_HOLY_CITY_CAPACITY', 'Amount', '1');


-- 连接到阿拉伯圣城的 [ICON_TRADEROUTE] 国际贸易路线为起源城市+2 [ICON_GOLD] 金币，为阿拉伯+2 [ICON_FAITH] 信仰值。
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_NW_ALBERT_HOLY_CITY', 'MODIFIER_BUILDING_NW_ALBERT_HOLY_CITY_TRADE_ROUTE_YIELD_TO_OTHERS');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_BUILDING_NW_ALBERT_HOLY_CITY_TRADE_ROUTE_YIELD_TO_OTHERS',
        'MODIFIER_SINGLE_CITY_ADJUST_TRADE_ROUTE_YIELD_TO_OTHERS', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_BUILDING_NW_ALBERT_HOLY_CITY_TRADE_ROUTE_YIELD_TO_OTHERS', 'Amount', '2'),
       ('MODIFIER_BUILDING_NW_ALBERT_HOLY_CITY_TRADE_ROUTE_YIELD_TO_OTHERS', 'Domestic', '0'),
       ('MODIFIER_BUILDING_NW_ALBERT_HOLY_CITY_TRADE_ROUTE_YIELD_TO_OTHERS', 'YieldType', 'YIELD_GOLD');

INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_NW_ALBERT_HOLY_CITY', 'MODIFIER_BUILDING_NW_ALBERT_HOLY_CITY_TRADE_ROUTE_YIELD_FROM_OTHERS');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_BUILDING_NW_ALBERT_HOLY_CITY_TRADE_ROUTE_YIELD_FROM_OTHERS',
        'MODIFIER_SINGLE_CITY_ADJUST_TRADE_ROUTE_YIELD_FROM_OTHERS', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_BUILDING_NW_ALBERT_HOLY_CITY_TRADE_ROUTE_YIELD_FROM_OTHERS', 'Amount', '2'),
       ('MODIFIER_BUILDING_NW_ALBERT_HOLY_CITY_TRADE_ROUTE_YIELD_FROM_OTHERS', 'Domestic', '0'),
       ('MODIFIER_BUILDING_NW_ALBERT_HOLY_CITY_TRADE_ROUTE_YIELD_FROM_OTHERS', 'YieldType', 'YIELD_FAITH');

-- =============================================================
-- 文美
UPDATE ModifierArguments
SET Value='1'
WHERE ModifierId = 'TRAIT_NATIONAL_PARK_APPEAL_BONUS'
  and Name = 'Amount';

UPDATE ModifierArguments
SET Value='0'
WHERE ModifierId IN ('TRAIT_ANTIQUES_AND_PARKS_CULTURE_FORESTS_OR_WONDERS','TRAIT_ANTIQUES_AND_PARKS_CULTURE_FORESTS_OR_WONDERS2','TRAIT_ANTIQUES_AND_PARKS_SCIENCE_NATIONAL_WONDERS_OR_MOUNTAINS')
  and Name = 'Amount';

UPDATE Modifiers
SET SubjectRequirementSetId = 'CITY_HAS_NATIONAL_PARK_REQUREMENTS'
WHERE ModifierId = 'TRAIT_NATIONAL_PARK_APPEAL_BONUS';

-- 惊艳+1科技值
INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES ('TRAIT_LEADER_ANTIQUES_AND_PARKS', 'MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_ADJUST_PLOT_YIELD');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_ADJUST_PLOT_YIELD', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 0, 0, 0,
        'NW_PLAYER_HAS_CIVIC_MYSTICISM', 'NW_PLOT_IS_BREATHTAKING');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_ADJUST_PLOT_YIELD', 'Amount', '1'),
       ('MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_ADJUST_PLOT_YIELD', 'YieldType', 'YIELD_SCIENCE');

-- 惊艳单元格
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('NW_PLOT_IS_BREATHTAKING', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('NW_PLOT_IS_BREATHTAKING', 'REQUIREMENT_NW_PLOT_IS_BREATHTAKING');
INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('REQUIREMENT_NW_PLOT_IS_BREATHTAKING', 'REQUIREMENT_PLOT_IS_APPEAL_BETWEEN');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('REQUIREMENT_NW_PLOT_IS_BREATHTAKING', 'MinimumAppeal', '4');


-- 惊艳未改良+1生产力
INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES ('TRAIT_LEADER_ANTIQUES_AND_PARKS', 'MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_ADJUST_PLOT_YIELD_PRODUCTION');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_ADJUST_PLOT_YIELD_PRODUCTION', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 0,
        0, 0,
        'NW_PLAYER_HAS_CIVIC_MYSTICISM', 'NW_PLOT_IS_BREATHTAKING_AND_UNIMPROVED');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_ADJUST_PLOT_YIELD_PRODUCTION', 'Amount', '1'),
       ('MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_ADJUST_PLOT_YIELD_PRODUCTION', 'YieldType', 'YIELD_PRODUCTION');


-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('NW_PLOT_IS_BREATHTAKING_AND_UNIMPROVED', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('NW_PLOT_IS_BREATHTAKING_AND_UNIMPROVED', 'REQUIREMENT_NW_PLOT_IS_BREATHTAKING'),
       ('NW_PLOT_IS_BREATHTAKING_AND_UNIMPROVED', 'REQUIREMENT_NW_PLOT_IS_UNIMPROVED');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType, Inverse)
VALUES ('REQUIREMENT_NW_PLOT_IS_UNIMPROVED', 'REQUIREMENT_PLOT_HAS_ANY_IMPROVEMENT', 1);

-- 保护区赠送自然学家
INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES ('TRAIT_LEADER_ANTIQUES_AND_PARKS', 'MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_GRANT_UNIT');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_GRANT_UNIT', 'MODIFIER_PLAYER_GRANT_UNIT_IN_CAPITAL', 0, 0, 0,
        'NW_PLAYER_HAS_DISTRICT_PRESERVE', NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_GRANT_UNIT', 'AllowUniqueOverride', '1'),
       ('MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_GRANT_UNIT', 'Amount', '1'),
       ('MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_GRANT_UNIT', 'UnitType', 'UNIT_NATURALIST');

-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('NW_PLAYER_HAS_DISTRICT_PRESERVE', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('NW_PLAYER_HAS_DISTRICT_PRESERVE', 'REQ_NW_PLAYER_HAS_DISTRICT_PRESERVE');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('REQ_NW_PLAYER_HAS_DISTRICT_PRESERVE', 'REQUIREMENT_PLAYER_HAS_DISTRICT');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('REQ_NW_PLAYER_HAS_DISTRICT_PRESERVE', 'DistrictType', 'DISTRICT_PRESERVE');


-- INSERT INTO TraitModifiers (TraitType, ModifierId)
-- SELECT 'TRAIT_LEADER_ANTIQUES_AND_PARKS',
--        'MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_GRANT_UNIT_' || BuildingType
-- FROM Buildings
-- WHERE PrereqDistrict = 'DISTRICT_PRESERVE';
-- INSERT INTO Modifiers (ModifierId, ModifierType, OwnerRequirementSetId)
-- SELECT 'MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_GRANT_UNIT_' || BuildingType,
--        'MODIFIER_PLAYER_GRANT_UNIT_IN_CAPITAL',
--        'NW_PLAYER_HAS_' || BuildingType
-- FROM Buildings
-- WHERE PrereqDistrict = 'DISTRICT_PRESERVE';
-- INSERT INTO ModifierArguments (ModifierId, Name, Value)
-- SELECT 'MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_GRANT_UNIT_' || BuildingType,
--        'AllowUniqueOverride',
--        '1'
-- FROM Buildings
-- WHERE PrereqDistrict = 'DISTRICT_PRESERVE'
-- UNION
-- SELECT 'MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_GRANT_UNIT_' || BuildingType,
--        'Amount',
--        '1'
-- FROM Buildings
-- WHERE PrereqDistrict = 'DISTRICT_PRESERVE'
-- UNION
-- SELECT 'MODIFIER_TRAIT_LEADER_ANTIQUES_AND_PARKS_GRANT_UNIT_' || BuildingType,
--        'UnitType',
--        'UNIT_NATURALIST'
-- FROM Buildings
-- WHERE PrereqDistrict = 'DISTRICT_PRESERVE';



-- =============================================================
-- 武美
UPDATE ModifierArguments
SET Name  = 'Key',
    Value = 'ROOSEVELT_COMBAT_BONUS_HOME_CONTINENT'
WHERE ModifierId = 'ROOSEVELT_COMBAT_BONUS_HOME_CONTINENT'
  and Name = 'Amount';


INSERT INTO Types (Type, Kind)
VALUES ('MODIFIER_NW_PLAYER_UNITS_ADJUST_PROPERTY', 'KIND_MODIFIER');
INSERT INTO DynamicModifiers (ModifierType, CollectionType, EffectType)
VALUES ('MODIFIER_NW_PLAYER_UNITS_ADJUST_PROPERTY', 'COLLECTION_PLAYER_UNITS', 'EFFECT_ADJUST_UNIT_PROPERTY');


INSERT INTO Modifiers (ModifierId, ModifierType)
VALUES ('MODIFIER_TRAIT_LEADER_ROOSEVELT_COROLLARY_ADD_JUST_PROPERTY', 'MODIFIER_NW_PLAYER_UNITS_ADJUST_PROPERTY');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_TRAIT_LEADER_ROOSEVELT_COROLLARY_ADD_JUST_PROPERTY', 'Key', 'ROOSEVELT_COMBAT_BONUS_HOME_CONTINENT'),
       ('MODIFIER_TRAIT_LEADER_ROOSEVELT_COROLLARY_ADD_JUST_PROPERTY', 'Amount', '1');

INSERT INTO DistrictModifiers(DistrictType, ModifierId)
VALUES ('DISTRICT_GOVERNMENT', 'MODIFIER_TRAIT_LEADER_ROOSEVELT_COROLLARY_ADD_JUST_PROPERTY');
INSERT INTO BuildingModifiers(BuildingType, ModifierId)
SELECT BuildingType,
       'MODIFIER_TRAIT_LEADER_ROOSEVELT_COROLLARY_ADD_JUST_PROPERTY'
FROM Buildings
WHERE PrereqDistrict = 'DISTRICT_GOVERNMENT';

INSERT INTO Modifiers (ModifierId, ModifierType)
VALUES ('MODIFIER_TRAIT_LEADER_ROOSEVELT_COROLLARY_ADD_JUST_PROPERTY2', 'MODIFIER_NW_PLAYER_UNITS_ADJUST_PROPERTY');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_TRAIT_LEADER_ROOSEVELT_COROLLARY_ADD_JUST_PROPERTY2', 'Key',
        'ROOSEVELT_COMBAT_BONUS_NOT_HOME_CONTINENT'),
       ('MODIFIER_TRAIT_LEADER_ROOSEVELT_COROLLARY_ADD_JUST_PROPERTY2', 'Amount', '1');


INSERT INTO DistrictModifiers(DistrictType, ModifierId)
VALUES ('DISTRICT_DIPLOMATIC_QUARTER', 'MODIFIER_TRAIT_LEADER_ROOSEVELT_COROLLARY_ADD_JUST_PROPERTY2');
INSERT INTO BuildingModifiers(BuildingType, ModifierId)
SELECT BuildingType,
       'MODIFIER_TRAIT_LEADER_ROOSEVELT_COROLLARY_ADD_JUST_PROPERTY2'
FROM Buildings
WHERE PrereqDistrict = 'DISTRICT_DIPLOMATIC_QUARTER';


INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId)
VALUES ('ABILITY_ROOSEVELT_COMBAT_BONUS_HOME_CONTINENT', 'ROOSEVELT_COMBAT_BONUS_FOREIGN_CONTINENT');
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
VALUES ('ROOSEVELT_COMBAT_BONUS_FOREIGN_CONTINENT', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH',
        'REDCOAT_PLOT_IS_FOREIGN_CONTINENT');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('ROOSEVELT_COMBAT_BONUS_FOREIGN_CONTINENT', 'Key', 'ROOSEVELT_COMBAT_BONUS_NOT_HOME_CONTINENT');
INSERT INTO ModifierStrings (ModifierId, Context, Text)
VALUES ('ROOSEVELT_COMBAT_BONUS_FOREIGN_CONTINENT', 'Preview', 'LOC_ROOSEVELT_COMBAT_BONUS_FOREIGN_CONTINENT');


-- =============================================================
-- 苏格兰
CREATE TABLE NW_SUGELAN_AMENITIES
(
    PopulationThreshold INTEGER PRIMARY KEY,
    AmenityCorrection   INTEGER NOT NULL
);

-- 插入修正值数据（1-30人口）
WITH RECURSIVE
    seq(k) AS (SELECT 1
               UNION ALL
               SELECT k + 1
               FROM seq
               WHERE k < 30),
    total_corrections AS (SELECT k,
                                 (k + 1) / 2 - k / 3 AS total_correction
                          FROM seq),
    corrections_with_prev AS (SELECT a.k,
                                     a.total_correction,
                                     COALESCE(b.total_correction, 0) AS prev_total_correction
                              FROM total_corrections a
                                       LEFT JOIN total_corrections b ON a.k = b.k + 1)
INSERT
INTO NW_SUGELAN_AMENITIES (PopulationThreshold, AmenityCorrection)
SELECT k,
       total_correction - prev_total_correction AS amenity_correction
FROM corrections_with_prev
WHERE amenity_correction != 0;


INSERT INTO TraitModifiers (TraitType, ModifierId)
SELECT 'TRAIT_CIVILIZATION_SCOTTISH_ENLIGHTENMENT',
       'TRAIT_CIVILIZATION_SCOTTISH_ENLIGHTENMENT_AMEN_' || PopulationThreshold
FROM NW_SUGELAN_AMENITIES;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
SELECT 'TRAIT_CIVILIZATION_SCOTTISH_ENLIGHTENMENT_AMEN_' || PopulationThreshold,
       'MODIFIER_PLAYER_CITIES_ADJUST_TRAIT_AMENITY',
       'REQS_NW_CITY_HAS_' || PopulationThreshold || '_POPULATION'
FROM NW_SUGELAN_AMENITIES;
INSERT INTO ModifierArguments (ModifierId, Name, Value)
SELECT 'TRAIT_CIVILIZATION_SCOTTISH_ENLIGHTENMENT_AMEN_' || PopulationThreshold,
       'Amount',
       AmenityCorrection
FROM NW_SUGELAN_AMENITIES;

-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
SELECT 'REQS_NW_CITY_HAS_' || PopulationThreshold || '_POPULATION',
       'REQUIREMENTSET_TEST_ALL'
FROM NW_SUGELAN_AMENITIES;
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
SELECT 'REQS_NW_CITY_HAS_' || PopulationThreshold || '_POPULATION',
       'REQ_NW_CITY_HAS_' || PopulationThreshold || '_POPULATION'
FROM NW_SUGELAN_AMENITIES;
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType)
SELECT 'REQ_NW_CITY_HAS_' || PopulationThreshold || '_POPULATION',
       'REQUIREMENT_CITY_HAS_X_POPULATION'
FROM NW_SUGELAN_AMENITIES;
INSERT INTO RequirementArguments (RequirementId, Name, Value)
SELECT 'REQ_NW_CITY_HAS_' || PopulationThreshold || '_POPULATION',
       'Amount',
       PopulationThreshold
FROM NW_SUGELAN_AMENITIES;

DELETE
FROM TraitModifiers
WHERE TraitType = 'TRAIT_CIVILIZATION_SCOTTISH_ENLIGHTENMENT'
  AND ModifierId IN ('TRAIT_BOOST_AQUEDUCT_PRODUCTION_CPLMOD_SUGELAN',
                     'TRAIT_SCIENTIST_HAPPY',
                     'TRAIT_SCIENTIST_ECSTATIC',
                     'TRAIT_ENGINEER_HAPPY',
                     'TRAIT_ENGINEER_ECSTATIC');

UPDATE ModifierArguments
SET Value = 5
WHERE ModifierId = 'TRAIT_SCIENCE_HAPPY'
  AND Name = 'Amount';
UPDATE ModifierArguments
SET Value = 5
WHERE ModifierId = 'TRAIT_PRODUCTION_HAPPY'
  AND Name = 'Amount';
UPDATE ModifierArguments
SET Value = 10
WHERE ModifierId = 'TRAIT_SCIENCE_ECSTATIC'
  AND Name = 'Amount';
UPDATE ModifierArguments
SET Value = 10
WHERE ModifierId = 'TRAIT_PRODUCTION_ECSTATIC'
  AND Name = 'Amount';

-- =============================================================
-- 埃莉诺（英国）
INSERT INTO Types (Type, Kind)
VALUES ('MODIFIER_NW_CAPITAL_GRANT_GREAT_PERSON_CLASS_IN_CITY', 'KIND_MODIFIER');
INSERT INTO DynamicModifiers (ModifierType, CollectionType, EffectType)
VALUES ('MODIFIER_NW_CAPITAL_GRANT_GREAT_PERSON_CLASS_IN_CITY', 'COLLECTION_PLAYER_CAPITAL_CITY',
        'EFFECT_GRANT_GREAT_PERSON_CLASS_IN_CITY');

UPDATE Modifiers
SET ModifierType = 'MODIFIER_NW_CAPITAL_GRANT_GREAT_PERSON_CLASS_IN_CITY'
WHERE ModifierId = 'TRAIT_BONUS_GREAT_PROPHET_POINT_D';
UPDATE ModifierArguments
SET Value = 3
WHERE ModifierId = 'ELEANOR_DOUBLE_SCULPTURE_S1'
  AND Name = 'YieldChange';


-- =============================================================
-- 埃莉诺（法国）
-- 巨作+3 [ICON_Science] 科技值，并对9个单元格内的外国城市施加3点忠诚度压力。
-- 因忠诚度而叛乱的城市，如其每回合对埃莉诺的忠诚度最高，则会直接加入埃莉诺的文明。
-- 埃莉诺的宫殿额外获得一个任意槽位。
-- 埃莉诺在建造剧院建筑、区域时+25% [ICON_PRODUCTION] 生产力。
-- 若解锁“戏剧与诗歌”市政，则获得一名免费的 [ICON_GreatWriter] 大作家。
-- 招募伟人时随机获得两项 [ICON_CivicBoosted] 鼓舞。

DELETE
FROM TraitModifiers
WHERE TraitType = 'TRAIT_LEADER_ELEANOR_FRANCE_LOYALTY_TEAM_PVP'
  AND ModifierId IN ('TRAIT_BONUS_GREAT_PROPHET_POINT_c',
                     'AIFA_CHENGBAO_JIA1JINBI_TEAM_PVP');

INSERT INTO TraitModifiers(TraitType, ModifierId)
VALUES ('TRAIT_LEADER_ELEANOR_FRANCE_LOYALTY_TEAM_PVP', 'TRAIT_BONUS_GREAT_PROPHET_POINT_D');

INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES ('TRAIT_LEADER_ELEANOR_FRANCE_LOYALTY_TEAM_PVP', 'MODIFIER_TRAIT_LEADER_ELEANOR_FRANCE_LOYALTY_TEAM_PVP_BOOST');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_TRAIT_LEADER_ELEANOR_FRANCE_LOYALTY_TEAM_PVP_BOOST',
        'MODIFIER_PLAYER_GRANT_RANDOM_CIVIC_BOOST_BY_ERA', 0, 0, 0, NULL, 'NW_UNIT_IS_ANY_GP');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_TRAIT_LEADER_ELEANOR_FRANCE_LOYALTY_TEAM_PVP_BOOST', 'Amount', '2'),
       ('MODIFIER_TRAIT_LEADER_ELEANOR_FRANCE_LOYALTY_TEAM_PVP_BOOST', 'EndEraType', 'ERA_FUTURE'),
       ('MODIFIER_TRAIT_LEADER_ELEANOR_FRANCE_LOYALTY_TEAM_PVP_BOOST', 'StartEraType', 'ERA_ANCIENT');

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('NW_UNIT_IS_ANY_GP', 'REQUIREMENTSET_TEST_ANY');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
SELECT 'NW_UNIT_IS_ANY_GP',
       'REQ_NW_UNIT_IS_' || GreatPersonClassType
FROM GreatPersonClasses;
INSERT INTO Requirements (RequirementId, RequirementType)
SELECT 'REQ_NW_UNIT_IS_' || GreatPersonClassType,
       'REQUIREMENT_GREAT_PERSON_TYPE_MATCHES'
FROM GreatPersonClasses;
INSERT INTO RequirementArguments (RequirementId, Name, Value)
SELECT 'REQ_NW_UNIT_IS_' || GreatPersonClassType,
       'GreatPersonClassType',
       GreatPersonClassType
FROM GreatPersonClasses;

-- =============================================================
-- 金法
-- 解锁写作时也解锁剧院广场。剧院广场从相邻奢侈品资源获得大量相邻加成。可在拥有剧院广场区域的任意城市中开展“宫廷盛会”项目。建造剧院广场建筑时+70%生产力。
-- 删除原效果
DELETE
FROM TraitModifiers
WHERE TraitType = 'TRAIT_LEADER_MAGNIFICENCES'
  AND ModifierId = 'TRAIT_GANGKOU_AQUEDUCT_PRODUCTION_MEIDIQI2';
DELETE
FROM TraitModifiers
WHERE TraitType = 'TRAIT_LEADER_MAGNIFICENCES'
  AND ModifierId = 'MAGNIFICENCES_CULTURE_LUXURY_ADJACENT_TO_THEATER_SQUARE_OR_CHATEAU';

INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES ('TRAIT_LEADER_MAGNIFICENCES', 'MODIFIER_TRAIT_LEADER_MAGNIFICENCES_DIS');
INSERT INTO Modifiers (ModifierId, ModifierType, OwnerRequirementSetId)
VALUES ('MODIFIER_TRAIT_LEADER_MAGNIFICENCES_DIS', 'MODIFIER_PLAYER_ADJUST_DISTRICT_UNLOCK','NW_PLAYER_HAS_TECH_WRITING');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_TRAIT_LEADER_MAGNIFICENCES_DIS', 'DistrictType', 'DISTRICT_THEATER'),
       ('MODIFIER_TRAIT_LEADER_MAGNIFICENCES_DIS', 'CivicType', 'CIVIC_CODE_OF_LAWS');

UPDATE ModifierArguments
SET Value = 50
WHERE ModifierId = 'THEATER_BUILDING_PRODUCTION_BONUS_MEDIQI'
  AND Name = 'Amount';

INSERT INTO Adjacency_YieldChanges(ID, Description, YieldType, AdjacentResourceClass, YieldChange)
VALUES ('TRAIT_LEADER_MAGNIFICENCES_THEATER', 'LOC_TRAIT_LEADER_MAGNIFICENCES_THEATER', 'YIELD_CULTURE', 'RESOURCECLASS_LUXURY', 2);
INSERT INTO District_Adjacencies(DistrictType, YieldChangeId) VALUES
('DISTRICT_THEATER','TRAIT_LEADER_MAGNIFICENCES_THEATER');

INSERT OR IGNORE INTO ExcludedAdjacencies(TraitType, YieldChangeId) SELECT DISTINCT TraitType, 'TRAIT_LEADER_MAGNIFICENCES_THEATER' FROM LeaderTraits GROUP BY LeaderType;
DELETE FROM ExcludedAdjacencies WHERE YieldChangeId = 'TRAIT_LEADER_MAGNIFICENCES_THEATER' AND TraitType IN (SELECT TraitType FROM LeaderTraits WHERE LeaderType = 'LEADER_CATHERINE_DE_MEDICI_ALT');

