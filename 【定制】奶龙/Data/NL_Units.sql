--	FILE: NL_Unit.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/10/6 11:26:46
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

-- 单位基础类型、标签、分类
INSERT INTO Types(Type, Kind)
VALUES ('UNIT_QZJ_NL', 'KIND_UNIT');

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
SELECT 'UNIT_QZJ_NL',                 -- 类型
       'LOC_UNIT_QZJ_NL_NAME',        -- 名称
       BaseSightRange,                --视野
       BaseMoves,                     -- 移动力
       Combat,                        -- 近战力
       RangedCombat,                  -- 远程力
       Range,                         -- 射程
       Bombard,                       -- 轰炸力
       Domain,                        -- 单位的海陆空类别。可用值：DOMAIN_LAND陆地单位，DOMAIN_SEA海上单位，DOMAIN_AIR空中单位。
       FormationClass,                -- 单位的编队类别，指向UnitFormationClasses表的FormationClassType列。可用值：FORMATION_CLASS_CIVILIAN平民单位，FORMATION_CLASS_LAND_COMBAT陆地战斗单位，FORMATION_CLASS_NAVAL海上战斗单位，FORMATION_CLASS_SUPPORT支援单位，FORMATION_CLASS_AIR空中战斗单位。
       Cost,                          -- 生产力
       999,                -- 消耗人口
       FoundCity,                     -- 能否创建城市
       FoundReligion,                 -- 能否创建宗教
       MakeTradeRoute,                -- 能否创建商路
       EvangelizeBelief,              -- 能否纳入新信仰
       LaunchInquisition,             -- 是否能开启宗教审讯
       RequiresInquisition,           -- 是否需要已开启宗教审讯才能生产/购买
       1,                             -- 劳动力
       ReligiousStrength,             -- 宗教战斗力
       ReligionEvictPercent,          -- 压教比例
       SpreadCharges,                 -- 传教次数
       ReligiousHealCharges,          -- 宗教治疗次数
       ExtractsArtifacts,             -- 是否可以挖掘文物。
       'LOC_UNIT_QZJ_NL_DESCRIPTION', -- 描述文本
       Flavor,
       CanCapture,                    -- 可以俘虏平民单位
       CanRetreatWhenCaptured,        -- 被俘虏时传送回最近城市
       'TRAIT_UNIT_QZJ_NL',           -- 绑定特性
       AllowBarbarians,               -- 允许蛮族生成
       CostProgressionModel,          -- 涨价方式 NO_COST_PROGRESSION不涨价
       CostProgressionParam1,         -- 涨价参数 COST_PROGRESSION_GAME_PROGRESS按游戏进程涨价 CostProgressionParam1填最终（即全科技/市政后的）价格百分比 COST_PROGRESSION_PREVIOUS_COPIES按已有数量涨价 CostProgressionParam1填每一个涨价的数量
       PromotionClass,                -- 单位的晋升树，指向UnitPromotionClasses表的PromotionClassType列。
       InitialLevel,                  -- 单位的初始等级，1是没有初始升级，2是附赠1级初始升级，以此类推。
       NumRandomChoices,              -- 单位升级时从所有升级里随机抽出的数量
       PrereqTech,                    -- 前置科技
       PrereqCivic,                   -- 前置市政
       PrereqDistrict,                -- 前置区域
       PrereqPopulation,              -- 消耗人口
       LeaderType,                    --
       CanTrain,                      -- 可生产
       StrategicResource,             -- 生产单位消耗的战略资源，指向Resources表的ResourceType列。消耗的数量在Units_XP2表的ResourceCost列指定。
       NULL,                          -- 购买方式
       1,                             -- 只能购买
       Maintenance,                   -- 维护费
       Stackable,                     -- 是否可以堆叠（在一个单元格上存在多个该单位）
       AirSlots,                      -- 能承载的空军单位数量
       CanTargetAir,                  -- 是否能攻击空军单位
       PseudoYieldType,
       ZoneOfControl,                 -- 是否有区域控制
       AntiAirCombat,                 -- 防空力
       Spy,                           -- 是间谍
       WMDCapable,
       ParkCharges,                   -- 建立国家公园次数
       IgnoreMoves,                   -- 是否不按正常规则移动（例如商人、间谍、飞机）
       TeamVisibility,                -- 同队可见
       ObsoleteTech,                  -- 过时科技
       ObsoleteCivic,                 -- 过时市政
       MandatoryObsoleteTech,         -- 强制过时科技
       MandatoryObsoleteCivic,        -- 强制过时市政
       AdvisorType,                   -- 顾问类型
       EnabledByReligion,             -- 是否需要信条解锁
       TrackReligion,                 -- 是否记录该单位信仰的宗教
       DisasterCharges,               -- 制造灾害次数
       UseMaxMeleeTrainedStrength,    -- 使用最大近战攻击力
       ImmediatelyName,               -- 是否需要在出现后立刻命名
       CanEarnExperience              -- 是否能获得经验
