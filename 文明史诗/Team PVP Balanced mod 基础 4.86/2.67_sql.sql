--神社、寺庙7折
UPDATE Buildings SET Cost=65,Maintenance=1  WHERE BuildingType='BUILDING_SHRINE';
UPDATE Buildings SET Cost=105,Maintenance=1  WHERE BuildingType='BUILDING_TEMPLE';
--单独减少
--UPDATE Buildings SET Cost=105,Maintenance=1  WHERE BuildingType='BUILDING_STAVE_CHURCH';
UPDATE Buildings SET Cost=105,Maintenance=1  WHERE BuildingType='BUILDING_PRASAT';


--宗教移民 不加边境
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='RELIGIOUS_SETTLEMENTS_CULTUREBORDER' AND Name='Amount';


--苏格兰
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='TRAIT_SCIENCE_HAPPY' AND Name='Amount';
UPDATE ModifierArguments SET Value='6' WHERE ModifierId='TRAIT_SCIENCE_ECSTATIC' AND Name='Amount';
UPDATE ModifierArguments SET Value='4' WHERE ModifierId='TRAIT_PRODUCTION_HAPPY' AND Name='Amount';
UPDATE ModifierArguments SET Value='8' WHERE ModifierId='TRAIT_PRODUCTION_ECSTATIC' AND Name='Amount';

--巴西
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_BRAZIL' AND TerrainType='FEATURE_JUNGLE';


--荷兰
UPDATE Improvements SET ValidAdjacentTerrainAmount=1 WHERE ImprovementType='IMPROVEMENT_POLDER';
UPDATE Improvements SET PrereqCivic='CIVIC_STATE_WORKFORCE' WHERE ImprovementType='IMPROVEMENT_POLDER';


--狩猎 GODDESS_OF_THE_HUNT_CAMP_PRODUCTION_MODIFIER GODDESS_OF_THE_HUNT_CAMP_FOOD_MODIFIER
UPDATE ModifierArguments SET Value='YIELD_GOLD' WHERE ModifierId='GODDESS_OF_THE_HUNT_CAMP_PRODUCTION_MODIFIER' AND Name='YieldType';

--法国
--城堡移至行政
UPDATE Improvements SET PrereqCivic='CIVIC_FEUDALISM' WHERE ImprovementType='IMPROVEMENT_CHATEAU';
--城堡加基础产出
--文
UPDATE Improvement_YieldChanges SET YieldChange='1' WHERE ImprovementType='IMPROVEMENT_CHATEAU' and YieldType="YIELD_CULTURE";
INSERT INTO Adjacency_YieldChanges (ID,Description,YieldType,YieldChange,TilesRequired,AdjacentRiver,PrereqCivic)
	VALUES ('Chateau_River_CULTURE_TEAMPVP','Placeholder','YIELD_CULTURE',"1","1",1,"CIVIC_HUMANISM");
INSERT INTO Improvement_Adjacencies (ImprovementType,YieldChangeId)
	VALUES ('IMPROVEMENT_CHATEAU','Chateau_River_CULTURE_TEAMPVP');
--INSERT INTO Improvement_BonusYieldChanges (Id,ImprovementType,YieldType,BonusYieldChange,PrereqCivic)
--	VALUES ('IMPROVEMENT_CHATEAU_CULTURE1','IMPROVEMENT_CHATEAU','YIELD_CULTURE',"1","CIVIC_HUMANISM");
--锤
INSERT INTO Improvement_YieldChanges (ImprovementType , YieldType,YieldChange)
 VALUES ("IMPROVEMENT_CHATEAU" , "YIELD_PRODUCTION" , "2");
--金
UPDATE Improvement_YieldChanges SET YieldChange='0' WHERE ImprovementType='IMPROVEMENT_CHATEAU' and YieldType="YIELD_GOLD";
UPDATE Adjacency_YieldChanges SET YieldChange=3 WHERE ID='Chateau_River';
--INSERT INTO Improvement_YieldChanges (ImprovementType , YieldType,YieldChange)
-- VALUES ("IMPROVEMENT_CHATEAU" , "YIELD_GOLD" , "1");





--私掠船
UPDATE Units SET PrereqCivic='CIVIC_EXPLORATION' WHERE UnitType='UNIT_PRIVATEER';
--海猎犬
UPDATE Units SET PrereqCivic='CIVIC_EXPLORATION' WHERE UnitType='UNIT_ENGLISH_SEADOG';