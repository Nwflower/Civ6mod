--删除峡湾
DELETE FROM Features WHERE FeatureType='FEATURE_LYSEFJORDEN';
--下龙湾
UPDATE Feature_YieldChanges SET YieldChange='2' WHERE FeatureType='FEATURE_HA_LONG_BAY' and YieldType='YIELD_PRODUCTION';

--白崖 4文/2金
/*
UPDATE Feature_YieldChanges SET YieldChange='4' WHERE FeatureType='FEATURE_CLIFFS_DOVER' and YieldType='YIELD_CULTURE';
UPDATE Feature_YieldChanges SET YieldChange='2' WHERE FeatureType='FEATURE_CLIFFS_DOVER' and YieldType='YIELD_GOLD';
INSERT INTO Feature_YieldChanges (FeatureType , YieldType , YieldChange)
	VALUES ('FEATURE_CLIFFS_DOVER' , 'YIELD_PRODUCTION', 1);
INSERT INTO Feature_YieldChanges (FeatureType , YieldType , YieldChange)
	VALUES ('FEATURE_CLIFFS_DOVER' , 'YIELD_FOOD', 1);
	*/
--白沙漠 官方
--UPDATE Feature_YieldChanges SET YieldChange='2' WHERE FeatureType='FEATURE_WHITEDESERT'    AND YieldType='YIELD_CULTURE'   ;
--UPDATE Feature_YieldChanges SET YieldChange='2' WHERE FeatureType='FEATURE_WHITEDESERT'    AND YieldType='YIELD_SCIENCE'   ;
--死海 2文2鸟
UPDATE Feature_YieldChanges SET YieldChange='3' WHERE FeatureType='FEATURE_DEAD_SEA' and YieldType='YIELD_CULTURE';
UPDATE Feature_YieldChanges SET YieldChange='3' WHERE FeatureType='FEATURE_DEAD_SEA' and YieldType='YIELD_FAITH';
--艾雅法拉火山	
UPDATE Feature_AdjacentYields SET YieldChange='0' WHERE FeatureType='FEATURE_EYJAFJALLAJOKULL' and YieldType='YIELD_FOOD';
--群岛
UPDATE Feature_AdjacentYields SET YieldChange='1' WHERE FeatureType='FEATURE_GALAPAGOS' and YieldType='YIELD_SCIENCE';
--INSERT INTO Feature_AdjacentYields (FeatureType , YieldType , YieldChange)
--	VALUES ('FEATURE_GALAPAGOS' , 'YIELD_PRODUCTION', 1);
--湿地 2-2
UPDATE Feature_YieldChanges SET YieldChange='1' WHERE FeatureType='FEATURE_PANTANAL' and YieldType='YIELD_CULTURE';	
UPDATE Feature_YieldChanges SET YieldChange='4' WHERE FeatureType='FEATURE_PANTANAL' and YieldType='YIELD_FOOD';
INSERT INTO Feature_YieldChanges (FeatureType , YieldType , YieldChange)
	VALUES ('FEATURE_PANTANAL' , 'YIELD_PRODUCTION', 1);
--大堡礁 3-2
UPDATE Feature_YieldChanges SET YieldChange='3' WHERE FeatureType='FEATURE_BARRIER_REEF' and YieldType='YIELD_FOOD';
UPDATE Feature_YieldChanges SET YieldChange='2' WHERE FeatureType='FEATURE_BARRIER_REEF' and YieldType='YIELD_SCIENCE';
INSERT INTO Feature_YieldChanges (FeatureType , YieldType , YieldChange)
	VALUES ('FEATURE_BARRIER_REEF' , 'YIELD_PRODUCTION', 1);
--火山湖口 4-1
UPDATE Feature_YieldChanges SET YieldChange='3' WHERE FeatureType='FEATURE_CRATER_LAKE' and YieldType='YIELD_SCIENCE';
--INSERT INTO Feature_YieldChanges (FeatureType , YieldType , YieldChange)
--	VALUES ('FEATURE_CRATER_LAKE' , 'YIELD_FOOD', 3);
--约塞米蒂公园 1-1
--UPDATE Feature_AdjacentYields SET YieldChange='1' WHERE FeatureType='FEATURE_YOSEMITE' and YieldType='YIELD_GOLD';
UPDATE Feature_AdjacentYields SET YieldChange='0' WHERE FeatureType='FEATURE_YOSEMITE' and YieldType='YIELD_FOOD';

