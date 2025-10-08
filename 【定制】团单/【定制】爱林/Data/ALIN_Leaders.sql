--	FILE: ALIN_Leader.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/10/3 14:25:12
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT INTO Types (Type, Kind)
Values ('LEADER_NWALIN', 'KIND_LEADER'),
       ('TRAIT_LEADER_NW_L0011_LEADER_AILIN', 'KIND_TRAIT');

INSERT INTO Leaders (LeaderType, Name, InheritFrom, Sex, SceneLayers)
Values ('LEADER_NWALIN', 'LOC_LEADER_NWALIN_NAME', 'LEADER_DEFAULT', 'Male', 4);

INSERT INTO LeaderQuotes (LeaderType, Quote)
VALUES ('LEADER_NWALIN', 'LOC_LEADER_NWALIN_QUOTE');

INSERT INTO LoadingInfo(LeaderType, ForegroundImage, BackgroundImage, PlayDawnOfManAudio, LeaderText)
VALUES ('LEADER_NWALIN', 'LEADER_LADY_TRIEU_NEUTRAL', 'LEADER_LADY_TRIEU_BACKGROUND', 1,
        'LOC_LOADING_INFO_LEADER_NWALIN');

INSERT INTO DiplomacyInfo (Type, BackgroundImage)
VALUES ('LEADER_NWALIN', 'LEADER_LADY_TRIEU_BACKGROUND');

INSERT INTO Traits (TraitType, Name, Description)
VALUES ('TRAIT_LEADER_NW_L0011_LEADER_AILIN', 'LOC_TRAIT_LEADER_NWALIN_NAME',
        'LOC_TRAIT_LEADER_NWALIN_DESCRIPTION');

INSERT INTO LeaderTraits (LeaderType, TraitType)
VALUES ('LEADER_NWALIN', 'TRAIT_LEADER_NW_L0011_LEADER_AILIN');