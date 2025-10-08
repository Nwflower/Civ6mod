
CREATE TABLE IF NOT EXISTS Nwflower_MOD_Traits(
TraitType TEXT NOT NULL,
PRIMARY KEY (TraitType),
FOREIGN KEY (TraitType) REFERENCES Traits (TraitType) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT OR IGNORE INTO Nwflower_MOD_Traits(TraitType) VALUES
('TRAIT_LEADER_JFD_AMERICAN_CONTRACT_ALT'),
('TRAIT_CIVILIZATION_NW_AMERICA_FREEDOM');

INSERT OR IGNORE INTO TraitModifiers(TraitType,ModifierId)SELECT
TraitType,				'MODFEAT_TRAIT_PROPERTY_'||TraitType
FROM Nwflower_MOD_Traits;

INSERT OR IGNORE INTO Modifiers(ModifierId,ModifierType)SELECT
'MODFEAT_TRAIT_PROPERTY_'||TraitType,			'MODIFIER_PLAYER_ADJUST_PROPERTY'
FROM Nwflower_MOD_Traits;

INSERT OR IGNORE INTO ModifierArguments(ModifierId,Name,Value)SELECT
'MODFEAT_TRAIT_PROPERTY_'||TraitType,			'Key',	'PROPERTY_'||TraitType
FROM Nwflower_MOD_Traits UNION SELECT
'MODFEAT_TRAIT_PROPERTY_'||TraitType,			'Amount',						1
FROM Nwflower_MOD_Traits;
--============================================================
-- Civ
--============================================================

DELETE FROM DistrictModifiers WHERE ModifierId = 'MODIFIER_DIS_GIVE_TRUMP_GOLD' AND DistrictType = 'DISTRICT_COMMERCIAL_HUB';
DELETE FROM DistrictModifiers WHERE ModifierId = 'MODIFIER_DIS_GIVE_TRUMP_GOLD' AND DistrictType IN (SELECT CivUniqueDistrictType FROM DistrictReplaces WHERE ReplacesDistrictType = 'DISTRICT_COMMERCIAL_HUB');



-- 做个表，不然LUA逻辑有点乱
CREATE TABLE IF NOT EXISTS American_Unit
(
    LandUnit TEXT NOT NULL,
    NavalUnit TEXT NOT NULL,
    PRIMARY KEY (LandUnit, NavalUnit)
);

INSERT INTO American_Unit(LandUnit, NavalUnit)VALUES
-- 桨帆船与棒子
('UNIT_WARRIOR','UNIT_GALLEY'),
-- 桨帆船与铁剑
('UNIT_SWORDSMAN','UNIT_GALLEY'),
-- 桨帆船与披甲
('UNIT_MAN_AT_ARMS','UNIT_GALLEY'),
-- 大船与火枪
('UNIT_MUSKETMAN','UNIT_CARAVEL'),
-- 线列与装甲舰
('UNIT_LINE_INFANTRY','UNIT_IRONCLAD'),
-- 步兵与装甲舰
('UNIT_INFANTRY','UNIT_IRONCLAD'),
-- 机械化步兵与驱逐舰
('UNIT_MECHANIZED_INFANTRY','UNIT_DESTROYER');


INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_LEADER_JFD_AMERICAN_CONTRACT_ALT', 'MODIFIER_TRAIT_LEADER_JFD_AMERICAN_CONTRACT_ALT_EXTRA_GOLD');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent) VALUES
('MODIFIER_TRAIT_LEADER_JFD_AMERICAN_CONTRACT_ALT_EXTRA_GOLD', 'MODIFIER_PLAYER_GRANT_YIELD', 1, 1);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value) VALUES
('MODIFIER_TRAIT_LEADER_JFD_AMERICAN_CONTRACT_ALT_EXTRA_GOLD', 'Amount', 'ScaleByGameSpeed','50'),
('MODIFIER_TRAIT_LEADER_JFD_AMERICAN_CONTRACT_ALT_EXTRA_GOLD', 'YieldType', 'ARGTYPE_IDENTITY','YIELD_GOLD');



INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_LEADER_JFD_AMERICAN_CONTRACT_ALT', 'MODIFIER_TRAIT_LEADER_JFD_AMERICAN_CONTRACT_ALT_JOINTWAR_EXPERIENCE');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_LEADER_JFD_AMERICAN_CONTRACT_ALT_JOINTWAR_EXPERIENCE', 'MODIFIER_PLAYER_ADJUST_JOINTWAR_EXPERIENCE', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_JFD_AMERICAN_CONTRACT_ALT_JOINTWAR_EXPERIENCE', 'Range', '6');


INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_LEADER_JFD_AMERICAN_CONTRACT_ALT', 'MODIFIER_TRAIT_LEADER_JFD_AMERICAN_CONTRACT_ALT_JOINTWAR_PLUNDER');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_LEADER_JFD_AMERICAN_CONTRACT_ALT_JOINTWAR_PLUNDER', 'MODIFIER_PLAYER_ADJUST_JOINTWAR_PLUNDER', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_JFD_AMERICAN_CONTRACT_ALT_JOINTWAR_PLUNDER', 'Multiplier', '100');


--世界议会
--世界议会周期
UPDATE GlobalParameters SET Value='20' WHERE Name='WORLD_CONGRESS_MAX_TIME_BETWEEN_MEETINGS';
--世界战斗议会
UPDATE GlobalParameters SET Value='10' WHERE Name='WORLD_CONGRESS_MIN_TIME_BETWEEN_SPECIAL_SESSIONS';
--世界启动议会
UPDATE GlobalParameters SET Value='8' WHERE Name='WORLD_CONGRESS_MAJORITY_LEADER_MINIMUM';
--世界启动议会
UPDATE GlobalParameters SET Value='1' WHERE Name='WORLD_CONGRESS_INITIAL_ERA';

UPDATE Resolutions SET EarliestEra='ERA_RENAISSANCE' WHERE ResolutionType='WC_RES_ESPIONAGE_PACT';
--森林砍伐条约-砍伐地貌收益-原子能时代提前至古典时代
UPDATE Resolutions SET EarliestEra='ERA_RENAISSANCE' WHERE ResolutionType='WC_RES_DEFORESTATION_TREATY';
UPDATE Resolutions SET LatestEra='ERA_RENAISSANCE' WHERE ResolutionType='WC_RES_DEFORESTATION_TREATY';
--整体加槽位提前古典
UPDATE Resolutions SET EarliestEra='ERA_MEDIEVAL' WHERE ResolutionType='WC_RES_WORLD_IDEOLOGY';
--区域加百分百产能  移动 中世纪
UPDATE Resolutions SET EarliestEra='ERA_MEDIEVAL' WHERE ResolutionType='WC_RES_URBAN_DEVELOPMENT';
--区域文化炸弹
--提前古典  结束中世纪
UPDATE Resolutions SET EarliestEra='ERA_CLASSICAL' WHERE ResolutionType='WC_RES_BORDER_CONTROL';
UPDATE Resolutions SET LatestEra='ERA_MEDIEVAL' WHERE ResolutionType='WC_RES_BORDER_CONTROL';
--项目加锤子 移动 中世纪
UPDATE Resolutions SET EarliestEra='ERA_CLASSICAL' WHERE ResolutionType='WC_RES_LUXURY';
--商路 移动 中世纪
UPDATE Resolutions SET EarliestEra='ERA_CLASSICAL' WHERE ResolutionType='WC_RES_TRADE_TREATY';
--会议召开花费 移动 中世纪
UPDATE Resolutions SET EarliestEra='ERA_MEDIEVAL' WHERE ResolutionType='WC_RES_MERCENARY_COMPANIES';
--全球能源条约-区域建筑建造增速-现代提前至文艺复兴
UPDATE Resolutions SET EarliestEra='ERA_RENAISSANCE' WHERE ResolutionType='WC_RES_GLOBAL_ENERGY_TREATY';
--公共工程计划-区域项目建造增速-原子能时代提前至现代
UPDATE Resolutions SET EarliestEra='ERA_MODERN' WHERE ResolutionType='WC_RES_PUBLIC_WORKS';
--外交胜利 投票文艺复兴开始
UPDATE Resolutions SET EarliestEra='ERA_RENAISSANCE' WHERE ResolutionType='WC_RES_DIPLOVICTORY';