FROM Units
WHERE UnitType = 'UNIT_BUILDER';

INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_UNIT_QZJ_NL', 'MODIFIER_TRAIT_UNIT_QZJ_NL_CAPITAL');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_UNIT_QZJ_NL_CAPITAL', 'MODIFIER_PLAYER_GRANT_UNIT_IN_CAPITAL', 0, 1, 0, 'PLAYER_HAS_NL_FD', NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_UNIT_QZJ_NL_CAPITAL', 'AllowUniqueOverride', '1'),
('MODIFIER_TRAIT_UNIT_QZJ_NL_CAPITAL', 'Amount', '1'),
('MODIFIER_TRAIT_UNIT_QZJ_NL_CAPITAL', 'UnitType', 'UNIT_QZJ_NL');
-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('PLAYER_HAS_NL_FD', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('PLAYER_HAS_NL_FD', 'REQ_PLAYER_HAS_NL_FD');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('REQ_PLAYER_HAS_NL_FD', 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('REQ_PLAYER_HAS_NL_FD', 'CivicType', 'CIVIC_CODE_OF_LAWS');

INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES ('TRAIT_UNIT_QZJ_NL', 'MODIFIER_TRAIT_UNIT_QZJ_NL_GRANT_UNIT');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_TRAIT_UNIT_QZJ_NL_GRANT_UNIT', 'MODIFIER_PLAYER_GRANT_UNITS_NW_NL', 0, 1, 0, 'PLAYER_HAS_GL_NL',
        NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_TRAIT_UNIT_QZJ_NL_GRANT_UNIT', 'AllowUniqueOverride', '1'),
       ('MODIFIER_TRAIT_UNIT_QZJ_NL_GRANT_UNIT', 'Amount', '1'),
       ('MODIFIER_TRAIT_UNIT_QZJ_NL_GRANT_UNIT', 'UnitType', 'UNIT_QZJ_NL');


-- Custom ModifierType
INSERT INTO Types (Type, Kind)
VALUES ('MODIFIER_PLAYER_GRANT_UNITS_NW_NL', 'KIND_MODIFIER');
INSERT INTO DynamicModifiers (ModifierType, CollectionType, EffectType)
VALUES ('MODIFIER_PLAYER_GRANT_UNITS_NW_NL', 'COLLECTION_PLAYER_CITIES', 'EFFECT_GRANT_UNIT_IN_CITY');
-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('PLAYER_HAS_GL_NL', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('PLAYER_HAS_GL_NL', 'REQ_PLAYER_HAS_GL_NL');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('REQ_PLAYER_HAS_GL_NL', 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('REQ_PLAYER_HAS_GL_NL', 'CivicType', 'CIVIC_STATE_WORKFORCE');

--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

-- 单位基础类型、标签、分类
INSERT INTO Types(Type, Kind)
VALUES ('UNIT_QZJ_NLDD', 'KIND_UNIT');

INSERT INTO TypeTags(Type, Tag)
SELECT 'UNIT_QZJ_NLDD', Tag
FROM TypeTags
WHERE Type = 'UNIT_WARRIOR';

INSERT INTO UnitAiInfos(UnitType, AiType)
SELECT 'UNIT_QZJ_NLDD', AiType
FROM UnitAiInfos
WHERE UnitType = 'UNIT_WARRIOR';

-- 单位是否替代原型单位

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
SELECT 'UNIT_QZJ_NLDD',                 -- 类型
       'LOC_UNIT_QZJ_NLDD_NAME',        -- 名称
       BaseSightRange,                  --视野
       BaseMoves,                       -- 移动力
       Combat,                          -- 近战力
       RangedCombat,                    -- 远程力
       Range,                           -- 射程
       Bombard,                         -- 轰炸力
       Domain,                          -- 单位的海陆空类别。可用值：DOMAIN_LAND陆地单位，DOMAIN_SEA海上单位，DOMAIN_AIR空中单位。
       FormationClass,                  -- 单位的编队类别，指向UnitFormationClasses表的FormationClassType列。可用值：FORMATION_CLASS_CIVILIAN平民单位，FORMATION_CLASS_LAND_COMBAT陆地战斗单位，FORMATION_CLASS_NAVAL海上战斗单位，FORMATION_CLASS_SUPPORT支援单位，FORMATION_CLASS_AIR空中战斗单位。
       30,                              -- 生产力
       PopulationCost,                  -- 消耗人口
       FoundCity,                       -- 能否创建城市
       FoundReligion,                   -- 能否创建宗教
       MakeTradeRoute,                  -- 能否创建商路
       EvangelizeBelief,                -- 能否纳入新信仰
       LaunchInquisition,               -- 是否能开启宗教审讯
       RequiresInquisition,             -- 是否需要已开启宗教审讯才能生产/购买
       0,                               -- 劳动力
       ReligiousStrength,               -- 宗教战斗力
       ReligionEvictPercent,            -- 压教比例
       SpreadCharges,                   -- 传教次数
       ReligiousHealCharges,            -- 宗教治疗次数
       ExtractsArtifacts,               -- 是否可以挖掘文物。
       'LOC_UNIT_QZJ_NLDD_DESCRIPTION', -- 描述文本
       Flavor,
       CanCapture,                      -- 可以俘虏平民单位
       CanRetreatWhenCaptured,          -- 被俘虏时传送回最近城市
       'TRAIT_UNIT_QZJ_NLDD',           -- 绑定特性
       AllowBarbarians,                 -- 允许蛮族生成
       CostProgressionModel,            -- 涨价方式 NO_COST_PROGRESSION不涨价
       CostProgressionParam1,           -- 涨价参数 COST_PROGRESSION_GAME_PROGRESS按游戏进程涨价 CostProgressionParam1填最终（即全科技/市政后的）价格百分比 COST_PROGRESSION_PREVIOUS_COPIES按已有数量涨价 CostProgressionParam1填每一个涨价的数量
       PromotionClass,                  -- 单位的晋升树，指向UnitPromotionClasses表的PromotionClassType列。
       InitialLevel,                    -- 单位的初始等级，1是没有初始升级，2是附赠1级初始升级，以此类推。
       NumRandomChoices,                -- 单位升级时从所有升级里随机抽出的数量
       NULL,                      -- 前置科技
       'CIVIC_CODE_OF_LAWS',                     -- 前置市政
       PrereqDistrict,                  -- 前置区域
       PrereqPopulation,                -- 消耗人口
       LeaderType,                      --
       CanTrain,                        -- 可生产
       StrategicResource,               -- 生产单位消耗的战略资源，指向Resources表的ResourceType列。消耗的数量在Units_XP2表的ResourceCost列指定。
       'YIELD_GOLD',                    -- 购买方式
       1,                               -- 只能购买
       Maintenance,                     -- 维护费
       Stackable,                       -- 是否可以堆叠（在一个单元格上存在多个该单位）
       AirSlots,                        -- 能承载的空军单位数量
       CanTargetAir,                    -- 是否能攻击空军单位
       PseudoYieldType,
       ZoneOfControl,                   -- 是否有区域控制
       AntiAirCombat,                   -- 防空力
       Spy,                             -- 是间谍
       WMDCapable,
       ParkCharges,                     -- 建立国家公园次数
       IgnoreMoves,                     -- 是否不按正常规则移动（例如商人、间谍、飞机）
       TeamVisibility,                  -- 同队可见
       ObsoleteTech,                    -- 过时科技
       ObsoleteCivic,                   -- 过时市政
       MandatoryObsoleteTech,           -- 强制过时科技
       MandatoryObsoleteCivic,          -- 强制过时市政
       AdvisorType,                     -- 顾问类型
       EnabledByReligion,               -- 是否需要信条解锁
       TrackReligion,                   -- 是否记录该单位信仰的宗教
       DisasterCharges,                 -- 制造灾害次数
       1,      -- 使用最大近战攻击力
       ImmediatelyName,                 -- 是否需要在出现后立刻命名
       CanEarnExperience                -- 是否能获得经验
FROM Units
WHERE UnitType = 'UNIT_WARRIOR';


INSERT INTO Units_XP2 (UnitType, CanFormMilitaryFormation)
VALUES ('UNIT_QZJ_NLDD', 0);

INSERT INTO Types
    (Type, Kind)
VALUES ('ABILITY_UNIT_QZJ_NLDD', 'KIND_ABILITY');
INSERT INTO Tags
    (Tag, Vocabulary)
VALUES ('CLASS_UNIT_QZJ_NLDD', 'ABILITY_CLASS');
INSERT INTO TypeTags
    (Type, Tag)
VALUES ('UNIT_QZJ_NLDD', 'CLASS_UNIT_QZJ_NLDD'),
       ('ABILITY_UNIT_QZJ_NLDD', 'CLASS_UNIT_QZJ_NLDD');
INSERT INTO UnitAbilities
    (UnitAbilityType, Name, Description, Inactive)
VALUES ('ABILITY_UNIT_QZJ_NLDD', 'LOC_UNIT_QZJ_NLDD_NAME', 'LOC_UNIT_QZJ_NLDD_DESCRIPTION', 0);

INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
('ABILITY_UNIT_QZJ_NLDD', 'MODFEAT_ABILITY_UNIT_QZJ_NLDD_FAILSAFE');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODFEAT_ABILITY_UNIT_QZJ_NLDD_FAILSAFE', 'MODIFIER_PLAYER_UNIT_BUILD_DISABLED', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODFEAT_ABILITY_UNIT_QZJ_NLDD_FAILSAFE', 'UnitType', 'UNIT_QZJ_NLDD');

INSERT OR IGNORE INTO RequirementSets(RequirementSetId, RequirementSetType)
SELECT 'NW_PLAYER_HAS_' || TechnologyType, 'REQUIREMENTSET_TEST_ALL'
FROM Technologies;
INSERT OR IGNORE INTO Requirements(RequirementId, RequirementType)
SELECT 'NW_UTILS_PLAYER_HAS_' || TechnologyType || '_REQUIREMENT', 'REQUIREMENT_PLAYER_HAS_TECHNOLOGY'
FROM Technologies;
INSERT OR IGNORE INTO RequirementArguments(RequirementId, Name, Value)
SELECT 'NW_UTILS_PLAYER_HAS_' || TechnologyType || '_REQUIREMENT', 'TechnologyType', TechnologyType
FROM Technologies;
INSERT OR IGNORE INTO RequirementSetRequirements(RequirementSetId, RequirementId)
SELECT 'NW_PLAYER_HAS_' || TechnologyType, 'NW_UTILS_PLAYER_HAS_' || TechnologyType || '_REQUIREMENT'
FROM Technologies;


INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
('ABILITY_UNIT_QZJ_NLDD', 'MODIFIER_ABILITY_UNIT_QZJ_NLDD_MOVEMENT1');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_ABILITY_UNIT_QZJ_NLDD_MOVEMENT1', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 0, 0, 0, 'NW_PLAYER_HAS_TECH_STIRRUPS', NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_ABILITY_UNIT_QZJ_NLDD_MOVEMENT1', 'Amount', '1');


INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
('ABILITY_UNIT_QZJ_NLDD', 'MODIFIER_ABILITY_UNIT_QZJ_NLDD_MOVEMENT2');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_ABILITY_UNIT_QZJ_NLDD_MOVEMENT2', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 0, 0, 0, 'NW_PLAYER_HAS_TECH_PRINTING', NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_ABILITY_UNIT_QZJ_NLDD_MOVEMENT2', 'Amount', '1');

INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
('ABILITY_UNIT_QZJ_NLDD', 'MODIFIER_ABILITY_UNIT_QZJ_NLDD_MOVEMENT3');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_ABILITY_UNIT_QZJ_NLDD_MOVEMENT3', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 0, 0, 0, 'NW_PLAYER_HAS_TECH_RIFLING', NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_ABILITY_UNIT_QZJ_NLDD_MOVEMENT3', 'Amount', '1');

