
-- 戈布斯坦国家公园：+1食物
INSERT INTO Feature_YieldChanges (FeatureType , YieldType , YieldChange)
VALUES ('FEATURE_GOBUSTAN' , 'YIELD_FOOD', 1);


INSERT INTO Feature_YieldChanges (FeatureType , YieldType , YieldChange)
VALUES ('FEATURE_LAKE_RETBA' , 'YIELD_FOOD', 2);

-- 张掖丹霞：允许生成于丘陵
INSERT INTO Feature_ValidTerrains (FeatureType, TerrainType) SELECT
'FEATURE_ZHANGYE_DANXIA',TerrainType
FROM Terrains WHERE Hills = 1;