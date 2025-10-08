--  FILE: LLR_Modifier.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/10/5 12:10:26

--============================================================
-- Lua Support
--============================================================
CREATE TABLE IF NOT EXISTS Nwflower_MOD_Traits(
TraitType TEXT NOT NULL,
PRIMARY KEY (TraitType),
FOREIGN KEY (TraitType) REFERENCES Traits (TraitType) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT OR IGNORE INTO Nwflower_MOD_Traits(TraitType) VALUES
('TRAIT_LEADER_NW251004');

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

--============================================================

-- 军营及其建筑不消耗维护费，
-- 军营建筑提供额外+1 [ICON_CULTURE] 文化。

INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES 
('TRAIT_LEADER_NW251004', 'MODIFIER_TRAIT_LEADER_NW251004_DW');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
('MODIFIER_TRAIT_LEADER_NW251004_DW', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE', 0, 0, 0, NULL, 'DISTRICT_IS_ENCAMPMENT');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
('MODIFIER_TRAIT_LEADER_NW251004_DW', 'Amount', '1'), 
('MODIFIER_TRAIT_LEADER_NW251004_DW', 'YieldType', 'YIELD_CULTURE');

INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES 
('TRAIT_LEADER_NW251004', 'MODIFIER_TRAIT_LEADER_NW251004_DG');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
('MODIFIER_TRAIT_LEADER_NW251004_DG', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE', 0, 0, 0, NULL, 'DISTRICT_IS_ENCAMPMENT');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
('MODIFIER_TRAIT_LEADER_NW251004_DG', 'Amount', '1'), 
('MODIFIER_TRAIT_LEADER_NW251004_DG', 'YieldType', 'YIELD_GOLD');


INSERT INTO TraitModifiers (TraitType, ModifierId) SELECT
'TRAIT_LEADER_NW251004', 'MODIFIER_TRAIT_LEADER_NW251004_ADD_FOOD_'||BuildingType
FROM Buildings WHERE PrereqDistrict = 'DISTRICT_ENCAMPMENT';
INSERT INTO Modifiers (ModifierId, ModifierType) SELECT
'MODIFIER_TRAIT_LEADER_NW251004_ADD_FOOD_'||BuildingType, 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE'
FROM Buildings WHERE PrereqDistrict = 'DISTRICT_ENCAMPMENT';
INSERT INTO ModifierArguments (ModifierId, Name, Value) SELECT
'MODIFIER_TRAIT_LEADER_NW251004_ADD_FOOD_'||BuildingType, 'Amount', '1'
FROM Buildings WHERE PrereqDistrict = 'DISTRICT_ENCAMPMENT' UNION SELECT
'MODIFIER_TRAIT_LEADER_NW251004_ADD_FOOD_'||BuildingType, 'BuildingType', BuildingType
FROM Buildings WHERE PrereqDistrict = 'DISTRICT_ENCAMPMENT' UNION SELECT
'MODIFIER_TRAIT_LEADER_NW251004_ADD_FOOD_'||BuildingType, 'YieldType', 'YIELD_CULTURE'
FROM Buildings WHERE PrereqDistrict = 'DISTRICT_ENCAMPMENT';

INSERT INTO TraitModifiers (TraitType, ModifierId) SELECT
'TRAIT_LEADER_NW251004', 'MODIFIER_TRAIT_LEADER_NW251004_ADD_GOLD_'||BuildingType
FROM Buildings WHERE PrereqDistrict = 'DISTRICT_ENCAMPMENT';
INSERT INTO Modifiers (ModifierId, ModifierType) SELECT
'MODIFIER_TRAIT_LEADER_NW251004_ADD_GOLD_'||BuildingType, 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE'
FROM Buildings WHERE PrereqDistrict = 'DISTRICT_ENCAMPMENT';
INSERT INTO ModifierArguments (ModifierId, Name, Value) SELECT
'MODIFIER_TRAIT_LEADER_NW251004_ADD_GOLD_'||BuildingType, 'Amount', Maintenance
FROM Buildings WHERE PrereqDistrict = 'DISTRICT_ENCAMPMENT' UNION SELECT
'MODIFIER_TRAIT_LEADER_NW251004_ADD_GOLD_'||BuildingType, 'BuildingType', BuildingType
FROM Buildings WHERE PrereqDistrict = 'DISTRICT_ENCAMPMENT' UNION SELECT
'MODIFIER_TRAIT_LEADER_NW251004_ADD_GOLD_'||BuildingType, 'YieldType', 'YIELD_GOLD'
FROM Buildings WHERE PrereqDistrict = 'DISTRICT_ENCAMPMENT';


-- 拥有兵工厂但尚无市场的城市获得一条 [ICON_TRADEROUTE] 贸易路线容量。

INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_LEADER_NW251004', 'MODIFIER_TRAIT_LEADER_NW251004_TR');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_LEADER_NW251004_TR', 'MODIFIER_PLAYER_CITIES_ADJUST_TRADE_ROUTE_CAPACITY', 0, 0, 0, NULL, 'REQS_NW_MODIFIER_TRAIT_LEADER_NW251004_TR');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_NW251004_TR', 'Amount', '1');

-- RequirementSets

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('REQS_NW_MODIFIER_TRAIT_LEADER_NW251004_TR', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('REQS_NW_MODIFIER_TRAIT_LEADER_NW251004_TR', 'REQ_NW_MODIFIER_TRAIT_LEADER_NW251004_TR1'),
('REQS_NW_MODIFIER_TRAIT_LEADER_NW251004_TR', 'REQ_NW_MODIFIER_TRAIT_LEADER_NW251004_TR2');

-- Requirements

INSERT INTO Requirements (RequirementId, RequirementType, Inverse) VALUES
('REQ_NW_MODIFIER_TRAIT_LEADER_NW251004_TR1', 'REQUIREMENT_CITY_HAS_BUILDING', 0),
('REQ_NW_MODIFIER_TRAIT_LEADER_NW251004_TR2', 'REQUIREMENT_CITY_HAS_BUILDING', 1);

INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('REQ_NW_MODIFIER_TRAIT_LEADER_NW251004_TR1', 'BuildingType', 'BUILDING_ARMORY'),
('REQ_NW_MODIFIER_TRAIT_LEADER_NW251004_TR2', 'BuildingType', 'BUILDING_MARKET');


-- 军团和军队的 [ICON_Strength] 战斗力在解锁人文主义后+1，城市化后+1。

INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_LEADER_NW251004', 'MODIFIER_TRAIT_LEADER_NW251004_LI1');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_LEADER_NW251004_LI1', 'MODIFIER_PLAYER_CORPS_ARMY_MODIFIED_STRENGTH', 0, 0, 0, 'NW_PLAYER_HAS_CIVIC_HUMANISM', NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_NW251004_LI1', 'Amount', 1),
('MODIFIER_TRAIT_LEADER_NW251004_LI1', 'Corps', 1),
('MODIFIER_TRAIT_LEADER_NW251004_LI1', 'Domain', 'DOMAIN_LAND');
INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_LEADER_NW251004', 'MODIFIER_TRAIT_LEADER_NW251004_LI2');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_LEADER_NW251004_LI2', 'MODIFIER_PLAYER_CORPS_ARMY_MODIFIED_STRENGTH', 0, 0, 0, 'NW_PLAYER_HAS_CIVIC_HUMANISM', NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_NW251004_LI2', 'Amount', 1),
('MODIFIER_TRAIT_LEADER_NW251004_LI2', 'Corps', 0),
('MODIFIER_TRAIT_LEADER_NW251004_LI2', 'Domain', 'DOMAIN_LAND');
INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_LEADER_NW251004', 'MODIFIER_TRAIT_LEADER_NW251004_LI3');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_LEADER_NW251004_LI3', 'MODIFIER_PLAYER_CORPS_ARMY_MODIFIED_STRENGTH', 0, 0, 0, 'NW_PLAYER_HAS_CIVIC_URBANIZATION', NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_NW251004_LI3', 'Amount', 1),
('MODIFIER_TRAIT_LEADER_NW251004_LI3', 'Corps', 1),
('MODIFIER_TRAIT_LEADER_NW251004_LI3', 'Domain', 'DOMAIN_LAND');
INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_LEADER_NW251004', 'MODIFIER_TRAIT_LEADER_NW251004_LI4');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_LEADER_NW251004_LI4', 'MODIFIER_PLAYER_CORPS_ARMY_MODIFIED_STRENGTH', 0, 0, 0, 'NW_PLAYER_HAS_CIVIC_URBANIZATION', NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_NW251004_LI4', 'Amount', 1),
('MODIFIER_TRAIT_LEADER_NW251004_LI4', 'Corps', 0),
('MODIFIER_TRAIT_LEADER_NW251004_LI4', 'Domain', 'DOMAIN_LAND');


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

-- 可更早组建军团（需军事学科技）和军队（需民族主义市政）。

INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_LEADER_NW251004', 'MODIFIER_TRAIT_LEADER_NW251004_JSX_JT');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_LEADER_NW251004_JSX_JT', 'MODIFIER_PLAYER_CORPS_ARMY_PREREQ', 0, 0, 0, 'REQS_NW_PLAYER_HAS_JSX', NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_NW251004_JSX_JT', 'CivicType', 'CIVIC_CODE_OF_LAWS'),
('MODIFIER_TRAIT_LEADER_NW251004_JSX_JT', 'Corps', 'true'),
('MODIFIER_TRAIT_LEADER_NW251004_JSX_JT', 'Domain', 'DOMAIN_LAND');
-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('REQS_NW_PLAYER_HAS_JSX', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('REQS_NW_PLAYER_HAS_JSX', 'REQ_NW_PLAYER_HAS_JSX');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('REQ_NW_PLAYER_HAS_JSX', 'REQUIREMENT_PLAYER_HAS_TECHNOLOGY');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('REQ_NW_PLAYER_HAS_JSX', 'TechnologyType', 'TECH_MILITARY_SCIENCE');


INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_LEADER_NW251004', 'MODIFIER_TRAIT_LEADER_NW251004_MZ_JD');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_LEADER_NW251004_MZ_JD', 'MODIFIER_PLAYER_CORPS_ARMY_PREREQ', 0, 0, 0, NULL, NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_NW251004_MZ_JD', 'CivicType', 'CIVIC_NATIONALISM'),
('MODIFIER_TRAIT_LEADER_NW251004_MZ_JD', 'Corps', 'false'),
('MODIFIER_TRAIT_LEADER_NW251004_MZ_JD', 'Domain', 'DOMAIN_LAND');

