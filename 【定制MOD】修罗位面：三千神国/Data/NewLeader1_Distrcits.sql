--     FILE: NewLeader1_Districts.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--     Copyright (c) 2025.
--     All rights reserved.
--  DateCreated: 2025/9/2 15:46:23
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT INTO Types(Type, Kind)
VALUES ('DISTRICT_XULINGTA', 'KIND_DISTRICT');
INSERT INTO DistrictReplaces(CivUniqueDistrictType, ReplacesDistrictType)
VALUES ('DISTRICT_XULINGTA', 'DISTRICT_INDUSTRIAL_ZONE');

-- 继承属性 但半价
INSERT INTO Districts(DistrictType, TraitType, Name, Description, PrereqCivic, PrereqTech, CitizenSlots, PlunderType,
                      OnePerCity, PlunderAmount, AdvisorType, Cost, CostProgressionModel, CostProgressionParam1,
                      Maintenance, Housing, RequiresPlacement, RequiresPopulation, Aqueduct, NoAdjacentCity,
                      InternalOnly, ZOC, HitPoints, Entertainment, CaptureRemovesBuildings, CaptureRemovesCityDefenses,
                      MilitaryDomain, Appeal, AllowsHolyCity, TravelTime, CityStrengthModifier, MaxPerPlayer,
                      CaptureRemovesDistrict)
SELECT 'DISTRICT_XULINGTA',
       'TRAIT_DISTRICT_XULINGTA',
       'LOC_DISTRICT_XULINGTA_NAME',
       'LOC_DISTRICT_XULINGTA_DESCRIPTION',
       'CIVIC_EARLY_EMPIRE',
       NULL,
       CitizenSlots,
       PlunderType,
       OnePerCity,
       PlunderAmount,
       AdvisorType,
       Cost / 2,
       CostProgressionModel,
       CostProgressionParam1,
       Maintenance,
       Housing,
       RequiresPlacement,
       0,
       Aqueduct,
       NoAdjacentCity,
       InternalOnly,
       ZOC,
       HitPoints,
       1,
       CaptureRemovesBuildings,
       CaptureRemovesCityDefenses,
       MilitaryDomain,
       Appeal,
       AllowsHolyCity,
       TravelTime,
       CityStrengthModifier,
       MaxPerPlayer,
       CaptureRemovesDistrict
FROM Districts
WHERE DistrictType = 'DISTRICT_INDUSTRIAL_ZONE';

-- 继承商路收益、公民产出、伟人点产出、特殊效果和相邻加成
INSERT INTO District_TradeRouteYields(DistrictType, YieldType, YieldChangeAsOrigin, YieldChangeAsDomesticDestination,
                                      YieldChangeAsInternationalDestination)
SELECT 'DISTRICT_XULINGTA',
       YieldType,
       YieldChangeAsOrigin,
       YieldChangeAsDomesticDestination,
       YieldChangeAsInternationalDestination
FROM District_TradeRouteYields
WHERE DistrictType = 'DISTRICT_INDUSTRIAL_ZONE';

INSERT INTO District_CitizenYieldChanges(DistrictType, YieldType, YieldChange)
SELECT 'DISTRICT_XULINGTA',
       YieldType,
       YieldChange
FROM District_CitizenYieldChanges
WHERE DistrictType = 'DISTRICT_INDUSTRIAL_ZONE';

INSERT INTO District_GreatPersonPoints(DistrictType, GreatPersonClassType, PointsPerTurn)
SELECT 'DISTRICT_XULINGTA',
       GreatPersonClassType,
       PointsPerTurn
FROM District_GreatPersonPoints
WHERE DistrictType = 'DISTRICT_INDUSTRIAL_ZONE';

INSERT INTO DistrictModifiers(DistrictType, ModifierId)
SELECT 'DISTRICT_XULINGTA',
       ModifierId
FROM DistrictModifiers
WHERE DistrictType = 'DISTRICT_INDUSTRIAL_ZONE';


INSERT INTO Adjacency_YieldChanges(ID, Description, YieldType, YieldChange, Self)
VALUES ('NW_DISTRICT_XULINGTA', 'LOC_NW_DISTRICT_XULINGTA', 'YIELD_PRODUCTION', 5, 1),('NW_DISTRICT_XULINGTA2', 'LOC_NW_DISTRICT_XULINGTA2', 'YIELD_CULTURE', 2, 1);
INSERT INTO District_Adjacencies(DistrictType, YieldChangeId)
VALUES ('DISTRICT_XULINGTA','NW_DISTRICT_XULINGTA'),
       ('DISTRICT_XULINGTA','NW_DISTRICT_XULINGTA2');

-- 允许购买XX区域中的建筑
INSERT OR IGNORE INTO DistrictModifiers(DistrictType,ModifierId)VALUES
('DISTRICT_XULINGTA',	'MODIFIER_NW_DISTRICT_XULINGTA_ENABLE_BUILDING_FAITH_PURCHASE');
INSERT OR IGNORE INTO Modifiers(ModifierId,ModifierType)VALUES
('MODIFIER_NW_DISTRICT_XULINGTA_ENABLE_BUILDING_FAITH_PURCHASE',	'MODIFIER_PLAYER_CITIES_ENABLE_BUILDING_FAITH_PURCHASE');
INSERT OR IGNORE INTO ModifierArguments(ModifierId,	Name,Value)VALUES
('MODIFIER_NW_DISTRICT_XULINGTA_ENABLE_BUILDING_FAITH_PURCHASE','DistrictType','DISTRICT_INDUSTRIAL_ZONE');
