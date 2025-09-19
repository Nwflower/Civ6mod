INSERT INTO Types(Type, Kind)
VALUES ('DISTRICT_JEER', 'KIND_DISTRICT');
INSERT INTO DistrictReplaces(CivUniqueDistrictType, ReplacesDistrictType)
VALUES ('DISTRICT_JEER', 'DISTRICT_AQUEDUCT');

INSERT INTO Districts(DistrictType, Name, PrereqTech, PrereqCivic, Coast, Description, Cost, RequiresPlacement,
                      RequiresPopulation, NoAdjacentCity, CityCenter, Aqueduct, InternalOnly, ZOC, FreeEmbark,
                      HitPoints, CaptureRemovesBuildings, CaptureRemovesCityDefenses, PlunderType, PlunderAmount,
                      TradeEmbark, MilitaryDomain, CostProgressionModel, CostProgressionParam1, TraitType, Appeal,
                      Housing, Entertainment, OnePerCity, AllowsHolyCity, Maintenance, AirSlots, CitizenSlots,
                      TravelTime, CityStrengthModifier, AdjacentToLand, CanAttack, AdvisorType, CaptureRemovesDistrict,
                      MaxPerPlayer)
SELECT 'DISTRICT_JEER',
       'LOC_DISTRICT_JEER_NAME',
       'TECH_IRRIGATION',
       PrereqCivic,
       Coast,
       'LOC_DISTRICT_JEER_DESCRIPTION',
       Cost / 2,
       RequiresPlacement,
       RequiresPopulation,
       NoAdjacentCity,
       CityCenter,
       Aqueduct,
       InternalOnly,
       ZOC,
       FreeEmbark,
       HitPoints,
       CaptureRemovesBuildings,
       CaptureRemovesCityDefenses,
       PlunderType,
       PlunderAmount,
       TradeEmbark,
       MilitaryDomain,
       CostProgressionModel,
       CostProgressionParam1,
       'TRAIT_DISTRICT_JEER',
       Appeal,
       Housing,
       Entertainment,
       OnePerCity,
       AllowsHolyCity,
       Maintenance,
       AirSlots,
       CitizenSlots,
       TravelTime,
       CityStrengthModifier,
       AdjacentToLand,
       CanAttack,
       AdvisorType,
       CaptureRemovesDistrict,
       MaxPerPlayer
FROM Districts
WHERE DistrictType = 'DISTRICT_AQUEDUCT';

-- 继承商路收益、公民产出、伟人点产出、特殊效果和相邻加成
INSERT INTO District_TradeRouteYields(DistrictType, YieldType, YieldChangeAsOrigin, YieldChangeAsDomesticDestination,
                                      YieldChangeAsInternationalDestination)
SELECT 'DISTRICT_JEER',
       YieldType,
       YieldChangeAsOrigin,
       YieldChangeAsDomesticDestination,
       YieldChangeAsInternationalDestination
FROM District_TradeRouteYields
WHERE DistrictType = 'DISTRICT_AQUEDUCT';

INSERT INTO District_CitizenYieldChanges(DistrictType, YieldType, YieldChange)
SELECT 'DISTRICT_JEER',
       YieldType,
       YieldChange
FROM District_CitizenYieldChanges
WHERE DistrictType = 'DISTRICT_AQUEDUCT';

INSERT INTO District_GreatPersonPoints(DistrictType, GreatPersonClassType, PointsPerTurn)
SELECT 'DISTRICT_JEER',
       GreatPersonClassType,
       PointsPerTurn
FROM District_GreatPersonPoints
WHERE DistrictType = 'DISTRICT_AQUEDUCT';

INSERT INTO DistrictModifiers(DistrictType, ModifierId)
SELECT 'DISTRICT_JEER',
       ModifierId
FROM DistrictModifiers
WHERE DistrictType = 'DISTRICT_AQUEDUCT';



INSERT INTO ImprovementModifiers (ImprovementType, ModifierId) VALUES
('IMPROVEMENT_FARM', 'MODIFIER_IMPROVEMENT_FARM_ADD_FOOD');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_IMPROVEMENT_FARM_ADD_FOOD', 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS', 0, 0, 0, NULL, 'REQSET_CITY_HAS_DISTRICT_JEER');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_IMPROVEMENT_FARM_ADD_FOOD', 'Amount', '1'),
('MODIFIER_IMPROVEMENT_FARM_ADD_FOOD', 'YieldType', 'YIELD_FOOD');

INSERT INTO ImprovementModifiers (ImprovementType, ModifierId) VALUES
('IMPROVEMENT_FARM', 'MODIFIER_IMPROVEMENT_FARM_ADD_HOUSING');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_IMPROVEMENT_FARM_ADD_HOUSING', 'MODIFIER_SINGLE_CITY_ADJUST_IMPROVEMENT_HOUSING', 0, 0, 0, NULL, 'REQSET_CITY_HAS_DISTRICT_JEER');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_IMPROVEMENT_FARM_ADD_HOUSING', 'Amount', '1');
-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('REQSET_CITY_HAS_DISTRICT_JEER', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('REQSET_CITY_HAS_DISTRICT_JEER', 'REQ_CITY_HAS_DISTRICT_JEER');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('REQ_CITY_HAS_DISTRICT_JEER', 'REQUIREMENT_CITY_HAS_DISTRICT');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('REQ_CITY_HAS_DISTRICT_JEER', 'DistrictType', 'DISTRICT_JEER');
