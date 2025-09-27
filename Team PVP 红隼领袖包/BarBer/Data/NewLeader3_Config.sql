--	FILE: NewLeader3_Config.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/22 21:48:22
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT OR
REPLACE INTO Players
(Domain, CivilizationType, LeaderType, CivilizationName, CivilizationIcon, LeaderName, LeaderIcon,
 CivilizationAbilityName, CivilizationAbilityDescription, CivilizationAbilityIcon, LeaderAbilityName,
 LeaderAbilityDescription, LeaderAbilityIcon, Portrait, PortraitBackground)
VALUES ('Players:Expansion2_Players', 'CIVILIZATION_CIV_NW_0003', 'LEADER_NW_0004',
        'LOC_CIVILIZATION_CIV_NW_0003_NAME', 'ICON_CIVILIZATION_CIV_NW_0003', 'LOC_LEADER_NW_0004_NAME',
        'ICON_LEADER_NW_0004', 'LOC_TRAIT_CIVILIZATION_CIV_NW_0003_NW007_NAME',
        'LOC_TRAIT_CIVILIZATION_CIV_NW_0003_NW007_DESCRIPTION', 'ICON_CIVILIZATION_CIV_NW_0003',
        'LOC_TRAIT_LEADER_NW_0004_NW008_NAME', 'LOC_TRAIT_LEADER_NW_0004_NW008_DESCRIPTION',
        'ICON_LEADER_NW_0004', 'LEADER_NW_0004_NEUTRAL', 'LEADER_NW_0004_BACKGROUND');

INSERT INTO PlayerItems
(Domain, CivilizationType, LeaderType, Type, Icon, Name, Description, SortIndex)
VALUES ('Players:Expansion2_Players', 'CIVILIZATION_CIV_NW_0003', 'LEADER_NW_0004',
        'DISTRICT_NW009', 'ICON_DISTRICT_NW009', 'LOC_DISTRICT_NW009_NAME',
        'LOC_DISTRICT_NW009_DESCRIPTION', 10),
       ('Players:Expansion2_Players', 'CIVILIZATION_CIV_NW_0003', 'LEADER_NW_0004',
        'IMPROVEMENT_NW010', 'ICON_IMPROVEMENT_NW010', 'LOC_IMPROVEMENT_NW010_NAME',
        'LOC_IMPROVEMENT_NW010_DESCRIPTION', 20),
       ('Players:Expansion2_Players', 'CIVILIZATION_CIV_NW_0003', 'LEADER_NW_0004',
        'UNIT_NW011', 'ICON_UNIT_NW011', 'LOC_UNIT_NW011_NAME',
        'LOC_UNIT_NW011_DESCRIPTION', 30);
