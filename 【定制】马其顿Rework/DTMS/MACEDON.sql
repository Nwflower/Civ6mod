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
-- 马其顿
-- 城市不会产生厌战情绪。没有消耗完移动力的单位，在下个回合开始时+1 [ICON_MOVEMENT] 移动力。民族主义市政后，拥有皇家学堂的城市+10% [ICON_CULTURE] 文化值。

DELETE FROM TraitModifiers WHERE TraitType = 'TRAIT_LEADER_TO_WORLDS_END'
AND ModifierId IN ('MAQIDUN_DAJUN_DIANSHU_1','MAQIDUN_DAJUN_DIANSHU_2','TRAIT_TOWORLDSEND_HEAL_ON_WONDER_CAPTURE');

DELETE FROM TraitModifiers WHERE TraitType = 'TRAIT_CIVILIZATION_HELLENISTIC_FUSION' AND ModifierId IN
    ('TRAIT_HELLENISTIC_FUSION_ENCAMPMENT_EUREKA',
     'TRAIT_HELLENISTIC_FUSION_CAMPUS_EUREKA',
     'TRAIT_HELLENISTIC_FUSION_HOLY_SITE_INSPIRATION',
     'TRAIT_HELLENISTIC_FUSION_THEATER_INSPIRATION');

INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_LEADER_TO_WORLDS_END', 'MODIFIER_TRAIT_LEADER_TO_WORLDS_END_ADD_CULTURE');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_LEADER_TO_WORLDS_END_ADD_CULTURE', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', 0, 0, 0, 'NW_PLAYER_HAS_CIVIC_NATIONALISM', 'REQS_NW_CITY_HAS_TRAIT_CIVILIZATION_BUILDING_BASILIKOI_PAIDES');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_TO_WORLDS_END_ADD_CULTURE', 'Amount', '10'),
('MODIFIER_TRAIT_LEADER_TO_WORLDS_END_ADD_CULTURE', 'YieldType', 'YIELD_CULTURE');

-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('REQS_NW_CITY_HAS_TRAIT_CIVILIZATION_BUILDING_BASILIKOI_PAIDES', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('REQS_NW_CITY_HAS_TRAIT_CIVILIZATION_BUILDING_BASILIKOI_PAIDES', 'REQ_NW_CITY_HAS_TRAIT_CIVILIZATION_BUILDING_BASILIKOI_PAIDES');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('REQ_NW_CITY_HAS_TRAIT_CIVILIZATION_BUILDING_BASILIKOI_PAIDES', 'REQUIREMENT_CITY_HAS_BUILDING');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('REQ_NW_CITY_HAS_TRAIT_CIVILIZATION_BUILDING_BASILIKOI_PAIDES', 'BuildingType', 'BUILDING_BASILIKOI_PAIDES');

-- 建造首都已有的区域时+15% [ICON_PRODUCTION] 生产力。
-- 在非自己建立的城市，上述加成翻倍。

INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_CIVILIZATION_HELLENISTIC_FUSION', 'MODIFIER_TRAIT_CIVILIZATION_HELLENISTIC_FUSION_ADD_FOOD');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_CIVILIZATION_HELLENISTIC_FUSION_ADD_FOOD', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_CIVILIZATION_HELLENISTIC_FUSION_ADD_FOOD', 'Amount', '1'),
('MODIFIER_TRAIT_CIVILIZATION_HELLENISTIC_FUSION_ADD_FOOD', 'YieldType', 'YIELD_FOOD');

INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_CIVILIZATION_HELLENISTIC_FUSION', 'MODIFIER_TRAIT_CIVILIZATION_HELLENISTIC_FUSION_ADD_PRODUCTION');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_CIVILIZATION_HELLENISTIC_FUSION_ADD_PRODUCTION', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE', 0, 0, 0, NULL, 'NW_DISTRICT_IS_DISTRICT_ENCAMPMENT');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_CIVILIZATION_HELLENISTIC_FUSION_ADD_PRODUCTION', 'Amount', '1'),
('MODIFIER_TRAIT_CIVILIZATION_HELLENISTIC_FUSION_ADD_PRODUCTION', 'YieldType', 'YIELD_PRODUCTION');


INSERT OR IGNORE INTO TraitModifiers (TraitType, ModifierId) SELECT
'TRAIT_CIVILIZATION_HELLENISTIC_FUSION','MODIFIER_TRAIT_CIVILIZATION_HELLENISTIC_FUSION_ADD_SCIENCE'||CivicType
FROM Civics;
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) SELECT
'MODIFIER_TRAIT_CIVILIZATION_HELLENISTIC_FUSION_ADD_SCIENCE'||CivicType, 'MODIFIER_PLAYER_ADJUST_YIELD_CHANGE', 'NW_PLAYER_HAS_CIVIC_POLITICAL_PHILOSOPHY_AND_'||CivicType
FROM Civics;
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) SELECT
'MODIFIER_TRAIT_CIVILIZATION_HELLENISTIC_FUSION_ADD_SCIENCE'||CivicType, 'Amount', 1/3
FROM Civics UNION SELECT
'MODIFIER_TRAIT_CIVILIZATION_HELLENISTIC_FUSION_ADD_SCIENCE'||CivicType, 'YieldType', 'YIELD_SCIENCE'
FROM Civics;

