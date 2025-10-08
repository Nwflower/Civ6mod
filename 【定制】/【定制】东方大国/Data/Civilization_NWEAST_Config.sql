--	FILE: Civilization_NWEAST_Config.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/12 11:48:27
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
        'CIVILIZATION_NWEAST',
        'LEADER_PLA',
        'LOC_CIVILIZATION_NWEAST_NAME',
        'ICON_CIVILIZATION_NWEAST',
        'LOC_LEADER_PLA_NAME',
        'ICON_LEADER_PLA',
        'LOC_TRAIT_CIVILIZATION_DYNASTIC_CYCLE_NAME',
        'LOC_TRAIT_CIVILIZATION_DYNASTIC_CYCLE_DESCRIPTION',
        'ICON_CIVILIZATION_NWEAST',
        'LOC_TRAIT_LEADER_PLA_CULTUREEXPAND_NAME',
        'LOC_TRAIT_LEADER_PLA_CULTUREEXPAND_DESCRIPTION',
        'ICON_LEADER_PLA',
        'LEADER_PLA_NEUTRAL',
        'LEADER_PLA_BACKGROUND');

INSERT INTO PlayerItems
(Domain, CivilizationType, LeaderType, Type, Icon, Name, Description, SortIndex)
VALUES ('Players:Expansion2_Players',
        'CIVILIZATION_NWEAST',
        'LEADER_PLA',
        'TRAIT_CIVILIZATION_NWEAST_SUPERBUILD',
        'ICON_CIVILIZATION_NWEAST',
        'LOC_TRAIT_CIVILIZATION_NWEAST_SUPERBUILD_NAME',
        'LOC_TRAIT_CIVILIZATION_NWEAST_SUPERBUILD_DESCRIPTION',
        1),
    ('Players:Expansion2_Players',
        'CIVILIZATION_NWEAST',
        'LEADER_PLA',
        'TRAIT_CIVILIZATION_NWEAST_SUPERBUILD2',
        'ICON_CIVILIZATION_NWEAST',
        'LOC_TRAIT_CIVILIZATION_NWEAST_SUPERBUILD2_NAME',
        'LOC_TRAIT_CIVILIZATION_NWEAST_SUPERBUILD2_DESCRIPTION',
        2),
    ('Players:Expansion2_Players',
        'CIVILIZATION_NWEAST',
        'LEADER_PLA',
        'TRAIT_LEADER_PLA_CULTUREEXPAND2',
        'ICON_CIVILIZATION_NWEAST',
        'LOC_TRAIT_LEADER_PLA_CULTUREEXPAND2_NAME',
        'LOC_TRAIT_LEADER_PLA_CULTUREEXPAND2_DESCRIPTION',
        4),
    ('Players:Expansion2_Players',
        'CIVILIZATION_NWEAST',
        'LEADER_PLA',
        'TRAIT_LEADER_PLA_CULTUREEXPAND3',
        'ICON_CIVILIZATION_NWEAST',
        'LOC_TRAIT_LEADER_PLA_CULTUREEXPAND3_NAME',
        'LOC_TRAIT_LEADER_PLA_CULTUREEXPAND3_DESCRIPTION',
        5),
    ('Players:Expansion2_Players',
        'CIVILIZATION_NWEAST',
        'LEADER_PLA',
        'TRAIT_LEADER_PLA_CULTUREEXPAND4',
        'ICON_CIVILIZATION_NWEAST',
        'LOC_TRAIT_LEADER_PLA_CULTUREEXPAND4_NAME',
        'LOC_TRAIT_LEADER_PLA_CULTUREEXPAND4_DESCRIPTION',
        6),
    ('Players:Expansion2_Players',
        'CIVILIZATION_NWEAST',
        'LEADER_PLA',
        'TRAIT_LEADER_PLA_CULTUREEXPAND5',
        'ICON_CIVILIZATION_NWEAST',
        'LOC_TRAIT_LEADER_PLA_CULTUREEXPAND5_NAME',
        'LOC_TRAIT_LEADER_PLA_CULTUREEXPAND5_DESCRIPTION',
        7),
    ('Players:Expansion2_Players',
        'CIVILIZATION_NWEAST',
        'LEADER_PLA',
        'TRAIT_LEADER_PLA_CULTUREEXPAND6',
        'ICON_CIVILIZATION_NWEAST',
        'LOC_TRAIT_LEADER_PLA_CULTUREEXPAND6_NAME',
        'LOC_TRAIT_LEADER_PLA_CULTUREEXPAND6_DESCRIPTION',
        8),
    ('Players:Expansion2_Players',
        'CIVILIZATION_NWEAST',
        'LEADER_PLA',
        'DISTRICT_TIANCEFU',
        'ICON_DISTRICT_TIANCEFU',
        'LOC_DISTRICT_TIANCEFU_NAME',
        'LOC_DISTRICT_TIANCEFU_DESCRIPTION',
        10),
        ('Players:Expansion2_Players',
        'CIVILIZATION_NWEAST',
        'LEADER_PLA',
        'IMPROVEMENT_GREAT_WALL',
        'ICON_IMPROVEMENT_GREAT_WALL',
        'LOC_IMPROVEMENT_GREAT_WALL_NAME',
        'LOC_IMPROVEMENT_GREAT_WALL_DESCRIPTION',
        20);
