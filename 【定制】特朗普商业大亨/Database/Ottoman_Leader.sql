-- Penacony_Leader
-- Author: Nwflower
-- DateCreated: 2025-5-9 16:22:20leader_suleiman
--------------------------------------------------------------
--------------------------------------------------------------
-- 出生地绑海，因此做个虚拟文明
INSERT INTO Types(Type, Kind)
VALUES ('CIVILIZATION_NW_AMERICA', 'KIND_CIVILIZATION');

INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth,
                          StartingCivilizationLevelType, Ethnicity)
SELECT 'CIVILIZATION_NW_AMERICA',
       Name,
       Description,
       Adjective,
       RandomCityNameDepth,
       StartingCivilizationLevelType,
       Ethnicity
FROM Civilizations
WHERE CivilizationType = 'CIVILIZATION_AMERICA';


INSERT INTO CivilizationInfo(CivilizationType, Header, Caption, SortIndex)SELECT
'CIVILIZATION_NW_AMERICA',Header, Caption, SortIndex
FROM CivilizationInfo
WHERE CivilizationType = 'CIVILIZATION_AMERICA';

INSERT INTO CityNames(CivilizationType, CityName)
SELECT 'CIVILIZATION_NW_AMERICA',
       CityName
FROM CityNames
WHERE CivilizationType = 'CIVILIZATION_AMERICA';

INSERT INTO CivilizationCitizenNames (CivilizationType, CitizenName, Female, Modern)
SELECT 'CIVILIZATION_NW_AMERICA', CitizenName, Female, Modern
FROM CivilizationCitizenNames
WHERE CivilizationType = 'CIVILIZATION_AMERICA';

INSERT INTO StartBiasTerrains(CivilizationType, TerrainType, Tier)
VALUES ('CIVILIZATION_NW_AMERICA', 'TERRAIN_COAST', 1);

---------------

INSERT INTO Types(Type, Kind)
VALUES ('TRAIT_CIVILIZATION_NW_AMERICA_FREEDOM', 'KIND_TRAIT'),
       ('TRAIT_UNIT_HANGMU', 'KIND_TRAIT'),
       ('TRAIT_DISTRICT_FREEDOM_HARBOR', 'KIND_TRAIT');

INSERT INTO Traits (TraitType, Name, Description)
VALUES ('TRAIT_CIVILIZATION_NW_AMERICA_FREEDOM', 'LOC_TRAIT_CIVILIZATION_NW_AMERICA_FREEDOM_NAME',
        'LOC_TRAIT_CIVILIZATION_NW_AMERICA_FREEDOM_DESCRIPTION');

INSERT INTO Traits (TraitType)
VALUES ('TRAIT_UNIT_HANGMU'),
       ('TRAIT_DISTRICT_FREEDOM_HARBOR');

INSERT INTO CivilizationTraits (TraitType, CivilizationType)
VALUES ('TRAIT_CIVILIZATION_NW_AMERICA_FREEDOM', 'CIVILIZATION_NW_AMERICA'),
       ('TRAIT_UNIT_HANGMU', 'CIVILIZATION_NW_AMERICA'),
       ('TRAIT_DISTRICT_FREEDOM_HARBOR', 'CIVILIZATION_NW_AMERICA');

UPDATE CivilizationLeaders SET CivilizationType ='CIVILIZATION_NW_AMERICA' WHERE LeaderType = 'LEADER_JFD_TRUMP_ALT';
