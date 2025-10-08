--	FILE: CIVILIZATION_LUNA_Leader.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/9/2 16:15:28
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT INTO Types (Type, Kind)
Values ('LEADER_NW_LUNA', 'KIND_LEADER'),
       ('TRAIT_LEADER_LUNA_TRAIT', 'KIND_TRAIT'),
       ('TRAIT_AGENDA_CONSTRUCTION_AGENDA', 'KIND_TRAIT');

INSERT INTO Leaders (LeaderType, Name, InheritFrom, Sex, SceneLayers)
Values ('LEADER_NW_LUNA', 'LOC_LEADER_NW_LUNA_NAME', 'LEADER_DEFAULT', 'Male', 4);

INSERT INTO LeaderQuotes (LeaderType, Quote)
VALUES ('LEADER_NW_LUNA', 'LOC_LEADER_NW_LUNA_QUOTE');

INSERT INTO LoadingInfo(LeaderType, ForegroundImage, BackgroundImage, PlayDawnOfManAudio, LeaderText)
VALUES ('LEADER_NW_LUNA', 'LEADER_NW_LUNA_NEUTRAL', 'LEADER_VICTORIA_ALT_BACKGROUND', 1,
        'LOC_LOADING_INFO_LEADER_NW_LUNA');

INSERT INTO DiplomacyInfo (Type, BackgroundImage)
VALUES ('LEADER_NW_LUNA', 'LEADER_NW_LUNA_BACKGROUND');

INSERT INTO Traits (TraitType, Name, Description)
VALUES ('TRAIT_LEADER_LUNA_TRAIT', 'LOC_TRAIT_LEADER_NW_LUNA_LUNA_TRAIT_NAME',
        'LOC_TRAIT_LEADER_NW_LUNA_LUNA_TRAIT_DESCRIPTION'),
       ('TRAIT_AGENDA_CONSTRUCTION_AGENDA', NULL, NULL);

INSERT INTO LeaderTraits (LeaderType, TraitType)
VALUES ('LEADER_NW_LUNA', 'TRAIT_LEADER_LUNA_TRAIT');