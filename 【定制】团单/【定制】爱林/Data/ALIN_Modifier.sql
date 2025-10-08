--  FILE: NewLeader2_Modifier.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/10/3 11:23:08

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
VALUES ('TRAIT_LEADER_NW_L0011_LEADER_AILIN');

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

-- 政治哲学市政后，已拥有的雨林单元格提供+1魅力值，而非通常的-1。
-- INSERT INTO TraitModifiers (TraitType, ModifierId)
-- VALUES ('TRAIT_LEADER_NW_L0011_LEADER_AILIN', 'TRAIT_LEADER_NW_L0011_LEADER_AILIN_MEILI');
-- INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
--                        SubjectRequirementSetId)
-- VALUES ('TRAIT_LEADER_NW_L0011_LEADER_AILIN_MEILI', 'MODIFIER_PLAYER_CITIES_ADJUST_FEATURE_APPEAL_MODIFIER', 0, 0, 0,
--         'REQS_NW_TRAIT_LEADER_NW_L0011_LEADER_AILIN_ZZZX', NULL);
-- INSERT INTO ModifierArguments (ModifierId, Name, Value)
-- VALUES ('TRAIT_LEADER_NW_L0011_LEADER_AILIN_MEILI', 'Amount', '2'),
--        ('TRAIT_LEADER_NW_L0011_LEADER_AILIN_MEILI', 'FeatureType', 'FEATURE_JUNGLE');
--
-- INSERT INTO Requirements (RequirementId, RequirementType)
-- VALUES ('REQ_NW_TRAIT_LEADER_NW_L0011_LEADER_AILIN_ZZZX', 'REQUIREMENT_PLAYER_HAS_CIVIC');
-- INSERT INTO RequirementArguments (RequirementId, Name, Value)
-- VALUES ('REQ_NW_TRAIT_LEADER_NW_L0011_LEADER_AILIN_ZZZX', 'CivicType', 'CIVIC_POLITICAL_PHILOSOPHY');
-- INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
-- VALUES ('REQS_NW_TRAIT_LEADER_NW_L0011_LEADER_AILIN_ZZZX', 'REQUIREMENTSET_TEST_ALL');
-- INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
-- VALUES ('REQS_NW_TRAIT_LEADER_NW_L0011_LEADER_AILIN_ZZZX',
--         'REQ_NW_TRAIT_LEADER_NW_L0011_LEADER_AILIN_ZZZX');

-- 惊艳的沼泽或雨林+1 [ICON_FOOD] 食物。

INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES ('TRAIT_LEADER_NW_L0011_LEADER_AILIN', 'TRAIT_LEADER_NW_L0011_LEADER_AILIN_FOOD');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('TRAIT_LEADER_NW_L0011_LEADER_AILIN_FOOD', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 0, 0, 0, NULL,
        'REQS_TRAIT_LEADER_NW_L0011_LEADER_AILIN_FOOD');

INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('TRAIT_LEADER_NW_L0011_LEADER_AILIN_FOOD', 'Amount', '1'),
       ('TRAIT_LEADER_NW_L0011_LEADER_AILIN_FOOD', 'YieldType', 'YIELD_FOOD');

