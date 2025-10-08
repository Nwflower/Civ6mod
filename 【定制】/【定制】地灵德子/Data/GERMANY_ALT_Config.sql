--	FILE: GERMANY_ALT_Config.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/23 9:28:58
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================
INSERT OR
REPLACE
INTO Players
(Domain, CivilizationType, LeaderType, CivilizationName, CivilizationIcon, LeaderName, LeaderIcon,
 CivilizationAbilityName, CivilizationAbilityDescription, CivilizationAbilityIcon, LeaderAbilityName,
 LeaderAbilityDescription, LeaderAbilityIcon, Portrait, PortraitBackground)
SELECT 'Players:Expansion2_Players',
       CivilizationType,
       'LEADER_BARBAROSSA_ALT',
       CivilizationName,
       CivilizationIcon,
        'LOC_LEADER_BARBAROSSA_ALT_NAME',
        'ICON_LEADER_BARBAROSSA_ALT',
       CivilizationAbilityName,
       CivilizationAbilityDescription,
       CivilizationAbilityIcon,
        'LOC_TRAIT_LEADER_BARBAROSSA_ALT_HOLY_ROMAN_EMPEROR_ALT_NAME',
        'LOC_TRAIT_LEADER_BARBAROSSA_ALT_HOLY_ROMAN_EMPEROR_ALT_DESCRIPTION',
        'ICON_LEADER_BARBAROSSA_ALT',
        'LEADER_BARBAROSSA_ALT_NEUTRAL',
        'LEADER_BARBAROSSA_ALT_BACKGROUND'
FROM Players
WHERE LeaderType = 'LEADER_BARBAROSSA'
  AND Domain = 'Players:Expansion2_Players';

INSERT INTO PlayerItems
(Domain, CivilizationType, LeaderType, Type, Icon, Name, Description, SortIndex)
SELECT 'Players:Expansion2_Players',
       CivilizationType,
       'LEADER_BARBAROSSA_ALT',
       Type,
       Icon,
       Name,
       Description,
       SortIndex
FROM PlayerItems
WHERE LeaderType = 'LEADER_BARBAROSSA'
  AND Domain = 'Players:Expansion2_Players';