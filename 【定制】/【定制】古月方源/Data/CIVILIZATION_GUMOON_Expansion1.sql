--	FILE: CIVILIZATION_GUMOON_Buildings.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/9/24 19:28:22
--------------------------------------------------------------------------------
--  作者： 千川白浪
--  特别鸣谢： 优妮
------------------------------------------------------------------------------
INSERT INTO Types (Type, Kind)
VALUES ('BUILDING_NW_250926', 'KIND_BUILDING');
INSERT INTO Buildings(BuildingType, Name, PrereqTech, PrereqCivic, Cost, MaxPlayerInstances, MaxWorldInstances, Capital,
                      PrereqDistrict, AdjacentDistrict, Description, RequiresPlacement, RequiresRiver,
                      OuterDefenseHitPoints, Housing, Entertainment, AdjacentResource, Coast, EnabledByReligion,
                      AllowsHolyCity, PurchaseYield, MustPurchase, Maintenance, IsWonder, TraitType,
                      OuterDefenseStrength, CitizenSlots, MustBeLake, MustNotBeLake, RegionalRange, AdjacentToMountain,
                      ObsoleteEra, RequiresReligion, GrantFortification, DefenseModifier, InternalOnly,
                      RequiresAdjacentRiver, Quote, QuoteAudio, MustBeAdjacentLand, AdvisorType, AdjacentCapital,
                      AdjacentImprovement, CityAdjacentTerrain, UnlocksGovernmentPolicy, GovernmentTierRequirement)
SELECT 'BUILDING_NW_250926',
       'LOC_BUILDING_NW_250926_NAME',
       PrereqTech,
       PrereqCivic,
       Cost,
       MaxPlayerInstances,
       MaxWorldInstances,
       Capital,
       PrereqDistrict,
       AdjacentDistrict,
       'LOC_BUILDING_NW_250926_DESCRIPTION',
       RequiresPlacement,
       RequiresRiver,
       OuterDefenseHitPoints,
       Housing,
       Entertainment,
       AdjacentResource,
       Coast,
       EnabledByReligion,
       AllowsHolyCity,
       PurchaseYield,
       MustPurchase,
       Maintenance,
       IsWonder,
       'TRAIT_BUILDING_NW_250926',
       OuterDefenseStrength,
       CitizenSlots,
       MustBeLake,
       MustNotBeLake,
       RegionalRange,
       AdjacentToMountain,
       ObsoleteEra,
       RequiresReligion,
       GrantFortification,
       DefenseModifier,
       InternalOnly,
       RequiresAdjacentRiver,
       Quote,
       QuoteAudio,
       MustBeAdjacentLand,
       AdvisorType,
       AdjacentCapital,
       AdjacentImprovement,
       CityAdjacentTerrain,
       UnlocksGovernmentPolicy,
       GovernmentTierRequirement
FROM Buildings
WHERE BuildingType = 'BUILDING_FACTORY';



-- 继承公民产出
INSERT INTO Building_CitizenYieldChanges(BuildingType, YieldType, YieldChange)
SELECT 'BUILDING_NW_250926',
       YieldType,
       YieldChange
FROM Building_CitizenYieldChanges
WHERE BuildingType = 'BUILDING_FACTORY';
-- 继承伟人点数
INSERT INTO Building_GreatPersonPoints(BuildingType, GreatPersonClassType, PointsPerTurn)
SELECT 'BUILDING_NW_250926',
       GreatPersonClassType,
       PointsPerTurn
FROM Building_GreatPersonPoints
WHERE BuildingType = 'BUILDING_FACTORY';
-- 继承产出
INSERT INTO Building_YieldChanges(BuildingType, YieldType, YieldChange)
SELECT 'BUILDING_NW_250926',
       YieldType,
       YieldChange
FROM Building_YieldChanges
WHERE BuildingType = 'BUILDING_FACTORY';
-- 继承修改器
INSERT INTO BuildingModifiers(BuildingType, ModifierId)
SELECT 'BUILDING_NW_250926',
       ModifierId
FROM BuildingModifiers
WHERE BuildingType = 'BUILDING_FACTORY';
-- 替代
INSERT INTO BuildingReplaces(CivUniqueBuildingType, ReplacesBuildingType)
VALUES ('BUILDING_NW_250926', 'BUILDING_FACTORY');


