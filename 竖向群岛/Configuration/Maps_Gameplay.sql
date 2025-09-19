-------------------------------------
-- Types
-------------------------------------
INSERT OR REPLACE INTO Types
		(Type,					Kind)
VALUES
		('MAPSIZE_GIGANTIC',	'KIND_MAPSIZE'),
		('MAPSIZE_HUGE_16',		'KIND_MAPSIZE'),
		('MAPSIZE_HUGE_18',		'KIND_MAPSIZE');
-------------------------------------
-- Maps
-------------------------------------
INSERT OR REPLACE INTO Maps
		(MapSizeType,			Name,							Description,						DefaultPlayers,	NumNaturalWonders,	GridWidth,	GridHeight,	PlateValue,	Continents)
VALUES
		('MAPSIZE_GIGANTIC',	'LOC_MAPSIZE_FOURE_NAME',		'LOC_MAPSIZE_FOURE_DESCRIPTION',	4,				3,					42,			42,			3,			2),
		('MAPSIZE_HUGE_16',		'LOC_MAPSIZE_HUGE_16_NAME',		'LOC_MAPSIZE_HUGE_16_DESCRIPTION',	16,				9,					74,			74,			7,			7),
		('MAPSIZE_HUGE_18',		'LOC_MAPSIZE_HUGE_18_NAME',		'LOC_MAPSIZE_HUGE_18_DESCRIPTION',	18,				10,					76,			76,			7,			7);
-------------------------------------
-- Map_GreatPersonClasses
-------------------------------------
INSERT OR REPLACE INTO Map_GreatPersonClasses
		(MapSizeType,			GreatPersonClassType,			MaxWorldInstances)
VALUES
		('MAPSIZE_GIGANTIC',	'GREAT_PERSON_CLASS_PROPHET',	3),
		('MAPSIZE_HUGE_16',		'GREAT_PERSON_CLASS_PROPHET',	7),
		('MAPSIZE_HUGE_18',		'GREAT_PERSON_CLASS_PROPHET',	7);