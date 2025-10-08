--	FILE: Civilization_Douglas_Config.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/14 10:32:02
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT OR
REPLACE INTO Players
(Domain, CivilizationType, LeaderType, CivilizationName, CivilizationIcon, LeaderName, LeaderIcon,
 CivilizationAbilityName, CivilizationAbilityDescription, CivilizationAbilityIcon, LeaderAbilityName,
 LeaderAbilityDescription, LeaderAbilityIcon, Portrait, PortraitBackground)
VALUES ('Players:Expansion2_Players', 'CIVILIZATION_CIV_DOUGLAS', 'LEADER_LEADER_DOUGLAS',
        'LOC_CIVILIZATION_CIV_DOUGLAS_NAME', 'ICON_CIVILIZATION_CIV_DOUGLAS', 'LOC_LEADER_LEADER_DOUGLAS_NAME',
        'ICON_LEADER_LEADER_DOUGLAS', 'LOC_TRAIT_CIVILIZATION_CIV_DOUGLAS_NW001_NAME',
        'LOC_TRAIT_CIVILIZATION_CIV_DOUGLAS_NW001_DESCRIPTION', 'ICON_CIVILIZATION_CIV_DOUGLAS',
        'LOC_TRAIT_LEADER_LEADER_DOUGLAS_NW002_NAME', 'LOC_TRAIT_LEADER_LEADER_DOUGLAS_NW002_DESCRIPTION',
        'ICON_LEADER_LEADER_DOUGLAS', 'LEADER_LEADER_DOUGLAS_NEUTRAL', 'LEADER_LEADER_DOUGLAS_BACKGROUND');

INSERT INTO PlayerItems
(Domain, CivilizationType, LeaderType, Type, Icon, Name, Description, SortIndex)
VALUES ('Players:Expansion2_Players', 'CIVILIZATION_CIV_DOUGLAS', 'LEADER_LEADER_DOUGLAS',
        'DISTRICT_AMERICAN_CAMP', 'ICON_DISTRICT_AMERICAN_CAMP', 'LOC_DISTRICT_AMERICAN_CAMP_NAME',
        'LOC_DISTRICT_AMERICAN_CAMP_DESCRIPTION', 10),
       ('Players:Expansion2_Players', 'CIVILIZATION_CIV_DOUGLAS', 'LEADER_LEADER_DOUGLAS',
        'UNIT_NIMIZI_HANGMU', 'ICON_UNIT_NIMIZI_HANGMU', 'LOC_UNIT_NIMIZI_HANGMU_NAME',
        'LOC_UNIT_NIMIZI_HANGMU_DESCRIPTION', 40);
