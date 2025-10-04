
-- 单位跨河移动力惩罚减半
UPDATE GlobalParameters SET Value = '1' WHERE Name = 'MOVEMENT_RIVER_COST';

-- 玉米可以刷在冻土
INSERT INTO Resource_ValidTerrains(ResourceType, TerrainType) VALUES
('RESOURCE_MAIZE','TERRAIN_TUNDRA');