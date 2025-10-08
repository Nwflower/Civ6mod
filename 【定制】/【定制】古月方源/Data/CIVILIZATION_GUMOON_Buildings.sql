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
VALUES ('BUILDING_NW_250924', 'KIND_BUILDING');
INSERT INTO Buildings(BuildingType, Name, PrereqTech, PrereqCivic, Cost, MaxPlayerInstances, MaxWorldInstances, Capital,
                      PrereqDistrict, AdjacentDistrict, Description, RequiresPlacement, RequiresRiver,
                      OuterDefenseHitPoints, Housing, Entertainment, AdjacentResource, Coast, EnabledByReligion,
                      AllowsHolyCity, PurchaseYield, MustPurchase, Maintenance, IsWonder, TraitType,
                      OuterDefenseStrength, CitizenSlots, MustBeLake, MustNotBeLake, RegionalRange, AdjacentToMountain,
                      ObsoleteEra, RequiresReligion, GrantFortification, DefenseModifier, InternalOnly,
                      RequiresAdjacentRiver, Quote, QuoteAudio, MustBeAdjacentLand, AdvisorType, AdjacentCapital,
                      AdjacentImprovement, CityAdjacentTerrain, UnlocksGovernmentPolicy, GovernmentTierRequirement)
SELECT 'BUILDING_NW_250924',
       'LOC_BUILDING_NW_250924_NAME',
       PrereqTech,
       PrereqCivic,
       Cost,
       MaxPlayerInstances,
       MaxWorldInstances,
       Capital,
       PrereqDistrict,
       AdjacentDistrict,
       'LOC_BUILDING_NW_250924_DESCRIPTION',
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
       'TRAIT_BUILDING_NW_250924',
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
WHERE BuildingType = 'BUILDING_MONUMENT';



-- 继承公民产出
INSERT INTO Building_CitizenYieldChanges(BuildingType, YieldType, YieldChange)
SELECT 'BUILDING_NW_250924',
       YieldType,
       YieldChange
FROM Building_CitizenYieldChanges
WHERE BuildingType = 'BUILDING_MONUMENT';
-- 继承伟人点数
INSERT INTO Building_GreatPersonPoints(BuildingType, GreatPersonClassType, PointsPerTurn)
SELECT 'BUILDING_NW_250924',
       GreatPersonClassType,
       PointsPerTurn
FROM Building_GreatPersonPoints
WHERE BuildingType = 'BUILDING_MONUMENT';
-- 继承产出
INSERT INTO Building_YieldChanges(BuildingType, YieldType, YieldChange)
SELECT 'BUILDING_NW_250924',
       YieldType,
       YieldChange
FROM Building_YieldChanges
WHERE BuildingType = 'BUILDING_MONUMENT';
-- 继承修改器
INSERT INTO BuildingModifiers(BuildingType, ModifierId)
SELECT 'BUILDING_NW_250924',
       ModifierId
FROM BuildingModifiers
WHERE BuildingType = 'BUILDING_MONUMENT';
-- 替代
INSERT INTO BuildingReplaces(CivUniqueBuildingType, ReplacesBuildingType)
VALUES ('BUILDING_NW_250924', 'BUILDING_MONUMENT');


INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES
('BUILDING_NW_250924', 'MODIFIER_BUILDING_NW_250924_GROWTH');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_BUILDING_NW_250924_GROWTH', 'MODIFIER_SINGLE_CITY_ADJUST_CITY_GROWTH', 0, 0, 0, NULL, NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_BUILDING_NW_250924_GROWTH', 'Amount', '10');



------------------------------------------------------------------------------
INSERT INTO Types (Type, Kind)
VALUES ('BUILDING_NW_250925', 'KIND_BUILDING');
INSERT INTO Buildings(BuildingType, Name, PrereqTech, PrereqCivic, Cost, MaxPlayerInstances, MaxWorldInstances, Capital,
                      PrereqDistrict, AdjacentDistrict, Description, RequiresPlacement, RequiresRiver,
                      OuterDefenseHitPoints, Housing, Entertainment, AdjacentResource, Coast, EnabledByReligion,
                      AllowsHolyCity, PurchaseYield, MustPurchase, Maintenance, IsWonder, TraitType,
                      OuterDefenseStrength, CitizenSlots, MustBeLake, MustNotBeLake, RegionalRange, AdjacentToMountain,
                      ObsoleteEra, RequiresReligion, GrantFortification, DefenseModifier, InternalOnly,
                      RequiresAdjacentRiver, Quote, QuoteAudio, MustBeAdjacentLand, AdvisorType, AdjacentCapital,
                      AdjacentImprovement, CityAdjacentTerrain, UnlocksGovernmentPolicy, GovernmentTierRequirement)
