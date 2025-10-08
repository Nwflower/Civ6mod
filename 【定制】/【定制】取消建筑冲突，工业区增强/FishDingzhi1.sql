-- 二、兵营马厩
-- 市场灯塔加商线
-- 艺术考古博物馆
-- 社区食品购物市场不冲突
-- 描述记得修改
-- （例如删掉无法建造在...，例如如无市场则+1商线改成+1商线等），还有等价的特色建筑也记得修改，例如波兰纺织会馆、马其顿皇家学堂、蒙古斡耳朵等

DELETE
FROM MutuallyExclusiveBuildings
WHERE Building = 'BUILDING_STABLE';
DELETE
FROM MutuallyExclusiveBuildings
WHERE MutuallyExclusiveBuilding = 'BUILDING_STABLE';
DELETE
FROM MutuallyExclusiveBuildings
WHERE Building = 'BUILDING_BARRACKS';
DELETE
FROM MutuallyExclusiveBuildings
WHERE MutuallyExclusiveBuilding = 'BUILDING_BARRACKS';

DELETE
FROM MutuallyExclusiveBuildings
WHERE Building = 'BUILDING_MUSEUM_ARTIFACT';
DELETE
FROM MutuallyExclusiveBuildings
WHERE MutuallyExclusiveBuilding = 'BUILDING_MUSEUM_ARTIFACT';
DELETE
FROM MutuallyExclusiveBuildings
WHERE Building = 'BUILDING_MUSEUM_ART';
DELETE
FROM MutuallyExclusiveBuildings
WHERE MutuallyExclusiveBuilding = 'BUILDING_MUSEUM_ART';

DELETE
FROM MutuallyExclusiveBuildings
WHERE Building = 'BUILDING_FOOD_MARKET';
DELETE
FROM MutuallyExclusiveBuildings
WHERE MutuallyExclusiveBuilding = 'BUILDING_FOOD_MARKET';
DELETE
FROM MutuallyExclusiveBuildings
WHERE Building = 'BUILDING_SHOPPING_MALL';
DELETE
FROM MutuallyExclusiveBuildings
WHERE MutuallyExclusiveBuilding = 'BUILDING_SHOPPING_MALL';

UPDATE Modifiers
SET SubjectRequirementSetId = NULL
WHERE SubjectRequirementSetId = 'LIGHTHOUSE_TRADE_ROUTE_CAPACITY_REQUIREMENTS';
UPDATE Buildings
SET Description = 'LOC_BUILDING_LIGHTHOUSE_EXPANSION2_DESCRIPTION'
WHERE BuildingType = 'BUILDING_LIGHTHOUSE';
-- 三、工业区相关：
-- 工作坊的基础+3生产力，改成+6生产力
-- 工厂的基础+3有电再+3，日本电子厂+3有电再+5，都改为基础+3有电再+6
-- 燃油发电厂的基础+3生产力，改成+6生产力
-- 核电厂的基础+4生产力，改成+12生产力，1铀16电改成1铀64电
UPDATE Building_YieldChanges
SET YieldChange = 6
WHERE BuildingType = 'BUILDING_WORKSHOP';
UPDATE Building_YieldChangesBonusWithPower
SET YieldChange = 6
WHERE BuildingType = 'BUILDING_FACTORY';
UPDATE Building_YieldChangesBonusWithPower
SET YieldChange = 6
WHERE BuildingType = 'BUILDING_ELECTRONICS_FACTORY';
UPDATE Building_YieldChanges
SET YieldChange = 6
WHERE BuildingType = 'BUILDING_FOSSIL_FUEL_POWER_PLANT';
UPDATE Building_YieldChanges
SET YieldChange = 12
WHERE BuildingType = 'BUILDING_POWER_PLANT';
UPDATE Resource_Consumption
SET PowerProvided = 64
WHERE ResourceType = 'RESOURCE_URANIUM';