--罗莱
DELETE FROM Feature_AdjacentYields WHERE FeatureType='FEATURE_RORAIMA' and YieldType='YIELD_FAITH';
--UPDATE Feature_AdjacentYields SET YieldChange='1' WHERE FeatureType='FEATURE_RORAIMA' and YieldType='YIELD_FAITH';
--INSERT INTO Feature_AdjacentYields (FeatureType , YieldType , YieldChange)
--	VALUES ('FEATURE_RORAIMA' , 'YIELD_GOLD', 1);
--乌鲁鲁 4文2鸟
UPDATE Feature_AdjacentYields SET YieldChange='2' WHERE FeatureType='FEATURE_ULURU' and YieldType='YIELD_CULTURE';
--INSERT INTO Feature_AdjacentYields (FeatureType , YieldType , YieldChange)
--	VALUES ('FEATURE_ULURU' , 'YIELD_GOLD', 2);
--撒哈拉 官方
--UPDATE Feature_YieldChanges SET YieldChange='3' WHERE FeatureType='FEATURE_EYE_OF_THE_SAHARA' and YieldType='YIELD_PRODUCTION';
--INSERT INTO Feature_YieldChanges (FeatureType , YieldType , YieldChange)
--	VALUES ('FEATURE_EYE_OF_THE_SAHARA' , 'YIELD_FOOD', 2);
--UPDATE RequirementArguments SET Value='ERA_INDUSTRIAL' WHERE RequirementId='FEATURE_EYE_OF_THE_SAHARA' and Name='EraType';	
--玫瑰湖 2文2金1锤
UPDATE Feature_YieldChanges SET YieldChange='3' WHERE FeatureType='FEATURE_LAKE_RETBA' and YieldType='YIELD_PRODUCTION';
--INSERT INTO Feature_YieldChanges (FeatureType , YieldType , YieldChange)
--	VALUES ('FEATURE_LAKE_RETBA' , 'YIELD_FOOD', 2);
--乌布苏盆地 2粮1锤2鸟
UPDATE Feature_YieldChanges SET YieldChange='3' WHERE FeatureType='FEATURE_UBSUNUR_HOLLOW' and YieldType='YIELD_FOOD';
UPDATE Feature_YieldChanges SET YieldChange='1' WHERE FeatureType='FEATURE_UBSUNUR_HOLLOW' and YieldType='YIELD_PRODUCTION';
DELETE FROM Features WHERE FeatureType='FEATURE_UBSUNUR_HOLLOW';
--拱门 2鸟1金
--INSERT INTO Feature_AdjacentYields (FeatureType , YieldType , YieldChange)
--	VALUES ('FEATURE_DELICATE_ARCH' , 'YIELD_PRODUCTION', 1);
UPDATE Feature_AdjacentYields SET YieldChange='2' WHERE FeatureType='FEATURE_DELICATE_ARCH' and YieldType='YIELD_FAITH';
UPDATE Feature_AdjacentYields SET YieldChange='2' WHERE FeatureType='FEATURE_DELICATE_ARCH' and YieldType='YIELD_GOLD';
--珠峰
UPDATE Feature_AdjacentYields SET YieldChange='2' WHERE FeatureType='FEATURE_EVEREST' and YieldType='YIELD_FAITH';
--马特洪峰
--UPDATE Feature_AdjacentYields SET YieldChange='1' WHERE FeatureType='FEATURE_MATTERHORN' and YieldType='YIELD_CULTURE';
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='ALPINE_TRAINING_COMBAT_HILLS' AND Name='Amount';
--巧克力山
UPDATE Feature_YieldChanges SET YieldChange='3' WHERE FeatureType='FEATURE_CHOCOLATEHILLS' and YieldType='YIELD_FOOD';
--戈布斯坦 3文1锤
UPDATE Feature_YieldChanges SET YieldChange='3' WHERE FeatureType='FEATURE_GOBUSTAN' and YieldType='YIELD_PRODUCTION';
--INSERT INTO Feature_YieldChanges (FeatureType , YieldType , YieldChange)
--	VALUES ('FEATURE_GOBUSTAN' , 'YIELD_FOOD', 3);

