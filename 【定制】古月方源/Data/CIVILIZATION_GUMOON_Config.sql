--	FILE: CIVILIZATION_GUMOON_Config.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/24 19:28:22
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT OR
REPLACE INTO Players
(Domain, CivilizationType, LeaderType, CivilizationName, CivilizationIcon, LeaderName, LeaderIcon,
 CivilizationAbilityName, CivilizationAbilityDescription, CivilizationAbilityIcon, LeaderAbilityName,
 LeaderAbilityDescription, LeaderAbilityIcon, Portrait, PortraitBackground)
VALUES ('Players:Expansion2_Players', 'CIVILIZATION_CIV_DAAIM', 'LEADER_LEADER_GUMOON',
        'LOC_CIVILIZATION_CIV_DAAIM_NAME', 'ICON_CIVILIZATION_CIV_DAAIM', 'LOC_LEADER_LEADER_GUMOON_NAME',
        'ICON_LEADER_LEADER_GUMOON', 'LOC_TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE_NAME',
        'LOC_TRAIT_CIVILIZATION_CIV_DAAIM_ZUNZHE_DESCRIPTION', 'ICON_CIVILIZATION_CIV_DAAIM',
        'LOC_TRAIT_LEADER_LEADER_GUMOON_ZHIZUN_NAME', 'LOC_TRAIT_LEADER_LEADER_GUMOON_ZHIZUN_DESCRIPTION',
        'ICON_LEADER_LEADER_GUMOON', 'LEADER_LEADER_GUMOON_NEUTRAL', 'LEADER_LEADER_GUMOON_BACKGROUND');

INSERT INTO PlayerItems
(Domain, CivilizationType, LeaderType, Type, Icon, Name, Description, SortIndex)
VALUES ('Players:Expansion2_Players', 'CIVILIZATION_CIV_DAAIM', 'LEADER_LEADER_GUMOON',
        'DISTRICT_NW_250924', 'ICON_DISTRICT_NW_250924', 'LOC_DISTRICT_NW_250924_NAME',
        'LOC_DISTRICT_NW_250924_DESCRIPTION', 10),
       ('Players:Expansion2_Players', 'CIVILIZATION_CIV_DAAIM', 'LEADER_LEADER_GUMOON',
        'BUILDING_NW_250924', 'ICON_BUILDING_NW_250924', 'LOC_BUILDING_NW_250924_NAME',
        'LOC_BUILDING_NW_250924_DESCRIPTION', 30),
       ('Players:Expansion2_Players', 'CIVILIZATION_CIV_DAAIM', 'LEADER_LEADER_GUMOON',
        'BUILDING_NW_250925', 'ICON_BUILDING_NW_250925', 'LOC_BUILDING_NW_250925_NAME',
        'LOC_BUILDING_NW_250925_DESCRIPTION', 32),
       ('Players:Expansion2_Players', 'CIVILIZATION_CIV_DAAIM', 'LEADER_LEADER_GUMOON',
        'BUILDING_NW_250926', 'ICON_BUILDING_NW_250926', 'LOC_BUILDING_NW_250926_NAME',
        'LOC_BUILDING_NW_250926_DESCRIPTION', 33),
       ('Players:Expansion2_Players', 'CIVILIZATION_CIV_DAAIM', 'LEADER_LEADER_GUMOON',
        'UNIT_NW_250924', 'ICON_UNIT_NW_250924', 'LOC_UNIT_NW_250924_NAME',
        'LOC_UNIT_NW_250924_DESCRIPTION', 40);