-- 第二次定制
-- 燃煤辐射
-- UPDATE Buildings
-- SET RegionalRange = 6
-- WHERE BuildingType = 'BUILDING_COAL_POWER_PLANT';
UPDATE Districts
SET Cost=54
WHERE DistrictType IN ('DISTRICT_AQUEDUCT', 'DISTRICT_DAM', 'DISTRICT_CANAL');
UPDATE Districts
SET Cost=27
WHERE DistrictType = 'DISTRICT_BATH';

-- 运河商路
INSERT INTO DistrictModifiers(DistrictType, ModifierId)
VALUES ('DISTRICT_CANAL', 'MARKET_TRADE_ROUTE_CAPACITY');

-- 水渠、浴场余粮
INSERT INTO DistrictModifiers (DistrictType, ModifierId)
VALUES ('DISTRICT_AQUEDUCT', 'MODIFIER_DISTRICT_AQUEDUCT_ADD_GROWTH'),
       ('DISTRICT_BATH', 'MODIFIER_DISTRICT_AQUEDUCT_ADD_GROWTH');
INSERT INTO Modifiers (ModifierId, ModifierType)
VALUES ('MODIFIER_DISTRICT_AQUEDUCT_ADD_GROWTH', 'MODIFIER_SINGLE_CITY_ADJUST_CITY_GROWTH');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_DISTRICT_AQUEDUCT_ADD_GROWTH', 'Amount', '20');

-- 人头粮
INSERT INTO DistrictModifiers (DistrictType, ModifierId)
VALUES ('DISTRICT_AQUEDUCT', 'MODIFIER_DISTRICT_AQUEDUCT_ADD_FOOD'),
       ('DISTRICT_BATH', 'MODIFIER_DISTRICT_AQUEDUCT_ADD_FOOD');
INSERT INTO Modifiers (ModifierId, ModifierType)
VALUES ('MODIFIER_DISTRICT_AQUEDUCT_ADD_FOOD', 'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_DISTRICT_AQUEDUCT_ADD_FOOD', 'Amount', '0.5'),
       ('MODIFIER_DISTRICT_AQUEDUCT_ADD_FOOD', 'YieldType', 'YIELD_FOOD');

-- 堤坝 农场、种植园+1食物
INSERT INTO DistrictModifiers (DistrictType, ModifierId)
VALUES ('DISTRICT_DAM', 'MODIFIER_DISTRICT_DAM_ADD_FOOD');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_DISTRICT_DAM_ADD_FOOD', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 0, 0, 0, NULL,
        'NW_FD_PLOTS_HAS_DAM_IMPROVEMENT');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_DISTRICT_DAM_ADD_FOOD', 'Amount', '1'),
       ('MODIFIER_DISTRICT_DAM_ADD_FOOD', 'YieldType', 'YIELD_FOOD');