SELECT 'BUILDING_NW_250925',
       'LOC_BUILDING_NW_250925_NAME',
       PrereqTech,
       PrereqCivic,
       Cost,
       MaxPlayerInstances,
       MaxWorldInstances,
       Capital,
       PrereqDistrict,
       AdjacentDistrict,
       'LOC_BUILDING_NW_250925_DESCRIPTION',
       RequiresPlacement,
       RequiresRiver,
       OuterDefenseHitPoints,
       2,
       Entertainment,
       AdjacentResource,
       Coast,
       EnabledByReligion,
       AllowsHolyCity,
       PurchaseYield,
       MustPurchase,
       Maintenance,
       IsWonder,
       'TRAIT_BUILDING_NW_250924',
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
WHERE BuildingType = 'BUILDING_WORKSHOP';



-- 继承公民产出
INSERT INTO Building_CitizenYieldChanges(BuildingType, YieldType, YieldChange)
SELECT 'BUILDING_NW_250925',
       YieldType,
       YieldChange
FROM Building_CitizenYieldChanges
WHERE BuildingType = 'BUILDING_WORKSHOP';
-- 继承伟人点数
INSERT INTO Building_GreatPersonPoints(BuildingType, GreatPersonClassType, PointsPerTurn)
SELECT 'BUILDING_NW_250925',
       GreatPersonClassType,
       PointsPerTurn
FROM Building_GreatPersonPoints
WHERE BuildingType = 'BUILDING_WORKSHOP';
-- 继承产出
INSERT INTO Building_YieldChanges(BuildingType, YieldType, YieldChange)
SELECT 'BUILDING_NW_250925',
       YieldType,
       YieldChange
FROM Building_YieldChanges
WHERE BuildingType = 'BUILDING_WORKSHOP';
-- 继承修改器
INSERT INTO BuildingModifiers(BuildingType, ModifierId)
SELECT 'BUILDING_NW_250925',
       ModifierId
FROM BuildingModifiers
WHERE BuildingType = 'BUILDING_WORKSHOP';
-- 替代
INSERT INTO BuildingReplaces(CivUniqueBuildingType, ReplacesBuildingType)
VALUES ('BUILDING_NW_250925', 'BUILDING_WORKSHOP');

INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES
('BUILDING_NW_250925', 'MODIFIER_BUILDING_NW_250925_P2S');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_BUILDING_NW_250925_P2S', 'MODIFIER_PLAYER_DISTRICT_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_BUILDING_NW_250925_P2S', 'DistrictType', 'DISTRICT_NW_250924'),
('MODIFIER_BUILDING_NW_250925_P2S', 'YieldTypeToGrant', 'YIELD_SCIENCE'),
('MODIFIER_BUILDING_NW_250925_P2S', 'YieldTypeToMirror', 'YIELD_PRODUCTION');


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
       'TRAIT_BUILDING_NW_250924',
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

INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES
('BUILDING_NW_250925', 'MODIFIER_BUILDING_NW_250926');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_BUILDING_NW_250926', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 0, 0, 0, NULL, 'REQS_MODIFIER_BUILDING_NW_250926');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_BUILDING_NW_250926', 'Amount', '2'),
('MODIFIER_BUILDING_NW_250926', 'YieldType', 'YIELD_PRODUCTION');
-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('REQS_MODIFIER_BUILDING_NW_250926', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('REQS_MODIFIER_BUILDING_NW_250926', 'REQ_MODIFIER_BUILDING_NW_250926');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('REQ_MODIFIER_BUILDING_NW_250926', 'REQUIREMENT_PLOT_HAS_ANY_IMPROVEMENT');
