--	FILE: CIVILIZATION_ASIS_Unit.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/9/13 11:37:52
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

-- 单位基础类型、标签、分类
INSERT INTO Types(Type, Kind)
VALUES ('UNIT_NIULI', 'KIND_UNIT');

INSERT INTO TypeTags(Type, Tag)
SELECT 'UNIT_NIULI', Tag
FROM TypeTags
WHERE Type = 'UNIT_TREBUCHET';

INSERT INTO UnitAiInfos(UnitType, AiType)
SELECT 'UNIT_NIULI', AiType
FROM UnitAiInfos
WHERE UnitType = 'UNIT_TREBUCHET';

-- 单位是否替代原型单位
INSERT INTO UnitReplaces (civuniqueunittype, replacesunittype)
VALUES ('UNIT_NIULI', 'UNIT_TREBUCHET');


-- 风云变幻扩展包给Units表补充的额外信息
INSERT INTO Units_XP2(UnitType, ResourceMaintenanceAmount, ResourceCost, ResourceMaintenanceType, TourismBomb,
                      CanEarnExperience, TourismBombPossible, CanFormMilitaryFormation, MajorCivOnly, CanCauseDisasters,
                      CanSacrificeUnits)
SELECT 'UNIT_NIULI',
       ResourceMaintenanceAmount, -- 每回合消耗的战略资源数量
       ResourceCost, -- 建造单位需要的战略资源数量
       ResourceMaintenanceType, -- 战略资源维护费
       TourismBomb,
       CanEarnExperience,
       TourismBombPossible,
       CanFormMilitaryFormation, -- 是否能组成军团或军队
       MajorCivOnly, -- 是否只有主要文明才能建造
       CanCauseDisasters, -- 是否能召唤灾难
       CanSacrificeUnits
FROM Units_XP2
WHERE UnitType = 'UNIT_TREBUCHET';

-- 生产/购买单位需要的前置建筑。如果某个单位在这个表中没有任何对应的行，它不需要任何前置建筑就可以生产。如果某个单位在这个表中有任何对应的行，它就只能在有任意一行中指定的建筑时才可以生产。
INSERT INTO Unit_BuildingPrereqs(Unit, PrereqBuilding, NumSupported)
SELECT 'UNIT_NIULI',
       PrereqBuilding,
       NumSupported -- 每个对应建筑可以允许多少个对应单位（只有考古学家和考古博物馆用到了这一列），-1 代表任意数量。
FROM Unit_BuildingPrereqs
WHERE unit = 'UNIT_TREBUCHET';

-- 标明了某个单位Unit可以升级为高级单位UpgradeUnit。只有一个主键Unit。
INSERT INTO UnitUpgrades(unit, upgradeunit)
SELECT 'UNIT_NIULI',
       UpgradeUnit