-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('NW_FD_PLOTS_HAS_DAM_IMPROVEMENT', 'REQUIREMENTSET_TEST_ANY');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('NW_FD_PLOTS_HAS_DAM_IMPROVEMENT', 'NW_FD_PLOTS_HAS_FARM'),
       ('NW_FD_PLOTS_HAS_DAM_IMPROVEMENT', 'NW_FD_PLOTS_HAS_PLANTATION');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('NW_FD_PLOTS_HAS_FARM', 'REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES'),
       ('NW_FD_PLOTS_HAS_PLANTATION', 'REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('NW_FD_PLOTS_HAS_FARM', 'ImprovementType', 'IMPROVEMENT_FARM'),
       ('NW_FD_PLOTS_HAS_PLANTATION', 'ImprovementType', 'IMPROVEMENT_PLANTATION');

-- 保护区
UPDATE Districts
SET Appeal = 3
WHERE DistrictType = 'DISTRICT_PRESERVE';
UPDATE Adjacent_AppealYieldChanges
set Unimproved = 0
where DistrictType = 'DISTRICT_PRESERVE';

-- 外交区
INSERT INTO DistrictModifiers (DistrictType, ModifierId)
VALUES ('DISTRICT_DIPLOMATIC_QUARTER', 'MODIFIER_DISTRICT_DIPLOMATIC_QUARTER_INFLUENCE_POINTS');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODIFIER_DISTRICT_DIPLOMATIC_QUARTER_INFLUENCE_POINTS', 'MODIFIER_PLAYER_ADJUST_INFLUENCE_POINTS_PER_TURN', 0,
        0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODIFIER_DISTRICT_DIPLOMATIC_QUARTER_INFLUENCE_POINTS', 'Amount', '1');

-- 关闭发电厂常驻
UPDATE Projects_XP2
SET UnlocksFromEffect = 0
WHERE ProjectType IN ('PROJECT_DECOMMISSION_COAL_POWER_PLANT', 'PROJECT_DECOMMISSION_NUCLEAR_POWER_PLANT',
                      'PROJECT_DECOMMISSION_OIL_POWER_PLANT');

-- 伟人无视时代限制
-- 删除时代限制
DELETE
FROM RequirementSetRequirements
WHERE RequirementSetId IN (SELECT 'AOE_' || REPLACE(EraType, 'ERA_', '') || '_SEA_REQUIREMENTS'
                           FROM Eras
                           UNION
                           SELECT 'AOE_' || REPLACE(EraType, 'ERA_', '') || '_LAND_REQUIREMENTS'
                           FROM Eras)
  AND RequirementId IN (SELECT 'AOE_REQUIRES_' || REPLACE(EraType, 'ERA_', '') || '_REQUIREMENTS' FROM Eras);

UPDATE ModifierStrings
SET Text = 'LOC_GREATPERSON_COMBAT_STRENGTH_AOE_SEA'
WHERE ModifierId LIKE 'GREATPERSON_COMBAT_STRENGTH_AOE_%_SEA';
UPDATE ModifierStrings
SET Text = 'LOC_GREATPERSON_COMBAT_STRENGTH_AOE_LAND'
WHERE ModifierId LIKE 'GREATPERSON_COMBAT_STRENGTH_AOE_%_LAND';

-- 迁都
UPDATE TraitModifiers
SET TraitType = 'TRAIT_LEADER_MAJOR_CIV'
WHERE TraitType = 'TRAIT_LEADER_FOUNDER_CARTHAGE'
  AND ModifierId = 'DISTRICT_COMPLETE_MOVE_CAPITAL';
UPDATE Projects
SET PrereqDistrict = NULL
WHERE ProjectType = 'PROJECT_COTHON_CAPITAL_MOVE';


-- ====================================

-- insert or
-- replace into Types
--     (Type, Kind)
-- Select 'POLICY_FISHDINGZHI_' || CommemorationTypes.CommemorationType, 'KIND_POLICY'
-- from CommemorationTypes;
--
-- insert or ignore into Policies_XP1
-- (PolicyType, MinimumGameEra, MaximumGameEra, RequiresDarkAge, RequiresGoldenAge)
-- SELECT DISTINCT 'POLICY_FISHDINGZHI_' || CommemorationTypes.CommemorationType,
--                 CASE
--                     WHEN CommemorationTypes.MinimumGameEra is null THEN 'ERA_CLASSICAL'
--                     ELSE CommemorationTypes.MinimumGameEra END,
--                 CASE
--                     WHEN CommemorationTypes.MaximumGameEra is null THEN 'ERA_FUTURE'
--                     ELSE CommemorationTypes.MaximumGameEra END,
--                 0,
--                 1
-- from CommemorationTypes;
-- insert or
-- replace into Policies
--     (PolicyType, Name, Description, GovernmentSlotType, ExplicitUnlock)
-- SELECT DISTINCT 'POLICY_FISHDINGZHI_' || CommemorationTypes.CommemorationType,
--                 CommemorationTypes.CategoryDescription,
--                 CommemorationTypes.GoldenAgeBonusDescription,
--                 'SLOT_WILDCARD',
--                 0
-- from CommemorationTypes;
--
--
-- insert or
-- replace into PolicyModifiers
--     (PolicyType, ModifierId)
-- Select 'POLICY_FISHDINGZHI_' || CommemorationModifiers.CommemorationType,
--        'FISHDINGZHI_POLICY_' || CommemorationModifiers.ModifierId
-- from CommemorationModifiers;
--
-- insert or
-- replace into RequirementSets
--     (RequirementSetId, RequirementSetType)
-- Select 'FISHDINGZHI_DARKAGE_' || rs.RequirementSetId, rs.RequirementSetType
-- from CommemorationModifiers cm
--          Join Modifiers m on cm.ModifierId = m.ModifierId
--          Join RequirementSets rs
--               on (rs.RequirementSetId = m.OwnerRequirementSetId or rs.RequirementSetId = m.SubjectRequirementSetId);
--
-- insert or
-- replace into RequirementSetRequirements
--     (RequirementSetId, RequirementId)
-- Select 'FISHDINGZHI_DARKAGE_' || rsq.RequirementSetId,rsq.RequirementId
-- from CommemorationModifiers cm
--          Join Modifiers m on cm.ModifierId = m.ModifierId
--          Join RequirementSetRequirements rsq
--               on rsq.RequirementSetId = m.OwnerRequirementSetId or rsq.RequirementSetId = m.SubjectRequirementSetId;
--
-- insert or
-- replace into Modifiers
-- (ModifierId, ModifierType, RunOnce, OwnerRequirementSetId, SubjectRequirementSetId, OwnerStackLimit, SubjectStackLimit)
-- Select 'FISHDINGZHI_POLICY_' || cm.ModifierId,
--        m.ModifierType,
--        m.RunOnce,
--        CASE
--            WHEN m.OwnerRequirementSetId like '%GOLDEN_AGE%' THEN 'FISHDINGZHI_DARKAGE_' || m.OwnerRequirementSetId
--            ELSE m.OwnerRequirementSetId END,
--        CASE
--            WHEN m.SubjectRequirementSetId like '%GOLDEN_AGE%' THEN 'FISHDINGZHI_DARKAGE_' || m.SubjectRequirementSetId
--            ELSE m.SubjectRequirementSetId END,
--        m.OwnerStackLimit,
--        m.SubjectStackLimit
-- from CommemorationModifiers cm
--          Join Modifiers m on cm.ModifierId = m.ModifierId;
--
-- insert or
-- replace into ModifierArguments
--     (ModifierId, Name, Value)
-- Select 'FISHDINGZHI_POLICY_' || ma.ModifierId, ma.Name, ma.Value
-- from CommemorationModifiers cm
--          Join ModifierArguments ma on cm.ModifierId = ma.ModifierId;
--
-- -- 删除全民皆兵
-- DELETE FROM Policies WHERE PolicyType = 'POLICY_FISHDINGZHI_COMMEMORATION_MILITARY';
-- -- 删除黄金时代战争
DELETE FROM DiplomaticActions WHERE DiplomaticActionType = 'DIPLOACTION_DECLARE_GOLDEN_AGE_WAR';
--
-- -- 黄金时代同普通时代
UPDATE CommemorationTypes SET GoldenAgeBonusDescription = NormalAgeBonusDescription;
DELETE FROM CommemorationModifiers WHERE CommemorationType NOT LIKE '%QUEST';
DELETE FROM RequirementSetRequirements WHERE RequirementId = 'REQUIRES_PLAYER_NOT_HAS_GOLDEN_AGE' AND RequirementSetId = 'PLAYER_ELIGIBLE_FOR_COMMEMORATION_QUEST';

UPDATE Buildings SET Housing = 3 WHERE BuildingType = 'BUILDING_FOOD_MARKET';
UPDATE Building_YieldChanges SET YieldChange = 3 WHERE BuildingType IN ('BUILDING_FOOD_MARKET','BUILDING_SHOPPING_MALL');
UPDATE Building_YieldChangesBonusWithPower SET YieldChange = 6 WHERE BuildingType IN ('BUILDING_FOOD_MARKET','BUILDING_SHOPPING_MALL');

UPDATE Building_YieldChanges SET YieldChange = 3 WHERE YieldType = 'YIELD_CULTURE' AND BuildingType IN ('BUILDING_MUSEUM_ART','BUILDING_MUSEUM_ARTIFACT','BUILDING_BROADCAST_CENTER','BUILDING_FILM_STUDIO');
UPDATE Building_YieldChangesBonusWithPower SET YieldChange = 5 WHERE YieldType = 'YIELD_CULTURE' AND BuildingType IN ('BUILDING_BROADCAST_CENTER','BUILDING_FILM_STUDIO');

INSERT INTO Building_GreatPersonPoints(BuildingType, GreatPersonClassType, PointsPerTurn) VALUES
('BUILDING_GROVE','GREAT_PERSON_CLASS_PROPHET',1),
('BUILDING_GROVE','GREAT_PERSON_CLASS_WRITER',1),
('BUILDING_SANCTUARY','GREAT_PERSON_CLASS_MERCHANT',1),
('BUILDING_SANCTUARY','GREAT_PERSON_CLASS_ARTIST',1),
('BUILDING_SANCTUARY','GREAT_PERSON_CLASS_MUSICIAN',1),
('BUILDING_SANCTUARY','GREAT_PERSON_CLASS_SCIENTIST',1);

-- Ban 文明百科
-- INSERT INTO CivilopediaPageExcludes(SectionId, PageId) SELECT
-- 'GOVERNMENTS','POLICY_FISHDINGZHI_' || CommemorationTypes.CommemorationType
-- from CommemorationTypes;

-- 在此城中生产军事单位时 [ICON_Production] 生产力+30%。占领一座敌方城市后，所有城市将获得20%的 [ICON_Production] 生产力加成，效果持续5回合。[NEWLINE]奖励1个 [Icon_Governor] 总督头衔。

-- Custom ModifierType
INSERT INTO Types (Type, Kind) VALUES
('MODIFIER_PLAYER_NW_CITY_ADJUST_UNIT_PRODUCTION', 'KIND_MODIFIER');
INSERT INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES
('MODIFIER_PLAYER_NW_CITY_ADJUST_UNIT_PRODUCTION', 'COLLECTION_OWNER', 'EFFECT_ADJUST_UNIT_PRODUCTION');

INSERT INTO BuildingModifiers (BuildingType, ModifierId) SELECT
'BUILDING_GOV_CONQUEST', 'MODIFIER_BUILDING_GOV_CONQUEST_ADD_UNIT_PRODUCTION'||UnitType
FROM Units WHERE FormationClass IS NOT 'FORMATION_CLASS_CIVILIAN';
INSERT INTO Modifiers (ModifierId, ModifierType) SELECT
'MODIFIER_BUILDING_GOV_CONQUEST_ADD_UNIT_PRODUCTION'||UnitType, 'MODIFIER_PLAYER_NW_CITY_ADJUST_UNIT_PRODUCTION'
FROM Units WHERE FormationClass IS NOT 'FORMATION_CLASS_CIVILIAN';

INSERT INTO ModifierArguments (ModifierId, Name, Value) SELECT
'MODIFIER_BUILDING_GOV_CONQUEST_ADD_UNIT_PRODUCTION'||UnitType, 'Amount', '30'
FROM Units WHERE FormationClass IS NOT 'FORMATION_CLASS_CIVILIAN' UNION SELECT
'MODIFIER_BUILDING_GOV_CONQUEST_ADD_UNIT_PRODUCTION'||UnitType, 'UnitType', UnitType
FROM Units WHERE FormationClass IS NOT 'FORMATION_CLASS_CIVILIAN';

-- [ICON_CAPITAL] 首都或有 [ICON_Governor] 总督的城市+2 [ICON_Amenities] 宜居度、+4 [ICON_Housing] 住房。[NEWLINE]无 [ICON_Governor] 总督的非[ICON_CAPITAL] 首都城市-2忠诚度。[NEWLINE]奖励1个 [Icon_Governor] 总督头衔。


-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('CITY_HAS_GOVERNOR_OR_PALACE_REQUIREMENTS', 'REQUIREMENTSET_TEST_ANY');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('CITY_HAS_GOVERNOR_OR_PALACE_REQUIREMENTS', 'REQUIRES_CITY_HAS_GOVERNOR'),
('CITY_HAS_GOVERNOR_OR_PALACE_REQUIREMENTS', 'REQUIRES_CITY_HAS_PALACE');
UPDATE Modifiers SET SubjectRequirementSetId = 'CITY_HAS_GOVERNOR_OR_PALACE_REQUIREMENTS' WHERE ModifierId IN ('GOV_TALL_HOUSING_BUFF','GOV_TALL_AMENITY_BUFF','THEOCRACY_RELIGIOUS_PEOPLE','MERCHANT_REPUBLIC_GOLD_MODIFIER','COMMUNISM_PRODUCTIVE_PEOPLE');

-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('NONE_CITY_HAS_GOVERNOR_OR_PALACE_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('NONE_CITY_HAS_GOVERNOR_OR_PALACE_REQUIREMENTS', 'REQUIRES_NOT_CITY_HAS_GOV'),
('NONE_CITY_HAS_GOVERNOR_OR_PALACE_REQUIREMENTS', 'REQUIRES_NW_FS_CITY_HAS_NO_PALACE');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType, Inverse) VALUES
('REQUIRES_NW_FS_CITY_HAS_NO_PALACE', 'REQUIREMENT_CITY_HAS_BUILDING', 1);
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('REQUIRES_NW_FS_CITY_HAS_NO_PALACE', 'BuildingType', 'BUILDING_PALACE');
UPDATE Modifiers SET SubjectRequirementSetId = 'NONE_CITY_HAS_GOVERNOR_OR_PALACE_REQUIREMENTS' WHERE ModifierId IN ('GOV_TALL_LOYALTY_DEBUFF');

-- 间谍容量+2。[NEWLINE]所有间谍行动的成功率上升。[NEWLINE]奖励1个 [Icon_Governor] 总督头衔。
DELETE FROM BuildingModifiers WHERE ModifierId = 'GOV_ADD_SPY_UNIT' AND BuildingType = 'BUILDING_GOV_SPIES';
UPDATE ModifierArguments SET Value = 2 WHERE ModifierId = 'GOV_GRANT_SPY' AND Name = 'Amount';

-- 每回合影响力点数+2。
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES
('BUILDING_GOV_CITYSTATES', 'MODIFIER_BUILDING_GOV_CITYSTATES_2INFF');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_BUILDING_GOV_CITYSTATES_2INFF', 'MODIFIER_PLAYER_ADJUST_INFLUENCE_POINTS_PER_TURN', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_BUILDING_GOV_CITYSTATES_2INFF', 'Amount', '2');

