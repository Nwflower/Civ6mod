------------------------------------------------------------------------------
--	FILE: TPRF.sql
--  VERSION: 1
--	PURPOSE: Team PVP Resource Fallback
------------------------------------------------------------------------------
--	Copyright (c) 2025 Nwflower.
--	All rights reserved.
------------------------------------------------------------------------------

-- 为支援单位类型，拥有2点劳动力，可以在无资源的单元格随机建造一个符合可生成逻辑的加成资源；
-- 星球塑形师也能够消耗1点劳动力，完成堤坝、水渠、社区、运河60%的建造进度。
-- ===============================
-- 代码块：单位定义
-- 作者：千川白浪
-- ===============================

-- 单位基础类型、标签、分类
INSERT INTO Types(Type, Kind)
VALUES ('UNIT_EARTH_ENGINEER', 'KIND_UNIT');
INSERT INTO TypeTags(Type, Tag)
SELECT 'UNIT_EARTH_ENGINEER',
       Tag
FROM TypeTags
WHERE Type = 'UNIT_MILITARY_ENGINEER';
INSERT INTO UnitAiInfos(UnitType, AiType)
SELECT 'UNIT_EARTH_ENGINEER',
       AiType
FROM UnitAiInfos
WHERE UnitType = 'UNIT_MILITARY_ENGINEER';

INSERT INTO Types(Type, Kind)
VALUES ('TRAIT_UNIT_MILITARY_ENGINEER', 'KIND_TRAIT');

INSERT INTO Traits (TraitType)
VALUES ('TRAIT_UNIT_MILITARY_ENGINEER');

-- 单位定义
INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Bombard, Domain,
                  FormationClass, Cost, PopulationCost, FoundCity, FoundReligion, MakeTradeRoute, EvangelizeBelief,
                  LaunchInquisition, RequiresInquisition, BuildCharges, ReligiousStrength, ReligionEvictPercent,
                  SpreadCharges, ReligiousHealCharges, ExtractsArtifacts, Description, Flavor, CanCapture,
                  CanRetreatWhenCaptured, TraitType, AllowBarbarians, CostProgressionModel, CostProgressionParam1,
                  PromotionClass, InitialLevel, NumRandomChoices, PrereqTech, PrereqCivic, PrereqDistrict,
                  PrereqPopulation, LeaderType, CanTrain, StrategicResource, PurchaseYield, MustPurchase, Maintenance,
                  Stackable, AirSlots, CanTargetAir, PseudoYieldType, ZoneOfControl, AntiAirCombat, Spy, WMDCapable,
                  ParkCharges, IgnoreMoves, TeamVisibility, ObsoleteTech, ObsoleteCivic, MandatoryObsoleteTech,
                  MandatoryObsoleteCivic, AdvisorType, EnabledByReligion, TrackReligion, DisasterCharges,
                  UseMaxMeleeTrainedStrength, ImmediatelyName, CanEarnExperience)
SELECT 'UNIT_EARTH_ENGINEER',         -- 类型
       'LOC_UNIT_EARTH_ENGINEER_NAME',-- 名称
       2,--视野
       2,-- 移动力
       Combat,-- 近战力
       RangedCombat,-- 远程力
       Range,-- 射程
       Bombard,-- 轰炸力
       Domain,-- 战斗域
       FormationClass,-- 编队类型
       300,-- 生产力
       PopulationCost,-- 消耗人口
       FoundCity,-- 能否创建城市
       FoundReligion,-- 能否创建宗教
       MakeTradeRoute,-- 能否创建商路
       EvangelizeBelief,-- 能否纳入新信仰
       LaunchInquisition,
       RequiresInquisition,
       0,
       ReligiousStrength,
       ReligionEvictPercent,
       SpreadCharges,
       ReligiousHealCharges,
       ExtractsArtifacts,
       'LOC_UNIT_EARTH_ENGINEER_DESCRIPTION',
       Flavor,
       CanCapture,
       CanRetreatWhenCaptured,
       'TRAIT_UNIT_MILITARY_ENGINEER',
       AllowBarbarians,
       CostProgressionModel,
       CostProgressionParam1,
       PromotionClass,
       InitialLevel,
       NumRandomChoices,
       NULL,
       NULL,
       PrereqDistrict,
       PrereqPopulation,
       LeaderType,
       CanTrain,
       StrategicResource,
       PurchaseYield,
       MustPurchase,
       0,
       Stackable,
       AirSlots,
       CanTargetAir,
       PseudoYieldType,
       ZoneOfControl,
       AntiAirCombat,
       Spy,
       WMDCapable,
       ParkCharges,
       IgnoreMoves,
       TeamVisibility,
       ObsoleteTech,
       ObsoleteCivic,
       MandatoryObsoleteTech,
       MandatoryObsoleteCivic,
       AdvisorType,
       EnabledByReligion,
       TrackReligion,
       DisasterCharges,
       UseMaxMeleeTrainedStrength,
       ImmediatelyName,
       CanEarnExperience
