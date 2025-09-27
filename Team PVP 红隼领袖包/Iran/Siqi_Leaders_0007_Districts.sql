INSERT INTO Types (Type, Kind) VALUES
('DISTRICT_SIQI_D0007', 'KIND_DISTRICT'),
('TRAIT_DISTRICT_SIQI_D0007', 'KIND_TRAIT');

INSERT INTO Traits (TraitType, Name, Description) VALUES
('TRAIT_DISTRICT_SIQI_D0007', 'LOC_TRAIT_DISTRICT_SIQI_D0007_NAME', 'LOC_TRAIT_DISTRICT_SIQI_D0007_DESCRIPTION');

INSERT INTO DistrictReplaces (CivUniqueDistrictType, ReplacesDistrictType) VALUES
('DISTRICT_SIQI_D0007', 'DISTRICT_HARBOR');

INSERT INTO Districts (
    DistrictType,
    Name,
    PrereqTech,
    PrereqCivic,
    Coast,
    Description,
    Cost,
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
    TraitType,
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
) SELECT
    'DISTRICT_SIQI_D0007',
    'LOC_DISTRICT_SIQI_D0007_NAME',
    PrereqTech,
    PrereqCivic,
    Coast,
    'LOC_DISTRICT_SIQI_D0007_DESCRIPTION',
    Cost*0.6,
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
    'TRAIT_DISTRICT_SIQI_D0007',
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
WHERE DistrictType = 'DISTRICT_HARBOR';

INSERT INTO District_TradeRouteYields (DistrictType, YieldType, YieldChangeAsOrigin, YieldChangeAsDomesticDestination, YieldChangeAsInternationalDestination)
SELECT 'DISTRICT_SIQI_D0007', YieldType, YieldChangeAsOrigin, YieldChangeAsDomesticDestination, YieldChangeAsInternationalDestination FROM District_TradeRouteYields WHERE DistrictType = 'DISTRICT_HARBOR';

INSERT INTO District_GreatPersonPoints (DistrictType, GreatPersonClassType, PointsPerTurn)
SELECT 'DISTRICT_SIQI_D0007', GreatPersonClassType, PointsPerTurn FROM District_GreatPersonPoints WHERE DistrictType = 'DISTRICT_HARBOR';

INSERT INTO District_GreatPersonPoints (DistrictType, GreatPersonClassType, PointsPerTurn)
VALUES ('DISTRICT_SIQI_D0007', 'GREAT_PERSON_CLASS_PROPHET', 1);

INSERT INTO District_CitizenYieldChanges (DistrictType, YieldType, YieldChange)
SELECT 'DISTRICT_SIQI_D0007', YieldType, YieldChange FROM District_CitizenYieldChanges WHERE DistrictType = 'DISTRICT_HARBOR';

INSERT INTO District_Adjacencies (DistrictType, YieldChangeId)
SELECT 'DISTRICT_SIQI_D0007', YieldChangeId FROM District_Adjacencies WHERE DistrictType = 'DISTRICT_HARBOR';

INSERT INTO District_Adjacencies (DistrictType, YieldChangeId) VALUES
('DISTRICT_SIQI_D0007', 'Base_Siqi_D0007_Faith'),
('DISTRICT_SIQI_D0007', 'Base_Siqi_D0007_Faith2'),
('DISTRICT_SIQI_D0007', 'Base_Siqi_D0007_Faith3'),
('DISTRICT_SIQI_D0007', 'Base_Siqi_D0007_Culture');

INSERT INTO Adjacency_YieldChanges (ID, Description, YieldType, YieldChange, TilesRequired, AdjacentDistrict) VALUES
('Base_Siqi_D0007_Faith',    'LOC_SIQI_DISTRICT_SIQI_D0007_ADJACENCY_FAITH',    'YIELD_GOLD',    1, 1, 'DISTRICT_HOLY_SITE'),
('Base_Siqi_D0007_Culture', 'LOC_SIQI_DISTRICT_SIQI_D0007_ADJACENCY_CULTURE', 'YIELD_CULTURE', 1, 1, 'DISTRICT_HOLY_SITE');


INSERT INTO Adjacency_YieldChanges (ID, Description, YieldType, YieldChange, TilesRequired, AdjacentDistrict,PrereqCivic) VALUES
('Base_Siqi_D0007_Faith2',    'LOC_SIQI_DISTRICT_SIQI_D0007_ADJACENCY_FAITH',    'YIELD_GOLD',    1, 1, 'DISTRICT_HOLY_SITE','CIVIC_THEOLOGY'),
('Base_Siqi_D0007_Faith3', 'LOC_SIQI_DISTRICT_SIQI_D0007_ADJACENCY_FAITH', 'YIELD_GOLD', 1, 1, 'DISTRICT_HOLY_SITE','CIVIC_REFORMED_CHURCH');