------------------------------------------------------------------------------
--	FILE: TPMG_Merchant.sql
--  VERSION: 1
--	PURPOSE: Team PVP More Great Merchant
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
VALUES ('GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_CLASSICAL_1', 'GREAT_PERSON_CLASS_MERCHANT', 'ERA_CLASSICAL'),
       ('GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_CLASSICAL_2', 'GREAT_PERSON_CLASS_MERCHANT', 'ERA_CLASSICAL'),
       ('GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_MEDIEVAL_1', 'GREAT_PERSON_CLASS_MERCHANT', 'ERA_MEDIEVAL'),
       ('GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_MEDIEVAL_2', 'GREAT_PERSON_CLASS_MERCHANT', 'ERA_MEDIEVAL'),
       ('GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_RENAISSANCE_1', 'GREAT_PERSON_CLASS_MERCHANT', 'ERA_RENAISSANCE'),
       ('GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_RENAISSANCE_2', 'GREAT_PERSON_CLASS_MERCHANT', 'ERA_RENAISSANCE'),
       ('GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_INDUSTRIAL_1', 'GREAT_PERSON_CLASS_MERCHANT', 'ERA_INDUSTRIAL'),
       ('GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_INDUSTRIAL_2', 'GREAT_PERSON_CLASS_MERCHANT', 'ERA_INDUSTRIAL');

INSERT INTO Types (Type, Kind)
SELECT GreatPersonIndividualType, 'KIND_GREAT_PERSON_INDIVIDUAL'
FROM NW_GreatPersonClass
WHERE GreatPersonClassType = 'GREAT_PERSON_CLASS_MERCHANT';



-- ======================================================
-- 大商人
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
WHERE GreatPersonClassType = 'GREAT_PERSON_CLASS_MERCHANT';

-- 需要奢侈品
UPDATE GreatPersonIndividuals
SET ActionRequiresVisibleLuxury = 1,
    ActionRequiresOwnedTile = 0
WHERE GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_RENAISSANCE_1';

-- 需要城邦
UPDATE GreatPersonIndividuals
SET ActionRequiresCityStateTerritory  = 1,
    ActionRequiresOwnedTile = 0
WHERE GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_INDUSTRIAL_2';


UPDATE GreatPersonIndividuals
SET ActionRequiresCompletedDistrictType='DISTRICT_COMMERCIAL_HUB'
WHERE GreatPersonIndividualType IN (
                                    'GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_CLASSICAL_1',
                                    'GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_CLASSICAL_2',
                                    'GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_MEDIEVAL_1',
                                    'GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_MEDIEVAL_2',
                                    'GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_RENAISSANCE_2',
                                    'GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_INDUSTRIAL_1'
    );


-- 1 立即建造一个市场，市场+2 [ICON_GOLD] 金币。
INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
VALUES ('GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_CLASSICAL_1', 'MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_CLASSICAL_1',
        'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_CLASSICAL_1',
        'MODIFIER_SINGLE_CITY_GRANT_BUILDING_IN_CITY_IGNORE', 1, 1, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_CLASSICAL_1', 'BuildingType', 'BUILDING_MARKET');

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId)
VALUES ('GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_CLASSICAL_1',
        'MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_CLASSICAL_1_2');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_CLASSICAL_1_2',
        'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_CLASSICAL_1_2', 'Amount', 1),
       ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_CLASSICAL_1_2', 'BuildingType', 'BUILDING_MARKET'),
       ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_CLASSICAL_1_2', 'YieldType', 'YIELD_GOLD');


-- 3 +1 [ICON_TradeRoute] 贸易路线容量，+1 [ICON_ENVOY] 使者。
INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId)
VALUES ('GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_MEDIEVAL_1', 'MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_MEDIEVAL_1_1');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_MEDIEVAL_1_1', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY', 1,
        1, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_MEDIEVAL_1_1', 'Amount', '1');

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId)
VALUES ('GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_MEDIEVAL_1', 'MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_MEDIEVAL_1_2');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_MEDIEVAL_1_2', 'MODIFIER_PLAYER_GRANT_INFLUENCE_TOKEN', 1, 1, 0,
        NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_MEDIEVAL_1_2', 'Amount', '1');



