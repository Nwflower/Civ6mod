--	FILE: LWT_Improvement.sql
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
INSERT INTO Types(Type, Kind)
VALUES ('IMPROVEMENT_20250929', 'KIND_IMPROVEMENT');

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
 Domain,
 DefenseModifier,
 GrantFortification)
VALUES ('IMPROVEMENT_20250929',
        'LOC_IMPROVEMENT_20250929_NAME',
        'TECH_MASONRY',
        1,
        'LOC_IMPROVEMENT_20250929_DESCRIPTION',
        'PLUNDER_GOLD',
        37.5,
        2,
        'ICON_IMPROVEMENT_20250929',
        'TRAIT_IMPROVEMENT_20250929',
        'DOMAIN_LAND',
        4,
        2);

-- 产出设置 鲨堡加6科技加6文化加6粮食加2住房。
INSERT INTO Improvement_YieldChanges(ImprovementType, YieldType, YieldChange)
VALUES ('IMPROVEMENT_20250929', 'YIELD_FOOD', 6),
       ('IMPROVEMENT_20250929', 'YIELD_SCIENCE', 6),
       ('IMPROVEMENT_20250929', 'YIELD_CULTURE', 6);

-- 可建造设置
INSERT INTO Improvement_ValidBuildUnits(ImprovementType, UnitType)
VALUES ('IMPROVEMENT_20250929', 'UNIT_BUILDER');

INSERT INTO Improvement_ValidTerrains(ImprovementType, TerrainType)
SELECT 'IMPROVEMENT_20250929', TerrainType
FROM Terrains;
INSERT INTO Improvement_ValidFeatures(ImprovementType, FeatureType)
SELECT 'IMPROVEMENT_20250929', FeatureType
FROM Features;
INSERT INTO Improvement_ValidResources(ImprovementType, ResourceType)
SELECT 'IMPROVEMENT_20250929', ResourceType
FROM Resources;

--------------------------------------------------------------------------------
--  作者： 千川白浪
--  特别鸣谢： 优妮
------------------------------------------------------------------------------
INSERT INTO Types(Type, Kind)
VALUES ('IMPROVEMENT_20250930', 'KIND_IMPROVEMENT');

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
 Domain,
 SameAdjacentValid)
VALUES ('IMPROVEMENT_20250930',
        'LOC_IMPROVEMENT_20250930_NAME',
        'TECH_SHIPBUILDING',
        1,
        'LOC_IMPROVEMENT_20250930_DESCRIPTION',
        'PLUNDER_GOLD',
        37.5,
        1,
        'ICON_IMPROVEMENT_20250930',
        'TRAIT_IMPROVEMENT_20250930',
        'DOMAIN_SEA',
        0);
-- 解锁建造者建造深空之眼逆潮特色改良设施鲨浮标的能力。[NEWLINE][NEWLINE]为区域提供大量相邻加成。无法建造在另一个鲨浮标旁边。可以建造在海岸、湖泊和海洋单元格中。
-- 可建造设置
INSERT INTO Improvement_ValidBuildUnits(ImprovementType, UnitType)
VALUES ('IMPROVEMENT_20250930', 'UNIT_BUILDER');

INSERT INTO Improvement_ValidTerrains(ImprovementType, TerrainType)
VALUES ('IMPROVEMENT_20250930', 'TERRAIN_COAST'),
       ('IMPROVEMENT_20250930', 'TERRAIN_OCEAN');

INSERT INTO Adjacency_YieldChanges(ID,Description,YieldChange,YieldType,AdjacentImprovement)SELECT
ID||'IMPROVEMENT_20250930',Description,2,YieldType,'IMPROVEMENT_20250930'
FROM Adjacency_YieldChanges WHERE AdjacentDistrict ='DISTRICT_GOVERNMENT';

INSERT INTO District_Adjacencies(DistrictType, YieldChangeId) SELECT
DistrictType,YieldChangeId||'IMPROVEMENT_20250930'
FROM District_Adjacencies WHERE YieldChangeId IN (SELECT ID FROM Adjacency_YieldChanges WHERE AdjacentDistrict ='DISTRICT_GOVERNMENT');
