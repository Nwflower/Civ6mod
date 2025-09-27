--	FILE: NewLeader3_Leader.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/9/22 21:48:22
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT INTO Types (Type, Kind)
Values ('LEADER_NW_0004', 'KIND_LEADER'),
       ('TRAIT_LEADER_NW008', 'KIND_TRAIT'),
       ('TRAIT_UNIT_NW011', 'KIND_TRAIT');

INSERT INTO Leaders (LeaderType, Name, InheritFrom, Sex, SceneLayers)
Values ('LEADER_NW_0004', 'LOC_LEADER_NW_0004_NAME', 'LEADER_DEFAULT', 'Male', 4);

INSERT INTO LeaderQuotes (LeaderType, Quote)
VALUES ('LEADER_NW_0004', 'LOC_LEADER_NW_0004_QUOTE');

INSERT INTO LoadingInfo(LeaderType, ForegroundImage, BackgroundImage, PlayDawnOfManAudio, LeaderText)
VALUES ('LEADER_NW_0004', 'LEADER_NW_0004_NEUTRAL', 'LEADER_NW_0004_BACKGROUND', 1,
        'LOC_LOADING_INFO_LEADER_NW_0004');

INSERT INTO DiplomacyInfo (Type, BackgroundImage)
VALUES ('LEADER_NW_0004', 'LEADER_NW_0004_BACKGROUND');

INSERT INTO Traits (TraitType, Name, Description)
VALUES ('TRAIT_LEADER_NW008', 'LOC_TRAIT_LEADER_NW_0004_NW008_NAME',
        'LOC_TRAIT_LEADER_NW_0004_NW008_DESCRIPTION'),
       ('TRAIT_UNIT_NW011', NULL, NULL);

INSERT INTO LeaderTraits (LeaderType, TraitType)
VALUES ('LEADER_NW_0004', 'TRAIT_LEADER_NW008'),
       ('LEADER_NW_0004', 'TRAIT_UNIT_NW011');