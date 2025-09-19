--	FILE: Liuche_Config.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/9 21:08:06
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
        'CIVILIZATION_CIV_NW_HAN',
        'LEADER_NW_LIUCHE',
        'LOC_CIVILIZATION_CIV_NW_HAN_NAME',
        'ICON_CIVILIZATION_CIV_NW_HAN',
        'LOC_LEADER_NW_LIUCHE_NAME',
        'ICON_LEADER_NW_LIUCHE',
        'LOC_TRAIT_CIVILIZATION_CIV_NW_HAN_RU_BIGGIST_NAME',
        'LOC_TRAIT_CIVILIZATION_CIV_NW_HAN_RU_BIGGIST_DESCRIPTION',
        'ICON_CIVILIZATION_CIV_NW_HAN',
        'LOC_TRAIT_LEADER_NW_LIUCHE_EN_LINK_NAME',
        'LOC_TRAIT_LEADER_NW_LIUCHE_EN_LINK_DESCRIPTION',
        'ICON_LEADER_NW_LIUCHE',
        'LEADER_NW_LIUCHE_NEUTRAL',
        'LEADER_NW_LIUCHE_BACKGROUND');

INSERT INTO PlayerItems
(Domain, CivilizationType, LeaderType, Type, Icon, Name, Description, SortIndex)
VALUES ('Players:Expansion2_Players',
        'CIVILIZATION_CIV_NW_HAN',
        'LEADER_NW_LIUCHE',
        'BUILDING_YAN_MARKET',
        'ICON_BUILDING_YAN_MARKET',
        'LOC_BUILDING_YAN_MARKET_NAME',
        'LOC_BUILDING_YAN_MARKET_DESCRIPTION',
        30),
       ('Players:Expansion2_Players',
        'CIVILIZATION_CIV_NW_HAN',
        'LEADER_NW_LIUCHE',
        'UNIT_CAR_CALAVEY',
        'ICON_UNIT_CAR_CALAVEY',
        'LOC_UNIT_CAR_CALAVEY_NAME',
        'LOC_UNIT_CAR_CALAVEY_DESCRIPTION',
        40);

INSERT OR
REPLACE
INTO Players
(Domain, CivilizationType, LeaderType, CivilizationName, CivilizationIcon, LeaderName, LeaderIcon,
 CivilizationAbilityName, CivilizationAbilityDescription, CivilizationAbilityIcon, LeaderAbilityName,
 LeaderAbilityDescription, LeaderAbilityIcon, Portrait, PortraitBackground)
VALUES ('Players:Expansion2_Players',
        'CIVILIZATION_CIV_NW_HAN',
        'LEADER_NW_LIUCHE_ALT',
        'LOC_CIVILIZATION_CIV_NW_HAN_NAME',
        'ICON_CIVILIZATION_CIV_NW_HAN',
        'LOC_LEADER_NW_LIUCHE_ALT_NAME',
        'ICON_LEADER_NW_LIUCHE_ALT',
        'LOC_TRAIT_CIVILIZATION_CIV_NW_HAN_RU_BIGGIST_NAME',
        'LOC_TRAIT_CIVILIZATION_CIV_NW_HAN_RU_BIGGIST_DESCRIPTION',
        'ICON_CIVILIZATION_CIV_NW_HAN',
        'LOC_TRAIT_LEADER_NW_LIUCHE_MUST_KILL_NAME',
        'LOC_TRAIT_LEADER_NW_LIUCHE_MUST_KILL_DESCRIPTION',
        'ICON_LEADER_NW_LIUCHE_ALT',
        'LEADER_NW_LIUCHE_ALT_NEUTRAL',
        'LEADER_NW_LIUCHE_ALT_BACKGROUND');

INSERT INTO PlayerItems
(Domain, CivilizationType, LeaderType, Type, Icon, Name, Description, SortIndex)
VALUES ('Players:Expansion2_Players',
        'CIVILIZATION_CIV_NW_HAN',
        'LEADER_NW_LIUCHE_ALT',
        'BUILDING_YAN_MARKET',
        'ICON_BUILDING_YAN_MARKET',
        'LOC_BUILDING_YAN_MARKET_NAME',
        'LOC_BUILDING_YAN_MARKET_DESCRIPTION',
        30),
       ('Players:Expansion2_Players',
        'CIVILIZATION_CIV_NW_HAN',
        'LEADER_NW_LIUCHE_ALT',
        'UNIT_CAR_CALAVEY',
        'ICON_UNIT_CAR_CALAVEY',
        'LOC_UNIT_CAR_CALAVEY_NAME',
        'LOC_UNIT_CAR_CALAVEY_DESCRIPTION',
        40);
