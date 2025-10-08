--	FILE: Liuche_Buildings.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/9/9 21:08:06
--------------------------------------------------------------------------------
--  作者： 千川白浪
--  特别鸣谢： 优妮
------------------------------------------------------------------------------
INSERT INTO Types (Type, Kind)
VALUES ('BUILDING_YAN_MARKET', 'KIND_BUILDING');
INSERT INTO Buildings(BuildingType, Name, PrereqTech, PrereqCivic, Cost, MaxPlayerInstances, MaxWorldInstances, Capital,
                      PrereqDistrict, AdjacentDistrict, Description, RequiresPlacement, RequiresRiver,
                      OuterDefenseHitPoints, Housing, Entertainment, AdjacentResource, Coast, EnabledByReligion,
                      AllowsHolyCity, PurchaseYield, MustPurchase, Maintenance, IsWonder, TraitType,
                      OuterDefenseStrength, CitizenSlots, MustBeLake, MustNotBeLake, RegionalRange, AdjacentToMountain,
                      ObsoleteEra, RequiresReligion, GrantFortification, DefenseModifier, InternalOnly,
                      RequiresAdjacentRiver, Quote, QuoteAudio, MustBeAdjacentLand, AdvisorType, AdjacentCapital,
                      AdjacentImprovement, CityAdjacentTerrain, UnlocksGovernmentPolicy, GovernmentTierRequirement)
SELECT 'BUILDING_YAN_MARKET',
       'LOC_BUILDING_YAN_MARKET_NAME',
       PrereqTech,
       PrereqCivic,
       90,
       MaxPlayerInstances,
       MaxWorldInstances,
       Capital,
       PrereqDistrict,
       AdjacentDistrict,
       'LOC_BUILDING_YAN_MARKET_DESCRIPTION',
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
       'TRAIT_BUILDING_YAN_MARKET',
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
WHERE BuildingType = 'BUILDING_MARKET';


-- 继承公民产出
INSERT INTO Building_CitizenYieldChanges(BuildingType, YieldType, YieldChange)
SELECT 'BUILDING_YAN_MARKET',
       YieldType,
       YieldChange
FROM Building_CitizenYieldChanges
WHERE BuildingType = 'BUILDING_MARKET';
-- 继承伟人点数
INSERT INTO Building_GreatPersonPoints(BuildingType, GreatPersonClassType, PointsPerTurn)
SELECT 'BUILDING_YAN_MARKET',
       GreatPersonClassType,
       PointsPerTurn
FROM Building_GreatPersonPoints
WHERE BuildingType = 'BUILDING_MARKET';
-- 继承产出
INSERT INTO Building_YieldChanges(BuildingType, YieldType, YieldChange)
SELECT 'BUILDING_YAN_MARKET',
       YieldType,
       YieldChange
FROM Building_YieldChanges
WHERE BuildingType = 'BUILDING_MARKET';
-- 继承修改器
INSERT INTO BuildingModifiers(BuildingType, ModifierId)
SELECT 'BUILDING_YAN_MARKET',
       ModifierId
FROM BuildingModifiers
WHERE BuildingType = 'BUILDING_MARKET';

INSERT INTO BuildingModifiers(BuildingType, ModifierId)
VALUES ('BUILDING_YAN_MARKET', 'LIGHTHOUSE_TRADE_ROUTE_CAPACITY');
-- 替代
INSERT INTO BuildingReplaces(CivUniqueBuildingType, ReplacesBuildingType)
VALUES ('BUILDING_YAN_MARKET', 'BUILDING_MARKET');

INSERT INTO BuildingPrereqs(Building, PrereqBuilding) SELECT
'BUILDING_YAN_MARKET', PrereqBuilding
FROM BuildingPrereqs
WHERE Building = 'BUILDING_MARKET';

INSERT INTO Unit_BuildingPrereqs(Unit, PrereqBuilding, NumSupported) SELECT
Unit, 'BUILDING_YAN_MARKET', NumSupported
FROM Unit_BuildingPrereqs
WHERE PrereqBuilding = 'BUILDING_MARKET';


INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES
('BUILDING_YAN_MARKET', 'MODIFIER_BUILDING_YAN_MARKET_ADD_IRON');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_BUILDING_YAN_MARKET_ADD_IRON', 'MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_EXTRACTION', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_BUILDING_YAN_MARKET_ADD_IRON', 'Amount', '1'),
('MODIFIER_BUILDING_YAN_MARKET_ADD_IRON', 'ResourceType', 'RESOURCE_IRON');



INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES
('BUILDING_YAN_MARKET', 'MODIFIER_BUILDING_YAN_MARKET_ADD_GOLD');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_BUILDING_YAN_MARKET_ADD_GOLD', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 0, 0, 0, NULL, 'REQS_MODIFIER_BUILDING_YAN_MARKET_ADD_GOLD');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_BUILDING_YAN_MARKET_ADD_GOLD', 'Amount', '2'),
('MODIFIER_BUILDING_YAN_MARKET_ADD_GOLD', 'YieldType', 'YIELD_GOLD');

-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('REQS_MODIFIER_BUILDING_YAN_MARKET_ADD_GOLD', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('REQS_MODIFIER_BUILDING_YAN_MARKET_ADD_GOLD', 'REQ_MODIFIER_BUILDING_YAN_MARKET_ADD_GOLD'),
('REQS_MODIFIER_BUILDING_YAN_MARKET_ADD_GOLD', 'REQ_MODIFIER_BUILDING_YAN_MARKET_ADD_GOLD2');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('REQ_MODIFIER_BUILDING_YAN_MARKET_ADD_GOLD', 'REQUIREMENT_PLOT_RESOURCE_TYPE_MATCHES'),
('REQ_MODIFIER_BUILDING_YAN_MARKET_ADD_GOLD2', 'REQUIREMENT_PLOT_HAS_ANY_IMPROVEMENT');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('REQ_MODIFIER_BUILDING_YAN_MARKET_ADD_GOLD', 'ResourceType', 'RESOURCE_SALT');
