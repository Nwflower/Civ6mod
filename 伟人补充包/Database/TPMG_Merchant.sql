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

-- 2 所有贸易路线+1 [ICON_GOLD] 金币。
INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId)
VALUES ('GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_CLASSICAL_2', 'MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_CLASSICAL_2');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_CLASSICAL_2', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD', 0, 0, 0,
        NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_CLASSICAL_2', 'Amount', '1'),
       ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_CLASSICAL_2', 'YieldType', 'YIELD_GOLD');

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


-- 4 己方领土内或靠近己方领土的商人单位免遭掠夺
INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId)
VALUES ('GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_MEDIEVAL_2', 'MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_MEDIEVAL_2_1');
INSERT INTO Modifiers (ModifierId, ModifierType)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_MEDIEVAL_2_1', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_MEDIEVAL_2_1', 'AbilityType',
        'ABILITY_NW_TMPG_TR_PLUNDER_IMMUNITY');

-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('REQS_NW_TPMG_UNIT_IN_OWNER_TERRITORY', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('REQS_NW_TPMG_UNIT_IN_OWNER_TERRITORY', 'REQ_NW_TPMG_UNIT_IN_OWNER_TERRITORY');

-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('REQ_NW_TPMG_UNIT_IN_OWNER_TERRITORY', 'REQUIREMENT_UNIT_IN_OWNER_TERRITORY');

INSERT OR IGNORE INTO Types(Type, Kind)
VALUES ('ABILITY_NW_TMPG_TR_PLUNDER_IMMUNITY', 'KIND_ABILITY');
INSERT OR IGNORE INTO TypeTags(Type, Tag)
VALUES ('ABILITY_NW_TMPG_TR_PLUNDER_IMMUNITY', 'CLASS_TRADER');
INSERT OR IGNORE INTO UnitAbilities(UnitAbilityType, Inactive, Name, Description)
VALUES ('ABILITY_NW_TMPG_TR_PLUNDER_IMMUNITY', 1, 'LOC_ABILITY_NW_TMPG_TR_PLUNDER_IMMUNITY_NAME',
        'LOC_ABILITY_NW_TMPG_TR_PLUNDER_IMMUNITY_NAME');

INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
('ABILITY_NW_TMPG_TR_PLUNDER_IMMUNITY', 'MODIFIER_ABILITY_NW_TMPG_TR_PLUNDER_IMMUNITY');
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
('MODIFIER_ABILITY_NW_TMPG_TR_PLUNDER_IMMUNITY', 'MODIFIER_PLAYER_UNIT_ADJUST_TRADE_ROUTE_PLUNDER_IMMUNITY');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_ABILITY_NW_TMPG_TR_PLUNDER_IMMUNITY', 'DomainType', 'DOMAIN_LAND');


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


-- 6  每个回合开始时，+2%国库 [ICON_GOLD] 金币。
INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId)
VALUES ('GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_RENAISSANCE_2',
        'MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_RENAISSANCE_2');
INSERT INTO Modifiers (ModifierId, ModifierType)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_RENAISSANCE_2', 'MODIFIER_PLAYER_ADJUST_GOLD_INTEREST_PERCENT');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_RENAISSANCE_2', 'Percent', 2);

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

-- 8  顾维钧:在城邦领土内激活。为玩家提供该城邦的宗主国能力
INSERT INTO GreatPersonIndividualBirthModifiers(GreatPersonIndividualType, ModifierId)
SELECT 'GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_INDUSTRIAL_2', ModifierId
FROM GreatPersonIndividualBirthModifiers
WHERE GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_ZHOU_DAGUAN';
------------------------------------------------------
-- 建表：将Trait对应的终端Modifier标记出来
-- Spacial Thanks: Pen's Team Suzerain
------------------------------------------------------
CREATE TABLE IF NOT EXISTS NW_TMPG_SUZERAIN (
	LeaderType			TEXT	NOT NULL,
	ModifierId			TEXT	NOT NULL,
    PRIMARY KEY (LeaderType, ModifierId)
);

INSERT OR REPLACE INTO NW_TMPG_SUZERAIN (LeaderType, ModifierId)
SELECT l.LeaderType,ma.Value
FROM Leaders l JOIN LeaderTraits lt JOIN TraitModifiers tm JOIN Modifiers m JOIN ModifierArguments ma JOIN RequirementSetRequirements RSR
ON l.LeaderType = lt.LeaderType
AND lt.TraitType = tm.TraitType
AND m.ModifierId = tm.ModifierId
AND m.ModifierId = ma.ModifierId
AND RSR.RequirementSetId = m.SubjectRequirementSetId
WHERE l.InheritFrom LIKE 'LEADER/_MINOR/_CIV/_%' ESCAPE '/'
AND ma.Name = 'ModifierId'
AND RSR.RequirementId IN (SELECT RequirementId FROM Requirements WHERE RequirementType = 'REQUIREMENT_PLAYER_IS_SUZERAIN');
