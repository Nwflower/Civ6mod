------------------------------------------------------------------------------
--	FILE: TPRF.sql
--  VERSION: 1
--	PURPOSE: Team PVP Resource Fallback
------------------------------------------------------------------------------
--	Copyright (c) 2025 Nwflower.
--	All rights reserved.
------------------------------------------------------------------------------
-- 建立首都后赠送一个资源工程师，拥有2点移动力、1点劳动力。
-- 可以在空地或可以放置的位置建造一个加成资源。
-- ===============================
-- 代码块：所有主流文明开局提供一个资源工程师
-- 作者：千川白浪
-- ===============================
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES
('BUILDING_PALACE', 'NW_TPRF_MODIFIER_TRAIT_LEADER_MAJOR_CIV_FREE_UNIT_RESOURCE_ENGINEER');
INSERT INTO Modifiers (ModifierId, ModifierType,SubjectStackLimit, RunOnce, Permanent) VALUES
('NW_TPRF_MODIFIER_TRAIT_LEADER_MAJOR_CIV_FREE_UNIT_RESOURCE_ENGINEER', 'MODIFIER_PLAYER_GRANT_UNIT_IN_CAPITAL',1, 1,1);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('NW_TPRF_MODIFIER_TRAIT_LEADER_MAJOR_CIV_FREE_UNIT_RESOURCE_ENGINEER', 'AllowUniqueOverride', '1'),
('NW_TPRF_MODIFIER_TRAIT_LEADER_MAJOR_CIV_FREE_UNIT_RESOURCE_ENGINEER', 'Amount', '1'),
('NW_TPRF_MODIFIER_TRAIT_LEADER_MAJOR_CIV_FREE_UNIT_RESOURCE_ENGINEER', 'UnitType', 'UNIT_RESOURCE_ENGINEER');

-- ===============================
-- 代码块：单位定义
-- 作者：千川白浪
-- ===============================

-- 单位基础类型、标签、分类
INSERT INTO Types(Type, Kind)
VALUES ('UNIT_RESOURCE_ENGINEER', 'KIND_UNIT');
INSERT INTO TypeTags(Type, Tag)
SELECT 'UNIT_RESOURCE_ENGINEER',
       Tag
FROM TypeTags
WHERE Type = 'UNIT_MILITARY_ENGINEER';
INSERT INTO UnitAiInfos(UnitType, AiType)
SELECT 'UNIT_RESOURCE_ENGINEER',
       AiType
FROM UnitAiInfos
WHERE UnitType = 'UNIT_MILITARY_ENGINEER';

-- 单位是否替代原型单位
-- INSERT INTO UnitReplaces (civuniqueunittype, replacesunittype) VALUES
-- ('UNIT_RESOURCE_ENGINEER','UNIT_MILITARY_ENGINEER');

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
SELECT 'UNIT_RESOURCE_ENGINEER',         -- 类型
       'LOC_UNIT_RESOURCE_ENGINEER_NAME',-- 名称
       BaseSightRange,--视野
       2,-- 移动力
       Combat,-- 近战力
       RangedCombat,-- 远程力
       Range,-- 射程
       Bombard,-- 轰炸力
       Domain,-- 战斗域
       FormationClass,-- 编队类型
       1,-- 生产力
       PopulationCost,-- 消耗人口
       FoundCity,-- 能否创建城市
       FoundReligion,-- 能否创建宗教
       MakeTradeRoute,-- 能否创建商路
       EvangelizeBelief,-- 能否纳入新信仰
       LaunchInquisition,
       RequiresInquisition,
       1,
       ReligiousStrength,
       ReligionEvictPercent,
       SpreadCharges,
       ReligiousHealCharges,
       ExtractsArtifacts,
       'LOC_UNIT_RESOURCE_ENGINEER_DESCRIPTION',
       Flavor,
       CanCapture,
       CanRetreatWhenCaptured,
       TraitType,
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
       null,
       1,
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
SELECT 'UNIT_RESOURCE_ENGINEER',
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

-- 单位升级情况
INSERT INTO UnitUpgrades(unit, upgradeunit)
SELECT 'UNIT_RESOURCE_ENGINEER', UpgradeUnit
FROM UnitUpgrades
WHERE unit = 'UNIT_MILITARY_ENGINEER';


-- ===============================
-- 代码块：虚拟改良
-- 作者：千川白浪
-- ===============================
CREATE TABLE NW_TPRF_IMPROVEMENT(
    ImprovementType TEXT NOT NULL PRIMARY KEY,
    ResourceType TEXT NOT NULL
);

INSERT INTO NW_TPRF_IMPROVEMENT(ImprovementType, ResourceType) SELECT
'IMPROVEMENT_NW_TPRF_' || ResourceType, ResourceType
FROM Resources
WHERE ResourceClassType = 'RESOURCECLASS_BONUS';

INSERT INTO Types(Type, Kind)
SELECT 'IMPROVEMENT_NW_TPRF_' || ResourceType, 'KIND_IMPROVEMENT'
FROM Resources
WHERE ResourceClassType = 'RESOURCECLASS_BONUS';

INSERT INTO Improvements(ImprovementType, Name, Buildable, Description, PlunderType, PlunderAmount, Icon,
                        Goody, Capturable, Domain, CanBuildOutsideTerritory)
SELECT 'IMPROVEMENT_NW_TPRF_' || ResourceType,
        'LOC_'||ResourceType||'_NAME',
        1,
        'LOC_IMPROVEMENT_NW_TPRF_'||ResourceType||'_DESCRIPTION',
        'NO_PLUNDER',
        0,
        'ICON_'||ResourceType,
        0,
        1,
        CASE
            WHEN SeaFrequency > 0 THEN 'DOMAIN_SEA'
            ELSE 'DOMAIN_LAND'
        END,
    1
FROM Resources
WHERE ResourceClassType = 'RESOURCECLASS_BONUS';

-- 产出设置
INSERT INTO Improvement_YieldChanges(ImprovementType, YieldType, YieldChange)
SELECT 'IMPROVEMENT_NW_TPRF_' || ResourceType, YieldType, YieldChange
FROM Resource_YieldChanges WHERE ResourceType IN (
SELECT ResourceType
FROM Resources
WHERE ResourceClassType = 'RESOURCECLASS_BONUS');

-- 可建造设置
INSERT INTO Improvement_ValidBuildUnits(ImprovementType, UnitType)
SELECT 'IMPROVEMENT_NW_TPRF_' || ResourceType,'UNIT_RESOURCE_ENGINEER'
FROM Resources
WHERE ResourceClassType = 'RESOURCECLASS_BONUS';

INSERT INTO Improvement_ValidTerrains(ImprovementType, TerrainType)
SELECT 'IMPROVEMENT_NW_TPRF_' || ResourceType,TerrainType
FROM Resource_ValidTerrains WHERE ResourceType IN (
SELECT ResourceType
FROM Resources
WHERE ResourceClassType = 'RESOURCECLASS_BONUS');

INSERT INTO Improvement_ValidFeatures(ImprovementType,FeatureType)
SELECT 'IMPROVEMENT_NW_TPRF_' || ResourceType,FeatureType
FROM Resource_ValidFeatures WHERE ResourceType IN (
SELECT ResourceType
FROM Resources
WHERE ResourceClassType = 'RESOURCECLASS_BONUS');