--	FILE: CIVILIZATION_NW_HANJ_Buildings.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/9/15 18:21:35
--------------------------------------------------------------------------------
--  作者： 千川白浪
--  特别鸣谢： 优妮
------------------------------------------------------------------------------
INSERT INTO Types (Type, Kind)
VALUES ('BUILDING_TAICANG', 'KIND_BUILDING');
INSERT INTO Buildings(BuildingType, Name, PrereqTech, PrereqCivic, Cost, MaxPlayerInstances, MaxWorldInstances, Capital,
                      PrereqDistrict, AdjacentDistrict, Description, RequiresPlacement, RequiresRiver,
                      OuterDefenseHitPoints, Housing, Entertainment, AdjacentResource, Coast, EnabledByReligion,
                      AllowsHolyCity, PurchaseYield, MustPurchase, Maintenance, IsWonder, TraitType,
                      OuterDefenseStrength, CitizenSlots, MustBeLake, MustNotBeLake, RegionalRange, AdjacentToMountain,
                      ObsoleteEra, RequiresReligion, GrantFortification, DefenseModifier, InternalOnly,
                      RequiresAdjacentRiver, Quote, QuoteAudio, MustBeAdjacentLand, AdvisorType, AdjacentCapital,
                      AdjacentImprovement, CityAdjacentTerrain, UnlocksGovernmentPolicy, GovernmentTierRequirement)
SELECT 'BUILDING_TAICANG',
       'LOC_BUILDING_TAICANG_NAME',
       PrereqTech,
       PrereqCivic,
       Cost / 2,
       MaxPlayerInstances,
       MaxWorldInstances,
       Capital,
       PrereqDistrict,
       AdjacentDistrict,
       'LOC_BUILDING_TAICANG_DESCRIPTION',
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
       'TRAIT_BUILDING_TAICANG',
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
WHERE BuildingType = 'BUILDING_GRANARY';

-- 继承公民产出
INSERT INTO Building_CitizenYieldChanges(BuildingType, YieldType, YieldChange)
SELECT 'BUILDING_TAICANG',
       YieldType,
       YieldChange
FROM Building_CitizenYieldChanges
WHERE BuildingType = 'BUILDING_GRANARY';
-- 继承伟人点数
INSERT INTO Building_GreatPersonPoints(BuildingType, GreatPersonClassType, PointsPerTurn)
SELECT 'BUILDING_TAICANG',
       GreatPersonClassType,
       PointsPerTurn
FROM Building_GreatPersonPoints
WHERE BuildingType = 'BUILDING_GRANARY';
-- 继承产出
INSERT INTO Building_YieldChanges(BuildingType, YieldType, YieldChange)
SELECT 'BUILDING_TAICANG',
       YieldType,
       YieldChange
FROM Building_YieldChanges
WHERE BuildingType = 'BUILDING_GRANARY';
-- 继承修改器
INSERT INTO BuildingModifiers(BuildingType, ModifierId)
SELECT 'BUILDING_TAICANG',
       ModifierId
FROM BuildingModifiers
WHERE BuildingType = 'BUILDING_GRANARY';
-- 替代
INSERT INTO BuildingReplaces(CivUniqueBuildingType, ReplacesBuildingType)
VALUES ('BUILDING_TAICANG', 'BUILDING_GRANARY');


-- 大汉特色建筑，替代粮仓，建造费用更低。战略储量上限+10。

INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES
('BUILDING_TAICANG', 'MODIFIER_BUILDING_TAICANG_ADD_CAP');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_BUILDING_TAICANG_ADD_CAP', 'MODIFIER_PLAYER_ADJUST_RESOURCE_STOCKPILE_CAP', 0, 0, 0, NULL, NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_BUILDING_TAICANG_ADD_CAP', 'Amount', '20');
