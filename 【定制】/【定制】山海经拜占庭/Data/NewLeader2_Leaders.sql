--	FILE: NewLeader2_Leader.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/10/3 11:23:08
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT INTO Types (Type, Kind)
Values ('LEADER_BASIL_ALT', 'KIND_LEADER'),
       ('TRAIT_LEADER_ZISHI_ALT', 'KIND_TRAIT'),
       ('TRAIT_UNIT_20251002', 'KIND_TRAIT');

INSERT INTO Leaders (LeaderType, Name, InheritFrom, Sex, SceneLayers)
Values ('LEADER_BASIL_ALT', 'LOC_LEADER_BASIL_ALT_NAME', 'LEADER_DEFAULT', 'Male', 4);

INSERT INTO LeaderQuotes (LeaderType, Quote)
VALUES ('LEADER_BASIL_ALT', 'LOC_LEADER_BASIL_ALT_QUOTE');

INSERT INTO LoadingInfo(LeaderType, ForegroundImage, BackgroundImage, PlayDawnOfManAudio, LeaderText)
VALUES ('LEADER_BASIL_ALT', 'LEADER_BASIL_NEUTRAL', 'LEADER_BASIL_BACKGROUND', 1,
        'LOC_LOADING_INFO_LEADER_BASIL_ALT');

INSERT INTO DiplomacyInfo (Type, BackgroundImage)
VALUES ('LEADER_BASIL_ALT', 'LEADER_BASIL_BACKGROUND');

INSERT INTO Traits (TraitType, Name, Description)
VALUES ('TRAIT_LEADER_ZISHI_ALT', 'LOC_TRAIT_LEADER_BASIL_ALT_ZISHI_ALT_NAME',
        'LOC_TRAIT_LEADER_BASIL_ALT_ZISHI_ALT_DESCRIPTION'),
       ('TRAIT_UNIT_20251002', NULL, NULL);

INSERT INTO LeaderTraits (LeaderType, TraitType)
VALUES ('LEADER_BASIL_ALT', 'TRAIT_LEADER_ZISHI_ALT'),
       ('LEADER_BASIL_ALT', 'TRAIT_UNIT_20251002');