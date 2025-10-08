--	FILE: PDL_Config.sql
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
        'CIVILIZATION_BRAZIL',
        'LEADER_NW_PDL',
        'LOC_CIVILIZATION_BRAZIL_NAME',
        'ICON_CIVILIZATION_BRAZIL',
        'LOC_LEADER_NW_PDL_NAME',
        'ICON_LEADER_PEDRO',
        'LOC_TRAIT_CIVILIZATION_AMAZON_NAME',
        'LOC_TRAIT_CIVILIZATION_AMAZON_DESCRIPTION',
        'ICON_CIVILIZATION_BRAZIL',
        'LOC_TRAIT_LEADER_NW_PDL_NW251004_NAME',
        'LOC_TRAIT_LEADER_NW_PDL_NW251004_DESCRIPTION',
        'ICON_LEADER_PEDRO',
        'LEADER_PEDRO_NEUTRAL',
        'LEADER_PEDRO_BACKGROUND');

INSERT OR IGNORE INTO PlayerItems
(Domain, CivilizationType, LeaderType, Type, Icon, Name, Description, SortIndex)
SELECT DISTINCT 'Players:Expansion2_Players',
       'CIVILIZATION_BRAZIL',
       'LEADER_NW_PDL',
        Type,
        Icon,
        Name,
        Description,
        SortIndex
FROM PlayerItems WHERE LeaderType = 'LEADER_PEDRO';