-- BUILDING_GOV_CULTURE
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES
('BUILDING_GOV_CULTURE', 'MODIFIER_BUILDING_GOV_CULTURE_ADD_TOUR');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_BUILDING_GOV_CULTURE_ADD_TOUR', 'MODIFIER_PLAYER_DISTRICT_ADJUST_TOURISM_CHANGE', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_BUILDING_GOV_CULTURE_ADD_TOUR', 'Amount', '10');


INSERT INTO Building_GreatPersonPoints(BuildingType, GreatPersonClassType, PointsPerTurn) VALUES
('BUILDING_GOV_CULTURE','GREAT_PERSON_CLASS_WRITER',4),
('BUILDING_GOV_CULTURE','GREAT_PERSON_CLASS_ARTIST',4),
('BUILDING_GOV_CULTURE','GREAT_PERSON_CLASS_MUSICIAN',4),
('BUILDING_GOV_SCIENCE','GREAT_PERSON_CLASS_ENGINEER',4),
('BUILDING_GOV_SCIENCE','GREAT_PERSON_CLASS_SCIENTIST',4),
('BUILDING_GOV_MILITARY','GREAT_PERSON_CLASS_GENERAL',4),
('BUILDING_GOV_MILITARY','GREAT_PERSON_CLASS_ADMIRAL',4);

-- UPDATE Eras_XP1 SET GameEraMaximumTurns=0, GameEraMinimumTurns = 0;