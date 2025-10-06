--	FILE: LWT_Config.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/29 22:03:38
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
VALUES ('Players:Expansion2_Players',
        'CIVILIZATION_NW_DEEPSKY', 'LEADER_LIWEITAN',
        'LOC_CIVILIZATION_NW_DEEPSKY_NAME', 'ICON_CIVILIZATION_NW_DEEPSKY', 'LOC_LEADER_LIWEITAN_NAME',
        'ICON_LEADER_LIWEITAN', 'LOC_TRAIT_CIVILIZATION_NW_DEEPSKY_NICHAO_NAME',
        'LOC_TRAIT_CIVILIZATION_NW_DEEPSKY_NICHAO_DESCRIPTION', 'ICON_CIVILIZATION_NW_DEEPSKY',
        'LOC_TRAIT_LEADER_LIWEITAN_LWT_NAME', 'LOC_TRAIT_LEADER_LIWEITAN_LWT_DESCRIPTION',
        'ICON_LEADER_LIWEITAN', 'SELECT_LEADER_LIWEITA', 'LEADER_VICTORIA_ALT_BACKGROUND');

INSERT INTO PlayerItems
(Domain, CivilizationType, LeaderType, Type, Icon, Name, Description, SortIndex)
VALUES ('Players:Expansion2_Players', 'CIVILIZATION_NW_DEEPSKY', 'LEADER_LIWEITAN',
        'IMPROVEMENT_20250930', 'ICON_IMPROVEMENT_20250930', 'LOC_IMPROVEMENT_20250930_NAME',
        'LOC_IMPROVEMENT_20250930_DESCRIPTION', 10),
       ('Players:Expansion2_Players', 'CIVILIZATION_NW_DEEPSKY', 'LEADER_LIWEITAN',
        'IMPROVEMENT_20250929', 'ICON_IMPROVEMENT_20250929', 'LOC_IMPROVEMENT_20250929_NAME',
        'LOC_IMPROVEMENT_20250929_DESCRIPTION', 20),
       ('Players:Expansion2_Players', 'CIVILIZATION_NW_DEEPSKY', 'LEADER_LIWEITAN',
        'BUILDING_20250929', 'ICON_BUILDING_20250929', 'LOC_BUILDING_20250929_NAME',
        'LOC_BUILDING_20250929_DESCRIPTION', 30),
       ('Players:Expansion2_Players', 'CIVILIZATION_NW_DEEPSKY', 'LEADER_LIWEITAN',
        'UNIT_20250929', 'ICON_UNIT_20250929', 'LOC_UNIT_20250929_NAME',
        'LOC_UNIT_20250929_DESCRIPTION', 40);
