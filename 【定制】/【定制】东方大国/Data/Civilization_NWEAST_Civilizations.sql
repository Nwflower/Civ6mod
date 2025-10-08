--	FILE: Civilization_NWEAST_Civilizations.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/9/12 11:48:27
--------------------------------------------------------------------------------
--  作者： 千川白浪
--  特别鸣谢： 优妮
------------------------------------------------------------------------------
INSERT INTO Types(Type, Kind)
VALUES ('CIVILIZATION_NWEAST', 'KIND_CIVILIZATION'),
       ('TRAIT_CIVILIZATION_NWEAST_SUPERBUILD', 'KIND_TRAIT'),
       ('TRAIT_CIVILIZATION_NWEAST_SUPERBUILD2', 'KIND_TRAIT'),
       ('TRAIT_DISTRICT_TIANCEFU', 'KIND_TRAIT');

INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth,StartingCivilizationLevelType, Ethnicity)
VALUES ('CIVILIZATION_NWEAST', 'LOC_CIVILIZATION_NWEAST_NAME', 'LOC_CIVILIZATION_NWEAST_DESCRIPTION',
        'LOC_CIVILIZATION_NWEAST_ADJECTIVE', 10, 'CIVILIZATION_LEVEL_FULL_CIV', 'ETHNICITY_MEDIT');

INSERT INTO CivilizationLeaders (CivilizationType, LeaderType, CapitalName)
VALUES ('CIVILIZATION_NWEAST', 'LEADER_PLA', 'LOC_CITY_NAME_BEIJINGSHI');

INSERT INTO CivilizationInfo(CivilizationType, Header, Caption, SortIndex)
SELECT 'CIVILIZATION_NWEAST', Header, Caption, SortIndex
FROM CivilizationInfo WHERE CivilizationType = 'CIVILIZATION_CHINA';

INSERT INTO Traits (TraitType, Name, Description)
VALUES ('TRAIT_CIVILIZATION_NWEAST_SUPERBUILD', 'LOC_TRAIT_CIVILIZATION_NWEAST_SUPERBUILD_NAME',
        'LOC_TRAIT_CIVILIZATION_NWEAST_SUPERBUILD_DESCRIPTION'),
    ('TRAIT_CIVILIZATION_NWEAST_SUPERBUILD2', 'LOC_TRAIT_CIVILIZATION_NWEAST_SUPERBUILD2_NAME',
        'LOC_TRAIT_CIVILIZATION_NWEAST_SUPERBUILD2_DESCRIPTION');


INSERT INTO Traits (TraitType)
VALUES ('TRAIT_DISTRICT_TIANCEFU');

INSERT INTO CivilizationTraits (TraitType, CivilizationType)
VALUES ('TRAIT_CIVILIZATION_NWEAST_SUPERBUILD', 'CIVILIZATION_NWEAST'),
       ('TRAIT_CIVILIZATION_NWEAST_SUPERBUILD2', 'CIVILIZATION_NWEAST'),
       ('TRAIT_DISTRICT_TIANCEFU', 'CIVILIZATION_NWEAST');

INSERT INTO CityNames(CivilizationType, CityName)
SELECT 'CIVILIZATION_NWEAST', CityName
FROM CityNames WHERE CivilizationType = 'CIVILIZATION_CHINA';


INSERT INTO CivilizationTraits (TraitType, CivilizationType)
SELECT TraitType, 'CIVILIZATION_NWEAST'
FROM CivilizationTraits WHERE CivilizationType = 'CIVILIZATION_CHINA';