-- 解锁合成材料科技后无视地形地貌带来的移动力减益。

INSERT OR
REPLACE INTO UnitAbilityModifiers(UnitAbilityType, ModifierId)
VALUES ('ABILITY_UNIT_QZJ_NLDD', 'NLDD_IGNORE_RIVER'),
       ('ABILITY_UNIT_QZJ_NLDD', 'NLDD_IGNORE_SHORES'),
       ('ABILITY_UNIT_QZJ_NLDD', 'NLDD_IGNORE_TERRAINS_COST');

INSERT OR
REPLACE INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId)
VALUES ('NLDD_IGNORE_RIVER', 'MODIFIER_PLAYER_UNIT_ADJUST_IGNORE_RIVERS', 'NW_PLAYER_HAS_TECH_SYNTHETIC_MATERIALS'),
       ('NLDD_IGNORE_SHORES', 'MODIFIER_PLAYER_UNIT_ADJUST_IGNORE_SHORES', 'NW_PLAYER_HAS_TECH_SYNTHETIC_MATERIALS'),
       ('NLDD_IGNORE_TERRAINS_COST', 'MODIFIER_PLAYER_UNIT_ADJUST_IGNORE_TERRAIN_COST', 'NW_PLAYER_HAS_TECH_SYNTHETIC_MATERIALS');

