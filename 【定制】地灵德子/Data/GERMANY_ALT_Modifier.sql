--  FILE: GERMANY_ALT_Modifier.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/23 9:28:58

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
VALUES ('TRAIT_CIVILIZATION_IMPERIAL_FREE_CITIES'),
       ('TRAIT_LEADER_HOLY_ROMAN_EMPEROR_ALT');

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
-- 继承原效果
INSERT OR IGNORE INTO TraitModifiers(TraitType, ModifierId)
SELECT 'TRAIT_LEADER_HOLY_ROMAN_EMPEROR_ALT',
       ModifierId
FROM TraitModifiers
WHERE TraitType = 'TRAIT_LEADER_HOLY_ROMAN_EMPEROR';

-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('NW_LEADER_IS_BBLS_ALT', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('NW_LEADER_IS_BBLS_ALT', 'REQ_NW_LEADER_IS_BBLS_ALT');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('REQ_NW_LEADER_IS_BBLS_ALT', 'REQUIREMENT_PLAYER_LEADER_TYPE_MATCHES');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('REQ_NW_LEADER_IS_BBLS_ALT', 'LeaderType', 'LEADER_BARBAROSSA_ALT');

--------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 地灵契约
--------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 买地-40%
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_BELIEF_KONGBAI_BUY_20_MODIFIER', 'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER', 0, 0, 0, NULL,
        'PLAYER_HAS_PANTHEON_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_BELIEF_KONGBAI_BUY_20_MODIFIER', 'ModifierId', 'MODIFIER_BELIEF_KONGBAI_BUY_20');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_BELIEF_KONGBAI_BUY_20', 'MODIFIER_PLAYER_CITIES_ADJUST_PLOT_PURCHASE_COST', 0, 0, 0,
        'NW_LEADER_IS_BBLS_ALT', NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_BELIEF_KONGBAI_BUY_20', 'Amount', '-40');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_BELIEF_KONGBAI_BUY_40_MODIFIER', 'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER', 0, 0, 0, NULL,
        'PLAYER_HAS_PANTHEON_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_BELIEF_KONGBAI_BUY_40_MODIFIER', 'ModifierId', 'MODIFIER_BELIEF_KONGBAI_BUY_40');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_BELIEF_KONGBAI_BUY_40', 'MODIFIER_PLAYER_CITIES_ADJUST_PLOT_PURCHASE_COST', 0, 0, 0,
        'NW_LEADER_IS_BBLS_ALT', 'REQ_BELIEF_KONGBAI_HAS_TECH_REQ');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_BELIEF_KONGBAI_BUY_40', 'Amount', '-15');
-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('REQ_BELIEF_KONGBAI_HAS_TECH_REQ', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('REQ_BELIEF_KONGBAI_HAS_TECH_REQ', 'REQ_BELIEF_KONGBAI_HAS_TECH');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('REQ_BELIEF_KONGBAI_HAS_TECH', 'REQUIREMENT_PLAYER_HAS_TECHNOLOGY');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('REQ_BELIEF_KONGBAI_HAS_TECH', 'TechnologyType', 'TECH_PRINTING');
-- 每个特色区域+1金币
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_BELIEF_KONGBAI_GOLD_MODIFIER', 'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER', 0, 0, 0, NULL,
        'PLAYER_HAS_PANTHEON_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_BELIEF_KONGBAI_GOLD_MODIFIER', 'ModifierId', 'MODIFIER_BELIEF_KONGBAI_GOLD');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_BELIEF_KONGBAI_GOLD', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_PER_DISTRICT', 0, 0, 0,
        'NW_LEADER_IS_BBLS_ALT', NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_BELIEF_KONGBAI_GOLD', 'Amount', '1'),
       ('MODIFIER_BELIEF_KONGBAI_GOLD', 'YieldType', 'YIELD_GOLD');

--============================================================
-- 空白万神
INSERT OR IGNORE INTO Types(Type, Kind)
VALUES ('BELIEF_KONGBAI', 'KIND_BELIEF');
INSERT OR IGNORE INTO Beliefs(BeliefType, Name, Description, BeliefClassType)
VALUES ('BELIEF_KONGBAI', 'LOC_BELIEF_KONGBAI_NAME', 'LOC_BELIEF_KONGBAI_DESCRIPTION', 'BELIEF_CLASS_PANTHEON');

INSERT OR IGNORE INTO Types(Type, Kind)
VALUES ('BELIEF_KONGBAI2', 'KIND_BELIEF');
INSERT OR IGNORE INTO Beliefs(BeliefType, Name, Description, BeliefClassType)
VALUES ('BELIEF_KONGBAI2', 'LOC_BELIEF_KONGBAI_NAME', 'LOC_BELIEF_KONGBAI_DESCRIPTION', 'BELIEF_CLASS_PANTHEON');

