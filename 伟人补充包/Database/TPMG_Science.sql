------------------------------------------------------------------------------
--	FILE: TPMG_SCIENTIST.sql
--  VERSION: 1
--	PURPOSE: Team PVP More Great SCIENTIST
------------------------------------------------------------------------------
--	Copyright (c) 2025 Nwflower.
--	All rights reserved.
------------------------------------------------------------------------------

-- TPMG Files Support

CREATE TABLE IF NOT EXISTS NW_GreatPersonClass
(
    GreatPersonIndividualType TEXT NOT NULL,
    GreatPersonClassType      TEXT NOT NULL,
    EraType                   TEXT NOT NULL,
    GreatWorksNum             INTEGER DEFAULT 0,
    PRIMARY KEY (GreatPersonIndividualType)
);
INSERT INTO NW_GreatPersonClass(GreatPersonIndividualType, GreatPersonClassType, EraType)
VALUES ('GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_CLASSICAL_1', 'GREAT_PERSON_CLASS_SCIENTIST', 'ERA_CLASSICAL'),
       ('GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_CLASSICAL_2', 'GREAT_PERSON_CLASS_SCIENTIST', 'ERA_CLASSICAL'),
       ('GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MEDIEVAL_1', 'GREAT_PERSON_CLASS_SCIENTIST', 'ERA_MEDIEVAL'),
       ('GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MEDIEVAL_2', 'GREAT_PERSON_CLASS_SCIENTIST', 'ERA_MEDIEVAL'),
       ('GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_RENAISSANCE_1', 'GREAT_PERSON_CLASS_SCIENTIST', 'ERA_RENAISSANCE'),
       ('GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_RENAISSANCE_2', 'GREAT_PERSON_CLASS_SCIENTIST', 'ERA_RENAISSANCE'),
       ('GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_INDUSTRIAL_1', 'GREAT_PERSON_CLASS_SCIENTIST', 'ERA_INDUSTRIAL'),
       ('GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_INDUSTRIAL_2', 'GREAT_PERSON_CLASS_SCIENTIST', 'ERA_INDUSTRIAL'),
       ('GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MODERN_1', 'GREAT_PERSON_CLASS_SCIENTIST', 'ERA_MODERN'),
       ('GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MODERN_2', 'GREAT_PERSON_CLASS_SCIENTIST', 'ERA_MODERN');

INSERT INTO Types (Type, Kind)
SELECT GreatPersonIndividualType, 'KIND_GREAT_PERSON_INDIVIDUAL'
FROM NW_GreatPersonClass
WHERE GreatPersonClassType = 'GREAT_PERSON_CLASS_SCIENTIST';



-- ======================================================
-- 大科学家
-- ======================================================

INSERT INTO GreatPersonIndividuals(GreatPersonIndividualType, Name, GreatPersonClassType, EraType, Gender,
                                   ActionCharges, ActionRequiresOwnedTile,
                                   ActionEffectTileHighlighting, ActionEffectTextOverride)
SELECT GreatPersonIndividualType,
       'LOC_' || GreatPersonIndividualType || '_NAME',
       GreatPersonClassType,
       EraType,
       'M',
       1,
       1,
       1,
       'LOC_MODIFIER_' || GreatPersonIndividualType
FROM NW_GreatPersonClass
WHERE GreatPersonClassType = 'GREAT_PERSON_CLASS_SCIENTIST';

-- 需要学院
UPDATE GreatPersonIndividuals
SET ActionRequiresCompletedDistrictType='DISTRICT_CAMPUS'
WHERE GreatPersonIndividualType IN (
                                    'GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_CLASSICAL_2',
                                    'GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MEDIEVAL_1',
                                    'GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MEDIEVAL_2',
                                    'GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_RENAISSANCE_1',
                                    'GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_RENAISSANCE_2',
                                    'GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_INDUSTRIAL_1',
                                    'GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_INDUSTRIAL_2',
                                    'GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MODERN_1',
                                    'GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MODERN_2'
    );


-- 1 Y 九章算术
INSERT INTO Types (Type, Kind)
VALUES ('GREATWORK_NW_SCIENTIST_CLASSICAL_1', 'KIND_GREATWORK');

UPDATE GreatPersonIndividuals SET ActionCharges = 0 WHERE GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_CLASSICAL_1';

INSERT INTO GreatWorks
(GreatWorkType, GreatWorkObjectType, GreatPersonIndividualType, Name, Quote, Tourism, Audio)
VALUES ('GREATWORK_NW_SCIENTIST_CLASSICAL_1', 'GREATWORKOBJECT_WRITING',
        'GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_CLASSICAL_1', 'LOC_GREATWORK_NW_SCIENTIST_CLASSICAL_1_NAME',
        'LOC_GREATWORK_NW_SCIENTIST_CLASSICAL_1_QUOTE', 4, '');

INSERT INTO GreatWork_YieldChanges (GreatWorkType, YieldType, YieldChange)
VALUES ('GREATWORK_NW_SCIENTIST_CLASSICAL_1', 'YIELD_SCIENCE', 4);