INSERT OR
REPLACE INTO ModifierArguments(ModifierId, Name, Value)
VALUES ('NLDD_IGNORE_RIVER', 'Ignore', 1),
       ('NLDD_IGNORE_SHORES', 'Ignore', 1),
       ('NLDD_IGNORE_TERRAINS_COST', 'Ignore', 1),
       ('NLDD_IGNORE_TERRAINS_COST', 'Type', 'ALL');


-- 奶龙大帝击杀敌方文明或城邦的单位时，奶龙的宗教将传播到附近的城市。
INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
('ABILITY_UNIT_QZJ_NLDD', 'MODIFIER_ABILITY_UNIT_QZJ_NLDD_LAND_VICTORY_SPREAD');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_ABILITY_UNIT_QZJ_NLDD_LAND_VICTORY_SPREAD', 'MODIFIER_PLAYER_UNIT_ADJUST_LAND_VICTORY_SPREAD', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_ABILITY_UNIT_QZJ_NLDD_LAND_VICTORY_SPREAD', 'LandVictorySpread', '1');

-- 从每2座信奉奶龙宗教的外国城市获得1点 [ICON_Strength] 战斗力。
INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
('ABILITY_UNIT_QZJ_NLDD', 'MODIFIER_ABILITY_UNIT_QZJ_NLDD_COMBAT');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_ABILITY_UNIT_QZJ_NLDD_COMBAT', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_ABILITY_UNIT_QZJ_NLDD_COMBAT', 'Key', 'ABILITY_UNIT_QZJ_NLDD');
INSERT INTO ModifierStrings (ModifierId, Context, Text) VALUES
('MODIFIER_ABILITY_UNIT_QZJ_NLDD_COMBAT', 'Preview', 'LOC_MODIFIER_ABILITY_UNIT_QZJ_NLDD_COMBAT');


