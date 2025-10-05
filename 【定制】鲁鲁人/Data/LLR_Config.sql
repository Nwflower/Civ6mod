--	FILE: LLR_Config.sql
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
        'CIVILIZATION_ZULU',
        'LEADER_NW_LLR',
        'LOC_CIVILIZATION_ZULU_NAME',
        'ICON_CIVILIZATION_ZULU',
        'LOC_LEADER_NW_LLR_NAME',
        'ICON_LEADER_SHAKA',
        'LOC_TRAIT_CIVILIZATION_ZULU_ISIBONGO_NAME',
        'LOC_TRAIT_CIVILIZATION_ZULU_ISIBONGO_DESCRIPTION',
        'ICON_CIVILIZATION_ZULU',
        'LOC_TRAIT_LEADER_NW_LLR_NW251004_NAME',
        'LOC_TRAIT_LEADER_NW_LLR_NW251004_DESCRIPTION',
        'ICON_LEADER_SHAKA',
        'LEADER_SHAKA_NEUTRAL',
        'LEADER_SHAKA_BACKGROUND');

INSERT INTO PlayerItems
(Domain, CivilizationType, LeaderType, Type, Icon, Name, Description, SortIndex)
SELECT 'Players:Expansion2_Players',
       'CIVILIZATION_ZULU',
       'LEADER_NW_LLR',
        Type,
        Icon,
        Name,
        Description,
        SortIndex
FROM PlayerItems WHERE Type = 'LEADER_SHAKA';