--  FILE: CIVILIZATION_GUMOON_Modifier.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/24 19:28:22

--============================================================
-- Lua Support
--============================================================
CREATE TABLE IF NOT EXISTS Nwflower_MOD_Traits(
TraitType TEXT NOT NULL,
PRIMARY KEY (TraitType),
FOREIGN KEY (TraitType) REFERENCES Traits (TraitType) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT OR IGNORE INTO Nwflower_MOD_Traits(TraitType) VALUES
('TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE'),
('TRAIT_LEADER_ZHIZUN');

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
-- 改良设施+2 [ICON_PRODUCTION] 生产力、+1 [ICON_GOLD] 金币。

INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_LEADER_ZHIZUN', 'MODIFIER_TRAIT_LEADER_ZHIZUN1');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_LEADER_ZHIZUN1', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 0, 0, 0, NULL, 'REQS_MODIFIER_TRAIT_LEADER_ZHIZUN1');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_ZHIZUN1', 'Amount', '2,1'),
('MODIFIER_TRAIT_LEADER_ZHIZUN1', 'YieldType', 'YIELD_PRODUCTION, YIELD_GOLD');

-- RequirementSets

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('REQS_MODIFIER_TRAIT_LEADER_ZHIZUN1', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('REQS_MODIFIER_TRAIT_LEADER_ZHIZUN1', 'REQ_MODIFIER_TRAIT_LEADER_ZHIZUN1');

-- Requirements

INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('REQ_MODIFIER_TRAIT_LEADER_ZHIZUN1', 'REQUIREMENT_PLOT_HAS_ANY_IMPROVEMENT');


-- 奢侈品+1 [ICON_PRODUCTION] 生产力、+1 [ICON_GOLD] 金币，相邻的改良设施+1 [ICON_PRODUCTION] 生产力、+1 [ICON_GOLD] 金币。
INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_LEADER_ZHIZUN', 'MODIFIER_TRAIT_LEADER_ZHIZUN3');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_LEADER_ZHIZUN3', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 0, 0, 0, NULL, 'REQS_MODIFIER_TRAIT_LEADER_ZHIZUN3');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_ZHIZUN3', 'Amount', '1,1'),
('MODIFIER_TRAIT_LEADER_ZHIZUN3', 'YieldType', 'YIELD_PRODUCTION, YIELD_GOLD');
-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('REQS_MODIFIER_TRAIT_LEADER_ZHIZUN3', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('REQS_MODIFIER_TRAIT_LEADER_ZHIZUN3', 'REQ_MODIFIER_TRAIT_LEADER_ZHIZUN3');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('REQ_MODIFIER_TRAIT_LEADER_ZHIZUN3', 'REQUIREMENT_PLOT_RESOURCE_CLASS_TYPE_MATCHES');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('REQ_MODIFIER_TRAIT_LEADER_ZHIZUN3', 'ResourceClassType', 'RESOURCECLASS_LUXURY');


INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_LEADER_ZHIZUN', 'MODIFIER_TRAIT_LEADER_ZHIZUN2');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_LEADER_ZHIZUN2', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 0, 0, 0, NULL, 'REQS_MODIFIER_TRAIT_LEADER_ZHIZUN2');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_ZHIZUN2', 'Amount', '1,1'),
('MODIFIER_TRAIT_LEADER_ZHIZUN2', 'YieldType', 'YIELD_PRODUCTION, YIELD_GOLD');

-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('REQS_MODIFIER_TRAIT_LEADER_ZHIZUN2', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('REQS_MODIFIER_TRAIT_LEADER_ZHIZUN2', 'REQ_MODIFIER_TRAIT_LEADER_ZHIZUN1'),
('REQS_MODIFIER_TRAIT_LEADER_ZHIZUN2', 'REQ_MODIFIER_TRAIT_LEADER_ZHIZUN2');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('REQ_MODIFIER_TRAIT_LEADER_ZHIZUN2', 'REQUIREMENT_PLOT_ANY_ADJACENT_RESOURCE');

-- 每拥有一种不同资源提升1% [ICON_PRODUCTION] 生产力。
INSERT INTO TraitModifiers (TraitType, ModifierId) SELECT
'TRAIT_LEADER_ZHIZUN', 'MODIFIER_TRAIT_LEADER_ZHIZUN_FROM_'||ResourceType
FROM Resources;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) SELECT
'MODIFIER_TRAIT_LEADER_ZHIZUN_FROM_'||ResourceType, 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', 'REQS_MODIFIER_TRAIT_LEADER_ZHIZUN_HAS'||ResourceType
FROM Resources;
INSERT INTO ModifierArguments (ModifierId, Name, Value) SELECT
'MODIFIER_TRAIT_LEADER_ZHIZUN_FROM_'||ResourceType, 'Amount', '1'
FROM Resources UNION SELECT
'MODIFIER_TRAIT_LEADER_ZHIZUN_FROM_'||ResourceType, 'YieldType', 'YIELD_PRODUCTION'
FROM Resources;

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) SELECT
'REQS_MODIFIER_TRAIT_LEADER_ZHIZUN_HAS'||ResourceType, 'REQUIREMENTSET_TEST_ALL'
FROM Resources;
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) SELECT
'REQS_MODIFIER_TRAIT_LEADER_ZHIZUN_HAS'||ResourceType, 'REQ_MODIFIER_TRAIT_LEADER_ZHIZUN_HAS'||ResourceType
FROM Resources;
INSERT INTO Requirements (RequirementId, RequirementType) SELECT
'REQ_MODIFIER_TRAIT_LEADER_ZHIZUN_HAS'||ResourceType, 'REQUIREMENT_PLAYER_HAS_RESOURCE_IMPROVED'
FROM Resources;
INSERT INTO RequirementArguments (RequirementId, Name, Value) SELECT
'REQ_MODIFIER_TRAIT_LEADER_ZHIZUN_HAS'||ResourceType, 'ResourceType', ResourceType
FROM Resources;

