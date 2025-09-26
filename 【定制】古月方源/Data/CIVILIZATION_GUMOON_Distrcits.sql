--     FILE: CIVILIZATION_GUMOON_Districts.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--     Copyright (c) 2025.
--     All rights reserved.
--  DateCreated: 2025/9/24 19:28:22
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT INTO Types(Type, Kind)
VALUES ('DISTRICT_NW_250924', 'KIND_DISTRICT');
INSERT INTO DistrictReplaces(CivUniqueDistrictType, ReplacesDistrictType)
VALUES ('DISTRICT_NW_250924', 'DISTRICT_INDUSTRIAL_ZONE');

-- 继承属性 但半价
INSERT INTO Districts(DistrictType, TraitType, Name, Description, PrereqCivic, PrereqTech, CitizenSlots, PlunderType,
                      OnePerCity, PlunderAmount, AdvisorType, Cost, CostProgressionModel, CostProgressionParam1,
                      Maintenance, Housing, RequiresPlacement, RequiresPopulation, Aqueduct, NoAdjacentCity,
                      InternalOnly, ZOC, HitPoints, Entertainment, CaptureRemovesBuildings, CaptureRemovesCityDefenses,
                      MilitaryDomain, Appeal, AllowsHolyCity, TravelTime, CityStrengthModifier, MaxPerPlayer,
                      CaptureRemovesDistrict)
SELECT 'DISTRICT_NW_250924',
       'TRAIT_DISTRICT_NW_250924',
       'LOC_DISTRICT_NW_250924_NAME',
       'LOC_DISTRICT_NW_250924_DESCRIPTION',
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
WHERE DistrictType = 'DISTRICT_INDUSTRIAL_ZONE';

-- 继承商路收益、公民产出、伟人点产出、特殊效果和相邻加成
INSERT INTO District_TradeRouteYields(DistrictType, YieldType, YieldChangeAsOrigin, YieldChangeAsDomesticDestination,
                                      YieldChangeAsInternationalDestination)
SELECT 'DISTRICT_NW_250924',
       YieldType,
       YieldChangeAsOrigin,
       YieldChangeAsDomesticDestination,
       YieldChangeAsInternationalDestination
FROM District_TradeRouteYields
WHERE DistrictType = 'DISTRICT_INDUSTRIAL_ZONE';

INSERT INTO District_CitizenYieldChanges(DistrictType, YieldType, YieldChange)
SELECT 'DISTRICT_NW_250924',
       YieldType,
       YieldChange
FROM District_CitizenYieldChanges
WHERE DistrictType = 'DISTRICT_INDUSTRIAL_ZONE';

INSERT INTO District_GreatPersonPoints(DistrictType, GreatPersonClassType, PointsPerTurn)
SELECT 'DISTRICT_NW_250924',
       GreatPersonClassType,
       PointsPerTurn
FROM District_GreatPersonPoints
WHERE DistrictType = 'DISTRICT_INDUSTRIAL_ZONE';

INSERT INTO DistrictModifiers(DistrictType, ModifierId)
SELECT 'DISTRICT_NW_250924',
       ModifierId
FROM DistrictModifiers
WHERE DistrictType = 'DISTRICT_INDUSTRIAL_ZONE';


-- 从从改良设施、奇观、自然奇观、湖泊和河流获得标准相邻加成，从漂流炼巢获得大量相邻加成
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,AdjacentImprovement) SELECT
'DISTRICT_NW_250924_production_'||ImprovementType,'{LOC_DISTRICT_NW_250924_production_DESCRIPTION1}{LOC_'||ImprovementType||'_DESCRIPTION}{LOC_DISTRICT_NW_250924_production_DESCRIPTION2}',	'YIELD_PRODUCTION',	1,ImprovementType
FROM Improvements;

INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,AdjacentRiver) VALUES
('DISTRICT_NW_250924_production_River','{LOC_DISTRICT_NW_250924_production_DESCRIPTION1}{LOC_DISTRICT_NW_250924_production_DESCRIPTION3}',	'YIELD_PRODUCTION',	1,1);
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,AdjacentWonder) VALUES
('DISTRICT_NW_250924_production_AdjacentWonder','{LOC_DISTRICT_NW_250924_production_DESCRIPTION1}{LOC_DISTRICT_NW_250924_production_DESCRIPTION4}',	'YIELD_PRODUCTION',	1,1);
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,AdjacentNaturalWonder) VALUES
('DISTRICT_NW_250924_production_AdjacentNaturalWonder','{LOC_DISTRICT_NW_250924_production_DESCRIPTION1}{LOC_DISTRICT_NW_250924_production_DESCRIPTION5}',	'YIELD_PRODUCTION',	1,1);
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,AdjacentTerrain) VALUES
('DISTRICT_NW_250924_production_AdjacentTerrain','{LOC_DISTRICT_NW_250924_production_DESCRIPTION1}{LOC_TERRAIN_COAST_NAME}{LOC_DISTRICT_NW_250924_production_DESCRIPTION2}',	'YIELD_PRODUCTION',	1,'TERRAIN_COAST');
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,AdjacentDistrict) VALUES
('DISTRICT_NW_250924_production_AdjacentDistrict','{LOC_DISTRICT_NW_250924_production_DESCRIPTION1}{LOC_DISTRICT_NW_250924_NAME}{LOC_DISTRICT_NW_250924_production_DESCRIPTION2}',	'YIELD_PRODUCTION',	2,'DISTRICT_NW_250924');

INSERT OR IGNORE INTO District_Adjacencies(DistrictType,YieldChangeId)SELECT
'DISTRICT_NW_250924','DISTRICT_NW_250924_production_'||ImprovementType
FROM Improvements;

INSERT OR IGNORE INTO District_Adjacencies(DistrictType,YieldChangeId)VALUES
('DISTRICT_NW_250924','DISTRICT_NW_250924_production_River'),
('DISTRICT_NW_250924','DISTRICT_NW_250924_production_AdjacentWonder'),
('DISTRICT_NW_250924','DISTRICT_NW_250924_production_AdjacentNaturalWonder'),
('DISTRICT_NW_250924','DISTRICT_NW_250924_production_AdjacentTerrain'),
('DISTRICT_NW_250924','DISTRICT_NW_250924_production_AdjacentDistrict');

-- 使用SELECT兼容地脉
INSERT INTO District_Adjacencies(DistrictType,YieldChangeId)SELECT DISTINCT
'DISTRICT_NW_250924',YieldChangeId FROM District_Adjacencies WHERE YieldChangeId = 'LeyLine_Production' OR DistrictType = 'DISTRICT_INDUSTRIAL_ZONE';

--================
-- MomentIllustrations
--================
INSERT INTO MomentIllustrations(MomentIllustrationType, MomentDataType, GameDataType, Texture) VALUES
('MOMENT_ILLUSTRATION_UNIQUE_DISTRICT','MOMENT_DATA_DISTRICT','DISTRICT_NW_250924','MomentXP2_BuildingSuguba.dds');