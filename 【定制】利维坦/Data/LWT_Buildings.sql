--	FILE: LWT_Buildings.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/9/29 22:03:38
--------------------------------------------------------------------------------
--  作者： 千川白浪
--  特别鸣谢： 优妮
------------------------------------------------------------------------------
INSERT INTO Types (Type, Kind)
VALUES ('BUILDING_20250929', 'KIND_BUILDING');
INSERT INTO Buildings(BuildingType, Name, PrereqTech, PrereqCivic, Cost, MaxPlayerInstances, MaxWorldInstances, Capital,
                      PrereqDistrict, AdjacentDistrict, Description, RequiresPlacement, RequiresRiver,
                      OuterDefenseHitPoints, Housing, Entertainment, AdjacentResource, Coast, EnabledByReligion,
                      AllowsHolyCity, PurchaseYield, MustPurchase, Maintenance, IsWonder, TraitType,
                      OuterDefenseStrength, CitizenSlots, MustBeLake, MustNotBeLake, RegionalRange, AdjacentToMountain,
                      ObsoleteEra, RequiresReligion, GrantFortification, DefenseModifier, InternalOnly,
                      RequiresAdjacentRiver, Quote, QuoteAudio, MustBeAdjacentLand, AdvisorType, AdjacentCapital,
                      AdjacentImprovement, CityAdjacentTerrain, UnlocksGovernmentPolicy, GovernmentTierRequirement)
SELECT 'BUILDING_20250929',
       'LOC_BUILDING_20250929_NAME',
       PrereqTech,
       PrereqCivic,
       Cost,
       MaxPlayerInstances,
       MaxWorldInstances,
       Capital,
       PrereqDistrict,
       AdjacentDistrict,
       'LOC_BUILDING_20250929_DESCRIPTION',
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
       'TRAIT_BUILDING_20250929',
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
SELECT 'BUILDING_20250929',
       YieldType,
       YieldChange
FROM Building_CitizenYieldChanges
WHERE BuildingType = 'BUILDING_MONUMENT';
-- 继承伟人点数
INSERT INTO Building_GreatPersonPoints(BuildingType, GreatPersonClassType, PointsPerTurn)
SELECT 'BUILDING_20250929',
       GreatPersonClassType,
       PointsPerTurn
FROM Building_GreatPersonPoints
WHERE BuildingType = 'BUILDING_MONUMENT';
-- 继承产出
INSERT INTO Building_YieldChanges(BuildingType, YieldType, YieldChange)
VALUES ('BUILDING_20250929','YIELD_FAITH',4),
       ('BUILDING_20250929','YIELD_CULTURE',1);
-- 继承修改器
INSERT INTO BuildingModifiers(BuildingType, ModifierId)
SELECT 'BUILDING_20250929',
       ModifierId
FROM BuildingModifiers
WHERE BuildingType = 'BUILDING_MONUMENT';
-- 替代
INSERT INTO BuildingReplaces(CivUniqueBuildingType, ReplacesBuildingType)
VALUES ('BUILDING_20250929', 'BUILDING_MONUMENT');


INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES
('BUILDING_20250929', 'MODIFIER_BUILDING_20250929_ADD_FAITH2');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_BUILDING_20250929_ADD_FAITH2', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 0, 0, 0, NULL, 'PLOT_IS_IMPROVED');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_BUILDING_20250929_ADD_FAITH2', 'Amount', '2'),
('MODIFIER_BUILDING_20250929_ADD_FAITH2', 'YieldType', 'YIELD_FAITH');

-- RequirementSets
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('PLOT_IS_IMPROVED', 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('PLOT_IS_IMPROVED', 'REQ_PLOT_IS_IMPROVED');
-- Requirements
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES
('REQ_PLOT_IS_IMPROVED', 'REQUIREMENT_PLOT_HAS_ANY_IMPROVEMENT');

INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES
('BUILDING_20250929', 'MODIFIER_BUILDING_20250929_ADD_FAITH4');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_BUILDING_20250929_ADD_FAITH4', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 0, 0, 0, NULL, 'PLOT_HAS_IMPROVEMENT_20250929');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_BUILDING_20250929_ADD_FAITH4', 'Amount', '4'),
('MODIFIER_BUILDING_20250929_ADD_FAITH4', 'YieldType', 'YIELD_FAITH');

-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('PLOT_HAS_IMPROVEMENT_20250929', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('PLOT_HAS_IMPROVEMENT_20250929', 'REQ_PLOT_HAS_IMPROVEMENT_20250929');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('REQ_PLOT_HAS_IMPROVEMENT_20250929', 'REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('REQ_PLOT_HAS_IMPROVEMENT_20250929', 'ImprovementType', 'IMPROVEMENT_20250929');


-- 如果城市至少有1个沙堡且拥有主流宗教，则九个单元格外的其他城市每回合-5点忠诚度。
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES
('BUILDING_20250929', 'MODIFIER_BUILDING_20250929_IDENTY');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_BUILDING_20250929_IDENTY', 'MODIFIER_NW_ALL_CITYS_ADJUST_IDENTITY_PER_TURN', 0, 0, 0, 'CITY_HAS_SHABAO_AND_RELIGION', 'REQS_CITY_IN_9PLOT');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_BUILDING_20250929_IDENTY', 'Amount', '-5');

-- Custom ModifierType
INSERT INTO Types (Type, Kind) VALUES
('MODIFIER_NW_ALL_CITYS_ADJUST_IDENTITY_PER_TURN', 'KIND_MODIFIER');
INSERT INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES
('MODIFIER_NW_ALL_CITYS_ADJUST_IDENTITY_PER_TURN', 'COLLECTION_ALL_CITIES', 'EFFECT_ADJUST_CITY_IDENTITY_PER_TURN');
-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('CITY_HAS_SHABAO_AND_RELIGION', 'REQUIREMENTSET_TEST_ALL'),
('REQS_CITY_IN_9PLOT', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('CITY_HAS_SHABAO_AND_RELIGION', 'REQ_05C6QZGF'),
('REQS_CITY_IN_9PLOT', 'REQ_CITY_IN_9PLOT');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType,Inverse) VALUES
('REQ_05C6QZGF', 'REQUIREMENT_CITY_FOLLOWS_RELIGION',0),
('REQ_CITY_IN_9PLOT', 'REQUIREMENT_PLOT_ADJACENT_TO_OWNER',1);
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('REQ_CITY_IN_9PLOT', 'MaxDistance', '9'),
('REQ_CITY_IN_9PLOT', 'MinDistance', '0');


