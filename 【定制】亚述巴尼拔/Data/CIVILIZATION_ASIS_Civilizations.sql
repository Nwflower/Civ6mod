--	FILE: CIVILIZATION_ASIS_Civilizations.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/9/13 11:37:52
--------------------------------------------------------------------------------
--  作者： 千川白浪
--  特别鸣谢： 优妮
------------------------------------------------------------------------------
INSERT INTO Types(Type, Kind)
VALUES ('CIVILIZATION_NW_ASIS', 'KIND_CIVILIZATION'),
       ('TRAIT_CIVILIZATION_NW_ASIS_NWASIS1', 'KIND_TRAIT'),
       ('TRAIT_UNIT_NIULI', 'KIND_TRAIT'),
       ('TRAIT_DISTRICT_JEER', 'KIND_TRAIT');

INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth,StartingCivilizationLevelType, Ethnicity)
VALUES ('CIVILIZATION_NW_ASIS', 'LOC_CIVILIZATION_NW_ASIS_NAME', 'LOC_CIVILIZATION_NW_ASIS_DESCRIPTION',
        'LOC_CIVILIZATION_NW_ASIS_ADJECTIVE', 10, 'CIVILIZATION_LEVEL_FULL_CIV', 'ETHNICITY_MEDIT');

INSERT INTO CivilizationLeaders (CivilizationType, LeaderType, CapitalName)
VALUES ('CIVILIZATION_NW_ASIS', 'LEADER_NWBNB', 'LOC_CITY_NAME_NWASIS');

INSERT INTO CivilizationInfo(CivilizationType, Header, Caption, SortIndex)
VALUES ('CIVILIZATION_NW_ASIS', 'LOC_CIVINFO_LOCATION', 'LOC_CIVINFO_NW_ASIS_LOCATION', 10),
       ('CIVILIZATION_NW_ASIS', 'LOC_CIVINFO_SIZE', 'LOC_CIVINFO_NW_ASIS_SIZE', 20),
       ('CIVILIZATION_NW_ASIS', 'LOC_CIVINFO_POPULATION', 'LOC_CIVINFO_NW_ASIS_POPULATION', 30),
       ('CIVILIZATION_NW_ASIS', 'LOC_CIVINFO_CAPITAL', 'LOC_CIVINFO_NW_ASIS_CAPITAL', 40);

INSERT INTO Traits (TraitType, Name, Description)
VALUES ('TRAIT_CIVILIZATION_NW_ASIS_NWASIS1', 'LOC_TRAIT_CIVILIZATION_NW_ASIS_NWASIS1_NAME',
        'LOC_TRAIT_CIVILIZATION_NW_ASIS_NWASIS1_DESCRIPTION');


INSERT INTO Traits (TraitType)
VALUES ('TRAIT_UNIT_NIULI'),
       ('TRAIT_DISTRICT_JEER');

INSERT INTO CivilizationTraits (TraitType, CivilizationType)
VALUES ('TRAIT_CIVILIZATION_NW_ASIS_NWASIS1', 'CIVILIZATION_NW_ASIS'),
       ('TRAIT_UNIT_NIULI', 'CIVILIZATION_NW_ASIS'),
       ('TRAIT_DISTRICT_JEER', 'CIVILIZATION_NW_ASIS');

INSERT INTO CityNames(CivilizationType, CityName)
SELECT 'CIVILIZATION_NW_ASIS', CityName
FROM CityNames WHERE CivilizationType = 'CIVILIZATION_SUMERIA';

INSERT INTO CivilizationCitizenNames(CivilizationType, CitizenName, Female, Modern) SELECT
'CIVILIZATION_NW_ASIS', CitizenName, Female, Modern
FROM CivilizationCitizenNames WHERE CivilizationType = 'CIVILIZATION_SUMERIA';