-- RequirementSets
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) SELECT
'NW_PLAYER_HAS_CIVIC_POLITICAL_PHILOSOPHY_AND_'||CivicType, 'REQUIREMENTSET_TEST_ALL'
FROM Civics;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) SELECT
'NW_PLAYER_HAS_CIVIC_POLITICAL_PHILOSOPHY_AND_'||CivicType, 'NW_UTILS_PLAYER_HAS_'||CivicType
FROM Civics UNION SELECT
'NW_PLAYER_HAS_CIVIC_POLITICAL_PHILOSOPHY_AND_'||CivicType, 'NW_UTILS_PLAYER_HAS_CIVIC_POLITICAL_PHILOSOPHY_REQUIREMENT'
FROM Civics;


INSERT OR IGNORE INTO TraitModifiers (TraitType, ModifierId) SELECT
'TRAIT_CIVILIZATION_HELLENISTIC_FUSION','MODIFIER_TRAIT_CIVILIZATION_HELLENISTIC_FUSION_ADD_SCIENCE'||TechnologyType
FROM Technologies;
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) SELECT
'MODIFIER_TRAIT_CIVILIZATION_HELLENISTIC_FUSION_ADD_SCIENCE'||TechnologyType, 'MODIFIER_PLAYER_ADJUST_YIELD_CHANGE', 'NW_PLAYER_HAS_CIVIC_POLITICAL_PHILOSOPHY_AND_'||TechnologyType
FROM Technologies;
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) SELECT
'MODIFIER_TRAIT_CIVILIZATION_HELLENISTIC_FUSION_ADD_SCIENCE'||TechnologyType, 'Amount', 1/3
FROM Technologies UNION SELECT
'MODIFIER_TRAIT_CIVILIZATION_HELLENISTIC_FUSION_ADD_SCIENCE'||TechnologyType, 'YieldType', 'YIELD_CULTURE'
FROM Technologies;

-- RequirementSets
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) SELECT
'NW_PLAYER_HAS_CIVIC_POLITICAL_PHILOSOPHY_AND_'||TechnologyType, 'REQUIREMENTSET_TEST_ALL'
FROM Technologies;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) SELECT
'NW_PLAYER_HAS_CIVIC_POLITICAL_PHILOSOPHY_AND_'||TechnologyType, 'NW_UTILS_PLAYER_HAS_'||TechnologyType
FROM Technologies UNION SELECT
'NW_PLAYER_HAS_CIVIC_POLITICAL_PHILOSOPHY_AND_'||TechnologyType, 'NW_UTILS_PLAYER_HAS_CIVIC_POLITICAL_PHILOSOPHY_REQUIREMENT'
FROM Technologies;



INSERT INTO Modifiers (ModifierId, ModifierType, OwnerRequirementSetId) SELECT
'MODIFIER_MAQIDUN_ADD_PRODUCTION_'||DistrictType, 'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION',  'NW_CITY_HAS_PALACE_AND_IS_MAQIDUN'
FROM Districts;
INSERT INTO ModifierArguments (ModifierId, Name, Value) SELECT
'MODIFIER_MAQIDUN_ADD_PRODUCTION_'||DistrictType, 'Amount', '15'
FROM Districts UNION SELECT
'MODIFIER_MAQIDUN_ADD_PRODUCTION_'||DistrictType, 'DistrictType', DistrictType
FROM Districts;
INSERT INTO DistrictModifiers(DistrictType, ModifierId) SELECT
DistrictType,'MODIFIER_MAQIDUN_ADD_PRODUCTION_'||DistrictType
FROM Districts;

INSERT INTO Modifiers (ModifierId, ModifierType, OwnerRequirementSetId,SubjectRequirementSetId) SELECT
'MODIFIER_MAQIDUN_ADD_PRODUCTION2_'||DistrictType, 'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION',  'NW_CITY_HAS_PALACE_AND_IS_MAQIDUN','CITY_NOT_FOUNDED'
FROM Districts;
INSERT INTO ModifierArguments (ModifierId, Name, Value) SELECT
'MODIFIER_MAQIDUN_ADD_PRODUCTION2_'||DistrictType, 'Amount', '15'
FROM Districts UNION SELECT
'MODIFIER_MAQIDUN_ADD_PRODUCTION2_'||DistrictType, 'DistrictType', DistrictType
FROM Districts;
INSERT INTO DistrictModifiers(DistrictType, ModifierId) SELECT
DistrictType,'MODIFIER_MAQIDUN_ADD_PRODUCTION2_'||DistrictType
FROM Districts;

-- RequirementSets
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('NW_CITY_HAS_PALACE_AND_IS_MAQIDUN', 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('NW_CITY_HAS_PALACE_AND_IS_MAQIDUN', 'REQ_NW_CITY_HAS_PALACE'),
('NW_CITY_HAS_PALACE_AND_IS_MAQIDUN', 'NW_PLAYER_IS_LEADER_ALEXANDER_REQUIREMENT');
-- Requirements
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES
('REQ_NW_CITY_HAS_PALACE', 'REQUIREMENT_CITY_HAS_BUILDING');
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES
('REQ_NW_CITY_HAS_PALACE', 'BuildingType', 'BUILDING_PALACE');
