--	FILE: Civilization_Douglas_Leader.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/9/14 10:32:02
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT INTO Types (Type, Kind)
Values ('LEADER_LEADER_DOUGLAS', 'KIND_LEADER'),
       ('TRAIT_LEADER_NW002', 'KIND_TRAIT');

INSERT INTO Leaders (LeaderType, Name, InheritFrom, Sex, SceneLayers)
Values ('LEADER_LEADER_DOUGLAS', 'LOC_LEADER_LEADER_DOUGLAS_NAME', 'LEADER_DEFAULT', 'Male', 4);

INSERT INTO LeaderQuotes (LeaderType, Quote)
VALUES ('LEADER_LEADER_DOUGLAS', 'LOC_LEADER_LEADER_DOUGLAS_QUOTE');

INSERT INTO LoadingInfo(LeaderType, ForegroundImage, BackgroundImage, PlayDawnOfManAudio, LeaderText)
VALUES ('LEADER_LEADER_DOUGLAS', 'LEADER_LEADER_DOUGLAS_NEUTRAL', 'LEADER_LEADER_DOUGLAS_BACKGROUND', 1,
        'LOC_LOADING_INFO_LEADER_LEADER_DOUGLAS');

INSERT INTO DiplomacyInfo (Type, BackgroundImage)
VALUES ('LEADER_LEADER_DOUGLAS', 'LEADER_LEADER_DOUGLAS_BACKGROUND');

INSERT INTO Traits (TraitType, Name, Description)
VALUES ('TRAIT_LEADER_NW002', 'LOC_TRAIT_LEADER_LEADER_DOUGLAS_NW002_NAME',
        'LOC_TRAIT_LEADER_LEADER_DOUGLAS_NW002_DESCRIPTION');

INSERT INTO LeaderTraits (LeaderType, TraitType)
VALUES ('LEADER_LEADER_DOUGLAS', 'TRAIT_LEADER_NW002');