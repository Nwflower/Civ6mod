--     FILE: NewLeader3_Districts.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--     Copyright (c) 2025.
--     All rights reserved.
--  DateCreated: 2025/9/22 21:48:22
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT INTO Types(Type, Kind)
VALUES ('DISTRICT_NW009', 'KIND_DISTRICT');
INSERT INTO DistrictReplaces(CivUniqueDistrictType, ReplacesDistrictType)
VALUES ('DISTRICT_NW009', 'DISTRICT_CAMPUS');

-- 继承属性 但半价
INSERT INTO Districts(DistrictType, TraitType, Name, Description, PrereqCivic, PrereqTech, CitizenSlots, PlunderType,
                      OnePerCity, PlunderAmount, AdvisorType, Cost, CostProgressionModel, CostProgressionParam1,
                      Maintenance, Housing, RequiresPlacement, RequiresPopulation, Aqueduct, NoAdjacentCity,
                      InternalOnly, ZOC, HitPoints, Entertainment, CaptureRemovesBuildings, CaptureRemovesCityDefenses,
                      MilitaryDomain, Appeal, AllowsHolyCity, TravelTime, CityStrengthModifier, MaxPerPlayer,
                      CaptureRemovesDistrict)
SELECT 'DISTRICT_NW009',
       'TRAIT_DISTRICT_NW009',
       'LOC_DISTRICT_NW009_NAME',
       'LOC_DISTRICT_NW009_DESCRIPTION',
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
WHERE DistrictType = 'DISTRICT_CAMPUS';

-- 继承商路收益、公民产出、伟人点产出、特殊效果和相邻加成
INSERT INTO District_TradeRouteYields(DistrictType, YieldType, YieldChangeAsOrigin, YieldChangeAsDomesticDestination,
                                      YieldChangeAsInternationalDestination)
SELECT 'DISTRICT_NW009',
       YieldType,
       YieldChangeAsOrigin,
       YieldChangeAsDomesticDestination,
       YieldChangeAsInternationalDestination
FROM District_TradeRouteYields
WHERE DistrictType = 'DISTRICT_CAMPUS';

INSERT INTO District_CitizenYieldChanges(DistrictType, YieldType, YieldChange)
SELECT 'DISTRICT_NW009',
       YieldType,
       YieldChange
FROM District_CitizenYieldChanges
WHERE DistrictType = 'DISTRICT_CAMPUS';

INSERT INTO District_GreatPersonPoints(DistrictType, GreatPersonClassType, PointsPerTurn)
SELECT 'DISTRICT_NW009',
       GreatPersonClassType,
       PointsPerTurn
FROM District_GreatPersonPoints
WHERE DistrictType = 'DISTRICT_CAMPUS';



INSERT INTO District_GreatPersonPoints(DistrictType, GreatPersonClassType, PointsPerTurn)VALUES
('DISTRICT_NW009', 'GREAT_PERSON_CLASS_PROPHET', 1);

INSERT INTO DistrictModifiers(DistrictType, ModifierId)
SELECT 'DISTRICT_NW009',
       ModifierId
FROM DistrictModifiers
WHERE DistrictType = 'DISTRICT_CAMPUS';

INSERT INTO District_Adjacencies(DistrictType, YieldChangeId) SELECT
'DISTRICT_NW009', YieldChangeId
FROM District_Adjacencies
WHERE DistrictType = 'DISTRICT_CAMPUS';

-- INSERT INTO TraitModifiers(ModifierId,								TraitType)VALUES
-- ('MODIFIER_DISTRICT_KEFALEPLAZA_CULTURE_BOMB_TRIGGER', 'TRAIT_DISTRICT_NW009');
-- INSERT INTO Modifiers(ModifierId,								ModifierType,SubjectRequirementSetId)VALUES
-- ('MODIFIER_DISTRICT_KEFALEPLAZA_CULTURE_BOMB_TRIGGER', 'MODIFIER_PLAYER_ADD_CULTURE_BOMB_TRIGGER',NULL);
-- INSERT INTO ModifierArguments(ModifierId,								Name,						Value)VALUES
-- ('MODIFIER_DISTRICT_KEFALEPLAZA_CULTURE_BOMB_TRIGGER',		'DistrictType',	'DISTRICT_NW009');
