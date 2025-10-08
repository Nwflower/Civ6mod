--	FILE: CIVILIZATION_NW_HANJ_Civilizations.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/9/15 18:21:35
--------------------------------------------------------------------------------
--  作者： 千川白浪
--  特别鸣谢： 优妮
------------------------------------------------------------------------------
INSERT INTO Types(Type, Kind)
VALUES ('CIVILIZATION_CIV_HANJ', 'KIND_CIVILIZATION'),
       ('TRAIT_CIVILIZATION_CIV_HANJ_NW003', 'KIND_TRAIT'),
       ('TRAIT_UNIT_NW_YULIN', 'KIND_TRAIT'),
       ('TRAIT_BUILDING_TAICANG', 'KIND_TRAIT');

INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth,StartingCivilizationLevelType, Ethnicity)
VALUES ('CIVILIZATION_CIV_HANJ', 'LOC_CIVILIZATION_CIV_HANJ_NAME', 'LOC_CIVILIZATION_CIV_HANJ_DESCRIPTION',
        'LOC_CIVILIZATION_CIV_HANJ_ADJECTIVE', 10, 'CIVILIZATION_LEVEL_FULL_CIV', 'ETHNICITY_MEDIT');

INSERT INTO CivilizationLeaders (CivilizationType, LeaderType, CapitalName)
VALUES ('CIVILIZATION_CIV_HANJ', 'LEADER_NW_LIUXUN', 'LOC_CITY_NAME_CHANGAN'),
       ('CIVILIZATION_CIV_HANJ', 'LEADER_NW_JET_LIUCHE', 'LOC_CITY_NAME_CHANGAN');

INSERT INTO CivilizationInfo(CivilizationType, Header, Caption, SortIndex)
VALUES ('CIVILIZATION_CIV_HANJ', 'LOC_CIVINFO_LOCATION', 'LOC_CIVINFO_CIV_HANJ_LOCATION', 10),
       ('CIVILIZATION_CIV_HANJ', 'LOC_CIVINFO_SIZE', 'LOC_CIVINFO_CIV_HANJ_SIZE', 20),
       ('CIVILIZATION_CIV_HANJ', 'LOC_CIVINFO_POPULATION', 'LOC_CIVINFO_CIV_HANJ_POPULATION', 30),
       ('CIVILIZATION_CIV_HANJ', 'LOC_CIVINFO_CAPITAL', 'LOC_CIVINFO_CIV_HANJ_CAPITAL', 40);

INSERT INTO Traits (TraitType, Name, Description)
VALUES ('TRAIT_CIVILIZATION_CIV_HANJ_NW003', 'LOC_TRAIT_CIVILIZATION_CIV_HANJ_NW003_NAME',
        'LOC_TRAIT_CIVILIZATION_CIV_HANJ_NW003_DESCRIPTION');


INSERT INTO Traits (TraitType)
VALUES ('TRAIT_UNIT_NW_YULIN'),
       ('TRAIT_BUILDING_TAICANG');

INSERT INTO CivilizationTraits (TraitType, CivilizationType)
VALUES ('TRAIT_CIVILIZATION_CIV_HANJ_NW003', 'CIVILIZATION_CIV_HANJ'),
       ('TRAIT_UNIT_NW_YULIN', 'CIVILIZATION_CIV_HANJ'),
       ('TRAIT_BUILDING_TAICANG', 'CIVILIZATION_CIV_HANJ');

INSERT INTO CityNames(CivilizationType, CityName)
SELECT 'CIVILIZATION_CIV_HANJ', CityName
FROM CityNames WHERE CivilizationType = 'CIVILIZATION_CHINA';

INSERT INTO CivilizationCitizenNames(CivilizationType, CitizenName, Female, Modern) SELECT
'CIVILIZATION_CIV_HANJ', CitizenName, Female, Modern
FROM CivilizationCitizenNames WHERE CivilizationType = 'CIVILIZATION_CHINA';

INSERT INTO StartBiasResources(CivilizationType, ResourceType, Tier) VALUES
('CIVILIZATION_CIV_HANJ','RESOURCE_BANANAS',1),
('CIVILIZATION_CIV_HANJ','RESOURCE_HORSES',5),
('CIVILIZATION_CIV_HANJ','RESOURCE_IRON',5);