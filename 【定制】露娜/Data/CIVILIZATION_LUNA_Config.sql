--	FILE: CIVILIZATION_LUNA_Config.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/2 16:15:28
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT OR
REPLACE INTO Players
(Domain, CivilizationType, LeaderType, CivilizationName, CivilizationIcon, LeaderName, LeaderIcon,
 CivilizationAbilityName, CivilizationAbilityDescription, CivilizationAbilityIcon, LeaderAbilityName,
 LeaderAbilityDescription, LeaderAbilityIcon, Portrait, PortraitBackground)
VALUES ('Players:Expansion2_Players', 'CIVILIZATION_CIV_ZUAN', 'LEADER_NW_LUNA',
        'LOC_CIVILIZATION_CIV_ZUAN_NAME', 'ICON_CIVILIZATION_CIV_ZUAN', 'LOC_LEADER_NW_LUNA_NAME',
        'ICON_LEADER_NW_LUNA', 'LOC_TRAIT_CIVILIZATION_CIV_ZUAN_SPICE_ISLANDS_NAME',
        'LOC_TRAIT_CIVILIZATION_CIV_ZUAN_SPICE_ISLANDS_DESCRIPTION', 'ICON_CIVILIZATION_CIV_ZUAN',
        'LOC_TRAIT_LEADER_NW_LUNA_LUNA_TRAIT_NAME', 'LOC_TRAIT_LEADER_NW_LUNA_LUNA_TRAIT_DESCRIPTION',
        'ICON_LEADER_NW_LUNA', 'LEADER_NW_LUNA_NEUTRAL', 'LEADER_NW_LUNA_BACKGROUND');

INSERT INTO PlayerItems
(Domain, CivilizationType, LeaderType, Type, Icon, Name, Description, SortIndex)
VALUES ('Players:Expansion2_Players', 'CIVILIZATION_CIV_ZUAN', 'LEADER_NW_LUNA',
        'DISTRICT_MOON_BAY', 'ICON_DISTRICT_MOON_BAY', 'LOC_DISTRICT_MOON_BAY_NAME',
        'LOC_DISTRICT_MOON_BAY_DESCRIPTION', 10),
       ('Players:Expansion2_Players', 'CIVILIZATION_CIV_ZUAN', 'LEADER_NW_LUNA',
        'UNIT_LUNAR_BOAT', 'ICON_UNIT_LUNAR_BOAT', 'LOC_UNIT_LUNAR_BOAT_NAME',
        'LOC_UNIT_LUNAR_BOAT_DESCRIPTION', 40);
