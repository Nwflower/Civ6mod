--	FILE: NewLeader1_Config.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/2 15:46:23
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT OR
REPLACE INTO Players
(Domain, CivilizationType, LeaderType, CivilizationName, CivilizationIcon, LeaderName, LeaderIcon,
 CivilizationAbilityName, CivilizationAbilityDescription, CivilizationAbilityIcon, LeaderAbilityName,
 LeaderAbilityDescription, LeaderAbilityIcon, Portrait, PortraitBackground)
VALUES ('Players:Expansion2_Players', 'CIVILIZATION_NW_XIULUOWEIMIAN', 'LEADER_NW_SANQIAN',
        'LOC_CIVILIZATION_NW_XIULUOWEIMIAN_NAME', 'ICON_CIVILIZATION_NW_XIULUOWEIMIAN', 'LOC_LEADER_NW_SANQIAN_NAME',
        'ICON_LEADER_NW_SANQIAN', 'LOC_TRAIT_CIVILIZATION_NW_XIULUOWEIMIAN_TRAIT_XIULUO_NAME',
        'LOC_TRAIT_CIVILIZATION_NW_XIULUOWEIMIAN_TRAIT_XIULUO_DESCRIPTION', 'ICON_CIVILIZATION_NW_XIULUOWEIMIAN',
        'LOC_TRAIT_LEADER_NW_SANQIAN_TRAIT_SANQIANSHENGUO_NAME', 'LOC_TRAIT_LEADER_NW_SANQIAN_TRAIT_SANQIANSHENGUO_DESCRIPTION',
        'ICON_LEADER_NW_SANQIAN', 'LEADER_NW_SANQIAN_NEUTRAL', 'LEADER_NW_SANQIAN_BACKGROUND');

INSERT INTO PlayerItems
(Domain, CivilizationType, LeaderType, Type, Icon, Name, Description, SortIndex)
VALUES ('Players:Expansion2_Players', 'CIVILIZATION_NW_XIULUOWEIMIAN', 'LEADER_NW_SANQIAN',
        'DISTRICT_XULINGTA', 'ICON_DISTRICT_XULINGTA', 'LOC_DISTRICT_XULINGTA_NAME',
        'LOC_DISTRICT_XULINGTA_DESCRIPTION', 10),
       ('Players:Expansion2_Players', 'CIVILIZATION_NW_XIULUOWEIMIAN', 'LEADER_NW_SANQIAN',
        'UNIT_ANYINQISHI', 'ICON_UNIT_ANYINQISHI', 'LOC_UNIT_ANYINQISHI_NAME',
        'LOC_UNIT_ANYINQISHI_DESCRIPTION', 40);