--百慕大
UPDATE Feature_AdjacentYields SET YieldChange='2' WHERE FeatureType='FEATURE_BERMUDA_TRIANGLE' and YieldType='YIELD_SCIENCE';

--巨人堤 文化
UPDATE Feature_AdjacentYields SET YieldChange='0' WHERE FeatureType='FEATURE_GIANTS_CAUSEWAY' and YieldType='YIELD_CULTURE';

--乞力马扎罗山
UPDATE Feature_AdjacentYields SET YieldChange='1' WHERE FeatureType='FEATURE_KILIMANJARO' and YieldType='YIELD_FOOD';

--百内
--DELETE FROM Features WHERE FeatureType='FEATURE_TORRES_DEL_PAINE';
UPDATE Features SET DoubleAdjacentTerrainYield=0 WHERE FeatureType='FEATURE_TORRES_DEL_PAINE';
--+1锤
INSERT INTO Feature_AdjacentYields (FeatureType , YieldType , YieldChange)
	VALUES ('FEATURE_TORRES_DEL_PAINE' , 'YIELD_PRODUCTION', 1);

--火山奇观喷发几率
--艾雅法拉
UPDATE RandomEvent_Yields  SET Percentage="17" WHERE 
RandomEventType="RANDOM_EVENT_EYJAFJALLAJOKULL_CATASTROPHIC" and 
YieldType="YIELD_FOOD" and  FeatureType="FEATURE_VOLCANIC_SOIL";

UPDATE RandomEvent_Yields  SET Percentage="10" WHERE 
RandomEventType="RANDOM_EVENT_EYJAFJALLAJOKULL_CATASTROPHIC" and 
YieldType="YIELD_PRODUCTION" and  FeatureType="FEATURE_VOLCANIC_SOIL";

UPDATE RandomEvent_Yields  SET Percentage="33" WHERE 
RandomEventType="RANDOM_EVENT_EYJAFJALLAJOKULL_MEGACOLOSSAL" and 
YieldType="YIELD_FOOD" and  FeatureType="FEATURE_VOLCANIC_SOIL";

UPDATE RandomEvent_Yields  SET Percentage="17" WHERE 
RandomEventType="RANDOM_EVENT_EYJAFJALLAJOKULL_MEGACOLOSSAL" and 
YieldType="YIELD_PRODUCTION" and  FeatureType="FEATURE_VOLCANIC_SOIL";

UPDATE RandomEvent_Damages SET Percentage='20' WHERE RandomEventType='RANDOM_EVENT_EYJAFJALLAJOKULL_CATASTROPHIC'and DamageType="POPULATION_LOSS";
UPDATE RandomEvent_Damages SET Percentage='20' WHERE RandomEventType='RANDOM_EVENT_EYJAFJALLAJOKULL_CATASTROPHIC'and DamageType="POPULATION_LOSS";
--维苏威
UPDATE RandomEvent_Yields  SET Percentage="25" WHERE 
RandomEventType="RANDOM_EVENT_VESUVIUS_MEGACOLOSSAL" and 
YieldType="YIELD_FOOD" and  FeatureType="FEATURE_VOLCANIC_SOIL";

UPDATE RandomEvent_Yields  SET Percentage="15" WHERE 
RandomEventType="RANDOM_EVENT_VESUVIUS_MEGACOLOSSAL" and 
YieldType="YIELD_PRODUCTION" and  FeatureType="FEATURE_VOLCANIC_SOIL";

