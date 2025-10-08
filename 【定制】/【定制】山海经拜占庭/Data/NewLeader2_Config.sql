--	FILE: NewLeader2_Config.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/10/3 11:23:08
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT OR
REPLACE INTO Players
(Domain, CivilizationType, LeaderType, CivilizationName, CivilizationIcon, LeaderName, LeaderIcon,
 CivilizationAbilityName, CivilizationAbilityDescription, CivilizationAbilityIcon, LeaderAbilityName,
 LeaderAbilityDescription, LeaderAbilityIcon, Portrait, PortraitBackground)
VALUES ('Players:Expansion2_Players',
        'CIVILIZATION_BYZANTIUM',
        'LEADER_BASIL_ALT',
        'LOC_CIVILIZATION_BYZANTIUM_NAME',
        'ICON_CIVILIZATION_BYZANTIUM',
        'LOC_LEADER_BASIL_ALT_NAME',
        'ICON_LEADER_BASIL_ALT',
        'LOC_TRAIT_CIVILIZATION_BYZANTIUM_NAME',
        'LOC_TRAIT_CIVILIZATION_BYZANTIUM_DESCRIPTION',
        'ICON_CIVILIZATION_BYZANTIUM',
        'LOC_TRAIT_LEADER_BASIL_ALT_ZISHI_ALT_NAME',
        'LOC_TRAIT_LEADER_BASIL_ALT_ZISHI_ALT_DESCRIPTION',
        'ICON_LEADER_BASIL',
        'LEADER_BASIL_NEUTRAL',
        'LEADER_BASIL_BACKGROUND');



INSERT INTO PlayerItems
(Domain, CivilizationType, LeaderType, Type, Icon, Name, Description, SortIndex)
VALUES ('Players:Expansion2_Players', 'CIVILIZATION_BYZANTIUM', 'LEADER_BASIL_ALT',
        'UNIT_BYZANTINE_DROMON', 'ICON_UNIT_BYZANTINE_DROMON', 'LOC_UNIT_BYZANTINE_DROMON_NAME',
        'LOC_UNIT_BYZANTINE_DROMON_DESCRIPTION', 10),
       ('Players:Expansion2_Players', 'CIVILIZATION_BYZANTIUM', 'LEADER_BASIL_ALT',
        'DISTRICT_HIPPODROME', 'ICON_DISTRICT_HIPPODROME', 'LOC_DISTRICT_HIPPODROME_NAME',
        'LOC_DISTRICT_HIPPODROME_DESCRIPTION', 20),
       ('Players:Expansion2_Players', 'CIVILIZATION_BYZANTIUM', 'LEADER_BASIL_ALT',
        'UNIT_20251002', 'ICON_UNIT_20251002', 'LOC_UNIT_20251002_NAME',
        'LOC_UNIT_20251002_DESCRIPTION', 40);
