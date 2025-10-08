--  FILE: Civilization_Douglas_Modifier.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/14 10:32:02

--============================================================
-- Lua Support
--============================================================
CREATE TABLE IF NOT EXISTS Nwflower_MOD_Traits(
TraitType TEXT NOT NULL,
PRIMARY KEY (TraitType),
FOREIGN KEY (TraitType) REFERENCES Traits (TraitType) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT OR IGNORE INTO Nwflower_MOD_Traits(TraitType) VALUES
('TRAIT_CIVILIZATION_CIV_DOUGLAS_NW001'),
('TRAIT_LEADER_NW002');

INSERT OR IGNORE INTO TraitModifiers(TraitType,ModifierId)SELECT
TraitType,				'MODFEAT_TRAIT_PROPERTY_'||TraitType
FROM Nwflower_MOD_Traits;

INSERT OR IGNORE INTO Modifiers(ModifierId,ModifierType)SELECT
'MODFEAT_TRAIT_PROPERTY_'||TraitType,			'MODIFIER_PLAYER_ADJUST_PROPERTY'
FROM Nwflower_MOD_Traits;

INSERT OR IGNORE INTO ModifierArguments(ModifierId,Name,Value)SELECT
'MODFEAT_TRAIT_PROPERTY_'||TraitType,			'Key',	'PROPERTY_'||TraitType
FROM Nwflower_MOD_Traits UNION SELECT
'MODFEAT_TRAIT_PROPERTY_'||TraitType,			'Amount',						1
FROM Nwflower_MOD_Traits;


-- 与海军单位相邻的近战攻击单位不会受到两栖作战登陆攻击减益。
INSERT OR IGNORE INTO Types(Type, Kind)
VALUES ( 'ABILITY_NW_001_1','KIND_ABILITY');
INSERT OR IGNORE INTO TypeTags(Type,Tag)
VALUES ('ABILITY_NW_001_1','CLASS_MELEE'),
       ('ABILITY_NW_001_1','CLASS_ANTI_CAVALRY'),
       ('ABILITY_NW_001_1','CLASS_LIGHT_CAVALRY'),
       ('ABILITY_NW_001_1','CLASS_HEAVY_CAVALRY');
INSERT OR IGNORE INTO UnitAbilities(UnitAbilityType,Inactive,Name,Description)
VALUES ( 'ABILITY_NW_001_1', 1 ,'LOC_ABILITY_NW_001_1_NAME','LOC_ABILITY_NW_001_1_NAME');
INSERT OR IGNORE INTO UnitAbilityModifiers(UnitAbilityType,ModifierId)
VALUES ( 'ABILITY_NW_001_1', 'MODIFIER_ABILITY_NW_001_1');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_ABILITY_NW_001_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 0, 0, 0, NULL, 'UNIT_STRONG_WHEN_ATTACKING_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_ABILITY_NW_001_1', 'Amount', '10');
INSERT INTO ModifierStrings (ModifierId, Context, Text) VALUES
('MODIFIER_ABILITY_NW_001_1', 'Preview', 'LOC_MODIFIER_ABILITY_NW_001_1');


INSERT OR IGNORE INTO Types(Type, Kind)
VALUES ( 'ABILITY_NW_001_3','KIND_ABILITY');
INSERT OR IGNORE INTO TypeTags(Type,Tag)
VALUES ('ABILITY_NW_001_3','CLASS_NAVAL_MELEE'),
       ('ABILITY_NW_001_3','CLASS_NAVAL_RANGED'),
       ('ABILITY_NW_001_3','CLASS_NAVAL_RAIDER'),
       ('ABILITY_NW_001_3','CLASS_NAVAL_CARRIER');
INSERT OR IGNORE INTO UnitAbilities(UnitAbilityType,Inactive,Name,Description)
VALUES ( 'ABILITY_NW_001_3', 1 ,'LOC_ABILITY_NW_001_3_NAME','LOC_ABILITY_NW_001_3_NAME');

INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
('ABILITY_NW_001_3', 'TRAIT_ABILITY_NW_001_3_GANGHUAN');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('TRAIT_ABILITY_NW_001_3_GANGHUAN', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 0, 0, 0, NULL, 'REQSET_NW_005');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('TRAIT_ABILITY_NW_001_3_GANGHUAN', 'AbilityType', 'ABILITY_NW_001_1');
-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('REQSET_NW_005', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('REQSET_NW_005', 'REQ_NW_005_1'),
('REQSET_NW_005', 'REQ_NW_005_2');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('REQ_NW_005_1', 'REQUIREMENT_PLOT_ADJACENT_TO_OWNER');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('REQ_NW_005_1', 'MaxDistance', '1'),
('REQ_NW_005_1', 'MinDistance', '0');
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('REQ_NW_005_2', 'REQUIREMENT_PLOT_TERRAIN_CLASS_MATCHES');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('REQ_NW_005_2', 'TerrainClass', 'TERRAIN_CLASS_WATER');


INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_LEADER_NW002', 'TRAIT_TRAIT_LEADER_NW002_NAVAL_ABILITY');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('TRAIT_TRAIT_LEADER_NW002_NAVAL_ABILITY', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('TRAIT_TRAIT_LEADER_NW002_NAVAL_ABILITY', 'AbilityType', 'ABILITY_NW_001_3');


-- 拥有驻军的非己方建立的城市每回合额外提供20点忠诚度。
INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_LEADER_NW002', 'MODIFIER_TRAIT_LEADER_NW002_IDENTITY_PER_TURN');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_LEADER_NW002_IDENTITY_PER_TURN', 'MODIFIER_PLAYER_CITIES_ADJUST_IDENTITY_PER_TURN', 0, 0, 0, NULL, 'REQSET_NW_001');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_NW002_IDENTITY_PER_TURN', 'Amount', '20');
-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('REQSET_NW_001', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('REQSET_NW_001', 'REQ_NW_001_1'),
('REQSET_NW_001', 'REQ_NW_001_2');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType, Inverse) VALUES
('REQ_NW_001_1', 'REQUIREMENT_CITY_HAS_GARRISON_UNIT', 0),
('REQ_NW_001_2', 'REQUIREMENT_CITY_IS_ORIGINAL_OWNER', 1);

