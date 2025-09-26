--  FILE: NewLeader3_Modifier.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/22 21:48:22

--============================================================
-- Lua Support
--============================================================
CREATE TABLE IF NOT EXISTS Nwflower_MOD_Traits(
TraitType TEXT NOT NULL,
PRIMARY KEY (TraitType),
FOREIGN KEY (TraitType) REFERENCES Traits (TraitType) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT OR IGNORE INTO Nwflower_MOD_Traits(TraitType) VALUES
('TRAIT_CIVILIZATION_CIV_NW_0003_NW007'),
('TRAIT_LEADER_NW008');

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

INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_LEADER_NW008', 'MODIFIER_TRAIT_LEADER_NW008_ALWAYS_LOYAL');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_LEADER_NW008_ALWAYS_LOYAL', 'MODIFIER_PLAYER_CITIES_ADJUST_ALWAYS_LOYAL', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_NW008_ALWAYS_LOYAL', 'AlwaysLoyal', '1');


INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_LEADER_NW008', 'MODIFIER_TRAIT_LEADER_NW008_UNIT_FAITH_PURCHASE');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_LEADER_NW008_UNIT_FAITH_PURCHASE', 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_NW008_UNIT_FAITH_PURCHASE', 'Tag', 'CLASS_HEAVY_CAVALRY');


--============================================================

INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_CIVILIZATION_CIV_NW_0003_NW007', 'MODIFIER_TRAIT_LEADER_NW008_ADD_MOVE_AB');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_LEADER_NW008_ADD_MOVE_AB', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 0, 1, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_NW008_ADD_MOVE_AB', 'AbilityType', 'AB_MODIFIER_TRAIT_LEADER_NW008_ADD_MOVE');


INSERT OR IGNORE INTO Types(Type, Kind)
VALUES ( 'AB_MODIFIER_TRAIT_LEADER_NW008_ADD_MOVE','KIND_ABILITY');
INSERT OR IGNORE INTO Tags(Tag, Vocabulary)
VALUES ('NW_CLASS_AB_MODIFIER_TRAIT_LEADER_NW008_ADD_MOVE','ABILITY_CLASS');
INSERT OR IGNORE INTO TypeTags(Type,Tag)
VALUES ('AB_MODIFIER_TRAIT_LEADER_NW008_ADD_MOVE','NW_CLASS_AB_MODIFIER_TRAIT_LEADER_NW008_ADD_MOVE'),
       ('UNIT_SETTLER','NW_CLASS_AB_MODIFIER_TRAIT_LEADER_NW008_ADD_MOVE');
INSERT OR IGNORE INTO UnitAbilities(UnitAbilityType,Inactive,Name,Description)
VALUES ( 'AB_MODIFIER_TRAIT_LEADER_NW008_ADD_MOVE', 1 ,'LOC_AB_MODIFIER_TRAIT_LEADER_NW008_ADD_MOVE_NAME','LOC_AB_MODIFIER_TRAIT_LEADER_NW008_ADD_MOVE_NAME');

INSERT OR IGNORE INTO UnitAbilityModifiers(UnitAbilityType,ModifierId)
VALUES ( 'AB_MODIFIER_TRAIT_LEADER_NW008_ADD_MOVE', 'MODIFIER_TRAIT_LEADER_NW008_ADD_MOVE');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_LEADER_NW008_ADD_MOVE', 'MODIFIER_SINGLE_UNIT_ATTACH_MODIFIER', 0, 0, 0, 'ORS_PLAYER_HAS_PALACE', 'ON_TURN_STARTED');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_NW008_ADD_MOVE', 'ModifierId', 'MODIFIER_TRAIT_LEADER_NW008_ADD_MOVE_ATTACH');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_LEADER_NW008_ADD_MOVE_ATTACH', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_NW008_ADD_MOVE_ATTACH', 'Amount', '1');

INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
('AB_MODIFIER_TRAIT_LEADER_NW008_ADD_MOVE', 'MODIFIER_TRAIT_LEADER_NW008_ADD_MOVE_DEBUFF');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_LEADER_NW008_ADD_MOVE_DEBUFF', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 0, 0, 0, 'ORS_PLAYER_HAS_PALACE', NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_NW008_ADD_MOVE_DEBUFF', 'Amount', '-1');


-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('ORS_PLAYER_HAS_PALACE', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('ORS_PLAYER_HAS_PALACE', 'REQ_N008_PLAYER_HAS_PALACE');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('REQ_N008_PLAYER_HAS_PALACE', 'REQUIREMENT_PLAYER_HAS_BUILDING');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('REQ_N008_PLAYER_HAS_PALACE', 'BuildingType', 'BUILDING_PALACE');




--============================================================
