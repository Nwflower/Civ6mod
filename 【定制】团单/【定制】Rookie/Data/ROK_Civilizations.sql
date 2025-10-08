
INSERT INTO CivilizationLeaders (CivilizationType, LeaderType, CapitalName)
SELECT 'CIVILIZATION_MALI', 'LEADER_NW_ROK', CapitalName
FROM CivilizationLeaders WHERE LeaderType = 'LEADER_MANSA_MUSA' AND CivilizationType = 'CIVILIZATION_MALI';
