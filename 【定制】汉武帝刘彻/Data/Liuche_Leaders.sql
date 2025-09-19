--	FILE: Liuche_Leader.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/9/9 21:08:06
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT INTO Types (Type, Kind)
Values ('LEADER_NW_LIUCHE', 'KIND_LEADER'),
       ('TRAIT_LEADER_EN_LINK', 'KIND_TRAIT');

INSERT INTO Leaders (LeaderType, Name, InheritFrom, Sex, SceneLayers)
Values ('LEADER_NW_LIUCHE', 'LOC_LEADER_NW_LIUCHE_NAME', 'LEADER_DEFAULT', 'Male', 4);

INSERT INTO LeaderQuotes (LeaderType, Quote)
VALUES ('LEADER_NW_LIUCHE', 'LOC_LEADER_NW_LIUCHE_QUOTE');

INSERT INTO LoadingInfo(LeaderType, ForegroundImage, BackgroundImage, PlayDawnOfManAudio, LeaderText)
VALUES ('LEADER_NW_LIUCHE', 'LEADER_NW_LIUCHE_NEUTRAL', 'LEADER_NW_LIUCHE_BACKGROUND', 1,
        'LOC_LOADING_INFO_LEADER_NW_LIUCHE');

INSERT INTO DiplomacyInfo (Type, BackgroundImage)
VALUES ('LEADER_NW_LIUCHE', 'LEADER_NW_LIUCHE_BACKGROUND');

INSERT INTO Traits (TraitType, Name, Description)
VALUES ('TRAIT_LEADER_EN_LINK', 'LOC_TRAIT_LEADER_NW_LIUCHE_EN_LINK_NAME',
        'LOC_TRAIT_LEADER_NW_LIUCHE_EN_LINK_DESCRIPTION');

INSERT INTO LeaderTraits (LeaderType, TraitType)
VALUES ('LEADER_NW_LIUCHE', 'TRAIT_LEADER_EN_LINK');


INSERT INTO Types (Type, Kind)
Values ('LEADER_NW_LIUCHE_ALT', 'KIND_LEADER'),
       ('TRAIT_LEADER_MUST_KILL', 'KIND_TRAIT');

INSERT INTO Leaders (LeaderType, Name, InheritFrom, Sex, SceneLayers)
Values ('LEADER_NW_LIUCHE_ALT', 'LOC_LEADER_NW_LIUCHE_ALT_NAME', 'LEADER_DEFAULT', 'Male', 4);

INSERT INTO LeaderQuotes (LeaderType, Quote)
VALUES ('LEADER_NW_LIUCHE_ALT', 'LOC_LEADER_NW_LIUCHE_ALT_QUOTE');

INSERT INTO LoadingInfo(LeaderType, ForegroundImage, BackgroundImage, PlayDawnOfManAudio, LeaderText)
VALUES ('LEADER_NW_LIUCHE_ALT', 'LEADER_NW_LIUCHE_ALT_NEUTRAL', 'LEADER_NW_LIUCHE_ALT_BACKGROUND', 1,
        'LOC_LOADING_INFO_LEADER_NW_LIUCHE_ALT');

INSERT INTO DiplomacyInfo (Type, BackgroundImage)
VALUES ('LEADER_NW_LIUCHE_ALT', 'LEADER_NW_LIUCHE_ALT_BACKGROUND');

INSERT INTO Traits (TraitType, Name, Description)
VALUES ('TRAIT_LEADER_MUST_KILL', 'LOC_TRAIT_LEADER_NW_LIUCHE_MUST_KILL_NAME',
        'LOC_TRAIT_LEADER_NW_LIUCHE_MUST_KILL_DESCRIPTION');

INSERT INTO LeaderTraits (LeaderType, TraitType)
VALUES ('LEADER_NW_LIUCHE_ALT', 'TRAIT_LEADER_MUST_KILL');

INSERT OR IGNORE INTO DuplicateLeaders(LeaderType, OtherLeaderType) VALUES
('LEADER_NW_LIUCHE', 'LEADER_NW_LIUCHE_ALT');