--	FILE: MRK_Config.sql
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
        'CIVILIZATION_PERSIA',
        'LEADER_NW_MRK',
        'LOC_CIVILIZATION_PERSIA_NAME',
        'ICON_CIVILIZATION_PERSIA',
        'LOC_LEADER_NW_MRK_NAME',
        'ICON_LEADER_NADER_SHAH',
        'LOC_TRAIT_CIVILIZATION_SATRAPIES_NAME',
        'LOC_TRAIT_CIVILIZATION_SATRAPIES_DESCRIPTION',
        'ICON_CIVILIZATION_PERSIA',
        'LOC_TRAIT_LEADER_NW_MRK_NW251004_NAME',
        'LOC_TRAIT_LEADER_NW_MRK_NW251004_DESCRIPTION',
        'ICON_LEADER_NADER_SHAH',
        'LEADER_NADER_SHAH_NEUTRAL',
        'LEADER_NADER_SHAH_BACKGROUND');

INSERT OR IGNORE INTO PlayerItems
(Domain, CivilizationType, LeaderType, Type, Icon, Name, Description, SortIndex)
SELECT DISTINCT 'Players:Expansion2_Players',
       'CIVILIZATION_PERSIA',
       'LEADER_NW_MRK',
        Type,
        Icon,
        Name,
        Description,
        SortIndex
FROM PlayerItems WHERE LeaderType = 'LEADER_NADER_SHAH';