--	FILE: NewLeader1_Leader.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/9/2 15:46:23
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT INTO Types (Type, Kind)
Values ('LEADER_NW_SANQIAN', 'KIND_LEADER'),
       ('TRAIT_LEADER_TRAIT_SANQIANSHENGUO', 'KIND_TRAIT'),
       ('TRAIT_AGENDA_PALACE', 'KIND_TRAIT');

INSERT INTO Leaders (LeaderType, Name, InheritFrom, Sex, SceneLayers)
Values ('LEADER_NW_SANQIAN', 'LOC_LEADER_NW_SANQIAN_NAME', 'LEADER_DEFAULT', 'Male', 1);

INSERT INTO LeaderQuotes (LeaderType, Quote)
VALUES ('LEADER_NW_SANQIAN', 'LOC_LEADER_NW_SANQIAN_QUOTE');

INSERT INTO LoadingInfo(LeaderType, ForegroundImage, BackgroundImage, PlayDawnOfManAudio, LeaderText)
VALUES ('LEADER_NW_SANQIAN', 'LEADER_NW_SANQIAN_NEUTRAL', 'LEADER_NW_SANQIAN_BACKGROUND', 1,
        '');

INSERT INTO DiplomacyInfo (Type, BackgroundImage)
VALUES ('LEADER_NW_SANQIAN', 'LEADER_NW_SANQIAN_BACKGROUND');

INSERT INTO Traits (TraitType, Name, Description)
VALUES ('TRAIT_LEADER_TRAIT_SANQIANSHENGUO', 'LOC_TRAIT_LEADER_NW_SANQIAN_TRAIT_SANQIANSHENGUO_NAME',
        'LOC_TRAIT_LEADER_NW_SANQIAN_TRAIT_SANQIANSHENGUO_DESCRIPTION'),
       ('TRAIT_AGENDA_PALACE', NULL, NULL);

INSERT INTO LeaderTraits (LeaderType, TraitType)
VALUES ('LEADER_NW_SANQIAN', 'TRAIT_LEADER_TRAIT_SANQIANSHENGUO');