FROM UnitUpgrades
WHERE unit = 'UNIT_TREBUCHET';

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
SELECT 'UNIT_NIULI',                 -- 类型
       'LOC_UNIT_NIULI_NAME',        -- 名称
       BaseSightRange,                            --视野
       BaseMoves,                                 -- 移动力
       Combat,                                    -- 近战力
       RangedCombat,                              -- 远程力
       Range,                                     -- 射程
       Bombard,                                   -- 轰炸力
       Domain,                                    -- 单位的海陆空类别。可用值：DOMAIN_LAND陆地单位，DOMAIN_SEA海上单位，DOMAIN_AIR空中单位。
       FormationClass,                            -- 单位的编队类别，指向UnitFormationClasses表的FormationClassType列。可用值：FORMATION_CLASS_CIVILIAN平民单位，FORMATION_CLASS_LAND_COMBAT陆地战斗单位，FORMATION_CLASS_NAVAL海上战斗单位，FORMATION_CLASS_SUPPORT支援单位，FORMATION_CLASS_AIR空中战斗单位。
       Cost,                                      -- 生产力
       PopulationCost,                            -- 消耗人口
       FoundCity,                                 -- 能否创建城市
       FoundReligion,                             -- 能否创建宗教
       MakeTradeRoute,                            -- 能否创建商路
       EvangelizeBelief,                          -- 能否纳入新信仰
       LaunchInquisition,                         -- 是否能开启宗教审讯
       RequiresInquisition,                       -- 是否需要已开启宗教审讯才能生产/购买
       BuildCharges,                              -- 劳动力
       ReligiousStrength,                         -- 宗教战斗力
       ReligionEvictPercent,                      -- 压教比例
       SpreadCharges,                             -- 传教次数
       ReligiousHealCharges,                      -- 宗教治疗次数
       ExtractsArtifacts,                         -- 是否可以挖掘文物。
       'LOC_UNIT_NIULI_DESCRIPTION', -- 描述文本
       Flavor,
       CanCapture,                                -- 可以俘虏平民单位
       CanRetreatWhenCaptured,                    -- 被俘虏时传送回最近城市
       'TRAIT_UNIT_NIULI',           -- 绑定特性
       AllowBarbarians,                           -- 允许蛮族生成
       CostProgressionModel,                      -- 涨价方式 NO_COST_PROGRESSION不涨价
       CostProgressionParam1,                     -- 涨价参数 COST_PROGRESSION_GAME_PROGRESS按游戏进程涨价 CostProgressionParam1填最终（即全科技/市政后的）价格百分比 COST_PROGRESSION_PREVIOUS_COPIES按已有数量涨价 CostProgressionParam1填每一个涨价的数量
       PromotionClass,                            -- 单位的晋升树，指向UnitPromotionClasses表的PromotionClassType列。
       InitialLevel,                              -- 单位的初始等级，1是没有初始升级，2是附赠1级初始升级，以此类推。
       NumRandomChoices,                          -- 单位升级时从所有升级里随机抽出的数量
       PrereqTech,                                -- 前置科技
       PrereqCivic,                               -- 前置市政
       PrereqDistrict,                            -- 前置区域
       PrereqPopulation,                          -- 消耗人口
       LeaderType,                                --
       CanTrain,                                  -- 可生产
       StrategicResource,                         -- 生产单位消耗的战略资源，指向Resources表的ResourceType列。消耗的数量在Units_XP2表的ResourceCost列指定。
       PurchaseYield,                             -- 购买方式
       MustPurchase,                              -- 只能购买
       Maintenance,                               -- 维护费
       Stackable,                                 -- 是否可以堆叠（在一个单元格上存在多个该单位）
       AirSlots,                                  -- 能承载的空军单位数量
       CanTargetAir,                              -- 是否能攻击空军单位
       PseudoYieldType,
       ZoneOfControl,                             -- 是否有区域控制
       AntiAirCombat,                             -- 防空力
       Spy,                                       -- 是间谍
       WMDCapable,
       ParkCharges,                               -- 建立国家公园次数
       IgnoreMoves,                               -- 是否不按正常规则移动（例如商人、间谍、飞机）
       TeamVisibility,                            -- 同队可见
       ObsoleteTech,                              -- 过时科技
       ObsoleteCivic,                             -- 过时市政
       MandatoryObsoleteTech,                     -- 强制过时科技
       MandatoryObsoleteCivic,                    -- 强制过时市政
       AdvisorType,                               -- 顾问类型
       EnabledByReligion,                         -- 是否需要信条解锁
       TrackReligion,                             -- 是否记录该单位信仰的宗教
       DisasterCharges,                           -- 制造灾害次数
       UseMaxMeleeTrainedStrength,                -- 使用最大近战攻击力
       ImmediatelyName,                           -- 是否需要在出现后立刻命名
       CanEarnExperience                          -- 是否能获得经验
FROM Units
WHERE UnitType = 'UNIT_TREBUCHET';


INSERT INTO TypeTags
    (Type, Tag)
SELECT 'UNIT_NIULI', Tag
FROM TypeTags
WHERE Type = 'UNIT_TREBUCHET';


INSERT OR IGNORE INTO Types(Type, Kind)
VALUES ( 'ABILITY_UNIT_NIULI','KIND_ABILITY');
INSERT OR IGNORE INTO Tags(Tag, Vocabulary)
VALUES ('CLASS_UNIT_NIULI','ABILITY_CLASS');
INSERT OR IGNORE INTO TypeTags(Type,Tag)
VALUES ('ABILITY_UNIT_NIULI','CLASS_UNIT_NIULI'),
       ('UNIT_NIULI','CLASS_UNIT_NIULI');
INSERT OR IGNORE INTO UnitAbilities(UnitAbilityType,Name,Description)
VALUES ( 'ABILITY_UNIT_NIULI' ,'LOC_ABILITY_UNIT_NIULI_NAME','LOC_ABILITY_UNIT_NIULI_NAME');

INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
('ABILITY_UNIT_NIULI', 'MODIFIER_ABILITY_UNIT_NIULI_ADD_COMBAT');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_ABILITY_UNIT_NIULI_ADD_COMBAT', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 0, 0, 0, 'REQSET_MODIFIER_ABILITY_UNIT_NIULI_ADD_COMBAT', NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_ABILITY_UNIT_NIULI_ADD_COMBAT', 'Amount', '3');
INSERT INTO ModifierStrings (ModifierId, Context, Text) VALUES
('MODIFIER_ABILITY_UNIT_NIULI_ADD_COMBAT', 'Preview', 'LOC_MODIFIER_ABILITY_UNIT_NIULI_ADD_COMBAT');
-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('REQSET_MODIFIER_ABILITY_UNIT_NIULI_ADD_COMBAT', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('REQSET_MODIFIER_ABILITY_UNIT_NIULI_ADD_COMBAT', 'REQ_MODIFIER_ABILITY_UNIT_NIULI_ADD_COMBAT');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('REQ_MODIFIER_ABILITY_UNIT_NIULI_ADD_COMBAT', 'REQUIREMENT_PLOT_ADJACENT_UNIT_TYPE_MATCHES');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('REQ_MODIFIER_ABILITY_UNIT_NIULI_ADD_COMBAT', 'MaxRange', '0'),
('REQ_MODIFIER_ABILITY_UNIT_NIULI_ADD_COMBAT', 'MinRange', '0'),
('REQ_MODIFIER_ABILITY_UNIT_NIULI_ADD_COMBAT', 'UnitType', 'UNIT_MILITARY_ENGINEER');
