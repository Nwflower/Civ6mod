--	FILE: CIVILIZATION_ASIS_Config.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/13 11:37:52
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
VALUES ('Players:Expansion2_Players', 'CIVILIZATION_NW_ASIS', 'LEADER_NWBNB',
        'LOC_CIVILIZATION_NW_ASIS_NAME', 'ICON_CIVILIZATION_NW_ASIS', 'LOC_LEADER_NWBNB_NAME',
        'ICON_LEADER_NWBNB', 'LOC_TRAIT_CIVILIZATION_NW_ASIS_NWASIS1_NAME',
        'LOC_TRAIT_CIVILIZATION_NW_ASIS_NWASIS1_DESCRIPTION', 'ICON_CIVILIZATION_NW_ASIS',
        'LOC_TRAIT_LEADER_NWBNB_NWASIS2_NAME', 'LOC_TRAIT_LEADER_NWBNB_NWASIS2_DESCRIPTION',
        'ICON_LEADER_NWBNB', 'LEADER_NWBNB_NEUTRAL', 'LEADER_NWBNB_BACKGROUND');

INSERT INTO PlayerItems
(Domain, CivilizationType, LeaderType, Type, Icon, Name, Description, SortIndex)
VALUES ('Players:Expansion2_Players', 'CIVILIZATION_NW_ASIS', 'LEADER_NWBNB',
        'DISTRICT_JEER', 'ICON_DISTRICT_JEER', 'LOC_DISTRICT_JEER_NAME',
        'LOC_DISTRICT_JEER_DESCRIPTION', 10),
    ('Players:Expansion2_Players', 'CIVILIZATION_NW_ASIS', 'LEADER_NWBNB',
        'UNIT_NIULI', 'ICON_UNIT_NIULI', 'LOC_UNIT_NIULI_NAME',
        'LOC_UNIT_NIULI_DESCRIPTION', 20);
