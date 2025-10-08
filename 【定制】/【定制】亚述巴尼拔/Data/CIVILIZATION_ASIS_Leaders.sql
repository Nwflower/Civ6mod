--	FILE: CIVILIZATION_ASIS_Leader.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/9/13 11:37:52
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT INTO Types (Type, Kind)
Values ('LEADER_NWBNB', 'KIND_LEADER'),
       ('TRAIT_LEADER_NWASIS2', 'KIND_TRAIT');

INSERT INTO Leaders (LeaderType, Name, InheritFrom, Sex, SceneLayers)
Values ('LEADER_NWBNB', 'LOC_LEADER_NWBNB_NAME', 'LEADER_DEFAULT', 'Male', 4);

INSERT INTO LeaderQuotes (LeaderType, Quote)
VALUES ('LEADER_NWBNB', 'LOC_LEADER_NWBNB_QUOTE');

INSERT INTO LoadingInfo(LeaderType, ForegroundImage, BackgroundImage, PlayDawnOfManAudio, LeaderText)
VALUES ('LEADER_NWBNB', 'LEADER_NWBNB_NEUTRAL', 'LEADER_NWBNB_BACKGROUND', 1,
        'LOC_LOADING_INFO_LEADER_NWBNB');

INSERT INTO DiplomacyInfo (Type, BackgroundImage)
VALUES ('LEADER_NWBNB', 'LEADER_NWBNB_BACKGROUND');

INSERT INTO Traits (TraitType, Name, Description)
VALUES ('TRAIT_LEADER_NWASIS2', 'LOC_TRAIT_LEADER_NWBNB_NWASIS2_NAME',
        'LOC_TRAIT_LEADER_NWBNB_NWASIS2_DESCRIPTION');

INSERT INTO LeaderTraits (LeaderType, TraitType)
VALUES ('LEADER_NWBNB', 'TRAIT_LEADER_NWASIS2');