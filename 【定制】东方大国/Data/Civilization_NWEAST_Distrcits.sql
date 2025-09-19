--     FILE: Civilization_NWEAST_Districts.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--     Copyright (c) 2025.
--     All rights reserved.
--  DateCreated: 2025/9/12 11:48:27
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT INTO Types(Type, Kind)
VALUES ('DISTRICT_TIANCEFU', 'KIND_DISTRICT');
INSERT INTO DistrictReplaces(CivUniqueDistrictType, ReplacesDistrictType)
VALUES ('DISTRICT_TIANCEFU', 'DISTRICT_GOVERNMENT');

-- 继承属性 但半价
INSERT INTO Districts(DistrictType, TraitType, Name, Description, PrereqCivic, PrereqTech, CitizenSlots, PlunderType,
                      OnePerCity, PlunderAmount, AdvisorType, Cost, CostProgressionModel, CostProgressionParam1,
                      Maintenance, Housing, RequiresPlacement, RequiresPopulation, Aqueduct, NoAdjacentCity,
                      InternalOnly, ZOC, HitPoints, Entertainment, CaptureRemovesBuildings, CaptureRemovesCityDefenses,
                      MilitaryDomain, Appeal, AllowsHolyCity, TravelTime, CityStrengthModifier, MaxPerPlayer,
                      CaptureRemovesDistrict)
SELECT 'DISTRICT_TIANCEFU',
       'TRAIT_DISTRICT_TIANCEFU',
       'LOC_DISTRICT_TIANCEFU_NAME',
       'LOC_DISTRICT_TIANCEFU_DESCRIPTION',
       PrereqCivic,
       PrereqTech,
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
       CaptureRemovesDistrict
FROM Districts
WHERE DistrictType = 'DISTRICT_GOVERNMENT';

-- 继承商路收益、公民产出、伟人点产出、特殊效果和相邻加成
INSERT INTO District_TradeRouteYields(DistrictType, YieldType, YieldChangeAsOrigin, YieldChangeAsDomesticDestination,
                                      YieldChangeAsInternationalDestination)
SELECT 'DISTRICT_TIANCEFU',
       YieldType,
       YieldChangeAsOrigin,
       YieldChangeAsDomesticDestination,
       YieldChangeAsInternationalDestination
FROM District_TradeRouteYields
WHERE DistrictType = 'DISTRICT_GOVERNMENT';

INSERT INTO District_CitizenYieldChanges(DistrictType, YieldType, YieldChange)
SELECT 'DISTRICT_TIANCEFU',
       YieldType,
       YieldChange
FROM District_CitizenYieldChanges
WHERE DistrictType = 'DISTRICT_GOVERNMENT';

INSERT INTO District_GreatPersonPoints(DistrictType, GreatPersonClassType, PointsPerTurn)
SELECT 'DISTRICT_TIANCEFU',
       GreatPersonClassType,
       PointsPerTurn
FROM District_GreatPersonPoints
WHERE DistrictType = 'DISTRICT_GOVERNMENT';

INSERT INTO DistrictModifiers(DistrictType, ModifierId)
SELECT 'DISTRICT_TIANCEFU',
       ModifierId
FROM DistrictModifiers
WHERE DistrictType = 'DISTRICT_GOVERNMENT';


INSERT INTO DistrictModifiers (DistrictType, ModifierId)
VALUES ('DISTRICT_TIANCEFU', 'MODIFIER_NWEAST_CITIES_ADD_POPULATION');
INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, NewOnly)
VALUES ('MODIFIER_NWEAST_CITIES_ADD_POPULATION', 'MODIFIER_PLAYER_CITIES_ADD_POPULATION', 0, 1, 1);
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_NWEAST_CITIES_ADD_POPULATION', 'Amount', '3');