--================
-- 伟人：小七
--================
INSERT INTO Types (Type, Kind)
VALUES	('GREAT_PERSON_CLASS_XIAOQI', 'KIND_GREAT_PERSON_CLASS'),
		('GREAT_PERSON_INDIVIDUAL_XIAOQI_0',	'KIND_GREAT_PERSON_INDIVIDUAL');

INSERT INTO Types (Type, Kind)
VALUES	('PSEUDOYIELD_GPP_XIAOQI',			'KIND_PSEUDOYIELD');

INSERT INTO PseudoYields (PseudoYieldType, DefaultValue)
VALUES	('PSEUDOYIELD_GPP_XIAOQI', 0.5);

INSERT INTO GreatPersonClasses
(GreatPersonClassType, Name, UnitType, DistrictType, AvailableInTimeline, GenerateDuplicateIndividuals, PseudoYieldType, IconString, ActionIcon)
VALUES
('GREAT_PERSON_CLASS_XIAOQI',
 'LOC_GREAT_PERSON_CLASS_GENERAL_NAME',
 'UNIT_GREAT_GENERAL',
 'DISTRICT_CITY_CENTER',
 0,
 1,
 'PSEUDOYIELD_GPP_XIAOQI',
 '[ICON_GreatGeneral]',
 'ICON_UNITOPERATION_GENERAL_ACTION');