-- 5  在选定的奢侈品单元格上激活，赠予一份该奢侈品给您的首都。
-- 该奢侈品将重复提供宜居度。(LUA)
INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
VALUES ('GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_RENAISSANCE_1',
        'MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_RENAISSANCE_1',
        'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_UNIT_GREATPERSON');
INSERT INTO Modifiers (ModifierId, ModifierType)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_RENAISSANCE_1',
        'MODIFIER_PLAYER_GRANT_FREE_RESOURCE_FROM_UNIT_PLOT');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_RENAISSANCE_1', 'Amount', 1);


-- 为每个奢侈品资源插入修改器定义
INSERT INTO Modifiers (ModifierId, ModifierType)
SELECT 'MODIFIER_PLAYER_GRANT_REPEAT_RESOURCE_AMEN_' || ResourceType, 'MODIFIER_PLAYER_ADJUST_NO_CAP_RESOURCE'
FROM Resources WHERE ResourceClassType = 'RESOURCECLASS_LUXURY';

-- 为每个修改器添加资源类型参数
INSERT INTO ModifierArguments (ModifierId, Name, Value)
SELECT 'MODIFIER_PLAYER_GRANT_REPEAT_RESOURCE_AMEN_' || ResourceType, 'ResourceType', ResourceType
FROM Resources WHERE ResourceClassType = 'RESOURCECLASS_LUXURY';


-- 7 +1 [ICON_TradeRoute] 贸易路线容量。改良后的 [ICON_RESOURCE_IRON] 铁资源+3 [ICON_GOLD] 金币。
INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId)
VALUES ('GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_INDUSTRIAL_1',
        'MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_INDUSTRIAL_1_1');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_INDUSTRIAL_1_1', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY', 1,
        1, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_INDUSTRIAL_1_1', 'Amount', '1');

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId)
VALUES ('GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_INDUSTRIAL_1',
        'MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_INDUSTRIAL_1_2');
INSERT INTO Modifiers (ModifierId, ModifierType)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_INDUSTRIAL_1_2', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_INDUSTRIAL_1_2', 'ModifierId',
        'MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_INDUSTRIAL_1_2A');
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_INDUSTRIAL_1_2A', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',
        'REQS_NW_TMPG_PLOT_HAS_IRON');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_INDUSTRIAL_1_2A', 'Amount', '3'),
       ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_INDUSTRIAL_1_2A', 'YieldType', 'YIELD_GOLD');

-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('REQS_NW_TMPG_PLOT_HAS_IRON', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('REQS_NW_TMPG_PLOT_HAS_IRON', 'REQ_NW_TMPG_PLOT_HAS_IRON'),
       ('REQS_NW_TMPG_PLOT_HAS_IRON', 'REQ_NW_TMPG_PLOT_HAS_ANY_IM');

-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('REQ_NW_TMPG_PLOT_HAS_IRON', 'REQUIREMENT_PLOT_RESOURCE_TYPE_MATCHES'),
       ('REQ_NW_TMPG_PLOT_HAS_ANY_IM', 'REQUIREMENT_PLOT_HAS_ANY_IMPROVEMENT');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('REQ_NW_TMPG_PLOT_HAS_IRON', 'ResourceType', 'RESOURCE_IRON');


DELETE FROM Types WHERE Type IN (
        'GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_CLASSICAL_2',
        'GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_MEDIEVAL_2',
        'GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_RENAISSANCE_2',
        'GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_INDUSTRIAL_2',
        'GREAT_PERSON_INDIVIDUAL_RAJA_TODAR_MAL',
        'GREAT_PERSON_INDIVIDUAL_ZHOU_DAGUAN',
        'GREAT_PERSON_INDIVIDUAL_JOHN_JACOB_ASTOR','GREAT_PERSON_INDIVIDUAL_MARY_KATHERINE_GODDARD','GREAT_PERSON_INDIVIDUAL_STAMFORD_RAFFLES');