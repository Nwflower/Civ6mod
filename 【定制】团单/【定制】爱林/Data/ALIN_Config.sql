--	FILE: ALIN_Config.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/10/3 14:25:12
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
        'CIVILIZATION_VIETNAM',
        'LEADER_NWALIN',
        'LOC_CIVILIZATION_VIETNAM_NAME',
        'ICON_CIVILIZATION_VIETNAM',
        'LOC_LEADER_NWALIN_NAME',
        'ICON_LEADER_LADY_TRIEU',
        'LOC_TRAIT_CIVILIZATION_VIETNAM_NAME',
        'LOC_TRAIT_CIVILIZATION_VIETNAM_DESCRIPTION',
        'ICON_CIVILIZATION_VIETNAM',
        'LOC_TRAIT_LEADER_NWALIN_NAME',
        'LOC_TRAIT_LEADER_NWALIN_DESCRIPTION',
        'ICON_LEADER_LADY_TRIEU',
        'LEADER_LADY_TRIEU_NEUTRAL',
        'LEADER_LADY_TRIEU_BACKGROUND');


INSERT OR
REPLACE
INTO PlayerItems (Domain, CivilizationType, LeaderType, Type, Icon, Name, Description, SortIndex)
VALUES ('Players:Expansion2_Players',
        'CIVILIZATION_VIETNAM',
        'LEADER_NWALIN',
        'DISTRICT_THANH',
        'ICON_DISTRICT_THANH',
        'LOC_DISTRICT_THANH_NAME',
        'LOC_DISTRICT_THANH_DESCRIPTION',
        10),
       ('Players:Expansion2_Players',
        'CIVILIZATION_VIETNAM',
        'LEADER_NWALIN',
        'UNIT_VIETNAMESE_VOI_CHIEN',
        'ICON_UNIT_VIETNAMESE_VOI_CHIEN',
        'LOC_UNIT_VIETNAMESE_VOI_CHIEN_NAME',
        'LOC_UNIT_VIETNAMESE_VOI_CHIEN_DESCRIPTION',
        20);
