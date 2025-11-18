-- Author: QIANCHUANBAILANG
-- DateCreated: 2025-8-7 22:45:53
--------------------------------------------------------------

INSERT INTO PlayerItems(Domain, CivilizationType, LeaderType, Type, Name, Description, Icon, SortIndex)
VALUES ('Players:Expansion2_Players',
        'CIVILIZATION_MACEDON',
        'LEADER_ALEXANDER',
        'UNIT_ALEXANDER_THE_GREAT',
        'LOC_LEADER_NW_ALEXANDER_NAME',
        'LOC_LEADER_NW_ALEXANDER_DESCRIPTION',
        'ICON_UNIT_ALEXANDER_THE_GREAT',
        25);

-- 秘密结社
UPDATE Parameters SET DefaultValue = 1 WHERE ParameterId = 'GameMode_SecretSocieties';

-- 行业与公司
UPDATE Parameters SET DefaultValue = 1 WHERE ParameterId = 'GameMode_Monopolies';