FROM Units
WHERE UnitType = 'UNIT_MILITARY_ENGINEER';

INSERT INTO Units_XP2(UnitType, ResourceMaintenanceAmount, ResourceCost, ResourceMaintenanceType, TourismBomb,
                      CanEarnExperience, TourismBombPossible, CanFormMilitaryFormation, MajorCivOnly, CanCauseDisasters,
                      CanSacrificeUnits)
SELECT 'UNIT_EARTH_ENGINEER',
       ResourceMaintenanceAmount,
       ResourceCost,
       ResourceMaintenanceType,
       TourismBomb,
       CanEarnExperience,
       TourismBombPossible,
       CanFormMilitaryFormation,
       MajorCivOnly,
       CanCauseDisasters,
       CanSacrificeUnits
FROM Units_XP2
WHERE UnitType = 'UNIT_MILITARY_ENGINEER';

INSERT INTO Units_MODE(UnitType, ActionCharges)
VALUES ('UNIT_EARTH_ENGINEER', 1);

--============================================================
-- Ability
--============================================================
INSERT INTO Types (Type, Kind)
VALUES ('ABILITY_EARTH_ENGINEER', 'KIND_ABILITY');

INSERT INTO Tags(Tag, Vocabulary)
VALUES ('CLASS_EARTH_ENGINEER', 'ABILITY_CLASS');

INSERT INTO TypeTags (Type, Tag)
VALUES ('ABILITY_EARTH_ENGINEER', 'CLASS_EARTH_ENGINEER'),
       ('UNIT_EARTH_ENGINEER', 'CLASS_EARTH_ENGINEER');

INSERT INTO UnitAbilities (UnitAbilityType, Description)
VALUES ('ABILITY_EARTH_ENGINEER', 'LOC_ABILITY_EARTH_ENGINEER');

INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId)
VALUES ('ABILITY_EARTH_ENGINEER', 'MODFEAT_EARTH_ENGINEER_PROPERTY');

INSERT INTO Modifiers (ModifierId, ModifierType)
VALUES ('MODFEAT_EARTH_ENGINEER_PROPERTY', 'MODIFIER_UNIT_ADJUST_PROPERTY');

INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODFEAT_EARTH_ENGINEER_PROPERTY', 'Key', 'PROPERTY_EARTHENGINEER_RANDOM_RESOURCE'),
       ('MODFEAT_EARTH_ENGINEER_PROPERTY', 'Amount', 1);


INSERT INTO Types (Type, Kind)
VALUES ('ABILITY_EARTH_ENGINEER_UNLOCK3', 'KIND_ABILITY');
INSERT INTO TypeTags (Type, Tag)
VALUES ('ABILITY_EARTH_ENGINEER_UNLOCK3', 'CLASS_EARTH_ENGINEER');

INSERT INTO UnitAbilities (UnitAbilityType, Description, Inactive)
VALUES ('ABILITY_EARTH_ENGINEER_UNLOCK3', 'LOC_ABILITY_EARTH_ENGINEER_UNLOCK3', 1);

INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId)
VALUES ('ABILITY_EARTH_ENGINEER_UNLOCK3', 'MODFEAT_EARTH_ENGINEER_PROPERTY_3');

INSERT INTO Modifiers (ModifierId, ModifierType)
VALUES ('MODFEAT_EARTH_ENGINEER_PROPERTY_3', 'MODIFIER_UNIT_ADJUST_PROPERTY');

INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODFEAT_EARTH_ENGINEER_PROPERTY_3', 'Key', 'PROPERTY_EARTHENGINEER_RANDOM_RESOURCE_3'),
       ('MODFEAT_EARTH_ENGINEER_PROPERTY_3', 'Amount', 1);

--============================================================
-- 辅助表：合法加成资源
--============================================================
CREATE TABLE NW_TABLE_BASE_RANDOM_RESOURCES
(
    ResourceType TEXT NOT NULL,
    FeatureType  TEXT,
    TerrainType  TEXT,
    PRIMARY KEY (ResourceType, FeatureType, TerrainType)
);

INSERT INTO NW_TABLE_BASE_RANDOM_RESOURCES(ResourceType, FeatureType, TerrainType)
SELECT Rvf.ResourceType, Rvf.FeatureType, NULL
FROM Resource_ValidFeatures Rvf
         JOIN Resources r ON Rvf.ResourceType = r.ResourceType
WHERE r.ResourceClassType = 'RESOURCECLASS_BONUS';

INSERT INTO NW_TABLE_BASE_RANDOM_RESOURCES(ResourceType, FeatureType, TerrainType)
SELECT Rvt.ResourceType, NULL, Rvt.TerrainType
FROM Resource_ValidTerrains Rvt
         JOIN Resources r ON Rvt.ResourceType = r.ResourceType
WHERE r.ResourceClassType = 'RESOURCECLASS_BONUS';