INSERT OR IGNORE INTO Types(Type, Kind)
VALUES ('BELIEF_KONGBAI3', 'KIND_BELIEF');
INSERT OR IGNORE INTO Beliefs(BeliefType, Name, Description, BeliefClassType)
VALUES ('BELIEF_KONGBAI3', 'LOC_BELIEF_KONGBAI_NAME', 'LOC_BELIEF_KONGBAI_DESCRIPTION', 'BELIEF_CLASS_PANTHEON');

INSERT OR IGNORE INTO Types(Type, Kind)
VALUES ('BELIEF_KONGBAI4', 'KIND_BELIEF');
INSERT OR IGNORE INTO Beliefs(BeliefType, Name, Description, BeliefClassType)
VALUES ('BELIEF_KONGBAI4', 'LOC_BELIEF_KONGBAI_NAME', 'LOC_BELIEF_KONGBAI_DESCRIPTION', 'BELIEF_CLASS_PANTHEON');

INSERT OR IGNORE INTO Types(Type, Kind)
VALUES ('BELIEF_KONGBAI5', 'KIND_BELIEF');
INSERT OR IGNORE INTO Beliefs(BeliefType, Name, Description, BeliefClassType)
VALUES ('BELIEF_KONGBAI5', 'LOC_BELIEF_KONGBAI_NAME', 'LOC_BELIEF_KONGBAI_DESCRIPTION', 'BELIEF_CLASS_PANTHEON');

INSERT OR IGNORE INTO Types(Type, Kind)
VALUES ('BELIEF_KONGBAI6', 'KIND_BELIEF');
INSERT OR IGNORE INTO Beliefs(BeliefType, Name, Description, BeliefClassType)
VALUES ('BELIEF_KONGBAI6', 'LOC_BELIEF_KONGBAI_NAME', 'LOC_BELIEF_KONGBAI_DESCRIPTION', 'BELIEF_CLASS_PANTHEON');


INSERT INTO BeliefModifiers (BeliefType, ModifierId)
VALUES ('BELIEF_KONGBAI', 'MODIFIER_BELIEF_KONGBAI_BUY_20_MODIFIER'),
       ('BELIEF_KONGBAI2', 'MODIFIER_BELIEF_KONGBAI_BUY_20_MODIFIER'),
       ('BELIEF_KONGBAI3', 'MODIFIER_BELIEF_KONGBAI_BUY_20_MODIFIER'),
       ('BELIEF_KONGBAI4', 'MODIFIER_BELIEF_KONGBAI_BUY_20_MODIFIER'),
       ('BELIEF_KONGBAI5', 'MODIFIER_BELIEF_KONGBAI_BUY_20_MODIFIER'),
       ('BELIEF_KONGBAI6', 'MODIFIER_BELIEF_KONGBAI_BUY_20_MODIFIER'),
       ('BELIEF_KONGBAI', 'MODIFIER_BELIEF_KONGBAI_BUY_40_MODIFIER'),
       ('BELIEF_KONGBAI2', 'MODIFIER_BELIEF_KONGBAI_BUY_40_MODIFIER'),
       ('BELIEF_KONGBAI3', 'MODIFIER_BELIEF_KONGBAI_BUY_40_MODIFIER'),
       ('BELIEF_KONGBAI4', 'MODIFIER_BELIEF_KONGBAI_BUY_40_MODIFIER'),
       ('BELIEF_KONGBAI5', 'MODIFIER_BELIEF_KONGBAI_BUY_40_MODIFIER'),
       ('BELIEF_KONGBAI6', 'MODIFIER_BELIEF_KONGBAI_BUY_40_MODIFIER'),
       ('BELIEF_KONGBAI', 'MODIFIER_BELIEF_KONGBAI_GOLD_MODIFIER'),
       ('BELIEF_KONGBAI2', 'MODIFIER_BELIEF_KONGBAI_GOLD_MODIFIER'),
       ('BELIEF_KONGBAI3', 'MODIFIER_BELIEF_KONGBAI_GOLD_MODIFIER'),
       ('BELIEF_KONGBAI4', 'MODIFIER_BELIEF_KONGBAI_GOLD_MODIFIER'),
       ('BELIEF_KONGBAI5', 'MODIFIER_BELIEF_KONGBAI_GOLD_MODIFIER'),
       ('BELIEF_KONGBAI6', 'MODIFIER_BELIEF_KONGBAI_GOLD_MODIFIER');