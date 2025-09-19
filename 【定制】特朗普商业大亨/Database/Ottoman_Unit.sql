--==========================================================================================================================
-- UNITS
--==========================================================================================================================
-- Types
-----------------------------------------------------------------------------------	
INSERT INTO Types
    (Type, Kind)
VALUES ('UNIT_HANGMU', 'KIND_UNIT');
-----------------------------------------------------------------------------------
-- Units
-----------------------------------------------------------------------------------	
INSERT INTO Units
(UnitType, BaseMoves, Cost, StrategicResource, AdvisorType, BaseSightRange, ZoneOfControl, Domain, FormationClass, Name,
 Description, MandatoryObsoleteTech, PurchaseYield, PromotionClass, Maintenance, Combat, RangedCombat, AirSlots, Range,
 PrereqTech, TraitType)
SELECT 'UNIT_HANGMU',
       BaseMoves,
       Cost,
       StrategicResource,
       AdvisorType,
       BaseSightRange,
       ZoneOfControl,
       Domain,
       FormationClass,
       'LOC_UNIT_HANGMU_NAME',
       'LOC_UNIT_HANGMU_DESCRIPTION',
       MandatoryObsoleteTech,
       PurchaseYield,
       PromotionClass,
       Maintenance,
       Combat,
       RangedCombat,
       2,
       Range,
       PrereqTech,
       'TRAIT_UNIT_HANGMU'
FROM Units
WHERE UnitType = 'UNIT_AIRCRAFT_CARRIER';
-----------------------------------------------------------------------------------
-- UnitReplaces
-----------------------------------------------------------------------------------	
INSERT INTO UnitReplaces
    (CivUniqueUnitType, ReplacesUnitType)
VALUES ('UNIT_HANGMU', 'UNIT_AIRCRAFT_CARRIER');
-----------------------------------------------------------------------------------
-- UnitUpgrades
-----------------------------------------------------------------------------------	
INSERT INTO UnitUpgrades
    (Unit, UpgradeUnit)
SELECT 'UNIT_HANGMU', UpgradeUnit
FROM UnitUpgrades
WHERE Unit = 'UNIT_AIRCRAFT_CARRIER';
-----------------------------------------------------------------------------------
-- UnitAIInfos
-----------------------------------------------------------------------------------	
INSERT INTO UnitAIInfos
    (UnitType, AiType)
SELECT 'UNIT_HANGMU', AiType
FROM UnitAIInfos
WHERE UnitType = 'UNIT_AIRCRAFT_CARRIER';
--------------------------------------------------------------------------------------------------------------------------
-- Units_XP2
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Units_XP2
(UnitType, ResourceMaintenanceAmount, ResourceCost, ResourceMaintenanceType)
SELECT 'UNIT_HANGMU', ResourceMaintenanceAmount, ResourceCost, ResourceMaintenanceType
FROM Units_XP2
WHERE UnitType = 'UNIT_AIRCRAFT_CARRIER';
-----------------------------------------------------------------------------------
-- Tags
-----------------------------------------------------------------------------------	
INSERT INTO Tags
    (Tag, Vocabulary)
VALUES ('CLASS_HANGMU', 'ABILITY_CLASS');
-----------------------------------------------------------------------------------
-- TypeTags
-----------------------------------------------------------------------------------	
INSERT INTO TypeTags
    (Type, Tag)
SELECT 'UNIT_HANGMU', Tag
FROM TypeTags
WHERE Type = 'UNIT_AIRCRAFT_CARRIER';

INSERT INTO TypeTags
    (Type, Tag)
VALUES ('UNIT_HANGMU', 'CLASS_HANGMU');