-- 解锁“法典”市政后，显示石油资源。石油资源额外+1科技值。
INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_CIVILIZATION_CIV_DOUGLAS_NW001', 'MODIFIER_TRAIT_CIVILIZATION_CIV_DOUGLAS_NW001_VIS');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_CIVILIZATION_CIV_DOUGLAS_NW001_VIS', 'MODIFIER_PLAYER_GRANT_FREE_RESOURCE_VISIBILITY', 0, 0, 0, 'REQSET_NW_002', NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_CIVILIZATION_CIV_DOUGLAS_NW001_VIS', 'ResourceType', 'RESOURCE_OIL');
-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('REQSET_NW_002', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('REQSET_NW_002', 'REQ_NW_002_1');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('REQ_NW_002_1', 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('REQ_NW_002_1', 'CivicType', 'CIVIC_CODE_OF_LAWS');


INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_CIVILIZATION_CIV_DOUGLAS_NW001', 'MODIFIER_TRAIT_CIVILIZATION_CIV_DOUGLAS_NW001_SCIEN');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_CIVILIZATION_CIV_DOUGLAS_NW001_SCIEN', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 0, 0, 0, NULL, 'REQSET_NW_003');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_CIVILIZATION_CIV_DOUGLAS_NW001_SCIEN', 'Amount', '1'),
('MODIFIER_TRAIT_CIVILIZATION_CIV_DOUGLAS_NW001_SCIEN', 'YieldType', 'YIELD_SCIENCE');
-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('REQSET_NW_003', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('REQSET_NW_003', 'REQ_NW_003_1'),
('REQSET_NW_003', 'REQ_NW_003_2');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('REQ_NW_003_1', 'REQUIREMENT_PLOT_RESOURCE_TYPE_MATCHES'),
('REQ_NW_003_2', 'REQUIREMENT_PLOT_RESOURCE_VISIBLE');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('REQ_NW_003_1', 'ResourceType', 'RESOURCE_OIL');


-- 位于海军统帅范围内的所有军事单位进攻时额外+2 [ICON_Strength] 战斗力，并额外回复5点生命值。
INSERT OR IGNORE INTO Types(Type, Kind)
VALUES ( 'ABILITY_NW_001_2','KIND_ABILITY');
INSERT OR IGNORE INTO TypeTags(Type,Tag)
VALUES ('ABILITY_NW_001_2','CLASS_ALL_COMBAT_UNITS');
INSERT OR IGNORE INTO UnitAbilities(UnitAbilityType,Inactive,Name,Description)
VALUES ( 'ABILITY_NW_001_2', 1 ,'LOC_ABILITY_NW_001_2_NAME','LOC_ABILITY_NW_001_2_NAME');
INSERT OR IGNORE INTO UnitAbilityModifiers(UnitAbilityType,ModifierId)
VALUES ( 'ABILITY_NW_001_2', 'MODIFIER_ABILITY_NW_001_2'),
       ('ABILITY_NW_001_2','MAMLUK_HEAL_EVERY_MOVE');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_ABILITY_NW_001_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 0, 0, 0, NULL, 'UNIT_STRONG_WHEN_ATTACKING_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_ABILITY_NW_001_2', 'Amount', '2');
INSERT INTO ModifierStrings (ModifierId, Context, Text) VALUES
('MODIFIER_ABILITY_NW_001_2', 'Preview', 'LOC_MODIFIER_ABILITY_NW_001_2');


INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_CIVILIZATION_CIV_DOUGLAS_NW001', 'TRAIT_CIVILIZATION_CIV_DOUGLAS_NW001_ABILITY');
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
('TRAIT_CIVILIZATION_CIV_DOUGLAS_NW001_ABILITY', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('TRAIT_CIVILIZATION_CIV_DOUGLAS_NW001_ABILITY', 'AbilityType', 'ABILITY_NW_001_5');

INSERT OR IGNORE INTO Types(Type, Kind)
VALUES ( 'ABILITY_NW_001_5','KIND_ABILITY');
INSERT OR IGNORE INTO Tags(Tag, Vocabulary)
VALUES ('NW_CLASS_GREAT_ADMIRAL','ABILITY_CLASS');
INSERT OR IGNORE INTO TypeTags(Type,Tag)
VALUES ('ABILITY_NW_001_5','NW_CLASS_GREAT_ADMIRAL'),
       ('UNIT_GREAT_ADMIRAL','NW_CLASS_GREAT_ADMIRAL');
INSERT OR IGNORE INTO UnitAbilities(UnitAbilityType,Inactive,Name,Description)
VALUES ( 'ABILITY_NW_001_5', 1 ,'LOC_ABILITY_NW_001_5_NAME','LOC_ABILITY_NW_001_5_NAME');

INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
('ABILITY_NW_001_5', 'ABILITY_NW_001_5_GRANT_ABILITY');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('ABILITY_NW_001_5_GRANT_ABILITY', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 0, 0, 0, NULL, 'REQSET_NW_007');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('ABILITY_NW_001_5_GRANT_ABILITY', 'AbilityType', 'ABILITY_NW_001_2');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('REQSET_NW_007', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('REQSET_NW_007', 'REQ_NW_007_1');
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('REQ_NW_007_1', 'REQUIREMENT_PLOT_ADJACENT_TO_OWNER');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('REQ_NW_007_1', 'MaxDistance', '2'),
('REQ_NW_007_1', 'MinDistance', '0');
