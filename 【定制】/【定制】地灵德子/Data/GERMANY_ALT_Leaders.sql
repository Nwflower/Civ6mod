--	FILE: GERMANY_ALT_Leader.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/9/23 9:28:58
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT INTO Types (Type, Kind)
Values ('LEADER_BARBAROSSA_ALT', 'KIND_LEADER'),
       ('TRAIT_LEADER_HOLY_ROMAN_EMPEROR_ALT', 'KIND_TRAIT');

INSERT INTO Leaders (LeaderType, Name, InheritFrom, Sex, SceneLayers)
Values ('LEADER_BARBAROSSA_ALT', 'LOC_LEADER_BARBAROSSA_ALT_NAME', 'LEADER_DEFAULT', 'Male', 4);

INSERT INTO LeaderQuotes (LeaderType, Quote)
VALUES ('LEADER_BARBAROSSA_ALT', 'LOC_LEADER_BARBAROSSA_ALT_QUOTE');

INSERT INTO LoadingInfo(LeaderType, ForegroundImage, BackgroundImage, PlayDawnOfManAudio, LeaderText)
VALUES ('LEADER_BARBAROSSA_ALT', 'LEADER_BARBAROSSA_NEUTRAL', 'LEADER_BARBAROSSA_BACKGROUND', 1,
        'LOC_LOADING_INFO_LEADER_BARBAROSSA_ALT');

INSERT INTO DiplomacyInfo (Type, BackgroundImage)
VALUES ('LEADER_BARBAROSSA_ALT', 'LEADER_BARBAROSSA_BACKGROUND');

INSERT INTO Traits (TraitType, Name, Description)
VALUES ('TRAIT_LEADER_HOLY_ROMAN_EMPEROR_ALT', 'LOC_TRAIT_LEADER_BARBAROSSA_ALT_HOLY_ROMAN_EMPEROR_ALT_NAME',
        'LOC_TRAIT_LEADER_BARBAROSSA_ALT_HOLY_ROMAN_EMPEROR_ALT_DESCRIPTION');

INSERT INTO LeaderTraits (LeaderType, TraitType)
VALUES ('LEADER_BARBAROSSA_ALT', 'TRAIT_LEADER_HOLY_ROMAN_EMPEROR_ALT');