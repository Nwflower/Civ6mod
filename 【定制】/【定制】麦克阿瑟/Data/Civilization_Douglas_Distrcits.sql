--     FILE: Civilization_Douglas_Districts.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--     Copyright (c) 2025.
--     All rights reserved.
--  DateCreated: 2025/9/14 10:32:02
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT INTO Types(Type, Kind)
VALUES ('DISTRICT_AMERICAN_CAMP', 'KIND_DISTRICT');
INSERT INTO DistrictReplaces(CivUniqueDistrictType, ReplacesDistrictType)
VALUES ('DISTRICT_AMERICAN_CAMP', 'DISTRICT_HARBOR');

-- 继承属性 但半价
INSERT INTO Districts(DistrictType, TraitType, Name, Description, PrereqCivic, PrereqTech, CitizenSlots, PlunderType,
                      OnePerCity, PlunderAmount, AdvisorType, Cost, CostProgressionModel, CostProgressionParam1,
                      Maintenance, Housing, RequiresPlacement, RequiresPopulation, Aqueduct, NoAdjacentCity,
                      InternalOnly, ZOC, HitPoints, Entertainment, CaptureRemovesBuildings, CaptureRemovesCityDefenses,
                      MilitaryDomain, Appeal, AllowsHolyCity, TravelTime, CityStrengthModifier, MaxPerPlayer,
                      CaptureRemovesDistrict,Coast,AdjacentToLand,FreeEmbark)
SELECT 'DISTRICT_AMERICAN_CAMP',
       'TRAIT_DISTRICT_AMERICAN_CAMP',
       'LOC_DISTRICT_AMERICAN_CAMP_NAME',
       'LOC_DISTRICT_AMERICAN_CAMP_DESCRIPTION',
       PrereqCivic,
       PrereqTech,
       CitizenSlots,
       PlunderType,
       OnePerCity,
       PlunderAmount,
       AdvisorType,
       Cost /2,
       CostProgressionModel,
       CostProgressionParam1,
       Maintenance,
       Housing,
       RequiresPlacement,
       RequiresPopulation,
       Aqueduct,
       NoAdjacentCity,
       InternalOnly,
       ZOC,
       HitPoints,
       Entertainment,
       CaptureRemovesBuildings,
       CaptureRemovesCityDefenses,
       MilitaryDomain,
       Appeal,
       AllowsHolyCity,
       TravelTime,
       CityStrengthModifier,
       MaxPerPlayer,
       CaptureRemovesDistrict,
       Coast,
       AdjacentToLand,
       FreeEmbark
FROM Districts
WHERE DistrictType = 'DISTRICT_HARBOR';


-- 继承商路收益、公民产出、伟人点产出、特殊效果和相邻加成
INSERT INTO District_TradeRouteYields(DistrictType, YieldType, YieldChangeAsOrigin, YieldChangeAsDomesticDestination,
                                      YieldChangeAsInternationalDestination)
SELECT 'DISTRICT_AMERICAN_CAMP',
       YieldType,
       YieldChangeAsOrigin,
       YieldChangeAsDomesticDestination,
       YieldChangeAsInternationalDestination
FROM District_TradeRouteYields
WHERE DistrictType = 'DISTRICT_HARBOR';

INSERT INTO District_CitizenYieldChanges(DistrictType, YieldType, YieldChange)
SELECT 'DISTRICT_AMERICAN_CAMP',
       YieldType,
       YieldChange
FROM District_CitizenYieldChanges
WHERE DistrictType = 'DISTRICT_HARBOR';

INSERT INTO District_GreatPersonPoints(DistrictType, GreatPersonClassType, PointsPerTurn)
SELECT 'DISTRICT_AMERICAN_CAMP',
       GreatPersonClassType,
       PointsPerTurn
FROM District_GreatPersonPoints
WHERE DistrictType = 'DISTRICT_HARBOR';

INSERT INTO DistrictModifiers(DistrictType, ModifierId)
SELECT 'DISTRICT_AMERICAN_CAMP',
       ModifierId
