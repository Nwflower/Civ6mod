--     FILE: CIVILIZATION_LUNA_Districts.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--     Copyright (c) 2025.
--     All rights reserved.
--  DateCreated: 2025/9/2 16:15:28
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT INTO Types(Type, Kind)
VALUES ('DISTRICT_MOON_BAY', 'KIND_DISTRICT');
INSERT INTO DistrictReplaces(CivUniqueDistrictType, ReplacesDistrictType)
VALUES ('DISTRICT_MOON_BAY', 'DISTRICT_HARBOR');

-- 继承属性 但半价
INSERT INTO Districts(DistrictType, TraitType, Name, Description, PrereqCivic, PrereqTech, CitizenSlots, PlunderType,
                      OnePerCity, PlunderAmount, AdvisorType, Cost, CostProgressionModel, CostProgressionParam1,
                      Maintenance, Housing, RequiresPlacement, RequiresPopulation, Aqueduct, NoAdjacentCity,
                      InternalOnly, ZOC, HitPoints, Entertainment, CaptureRemovesBuildings, CaptureRemovesCityDefenses,
                      MilitaryDomain, Appeal, AllowsHolyCity, TravelTime, CityStrengthModifier, MaxPerPlayer,
                      CaptureRemovesDistrict,Coast)
SELECT 'DISTRICT_MOON_BAY',
       'TRAIT_DISTRICT_MOON_BAY',
       'LOC_DISTRICT_MOON_BAY_NAME',
       'LOC_DISTRICT_MOON_BAY_DESCRIPTION',
       PrereqCivic,
       PrereqTech,
       CitizenSlots,
       PlunderType,
       OnePerCity,
       PlunderAmount,
       AdvisorType,
       Cost / 2.5,
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
       Coast
FROM Districts
WHERE DistrictType = 'DISTRICT_HARBOR';

-- 继承商路收益、公民产出、伟人点产出、特殊效果和相邻加成
INSERT INTO District_TradeRouteYields(DistrictType, YieldType, YieldChangeAsOrigin, YieldChangeAsDomesticDestination,
                                      YieldChangeAsInternationalDestination)
SELECT 'DISTRICT_MOON_BAY',
       YieldType,
       YieldChangeAsOrigin,
       YieldChangeAsDomesticDestination,
       YieldChangeAsInternationalDestination
FROM District_TradeRouteYields
WHERE DistrictType = 'DISTRICT_HARBOR';

INSERT INTO District_CitizenYieldChanges(DistrictType, YieldType, YieldChange)
SELECT 'DISTRICT_MOON_BAY',
       YieldType,
       YieldChange
FROM District_CitizenYieldChanges
WHERE DistrictType = 'DISTRICT_HARBOR';

INSERT INTO District_GreatPersonPoints(DistrictType, GreatPersonClassType, PointsPerTurn)
SELECT 'DISTRICT_MOON_BAY',
       GreatPersonClassType,
       PointsPerTurn
FROM District_GreatPersonPoints
WHERE DistrictType = 'DISTRICT_HARBOR';

INSERT INTO DistrictModifiers(DistrictType, ModifierId)
SELECT 'DISTRICT_MOON_BAY',
       ModifierId
FROM DistrictModifiers
WHERE DistrictType = 'DISTRICT_HARBOR';

INSERT INTO District_Adjacencies(DistrictType, YieldChangeId)
SELECT 'DISTRICT_MOON_BAY',
       YieldChangeId
FROM District_Adjacencies
WHERE DistrictType = 'DISTRICT_HARBOR';

INSERT INTO Adjacency_YieldChanges(ID, Description, YieldType, YieldChange, AdjacentDistrict)
VALUES ('NW_City_DISTRICT_MOON_BAY', 'LOC_DISTRICT_MOON_BAY_GOLD', 'YIELD_GOLD', 2, 'DISTRICT_MOON_BAY');
INSERT INTO District_Adjacencies(DistrictType, YieldChangeId)
VALUES ('DISTRICT_COMMERCIAL_HUB','NW_City_DISTRICT_MOON_BAY');


INSERT INTO DistrictModifiers(DistrictType, ModifierId)VALUES
('DISTRICT_MOON_BAY', 'MODIFIER_TRAIT_LEADER_LUNA_TRAIT_YIELD_CULTURE');
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
('MODIFIER_TRAIT_LEADER_LUNA_TRAIT_YIELD_CULTURE', 'MODIFIER_SINGLE_CITY_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_LUNA_TRAIT_YIELD_CULTURE', 'Amount', '1'),
('MODIFIER_TRAIT_LEADER_LUNA_TRAIT_YIELD_CULTURE', 'YieldType', 'YIELD_CULTURE');


-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('REQ_SET_NW_PLAYER_HAS_CIVIC_MERCANTILISM', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('REQ_SET_NW_PLAYER_HAS_CIVIC_MERCANTILISM', 'REQ_NW_PLAYER_HAS_CIVIC_MERCANTILISM');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('REQ_NW_PLAYER_HAS_CIVIC_MERCANTILISM', 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('REQ_NW_PLAYER_HAS_CIVIC_MERCANTILISM', 'CivicType', 'CIVIC_MERCANTILISM');

INSERT INTO DistrictModifiers(DistrictType, ModifierId)VALUES
('DISTRICT_MOON_BAY', 'MODIFIER_TRAIT_LEADER_LUNA_TRAIT_YIELD_GOLD');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_LEADER_LUNA_TRAIT_YIELD_GOLD', 'MODIFIER_SINGLE_CITY_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL', 0, 0, 0, 'REQ_SET_NW_PLAYER_HAS_CIVIC_MERCANTILISM', NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_LUNA_TRAIT_YIELD_GOLD', 'Amount', '4'),
('MODIFIER_TRAIT_LEADER_LUNA_TRAIT_YIELD_GOLD', 'YieldType', 'YIELD_GOLD');