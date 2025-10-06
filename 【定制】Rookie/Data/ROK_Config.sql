--	FILE: ROK_Config.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/10/5 12:10:26
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
        'CIVILIZATION_MALI',
        'LEADER_NW_ROK',
        'LOC_CIVILIZATION_MALI_NAME',
        'ICON_CIVILIZATION_MALI',
        'LOC_LEADER_NW_ROK_NAME',
        'ICON_LEADER_MANSA_MUSA',
        'LOC_TRAIT_CIVILIZATION_MALI_GOLD_DESERT_NAME',
        'LOC_TRAIT_CIVILIZATION_MALI_GOLD_DESERT_DESCRIPTION',
        'ICON_CIVILIZATION_MALI',
        'LOC_TRAIT_LEADER_NW_ROK_NW251004_NAME',
        'LOC_TRAIT_LEADER_NW_ROK_NW251004_DESCRIPTION',
        'ICON_LEADER_MANSA_MUSA',
        'LEADER_MANSA_MUSA_NEUTRAL',
        'LEADER_MANSA_MUSA_BACKGROUND');

INSERT OR IGNORE INTO PlayerItems
(Domain, CivilizationType, LeaderType, Type, Icon, Name, Description, SortIndex)
SELECT DISTINCT 'Players:Expansion2_Players',
       'CIVILIZATION_MALI',
       'LEADER_NW_ROK',
        Type,
        Icon,
        Name,
        Description,
        SortIndex
FROM PlayerItems WHERE LeaderType = 'LEADER_MANSA_MUSA';