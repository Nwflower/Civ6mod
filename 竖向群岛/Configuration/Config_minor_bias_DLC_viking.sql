--==============================================================================
--******			Bias Parameters			  	  ******
--==============================================================================
INSERT OR REPLACE INTO StartBiasResources (CivilizationType , ResourceType , Tier)
	VALUES
	('CIVILIZATION_AUCKLAND' , 'RESOURCE_SHEEP' , 5),
	('CIVILIZATION_AUCKLAND' , 'RESOURCE_FISH' , 3),
	('CIVILIZATION_AUCKLAND' , 'RESOURCE_CRABS' , 3);
INSERT OR REPLACE INTO StartBiasRivers (CivilizationType , Tier)
	VALUES
	('CIVILIZATION_PALENQUE' , 5);
INSERT OR REPLACE INTO StartBiasTerrains (CivilizationType , TerrainType , Tier)
	VALUES
	('CIVILIZATION_MUSCAT' , 'TERRAIN_COAST'  , 3),
	--('CIVILIZATION_MUSCAT' , 'TERRAIN_DESERT'  , 5),
	('CIVILIZATION_MUSCAT' , 'TERRAIN_GRASS'  , 5);
INSERT OR REPLACE INTO StartBiasFeatures (CivilizationType , FeatureType , Tier)
	VALUES
	('CIVILIZATION_PALENQUE' , 'FEATURE_JUNGLE' , 3);