INSERT INTO GreatPersonIndividuals (GreatPersonIndividualType, Name, GreatPersonClassType, EraType, Gender, ActionCharges)
VALUES
('GREAT_PERSON_INDIVIDUAL_XIAOQI_0',
 'LOC_UNIT_XIAOQI_NAME',
 'GREAT_PERSON_CLASS_XIAOQI',
 'ERA_ANCIENT',
 'M',
 1);

INSERT INTO CivilopediaPageGroupExcludes(SectionId, PageGroupId)
VALUES 	('GREATPEOPLE', 'GREAT_PERSON_CLASS_XIAOQI');

INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_UNIT_QZJ_NLDD', 'MODIFIER_ABILITY_GREAT_PERSON_INDIVIDUAL_XIAOQI_0_SIGHT');
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
('MODIFIER_ABILITY_GREAT_PERSON_INDIVIDUAL_XIAOQI_0_SIGHT', 'MODIFIER_NWNL_PLAYER_UNITS_ADJUST_SIGHT', 'UNIT_IS_XQ');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_ABILITY_GREAT_PERSON_INDIVIDUAL_XIAOQI_0_SIGHT', 'Amount', '1');

-- Custom ModifierType
INSERT INTO Types (Type, Kind) VALUES
('MODIFIER_NWNL_PLAYER_UNITS_ADJUST_SIGHT', 'KIND_MODIFIER');
INSERT INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES
('MODIFIER_NWNL_PLAYER_UNITS_ADJUST_SIGHT', 'COLLECTION_PLAYER_UNITS', 'EFFECT_ADJUST_UNIT_SIGHT');

