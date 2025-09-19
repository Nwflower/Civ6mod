-------------------------------------
-- MapSizes
-------------------------------------
INSERT OR REPLACE INTO MapSizes
		(MapSizeType,			Name,							Description,						MinPlayers,	MaxPlayers,	DefaultPlayers,	MaxCityStates,	DefaultCityStates,	SortIndex)
VALUES
		('MAPSIZE_GIGANTIC',	'LOC_MAPSIZE_FOURE_NAME',		'LOC_MAPSIZE_FOURE_DESCRIPTION',	2,			6,			4,				20,				3,					15),
		('MAPSIZE_HUGE_16',		'LOC_MAPSIZE_HUGE_16_NAME',		'LOC_MAPSIZE_HUGE_16_DESCRIPTION',	2,			18,			16,				20,				8,					200),
		('MAPSIZE_HUGE_18',		'LOC_MAPSIZE_HUGE_18_NAME',		'LOC_MAPSIZE_HUGE_18_DESCRIPTION',	2,			20,			18,				20,				8,					201);