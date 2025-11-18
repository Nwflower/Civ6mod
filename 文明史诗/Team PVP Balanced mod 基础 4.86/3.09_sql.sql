--斯基泰UI
--INSERT INTO Improvements (ImprovementType , SameAdjacentValid)
--	VALUES ('IMPROVEMENT_HACIENDA' , 'false');
UPDATE Improvements SET SameAdjacentValid=0 WHERE ImprovementType='IMPROVEMENT_KURGAN';
--梁 4级
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='CITY_PARK_GOVERNOR_CULTURE' AND Name='Amount';
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='CITY_PARK_WATER_AMENITY' AND Name='Amount';

UPDATE Improvement_YieldChanges SET YieldChange=3 WHERE ImprovementType='IMPROVEMENT_CITY_PARK' AND YieldType='YIELD_GOLD';
UPDATE Improvement_YieldChanges SET YieldChange=0 WHERE ImprovementType='IMPROVEMENT_CITY_PARK' AND YieldType='YIELD_CULTURE';
--INSERT INTO Improvement_YieldChanges (ImprovementType, YieldType, YieldChange) VALUES
--('IMPROVEMENT_CITY_PARK', 'YIELD_GOLD', '2');
--+1粮2金 
--总督就位+1文1锤。宜居度+1-》+2。解锁人文主义+1文（总督就位）。城市化+1文+1金（总督就位）
--人文主义
INSERT INTO Requirements (RequirementId, RequirementType)
	VALUES ('REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_RENWEN_CULTURE', 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
	VALUES ('REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_RENWEN_CULTURE', 'CivicType', 'CIVIC_HUMANISM');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	VALUES ('PLAYER_HAS_POLITICAL_PHILOSOPHY_RENWEN_CULTURE', 'REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_RENWEN_CULTURE');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
	VALUES ('PLAYER_HAS_POLITICAL_PHILOSOPHY_RENWEN_CULTURE', 'REQUIREMENTSET_TEST_ALL');
--城市化
INSERT INTO Requirements (RequirementId, RequirementType)
	VALUES ('REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_URBANIZATION_CULTURE', 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
	VALUES ('REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_URBANIZATION_CULTURE', 'CivicType', 'CIVIC_URBANIZATION');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	VALUES ('PLAYER_HAS_POLITICAL_PHILOSOPHY_URBANIZATION_CULTURE', 'REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_URBANIZATION_CULTURE');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
	VALUES ('PLAYER_HAS_POLITICAL_PHILOSOPHY_URBANIZATION_CULTURE', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO ImprovementModifiers (ImprovementType, ModifierId) VALUES
('IMPROVEMENT_CITY_PARK', 'CITY_PARK_GOVERNOR_PRODUCTIONx');
INSERT INTO Modifiers (ModifierId, ModifierType ,SubjectRequirementSetId ) VALUES
('CITY_PARK_GOVERNOR_PRODUCTIONx', 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',
	'CITY_HAS_GOVERNOR_PROMOTION_PARKS_RECREATION');
INSERT INTO ModifierArguments (ModifierId, Name ,Value) VALUES
('CITY_PARK_GOVERNOR_PRODUCTIONx', 'YieldType','YIELD_PRODUCTION');
INSERT INTO ModifierArguments (ModifierId, Name ,Value) VALUES
('CITY_PARK_GOVERNOR_PRODUCTIONx', 'Amount','1');

INSERT INTO ImprovementModifiers (ImprovementType, ModifierId) VALUES
('IMPROVEMENT_CITY_PARK', 'CITY_PARK_GOVERNOR_PRODUCTION2');
INSERT INTO Modifiers (ModifierId, ModifierType ,SubjectRequirementSetId ,OwnerRequirementSetId ) VALUES
('CITY_PARK_GOVERNOR_PRODUCTION2', 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',
	'CITY_HAS_GOVERNOR_PROMOTION_PARKS_RECREATION','PLAYER_HAS_POLITICAL_PHILOSOPHY_RENWEN_CULTURE');
INSERT INTO ModifierArguments (ModifierId, Name ,Value) VALUES
('CITY_PARK_GOVERNOR_PRODUCTION2', 'YieldType','YIELD_CULTURE');
INSERT INTO ModifierArguments (ModifierId, Name ,Value) VALUES
('CITY_PARK_GOVERNOR_PRODUCTION2', 'Amount','1');

INSERT INTO ImprovementModifiers (ImprovementType, ModifierId) VALUES
('IMPROVEMENT_CITY_PARK', 'CITY_PARK_GOVERNOR_PRODUCTION3');
INSERT INTO Modifiers (ModifierId, ModifierType ,SubjectRequirementSetId ,OwnerRequirementSetId ) VALUES
('CITY_PARK_GOVERNOR_PRODUCTION3', 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',
	'CITY_HAS_GOVERNOR_PROMOTION_PARKS_RECREATION','PLAYER_HAS_POLITICAL_PHILOSOPHY_URBANIZATION_CULTURE');
INSERT INTO ModifierArguments (ModifierId, Name ,Value) VALUES
('CITY_PARK_GOVERNOR_PRODUCTION3', 'YieldType','YIELD_CULTURE');
INSERT INTO ModifierArguments (ModifierId, Name ,Value) VALUES
('CITY_PARK_GOVERNOR_PRODUCTION3', 'Amount','1');

INSERT INTO ImprovementModifiers (ImprovementType, ModifierId) VALUES
('IMPROVEMENT_CITY_PARK', 'CITY_PARK_GOVERNOR_PRODUCTION4');
INSERT INTO Modifiers (ModifierId, ModifierType ,SubjectRequirementSetId ,OwnerRequirementSetId ) VALUES
('CITY_PARK_GOVERNOR_PRODUCTION4', 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',
	'CITY_HAS_GOVERNOR_PROMOTION_PARKS_RECREATION','PLAYER_HAS_POLITICAL_PHILOSOPHY_URBANIZATION_CULTURE');
INSERT INTO ModifierArguments (ModifierId, Name ,Value) VALUES
('CITY_PARK_GOVERNOR_PRODUCTION4', 'YieldType','YIELD_GOLD');
INSERT INTO ModifierArguments (ModifierId, Name ,Value) VALUES
('CITY_PARK_GOVERNOR_PRODUCTION4', 'Amount','1');

--雄伟壮丽，信仰黄金区域+2信仰。移除折扣
INSERT INTO Modifiers (ModifierId , ModifierType , OwnerRequirementSetId)
    VALUES ('COMMEMORATION_RELIGIOUS_DISTRICTFAITH2' , 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_PER_DISTRICT' , 'PLAYER_HAS_GOLDEN_AGE');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('COMMEMORATION_RELIGIOUS_DISTRICTFAITH2' , 'YieldType' , 'YIELD_FAITH');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('COMMEMORATION_RELIGIOUS_DISTRICTFAITH2' , 'Amount' , '2');
INSERT INTO CommemorationModifiers (CommemorationType, ModifierId)
	VALUES ('COMMEMORATION_INFRASTRUCTURE', 'COMMEMORATION_RELIGIOUS_DISTRICTFAITH2');	
/*
INSERT INTO Modifiers (ModifierId , ModifierType , OwnerRequirementSetId ,SubjectRequirementSetId)
    VALUES ('ALPINE_IGNORE_HILLS_MOVEMENT_PENALTY_XWZL' , 'MODIFIER_PLAYER_UNIT_ADJUST_IGNORE_TERRAIN_COST' , 'PLAYER_HAS_GOLDEN_AGE','UNIT_IS_BUILDER');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('ALPINE_IGNORE_HILLS_MOVEMENT_PENALTY_XWZL' , 'Ignore' , 'true');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('ALPINE_IGNORE_HILLS_MOVEMENT_PENALTY_XWZL' , 'Type' , 'HILLS');
INSERT INTO CommemorationModifiers (CommemorationType, ModifierId)
	VALUES ('COMMEMORATION_INFRASTRUCTURE', 'ALPINE_IGNORE_HILLS_MOVEMENT_PENALTY_XWZL');	

INSERT INTO Modifiers (ModifierId , ModifierType , OwnerRequirementSetId ,SubjectRequirementSetId)
    VALUES ('ALPINE_IGNORE_HILLS_MOVEMENT_PENALTY_XWZL2' , 'MODIFIER_PLAYER_UNIT_ADJUST_IGNORE_TERRAIN_COST' , 'PLAYER_HAS_GOLDEN_AGE','UNIT_IS_BUILDER');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('ALPINE_IGNORE_HILLS_MOVEMENT_PENALTY_XWZL2' , 'Ignore' , 'true');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('ALPINE_IGNORE_HILLS_MOVEMENT_PENALTY_XWZL2' , 'Type' , 'FOREST');
INSERT INTO CommemorationModifiers (CommemorationType, ModifierId)
	VALUES ('COMMEMORATION_INFRASTRUCTURE', 'ALPINE_IGNORE_HILLS_MOVEMENT_PENALTY_XWZL2');	
*/
--神谕
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='ORACLE_GREATGENERALPOINTS' and Name='Amount';	
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='ORACLE_GREATADMIRALPOINTS' and Name='Amount';	
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='ORACLE_GREATENGINEERPOINTS' and Name='Amount';	
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='ORACLE_GREATMERCHANTPOINTS' and Name='Amount';	
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='ORACLE_GREATPROPHETPOINTS' and Name='Amount';	
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='ORACLE_GREATSCIENTISTPOINTS' and Name='Amount';
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='ORACLE_GREATWRITERPOINTS' and Name='Amount';
--流星
UPDATE ModifierArguments SET Value='PROMOTION_CLASS_MELEE' WHERE ModifierId='GOODY_METEOR_FREE_UNIT' AND Name='UnitPromotionClassType';
-- 资源          地貌
--20*25   +      20*25 =1000分
--（15+5）*25   +      20*25 
--15*25   +      20*25 

--巴比伦
--ULK-》18%
UPDATE ModifierArguments SET Value='18' WHERE ModifierId='TRAIT_EUREKA_INCREASE' and Name='Amount';
--科技加成-》-18%
UPDATE ModifierArguments SET Value='-18' WHERE ModifierId='TRAIT_SCIENCE_DECREASE' and Name='Amount';
--水磨
--农场+1
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId)
	VALUES ('PLOT_IS_FRESH', 'REQUIRES_PLOT_HAS_FARM');
UPDATE RequirementSets SET RequirementSetType='REQUIREMENTSET_TEST_ALL' WHERE RequirementSetId='PLOT_IS_FRESH';
--种植园+1
INSERT INTO BuildingModifiers(BuildingType , ModifierId) VALUES 
('BUILDING_PALGUM', 'PALGUM_ADDFOOD2');
INSERT INTO Modifiers(ModifierId , ModifierType , SubjectRequirementSetId) VALUES 
('PALGUM_ADDFOOD2', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD','PLOT_IS_FRESH2');
INSERT INTO ModifierArguments(ModifierId , Name ,Value) VALUES 
('PALGUM_ADDFOOD2', 'Amount','1');
INSERT INTO ModifierArguments(ModifierId , Name ,Value) VALUES 
('PALGUM_ADDFOOD2', 'YieldType','YIELD_FOOD');
--条件
INSERT INTO RequirementSets(RequirementSetId , RequirementSetType) VALUES 
('PLOT_IS_FRESH2', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId) VALUES 
('PLOT_IS_FRESH2', 'REQUIRES_PLOT_IS_FRESH_WATER_BABYLON');
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId) VALUES
('PLOT_IS_FRESH2', 'REQUIRES_PLOT_HAS_PLANTATION');

--
--沃林 
UPDATE ModifierArguments SET Value='16' WHERE  ModifierId='WOLIN_GREAT_GENERAL_POINTS' and Name='Amount';
UPDATE ModifierArguments SET Value='16' WHERE  ModifierId='WOLIN_GREAT_ADMIRAL_POINTS' and Name='Amount';
--纳兰大 移除免费科技
DELETE FROM TraitModifiers Where TraitType="MINOR_CIV_NALANDA_TRAIT" and ModifierId="MINOR_CIV_NALANDA_FREE_TECHNOLOGY";
--阿瑜陀耶 移除城邦
DELETE FROM Types Where Type="CIVILIZATION_AYUTTHAYA" and Kind="KIND_CIVILIZATION";
--约翰内斯堡 仅对首都有效 拥有建筑宫殿 移除工业化+2锤
--
DELETE FROM Types Where Type="CIVILIZATION_JOHANNESBURG" and Kind="KIND_CIVILIZATION";
/*--条件
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
    VALUES ('CIVILIZATION_AYUTTHAYA_GONGDIAN', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
    VALUES ('CIVILIZATION_AYUTTHAYA_GONGDIAN', 'REQ_ZBQOHA83');
INSERT INTO Requirements (RequirementId, RequirementType)
    VALUES ('REQ_ZBQOHA83', 'REQUIREMENT_CITY_HAS_BUILDING');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
    VALUES ('REQ_ZBQOHA83', 'AmoBuildingTypeunt','BUILDING_PALACE');
--
UPDATE Modifiers Set SubjectRequirementSetId='CIVILIZATION_AYUTTHAYA_GONGDIAN' where ModifierId='MINOR_CIV_JOHANNESBURG_PRODUCTION_RESOURCES' 
and ModifierType='MODIFIER_PLAYER_CITIES_ADJUST_YIELD_BY_NUMBER_RESOURCES';
--UPDATE ModifierArguments SET Value='0' WHERE  ModifierId='MINOR_CIV_JOHANNESBURG_PRODUCTION_RESOURCES_LATE' and Name='Amount';
*/
--火山随机事件
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_EYJAFJALLAJOKULL_TRIGGERED'and DamageType="UNIT_KILLED_CIVILIAN";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_EYJAFJALLAJOKULL_TRIGGERED'and DamageType="IMPROVEMENT_DESTROYED";

--祠堂
UPDATE ModifierArguments SET Value='50' WHERE  ModifierId='GOV_SETTLER_COST_REDUCTION' and Name='Amount';

--世界议会 雇佣兵
-- -50-》-33%
UPDATE ModifierArguments SET Value='33' WHERE  ModifierId='WC_RES_UNIT_PRODUCTION_YIELD_BUFF' and Name='Amount';
-- +100-》+50%
UPDATE ModifierArguments SET Value='-50' WHERE  ModifierId='WC_RES_UNIT_PRODUCTION_YIELD_DEBUFF' and Name='Amount';


--姆班赞
UPDATE Districts SET PrereqCivic="CIVIC_FEUDALISM" WHERE DistrictType="DISTRICT_MBANZA";


--大庄园
UPDATE Adjacency_YieldChanges SET PrereqTech='TECH_SCIENTIFIC_THEORY' WHERE  ID='Hacienda_MechanizedPlantationAdjacency';
UPDATE Adjacency_YieldChanges SET ObsoleteTech='TECH_SCIENTIFIC_THEORY' WHERE  ID='Hacienda_PlantationAdjacency';
UPDATE Adjacency_YieldChanges SET PrereqCivic='CIVIC_IDEOLOGY' WHERE  ID='Hacienda_AdvancedHaciendaAdjacency';
UPDATE Adjacency_YieldChanges SET ObsoleteCivic='CIVIC_IDEOLOGY' WHERE  ID='Hacienda_HaciendaAdjacency';




--
--南马
INSERT INTO Requirements ( RequirementId, RequirementType, Inverse )
	VALUES
		( 'REQUIRES_DISTRICT_IS_NOT_CITY_CENTER_TPBT', 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES', 0 );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
	VALUES
		( 'REQUIRES_DISTRICT_IS_NOT_CITY_CENTER_TPBT', 'DistrictType', 'DISTRICT_CITY_CENTER' );
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
	VALUES ( 'SPECIAL_DISTRICT_ON_COAST_TPB', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
	VALUES
		( 'SPECIAL_DISTRICT_ON_COAST_TPB', 'REQUIRES_PLOT_IS_ADJACENT_TO_COAST' ),
		( 'SPECIAL_DISTRICT_ON_COAST_TPB', 'REQUIRES_DISTRICT_IS_NOT_CITY_CENTER_TPBT' );
UPDATE Modifiers SET SubjectRequirementSetId='SPECIAL_DISTRICT_ON_COAST_TPB' WHERE ModifierId='MINOR_CIV_NAN_MADOL_DISTRICTS_CULTURE_BONUS';

UPDATE ModifierArguments SET Value='1' WHERE ModifierId='MINOR_CIV_NAN_MADOL_DISTRICTS_CULTURE_BONUS' and Name='Amount';
--博洛尼亚
--判断
/*
INSERT INTO Requirements (RequirementId, RequirementType)
    VALUES ('REQ_ZBQOHA834', 'REQUIREMENT_CITY_HAS_BUILDING');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
    VALUES ('REQ_ZBQOHA834', 'AmoBuildingTypeunt','BUILDING_PALACE');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
    VALUES ('CIVILIZATION_BOLOGNA_GONGDIAN', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
    VALUES ('CIVILIZATION_BOLOGNA_GONGDIAN', 'REQ_ZBQOHA834');
 INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
    VALUES ('CIVILIZATION_BOLOGNA_GONGDIAN', 'REQUIRES_PLAYER_IS_SUZERAIN_BONUS_ENABLED');


UPDATE Modifiers SET SubjectRequirementSetId='CIVILIZATION_BOLOGNA_GONGDIAN' WHERE ModifierId='MINOR_CIV_BOLOGNA_UNIQUE_INFLUENCE_GREAT_GENERAL_POINTS_BONUS';
UPDATE Modifiers SET SubjectRequirementSetId='CIVILIZATION_BOLOGNA_GONGDIAN' WHERE ModifierId='MINOR_CIV_BOLOGNA_UNIQUE_INFLUENCE_GREAT_ADMIRAL_POINTS_BONUS';
UPDATE Modifiers SET SubjectRequirementSetId='CIVILIZATION_BOLOGNA_GONGDIAN' WHERE ModifierId='MINOR_CIV_BOLOGNA_UNIQUE_INFLUENCE_GREAT_ENGINEER_POINTS_BONUS';
UPDATE Modifiers SET SubjectRequirementSetId='CIVILIZATION_BOLOGNA_GONGDIAN' WHERE ModifierId='MINOR_CIV_BOLOGNA_UNIQUE_INFLUENCE_GREAT_MERCHANT_POINTS_BONUS';
UPDATE Modifiers SET SubjectRequirementSetId='CIVILIZATION_BOLOGNA_GONGDIAN' WHERE ModifierId='MINOR_CIV_BOLOGNA_UNIQUE_INFLUENCE_GREAT_PROPHET_POINTS_BONUS';
UPDATE Modifiers SET SubjectRequirementSetId='CIVILIZATION_BOLOGNA_GONGDIAN' WHERE ModifierId='MINOR_CIV_BOLOGNA_UNIQUE_INFLUENCE_GREAT_SCIENTIST_POINTS_BONUS';
UPDATE Modifiers SET SubjectRequirementSetId='CIVILIZATION_BOLOGNA_GONGDIAN' WHERE ModifierId='MINOR_CIV_BOLOGNA_UNIQUE_INFLUENCE_GREAT_WRITER_POINTS_BONUS';
UPDATE Modifiers SET SubjectRequirementSetId='CIVILIZATION_BOLOGNA_GONGDIAN' WHERE ModifierId='MINOR_CIV_BOLOGNA_UNIQUE_INFLUENCE_GREAT_ARTIST_POINTS_BONUS';
UPDATE Modifiers SET SubjectRequirementSetId='CIVILIZATION_BOLOGNA_GONGDIAN' WHERE ModifierId='MINOR_CIV_BOLOGNA_UNIQUE_INFLUENCE_GREAT_MUSICIAN_POINTS_BONUS';
*/
--

--普雷斯拉夫
UPDATE ModifierArguments SET Value='4' WHERE ModifierId='MINOR_CIV_PRESLAV_BARRACKS_STABLE_IDENTITY_BONUS' and Name='Amount';
UPDATE ModifierArguments SET Value='4' WHERE ModifierId='MINOR_CIV_PRESLAV_ARMORY_IDENTITY_BONUS' and Name='Amount';
UPDATE ModifierArguments SET Value='4' WHERE ModifierId='MINOR_CIV_PRESLAV_MILITARY_ACADEMY_IDENTITY_BONUS' and Name='Amount';
--


--狮身人面象
UPDATE Improvement_YieldChanges SET YieldChange="0" WHERE ImprovementType="IMPROVEMENT_SPHINX" and YieldType="YIELD_CULTURE";
UPDATE ModifierArguments SET Value='YIELD_PRODUCTION' WHERE  ModifierId='SPHINX_FLOODPLAINS_CULTURE' and Name='YieldType';
UPDATE ModifierArguments SET Value='2' WHERE  ModifierId='SPHINX_FLOODPLAINS_CULTURE' and Name='Amount';

INSERT INTO Improvement_BonusYieldChanges (Id , ImprovementType , YieldType , BonusYieldChange , PrereqCivic)
	VALUES ('IMPROVEMENT_SPHINX_1' , 'IMPROVEMENT_SPHINX' , 'YIELD_CULTURE' , '1' , 'CIVIC_FEUDALISM');


--基础+1科技
INSERT INTO Requirements (RequirementId , RequirementType )
	VALUES ('REQUIRES_PLOT_ADJACENT_TO_DISTRICT_OBSERVATORY' , 'REQUIREMENT_PLOT_ADJACENT_DISTRICT_TYPE_MATCHES');
INSERT INTO RequirementArguments(RequirementId, Name, Value)
	VALUES ('REQUIRES_PLOT_ADJACENT_TO_DISTRICT_OBSERVATORY' , 'DistrictType' ,'DISTRICT_OBSERVATORY');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType )
	VALUES ('PLOT_ADJACENT_TO_SEOWON_PLANTATION_REQUIREMENTS_123' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId )
	VALUES ('PLOT_ADJACENT_TO_SEOWON_PLANTATION_REQUIREMENTS_123' , 'REQUIRES_PLOT_HAS_PLANTATION');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId )
	VALUES ('PLOT_ADJACENT_TO_SEOWON_PLANTATION_REQUIREMENTS_123' , 'REQUIRES_PLOT_ADJACENT_TO_DISTRICT_OBSERVATORY');


INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId )
	VALUES ('TRAIT_MINES_SCIENCE_SEOWON_DISTRICT_OBSERVATORY' , 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD','PLOT_ADJACENT_TO_SEOWON_PLANTATION_REQUIREMENTS_123' );
INSERT INTO ModifierArguments (ModifierId , Name ,Value)
	VALUES ('TRAIT_MINES_SCIENCE_SEOWON_DISTRICT_OBSERVATORY' , 'YieldType','YIELD_SCIENCE');
INSERT INTO ModifierArguments (ModifierId , Name ,Value)
	VALUES ('TRAIT_MINES_SCIENCE_SEOWON_DISTRICT_OBSERVATORY' , 'Amount','1');


INSERT INTO TraitModifiers (TraitType , ModifierId )
	VALUES ('TRAIT_CIVILIZATION_MAYAB' , 'TRAIT_MINES_SCIENCE_SEOWON_DISTRICT_OBSERVATORY');

--
--普世教会
UPDATE ModifierArguments SET Value='6' WHERE ModifierId='WORLD_CHURCH_CULTURE_FOLLOWER_MODIFIER' AND Name='PerXItems';
--什一税
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='TITHE_GOLD_CITY_MODIFIER' AND Name='Amount';

--大工达芬奇
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='GREATPERSON_WORKSHOP_CULTURE' and Name='Amount';

--封建
UPDATE Boosts SET NumItems="5" Where CivicType='CIVIC_FEUDALISM';

--雄伟
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='COMMEMORATION_INFRASTRUCTURE_GA_MOVEMENT' and Name='Amount';

--魅力型领袖 城邦
INSERT INTO PolicyModifiers (PolicyType , ModifierId )
	VALUES ('POLICY_CHARISMATIC_LEADER' , 'GUNBOATDIPLOMACY_OPENBORDERS');



--卡
UPDATE RequirementArguments SET Value='13' WHERE RequirementId='REQUIRES_CITY_HAS_HIGH_POPULATION' and Name='Amount'; 
UPDATE RequirementArguments SET Value='3' WHERE RequirementId='REQUIRES_CAMPUS_HAS_HIGH_ADJACENCY' and Name='Amount';
UPDATE RequirementArguments SET Value='3' WHERE RequirementId='REQUIRES_HOLY_SITE_HAS_HIGH_ADJACENCY' and Name='Amount';
UPDATE RequirementArguments SET Value='3' WHERE RequirementId='THEATER_SQUARE_HAS_HIGH_ADJACENCY' and Name='Amount';

--摩艾 石像
DELETE FROM Adjacency_YieldChanges WHERE ID="Moai_FirstBonusAdjacency";
DELETE FROM Adjacency_YieldChanges WHERE ID="Moai_SecondBonusAdjacency";
UPDATE Improvements SET SameAdjacentValid=0 WHERE ImprovementType='IMPROVEMENT_MOAI';
 
--棉花
INSERT INTO Resource_YieldChanges (ResourceType , YieldType ,YieldChange )
	VALUES ('RESOURCE_COTTON' , 'YIELD_FOOD' , '1');
DELETE FROM Resource_ValidTerrains WHERE  ResourceType="RESOURCE_COTTON" and TerrainType="TERRAIN_GRASS";
DELETE FROM Resource_ValidFeatures WHERE  ResourceType="RESOURCE_COTTON" and FeatureType="FEATURE_FLOODPLAINS";
DELETE FROM Resource_ValidFeatures WHERE  ResourceType="RESOURCE_COTTON" and FeatureType="FEATURE_FLOODPLAINS_GRASSLAND";
DELETE FROM Resource_ValidFeatures WHERE  ResourceType="RESOURCE_COTTON" and FeatureType="FEATURE_FLOODPLAINS_PLAINS";

--巴特依
UPDATE Adjacency_YieldChanges SET ObsoleteCivic = null WHERE ID='Batey_EntertainmentComplexAdjacency';
UPDATE Adjacency_YieldChanges SET ObsoleteCivic = null WHERE ID='Batey_BonusResourceAdjacency';
DELETE FROM Adjacency_YieldChanges WHERE  ID='Batey_LateEntertainmentComplexAdjacency';
DELETE FROM Adjacency_YieldChanges WHERE  ID='Batey_LateBonusResourceAdjacency';
INSERT INTO Improvement_BonusYieldChanges (Id , ImprovementType , YieldType , BonusYieldChange , PrereqCivic)
	VALUES ('IMPROVEMENT_BATEY_1' , 'IMPROVEMENT_BATEY' , 'YIELD_CULTURE' , '1' , 'CIVIC_EXPLORATION');

--欣盖提
--国籍贸易路线+2信仰
INSERT INTO Modifiers (ModifierId , ModifierType)
 VALUES ("MINOR_CIV_CHINGUETTI_FAITH_FOLLOWERS_GOLD" , "MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL"); 
INSERT INTO ModifierArguments (ModifierId , Name ,Value)
 VALUES ("MINOR_CIV_CHINGUETTI_FAITH_FOLLOWERS_GOLD" , "YieldType" ,"YIELD_FAITH");
INSERT INTO ModifierArguments (ModifierId , Name ,Value)
 VALUES ("MINOR_CIV_CHINGUETTI_FAITH_FOLLOWERS_GOLD" , "Amount" ,"2");
INSERT INTO ModifierArguments (ModifierId , Name ,Value)
 VALUES ("MINOR_CIV_CHINGUETTI_FAITH_FOLLOWERS_GOLD" , "Intercontinental" ,"false");

UPDATE ModifierArguments SET Value='MINOR_CIV_CHINGUETTI_FAITH_FOLLOWERS_GOLD' WHERE ModifierId='MINOR_CIV_CHINGUETTI_UNIQUE_INFLUENCE_BONUS' and Name='ModifierId';

--奥克兰
/*
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
    VALUES ('CIVILIZATION_AYUTTHAYA_GONGDIAN22', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
    VALUES ('CIVILIZATION_AYUTTHAYA_GONGDIAN22', 'REQ_ZBQOHA83');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
    VALUES ('CIVILIZATION_AYUTTHAYA_GONGDIAN22', 'REQUIRES_PLOT_HAS_SHALLOW_WATER');

UPDATE Modifiers SET ModifierType='MODIFIER_ALL_CITIES_ATTACH_MODIFIER' WHERE ModifierId='MINOR_CIV_AUCKLAND_UNIQUE_INFLUENCE_BONUS_BASE' and Name='ModifierId';
UPDATE Modifiers SET ModifierType='MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD' and SubjectRequirementSetId='CIVILIZATION_AYUTTHAYA_GONGDIAN22' WHERE ModifierId='MINOR_CIV_AUCKLAND_SHALLOW_WATER_PRODUCTION_BONUS_BASE' and Name='ModifierId';
*/
--
--职业道德3级
INSERT INTO Modifiers 
	(ModifierId                              , ModifierType                          , SubjectRequirementSetId)
	VALUES 
	('WORK_ETHIC_TIER3_PRODUCTION'          , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER' , 'CITY_FOLLOWS_RELIGION_REQUIREMENTS'),
	('WORK_ETHIC_TIER3_PRODUCTION_MODIFIER' , 'MODIFIER_SINGLE_CITY_ADJUST_YIELD_CHANGE'      , 'BUILDING_IS_TIER3_HOLY_SITE'     );
INSERT INTO ModifierArguments 
	(ModifierId                              , Name           , Value)
	VALUES 
	('WORK_ETHIC_TIER3_PRODUCTION'          , 'ModifierId'   , 'WORK_ETHIC_TIER3_PRODUCTION_MODIFIER'),
	('WORK_ETHIC_TIER3_PRODUCTION_MODIFIER' , 'YieldType'    , 'YIELD_PRODUCTION'                     ),
	('WORK_ETHIC_TIER3_PRODUCTION_MODIFIER' , 'Amount'       , '2'                                    );
INSERT INTO BeliefModifiers 
	(BeliefType          , ModifierId)
	VALUES 
	('BELIEF_WORK_ETHIC' , 'WORK_ETHIC_TIER3_PRODUCTION');

--合唱圣歌3级
INSERT INTO Modifiers 
	(ModifierId                              , ModifierType                          , SubjectRequirementSetId)
	VALUES 
	('CHORAL_MUSIC_TIER3_CULTURE'          , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER' , 'CITY_FOLLOWS_RELIGION_REQUIREMENTS'),
	('CHORAL_MUSIC_TIER3_CULTURE_MODIFIER' , 'MODIFIER_SINGLE_CITY_ADJUST_YIELD_CHANGE'      , 'BUILDING_IS_TIER3_HOLY_SITE'     );
INSERT INTO ModifierArguments 
	(ModifierId                              , Name           , Value)
	VALUES 
	('CHORAL_MUSIC_TIER3_CULTURE'          , 'ModifierId'   , 'CHORAL_MUSIC_TIER3_CULTURE_MODIFIER'),
	('CHORAL_MUSIC_TIER3_CULTURE_MODIFIER' , 'YieldType'    , 'YIELD_CULTURE'                     ),
	('CHORAL_MUSIC_TIER3_CULTURE_MODIFIER' , 'Amount'       , '2'                                    );
INSERT INTO BeliefModifiers 
	(BeliefType          , ModifierId)
	VALUES 
	('BELIEF_CHORAL_MUSIC' , 'CHORAL_MUSIC_TIER3_CULTURE');
--哺育世界3级
INSERT INTO Modifiers 
	(ModifierId                              , ModifierType                          , SubjectRequirementSetId)
	VALUES 
	('FEED_THE_WORLD_TIER3_FOOD'          , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER' , 'CITY_FOLLOWS_RELIGION_REQUIREMENTS'),
	('FEED_THE_WORLD_TIER3_FOOD_MODIFIER' , 'MODIFIER_SINGLE_CITY_ADJUST_YIELD_CHANGE'      , 'BUILDING_IS_TIER3_HOLY_SITE'     );
INSERT INTO ModifierArguments 
	(ModifierId                              , Name           , Value)
	VALUES 
	('FEED_THE_WORLD_TIER3_FOOD'          , 'ModifierId'   , 'FEED_THE_WORLD_TIER3_FOOD_MODIFIER'),
	('FEED_THE_WORLD_TIER3_FOOD_MODIFIER' , 'YieldType'    , 'YIELD_FOOD'                     ),
	('FEED_THE_WORLD_TIER3_FOOD_MODIFIER' , 'Amount'       , '2'                                    );
INSERT INTO BeliefModifiers 
	(BeliefType          , ModifierId)
	VALUES 
	('BELIEF_FEED_THE_WORLD' , 'FEED_THE_WORLD_TIER3_FOOD');


/*--布道者的远行
<Replace Tag="LOC_MOMENT_CATEGORY_RELIGIOUS_BONUS_GOLDEN_AGE" Language="zh_Hans_CN">
      <Text>“布道者的远行”黄金时代：[NEWLINE]所有传教士、使徒和审判官+2 [ICON_Movement] 移动力。此外，新生产的这些单位则+2使用次数。首都获得4个传教士。开拓者+1 [ICON_Movement] 移动力。每回合产生的 [ICON_GreatProphet] 大预言家点数+4。</Text>
    </Replace>
    
INSERT INTO Modifiers 
	(ModifierId                              , ModifierType                          , SubjectRequirementSetId,OwnerRequirementSetId,RunOnce,Permanent)
	VALUES 
	('FERTILITY_RITES_UNIT_MISSIONARY_MODIFIER' , 'MODIFIER_PLAYER_GRANT_UNIT_IN_CAPITAL'      , 'PLAYER_HAS_AT_LEAST_ONE_CITY_REQUIREMENTS','PLAYER_HAS_GOLDEN_AGE',1,1);
INSERT INTO ModifierArguments 
	(ModifierId                              , Name           , Value)
	VALUES 
	('FERTILITY_RITES_UNIT_MISSIONARY_MODIFIER'          , 'UnitType'   , 'UNIT_MISSIONARY'),
	('FERTILITY_RITES_UNIT_MISSIONARY_MODIFIER' , 'Amount'    , '4'                     ),
	('FERTILITY_RITES_UNIT_MISSIONARY_MODIFIER' , 'AllowUniqueOverride'       , 'false'                                    );
INSERT INTO CommemorationModifiers (CommemorationType, ModifierId)
	VALUES ('COMMEMORATION_RELIGIOUS', 'GANDHI_FAST_SETTLERS');
INSERT INTO CommemorationModifiers (CommemorationType, ModifierId)
	VALUES ('COMMEMORATION_RELIGIOUS', 'FERTILITY_RITES_UNIT_MISSIONARY_MODIFIER');*/

--梯井
--需要王权文化
INSERT INTO Requirements (RequirementId, RequirementType)
	VALUES ('REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_ZY_wq', 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
	VALUES ('REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_ZY_wq', 'CivicType', 'CIVIC_DIVINE_RIGHT');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	VALUES ('PLAYER_HAS_POLITICAL_PHILOSOPHY_ZY_wq', 'REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_ZY_wq');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
	VALUES ('PLAYER_HAS_POLITICAL_PHILOSOPHY_ZY_wq', 'REQUIREMENTSET_TEST_ALL');

--需要归正会文化
INSERT INTO Requirements (RequirementId, RequirementType)
	VALUES ('REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_ZY_gzh', 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
	VALUES ('REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_ZY_gzh', 'CivicType', 'CIVIC_REFORMED_CHURCH');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	VALUES ('PLAYER_HAS_POLITICAL_PHILOSOPHY_ZY_gzh', 'REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_ZY_gzh');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
	VALUES ('PLAYER_HAS_POLITICAL_PHILOSOPHY_ZY_gzh', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO Modifiers 
	(ModifierId                              , ModifierType                          , SubjectRequirementSetId                       ,OwnerRequirementSetId)
	VALUES 
	('STEPWELL_HOLYSITEADJACENCY_FAITH_3' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS' , 'PLOT_ADJACENT_TO_HOLYSITE_REQUIREMENTS'     ,"PLAYER_HAS_POLITICAL_PHILOSOPHY_ZY_wq"),
	('STEPWELL_HOLYSITEADJACENCY_PRODUCTION_4' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS' , 'PLOT_ADJACENT_TO_HOLYSITE_REQUIREMENTS',"PLAYER_HAS_POLITICAL_PHILOSOPHY_ZY_gzh");
INSERT INTO ModifierArguments 
	(ModifierId                              , Name           , Value)
	VALUES 
	('STEPWELL_HOLYSITEADJACENCY_FAITH_3' , 'Amount'       , '1'                ),
	('STEPWELL_HOLYSITEADJACENCY_FAITH_3' , 'YieldType'    , 'YIELD_FAITH'                     ),
	('STEPWELL_HOLYSITEADJACENCY_PRODUCTION_4' , 'YieldType'    , 'YIELD_FAITH'                     ),
	('STEPWELL_HOLYSITEADJACENCY_PRODUCTION_4' , 'Amount'       , '1'                                    );
INSERT INTO ImprovementModifiers 
    (ImprovementType                              , ModifierId           )
    VALUES 
	('IMPROVEMENT_STEPWELL' , 'STEPWELL_HOLYSITEADJACENCY_FAITH_3'       ),
	('IMPROVEMENT_STEPWELL' , 'STEPWELL_HOLYSITEADJACENCY_PRODUCTION_4'  );
--商路 海商 山洞
UPDATE GlobalParameters SET Value='0' WHERE Name='TRADE_ROUTE_TRANSPORTATION_EFFICIENCY_SCORE_BEST_ROUTE_TILE';
UPDATE GlobalParameters SET Value='0' WHERE Name='TRADE_ROUTE_TRANSPORTATION_EFFICIENCY_SCORE_WATER_TILE';


--印度尼西亚 UU

--外交部
INSERT INTO Modifiers (ModifierId, ModifierType)
	VALUES
	('ADD_TWO_INFLUENCE_TOKEN_WAIJIAOBU', 'MODIFIER_PLAYER_GRANT_INFLUENCE_TOKEN');
INSERT INTO ModifierArguments (ModifierId, Name,Value)
	VALUES 
	('ADD_TWO_INFLUENCE_TOKEN_WAIJIAOBU', 'Amount', '2');

INSERT INTO Modifiers 
	(ModifierId                              , ModifierType                          )
	VALUES 
	('TRAIT_TOWORLDSEND_NO_WAR_WEARINESS_222' , 'MODIFIER_PLAYER_ADJUST_WAR_WEARINESS' ),
	('CHARISMATICLEADER_INFLUENCEPOINTS_222' , 'MODIFIER_PLAYER_ADJUST_INFLUENCE_POINTS_PER_TURN');
INSERT INTO ModifierArguments 
	(ModifierId                              , Name           , Value)
	VALUES 
	('TRAIT_TOWORLDSEND_NO_WAR_WEARINESS_222' , 'Amount'       , '-20'                ),
	('TRAIT_TOWORLDSEND_NO_WAR_WEARINESS_222' , 'Overall'    , 'true'                     ),
	('CHARISMATICLEADER_INFLUENCEPOINTS_222' , 'Amount'    , '3'                     );
--
INSERT INTO BuildingModifiers (BuildingType,ModifierId)
    VALUES ('BUILDING_GOV_CITYSTATES', 'ADD_TWO_INFLUENCE_TOKEN_WAIJIAOBU'),
	--VALUES ('BUILDING_GOV_CITYSTATES', 'CIVIC_AWARD_ONE_INFLUENCE_TOKEN'),
    --('BUILDING_GOV_CITYSTATES', 'TRAIT_TOWORLDSEND_NO_WAR_WEARINESS_222'),
    ('BUILDING_GOV_CITYSTATES', 'CHARISMATICLEADER_INFLUENCEPOINTS_222');
UPDATE ModifierArguments SET Value='5' WHERE ModifierId='GOV_CITYSTATES_COMBAT_MODIFIER'and Name='Amount';--城邦+4-》+5
UPDATE ModifierArguments SET Value='5' WHERE ModifierId='GOVCITYSTATES_ADJUST_FAVOR'and Name='Amount';--外交+3-》+5

--银 不再出现在沙漠、冻土丘陵上，且频率更低
--UPDATE Resources SET Frequency='1' Where ResourceType="RESOURCE_SILVER";	
DELETE FROM Resource_ValidTerrains WHERE ResourceType="RESOURCE_SILVER" and TerrainType="TERRAIN_DESERT_HILLS";
DELETE FROM Resource_ValidTerrains WHERE ResourceType="RESOURCE_SILVER" and TerrainType="TERRAIN_TUNDRA_HILLS";
INSERT INTO Resource_ValidTerrains (ResourceType, TerrainType)
	VALUES ('RESOURCE_SILVER', 'TERRAIN_GRASS');
INSERT INTO Resource_ValidTerrains (ResourceType, TerrainType)
	VALUES ('RESOURCE_SILVER', 'TERRAIN_PLAINS');	
--库马戏 每个区域商路2文1金-》1文2金
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='MINOR_CIV_KUMASI_CULTURE_TRADE_ROUTE_YIELD_BONUS' and Name='Amount';
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='MINOR_CIV_KUMASI_GOLD_TRADE_ROUTE_YIELD_BONUS' and Name='Amount';


--枪兵
UPDATE ModifierArguments SET Value='7' WHERE ModifierId='ANTI_SPEAR' and Name='Amount';
UPDATE ModifierArguments SET Value='7' WHERE ModifierId='THRUST_BONUS_VS_MELEE' and Name='Amount';

--幸福 不高兴-1 ~ -2
--UPDATE Happinesses SET MaximumAmenityScore='-2' WHERE HappinessType='HAPPINESS_DISPLEASED';
--UPDATE Happinesses SET MinimumAmenityScore='-1' WHERE HappinessType='HAPPINESS_CONTENT';
--UPDATE GlobalParameters SET Value='1' WHERE Name='THRESHOLD_SHIFT_PER_MISSING_AMENITY';

--枪兵
--UPDATE UnitAbilities SET Description='LOC_ABILITY_ANTI_SPEAR_DESCRIPTION22' WHERE UnitAbilityType='ABILITY_ANTI_SPEAR';

--军阀
INSERT INTO BuildingModifiers (BuildingType , ModifierId)
	VALUES ('BUILDING_GOV_CONQUEST' , 'TRAIT_TOWORLDSEND_NO_WAR_WEARINESS_222');
--祠堂
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
	VALUES ('BUILDING_GOV_WIDE', 'GANDHI_FAST_SETTLERS');
--女王图书馆 总督就职+宜居度
INSERT INTO Modifiers 
	(ModifierId                              , ModifierType                          ,SubjectRequirementSetId)
	VALUES 
	('GOV_TALL_AMENITY_BUFF222' , 'MODIFIER_PLAYER_CITIES_ADJUST_AMENITIES_FROM_GOVERNORS','CITY_HAS_GOVERNOR_REQUIREMENTS');
INSERT INTO ModifierArguments 
	(ModifierId                              , Name           , Value)
	VALUES 
	('GOV_TALL_AMENITY_BUFF222' , 'Amount'       , '0'                );
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
	VALUES ('BUILDING_QUEENS_BIBLIOTHEQUE', 'GOV_TALL_AMENITY_BUFF222');


--丰产仪式
INSERT INTO BeliefModifiers (BeliefType, ModifierId) VALUES
('BELIEF_FERTILITY_RITES', 'RELIGIOUS_SETTLEMENTS_PALACE_YIELD_FOOD22');

INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES
('RELIGIOUS_SETTLEMENTS_PALACE_YIELD_FOOD22', 'MODIFIER_ALL_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('RELIGIOUS_SETTLEMENTS_PALACE_YIELD_FOOD22', 'BuildingType', 'BUILDING_GRANARY'),
('RELIGIOUS_SETTLEMENTS_PALACE_YIELD_FOOD22', 'YieldType',    'YIELD_FOOD'),
('RELIGIOUS_SETTLEMENTS_PALACE_YIELD_FOOD22', 'Amount',       '1');
