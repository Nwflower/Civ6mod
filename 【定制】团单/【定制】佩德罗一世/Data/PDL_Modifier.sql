--  FILE: PDL_Modifier.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/10/5 12:10:26

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
VALUES ('TRAIT_LEADER_NW251004_PDL');

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

-- 位于雨林的单位+2 [ICON_Strength] 战斗力。街头狂欢节+2 [ICON_FOOD]食物、+1[ICON_HOUSING]住房。

INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES ('TRAIT_LEADER_NW251004_PDL', 'PDL_COMBAT_FROM_JUNGLE');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('PDL_COMBAT_FROM_JUNGLE', 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH', 0, 0, 0, NULL, 'REQS_NW_PDL_UNIT_JUNGLE');

INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('PDL_COMBAT_FROM_JUNGLE', 'Amount', '2');

INSERT INTO ModifierStrings (ModifierId, Context, Text)
VALUES ('PDL_COMBAT_FROM_JUNGLE', 'Preview', 'LOC_PDL_COMBAT_FROM_JUNGLE');

-- RequirementSets

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('REQS_NW_PDL_UNIT_JUNGLE', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('REQS_NW_PDL_UNIT_JUNGLE', 'REQ_NW_PDL_UNIT_JUNGLE');

-- Requirements

INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('REQ_NW_PDL_UNIT_JUNGLE', 'REQUIREMENT_PLOT_FEATURE_TYPE_MATCHES');

INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('REQ_NW_PDL_UNIT_JUNGLE', 'FeatureType', 'FEATURE_JUNGLE');



INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES ('TRAIT_LEADER_NW251004_PDL', 'TRAIT_LEADER_NW251004_PDL_HOUSING');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('TRAIT_LEADER_NW251004_PDL_HOUSING', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_HOUSING', 0, 0, 0, NULL,
        'REQS_NW_DISTRICT_IS_STREET_CARNIVAL');

INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('TRAIT_LEADER_NW251004_PDL_HOUSING', 'Amount', '1');

INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES ('TRAIT_LEADER_NW251004_PDL', 'TRAIT_LEADER_NW251004_PDL_FOOD');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('TRAIT_LEADER_NW251004_PDL_FOOD', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE', 0, 0, 0, NULL,
        'REQS_NW_DISTRICT_IS_STREET_CARNIVAL');

INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('TRAIT_LEADER_NW251004_PDL_FOOD', 'Amount', '2'),
       ('TRAIT_LEADER_NW251004_PDL_FOOD', 'YieldType', 'YIELD_FOOD');

-- RequirementSets

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('REQS_NW_DISTRICT_IS_STREET_CARNIVAL', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('REQS_NW_DISTRICT_IS_STREET_CARNIVAL', 'REQ_NW_DISTRICT_IS_STREET_CARNIVAL');

-- Requirements

INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('REQ_NW_DISTRICT_IS_STREET_CARNIVAL', 'REQUIREMENT_DISTRICT_TYPE_MATCHES');

INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('REQ_NW_DISTRICT_IS_STREET_CARNIVAL', 'DistrictType', 'DISTRICT_STREET_CARNIVAL');

