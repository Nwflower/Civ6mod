--	FILE: Liuche_Civilizations.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/9/9 21:08:06
--------------------------------------------------------------------------------
--  作者： 千川白浪
--  特别鸣谢： 优妮
------------------------------------------------------------------------------
INSERT INTO Types(Type, Kind)
VALUES ('CIVILIZATION_CIV_NW_HAN', 'KIND_CIVILIZATION'),
       ('TRAIT_CIVILIZATION_CIV_NW_HAN_RU_BIGGIST', 'KIND_TRAIT'),
       ('TRAIT_UNIT_CAR_CALAVEY', 'KIND_TRAIT'),
       ('TRAIT_BUILDING_YAN_MARKET', 'KIND_TRAIT');

INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth,StartingCivilizationLevelType, Ethnicity)
VALUES ('CIVILIZATION_CIV_NW_HAN', 'LOC_CIVILIZATION_CIV_NW_HAN_NAME', 'LOC_CIVILIZATION_CIV_NW_HAN_DESCRIPTION',
        'LOC_CIVILIZATION_CIV_NW_HAN_ADJECTIVE', 10, 'CIVILIZATION_LEVEL_FULL_CIV', 'ETHNICITY_MEDIT');

INSERT INTO CivilizationLeaders (CivilizationType, LeaderType, CapitalName)
VALUES ('CIVILIZATION_CIV_NW_HAN', 'LEADER_NW_LIUCHE', 'LOC_CITY_NAME_CITY_JIMO'),
       ('CIVILIZATION_CIV_NW_HAN', 'LEADER_NW_LIUCHE_ALT', 'LOC_CITY_NAME_CITY_CHANGAN');

INSERT INTO CivilizationInfo(CivilizationType, Header, Caption, SortIndex)
SELECT 'CIVILIZATION_CIV_NW_HAN', Header, Caption, SortIndex
FROM CivilizationInfo WHERE CivilizationType = 'CIVILIZATION_CHINA';

INSERT INTO Traits (TraitType, Name, Description)
VALUES ('TRAIT_CIVILIZATION_CIV_NW_HAN_RU_BIGGIST', 'LOC_TRAIT_CIVILIZATION_CIV_NW_HAN_RU_BIGGIST_NAME',
        'LOC_TRAIT_CIVILIZATION_CIV_NW_HAN_RU_BIGGIST_DESCRIPTION');


INSERT INTO Traits (TraitType)
VALUES ('TRAIT_UNIT_CAR_CALAVEY'),
       ('TRAIT_BUILDING_YAN_MARKET');

INSERT INTO CivilizationTraits (TraitType, CivilizationType)
VALUES ('TRAIT_CIVILIZATION_CIV_NW_HAN_RU_BIGGIST', 'CIVILIZATION_CIV_NW_HAN'),
       ('TRAIT_UNIT_CAR_CALAVEY', 'CIVILIZATION_CIV_NW_HAN'),
       ('TRAIT_BUILDING_YAN_MARKET', 'CIVILIZATION_CIV_NW_HAN');

INSERT INTO CityNames(CivilizationType, CityName)
SELECT 'CIVILIZATION_CIV_NW_HAN', CityName
FROM CityNames WHERE CivilizationType = 'CIVILIZATION_CHINA';

INSERT INTO CivilizationCitizenNames(CivilizationType, CitizenName, Female, Modern)
SELECT 'CIVILIZATION_CIV_NW_HAN', CitizenName, Female, Modern
FROM CivilizationCitizenNames WHERE CivilizationType = 'CIVILIZATION_CHINA';

INSERT INTO DuplicateLeaders(LeaderType, OtherLeaderType) VALUES
('LEADER_NW_LIUCHE_ALT', 'LEADER_NW_LIUCHE');