--	FILE: NL_Leader.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/10/6 11:26:46
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT INTO Types (Type, Kind)
Values ('LEADER_MILKL', 'KIND_LEADER'),
       ('TRAIT_LEADER_NW251032', 'KIND_TRAIT'),
       ('TRAIT_AGENDA_PALACE', 'KIND_TRAIT');

INSERT INTO Leaders (LeaderType, Name, InheritFrom, Sex, SceneLayers)
Values ('LEADER_MILKL', 'LOC_LEADER_MILKL_NAME', 'LEADER_DEFAULT', 'Male', 4);

INSERT INTO LeaderQuotes (LeaderType, Quote)
VALUES ('LEADER_MILKL', 'LOC_LEADER_MILKL_QUOTE');

INSERT INTO LoadingInfo(LeaderType, ForegroundImage, BackgroundImage, PlayDawnOfManAudio, LeaderText)
VALUES ('LEADER_MILKL', 'LEADER_MILKL_NEUTRAL', 'LEADER_MILKL_BACKGROUND', 1,
        'LOC_LOADING_INFO_LEADER_MILKL');

INSERT INTO DiplomacyInfo (Type, BackgroundImage)
VALUES ('LEADER_MILKL', 'LEADER_MILKL_BACKGROUND');

INSERT INTO Traits (TraitType, Name, Description)
VALUES ('TRAIT_LEADER_NW251032', 'LOC_TRAIT_LEADER_MILKL_NW251032_NAME',
        'LOC_TRAIT_LEADER_MILKL_NW251032_DESCRIPTION'),
       ('TRAIT_AGENDA_PALACE', NULL, NULL);

INSERT INTO LeaderTraits (LeaderType, TraitType)
VALUES ('LEADER_MILKL', 'TRAIT_LEADER_NW251032');