UPDATE RandomEvent_Yields  SET Percentage="15" WHERE 
RandomEventType="RANDOM_EVENT_VESUVIUS_MEGACOLOSSAL" and 
YieldType="YIELD_SCIENCE" and  FeatureType="FEATURE_VOLCANIC_SOIL";
--维苏威火山 不产出文化
UPDATE RandomEvent_Yields  SET Percentage="0" WHERE 
RandomEventType="RANDOM_EVENT_VESUVIUS_MEGACOLOSSAL" and 
YieldType="YIELD_CULTURE" and  FeatureType="FEATURE_VOLCANIC_SOIL";

UPDATE RandomEvent_Damages SET Percentage='25' WHERE RandomEventType='RANDOM_EVENT_EYJAFJALLAJOKULL_CATASTROPHIC'and DamageType="POPULATION_LOSS";
UPDATE RandomEvent_Damages SET Percentage='25' WHERE RandomEventType='RANDOM_EVENT_EYJAFJALLAJOKULL_CATASTROPHIC'and DamageType="POPULATION_LOSS";
--wifi山 乞力马扎罗山
UPDATE RandomEvent_Yields  SET Percentage="17" WHERE 
RandomEventType="RANDOM_EVENT_KILIMANJARO_GENTLE" and 
YieldType="YIELD_FOOD" and  FeatureType="FEATURE_VOLCANIC_SOIL";

UPDATE RandomEvent_Yields  SET Percentage="10" WHERE 
RandomEventType="RANDOM_EVENT_KILIMANJARO_GENTLE" and 
YieldType="YIELD_PRODUCTION" and  FeatureType="FEATURE_VOLCANIC_SOIL";

UPDATE RandomEvent_Yields  SET Percentage="33" WHERE 
RandomEventType="RANDOM_EVENT_KILIMANJARO_CATASTROPHIC" and 
YieldType="YIELD_FOOD" and  FeatureType="FEATURE_VOLCANIC_SOIL";

UPDATE RandomEvent_Yields  SET Percentage="17" WHERE 
RandomEventType="RANDOM_EVENT_KILIMANJARO_CATASTROPHIC" and 
YieldType="YIELD_PRODUCTION" and  FeatureType="FEATURE_VOLCANIC_SOIL";

--其他灾害
--灾害产出 *0.67
--火山喷发
UPDATE RandomEvent_Yields  SET Percentage="17" WHERE 
RandomEventType="RANDOM_EVENT_VOLCANO_GENTLE" and 
YieldType="YIELD_FOOD" and  FeatureType="FEATURE_VOLCANIC_SOIL";

UPDATE RandomEvent_Yields  SET Percentage="10" WHERE 
RandomEventType="RANDOM_EVENT_VOLCANO_GENTLE" and 
YieldType="YIELD_PRODUCTION" and  FeatureType="FEATURE_VOLCANIC_SOIL";

UPDATE RandomEvent_Yields  SET Percentage="33" WHERE 
RandomEventType="RANDOM_EVENT_VOLCANO_CATASTROPHIC" and 
YieldType="YIELD_FOOD" and  FeatureType="FEATURE_VOLCANIC_SOIL";

UPDATE RandomEvent_Yields  SET Percentage="17" WHERE 
RandomEventType="RANDOM_EVENT_VOLCANO_CATASTROPHIC" and 
YieldType="YIELD_PRODUCTION" and  FeatureType="FEATURE_VOLCANIC_SOIL";

UPDATE RandomEvent_Yields  SET Percentage="50" WHERE 
RandomEventType="RANDOM_EVENT_VOLCANO_MEGACOLOSSAL" and 
YieldType="YIELD_FOOD" and  FeatureType="FEATURE_VOLCANIC_SOIL";

UPDATE RandomEvent_Yields  SET Percentage="24" WHERE 
RandomEventType="RANDOM_EVENT_VOLCANO_MEGACOLOSSAL" and 
YieldType="YIELD_PRODUCTION" and  FeatureType="FEATURE_VOLCANIC_SOIL";
--暴风雪
UPDATE RandomEvent_Yields  SET Percentage="3" WHERE 
RandomEventType="RANDOM_EVENT_BLIZZARD_SIGNIFICANT" and 
YieldType="YIELD_FOOD";