FROM DistrictModifiers
WHERE DistrictType = 'DISTRICT_HARBOR';


INSERT INTO Adjacency_YieldChanges(ID, Description, YieldType, YieldChange, AdjacentDistrict)
VALUES ('NW_DISTRICT_AMERICAN_CAMP_YIELD_GOLD', 'LOC_NW_DISTRICT_AMERICAN_CAMP_YIELD_GOLD', 'YIELD_GOLD', 2, 'DISTRICT_AMERICAN_CAMP');

INSERT INTO District_Adjacencies(DistrictType, YieldChangeId)
VALUES('DISTRICT_COMMERCIAL_HUB', 'NW_DISTRICT_AMERICAN_CAMP_YIELD_GOLD');

INSERT INTO District_Adjacencies(DistrictType, YieldChangeId)
SELECT DISTINCT 'DISTRICT_AMERICAN_CAMP',
                YieldChangeId
FROM District_Adjacencies
WHERE DistrictType = 'DISTRICT_HARBOR';


INSERT OR IGNORE INTO Types(Type, Kind)
VALUES ( 'ABILITY_NW_001_4','KIND_ABILITY');
INSERT OR IGNORE INTO TypeTags(Type,Tag)
VALUES ('ABILITY_NW_001_4','CLASS_NAVAL_MELEE'),
       ('ABILITY_NW_001_4','CLASS_NAVAL_RANGED'),
       ('ABILITY_NW_001_4','CLASS_NAVAL_RAIDER'),
       ('ABILITY_NW_001_4','CLASS_NAVAL_CARRIER');
INSERT OR IGNORE INTO UnitAbilities(UnitAbilityType,Inactive,Name,Description)
VALUES ( 'ABILITY_NW_001_4', 1 ,'LOC_ABILITY_NW_001_4_NAME','LOC_ABILITY_NW_001_4_NAME');

INSERT INTO DistrictModifiers (DistrictType, ModifierId) VALUES
('DISTRICT_AMERICAN_CAMP', 'MODIFIER_DISTRICT_AMERICAN_CAMP_DIS_WEIHU');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_DISTRICT_AMERICAN_CAMP_DIS_WEIHU', 'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_DISTRICT_AMERICAN_CAMP_DIS_WEIHU', 'AbilityType', 'ABILITY_NW_001_4');

INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
('ABILITY_NW_001_4', 'MODIFIER_TRAIT_DISTRICT_AMERICAN_CAMP');
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
('MODIFIER_TRAIT_DISTRICT_AMERICAN_CAMP', 'MODIFIER_PLAYER_ADJUST_YIELD_CHANGE');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_DISTRICT_AMERICAN_CAMP', 'Amount', '1'),
('MODIFIER_TRAIT_DISTRICT_AMERICAN_CAMP', 'YieldType', 'YIELD_GOLD');

INSERT INTO DistrictModifiers (DistrictType, ModifierId) VALUES
('DISTRICT_AMERICAN_CAMP', 'MODIFIER_DISTRICT_AMERICAN_CAMP_ADD_PROD');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_DISTRICT_AMERICAN_CAMP_ADD_PROD', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_PRODUCTION', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_DISTRICT_AMERICAN_CAMP_ADD_PROD', 'Amount', '50'),
('MODIFIER_DISTRICT_AMERICAN_CAMP_ADD_PROD', 'UnitType', 'UNIT_NIMIZI_HANGMU');


INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
('ABILITY_NW_001_4', 'MODIFIER_ABILITY_NW_001_4_MOVEMENT');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_ABILITY_NW_001_4_MOVEMENT', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 0, 0, 0, NULL, 'REQSET_NW_006');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_ABILITY_NW_001_4_MOVEMENT', 'Amount', '2');
-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('REQSET_NW_006', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('REQSET_NW_006', 'REQ_NW_006_1');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('REQ_NW_006_1', 'REQUIREMENT_UNIT_PROMOTION_CLASS_MATCHES');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('REQ_NW_006_1', 'UnitPromotionClass', 'PROMOTION_CLASS_NAVAL_CARRIER');