-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('REQSET_UNIT_HANGMU', 'REQUIREMENTSET_TEST_ALL'),
       ('REQSET_UNIT_HANGMU0', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('REQSET_UNIT_HANGMU', 'REQ_UNIT_HANGMU');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('REQ_UNIT_HANGMU', 'REQUIREMENT_UNIT_TYPE_MATCHES');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('REQ_UNIT_HANGMU', 'UnitType', 'UNIT_HANGMU');

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('REQSET_UNIT_HANGMU0', 'REQ_UNIT_HANGMU0');
INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('REQ_UNIT_HANGMU0', 'REQUIREMENT_COLLECTION_COUNT_ATLEAST');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('REQ_UNIT_HANGMU0', 'CollectionType', 'COLLECTION_PLAYER_UNITS'),
       ('REQ_UNIT_HANGMU0', 'Count', '0'),
       ('REQ_UNIT_HANGMU0', 'RequirementSetId', 'REQSET_UNIT_HANGMU');


INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES ('TRAIT_UNIT_HANGMU', 'TRAIT_UNIT_HANGMU_ADD_PRODUC');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('TRAIT_UNIT_HANGMU_ADD_PRODUC', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_PRODUCTION', 0, 0, 0,
        'REQSET_UNIT_HANGMU0', NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('TRAIT_UNIT_HANGMU_ADD_PRODUC', 'Amount', '100'),
       ('TRAIT_UNIT_HANGMU_ADD_PRODUC', 'UnitType', 'UNIT_HANGMU');


INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES ('TRAIT_UNIT_HANGMU', 'TRAIT_UNIT_HANGMU_PURCHASE_COST');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('TRAIT_UNIT_HANGMU_PURCHASE_COST', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_PURCHASE_COST', 0, 0, 0,
        'REQSET_UNIT_HANGMU0', NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('TRAIT_UNIT_HANGMU_PURCHASE_COST', 'Amount', '50'),
       ('TRAIT_UNIT_HANGMU_PURCHASE_COST', 'UnitType', 'UNIT_HANGMU');


-----------------------------------------------------------------------------------	
INSERT INTO Types(Type, Kind)
VALUES ('DISTRICT_FREEDOM_HARBOR', 'KIND_DISTRICT');
INSERT INTO DistrictReplaces(CivUniqueDistrictType, ReplacesDistrictType)
VALUES ('DISTRICT_FREEDOM_HARBOR', 'DISTRICT_HARBOR');


-- 继承属性 但半价
INSERT INTO Districts(DistrictType, TraitType, Name, Description, PrereqCivic, PrereqTech, CitizenSlots, PlunderType,
                      OnePerCity, PlunderAmount, AdvisorType, Cost, CostProgressionModel, CostProgressionParam1,
                      Maintenance, Housing, RequiresPlacement, RequiresPopulation, Aqueduct, NoAdjacentCity,
                      InternalOnly, ZOC, HitPoints, Entertainment, CaptureRemovesBuildings, CaptureRemovesCityDefenses,
                      MilitaryDomain, Appeal, AllowsHolyCity, TravelTime, CityStrengthModifier, MaxPerPlayer,
                      CaptureRemovesDistrict,Coast,AdjacentToLand)
SELECT 'DISTRICT_FREEDOM_HARBOR',
       'TRAIT_DISTRICT_FREEDOM_HARBOR',
       'LOC_DISTRICT_FREEDOM_HARBOR_NAME',
       'LOC_DISTRICT_FREEDOM_HARBOR_DESCRIPTION',
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
       1,
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
       AdjacentToLand
FROM Districts
WHERE DistrictType = 'DISTRICT_HARBOR';


-- 继承商路收益、公民产出、伟人点产出、特殊效果和相邻加成
INSERT INTO District_TradeRouteYields(DistrictType, YieldType, YieldChangeAsOrigin, YieldChangeAsDomesticDestination,
                                      YieldChangeAsInternationalDestination)
SELECT 'DISTRICT_FREEDOM_HARBOR',
       YieldType,
       YieldChangeAsOrigin,
       YieldChangeAsDomesticDestination,
       YieldChangeAsInternationalDestination
FROM District_TradeRouteYields
WHERE DistrictType = 'DISTRICT_HARBOR';

INSERT INTO District_CitizenYieldChanges(DistrictType, YieldType, YieldChange)
SELECT 'DISTRICT_FREEDOM_HARBOR',
       YieldType,
       YieldChange
FROM District_CitizenYieldChanges
WHERE DistrictType = 'DISTRICT_HARBOR';

INSERT INTO District_GreatPersonPoints(DistrictType, GreatPersonClassType, PointsPerTurn)
SELECT 'DISTRICT_FREEDOM_HARBOR',
       GreatPersonClassType,
       PointsPerTurn
FROM District_GreatPersonPoints
WHERE DistrictType = 'DISTRICT_HARBOR';

INSERT INTO DistrictModifiers(DistrictType, ModifierId)
SELECT 'DISTRICT_FREEDOM_HARBOR',
       ModifierId
FROM DistrictModifiers
WHERE DistrictType = 'DISTRICT_HARBOR';

INSERT INTO Adjacency_YieldChanges(ID, Description, YieldType, YieldChange, Self)
VALUES ('NW_DISTRICT_FREEDOM_HARBOR_YIELD_GOLD',
       'LOC_NW_DISTRICT_FREEDOM_HARBOR_YIELD_GOLD',
       'YIELD_GOLD',
       3,
       1);

INSERT INTO Adjacency_YieldChanges(ID, Description, YieldType, YieldChange, AdjacentDistrict)
VALUES ('NW_DISTRICT_FREEDOM_HARBOR_YIELD_GOLD_TO_SHANGYE',
       'LOC_NW_DISTRICT_FREEDOM_HARBOR_YIELD_GOLD_TO_SHANGYE',
       'YIELD_GOLD',
       3,
       'DISTRICT_FREEDOM_HARBOR');



INSERT OR IGNORE INTO District_Adjacencies(DistrictType, YieldChangeId)
VALUES ('DISTRICT_FREEDOM_HARBOR', 'NW_DISTRICT_FREEDOM_HARBOR_YIELD_GOLD'),
        ('DISTRICT_COMMERCIAL_HUB', 'NW_DISTRICT_FREEDOM_HARBOR_YIELD_GOLD_TO_SHANGYE');

-- 使用SELECT兼容地脉
INSERT OR IGNORE INTO District_Adjacencies(DistrictType, YieldChangeId)
SELECT 'DISTRICT_FREEDOM_HARBOR', YieldChangeId
FROM District_Adjacencies
WHERE DistrictType = 'DISTRICT_HARBOR';