UPDATE RandomEvent_Yields  SET Percentage="6" WHERE 
RandomEventType="RANDOM_EVENT_BLIZZARD_CRIPPLING" and 
YieldType="YIELD_FOOD";

UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_CRIPPLING'and DamageType="POPULATION_LOSS";
UPDATE RandomEvent_Damages SET Percentage='5' WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_CRIPPLING'and DamageType="DISTRICT_PILLAGED";

UPDATE RandomEvent_Damages SET Percentage='10' WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_SIGNIFICANT'and DamageType="BUILDING_PILLAGED";
UPDATE RandomEvent_Damages SET Percentage='10' WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_CRIPPLING'and DamageType="BUILDING_PILLAGED";

UPDATE RandomEvent_Damages SET Percentage='10' WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_SIGNIFICANT'and DamageType="IMPROVEMENT_PILLAGED";
UPDATE RandomEvent_Damages SET Percentage='20' WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_CRIPPLING'and DamageType="IMPROVEMENT_PILLAGED";


--沙城暴
UPDATE RandomEvent_Yields  SET Percentage="6" WHERE 
RandomEventType="RANDOM_EVENT_DUST_STORM_GRADIENT" and 
YieldType="YIELD_FOOD" ;

UPDATE RandomEvent_Yields  SET Percentage="6" WHERE 
RandomEventType="RANDOM_EVENT_DUST_STORM_GRADIENT" and 
YieldType="YIELD_PRODUCTION" ;

UPDATE RandomEvent_Yields  SET Percentage="3" WHERE 
RandomEventType="RANDOM_EVENT_DUST_STORM_HABOOB" and 
YieldType="YIELD_FOOD" ;

UPDATE RandomEvent_Yields  SET Percentage="3" WHERE 
RandomEventType="RANDOM_EVENT_DUST_STORM_HABOOB" and 
YieldType="YIELD_PRODUCTION" ;

UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_HABOOB'and DamageType="POPULATION_LOSS";
UPDATE RandomEvent_Damages SET Percentage='5' WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_HABOOB'and DamageType="DISTRICT_PILLAGED";
UPDATE RandomEvent_Damages SET Percentage='5' WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_GRADIENT'and DamageType="DISTRICT_PILLAGED";

UPDATE RandomEvent_Damages SET Percentage='10' WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_HABOOB'and DamageType="BUILDING_PILLAGED";
UPDATE RandomEvent_Damages SET Percentage='10' WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_GRADIENT'and DamageType="BUILDING_PILLAGED";

UPDATE RandomEvent_Damages SET Percentage='10' WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_HABOOB'and DamageType="IMPROVEMENT_PILLAGED";
UPDATE RandomEvent_Damages SET Percentage='20' WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_GRADIENT'and DamageType="IMPROVEMENT_PILLAGED";
--龙卷风
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_TORNADO_OUTBREAK'and DamageType="POPULATION_LOSS";
UPDATE RandomEvent_Damages SET Percentage='5' WHERE RandomEventType='RANDOM_EVENT_TORNADO_FAMILY'and DamageType="DISTRICT_PILLAGED";
UPDATE RandomEvent_Damages SET Percentage='5' WHERE RandomEventType='RANDOM_EVENT_TORNADO_OUTBREAK'and DamageType="DISTRICT_PILLAGED";

UPDATE RandomEvent_Damages SET Percentage='10' WHERE RandomEventType='RANDOM_EVENT_TORNADO_FAMILY'and DamageType="BUILDING_PILLAGED";
UPDATE RandomEvent_Damages SET Percentage='10' WHERE RandomEventType='RANDOM_EVENT_TORNADO_OUTBREAK'and DamageType="BUILDING_PILLAGED";

UPDATE RandomEvent_Damages SET Percentage='10' WHERE RandomEventType='RANDOM_EVENT_TORNADO_FAMILY'and DamageType="IMPROVEMENT_PILLAGED";
UPDATE RandomEvent_Damages SET Percentage='20' WHERE RandomEventType='RANDOM_EVENT_TORNADO_OUTBREAK'and DamageType="IMPROVEMENT_PILLAGED";
--飓风
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_5'and DamageType="POPULATION_LOSS";
UPDATE RandomEvent_Damages SET Percentage='5' WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_5'and DamageType="DISTRICT_PILLAGED";
UPDATE RandomEvent_Damages SET Percentage='5' WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_5'and DamageType="DISTRICT_PILLAGED";

