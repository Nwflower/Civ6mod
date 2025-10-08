--	FILE: NL_Config.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/10/6 11:26:46
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
        'CIVILIZATION_MILKD',
        'LEADER_MILKL',
        'LOC_CIVILIZATION_MILKD_NAME',
        'ICON_CIVILIZATION_MILKD',
        'LOC_LEADER_MILKL_NAME',
        'ICON_LEADER_MILKL',
        'LOC_TRAIT_CIVILIZATION_MILKD_NW251006_NAME',
        'LOC_TRAIT_CIVILIZATION_MILKD_NW251006_DESCRIPTION',
        'ICON_CIVILIZATION_MILKD',
        'LOC_TRAIT_LEADER_MILKL_NW251032_NAME',
        'LOC_TRAIT_LEADER_MILKL_NW251032_DESCRIPTION',
        'ICON_LEADER_MILKL',
        'LEADER_MILKL_NEUTRAL',
        'LEADER_MILKL_BACKGROUND');

INSERT INTO PlayerItems
(Domain, CivilizationType, LeaderType, Type, Icon, Name, Description, SortIndex)
VALUES ('Players:Expansion2_Players', 'CIVILIZATION_MILKD', 'LEADER_MILKL',
        'IMPROVEMENT_HTGTGC', 'ICON_IMPROVEMENT_HTGTGC', 'LOC_IMPROVEMENT_HTGTGC_NAME',
        'LOC_IMPROVEMENT_HTGTGC_DESCRIPTION', 20),
       ('Players:Expansion2_Players', 'CIVILIZATION_MILKD', 'LEADER_MILKL',
        'UNIT_XIAOQI', 'ICON_UNIT_XIAOQI', 'LOC_UNIT_XIAOQI_NAME',
        'LOC_UNIT_XIAOQI_DESCRIPTION', 40),
       ('Players:Expansion2_Players', 'CIVILIZATION_MILKD', 'LEADER_MILKL',
        'UNIT_QZJ_NLDD', 'ICON_UNIT_QZJ_NLDD', 'LOC_UNIT_QZJ_NLDD_NAME',
        'LOC_UNIT_QZJ_NLDD_DESCRIPTION', 40),
       ('Players:Expansion2_Players', 'CIVILIZATION_MILKD', 'LEADER_MILKL',
        'UNIT_QZJ_NL', 'ICON_UNIT_QZJ_NL', 'LOC_UNIT_QZJ_NL_NAME',
        'LOC_UNIT_QZJ_NL_DESCRIPTION', 40);
