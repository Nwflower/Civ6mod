-- Author: QIANCHUANBAILANG
-- DateCreated: 2025-8-7 22:45:53
--------------------------------------------------------------


-- INSERT INTO Parameters(ParameterId, Name, Description, Domain, DefaultValue, ConfigurationGroup, ConfigurationId,
--                        GroupId, SortIndex)
-- VALUES ('NW_DTMS_NATUREWONDER_REBALANCE', 'LOC_NW_DTMS_NATUREWONDER_REBALANCE_NAME', 'LOC_NW_DTMS_NATUREWONDER_REBALANCE_DESCRIPTION', 'bool', 1, 'Game',
--         'NW_DTMS_NATUREWONDER_REBALANCE', 'AdvancedOptions', 1640),
--        ('NW_DTMS_WONDER_REBALANCE', 'LOC_NW_DTMS_WONDER_REBALANCE_NAME', 'LOC_NW_DTMS_WONDER_REBALANCE_DESCRIPTION',
--         'bool', 1, 'Game', 'NW_DTMS_WONDER_REBALANCE', 'AdvancedOptions', 1641);
UPDATE Players
SET LeaderAbilityDescription='LOC_TRAIT_LEADER_ELEANOR_FRANCE_LOYALTY_TEAM_PVP_DESCRIPTION'
Where CivilizationType = 'CIVILIZATION_FRANCE'
  AND LeaderType = 'LEADER_ELEANOR_FRANCE';
