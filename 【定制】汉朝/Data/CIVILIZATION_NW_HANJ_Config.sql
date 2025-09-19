--	FILE: CIVILIZATION_NW_HANJ_Config.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/15 18:21:35
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT OR
REPLACE INTO Players
(Domain, CivilizationType, LeaderType, CivilizationName, CivilizationIcon, LeaderName, LeaderIcon,
 CivilizationAbilityName, CivilizationAbilityDescription, CivilizationAbilityIcon, LeaderAbilityName,
 LeaderAbilityDescription, LeaderAbilityIcon, Portrait, PortraitBackground)
VALUES ('Players:Expansion2_Players',
        'CIVILIZATION_CIV_HANJ',
        'LEADER_NW_LIUXUN',
        'LOC_CIVILIZATION_CIV_HANJ_NAME',
        'ICON_CIVILIZATION_CIV_HANJ',
        'LOC_LEADER_NW_LIUXUN_NAME',
        'ICON_LEADER_NW_LIUXUN',
        'LOC_TRAIT_CIVILIZATION_CIV_HANJ_NW003_NAME',
        'LOC_TRAIT_CIVILIZATION_CIV_HANJ_NW003_DESCRIPTION',
        'ICON_CIVILIZATION_CIV_HANJ',
        'LOC_TRAIT_LEADER_NW_LIUXUN_NW004_NAME',
        'LOC_TRAIT_LEADER_NW_LIUXUN_NW004_DESCRIPTION',
        'ICON_LEADER_NW_LIUXUN', 'NEUTRAL_LEADER_NW_LIUXUN',
        'LEADER_NW_LIUXUN_BACKGROUND');


INSERT OR
REPLACE INTO Players
(Domain, CivilizationType, LeaderType, CivilizationName, CivilizationIcon, LeaderName, LeaderIcon,
 CivilizationAbilityName, CivilizationAbilityDescription, CivilizationAbilityIcon, LeaderAbilityName,
 LeaderAbilityDescription, LeaderAbilityIcon, Portrait, PortraitBackground)
VALUES ('Players:Expansion2_Players',
        'CIVILIZATION_CIV_HANJ',
        'LEADER_NW_JET_LIUCHE',
        'LOC_CIVILIZATION_CIV_HANJ_NAME',
        'ICON_CIVILIZATION_CIV_HANJ',
        'LOC_LEADER_NW_JET_LIUCHE_NAME',
        'ICON_LEADER_NW_JET_LIUCHE',
        'LOC_TRAIT_CIVILIZATION_CIV_HANJ_NW003_NAME',
        'LOC_TRAIT_CIVILIZATION_CIV_HANJ_NW003_DESCRIPTION',
        'ICON_CIVILIZATION_CIV_HANJ',
        'LOC_TRAIT_LEADER_NW_JET_LIUCHE_NW005_NAME',
        'LOC_TRAIT_LEADER_NW_JET_LIUCHE_NW005_DESCRIPTION',
        'ICON_LEADER_NW_JET_LIUCHE', 'LEADER_NW_JET_LIUCHE_NEUTRAL',
        'LEADER_NW_JET_LIUCHE_BACKGROUND');

INSERT INTO PlayerItems
(Domain, CivilizationType, LeaderType, Type, Icon, Name, Description, SortIndex)
VALUES ('Players:Expansion2_Players', 'CIVILIZATION_CIV_HANJ', 'LEADER_NW_LIUXUN',
        'BUILDING_TAICANG', 'ICON_BUILDING_TAICANG', 'LOC_BUILDING_TAICANG_NAME',
        'LOC_BUILDING_TAICANG_DESCRIPTION', 20),
       ('Players:Expansion2_Players', 'CIVILIZATION_CIV_HANJ', 'LEADER_NW_LIUXUN',
        'UNIT_NW_YULIN', 'ICON_UNIT_NW_YULIN', 'LOC_UNIT_NW_YULIN_NAME',
        'LOC_UNIT_NW_YULIN_DESCRIPTION', 40),
    ('Players:Expansion2_Players', 'CIVILIZATION_CIV_HANJ', 'LEADER_NW_JET_LIUCHE',
        'BUILDING_TAICANG', 'ICON_BUILDING_TAICANG', 'LOC_BUILDING_TAICANG_NAME',
        'LOC_BUILDING_TAICANG_DESCRIPTION', 20),
       ('Players:Expansion2_Players', 'CIVILIZATION_CIV_HANJ', 'LEADER_NW_JET_LIUCHE',
        'UNIT_NW_YULIN', 'ICON_UNIT_NW_YULIN', 'LOC_UNIT_NW_YULIN_NAME',
        'LOC_UNIT_NW_YULIN_DESCRIPTION', 40),
       ('Players:Expansion2_Players', 'CIVILIZATION_CIV_HANJ', 'LEADER_NW_JET_LIUCHE',
        'UNIT_NW_BIAOQI', 'ICON_UNIT_NW_BIAOQI', 'LOC_UNIT_NW_BIAOQI_NAME',
        'LOC_UNIT_NW_BIAOQI_DESCRIPTION', 30);
