--	FILE: PDL_Leader.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/10/5 12:10:26
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT INTO Types (Type, Kind)
Values ('LEADER_NW_PDL', 'KIND_LEADER'),
       ('TRAIT_LEADER_NW251004_PDL', 'KIND_TRAIT');

INSERT INTO Leaders (LeaderType, Name, InheritFrom, Sex, SceneLayers)
Values ('LEADER_NW_PDL', 'LOC_LEADER_NW_PDL_NAME', 'LEADER_DEFAULT', 'Male', 4);

INSERT INTO LeaderQuotes (LeaderType, Quote)
VALUES ('LEADER_NW_PDL', 'LOC_LEADER_NW_PDL_QUOTE');

INSERT INTO LoadingInfo(LeaderType, ForegroundImage, BackgroundImage, PlayDawnOfManAudio, LeaderText)
VALUES ('LEADER_NW_PDL', 'LEADER_PEDRO_NEUTRAL', 'LEADER_PEDRO_BACKGROUND', 1,
        'LOC_LOADING_INFO_LEADER_NW_PDL');

INSERT INTO DiplomacyInfo (Type, BackgroundImage)
VALUES ('LEADER_NW_PDL', 'LEADER_PEDRO_BACKGROUND');

INSERT INTO Traits (TraitType, Name, Description)
VALUES ('TRAIT_LEADER_NW251004_PDL', 'LOC_TRAIT_LEADER_NW_PDL_NW251004_NAME',
        'LOC_TRAIT_LEADER_NW_PDL_NW251004_DESCRIPTION');

INSERT INTO LeaderTraits (LeaderType, TraitType)
VALUES ('LEADER_NW_PDL', 'TRAIT_LEADER_NW251004_PDL');