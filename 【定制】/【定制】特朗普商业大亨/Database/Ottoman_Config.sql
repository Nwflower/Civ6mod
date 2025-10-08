
--==========================================================================================================================
-- CONFIG DATA
--==========================================================================================================================
-- Players
----------------------------------------------------------------------------------------------------------------------------
UPDATE Players SET CivilizationType = 'CIVILIZATION_NW_AMERICA',
                   CivilizationName = 'LOC_CIVILIZATION_NW_AMERICA_NAME',
                   CivilizationAbilityName = 'LOC_TRAIT_CIVILIZATION_NW_AMERICA_FREEDOM_NAME',
                   CivilizationAbilityDescription = 'LOC_TRAIT_CIVILIZATION_NW_AMERICA_FREEDOM_DESCRIPTION'
                   WHERE LeaderType = 'LEADER_JFD_TRUMP_ALT';

----------------------------------------------------------------------------------------------------------------------------
-- PlayerItems
----------------------------------------------------------------------------------------------------------------------------
DELETE FROM PlayerItems WHERE LeaderType = 'LEADER_JFD_TRUMP_ALT';

INSERT OR
REPLACE INTO PlayerItems
(CivilizationType, Domain, LeaderType, Type, Icon, Name, Description, SortIndex)
VALUES ('CIVILIZATION_NW_AMERICA',
       'Players:Expansion2_Players',
       'LEADER_JFD_TRUMP_ALT',
       'DISTRICT_FREEDOM_HARBOR',
       'ICON_DISTRICT_FREEDOM_HARBOR',
       'LOC_DISTRICT_FREEDOM_HARBOR_NAME',
       'LOC_DISTRICT_FREEDOM_HARBOR_DESCRIPTION',
       10),
    ('CIVILIZATION_NW_AMERICA',
       'Players:Expansion2_Players',
       'LEADER_JFD_TRUMP_ALT',
       'UNIT_HANGMU',
       'ICON_UNIT_HANGMU',
       'LOC_UNIT_HANGMU_NAME',
       'LOC_UNIT_HANGMU_DESCRIPTION',
       20);


--==========================================================================================================================
--=================