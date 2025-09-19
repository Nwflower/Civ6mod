--	FILE: SecretSociety_WorldTree_Improvement.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/7/3 11:22:01
--------------------------------------------------------------------------------
--  作者： 千川白浪
--  特别鸣谢： 优妮
------------------------------------------------------------------------------
-- √ 上古维序者专属，替代动物园，所需 [ICON_PRODUCTION] 生产力为动物园的75%，
-- 首次建成后解锁自然历史。
-- √ 宜居度加成延伸到6个单元格中的每个市中心。
-- √ 此加成1座城市仅能应用1次，因此市中心6个单元格以内相同的此建筑不会再额外提供加成。
-- √ 此城中的每处雨林和礁石单元格+1 [ICON_SCIENCE] 科技值。


INSERT INTO Types
    (Type, Kind)
VALUES ('BUILDING_BIOLOGY_MUSEUM', 'KIND_BUILDING');
INSERT INTO Buildings(BuildingType, Name, PrereqTech, PrereqCivic, Cost, MaxPlayerInstances, MaxWorldInstances, Capital,
                      PrereqDistrict, AdjacentDistrict, Description, RequiresPlacement, RequiresRiver,
                      OuterDefenseHitPoints, Housing, Entertainment, AdjacentResource, Coast, EnabledByReligion,
                      AllowsHolyCity, PurchaseYield, MustPurchase, Maintenance, IsWonder, TraitType,
                      OuterDefenseStrength, CitizenSlots, MustBeLake, MustNotBeLake, RegionalRange, AdjacentToMountain,
                      ObsoleteEra, RequiresReligion, GrantFortification, DefenseModifier, InternalOnly,
                      RequiresAdjacentRiver, Quote, QuoteAudio, MustBeAdjacentLand, AdvisorType, AdjacentCapital,
                      AdjacentImprovement, CityAdjacentTerrain, UnlocksGovernmentPolicy, GovernmentTierRequirement)
SELECT 'BUILDING_BIOLOGY_MUSEUM',
       'LOC_BUILDING_BIOLOGY_MUSEUM_NAME',
       NULL,
       NULL,
       Cost * 0.75,
       MaxPlayerInstances,
       MaxWorldInstances,
       Capital,
       PrereqDistrict,
       AdjacentDistrict,
       'LOC_BUILDING_BIOLOGY_MUSEUM_DESCRIPTION',
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
       TraitType,
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
WHERE BuildingType = 'BUILDING_ZOO';

INSERT INTO Buildings_XP2(BuildingType, RequiredPower, ResourceTypeConvertedToPower, PreventsFloods, PreventsDrought,
                          BlocksCoastalFlooding, CostMultiplierPerTile, CostMultiplierPerSeaLevel, Bridge, CanalWonder,
                          EntertainmentBonusWithPower, NuclearReactor, Pillage)
SELECT 'BUILDING_BIOLOGY_MUSEUM',
       RequiredPower,
       ResourceTypeConvertedToPower,
       PreventsFloods,
       PreventsDrought,
       BlocksCoastalFlooding,
       CostMultiplierPerTile,
       CostMultiplierPerSeaLevel,
       Bridge,
       CanalWonder,
       EntertainmentBonusWithPower,
       NuclearReactor,
       Pillage
FROM Buildings_XP2
WHERE BuildingType = 'BUILDING_ZOO';

-- 继承公民产出
INSERT INTO Building_CitizenYieldChanges(BuildingType, YieldType, YieldChange)
SELECT 'BUILDING_BIOLOGY_MUSEUM',
       YieldType,
       YieldChange
FROM Building_CitizenYieldChanges
WHERE BuildingType = 'BUILDING_ZOO';
-- 继承伟人点数
INSERT INTO Building_GreatPersonPoints(BuildingType, GreatPersonClassType, PointsPerTurn)
SELECT 'BUILDING_BIOLOGY_MUSEUM',
       GreatPersonClassType,
       PointsPerTurn
FROM Building_GreatPersonPoints
WHERE BuildingType = 'BUILDING_ZOO';
-- 继承产出
INSERT INTO Building_YieldChanges(BuildingType, YieldType, YieldChange)
SELECT 'BUILDING_BIOLOGY_MUSEUM',
       YieldType,
       YieldChange
FROM Building_YieldChanges
WHERE BuildingType = 'BUILDING_ZOO';
INSERT INTO BuildingConditions(BuildingType, UnlocksFromEffect)
VALUES ('BUILDING_BIOLOGY_MUSEUM', 1);
-- 替代
INSERT INTO BuildingReplaces(CivUniqueBuildingType, ReplacesBuildingType)
VALUES ('BUILDING_BIOLOGY_MUSEUM', 'BUILDING_ZOO');

INSERT INTO BuildingPrereqs(Building, PrereqBuilding) SELECT
'BUILDING_BIOLOGY_MUSEUM', PrereqBuilding
FROM BuildingPrereqs
WHERE Building = 'BUILDING_ZOO';

INSERT INTO BuildingModifiers(BuildingType, ModifierId)
VALUES ('BUILDING_BIOLOGY_MUSEUM', 'ZOO_RAINFOREST_SCIENCE');


INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_BIOLOGY_MUSEUM', 'ZOO_FEATURE_REEF_SCIENCE');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('ZOO_FEATURE_REEF_SCIENCE', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 0, 0, 0, NULL,
        'ZOO_REQS_FEATURE_REEF');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('ZOO_FEATURE_REEF_SCIENCE', 'Amount', '1'),
       ('ZOO_FEATURE_REEF_SCIENCE', 'YieldType', 'YIELD_SCIENCE');
-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('ZOO_REQS_FEATURE_REEF', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('ZOO_REQS_FEATURE_REEF', 'ZOO_REQ_FEATURE_REEF');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('ZOO_REQ_FEATURE_REEF', 'REQUIREMENT_PLOT_FEATURE_TYPE_MATCHES');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('ZOO_REQ_FEATURE_REEF', 'FeatureType', 'FEATURE_REEF');

-- 上古维序者专属，替代工厂。
-- 其 [ICON_PRODUCTION] 生产力和 [ICON_CULTURE] 文化值加成延伸到6单元格内的所有市中心（前提是其尚未从其他的此建筑获得加成）。
-- 首次建成后，赠予1份特殊的人造奢侈品资源“香水”。

INSERT INTO Types
    (Type, Kind)
VALUES ('BUILDING_BIOLOGY_FACTORY', 'KIND_BUILDING');
INSERT INTO Buildings(BuildingType, Name, PrereqTech, PrereqCivic, Cost, MaxPlayerInstances, MaxWorldInstances, Capital,
                      PrereqDistrict, AdjacentDistrict, Description, RequiresPlacement, RequiresRiver,
                      OuterDefenseHitPoints, Housing, Entertainment, AdjacentResource, Coast, EnabledByReligion,
                      AllowsHolyCity, PurchaseYield, MustPurchase, Maintenance, IsWonder, TraitType,
                      OuterDefenseStrength, CitizenSlots, MustBeLake, MustNotBeLake, RegionalRange, AdjacentToMountain,
                      ObsoleteEra, RequiresReligion, GrantFortification, DefenseModifier, InternalOnly,
                      RequiresAdjacentRiver, Quote, QuoteAudio, MustBeAdjacentLand, AdvisorType, AdjacentCapital,
                      AdjacentImprovement, CityAdjacentTerrain, UnlocksGovernmentPolicy, GovernmentTierRequirement)
SELECT 'BUILDING_BIOLOGY_FACTORY',
       'LOC_BUILDING_BIOLOGY_FACTORY_NAME',
       NULL,
       NULL,
       Cost,
       MaxPlayerInstances,
       MaxWorldInstances,
       Capital,
       PrereqDistrict,
       AdjacentDistrict,
       'LOC_BUILDING_BIOLOGY_FACTORY_DESCRIPTION',
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
       TraitType,
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

INSERT INTO Buildings_XP2(BuildingType, RequiredPower, ResourceTypeConvertedToPower, PreventsFloods, PreventsDrought,
                          BlocksCoastalFlooding, CostMultiplierPerTile, CostMultiplierPerSeaLevel, Bridge, CanalWonder,
                          EntertainmentBonusWithPower, NuclearReactor, Pillage)
SELECT 'BUILDING_BIOLOGY_FACTORY',
       RequiredPower,
       ResourceTypeConvertedToPower,
       PreventsFloods,
       PreventsDrought,
       BlocksCoastalFlooding,
       CostMultiplierPerTile,
       CostMultiplierPerSeaLevel,
       Bridge,
       CanalWonder,
       EntertainmentBonusWithPower,
       NuclearReactor,
       Pillage
FROM Buildings_XP2
WHERE BuildingType = 'BUILDING_FACTORY';



INSERT INTO BuildingPrereqs(Building, PrereqBuilding) SELECT
'BUILDING_BIOLOGY_FACTORY', PrereqBuilding
FROM BuildingPrereqs
WHERE Building = 'BUILDING_FACTORY';

-- 继承公民产出
INSERT INTO Building_CitizenYieldChanges(BuildingType, YieldType, YieldChange)
SELECT 'BUILDING_BIOLOGY_FACTORY',
       YieldType,
       YieldChange
FROM Building_CitizenYieldChanges
WHERE BuildingType = 'BUILDING_FACTORY';
-- 继承伟人点数
INSERT INTO Building_GreatPersonPoints(BuildingType, GreatPersonClassType, PointsPerTurn)
SELECT 'BUILDING_BIOLOGY_FACTORY',
       GreatPersonClassType,
       PointsPerTurn
FROM Building_GreatPersonPoints
WHERE BuildingType = 'BUILDING_FACTORY';
-- 继承产出
INSERT INTO Building_YieldChanges(BuildingType, YieldType, YieldChange)
VALUES ('BUILDING_BIOLOGY_FACTORY', 'YIELD_PRODUCTION', 2),
       ('BUILDING_BIOLOGY_FACTORY', 'YIELD_CULTURE', 2);

INSERT INTO Building_YieldChangesBonusWithPower(BuildingType, YieldType, YieldChange)
VALUES ('BUILDING_BIOLOGY_FACTORY', 'YIELD_PRODUCTION', 4);

INSERT INTO BuildingConditions(BuildingType, UnlocksFromEffect)
VALUES ('BUILDING_BIOLOGY_FACTORY', 1);
-- 替代
INSERT INTO BuildingReplaces(CivUniqueBuildingType, ReplacesBuildingType)
VALUES ('BUILDING_BIOLOGY_FACTORY', 'BUILDING_FACTORY');
