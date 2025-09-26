--	FILE: CIVILIZATION_GUMOON_Leader.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/9/24 19:28:22
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT INTO Types (Type, Kind)
Values ('LEADER_LEADER_GUMOON', 'KIND_LEADER'),
       ('TRAIT_LEADER_ZHIZUN', 'KIND_TRAIT'),
       ('TRAIT_AGENDA_NW_250924', 'KIND_TRAIT');

INSERT INTO Leaders (LeaderType, Name, InheritFrom, Sex, SceneLayers)
Values ('LEADER_LEADER_GUMOON', 'LOC_LEADER_LEADER_GUMOON_NAME', 'LEADER_DEFAULT', 'Male', 4);

INSERT INTO LeaderQuotes (LeaderType, Quote)
VALUES ('LEADER_LEADER_GUMOON', 'LOC_LEADER_LEADER_GUMOON_QUOTE');

INSERT INTO LoadingInfo(LeaderType, ForegroundImage, BackgroundImage, PlayDawnOfManAudio, LeaderText)
VALUES ('LEADER_LEADER_GUMOON', 'LEADER_LEADER_GUMOON_NEUTRAL', 'LEADER_LEADER_GUMOON_BACKGROUND', 1,
        'LOC_LOADING_INFO_LEADER_LEADER_GUMOON');

INSERT INTO DiplomacyInfo (Type, BackgroundImage)
VALUES ('LEADER_LEADER_GUMOON', 'LEADER_LEADER_GUMOON_BACKGROUND');

INSERT INTO Traits (TraitType, Name, Description)
VALUES ('TRAIT_LEADER_ZHIZUN', 'LOC_TRAIT_LEADER_LEADER_GUMOON_ZHIZUN_NAME',
        'LOC_TRAIT_LEADER_LEADER_GUMOON_ZHIZUN_DESCRIPTION'),
       ('TRAIT_AGENDA_NW_250924', NULL, NULL);

INSERT INTO LeaderTraits (LeaderType, TraitType)
VALUES ('LEADER_LEADER_GUMOON', 'TRAIT_LEADER_ZHIZUN');

INSERT INTO HistoricalAgendas	
		(LeaderType,				AgendaType)
VALUES	('LEADER_LEADER_GUMOON',		'AGENDA_NW_250924');
INSERT INTO Agendas					
		(AgendaType,											Name,												Description)
VALUES	('AGENDA_NW_250924',							'LOC_AGENDA_NW_250924_NAME',				'LOC_AGENDA_NW_250924_DESCRIPTION');
INSERT INTO AgendaTraits				
		(AgendaType,											TraitType)
VALUES	('AGENDA_NW_250924',							'TRAIT_AGENDA_NW_250924');	