--	FILE: CIVILIZATION_NW_HANJ_Leader.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/9/15 18:21:35
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT INTO Types (Type, Kind)
Values ('LEADER_NW_LIUXUN', 'KIND_LEADER'),
       ('TRAIT_LEADER_NW004', 'KIND_TRAIT');

INSERT INTO Leaders (LeaderType, Name, InheritFrom, Sex, SceneLayers)
Values ('LEADER_NW_LIUXUN', 'LOC_LEADER_NW_LIUXUN_NAME', 'LEADER_DEFAULT', 'Male', 4);

INSERT INTO LeaderQuotes (LeaderType, Quote)
VALUES ('LEADER_NW_LIUXUN', 'LOC_LEADER_NW_LIUXUN_QUOTE');

INSERT INTO LoadingInfo(LeaderType, ForegroundImage, BackgroundImage, PlayDawnOfManAudio, LeaderText)
VALUES ('LEADER_NW_LIUXUN', 'NEUTRAL_LEADER_NW_LIUXUN', 'LEADER_NW_LIUXUN_BACKGROUND', 1,
        'LOC_LOADING_INFO_LEADER_NW_LIUXUN');


INSERT INTO Traits (TraitType, Name, Description)
VALUES ('TRAIT_LEADER_NW004', 'LOC_TRAIT_LEADER_NW_LIUXUN_NW004_NAME',
        'LOC_TRAIT_LEADER_NW_LIUXUN_NW004_DESCRIPTION');

INSERT INTO LeaderTraits (LeaderType, TraitType)
VALUES ('LEADER_NW_LIUXUN', 'TRAIT_LEADER_NW004');

--

INSERT INTO Types (Type, Kind)
Values ('LEADER_NW_JET_LIUCHE', 'KIND_LEADER'),
       ('TRAIT_LEADER_NW005', 'KIND_TRAIT'),
       ('TRAIT_UNIT_NW_BIAOQI', 'KIND_TRAIT');

INSERT INTO Leaders (LeaderType, Name, InheritFrom, Sex, SceneLayers)
Values ('LEADER_NW_JET_LIUCHE', 'LOC_LEADER_NW_JET_LIUCHE_NAME', 'LEADER_DEFAULT', 'Male', 4);

INSERT INTO LeaderQuotes (LeaderType, Quote)
VALUES ('LEADER_NW_JET_LIUCHE', 'LOC_LEADER_NW_JET_LIUCHE_QUOTE');

INSERT INTO LoadingInfo(LeaderType, ForegroundImage, BackgroundImage, PlayDawnOfManAudio, LeaderText)
VALUES ('LEADER_NW_JET_LIUCHE', 'LEADER_NW_JET_LIUCHE_NEUTRAL', 'LEADER_NW_JET_LIUCHE_BACKGROUND', 1,
        'LOC_LOADING_INFO_LEADER_NW_JET_LIUCHE');


INSERT INTO Traits (TraitType, Name, Description)
VALUES ('TRAIT_LEADER_NW005', 'LOC_TRAIT_LEADER_NW_JET_LIUCHE_NW005_NAME',
        'LOC_TRAIT_LEADER_NW_JET_LIUCHE_NW005_DESCRIPTION'),
       ('TRAIT_UNIT_NW_BIAOQI', NULL, NULL);

INSERT INTO LeaderTraits (LeaderType, TraitType)
VALUES ('LEADER_NW_JET_LIUCHE', 'TRAIT_LEADER_NW005'),
       ('LEADER_NW_JET_LIUCHE', 'TRAIT_UNIT_NW_BIAOQI');