UPDATE RandomEvent_Damages SET Percentage='10' WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_4'and DamageType="BUILDING_PILLAGED";
UPDATE RandomEvent_Damages SET Percentage='10' WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_5'and DamageType="BUILDING_PILLAGED";

UPDATE RandomEvent_Damages SET Percentage='10' WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_4'and DamageType="IMPROVEMENT_PILLAGED";
UPDATE RandomEvent_Damages SET Percentage='20' WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_5'and DamageType="IMPROVEMENT_PILLAGED";

--山火
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType="RANDOM_EVENT_JUNGLE_FIRE" and DamageType="SPREAD";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType="RANDOM_EVENT_FOREST_FIRE" and DamageType="SPREAD";

UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType="RANDOM_EVENT_JUNGLE_FIRE" and DamageType="POPULATION_LOSS";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType="RANDOM_EVENT_FOREST_FIRE" and DamageType="POPULATION_LOSS";

--洪水
UPDATE RandomEvent_Damages SET Percentage='75' WHERE RandomEventType='RANDOM_EVENT_FLOOD_MODERATE'and DamageType="IMPROVEMENT_PILLAGED";
UPDATE RandomEvent_Damages SET Percentage='50' WHERE RandomEventType='RANDOM_EVENT_FLOOD_MODERATE'and DamageType="BUILDING_PILLAGED";

UPDATE RandomEvent_Damages SET Percentage='75' WHERE RandomEventType='RANDOM_EVENT_FLOOD_MAJOR'and DamageType="BUILDING_PILLAGED";
UPDATE RandomEvent_Damages SET Percentage='10' WHERE RandomEventType='RANDOM_EVENT_FLOOD_MAJOR'and DamageType="DISTRICT_PILLAGED";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_FLOOD_MAJOR'and DamageType="POPULATION_LOSS";

UPDATE RandomEvent_Damages SET Percentage='15' WHERE RandomEventType='RANDOM_EVENT_FLOOD_1000_YEAR'and DamageType="DISTRICT_PILLAGED";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_FLOOD_1000_YEAR'and DamageType="POPULATION_LOSS";


--火山喷发
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_VOLCANO_CATASTROPHIC'and DamageType="POPULATION_LOSS";
UPDATE RandomEvent_Damages SET Percentage='80' WHERE RandomEventType='RANDOM_EVENT_VOLCANO_CATASTROPHIC'and DamageType="DISTRICT_PILLAGED";

UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_VOLCANO_MEGACOLOSSAL'and DamageType="POPULATION_LOSS";
UPDATE RandomEvent_Damages SET Percentage='90' WHERE RandomEventType='RANDOM_EVENT_VOLCANO_MEGACOLOSSAL'and DamageType="DISTRICT_PILLAGED";

/*UPDATE RandomEvent_Yields  SET Percentage=Percentage-10 WHERE 
RandomEventType="RANDOM_EVENT_FLOOD_MODERATE";

UPDATE RandomEvent_Yields  SET Percentage=10 WHERE 
RandomEventType="RANDOM_EVENT_FLOOD_MODERATE" and Percentage<10;

UPDATE RandomEvent_Yields  SET Percentage=Percentage-10 WHERE 
RandomEventType="RANDOM_EVENT_FLOOD_MAJOR";

UPDATE RandomEvent_Yields  SET Percentage=10 WHERE 
RandomEventType="RANDOM_EVENT_FLOOD_MAJOR" and Percentage<10;

UPDATE RandomEvent_Yields  SET Percentage=Percentage-10 WHERE 
RandomEventType="RANDOM_EVENT_FLOOD_1000_YEAR";

UPDATE RandomEvent_Yields  SET Percentage=10 WHERE 
RandomEventType="RANDOM_EVENT_FLOOD_1000_YEAR" and Percentage<10;*/