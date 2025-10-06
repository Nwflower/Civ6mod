--	FILE: LWT_Leader.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/9/29 22:03:38
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT INTO Types (Type, Kind)
Values ('LEADER_LIWEITAN', 'KIND_LEADER'),
       ('TRAIT_LEADER_LWT', 'KIND_TRAIT');

INSERT INTO Leaders (LeaderType, Name, InheritFrom, Sex, SceneLayers)
Values ('LEADER_LIWEITAN', 'LOC_LEADER_LIWEITAN_NAME', 'LEADER_DEFAULT', 'Male', 4);

INSERT INTO LeaderQuotes (LeaderType, Quote)
VALUES ('LEADER_LIWEITAN', 'LOC_LEADER_LIWEITAN_QUOTE');

INSERT INTO LoadingInfo(LeaderType, ForegroundImage, BackgroundImage, PlayDawnOfManAudio, LeaderText)
VALUES ('LEADER_LIWEITAN', 'LOADING_LEADER_LIWEITA', 'LEADER_VICTORIA_ALT_BACKGROUND', 1,
        'LOC_LOADING_INFO_LEADER_LIWEITAN');

INSERT INTO DiplomacyInfo (Type, BackgroundImage)
VALUES ('LEADER_LIWEITAN', 'LEADER_LIWEITAN_BACKGROUND');

INSERT INTO Traits (TraitType, Name, Description)
VALUES ('TRAIT_LEADER_LWT', 'LOC_TRAIT_LEADER_LIWEITAN_LWT_NAME',
        'LOC_TRAIT_LEADER_LIWEITAN_LWT_DESCRIPTION');

INSERT INTO LeaderTraits (LeaderType, TraitType)
VALUES ('LEADER_LIWEITAN', 'TRAIT_LEADER_LWT');