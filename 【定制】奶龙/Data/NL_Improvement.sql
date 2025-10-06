--	FILE: NL_Improvement.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/10/6 11:26:46
--------------------------------------------------------------------------------
--  作者： 千川白浪
--  特别鸣谢： 优妮
------------------------------------------------------------------------------
INSERT INTO Types(Type, Kind)
VALUES ('IMPROVEMENT_HTGTGC', 'KIND_IMPROVEMENT');

INSERT INTO Improvements
(ImprovementType,
 Name,
 PrereqTech,
 Buildable,
 Description,
 PlunderType,
 PlunderAmount,
 Housing,
 Icon,
 TraitType,
 Domain)
VALUES ('IMPROVEMENT_HTGTGC',
        'LOC_IMPROVEMENT_HTGTGC_NAME',
        NULL,
        1,
        'LOC_IMPROVEMENT_HTGTGC_DESCRIPTION',
        'PLUNDER_GOLD',
        37.5,
        1,
        'ICON_IMPROVEMENT_HTGTGC',
        'TRAIT_IMPROVEMENT_HTGTGC',
        'DOMAIN_LAND');

-- 产出设置
INSERT INTO Improvement_YieldChanges(ImprovementType, YieldType, YieldChange)
VALUES ('IMPROVEMENT_HTGTGC', 'YIELD_GOLD', 1),
       ('IMPROVEMENT_HTGTGC', 'YIELD_FAITH', 1);

-- 可建造设置
INSERT INTO Improvement_ValidBuildUnits(ImprovementType, UnitType)
VALUES ('IMPROVEMENT_HTGTGC', 'UNIT_QZJ_NL');

INSERT INTO Improvement_ValidTerrains(ImprovementType, TerrainType)
SELECT 'IMPROVEMENT_HTGTGC', TerrainType
FROM Terrains;
INSERT INTO Improvement_ValidFeatures(ImprovementType, FeatureType)
SELECT 'IMPROVEMENT_HTGTGC', FeatureType
FROM Features;
INSERT INTO Improvement_ValidResources(ImprovementType, ResourceType)
SELECT 'IMPROVEMENT_HTGTGC', ResourceType
FROM Resources;

-- 解锁奶龙建造奶龙特色改良设施黄桃罐头工厂的能力。
-- +1 [ICON_GOLD] 金币、+1 [ICON_FAITH] 信仰值。
-- 拥有“黄桃罐头工厂”的城市获得1大预言家点数。建成时对相邻单元格释放文化炸弹。如城市在奶龙文化炸弹的攻击下失去单元格，则奶龙的主流宗教将成为此城的主流宗教。
INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_IMPROVEMENT_HTGTGC', 'MODIFIER_TRAIT_IMPROVEMENT_HTGTGC_BOMB');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_IMPROVEMENT_HTGTGC_BOMB', 'MODIFIER_PLAYER_ADD_CULTURE_BOMB_TRIGGER', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_IMPROVEMENT_HTGTGC_BOMB', 'ImprovementType', 'IMPROVEMENT_HTGTGC');

INSERT INTO ImprovementModifiers (ImprovementType, ModifierId) VALUES
('IMPROVEMENT_HTGTGC', 'MODIFIER_IMPROVEMENT_HTGTGC_GPP');
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectStackLimit) VALUES
('MODIFIER_IMPROVEMENT_HTGTGC_GPP', 'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS', 1);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_IMPROVEMENT_HTGTGC_GPP', 'Amount', '1'),
('MODIFIER_IMPROVEMENT_HTGTGC_GPP', 'GreatPersonClassType', 'GREAT_PERSON_CLASS_PROPHET');

INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_IMPROVEMENT_HTGTGC', 'MODIFIER_TRAIT_IMPROVEMENT_HTGTGC_RELIGION');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_IMPROVEMENT_HTGTGC_RELIGION', 'MODIFIER_PLAYER_ADJUST_CULTURE_BOMB_CONVERTS_CITY', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_IMPROVEMENT_HTGTGC_RELIGION', 'ConvertsCity', '1');