-- RequirementSets

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('REQS_TRAIT_LEADER_NW_L0011_LEADER_AILIN_FOOD', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('REQS_TRAIT_LEADER_NW_L0011_LEADER_AILIN_FOOD', 'REQ_TRAIT_LEADER_NW_L0011_LEADER_AILIN_FOOD1'),
       ('REQS_TRAIT_LEADER_NW_L0011_LEADER_AILIN_FOOD', 'REQ_TRAIT_LEADER_NW_L0011_LEADER_AILIN_FOOD2');

-- Requirements

INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('REQ_TRAIT_LEADER_NW_L0011_LEADER_AILIN_FOOD1', 'REQUIREMENT_PLOT_IS_APPEAL_BETWEEN'),
       ('REQ_TRAIT_LEADER_NW_L0011_LEADER_AILIN_FOOD2', 'REQUIREMENT_PLOT_FEATURE_TAG_MATCHES');

INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('REQ_TRAIT_LEADER_NW_L0011_LEADER_AILIN_FOOD1', 'MinimumAppeal', '4'),
       ('REQ_TRAIT_LEADER_NW_L0011_LEADER_AILIN_FOOD2', 'Tag', 'CLASS_FEATURE_LEADER_AILIN');

INSERT INTO Tags(Tag, Vocabulary)
VALUES ('CLASS_FEATURE_LEADER_AILIN', 'FEATURE_CLASS');

INSERT INTO TypeTags (Type, Tag)
VALUES ('FEATURE_JUNGLE', 'CLASS_FEATURE_LEADER_AILIN'),
       ('FEATURE_MARSH', 'CLASS_FEATURE_LEADER_AILIN');

-- 如果城市尚无圣地，则魅力值至少为5的森林+1 [ICON_PRODUCTION] 生产力。

INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES ('TRAIT_LEADER_NW_L0011_LEADER_AILIN', 'TRAIT_LEADER_NW_L0011_LEADER_AILIN_PRODUCTION');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('TRAIT_LEADER_NW_L0011_LEADER_AILIN_PRODUCTION', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 0, 0, 0, NULL,
        'CITY_HAS_NOT_HOLY_AND_MELI5');

INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('TRAIT_LEADER_NW_L0011_LEADER_AILIN_PRODUCTION', 'Amount', '1'),
       ('TRAIT_LEADER_NW_L0011_LEADER_AILIN_PRODUCTION', 'YieldType', 'YIELD_PRODUCTION');

-- RequirementSets

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('CITY_HAS_NOT_HOLY_AND_MELI5', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('CITY_HAS_NOT_HOLY_AND_MELI5', 'REQ_NW_CITY_HASNT_DISTRICT_HOLY_SITE'),
       ('CITY_HAS_NOT_HOLY_AND_MELI5', 'REQ_NW_MELI5'),
       ('CITY_HAS_NOT_HOLY_AND_MELI5', 'REQ_XARHKIW0');

-- Requirements

INSERT INTO Requirements (RequirementId, RequirementType, Inverse)
VALUES ('REQ_NW_CITY_HASNT_DISTRICT_HOLY_SITE', 'REQUIREMENT_CITY_HAS_DISTRICT', 1),
       ('REQ_NW_MELI5', 'REQUIREMENT_PLOT_IS_APPEAL_BETWEEN', 0),
       ('REQ_XARHKIW0', 'REQUIREMENT_PLOT_FEATURE_TYPE_MATCHES', 0);

INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('REQ_NW_CITY_HASNT_DISTRICT_HOLY_SITE', 'DistrictType', 'DISTRICT_HOLY_SITE'),
       ('REQ_NW_MELI5', 'MinimumAppeal', '5'),
       ('REQ_XARHKIW0', 'FeatureType', 'FEATURE_FOREST');


-- 如果城市拥有圣地，则惊艳的森林单元格+1[ICON_FAITH]信仰值，土木工程市政后变为+2，保护地球市政后变为+3。

INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES ('TRAIT_LEADER_NW_L0011_LEADER_AILIN', 'TRAIT_LEADER_NW_L0011_LEADER_AILIN_FAITH1');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('TRAIT_LEADER_NW_L0011_LEADER_AILIN_FAITH1', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 0, 0, 0, NULL,
        'CITY_HAS_HOLY_AND_MELI5');

INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('TRAIT_LEADER_NW_L0011_LEADER_AILIN_FAITH1', 'Amount', '1'),
       ('TRAIT_LEADER_NW_L0011_LEADER_AILIN_FAITH1', 'YieldType', 'YIELD_FAITH');

-- RequirementSets

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('CITY_HAS_HOLY_AND_MELI5', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('CITY_HAS_HOLY_AND_MELI5', 'REQ_NW_AL_CITY_HAS_DISTRICT_HOLY_SITE'),
       ('CITY_HAS_HOLY_AND_MELI5', 'REQ_TRAIT_LEADER_NW_L0011_LEADER_AILIN_FOOD1'),
       ('CITY_HAS_HOLY_AND_MELI5', 'REQ_XARHKIW0');

-- Requirements

INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('REQ_NW_AL_CITY_HAS_DISTRICT_HOLY_SITE', 'REQUIREMENT_CITY_HAS_DISTRICT');

INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('REQ_NW_AL_CITY_HAS_DISTRICT_HOLY_SITE', 'DistrictType', 'DISTRICT_HOLY_SITE');



INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES ('TRAIT_LEADER_NW_L0011_LEADER_AILIN', 'TRAIT_LEADER_NW_L0011_LEADER_AILIN_FAITH2');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('TRAIT_LEADER_NW_L0011_LEADER_AILIN_FAITH2', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 0, 0, 0,
        'REQS_NW_PLAYER_HAS_CIVIC_CIVIL_ENGINEERING', 'CITY_HAS_HOLY_AND_MELI5');

INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('TRAIT_LEADER_NW_L0011_LEADER_AILIN_FAITH2', 'Amount', '1'),
       ('TRAIT_LEADER_NW_L0011_LEADER_AILIN_FAITH2', 'YieldType', 'YIELD_FAITH');

-- RequirementSets

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('REQS_NW_PLAYER_HAS_CIVIC_CIVIL_ENGINEERING', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('REQS_NW_PLAYER_HAS_CIVIC_CIVIL_ENGINEERING', 'REQ_NW_PLAYER_HAS_CIVIC_CIVIL_ENGINEERING');

-- Requirements

INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('REQ_NW_PLAYER_HAS_CIVIC_CIVIL_ENGINEERING', 'REQUIREMENT_PLAYER_HAS_CIVIC');

INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('REQ_NW_PLAYER_HAS_CIVIC_CIVIL_ENGINEERING', 'CivicType', 'CIVIC_CIVIL_ENGINEERING');



INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES ('TRAIT_LEADER_NW_L0011_LEADER_AILIN', 'TRAIT_LEADER_NW_L0011_LEADER_AILIN_FAITH3');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('TRAIT_LEADER_NW_L0011_LEADER_AILIN_FAITH3', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 0, 0, 0,
        'REQS_NW_PLAYER_HAS_CIVIC_CONSERVATION', 'CITY_HAS_HOLY_AND_MELI5');

INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('TRAIT_LEADER_NW_L0011_LEADER_AILIN_FAITH3', 'Amount', '1'),
       ('TRAIT_LEADER_NW_L0011_LEADER_AILIN_FAITH3', 'YieldType', 'YIELD_FAITH');

-- RequirementSets

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('REQS_NW_PLAYER_HAS_CIVIC_CONSERVATION', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('REQS_NW_PLAYER_HAS_CIVIC_CONSERVATION', 'REQ_NW_PLAYER_HAS_CIVIC_CONSERVATION');

-- Requirements

INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('REQ_NW_PLAYER_HAS_CIVIC_CONSERVATION', 'REQUIREMENT_PLAYER_HAS_CIVIC');

INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('REQ_NW_PLAYER_HAS_CIVIC_CONSERVATION', 'CivicType', 'CIVIC_CONSERVATION');

-- 单位在沼泽、雨林和森林上开始回合时，+1 [ICON_MOVEMENT] 移动力。
INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES ('TRAIT_LEADER_NW_L0011_LEADER_AILIN', 'TRAIT_LEADER_NW_L0011_LEADER_AILIN_MOVEMENT');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('TRAIT_LEADER_NW_L0011_LEADER_AILIN_MOVEMENT', 'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT', 0, 0, 0, NULL,
        'UNIT_IS_IN_THE_FEATURE_NW_ALIN');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('TRAIT_LEADER_NW_L0011_LEADER_AILIN_MOVEMENT', 'Amount', '1');

-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('UNIT_IS_IN_THE_FEATURE_NW_ALIN', 'REQUIREMENTSET_TEST_ANY');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('UNIT_IS_IN_THE_FEATURE_NW_ALIN', 'UNIT_IS_IN_THE_FEATURE_JUNGLE'),
       ('UNIT_IS_IN_THE_FEATURE_NW_ALIN', 'UNIT_IS_IN_THE_FEATURE_MARSH'),
       ('UNIT_IS_IN_THE_FEATURE_NW_ALIN', 'UNIT_IS_IN_THE_FEATURE_FOREST');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('UNIT_IS_IN_THE_FEATURE_JUNGLE', 'REQUIREMENT_PLOT_FEATURE_TYPE_MATCHES'),
       ('UNIT_IS_IN_THE_FEATURE_MARSH', 'REQUIREMENT_PLOT_FEATURE_TYPE_MATCHES'),
       ('UNIT_IS_IN_THE_FEATURE_FOREST', 'REQUIREMENT_PLOT_FEATURE_TYPE_MATCHES');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('UNIT_IS_IN_THE_FEATURE_JUNGLE', 'FeatureType', 'FEATURE_JUNGLE'),
       ('UNIT_IS_IN_THE_FEATURE_MARSH', 'FeatureType', 'FEATURE_MARSH'),
       ('UNIT_IS_IN_THE_FEATURE_FOREST', 'FeatureType', 'FEATURE_FOREST');