--============================================================
-- 获取单元格速度加快50%。四元方悔血炼池使建造区域和奇观时+25% [ICON_PRODUCTION] 生产力；每有一座奇观和自然奇观为首都+2 [ICON_PRODUCTION] 生产力、+2 [ICON_SCIENCE] 科技值。
insert or
replace
into Types
    (Type, Kind)
values ('MODIFIER_NW_250924_CITIES_CULTURE_BORDER_EXPANSION', 'KIND_MODIFIER');

insert or
replace
into DynamicModifiers
    (ModifierType, CollectionType, EffectType)
values ('MODIFIER_NW_250924_CITIES_CULTURE_BORDER_EXPANSION', 'COLLECTION_PLAYER_CITIES',
        'EFFECT_ADJUST_CITY_CULTURE_BORDER_EXPANSION');


INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE', 'MODIFIER_TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE_BORDER_EXPANSION');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE_BORDER_EXPANSION', 'MODIFIER_NW_250924_CITIES_CULTURE_BORDER_EXPANSION', 0, 0, 0, NULL, NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE_BORDER_EXPANSION', 'Amount', '50');


INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE', 'MODIFIER_TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE_1');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE_1', 'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION_MODIFIER', 0, 0, 0, NULL, NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE_1', 'Amount', '25');

INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE', 'MODIFIER_TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE_2');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE_2', 'MODIFIER_PLAYER_CITIES_ADJUST_WONDER_PRODUCTION', 0, 0, 0, NULL, NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE_2', 'Amount', '25');



INSERT INTO TraitModifiers (TraitType, ModifierId) SELECT
'TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE', 'MODIFIER_TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE_'||BuildingType
FROM Buildings WHERE IsWonder = 1;

INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) SELECT
'MODIFIER_TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE_'||BuildingType, 'MODIFIER_PLAYER_CAPITAL_CITY_ADJUST_CITY_YIELD_CHANGE',  'REQS_PLAYER_HAS_WONDER_'||BuildingType
FROM Buildings WHERE IsWonder = 1;

INSERT INTO ModifierArguments (ModifierId, Name, Value) SELECT
'MODIFIER_TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE_'||BuildingType, 'Amount', '2'
FROM Buildings WHERE IsWonder = 1 UNION SELECT
'MODIFIER_TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE_'||BuildingType, 'YieldType', 'YIELD_PRODUCTION'
FROM Buildings WHERE IsWonder = 1;

INSERT INTO TraitModifiers (TraitType, ModifierId) SELECT
'TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE', 'MODIFIER_TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE_2'||BuildingType
FROM Buildings WHERE IsWonder = 1;

INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) SELECT
'MODIFIER_TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE_2'||BuildingType, 'MODIFIER_PLAYER_CAPITAL_CITY_ADJUST_CITY_YIELD_CHANGE',  'REQS_PLAYER_HAS_WONDER_'||BuildingType
FROM Buildings WHERE IsWonder = 1;

INSERT INTO ModifierArguments (ModifierId, Name, Value) SELECT
'MODIFIER_TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE_2'||BuildingType, 'Amount', '2'
FROM Buildings WHERE IsWonder = 1 UNION SELECT
'MODIFIER_TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE_2'||BuildingType, 'YieldType', 'YIELD_SCIENCE'
FROM Buildings WHERE IsWonder = 1;


INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) SELECT
'REQS_PLAYER_HAS_WONDER_'||BuildingType, 'REQUIREMENTSET_TEST_ALL'
FROM Buildings WHERE IsWonder = 1;
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) SELECT
'REQS_PLAYER_HAS_WONDER_'||BuildingType, 'REQ_PLAYER_HAS_WONDER_'||BuildingType
FROM Buildings WHERE IsWonder = 1;
INSERT INTO Requirements (RequirementId, RequirementType) SELECT
'REQ_PLAYER_HAS_WONDER_'||BuildingType, 'REQUIREMENT_PLAYER_HAS_BUILDING'
FROM Buildings WHERE IsWonder = 1;
INSERT INTO RequirementArguments (RequirementId, Name, Value) SELECT
'REQ_PLAYER_HAS_WONDER_'||BuildingType, 'BuildingType', BuildingType
FROM Buildings WHERE IsWonder = 1;


INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE', 'MODIFIER_TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE_UNIT_UNLOCK');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE_UNIT_UNLOCK', 'MODIFIER_PLAYER_UNITS_ADJUST_VALID_TERRAIN', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE_UNIT_UNLOCK', 'TerrainType', 'TERRAIN_COAST'),
('MODIFIER_TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE_UNIT_UNLOCK', 'Valid', '1');