-- 2 Y 为机械和1个随机中世纪科技启动尤里卡时刻。

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId)
VALUES ('GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_CLASSICAL_2',
        'MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_CLASSICAL_2_1');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_CLASSICAL_2_1', 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECH_BOOST', 1,
        1, 0, NULL, NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_CLASSICAL_2_1', 'TechType', 'TECH_MACHINERY');

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId)
VALUES ('GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_CLASSICAL_2',
        'MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_CLASSICAL_2_2');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_CLASSICAL_2_2',
        'MODIFIER_PLAYER_GRANT_RANDOM_TECHNOLOGY_BOOST_BY_ERA', 1, 1, 0, NULL, NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_CLASSICAL_2_2', 'Amount', '1'),
       ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_CLASSICAL_2_2', 'EndEraType', 'ERA_MEDIEVAL'),
       ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_CLASSICAL_2_2', 'StartEraType', 'ERA_MEDIEVAL');

-- 3 Y 尤里卡提供额外2%进度。
INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId)
VALUES ('GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MEDIEVAL_1', 'MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MEDIEVAL_1');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MEDIEVAL_1', 'MODIFIER_PLAYER_ADJUST_TECHNOLOGY_BOOST', 1, 1, 0,
        NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MEDIEVAL_1', 'Amount', '2');

-- 4 Y 在学院上激活。该学院的科技值相邻加成也提供生产力。
INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType) VALUES
('GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MEDIEVAL_2', 'MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MEDIEVAL_2', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MEDIEVAL_2', 'MODIFIER_PLAYER_DISTRICT_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS', 1, 1, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MEDIEVAL_2', 'YieldTypeToGrant', 'YIELD_PRODUCTION'),
('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MEDIEVAL_2', 'YieldTypeToMirror', 'YIELD_SCIENCE');


-- 5 Y 为卫生科技启动尤里卡时刻，获得1个医疗兵。
INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId)
VALUES ('GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_RENAISSANCE_1',
        'MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_RENAISSANCE_1_1');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_RENAISSANCE_1_1', 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECH_BOOST', 1,
        1, 0, NULL, NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_RENAISSANCE_1_1', 'TechType', 'TECH_SANITATION');


INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId) VALUES
('GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_RENAISSANCE_1', 'MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_RENAISSANCE_1_2');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_RENAISSANCE_1_2', 'MODIFIER_PLAYER_GRANT_UNIT_IN_CAPITAL', 1, 1, 0, NULL, NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_RENAISSANCE_1_2', 'AllowUniqueOverride', '1'),
('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_RENAISSANCE_1_2', 'Amount', '1'),
('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_RENAISSANCE_1_2', 'UnitType', 'UNIT_MEDIC');


-- 6 Y 为所有文艺复兴时期的科技启动尤里卡时刻。
INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId)
VALUES ('GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_RENAISSANCE_2',
        'MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_RENAISSANCE_2');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_RENAISSANCE_2',
        'MODIFIER_PLAYER_GRANT_RANDOM_TECHNOLOGY_BOOST_BY_ERA', 1, 1, 0, NULL, NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_RENAISSANCE_2', 'Amount', (SELECT COUNT(TechnologyType) FROM Technologies WHERE EraType = 'ERA_RENAISSANCE')),
       ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_RENAISSANCE_2', 'EndEraType', 'ERA_RENAISSANCE'),
       ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_RENAISSANCE_2', 'StartEraType', 'ERA_RENAISSANCE');

-- 7 Y 为工业化启动尤里卡时刻，若已有尤里卡则解锁工业化科技。
INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId) VALUES
('GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_INDUSTRIAL_1', 'MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_INDUSTRIAL_1');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_INDUSTRIAL_1', 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECH_BOOST', 1, 1, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_INDUSTRIAL_1', 'TechType', 'TECH_INDUSTRIALIZATION'),
('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_INDUSTRIAL_1', 'GrantTechIfBoosted', 1);

-- 8 Y 立即获得1次当前回合的科技值产出。(LUA) 2次
UPDATE GreatPersonIndividuals SET ActionCharges = 2 WHERE GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_INDUSTRIAL_2';


-- 9 忽视普通科技要求，显示铀。所有战略资源改良设施+1每回合战略资源累计。
UPDATE GreatPersonIndividuals SET Gender = 'F' WHERE GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MODERN_1';
INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId) VALUES
('GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MODERN_1', 'MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MODERN_1_1');
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MODERN_1_1', 'MODIFIER_PLAYER_GRANT_FREE_RESOURCE_VISIBILITY');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MODERN_1_1', 'ResourceType', 'RESOURCE_URANIUM');

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId) VALUES
('GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MODERN_1', 'MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MODERN_1_2');
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MODERN_1_2', 'MODIFIER_PLAYER_CITIES_ADJUST_EXTRA_ACCUMULATION');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MODERN_1_2', 'Amount', '1');

-- 10 为无线电启动尤里卡时刻。若已有尤里卡则解锁无线电科技。
INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId) VALUES
('GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MODERN_2', 'MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MODERN_2_1');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MODERN_2_1', 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECH_BOOST', 1, 1, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MODERN_2_1', 'TechType', 'TECH_RADIO'),
('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_MODERN_2_1', 'GrantTechIfBoosted', 1);