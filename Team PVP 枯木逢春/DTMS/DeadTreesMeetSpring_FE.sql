-- Author: QIANCHUANBAILANG
-- DateCreated: 2025-8-7 22:45:53
--------------------------------------------------------------


INSERT INTO Parameters(ParameterId, Name, Description, Domain, DefaultValue, ConfigurationGroup, ConfigurationId,  GroupId, SortIndex) VALUES
('NW_DTMS_CAC_REBALANCE','LOC_NW_DTMS_CAC_REBALANCE_NAME','LOC_NW_DTMS_CAC_REBALANCE_DESCRIPTION','bool',1,'Game','NW_DTMS_CAC_REBALANCE','AdvancedOptions',1640);

UPDATE Players
SET LeaderAbilityDescription='LOC_TRAIT_LEADER_ELEANOR_FRANCE_LOYALTY_TEAM_PVP_DESCRIPTION'
Where CivilizationType = 'CIVILIZATION_FRANCE'
  AND LeaderType = 'LEADER_ELEANOR_FRANCE';

INSERT INTO PlayerItems(Domain, CivilizationType, LeaderType, Type, Name, Description, Icon, SortIndex)
VALUES ('Players:Expansion2_Players',
        'CIVILIZATION_MACEDON',
        'LEADER_ALEXANDER',
        'UNIT_ALEXANDER_THE_GREAT',
        'LOC_LEADER_NW_ALEXANDER_NAME',
        'LOC_LEADER_NW_ALEXANDER_DESCRIPTION',
        'ICON_UNIT_ALEXANDER_THE_GREAT',
        25);