-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('UNIT_IS_XQ', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('UNIT_IS_XQ', 'REQ_UNIT_IS_XQ');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('REQ_UNIT_IS_XQ', 'REQUIREMENT_GREAT_PERSON_TYPE_MATCHES');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('REQ_UNIT_IS_XQ', 'GreatPersonClassType', 'GREAT_PERSON_CLASS_XIAOQI');


INSERT INTO Types(Type, Kind)
VALUES ('UNIT_XIAOQI', 'KIND_UNIT');
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
SELECT 'UNIT_XIAOQI',                 -- 类型
       'LOC_UNIT_XIAOQI_NAME',        -- 名称
       BaseSightRange,                  --视野
       BaseMoves,                       -- 移动力
       Combat,                          -- 近战力
       RangedCombat,                    -- 远程力
       Range,                           -- 射程
       Bombard,                         -- 轰炸力
       Domain,                          -- 单位的海陆空类别。可用值：DOMAIN_LAND陆地单位，DOMAIN_SEA海上单位，DOMAIN_AIR空中单位。
       FormationClass,                  -- 单位的编队类别，指向UnitFormationClasses表的FormationClassType列。可用值：FORMATION_CLASS_CIVILIAN平民单位，FORMATION_CLASS_LAND_COMBAT陆地战斗单位，FORMATION_CLASS_NAVAL海上战斗单位，FORMATION_CLASS_SUPPORT支援单位，FORMATION_CLASS_AIR空中战斗单位。
       15,                              -- 生产力
       PopulationCost,                  -- 消耗人口
       FoundCity,                       -- 能否创建城市
       FoundReligion,                   -- 能否创建宗教
       MakeTradeRoute,                  -- 能否创建商路
       EvangelizeBelief,                -- 能否纳入新信仰
       LaunchInquisition,               -- 是否能开启宗教审讯
       RequiresInquisition,             -- 是否需要已开启宗教审讯才能生产/购买
       1,                               -- 劳动力
       ReligiousStrength,               -- 宗教战斗力
       ReligionEvictPercent,            -- 压教比例
       SpreadCharges,                   -- 传教次数
       ReligiousHealCharges,            -- 宗教治疗次数
       ExtractsArtifacts,               -- 是否可以挖掘文物。
       'LOC_UNIT_XIAOQI_DESCRIPTION', -- 描述文本
       Flavor,
       CanCapture,                      -- 可以俘虏平民单位
       CanRetreatWhenCaptured,          -- 被俘虏时传送回最近城市
       'TRAIT_UNIT_QZJ_NLDD',           -- 绑定特性
       AllowBarbarians,                 -- 允许蛮族生成
       CostProgressionModel,            -- 涨价方式 NO_COST_PROGRESSION不涨价
       CostProgressionParam1,           -- 涨价参数 COST_PROGRESSION_GAME_PROGRESS按游戏进程涨价 CostProgressionParam1填最终（即全科技/市政后的）价格百分比 COST_PROGRESSION_PREVIOUS_COPIES按已有数量涨价 CostProgressionParam1填每一个涨价的数量
       PromotionClass,                  -- 单位的晋升树，指向UnitPromotionClasses表的PromotionClassType列。
       InitialLevel,                    -- 单位的初始等级，1是没有初始升级，2是附赠1级初始升级，以此类推。
       NumRandomChoices,                -- 单位升级时从所有升级里随机抽出的数量
       PrereqTech,                      -- 前置科技
       'CIVIC_CODE_OF_LAWS',                     -- 前置市政
       PrereqDistrict,                  -- 前置区域
       PrereqPopulation,                -- 消耗人口
       LeaderType,                      --
       CanTrain,                        -- 可生产
       StrategicResource,               -- 生产单位消耗的战略资源，指向Resources表的ResourceType列。消耗的数量在Units_XP2表的ResourceCost列指定。
       NULL,                    -- 购买方式
       1,                               -- 只能购买
       Maintenance,                     -- 维护费
       Stackable,                       -- 是否可以堆叠（在一个单元格上存在多个该单位）
       AirSlots,                        -- 能承载的空军单位数量
       CanTargetAir,                    -- 是否能攻击空军单位
       PseudoYieldType,
       ZoneOfControl,                   -- 是否有区域控制
       AntiAirCombat,                   -- 防空力
       Spy,                             -- 是间谍
       WMDCapable,
       ParkCharges,                     -- 建立国家公园次数
       IgnoreMoves,                     -- 是否不按正常规则移动（例如商人、间谍、飞机）
       TeamVisibility,                  -- 同队可见
       ObsoleteTech,                    -- 过时科技
       ObsoleteCivic,                   -- 过时市政
       MandatoryObsoleteTech,           -- 强制过时科技
       MandatoryObsoleteCivic,          -- 强制过时市政
       AdvisorType,                     -- 顾问类型
       EnabledByReligion,               -- 是否需要信条解锁
       TrackReligion,                   -- 是否记录该单位信仰的宗教
       DisasterCharges,                 -- 制造灾害次数
       UseMaxMeleeTrainedStrength,      -- 使用最大近战攻击力
       ImmediatelyName,                 -- 是否需要在出现后立刻命名
       CanEarnExperience                -- 是否能获得经验
FROM Units
WHERE UnitType = 'UNIT_GREAT_GENERAL';