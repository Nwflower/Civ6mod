--PRAGMA foreign_keys = OFF; 
--无水
UPDATE GlobalParameters SET Value='3' WHERE  Name='CITY_POPULATION_NO_WATER';	
-- 渔船+1锤
UPDATE Improvement_YieldChanges SET YieldChange=1 WHERE ImprovementType='IMPROVEMENT_FISHING_BOATS' AND YieldType='YIELD_PRODUCTION';
-- 渔船+0粮
--UPDATE Improvement_YieldChanges SET YieldChange=1 WHERE ImprovementType='IMPROVEMENT_FISHING_BOATS' AND YieldType='YIELD_FOOD';

--INSERT INTO Improvement_YieldChanges (ImprovementType , YieldType, YieldChange)
	--VALUES ('IMPROVEMENT_FISHING_BOATS' , 'YIELD_PRODUCTION', '1');
	
--礁石+0生产力
--UPDATE Feature_YieldChanges SET YieldChange=0 WHERE FeatureType='FEATURE_REEF' AND YieldType='YIELD_PRODUCTION';
--冰
--UPDATE GlobalParameters SET Value =0 WHERE Name='ICE_TILES_PERCENT';
--沿海住房+1
UPDATE GlobalParameters SET Value='4' WHERE  Name='CITY_POPULATION_COAST';
--移除海油
--DELETE FROM Resource_ValidTerrains Where ResourceType="RESOURCE_OIL" and TerrainType="TERRAIN_COAST";
--移除茶叶与草原
--DELETE FROM Resource_ValidTerrains Where ResourceType="RESOURCE_TEA" and TerrainType="TERRAIN_GRASS";
DELETE FROM Resource_ValidTerrains Where ResourceType="RESOURCE_TEA" and TerrainType="TERRAIN_GRASS_HILLS";
INSERT INTO Resource_YieldChanges (ResourceType , YieldType ,YieldChange )
	VALUES ('RESOURCE_TEA' , 'YIELD_PRODUCTION' , '1');
--移除大理石与草原
DELETE FROM Resource_ValidTerrains Where ResourceType="RESOURCE_MARBLE" and TerrainType="TERRAIN_GRASS";
--咖啡取消关联草原、烟草取消关联草原平原
--咖啡
DELETE FROM Resource_ValidTerrains Where ResourceType="RESOURCE_COFFEE" and TerrainType="TERRAIN_GRASS";
--盐
INSERT INTO Resource_YieldChanges (ResourceType , YieldType ,YieldChange )
	VALUES ('RESOURCE_SALT' , 'YIELD_PRODUCTION' , '1');
--烟草
DELETE FROM Resource_ValidTerrains Where ResourceType="RESOURCE_TOBACCO" and TerrainType="TERRAIN_GRASS";
DELETE FROM Resource_ValidTerrains Where ResourceType="RESOURCE_TOBACCO" and TerrainType="TERRAIN_PLAINS";
--移除柑橘关联平原
DELETE FROM Resource_ValidTerrains Where ResourceType="RESOURCE_CITRUS" and TerrainType="TERRAIN_PLAINS";
INSERT INTO Resource_YieldChanges (ResourceType , YieldType ,YieldChange )
	VALUES ('RESOURCE_CITRUS' , 'YIELD_PRODUCTION' , '1');
UPDATE Resource_YieldChanges SET YieldChange="1" WHERE ResourceType="RESOURCE_CITRUS" and YieldType="YIELD_FOOD";
--移除蜂蜜关联草原
DELETE FROM Resource_ValidTerrains Where ResourceType="RESOURCE_HONEY" and TerrainType="TERRAIN_GRASS";
--水银关联草原
INSERT INTO Resource_ValidTerrains (ResourceType, TerrainType)
	VALUES ('RESOURCE_MERCURY', 'TERRAIN_GRASS');
--熏香关联草原
INSERT INTO Resource_ValidTerrains (ResourceType, TerrainType)
	VALUES ('RESOURCE_INCENSE', 'TERRAIN_GRASS');
	
-- 专家加强
--UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_CULTURE' 		AND DistrictType="DISTRICT_ACROPOLIS";
--UPDATE District_CitizenYieldChanges SET YieldChange=2 WHERE YieldType='YIELD_SCIENCE' 		AND DistrictType="DISTRICT_CAMPUS";
--商业中心
UPDATE District_CitizenYieldChanges SET YieldChange=6 WHERE YieldType='YIELD_GOLD' 			AND DistrictType="DISTRICT_SUGUBA";
UPDATE District_CitizenYieldChanges SET YieldChange=6 WHERE YieldType='YIELD_GOLD' 			AND DistrictType="DISTRICT_COMMERCIAL_HUB";
--圣地
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_FAITH' 		AND DistrictType="DISTRICT_HOLY_SITE";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_FAITH' 		AND DistrictType="DISTRICT_LAVRA";
--UPDATE District_CitizenYieldChanges SET YieldChange=2 WHERE YieldType='YIELD_SCIENCE' 		AND DistrictType="DISTRICT_SEOWON";
--UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_CULTURE' 		AND DistrictType="DISTRICT_THEATER";
--工业区
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_PRODUCTION' 	AND DistrictType="DISTRICT_INDUSTRIAL_ZONE";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_PRODUCTION' 	AND DistrictType="DISTRICT_HANSA";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_PRODUCTION' 	AND DistrictType="DISTRICT_OPPIDUM";
--港口
UPDATE District_CitizenYieldChanges SET YieldChange=4 WHERE YieldType='YIELD_GOLD' 	AND DistrictType="DISTRICT_HARBOR";
UPDATE District_CitizenYieldChanges SET YieldChange=4 WHERE YieldType='YIELD_GOLD' 	AND DistrictType="DISTRICT_ROYAL_NAVY_DOCKYARD";
UPDATE District_CitizenYieldChanges SET YieldChange=4 WHERE YieldType='YIELD_GOLD' 	AND DistrictType="DISTRICT_COTHON";
--军营
UPDATE District_CitizenYieldChanges SET YieldChange=2 WHERE YieldType='YIELD_PRODUCTION' 	AND DistrictType="DISTRICT_IKANDA";
UPDATE District_CitizenYieldChanges SET YieldChange=2 WHERE YieldType='YIELD_PRODUCTION' 	AND DistrictType="DISTRICT_ENCAMPMENT";
UPDATE District_CitizenYieldChanges SET YieldChange=2 WHERE YieldType='YIELD_PRODUCTION' 	AND DistrictType="DISTRICT_THANH";
--解锁城市防御 城墙
UPDATE ModifierArguments SET Value='130' WHERE ModifierId='STEEL_UNLOCK_URBAN_DEFENSES' and Name='DefenseValue';
UPDATE Buildings SET Cost=80,OuterDefenseHitPoints=50,OuterDefenseStrength=0 WHERE BuildingType='BUILDING_WALLS';
UPDATE Buildings SET Cost=130,OuterDefenseHitPoints=40,OuterDefenseStrength=2 WHERE BuildingType='BUILDING_CASTLE';
UPDATE Buildings SET Cost=170,OuterDefenseHitPoints=40,OuterDefenseStrength=2 WHERE BuildingType='BUILDING_STAR_FORT';
--城市防御远程
UPDATE GlobalParameters SET Value='40' WHERE  Name='COMBAT_DEFENSE_DAMAGE_PERCENT_RANGED';


--谒见厅+2食物
INSERT INTO BuildingModifiers (BuildingType , ModifierId)
	VALUES ('BUILDING_GOV_TALL' , 'GOV_TALL_FOOD_BUFF');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('GOV_TALL_FOOD_BUFF' , 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE' , 'CITY_HAS_GOVERNOR_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('GOV_TALL_FOOD_BUFF' , 'YieldType' , 'YIELD_FOOD');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('GOV_TALL_FOOD_BUFF' , 'Amount' , '2');
--谒见厅+8%发展速度
INSERT INTO BuildingModifiers (BuildingType , ModifierId)
	VALUES ('BUILDING_GOV_TALL' , 'GOV_TALL_CITY_GROWTH_BUFF');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('GOV_TALL_CITY_GROWTH_BUFF' , 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_GROWTH' , 'CITY_HAS_GOVERNOR_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('GOV_TALL_CITY_GROWTH_BUFF' , 'Amount' , '7');
--军阀造兵+15%产能
--DELETE FROM BuildingModifiers WHERE ModifierId='GOV_PRODUCTION_BOOST_FROM_CAPTURE';
--DELETE FROM ModifierArguments WHERE ModifierId='GOV_PRODUCTION_BOOST_FROM_CAPTURE';
--DELETE FROM Modifiers WHERE ModifierId='GOV_PRODUCTION_BOOST_FROM_CAPTURE';
INSERT INTO BuildingModifiers (BuildingType , ModifierId)
	VALUES 
	('BUILDING_GOV_CONQUEST' , 'GOV_CONQUEST_PRODUCTION_BONUS'),
	('BUILDING_GOV_CONQUEST' , 'GOV_CONQUEST_REDUCED_MAINTENANCE');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES 
	('GOV_CONQUEST_PRODUCTION_BONUS'    , 'MODIFIER_PLAYER_CITIES_ADJUST_MILITARY_UNITS_PRODUCTION');
	--('GOV_CONQUEST_REDUCED_MAINTENANCE' , 'MODIFIER_PLAYER_ADJUST_UNIT_MAINTENANCE_DISCOUNT'       );
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES 
	('GOV_CONQUEST_PRODUCTION_BONUS'    , 'Amount'   , '0'             ),
	('GOV_CONQUEST_PRODUCTION_BONUS'    , 'StartEra' , 'ERA_ANCIENT'    ),
	('GOV_CONQUEST_PRODUCTION_BONUS'    , 'EndEra'   , 'ERA_INFORMATION');
	
--同盟--
UPDATE ModifierArguments SET Value='4' WHERE ModifierId='ALLIANCE_ADJUST_COMBAT_STRENGTH' AND Name='Amount';
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='ALLIANCE_ADD_CULTURE_TO_ORIGIN_TRADE_ROUTE' AND Name='Amount';
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='ALLIANCE_ADJUST_RELIGIOUS_COMBAT_STRENGTH' AND Name='Amount';
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='ALLIANCE_ADD_SCIENCE_TO_ORIGIN_TRADE_ROUTE' AND Name='Amount';
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='ALLIANCE_ADD_GOLD_TO_ORIGIN_TRADE_ROUTE' AND Name='Amount';

--铝
--UPDATE Resource_Consumption SET ImprovedExtractionRate='4' Where ResourceType="RESOURCE_ALUMINUM";
--油
--UPDATE Resource_Consumption SET ImprovedExtractionRate='6' Where ResourceType="RESOURCE_OIL";
--铝 
UPDATE Resources SET Frequency='13' Where ResourceType="RESOURCE_ALUMINUM";	
--油
UPDATE Resources SET Frequency='21' Where ResourceType="RESOURCE_OIL";
--硝石
UPDATE Resources SET Frequency='16' Where ResourceType="RESOURCE_NITER";
--煤
UPDATE Resources SET Frequency='16' Where ResourceType="RESOURCE_COAL";	

--资源关联
INSERT INTO Resource_ValidTerrains (ResourceType, TerrainType)
	VALUES ('RESOURCE_OIL', 'TERRAIN_GRASS');
INSERT INTO Resource_ValidTerrains (ResourceType, TerrainType)
	VALUES ('RESOURCE_OIL', 'TERRAIN_PLAINS');	
INSERT INTO Resource_ValidTerrains (ResourceType, TerrainType)
	VALUES ('RESOURCE_ALUMINUM', 'TERRAIN_GRASS');	

-- 海油开发
UPDATE Improvements SET PrereqTech='TECH_REFINING' WHERE ImprovementType='IMPROVEMENT_OFFSHORE_OIL_RIG';

-- 城市守护女神 35%	
UPDATE ModifierArguments SET Value='55' WHERE ModifierId='CITY_PATRON_GODDESS_DISTRICT_PRODUCTION_MODIFIER';

-- 信仰守护
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='DEFENDER_OF_FAITH_COMBAT_BONUS_MODIFIER';
-- 十字军
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='JUST_WAR_COMBAT_BONUS_MODIFIER';

-- 宗教偶像
UPDATE ModifierArguments SET Value=3 WHERE ModifierId='RELIGIOUS_IDOLS_BONUS_MINE_FAITH_MODIFIER' and Name='Amount';
UPDATE ModifierArguments SET Value=3 WHERE ModifierId='RELIGIOUS_IDOLS_LUXURY_MINE_FAITH_MODIFIER' and Name='Amount';
-- 锻造之神
UPDATE ModifierArguments SET Value='15' WHERE ModifierId='GOD_OF_THE_FORGE_UNIT_ANCIENT_CLASSICAL_PRODUCTION_MODIFIER' and Name='Amount';
UPDATE ModifierArguments SET Value='ERA_INFORMATION' WHERE ModifierId='GOD_OF_THE_FORGE_UNIT_ANCIENT_CLASSICAL_PRODUCTION_MODIFIER' and Name='EndEra';
-- 主神纪念碑
UPDATE ModifierArguments SET Value='20' WHERE ModifierId='MONUMENT_TO_THE_GODS_ANCIENTCLASSICALWONDER_MODIFIER' and Name='Amount';
UPDATE ModifierArguments SET Value='ERA_INFORMATION' WHERE ModifierId='MONUMENT_TO_THE_GODS_ANCIENTCLASSICALWONDER_MODIFIER' AND Name='EndEra';
--石圈+2信仰+1信仰
 INSERT INTO BeliefModifiers(BeliefType, ModifierId)
	VALUES ('BELIEF_STONE_CIRCLES', 'STONE_CIRCLES_QUARRY_GOLD');
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId)
	VALUES ('STONE_CIRCLES_QUARRY_GOLD', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER','CITY_FOLLOWS_PANTHEON_REQUIREMENTS');
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId)
	VALUES ('STONE_CIRCLES_QUARRY_GOLD_MODIFIER', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD','PLOT_HAS_QUARRY_REQUIREMENTS');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('STONE_CIRCLES_QUARRY_GOLD', 'ModifierId','STONE_CIRCLES_QUARRY_GOLD_MODIFIER');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('STONE_CIRCLES_QUARRY_GOLD_MODIFIER', 'YieldType','YIELD_FAITH');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('STONE_CIRCLES_QUARRY_GOLD_MODIFIER', 'Amount',1); 

--共享教堂
UPDATE ModifierArguments SET Value='100' WHERE ModifierId='SIMULTANEUM_BUILDING_YIELDS_HIGH_ADJACENCY' and Name='Amount';
UPDATE ModifierArguments SET Value='100' WHERE ModifierId='SIMULTANEUM_BUILDING_YIELDS_HIGH_POP' and Name='Amount';

-- 合唱圣歌
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='CHORAL_MUSIC_SHRINE_CULTURE_MODIFIER' and Name='Amount';
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='CHORAL_MUSIC_TEMPLE_CULTURE_MODIFIER' and Name='Amount';


--信条
-- Lay Ministry now +2 Culture and +2 Faith per Theater and Holy Site
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='LAY_MINISTRY_CULTURE_DISTRICTS_MODIFIER' AND Name='Amount';
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='LAY_MINISTRY_FAITH_DISTRICTS_MODIFIER' AND Name='Amount';

UPDATE ModifierArguments SET Value='2' WHERE ModifierId='STEWARDSHIP_GOLD_DISTRICTS_MODIFIER' AND Name='Amount';
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='STEWARDSHIP_SCIENCE_DISTRICTS_MODIFIER' AND Name='Amount';

--夸文化信仰
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='CROSS_CULTURAL_DIALOGUE_SCIENCE_FOREIGN_FOLLOWER_MODIFIER' AND Name='PerXItems';
--普世教会
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='WORLD_CHURCH_CULTURE_FOREIGN_FOLLOWER_MODIFIER' AND Name='PerXItems';
--朝圣
UPDATE ModifierArguments SET Value='4' WHERE ModifierId='PILGRIMAGE_FAITH_FOREIGN_CITY_MODIFIER' AND Name='Amount';
--教会财产
--UPDATE ModifierArguments SET Value='4' WHERE ModifierId='CHURCH_PROPERTY_GOLD_FOREIGN_CITY_MODIFIER' AND Name='Amount';
--什一税
UPDATE ModifierArguments SET Value='5' WHERE ModifierId='TITHE_GOLD_FOLLOWER_MODIFIER' AND Name='PerXItems';
--禅修
UPDATE RequirementArguments SET Value='2' WHERE RequirementId='REQUIRES_CITY_HAS_2_SPECIALTY_DISTRICTS' AND Name='Amount';

--粮仓
--UPDATE Buildings SET Cost=65  WHERE BuildingType='BUILDING_GRANARY';

--拦洪坝
UPDATE Buildings SET Cost="40",PrereqTech="TECH_ELECTRICITY" WHERE BuildingType="BUILDING_FLOOD_BARRIER";
UPDATE Buildings_XP2 SET CostMultiplierPerTile="0",CostMultiplierPerSeaLevel="0" WHERE BuildingType="BUILDING_FLOOD_BARRIER";

--大学
--UPDATE Building_YieldChanges SET YieldChange=5 WHERE BuildingType='BUILDING_UNIVERSITY';
--UPDATE Building_YieldChanges SET YieldChange=5 WHERE BuildingType='BUILDING_MADRASA';

--兵营建筑+1产能
UPDATE Building_YieldChanges SET YieldChange="2" WHERE BuildingType='BUILDING_ORDU' and YieldType="YIELD_PRODUCTION";
UPDATE Building_YieldChanges SET YieldChange="2" WHERE BuildingType='BUILDING_BASILIKOI_PAIDES';
UPDATE Building_YieldChanges SET YieldChange="2" WHERE BuildingType='BUILDING_BARRACKS';
UPDATE Building_YieldChanges SET YieldChange="3" WHERE BuildingType='BUILDING_ARMORY';
UPDATE Building_YieldChanges SET YieldChange="4" WHERE BuildingType='BUILDING_MILITARY_ACADEMY';
UPDATE Building_YieldChanges SET YieldChange="2" WHERE BuildingType='BUILDING_STABLE';

--工业区建筑

UPDATE Building_YieldChanges SET YieldChange="4"  WHERE BuildingType='BUILDING_WORKSHOP';

--商业区建筑
--银行
UPDATE Building_YieldChanges SET YieldChange=7 WHERE BuildingType="BUILDING_BANK" and YieldType="YIELD_GOLD";
UPDATE Buildings SET Cost=250 WHERE BuildingType='BUILDING_BANK';
--证卷交易所
UPDATE Building_YieldChanges SET YieldChange=6 WHERE BuildingType="BUILDING_STOCK_EXCHANGE" and YieldType="YIELD_GOLD";

--剧院广场建筑
--博物馆
UPDATE Building_YieldChanges SET YieldChange=3 WHERE BuildingType="BUILDING_MUSEUM_ART" and YieldType="YIELD_CULTURE";
UPDATE Building_YieldChanges SET YieldChange=3 WHERE BuildingType="BUILDING_MUSEUM_ARTIFACT" and YieldType="YIELD_CULTURE";
--广播中心
UPDATE Building_YieldChanges SET YieldChange=3 WHERE BuildingType="BUILDING_BROADCAST_CENTER" and YieldType="YIELD_CULTURE";
UPDATE Building_YieldChanges SET YieldChange=3 WHERE BuildingType="BUILDING_FILM_STUDIO" and YieldType="YIELD_CULTURE";

--拦洪坝
UPDATE Buildings SET Cost="40",PrereqTech="TECH_ELECTRICITY" WHERE BuildingType="BUILDING_FLOOD_BARRIER";

--竞技场辐射
UPDATE Buildings SET Cost="150" WHERE BuildingType="BUILDING_ARENA";
--UPDATE Buildings SET RegionalRange="6",Description="LOC_BUILDING_ZOO_DESCRIPTION2",Entertainment="1" WHERE BuildingType="BUILDING_ARENA";
--DELETE FROM Building_YieldChanges  WHERE BuildingType='BUILDING_ARENA' and YieldType="YIELD_CULTURE";
UPDATE Building_YieldChanges SET YieldChange="2" WHERE BuildingType='BUILDING_ARENA' and YieldType="YIELD_CULTURE";


--武僧
UPDATE Units SET Cost=100,Combat=36,BaseMoves=3 WHERE UnitType='UNIT_WARRIOR_MONK'; 
--远古-30%产能
--侦察兵系
--高地
UPDATE Units SET Combat=55,Maintenance=2,BaseSightRange=3,BaseMoves=4 WHERE UnitType='UNIT_SCOTTISH_HIGHLANDER';
UPDATE Units SET Combat=25,Maintenance=1,BaseSightRange=3 WHERE UnitType='UNIT_SKIRMISHER';
--游骑兵
UPDATE Units SET Combat=50,Maintenance=2,BaseSightRange=3,BaseMoves=4 WHERE UnitType='UNIT_RANGER';
--特种部队
UPDATE Units SET Combat=70,Maintenance=4,BaseSightRange=3,BaseMoves=5 WHERE UnitType='UNIT_SPEC_OPS';

--弓箭
UPDATE Units SET Cost=60 WHERE UnitType='UNIT_ARCHER';
--66
--UPDATE Units SET Cost=24 WHERE UnitType='UNIT_SLINGER';
--棒子
--UPDATE Units SET MandatoryObsoleteTech="TECH_SCIENTIFIC_THEORY" WHERE UnitType='UNIT_WARRIOR';
--猴子
--UPDATE Units SET Cost=21 WHERE UnitType='UNIT_SCOUT';
--枪兵
UPDATE Units SET Cost=60,Maintenance=0,MandatoryObsoleteTech="TECH_MILITARY_TACTICS" WHERE UnitType='UNIT_SPEARMAN';
--战车
--UPDATE Units SET Cost=45 WHERE UnitType='UNIT_HEAVY_CHARIOT';
UPDATE Units SET MandatoryObsoleteTech="TECH_MILITARY_SCIENCE" WHERE UnitType="UNIT_HEAVY_CHARIOT";
--StrategicResource="RESOURCE_IRON"
--INSERT INTO Units_XP2 (ResourceMaintenanceAmount,ResourceCost,ResourceMaintenanceType,UnitType)
--	VALUES ('0','20','RESOURCE_IRON','UNIT_HEAVY_CHARIOT');
--INSERT SET ResourceMaintenanceAmount=0 , ResourceCost=20 , ResourceMaintenanceType="RESOURCE_IRON" WHERE UnitType='UNIT_HEAVY_CHARIOT';
--桨帆船
--UPDATE Units SET Cost=45 WHERE UnitType='UNIT_GALLEY';
--四段帆船
--UPDATE Units SET Cost=96 WHERE UnitType='UNIT_QUADRIREME';




--古典中世纪-20%产能
--攻城塔
UPDATE Units SET BaseMoves=3,Cost=80 WHERE UnitType='UNIT_SIEGE_TOWER';
--攻城锤
UPDATE Units SET BaseMoves=3,Cost=50 WHERE UnitType='UNIT_BATTERING_RAM';
--骑手
--UPDATE Units SET Cost=64,BaseMoves=4 WHERE UnitType='UNIT_HORSEMAN';
--铁剑
UPDATE Units SET Combat=36,MandatoryObsoleteTech="TECH_SCIENTIFIC_THEORY" WHERE UnitType='UNIT_SWORDSMAN';
--石弩
UPDATE Units SET Cost=90,Combat=20,BaseMoves=3 WHERE UnitType='UNIT_CATAPULT';
--长矛兵
UPDATE Units SET Combat=43,Cost=160,Maintenance=1,MandatoryObsoleteTech="TECH_BANKING" WHERE UnitType='UNIT_PIKEMAN';
--弩手
UPDATE Units SET Combat=32,RangedCombat=42 WHERE UnitType='UNIT_CROSSBOWMAN';
--散兵
--UPDATE Units SET Cost=120 WHERE UnitType='UNIT_SKIRMISHER';
--军事工程师
UPDATE Routes_XP2 SET BuildWithUnitChargeCost='0' WHERE RouteType='ROUTE_ANCIENT_ROAD';
UPDATE Routes_XP2 SET BuildWithUnitChargeCost='0' WHERE RouteType='ROUTE_MEDIEVAL_ROAD';
UPDATE Routes_XP2 SET BuildWithUnitChargeCost='0' WHERE RouteType='ROUTE_INDUSTRIAL_ROAD';
UPDATE Routes_XP2 SET BuildWithUnitChargeCost='0' WHERE RouteType='ROUTE_MODERN_ROAD';
UPDATE Units SET BaseMoves=4,Cost=150 WHERE UnitType='UNIT_MILITARY_ENGINEER';
--追猎者
UPDATE Units SET Cost=190,BaseMoves=6 WHERE UnitType='UNIT_COURSER';
--马镫
UPDATE Units SET Cost=210 WHERE UnitType='UNIT_KNIGHT';

--文艺复兴工业-10%产能
--火枪手
UPDATE Units SET BaseMoves=3,Combat=55 WHERE UnitType='UNIT_MUSKETMAN';
--硝石炮
UPDATE Units SET BaseMoves=3,Cost=210,Combat=40 WHERE UnitType='UNIT_BOMBARD';
--枪刺
UPDATE Units SET Cost=220,Maintenance=2,MandatoryObsoleteTech="TECH_CHEMISTRY" WHERE UnitType='UNIT_PIKE_AND_SHOT';
UPDATE Units SET PrereqTech='TECH_BANKING' WHERE UnitType='UNIT_PIKE_AND_SHOT';
--野战炮
--UPDATE Units SET Cost=267,Combat=50,RangedCombat=59 WHERE UnitType='UNIT_FIELD_CANNON';
--胸甲骑兵
--UPDATE Units SET Cost=297,Combat=64 WHERE UnitType='UNIT_CUIRASSIER';
UPDATE Units SET PrereqTech='TECH_MILITARY_SCIENCE' WHERE UnitType='UNIT_CUIRASSIER';
--近代骑兵
UPDATE Units SET Cost=320,Combat=61,BaseMoves=6 WHERE UnitType='UNIT_CAVALRY';
--轻快
--UPDATE Units SET Cost=216 WHERE UnitType='UNIT_CARAVEL';
--护卫舰
--UPDATE Units SET Cost=252 WHERE UnitType='UNIT_FRIGATE';

--现代以后
--坦克
UPDATE Units SET BaseMoves=5,Combat=81 WHERE UnitType='UNIT_TANK';
--现代坦克
UPDATE Units SET BaseMoves=5,Combat=95,PrereqTech='TECH_NANOTECHNOLOGY',Cost=660 WHERE UnitType='UNIT_MODERN_ARMOR';
--反坦克
UPDATE Units SET Cost=340,Maintenance=3,Combat=73,BaseMoves=3 WHERE UnitType='UNIT_AT_CREW';
--现代反坦克
UPDATE Units SET Cost=495,Maintenance=4,Combat=87,BaseMoves=3 WHERE UnitType='UNIT_MODERN_AT';
UPDATE Units SET PrereqTech='TECH_SATELLITES' WHERE UnitType='UNIT_MODERN_AT';
--步兵
UPDATE Units SET Cost=400,BaseMoves=3 WHERE UnitType='UNIT_INFANTRY';
--机关枪队
UPDATE Units SET Combat=70,RangedCombat=81 WHERE UnitType='UNIT_MACHINE_GUN';
--机械化步兵
UPDATE Units SET Cost=600,Combat=87,BaseMoves=3,Maintenance=6,PrereqTech='TECH_ROCKETRY' WHERE UnitType='UNIT_MECHANIZED_INFANTRY';
UPDATE Units SET StrategicResource="RESOURCE_NITER" WHERE UnitType="UNIT_INFANTRY";
UPDATE Units SET StrategicResource="RESOURCE_NITER" WHERE UnitType="UNIT_MECHANIZED_INFANTRY";
UPDATE Units_XP2 SET ResourceMaintenanceAmount=0 , ResourceCost=20 , ResourceMaintenanceType="RESOURCE_NITER" WHERE UnitType='UNIT_INFANTRY';
UPDATE Units_XP2 SET ResourceMaintenanceAmount=0 , ResourceCost=20 , ResourceMaintenanceType="RESOURCE_NITER" WHERE UnitType='UNIT_MECHANIZED_INFANTRY';
--直升机
UPDATE Units SET BaseMoves=5,Combat=86,Cost=540 WHERE UnitType='UNIT_HELICOPTER';
UPDATE Units SET StrategicResource="RESOURCE_OIL" WHERE UnitType="UNIT_HELICOPTER";
UPDATE Units_XP2 SET ResourceMaintenanceAmount=1 , ResourceCost=1 , ResourceMaintenanceType="RESOURCE_OIL" WHERE UnitType='UNIT_HELICOPTER';
--航空母舰
UPDATE Units SET Cost=400 WHERE UnitType='UNIT_AIRCRAFT_CARRIER';

--防空炮
UPDATE Units SET Cost=400,BaseMoves=2 WHERE UnitType='UNIT_ANTIAIR_GUN';
UPDATE Units SET AntiAirCombat=92 WHERE UnitType='UNIT_ANTIAIR_GUN';
UPDATE Units SET PrereqTech='TECH_REPLACEABLE_PARTS' WHERE UnitType='UNIT_ANTIAIR_GUN';
--防空车
UPDATE Units SET Cost=520,BaseMoves=3 WHERE UnitType='UNIT_MOBILE_SAM';
UPDATE Units SET AntiAirCombat=105 WHERE UnitType='UNIT_MOBILE_SAM';
--大炮--
UPDATE Units SET BaseMoves=3,Cost=320,Combat=60,Bombard=75  WHERE UnitType='UNIT_ARTILLERY';
--火箭炮--
UPDATE Units SET BaseMoves=3,Cost=510,Combat=75,Bombard=90  WHERE UnitType='UNIT_ROCKET_ARTILLERY';
--双翼机
UPDATE Units SET Combat=85,RangedCombat=85 WHERE UnitType='UNIT_BIPLANE';
--战斗机
UPDATE Units SET Combat=95,RangedCombat=95 WHERE UnitType='UNIT_FIGHTER';
--P51
UPDATE Units SET Combat=95,RangedCombat=95 WHERE UnitType='UNIT_AMERICAN_P51';
--轰炸机
UPDATE Units SET Combat=80,Bombard=105,Range=7  WHERE UnitType='UNIT_BOMBER';
--隐形战斗
UPDATE Units SET Combat=105,RangedCombat=105 WHERE UnitType='UNIT_JET_FIGHTER';
--隐形轰炸机
UPDATE Units SET Bombard=115,Combat=85,Range=8  WHERE UnitType='UNIT_JET_BOMBER'; 
--移除优先目标
UPDATE UnitCommands SET VisibleInUI=0 WHERE CommandType='UNITCOMMAND_PRIORITY_TARGET';
--UPDATE WMDs SET Cost= 1600 Where WeaponType="WMD_NUCLEAR_DEVICE";
--UPDATE WMDs SET Cost= 2000 Where WeaponType="WMD_THERMONUCLEAR_DEVICE";

--教育家
UPDATE ModifierArguments SET Value='0.6' WHERE ModifierId='CONNOISSEUR_CULTURE_CITIZEN' AND Name='Amount';
UPDATE ModifierArguments SET Value='0.8' WHERE ModifierId='RESEARCHER_SCIENCE_CITIZEN' AND Name='Amount';

--护卫舰+硝石
--UPDATE Units_XP2 SET ResourceCost="30" WHERE UnitType="UNIT_FRIGATE";
--戎克船
UPDATE Units SET StrategicResource="RESOURCE_NITER" WHERE UnitType="UNIT_INDONESIAN_JONG";
INSERT INTO Units_XP2 (UnitType,ResourceCost)
	VALUES ('UNIT_INDONESIAN_JONG','20');
--米舰
UPDATE Units SET Combat=63,RangedCombat=73,AntiAirCombat=85 WHERE UnitType='UNIT_BRAZILIAN_MINAS_GERAES';
--战舰
UPDATE Units SET AntiAirCombat=90 WHERE UnitType='UNIT_BATTLESHIP';
--驱逐舰
UPDATE Units SET AntiAirCombat=95 WHERE UnitType='UNIT_DESTROYER';
--导弹巡洋舰
UPDATE Units SET AntiAirCombat=105 WHERE UnitType='UNIT_MISSILE_CRUISER';
--时代进程
--UPDATE Eras_XP1 SET GameEraMinimumTurns='38' WHERE  EraType='ERA_CLASSICAL';
--UPDATE Eras_XP1 SET GameEraMaximumTurns='38' WHERE  EraType='ERA_CLASSICAL';
--UPDATE Eras_XP1 SET GameEraMinimumTurns='38' WHERE  EraType='ERA_MEDIEVAL';
--UPDATE Eras_XP1 SET GameEraMaximumTurns='38' WHERE  EraType='ERA_MEDIEVAL';
UPDATE Eras_XP1 SET GameEraMinimumTurns='30' WHERE  EraType='ERA_RENAISSANCE';--文艺复兴
--UPDATE Eras_XP1 SET GameEraMaximumTurns='38' WHERE  EraType='ERA_RENAISSANCE';
UPDATE Eras_XP1 SET GameEraMinimumTurns='30' WHERE  EraType='ERA_INDUSTRIAL';
--UPDATE Eras_XP1 SET GameEraMaximumTurns='38' WHERE  EraType='ERA_INDUSTRIAL';
UPDATE Eras_XP1 SET GameEraMinimumTurns='30' WHERE  EraType='ERA_MODERN';
--UPDATE Eras_XP1 SET GameEraMaximumTurns='38' WHERE  EraType='ERA_MODERN';
UPDATE Eras_XP1 SET GameEraMinimumTurns='30' WHERE  EraType='ERA_ATOMIC';
--UPDATE Eras_XP1 SET GameEraMaximumTurns='38' WHERE  EraType='ERA_ATOMIC';

--灾害系统
--陆地改良摧毁
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_FLOOD_MAJOR'and DamageType="IMPROVEMENT_DESTROYED";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_FLOOD_1000_YEAR'and DamageType="IMPROVEMENT_DESTROYED";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_KILIMANJARO_CATASTROPHIC'and DamageType="IMPROVEMENT_DESTROYED";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_VESUVIUS_MEGACOLOSSAL'and DamageType="IMPROVEMENT_DESTROYED";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_VOLCANO_CATASTROPHIC'and DamageType="IMPROVEMENT_DESTROYED";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_VOLCANO_MEGACOLOSSAL'and DamageType="IMPROVEMENT_DESTROYED";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_SIGNIFICANT'and DamageType="IMPROVEMENT_DESTROYED";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_CRIPPLING'and DamageType="IMPROVEMENT_DESTROYED";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_GRADIENT'and DamageType="IMPROVEMENT_DESTROYED";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_HABOOB'and DamageType="IMPROVEMENT_DESTROYED";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_TORNADO_FAMILY'and DamageType="IMPROVEMENT_DESTROYED";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_TORNADO_OUTBREAK'and DamageType="IMPROVEMENT_DESTROYED";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_4'and DamageType="IMPROVEMENT_DESTROYED";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_5'and DamageType="IMPROVEMENT_DESTROYED";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_TORNADO_FAMILY'and DamageType="IMPROVEMENT_DESTROYED";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_JUNGLE_FIRE'and DamageType="IMPROVEMENT_DESTROYED";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_FOREST_FIRE'and DamageType="IMPROVEMENT_DESTROYED";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE DamageType="IMPROVEMENT_DESTROYED";
--死亡平民单位
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_FLOOD_MAJOR'and DamageType="UNIT_KILLED_CIVILIAN";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_FLOOD_1000_YEAR'and DamageType="UNIT_KILLED_CIVILIAN";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_KILIMANJARO_CATASTROPHIC'and DamageType="UNIT_KILLED_CIVILIAN";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_VESUVIUS_MEGACOLOSSAL'and DamageType="UNIT_KILLED_CIVILIAN";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_VOLCANO_CATASTROPHIC'and DamageType="UNIT_KILLED_CIVILIAN";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_VOLCANO_MEGACOLOSSAL'and DamageType="UNIT_KILLED_CIVILIAN";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_CRIPPLING'and DamageType="UNIT_KILLED_CIVILIAN";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_HABOOB'and DamageType="UNIT_KILLED_CIVILIAN";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_TORNADO_OUTBREAK'and DamageType="UNIT_KILLED_CIVILIAN";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_5'and DamageType="UNIT_KILLED_CIVILIAN";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_NUCLEAR_ACCIDENT_MAJOR'and DamageType="UNIT_KILLED_CIVILIAN";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_NUCLEAR_ACCIDENT_CATASTROPHIC'and DamageType="UNIT_KILLED_CIVILIAN";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_FOREST_FIRE'and DamageType="UNIT_KILLED_CIVILIAN";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_JUNGLE_FIRE'and DamageType="UNIT_KILLED_CIVILIAN";
UPDATE RandomEvent_Damages SET Percentage='0' WHERE DamageType="UNIT_KILLED_CIVILIAN";

--暴风雪
--UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_SIGNIFICANT'and DamageType="DISTRICT_PILLAGED";
--UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_SIGNIFICANT'and DamageType="BUILDING_PILLAGED";
--UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_CRIPPLING'and DamageType="DISTRICT_PILLAGED";
--UPDATE RandomEvent_Damages SET Percentage='0' WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_CRIPPLING'and DamageType="POPULATION_LOSS";

--灾害生产力
--UPDATE RandomEvent_Yields SET Amount='0' WHERE RandomEventType='RANDOM_EVENT_JUNGLE_FIRE_TRIGGERED'and YieldType="YIELD_PRODUCTION";
--UPDATE RandomEvent_Yields SET Amount='0' WHERE RandomEventType='RANDOM_EVENT_FOREST_FIRE_TRIGGERED'and YieldType="YIELD_PRODUCTION";
--干旱
UPDATE RandomEvents SET Duration='3' WHERE RandomEventType='RANDOM_EVENT_DROUGHT_MAJOR';
UPDATE RandomEvents SET Duration='3' WHERE RandomEventType='RANDOM_EVENT_DROUGHT_EXTREME';
--灾害压力
--UPDATE GlobalParameters SET Value='50' WHERE Name='RANDOM_EVENT_FIRST_TIME_OCCURRENCE_BOOST';		
--地热相邻学院
--UPDATE Adjacency_YieldChanges SET YieldChange='1' WHERE ID='Geothermal_Science';
--山火
update RandomEvent_Yields set Amount = 0 where FeatureType = 'FEATURE_BURNT_JUNGLE' and RandomEventType = 'RANDOM_EVENT_JUNGLE_FIRE';
update RandomEvent_Yields set YieldType = 'YIELD_FOOD' where FeatureType = 'FEATURE_JUNGLE' and RandomEventType = 'RANDOM_EVENT_JUNGLE_FIRE';
update RandomEvent_Yields set Amount = 0 where FeatureType = 'FEATURE_BURNT_FOREST' and RandomEventType = 'RANDOM_EVENT_FOREST_FIRE';
update RandomEvent_Yields set YieldType = 'YIELD_FOOD' where FeatureType = 'FEATURE_FOREST' and RandomEventType = 'RANDOM_EVENT_FOREST_FIRE';

-- 太阳神

INSERT INTO Types(Type, Kind)
	VALUES ('BELIEF_GOD_OF_THE_SUN', 'KIND_BELIEF');
INSERT INTO Beliefs(BeliefType, Name, Description, BeliefClassType)
	VALUES ('BELIEF_GOD_OF_THE_SUN', 'LOC_BELIEF_GOD_OF_THE_SUN_NAME', 'LOC_BELIEF_GOD_OF_THE_SUN_DESCRIPTION', 'BELIEF_CLASS_PANTHEON');
INSERT INTO BeliefModifiers(BeliefType , ModifierId)
	VALUES ('BELIEF_GOD_OF_THE_SUN', 'GOD_OF_THE_SUN_BONUS_FARM_FOOD');
INSERT INTO BeliefModifiers(BeliefType , ModifierId)
	VALUES ('BELIEF_GOD_OF_THE_SUN', 'GOD_OF_THE_SUN_BONUS_FARM_GOLD');
INSERT INTO BeliefModifiers(BeliefType , ModifierId)
	VALUES ('BELIEF_GOD_OF_THE_SUN', 'GOD_OF_THE_SUN_BONUS_FARM_GOLD2');
INSERT INTO BeliefModifiers(BeliefType , ModifierId)
	VALUES ('BELIEF_GOD_OF_THE_SUN', 'GOD_OF_THE_SUN_BONUS_FARM_GOLD3');
	
INSERT INTO Modifiers(ModifierId , ModifierType, SubjectRequirementSetId)
	VALUES ('GOD_OF_THE_SUN_BONUS_FARM_FOOD', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS');
INSERT INTO Modifiers(ModifierId , ModifierType, SubjectRequirementSetId)
	VALUES ('GOD_OF_THE_SUN_BONUS_FARM_FOOD_MODIFIER', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_BONUS_FARM_REQUIREMENTS');

INSERT INTO RequirementSets(RequirementSetId , RequirementSetType)
	VALUES ('PLOT_HAS_BONUS_FARM_REQUIREMENTS', 'REQUIREMENTSET_TEST_ANY');	
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId)
	VALUES ('PLOT_HAS_BONUS_FARM_REQUIREMENTS', 'REQUIRES_RICE_IN_PLOT');	
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId)
	VALUES ('PLOT_HAS_BONUS_FARM_REQUIREMENTS', 'REQUIRES_WHEAT_IN_PLOT');	
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId)
	VALUES ('PLOT_HAS_BONUS_FARM_REQUIREMENTS', 'REQUIRES_MAIZE_IN_PLOT');	
--改良后金1
INSERT INTO RequirementSets(RequirementSetId , RequirementSetType)
	VALUES ('PLOT_HAS_BONUS_FARM_REQUIREMENTS2', 'REQUIREMENTSET_TEST_ALL');	
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId)
	VALUES ('PLOT_HAS_BONUS_FARM_REQUIREMENTS2', 'REQUIRES_PLOT_HAS_FARM');
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId)
	VALUES ('PLOT_HAS_BONUS_FARM_REQUIREMENTS2', 'REQUIRES_RICE_IN_PLOT');
--改良后金2
INSERT INTO RequirementSets(RequirementSetId , RequirementSetType)
	VALUES ('PLOT_HAS_BONUS_FARM_REQUIREMENTS3', 'REQUIREMENTSET_TEST_ALL');	
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId)
	VALUES ('PLOT_HAS_BONUS_FARM_REQUIREMENTS3', 'REQUIRES_PLOT_HAS_FARM');
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId)
	VALUES ('PLOT_HAS_BONUS_FARM_REQUIREMENTS3', 'REQUIRES_WHEAT_IN_PLOT');
--改良后金3
INSERT INTO RequirementSets(RequirementSetId , RequirementSetType)
	VALUES ('PLOT_HAS_BONUS_FARM_REQUIREMENTS4', 'REQUIREMENTSET_TEST_ALL');	
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId)
	VALUES ('PLOT_HAS_BONUS_FARM_REQUIREMENTS4', 'REQUIRES_PLOT_HAS_FARM');
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId)
	VALUES ('PLOT_HAS_BONUS_FARM_REQUIREMENTS4', 'REQUIRES_MAIZE_IN_PLOT');
--
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('GOD_OF_THE_SUN_BONUS_FARM_FOOD', 'ModifierId','GOD_OF_THE_SUN_BONUS_FARM_FOOD_MODIFIER');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('GOD_OF_THE_SUN_BONUS_FARM_FOOD_MODIFIER', 'YieldType','YIELD_FOOD');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('GOD_OF_THE_SUN_BONUS_FARM_FOOD_MODIFIER', 'Amount', 1);
--太阳神金币
INSERT INTO Modifiers(ModifierId , ModifierType, SubjectRequirementSetId)
	VALUES ('GOD_OF_THE_SUN_BONUS_FARM_GOLD', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS');
INSERT INTO Modifiers(ModifierId , ModifierType, SubjectRequirementSetId)
	VALUES ('GOD_OF_THE_SUN_BONUS_FARM_GOLD_MODIFIER', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_BONUS_FARM_REQUIREMENTS2');
--
INSERT INTO Modifiers(ModifierId , ModifierType, SubjectRequirementSetId)
	VALUES ('GOD_OF_THE_SUN_BONUS_FARM_GOLD2', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS');
INSERT INTO Modifiers(ModifierId , ModifierType, SubjectRequirementSetId)
	VALUES ('GOD_OF_THE_SUN_BONUS_FARM_GOLD_MODIFIER2', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_BONUS_FARM_REQUIREMENTS3');
--
INSERT INTO Modifiers(ModifierId , ModifierType, SubjectRequirementSetId)
	VALUES ('GOD_OF_THE_SUN_BONUS_FARM_GOLD3', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS');
INSERT INTO Modifiers(ModifierId , ModifierType, SubjectRequirementSetId)
	VALUES ('GOD_OF_THE_SUN_BONUS_FARM_GOLD_MODIFIER3', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_BONUS_FARM_REQUIREMENTS4');
--
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('GOD_OF_THE_SUN_BONUS_FARM_GOLD', 'ModifierId','GOD_OF_THE_SUN_BONUS_FARM_GOLD_MODIFIER');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('GOD_OF_THE_SUN_BONUS_FARM_GOLD2', 'ModifierId','GOD_OF_THE_SUN_BONUS_FARM_GOLD_MODIFIER2');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('GOD_OF_THE_SUN_BONUS_FARM_GOLD3', 'ModifierId','GOD_OF_THE_SUN_BONUS_FARM_GOLD_MODIFIER3');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('GOD_OF_THE_SUN_BONUS_FARM_GOLD_MODIFIER', 'YieldType','YIELD_GOLD');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('GOD_OF_THE_SUN_BONUS_FARM_GOLD_MODIFIER', 'Amount', 2);
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('GOD_OF_THE_SUN_BONUS_FARM_GOLD_MODIFIER2', 'YieldType','YIELD_GOLD');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('GOD_OF_THE_SUN_BONUS_FARM_GOLD_MODIFIER2', 'Amount', 2);
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('GOD_OF_THE_SUN_BONUS_FARM_GOLD_MODIFIER3', 'YieldType','YIELD_GOLD');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('GOD_OF_THE_SUN_BONUS_FARM_GOLD_MODIFIER3', 'Amount', 2);
 -- 月亮女神
INSERT INTO Types(Type, Kind)
	VALUES ('BELIEF_GODDESS_OF_THE_MOON', 'KIND_BELIEF');
INSERT INTO Beliefs(BeliefType, Name, Description, BeliefClassType)
	VALUES ('BELIEF_GODDESS_OF_THE_MOON', 'LOC_BELIEF_GODDESS_OF_THE_MOON_NAME', 'LOC_BELIEF_GODDESS_OF_THE_MOON_DESCRIPTION', 'BELIEF_CLASS_PANTHEON');
INSERT INTO BeliefModifiers(BeliefType , ModifierId)
	VALUES ('BELIEF_GODDESS_OF_THE_MOON', 'GODDESS_OF_THE_MOON_LUXURY_SCIENCE');
INSERT INTO Modifiers(ModifierId , ModifierType, SubjectRequirementSetId)
	VALUES ('GODDESS_OF_THE_MOON_LUXURY_SCIENCE', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS');
INSERT INTO Modifiers(ModifierId , ModifierType, SubjectRequirementSetId)
	VALUES ('GODDESS_OF_THE_MOON_LUXURY_SCIENCE_MODIFIER', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_LUXURY_FISHBOATS_REQUIREMENTS');		
INSERT INTO RequirementSets(RequirementSetId , RequirementSetType)
	VALUES ('PLOT_HAS_LUXURY_FISHBOATS_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL');	
 INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId)
 	VALUES ('PLOT_HAS_LUXURY_FISHBOATS_REQUIREMENTS', 'REQUIRES_PLOT_HAS_LUXURY');	
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId)
	VALUES ('PLOT_HAS_LUXURY_FISHBOATS_REQUIREMENTS', 'REQUIRES_PLOT_HAS_FISHINGBOATS');	
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('GODDESS_OF_THE_MOON_LUXURY_SCIENCE', 'ModifierId','GODDESS_OF_THE_MOON_LUXURY_SCIENCE_MODIFIER');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('GODDESS_OF_THE_MOON_LUXURY_SCIENCE_MODIFIER', 'YieldType','YIELD_PRODUCTION');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('GODDESS_OF_THE_MOON_LUXURY_SCIENCE_MODIFIER', 'Amount', 0);
	
INSERT INTO BeliefModifiers(BeliefType , ModifierId)
	VALUES ('BELIEF_GODDESS_OF_THE_MOON', 'GODDESS_OF_THE_MOON_LUXURY_SCIENCE1');
INSERT INTO Modifiers(ModifierId , ModifierType, SubjectRequirementSetId)
	VALUES ('GODDESS_OF_THE_MOON_LUXURY_SCIENCE1', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS');
INSERT INTO Modifiers(ModifierId , ModifierType, SubjectRequirementSetId)
	VALUES ('GODDESS_OF_THE_MOON_LUXURY_SCIENCE_MODIFIER2', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_FISHINGBOATS_REQUIREMENTS');			
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('GODDESS_OF_THE_MOON_LUXURY_SCIENCE1', 'ModifierId','GODDESS_OF_THE_MOON_LUXURY_SCIENCE_MODIFIER2');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('GODDESS_OF_THE_MOON_LUXURY_SCIENCE_MODIFIER2', 'YieldType','YIELD_GOLD');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('GODDESS_OF_THE_MOON_LUXURY_SCIENCE_MODIFIER2', 'Amount', 2); 
	
--黑暗卡科研40文化0 修行制度
UPDATE ModifierArguments SET Value='-10' WHERE ModifierId='MONASTICISM_CULTURE_MODIFIER' AND Name='Amount';
UPDATE ModifierArguments SET Value='12' WHERE ModifierId='MONASTICISM_HOLYSITE_SCIENCE' AND Name='Amount';

--政策黑暗商路卡 额外+2金币1科1文

INSERT INTO Modifiers (ModifierId,ModifierType)
	VALUES ('ISOLATIONISM_DOMESTIC_TRADE_ROUTE_GOLD','MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_DOMESTIC');
INSERT INTO PolicyModifiers (PolicyType,ModifierId)
	VALUES ('POLICY_ISOLATIONISM','ISOLATIONISM_DOMESTIC_TRADE_ROUTE_GOLD');
INSERT INTO ModifierArguments (ModifierId, Name,Value)
	VALUES ('ISOLATIONISM_DOMESTIC_TRADE_ROUTE_GOLD', 'YieldType', 'YIELD_GOLD');
INSERT INTO ModifierArguments (ModifierId, Name,Value)
	VALUES ('ISOLATIONISM_DOMESTIC_TRADE_ROUTE_GOLD', 'Amount', '2');
INSERT INTO ModifierArguments (ModifierId, Name,Value)
	VALUES ('ISOLATIONISM_DOMESTIC_TRADE_ROUTE_GOLD', 'Intercontinental', 'false');
INSERT INTO Modifiers (ModifierId,ModifierType)
	VALUES ('ISOLATIONISM_DOMESTIC_TRADE_ROUTE_CULTURE','MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_DOMESTIC');	
INSERT INTO PolicyModifiers (PolicyType,ModifierId)
	VALUES ('POLICY_ISOLATIONISM','ISOLATIONISM_DOMESTIC_TRADE_ROUTE_CULTURE');
INSERT INTO ModifierArguments (ModifierId, Name,Value)
	VALUES ('ISOLATIONISM_DOMESTIC_TRADE_ROUTE_CULTURE', 'YieldType', 'YIELD_CULTURE');
INSERT INTO ModifierArguments (ModifierId, Name,Value)
	VALUES ('ISOLATIONISM_DOMESTIC_TRADE_ROUTE_CULTURE', 'Amount', '1');
INSERT INTO ModifierArguments (ModifierId, Name,Value)
	VALUES ('ISOLATIONISM_DOMESTIC_TRADE_ROUTE_CULTURE', 'Intercontinental', 'false');
INSERT INTO Modifiers (ModifierId,ModifierType)
	VALUES ('ISOLATIONISM_DOMESTIC_TRADE_ROUTE_SCIENCE','MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_DOMESTIC');		
INSERT INTO PolicyModifiers (PolicyType,ModifierId)
	VALUES ('POLICY_ISOLATIONISM','ISOLATIONISM_DOMESTIC_TRADE_ROUTE_SCIENCE');
INSERT INTO ModifierArguments (ModifierId, Name,Value)
	VALUES ('ISOLATIONISM_DOMESTIC_TRADE_ROUTE_SCIENCE', 'YieldType', 'YIELD_SCIENCE');
INSERT INTO ModifierArguments (ModifierId, Name,Value)
	VALUES ('ISOLATIONISM_DOMESTIC_TRADE_ROUTE_SCIENCE', 'Amount', '2');
INSERT INTO ModifierArguments (ModifierId, Name,Value)
	VALUES ('ISOLATIONISM_DOMESTIC_TRADE_ROUTE_SCIENCE', 'Intercontinental', 'false');	

	
--黄金时代
/*
--自由探索港口商业+科研
INSERT INTO Types (Type,Kind) 
	VALUES ('MODIFIER_PLAYER_CITIE_ATTACH_MODIFIER', 'KIND_MODIFIER');
INSERT INTO DynamicModifiers (ModifierType, CollectionType,EffectType)
	VALUES ('MODIFIER_PLAYER_CITIE_ATTACH_MODIFIER', 'COLLECTION_PLAYER_CAPITAL_CITY', 'EFFECT_ATTACH_MODIFIER');
DELETE FROM	CommemorationModifiers WHERE CommemorationType="COMMEMORATION_SCIENTIFIC" and ModifierId="COMMEMORATION_SCIENTIFIC_GA_HARBOR";
DELETE FROM	CommemorationModifiers WHERE CommemorationType="COMMEMORATION_SCIENTIFIC" and ModifierId="COMMEMORATION_SCIENTIFIC_GA_COMMERCIAL_HUB";
INSERT INTO CommemorationModifiers (CommemorationType, ModifierId)
	VALUES ('COMMEMORATION_SCIENTIFIC', 'COMMEMORATION_SCIENTIFIC_GA_HARBOR_NEW');
INSERT INTO CommemorationModifiers (CommemorationType, ModifierId)
	VALUES ('COMMEMORATION_SCIENTIFIC', 'COMMEMORATION_SCIENTIFIC_GA_COMMERCIAL_HUB_NEW');
--INSERT INTO CommemorationModifiers (CommemorationType, ModifierId)
	--VALUES ('COMMEMORATION_SCIENTIFIC', 'COMMEMORATION_SCIENTIFIC_GA_ENCAMPMENT_NEW');
INSERT INTO Modifiers (ModifierId, ModifierType,OwnerRequirementSetId)
	VALUES ('COMMEMORATION_SCIENTIFIC_GA_HARBOR_NEW', 'MODIFIER_PLAYER_CITIE_ATTACH_MODIFIER', 'PLAYER_HAS_GOLDEN_AGE');
INSERT INTO Modifiers (ModifierId, ModifierType,SubjectRequirementSetId)
	VALUES ('COMMEMORATION_SCIENTIFIC_GA_HARBOR_MODIFIER_NEW', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE', 'DISTRICT_IS_HARBOR');
INSERT INTO Modifiers (ModifierId, ModifierType,OwnerRequirementSetId)
	VALUES ('COMMEMORATION_SCIENTIFIC_GA_COMMERCIAL_HUB_NEW', 'MODIFIER_PLAYER_CITIE_ATTACH_MODIFIER', 'PLAYER_HAS_GOLDEN_AGE');
INSERT INTO Modifiers (ModifierId, ModifierType,SubjectRequirementSetId)
	VALUES ('COMMEMORATION_SCIENTIFIC_GA_COMMERCIAL_HUB_MODIFIER_NEW', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE', 'DISTRICT_IS_COMMERCIAL_HUB');
--INSERT INTO Modifiers (ModifierId, ModifierType,OwnerRequirementSetId)
	--VALUES ('COMMEMORATION_SCIENTIFIC_GA_ENCAMPMENT_NEW', 'MODIFIER_PLAYER_CITIE_ATTACH_MODIFIER', 'PLAYER_HAS_GOLDEN_AGE');
INSERT INTO Modifiers (ModifierId, ModifierType,SubjectRequirementSetId)
	VALUES ('COMMEMORATION_SCIENTIFIC_GA_ENCAMPMENT_MODIFIER_NEW', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE', 'DISTRICT_IS_ENCAMPMENT');
--港口
INSERT INTO ModifierArguments (ModifierId, Name,Value)
	VALUES ('COMMEMORATION_SCIENTIFIC_GA_HARBOR_NEW', 'ModifierId', 'COMMEMORATION_SCIENTIFIC_GA_HARBOR_MODIFIER_NEW');
INSERT INTO ModifierArguments (ModifierId, Name,Value)
	VALUES ('COMMEMORATION_SCIENTIFIC_GA_HARBOR_MODIFIER_NEW', 'YieldType', 'YIELD_SCIENCE');
INSERT INTO ModifierArguments (ModifierId, Name,Value)
	VALUES ('COMMEMORATION_SCIENTIFIC_GA_HARBOR_MODIFIER_NEW', 'Amount', '4');
--商业
INSERT INTO ModifierArguments (ModifierId, Name,Value)
	VALUES ('COMMEMORATION_SCIENTIFIC_GA_COMMERCIAL_HUB_NEW', 'ModifierId', 'COMMEMORATION_SCIENTIFIC_GA_COMMERCIAL_HUB_MODIFIER_NEW');
INSERT INTO ModifierArguments (ModifierId, Name,Value)
	VALUES ('COMMEMORATION_SCIENTIFIC_GA_COMMERCIAL_HUB_MODIFIER_NEW', 'YieldType', 'YIELD_SCIENCE');
INSERT INTO ModifierArguments (ModifierId, Name,Value)
	VALUES ('COMMEMORATION_SCIENTIFIC_GA_COMMERCIAL_HUB_MODIFIER_NEW', 'Amount', '4');
	*/
--百花齐放
--文化黄金区域
--金币

INSERT INTO Modifiers (ModifierId , ModifierType , OwnerRequirementSetId)
    VALUES ('COMMEMORATION_CULTURAL_DISTRICTGOLD' , 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_PER_DISTRICT' , 'PLAYER_HAS_GOLDEN_AGE');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('COMMEMORATION_CULTURAL_DISTRICTGOLD' , 'YieldType' , 'YIELD_GOLD');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('COMMEMORATION_CULTURAL_DISTRICTGOLD' , 'Amount' , '1');
INSERT INTO CommemorationModifiers (CommemorationType, ModifierId)
	VALUES ('COMMEMORATION_CULTURAL', 'COMMEMORATION_CULTURAL_DISTRICTGOLD');
--锤
INSERT INTO Modifiers (ModifierId , ModifierType , OwnerRequirementSetId)
    VALUES ('COMMEMORATION_CULTURAL_DISTRICTGOLD2' , 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_PER_DISTRICT' , 'PLAYER_HAS_GOLDEN_AGE');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('COMMEMORATION_CULTURAL_DISTRICTGOLD2' , 'YieldType' , 'YIELD_PRODUCTION');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('COMMEMORATION_CULTURAL_DISTRICTGOLD2' , 'Amount' , '1');
INSERT INTO CommemorationModifiers (CommemorationType, ModifierId)
	VALUES ('COMMEMORATION_CULTURAL', 'COMMEMORATION_CULTURAL_DISTRICTGOLD2');
	
--雄伟壮丽
--折扣
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='COMMEMORATION_INFRASTRUCTURE_BUILDER_DISCOUNT_MODIFIER' AND Name='Amount';
UPDATE ModifierArguments SET Value='-30' WHERE ModifierId='COMMEMORATION_INFRASTRUCTURE_SETTLER_DISCOUNT_MODIFIER' AND Name='Amount';


--政策
--飞机卡移至大众媒体
--update Policies set PrereqCivic="CIVIC_MASS_MEDIA" where PolicyType="POLICY_STRATEGIC_AIR_FORCE";
--步兵卡移至动员
update Policies set PrereqCivic="CIVIC_MOBILIZATION" where PolicyType="POLICY_MILITARY_FIRST";








--==================
-- 阿拉伯
--==================
-- Arabia's Worship Building Bonus increased from 10% to 20%
UPDATE ModifierArguments SET Value='7' WHERE ModifierId='TRAIT_RELIGIOUS_BUILDING_MULTIPLIER_CULTURE' AND Name='Multiplier';
UPDATE ModifierArguments SET Value='7' WHERE ModifierId='TRAIT_RELIGIOUS_BUILDING_MULTIPLIER_FAITH' AND Name='Multiplier';
UPDATE ModifierArguments SET Value='7' WHERE ModifierId='TRAIT_RELIGIOUS_BUILDING_MULTIPLIER_SCIENCE' AND Name='Multiplier';
---奴隶骑
UPDATE Units SET Cost=200,Maintenance=4,Combat=52 WHERE UnitType='UNIT_ARABIAN_MAMLUK';				
UPDATE UnitUpgrades SET UpgradeUnit="UNIT_CUIRASSIER" WHERE Unit='UNIT_ARABIAN_MAMLUK' AND UpgradeUnit="UNIT_TANK" ;
---伊斯兰大学
--UPDATE Building_YieldChanges SET YieldChange=5 WHERE BuildingType='BUILDING_MADRASA';
--UPDATE ModifierArguments SET Value='BELIEF_YIELD_PER_CITY' WHERE ModifierId='TRAIT_SCIENCE_PER_FOREIGN_CITY_FOLLOWING_RELIGION' AND Name='BeliefYieldType';




  
--马其顿
--
UPDATE Buildings SET Cost=80 WHERE BuildingType="BUILDING_BASILIKOI_PAIDES";
--UPDATE ModifierArguments SET Value='2' WHERE ModifierId='HETAIROI_GREAT_GENERAL_COMBAT_BONUS' and Name='Amount';
UPDATE Units SET Cost=80,Combat=36 WHERE UnitType='UNIT_MACEDONIAN_HETAIROI';
UPDATE Units SET Cost=90,Combat=38 WHERE UnitType='UNIT_MACEDONIAN_HYPASPIST';
--迟钝护卫 铁
--迟钝护卫 对市中心伤害
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='HYPASPIST_SIEGE_BONUS' AND Name='Amount';
UPDATE Units_XP2 SET ResourceCost=10 WHERE UnitType="UNIT_MACEDONIAN_HYPASPIST";
--马其顿BUG修复
DELETE FROM UnitAbilityModifiers WHERE ModifierId='HETAIROI_GREAT_GENERAL_COMBAT_BONUS';
DELETE FROM Modifiers WHERE ModifierId='HETAIROI_GREAT_GENERAL_COMBAT_BONUS';
DELETE FROM ModifierArguments WHERE ModifierId='HETAIROI_GREAT_GENERAL_COMBAT_BONUS';
DELETE FROM ModifierStrings WHERE ModifierId='HETAIROI_GREAT_GENERAL_COMBAT_BONUS';

INSERT INTO UnitAbilityModifiers (UnitAbilityType , ModifierId)
	VALUES ('ABILITY_HETAIROI' , 'HETAIROI_NEIGHBOR_COMBAT');
INSERT INTO Modifiers (ModifierId , ModifierType,SubjectRequirementSetId)
	VALUES ('HETAIROI_NEIGHBOR_COMBAT' , 'MODIFIER_SINGLE_UNIT_ATTACH_MODIFIER','HETAIROI_PLOT_IS_HETAIROI_REQUIREMENTS');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('HETAIROI_NEIGHBOR_COMBAT_MODIFIER' , 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH');
INSERT INTO ModifierArguments (ModifierId , Name , Value) 
	VALUES ('HETAIROI_NEIGHBOR_COMBAT' , 'ModifierId' , 'HETAIROI_NEIGHBOR_COMBAT_MODIFIER');
INSERT INTO ModifierArguments (ModifierId , Name , Value) 
	VALUES ('HETAIROI_NEIGHBOR_COMBAT_MODIFIER' , 'Amount' , '2');

INSERT INTO ModifierStrings (ModifierId , Context , Text) 
	VALUES ('HETAIROI_NEIGHBOR_COMBAT_MODIFIER' , 'Preview' , 'LOC_HETAIROI_GREAT_GENERAL_COMBAT_BONUS_DESCRIPTION');

INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('HETAIROI_PLOT_IS_HETAIROI_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('HETAIROI_PLOT_IS_HETAIROI_REQUIREMENTS' , 'REQUIRES_UNIT_NEXT_TO_HETAIROI');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_UNIT_NEXT_TO_HETAIROI' , 'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_UNIT_TYPE_MATCHES');
INSERT INTO RequirementArguments (RequirementId , Name , Value) 
	VALUES ('REQUIRES_UNIT_NEXT_TO_HETAIROI' , 'UnitType' , 'UNIT_GREAT_GENERAL');
INSERT INTO RequirementArguments (RequirementId , Name , Value) 
	VALUES ('REQUIRES_UNIT_NEXT_TO_HETAIROI' , 'IncludeCenter' , 'true');

	
--毛利
--UPDATE ModifierArguments SET Value='0' WHERE ModifierId='SCIENCE_PRESETTLEMENT' AND Name='Amount';
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='CULTURE_PRESETTLEMENT' AND Name='Amount';
--渔船不加食物
--UPDATE ModifierArguments SET Value='0' WHERE ModifierId='TRAIT_MAORI_FISHING_BOAT_FOOD' AND Name='Amount';
--渔船加食物需要港口
/*
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('PLAYER_HAS_TECH_POTTERY_REQUIREMENTS_XXXmod_maoli' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('PLAYER_HAS_TECH_POTTERY_REQUIREMENTS_XXXmod_maoli' , 'PLAYER_HAS_TECH_POTTERY_XXXmod_maoli');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('PLAYER_HAS_TECH_POTTERY_XXXmod_maoli' , 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('PLAYER_HAS_TECH_POTTERY_XXXmod_maoli' , 'CivicType' , 'CIVIC_EARLY_EMPIRE');
UPDATE Modifiers SET OwnerRequirementSetId='PLAYER_HAS_TECH_POTTERY_REQUIREMENTS_XXXmod_maoli' WHERE ModifierId='TRAIT_MAORI_FISHING_BOAT_FOOD';
*/
UPDATE ModifierArguments SET Value="YIELD_GOLD" WHERE ModifierId='TRAIT_MAORI_FISHING_BOAT_FOOD' AND Name='YieldType';
--森林树林加锤需要铸铜
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('PLAYER_HAS_TECH_POTTERY_REQUIREMENTS_XXXmod_maoli2' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('PLAYER_HAS_TECH_POTTERY_REQUIREMENTS_XXXmod_maoli2' , 'PLAYER_HAS_TECH_POTTERY_XXXmod_maoli2');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('PLAYER_HAS_TECH_POTTERY_XXXmod_maoli2' , 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('PLAYER_HAS_TECH_POTTERY_XXXmod_maoli2' , 'CivicType' , 'CIVIC_FOREIGN_TRADE');
UPDATE Modifiers SET OwnerRequirementSetId='PLAYER_HAS_TECH_POTTERY_REQUIREMENTS_XXXmod_maoli2' WHERE ModifierId='TRAIT_MAORI_PRODUCTION_RAINFOREST';
UPDATE Modifiers SET OwnerRequirementSetId='PLAYER_HAS_TECH_POTTERY_REQUIREMENTS_XXXmod_maoli2' WHERE ModifierId='TRAIT_MAORI_PRODUCTION_WOODS';

--送猴子
--UPDATE ModifierArguments SET Value='UNIT_SCOUT' WHERE ModifierId='BUILDER_PRESETTLEMENT' AND Name='UnitType';



--20200529特殊改动
--瑞典
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='CAROLEAN_UNUSED_MOVEMENT_COMBAT'and Name="Amount";	
UPDATE Units SET Maintenance=2 WHERE UnitType='UNIT_SWEDEN_CAROLEAN';

UPDATE ModifierArguments SET Value="20" WHERE ModifierId="TRAIT_GREATPERSON_FAVOR_MODIFIER" and Name="Amount";	
		
--瑞典女王图书馆
UPDATE Building_GreatPersonPoints SET PointsPerTurn="2" WHERE BuildingType="BUILDING_QUEENS_BIBLIOTHEQUE" and GreatPersonClassType="GREAT_PERSON_CLASS_WRITER";
UPDATE Building_GreatPersonPoints SET PointsPerTurn="3" WHERE BuildingType="BUILDING_QUEENS_BIBLIOTHEQUE" and GreatPersonClassType="GREAT_PERSON_CLASS_ARTIST";
UPDATE Building_GreatPersonPoints SET PointsPerTurn="3" WHERE BuildingType="BUILDING_QUEENS_BIBLIOTHEQUE" and GreatPersonClassType="GREAT_PERSON_CLASS_MUSICIAN";

UPDATE Buildings SET GovernmentTierRequirement="Tier1",Cost="35" WHERE BuildingType="BUILDING_QUEENS_BIBLIOTHEQUE";
UPDATE ModifierArguments SET Value="0" WHERE ModifierId="QUEENS_BIBLIOTHEQUE_GRANT_GOVERNOR_POINTS" and Name="Delta";	
--删除可以升级至3级市政
DELETE FROM BuildingPrereqs WHERE Building='BUILDING_GOV_MILITARY' and PrereqBuilding="BUILDING_QUEENS_BIBLIOTHEQUE";
DELETE FROM BuildingPrereqs WHERE Building='BUILDING_GOV_CULTURE' and PrereqBuilding="BUILDING_QUEENS_BIBLIOTHEQUE";
DELETE FROM BuildingPrereqs WHERE Building='BUILDING_GOV_SCIENCE' and PrereqBuilding="BUILDING_QUEENS_BIBLIOTHEQUE";
--删除需要1级市政，女王图书馆可以升级至2级市政
DELETE FROM BuildingPrereqs WHERE Building='BUILDING_QUEENS_BIBLIOTHEQUE' and PrereqBuilding="BUILDING_GOV_TALL";
DELETE FROM BuildingPrereqs WHERE Building='BUILDING_QUEENS_BIBLIOTHEQUE' and PrereqBuilding="BUILDING_GOV_CONQUEST";
DELETE FROM BuildingPrereqs WHERE Building='BUILDING_QUEENS_BIBLIOTHEQUE' and PrereqBuilding="BUILDING_GOV_WIDE";
INSERT INTO BuildingPrereqs (Building , PrereqBuilding)
	VALUES 	('BUILDING_GOV_CITYSTATES' , 'BUILDING_QUEENS_BIBLIOTHEQUE');
INSERT INTO BuildingPrereqs (Building , PrereqBuilding)
	VALUES 	('BUILDING_GOV_SPIES' , 'BUILDING_QUEENS_BIBLIOTHEQUE');
	INSERT INTO BuildingPrereqs (Building , PrereqBuilding)
	VALUES 	('BUILDING_GOV_FAITH' , 'BUILDING_QUEENS_BIBLIOTHEQUE');
--删除女王图书馆与2级市政互斥
DELETE FROM MutuallyExclusiveBuildings WHERE Building='BUILDING_GOV_CITYSTATES' and MutuallyExclusiveBuilding="BUILDING_QUEENS_BIBLIOTHEQUE";
DELETE FROM MutuallyExclusiveBuildings WHERE Building='BUILDING_GOV_SPIES' and MutuallyExclusiveBuilding="BUILDING_QUEENS_BIBLIOTHEQUE";
DELETE FROM MutuallyExclusiveBuildings WHERE Building='BUILDING_GOV_FAITH' and MutuallyExclusiveBuilding="BUILDING_QUEENS_BIBLIOTHEQUE";
DELETE FROM MutuallyExclusiveBuildings WHERE Building='BUILDING_QUEENS_BIBLIOTHEQUE' and MutuallyExclusiveBuilding="BUILDING_GOV_CITYSTATES";
DELETE FROM MutuallyExclusiveBuildings WHERE Building='BUILDING_QUEENS_BIBLIOTHEQUE' and MutuallyExclusiveBuilding="BUILDING_GOV_SPIES";
DELETE FROM MutuallyExclusiveBuildings WHERE Building='BUILDING_QUEENS_BIBLIOTHEQUE' and MutuallyExclusiveBuilding="BUILDING_GOV_FAITH";
--添加女王图书馆与1级市政互斥
/*
INSERT INTO MutuallyExclusiveBuildings (Building , MutuallyExclusiveBuilding)
	VALUES 	('BUILDING_QUEENS_BIBLIOTHEQUE' , 'BUILDING_GOV_TALL');
INSERT INTO MutuallyExclusiveBuildings (Building , MutuallyExclusiveBuilding)
	VALUES 	('BUILDING_QUEENS_BIBLIOTHEQUE' , 'BUILDING_GOV_WIDE');
INSERT INTO MutuallyExclusiveBuildings (Building , MutuallyExclusiveBuilding)
	VALUES 	('BUILDING_QUEENS_BIBLIOTHEQUE' , 'BUILDING_GOV_CONQUEST');	
INSERT INTO MutuallyExclusiveBuildings (Building , MutuallyExclusiveBuilding)
	VALUES 	('BUILDING_GOV_TALL' , 'BUILDING_QUEENS_BIBLIOTHEQUE');
INSERT INTO MutuallyExclusiveBuildings (Building , MutuallyExclusiveBuilding)
	VALUES 	('BUILDING_GOV_WIDE' , 'BUILDING_QUEENS_BIBLIOTHEQUE');
INSERT INTO MutuallyExclusiveBuildings (Building , MutuallyExclusiveBuilding)
	VALUES 	('BUILDING_GOV_CONQUEST' , 'BUILDING_QUEENS_BIBLIOTHEQUE');	
	*/
--卡洛琳步兵
UPDATE Units SET PrereqTech='TECH_BANKING',MandatoryObsoleteTech="TECH_CHEMISTRY" WHERE UnitType='UNIT_SWEDEN_CAROLEAN';

--诺贝尔奖+工厂大学建造速度 额外+1伟人点
--UPDATE ModifierArguments SET Value="2" WHERE Name="Amount" and ModifierId="TRAIT_GREAT_SCIENTIST_UNIVERSITY_MODIFIER";
--UPDATE ModifierArguments SET Value="2" WHERE Name="Amount" and ModifierId="TRAIT_GREAT_ENGINEER_FACTORY_MODIFIER";

/*INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES
	('TRAIT_CIVILIZATION_NOBEL_PRIZE' , 'NOBEL_PRIZE_UNIVERISTY_BOOST' ),
	('TRAIT_CIVILIZATION_NOBEL_PRIZE' , 'NOBEL_PRIZE_FACTORY_BOOST' );
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES
	('NOBEL_PRIZE_UNIVERISTY_BOOST' , 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION' , null),
	('NOBEL_PRIZE_FACTORY_BOOST' , 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION' , null);
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra , SecondExtra)
	VALUES 
	('NOBEL_PRIZE_UNIVERISTY_BOOST' , 'BuildingType' , 'BUILDING_UNIVERSITY' , null , null),
	('NOBEL_PRIZE_UNIVERISTY_BOOST' , 'Amount'       , '45'                  , null , null),
	('NOBEL_PRIZE_FACTORY_BOOST'    , 'BuildingType' , 'BUILDING_FACTORY'    , null , null),
	('NOBEL_PRIZE_FACTORY_BOOST'    , 'Amount'       , '45'                  , null , null);
*/


	
	
--苏格兰
UPDATE Improvements SET PrereqCivic='CIVIC_GAMES_RECREATION' WHERE ImprovementType='IMPROVEMENT_GOLF_COURSE';
UPDATE ModifierArguments SET Value="1" WHERE ModifierId="GOLFCOURSE_AMENITY" AND Name="Amount";

--领袖埃丽诺
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='IDENTITY_NEARBY_GREATWORKS' AND Name='Amount';	

--核反应
UPDATE Projects SET Cost="1300" WHERE ProjectType="PROJECT_BUILD_NUCLEAR_DEVICE";
UPDATE Projects SET Cost="1600" WHERE ProjectType="PROJECT_BUILD_THERMONUCLEAR_DEVICE";

--所有文化著作等等+科研
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES 	('TRAIT_LEADER_ELEANOR_LOYALTY' , 'ELEANOR_DOUBLE_SCULPTURE_S1');	
INSERT INTO Modifiers(ModifierId , ModifierType)
	VALUES ('ELEANOR_DOUBLE_SCULPTURE_S1', 'MODIFIER_PLAYER_CITIES_ADJUST_GREATWORK_YIELD');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('ELEANOR_DOUBLE_SCULPTURE_S1', 'GreatWorkObjectType', 'GREATWORKOBJECT_WRITING');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('ELEANOR_DOUBLE_SCULPTURE_S1', 'YieldType', 'YIELD_SCIENCE');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('ELEANOR_DOUBLE_SCULPTURE_S1', 'YieldChange', 3);
	
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES 	('TRAIT_LEADER_ELEANOR_LOYALTY' , 'ELEANOR_DOUBLE_SCULPTURE_S2');
INSERT INTO Modifiers(ModifierId , ModifierType)
	VALUES ('ELEANOR_DOUBLE_SCULPTURE_S2', 'MODIFIER_PLAYER_CITIES_ADJUST_GREATWORK_YIELD');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('ELEANOR_DOUBLE_SCULPTURE_S2', 'GreatWorkObjectType', 'GREATWORKOBJECT_RELIGIOUS');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('ELEANOR_DOUBLE_SCULPTURE_S2', 'YieldType', 'YIELD_SCIENCE');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('ELEANOR_DOUBLE_SCULPTURE_S2', 'YieldChange', '3');	
	
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES 	('TRAIT_LEADER_ELEANOR_LOYALTY' , 'ELEANOR_DOUBLE_SCULPTURE_S3');
INSERT INTO Modifiers(ModifierId , ModifierType)
	VALUES ('ELEANOR_DOUBLE_SCULPTURE_S3', 'MODIFIER_PLAYER_CITIES_ADJUST_GREATWORK_YIELD');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('ELEANOR_DOUBLE_SCULPTURE_S3', 'GreatWorkObjectType', 'GREATWORKOBJECT_SCULPTURE');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('ELEANOR_DOUBLE_SCULPTURE_S3', 'YieldType', 'YIELD_SCIENCE');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('ELEANOR_DOUBLE_SCULPTURE_S3', 'YieldChange', '3');	
	
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES 	('TRAIT_LEADER_ELEANOR_LOYALTY' , 'ELEANOR_DOUBLE_SCULPTURE_S4');
INSERT INTO Modifiers(ModifierId , ModifierType)
	VALUES ('ELEANOR_DOUBLE_SCULPTURE_S4', 'MODIFIER_PLAYER_CITIES_ADJUST_GREATWORK_YIELD');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('ELEANOR_DOUBLE_SCULPTURE_S4', 'GreatWorkObjectType', 'GREATWORKOBJECT_PORTRAIT');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('ELEANOR_DOUBLE_SCULPTURE_S4', 'YieldType', 'YIELD_SCIENCE');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('ELEANOR_DOUBLE_SCULPTURE_S4', 'YieldChange', '3');	

INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES 	('TRAIT_LEADER_ELEANOR_LOYALTY' , 'ELEANOR_DOUBLE_SCULPTURE_S5');
INSERT INTO Modifiers(ModifierId , ModifierType)
	VALUES ('ELEANOR_DOUBLE_SCULPTURE_S5', 'MODIFIER_PLAYER_CITIES_ADJUST_GREATWORK_YIELD');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('ELEANOR_DOUBLE_SCULPTURE_S5', 'GreatWorkObjectType', 'GREATWORKOBJECT_LANDSCAPE');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('ELEANOR_DOUBLE_SCULPTURE_S5', 'YieldType', 'YIELD_SCIENCE');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('ELEANOR_DOUBLE_SCULPTURE_S5', 'YieldChange', '3');	
	
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES 	('TRAIT_LEADER_ELEANOR_LOYALTY' , 'ELEANOR_DOUBLE_SCULPTURE_S6');
INSERT INTO Modifiers(ModifierId , ModifierType)
	VALUES ('ELEANOR_DOUBLE_SCULPTURE_S6', 'MODIFIER_PLAYER_CITIES_ADJUST_GREATWORK_YIELD');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('ELEANOR_DOUBLE_SCULPTURE_S6', 'GreatWorkObjectType', 'GREATWORKOBJECT_MUSIC');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('ELEANOR_DOUBLE_SCULPTURE_S6', 'YieldType', 'YIELD_SCIENCE');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('ELEANOR_DOUBLE_SCULPTURE_S6', 'YieldChange', '3');	


--匈牙利--
-- only 1 envoy from levying city-states units
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='LEVY_MILITARY_TWO_FREE_ENVOYS';
-- no combat bonus for levied units
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='RAVEN_LEVY_COMBAT' AND Name='Amount' AND Value='5';
-- Huszars only +2 combat strength from each alliance instead of 3
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='HUSZAR_ALLIES_COMBAT_BONUS';
-- Black Army only +2 combat strength from adjacent levied units
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='BLACK_ARMY_ADJACENT_LEVY';
-- Only 1 extra movement for levied units
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='RAVEN_LEVY_MOVEMENT';

---黑军
UPDATE Units SET Cost=230,BaseMoves=6 WHERE UnitType='UNIT_HUNGARY_BLACK_ARMY';
--骠骑兵
UPDATE Units SET Combat=68 WHERE UnitType='UNIT_HUNGARY_HUSZAR';

--渡鸦之王征兵折扣10%
UPDATE ModifierArguments SET Value='10' WHERE ModifierId='LEVY_UNITUPGRADEDISCOUNT' AND Name='Amount';



--需要帝国初期文化
INSERT INTO Requirements (RequirementId, RequirementType)
	VALUES ('REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_DGCQ', 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
	VALUES ('REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_DGCQ', 'CivicType', 'CIVIC_EARLY_EMPIRE');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	VALUES ('PLAYER_HAS_POLITICAL_PHILOSOPHY_DGCQ', 'REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_DGCQ');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
	VALUES ('PLAYER_HAS_POLITICAL_PHILOSOPHY_DGCQ', 'REQUIREMENTSET_TEST_ALL');

--需要国家劳动力文化
INSERT INTO Requirements (RequirementId, RequirementType)
	VALUES ('REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_ZY', 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
	VALUES ('REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_ZY', 'CivicType', 'CIVIC_STATE_WORKFORCE');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	VALUES ('PLAYER_HAS_POLITICAL_PHILOSOPHY_ZY', 'REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_ZY');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
	VALUES ('PLAYER_HAS_POLITICAL_PHILOSOPHY_ZY', 'REQUIREMENTSET_TEST_ALL');
	
--需要政治哲学文化
INSERT INTO Requirements (RequirementId, RequirementType)
	VALUES ('REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_Z', 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
	VALUES ('REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_Z', 'CivicType', 'CIVIC_POLITICAL_PHILOSOPHY');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	VALUES ('PLAYER_HAS_POLITICAL_PHILOSOPHY_Z', 'REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_Z');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
	VALUES ('PLAYER_HAS_POLITICAL_PHILOSOPHY_Z', 'REQUIREMENTSET_TEST_ALL');
	
--需要法典文化
INSERT INTO Requirements (RequirementId, RequirementType)
	VALUES ('REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_FD_maya', 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
	VALUES ('REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_FD_maya', 'CivicType', 'CIVIC_CODE_OF_LAWS');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	VALUES ('PLAYER_HAS_POLITICAL_PHILOSOPHY_FD_maya', 'REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_FD_maya');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
	VALUES ('PLAYER_HAS_POLITICAL_PHILOSOPHY_FD_maya', 'REQUIREMENTSET_TEST_ALL');

-- 祖鲁
--UU
UPDATE Units SET MandatoryObsoleteTech="TECH_BANKING" WHERE UnitType="UNIT_ZULU_IMPI";
--军团军队+0力
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='TRAIT_LAND_CORPS_COMBAT_STRENGTH' and Name='Amount';
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='TRAIT_LAND_ARMIES_COMBAT_STRENGTH' and Name='Amount';
--军队文化要求
UPDATE ModifierArguments SET Value='CIVIC_HUMANISM' WHERE ModifierId='TRAIT_LAND_CORPS_EARLY' and Name='CivicType';
UPDATE ModifierArguments SET Value='CIVIC_URBANIZATION' WHERE ModifierId='TRAIT_LAND_ARMIES_EARLY' and Name='CivicType';
--兵营+1文化
/*
INSERT INTO DistrictModifiers (DistrictType , ModifierId)
    VALUES ('DISTRICT_IKANDA' , 'DISTRICT_IKANDA_CULTURAL_YIELD' );
INSERT INTO Modifiers (ModifierId, ModifierType)
	VALUES ('DISTRICT_IKANDA_CULTURAL_YIELD', 'MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE');	
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('DISTRICT_IKANDA_CULTURAL_YIELD' , 'YieldType' , 'YIELD_CULTURE');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('DISTRICT_IKANDA_CULTURAL_YIELD' , 'Amount' , '1');
	
--兵营+1科技
INSERT INTO DistrictModifiers (DistrictType , ModifierId)
    VALUES ('DISTRICT_IKANDA' , 'DISTRICT_IKANDA_SCIENCE_YIELD' );
INSERT INTO Modifiers (ModifierId, ModifierType)
	VALUES ('DISTRICT_IKANDA_SCIENCE_YIELD', 'MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE');	
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('DISTRICT_IKANDA_SCIENCE_YIELD' , 'YieldType' , 'YIELD_SCIENCE');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('DISTRICT_IKANDA_SCIENCE_YIELD' , 'Amount' , '1');
	*/
--美国
Update ModifierArguments SET Value='3' Where ModifierId="ROOSEVELT_COMBAT_BONUS_HOME_CONTINENT" and Name="Amount";
Update ModifierArguments SET Value='2' Where ModifierId="ROUGH_RIDER_BONUS_ON_HILLS" and Name="Amount";
Update Units SET Cost=330,PrereqTech='TECH_MILITARY_SCIENCE',Combat=64 Where UnitType="UNIT_AMERICAN_ROUGH_RIDER";
--P51战斗力加成
Update ModifierArguments SET Value="2" Where ModifierId="ANTI_FIGHTER_AIRCRAFT_COMBAT_BONUS" and Name="Amount";
		
--法国
--新增科技判断 【判断军事学】 
--INSERT INTO RequirementArguments(RequirementId,Name,Value)
--VALUES("REQUIRES_TECH_MILITARY_SCIENCE2","TechnologyType","TECH_MILITARY_SCIENCE");
--INSERT INTO Requirements(RequirementId,RequirementType)
--VALUES("REQUIRES_TECH_MILITARY_SCIENCE2","REQUIREMENT_PLAYER_HAS_TECHNOLOGY");

--【科技判断军事学】 【全判断】 【判断军事学】
--INSERT INTO RequirementSetRequirements(RequirementSetId,RequirementId)
--VALUES("PLAYER_HAS_TECH_MILITARY_SCIENCE2","REQUIRES_TECH_MILITARY_SCIENCE2");
--INSERT INTO RequirementSets(RequirementSetId,RequirementSetType)
--VALUES("PLAYER_HAS_TECH_MILITARY_SCIENCE2","REQUIREMENTSET_TEST_ALL");

--将科技判断城堡 替换为 科技判断军事学
--UPDATE Modifiers SET SubjectRequirementSetId="PLAYER_HAS_TECH_MILITARY_SCIENCE2" WHERE ModifierId="UNIQUE_LEADER_ADD_SPY_CAPACITY" AND ModifierType="MODIFIER_PLAYER_GRANT_SPY";
--UPDATE RequirementSetRequirements SET RequirementId="REQUIRES_TECH_MILITARY_SCIENCE2" WHERE RequirementSetId="PLAYER_HAS_CASTLES_TECHNOLOGY_AND_CAPITAL" AND --RequirementId="REQUIRES_TECHNOLOGY_CASTLES";

	
	 
--苏美尔 闪闪
UPDATE Units SET Combat=30,Cost=65,MandatoryObsoleteTech="TECH_MILITARY_SCIENCE",PrereqTech="TECH_THE_WHEEL" WHERE UnitType='UNIT_SUMERIAN_WAR_CART';
--INSERT INTO Units_XP2 (ResourceMaintenanceAmount,ResourceCost,ResourceMaintenanceType,UnitType)
--	VALUES ('0','20','RESOURCE_IRON','UNIT_SUMERIAN_WAR_CART');
--移除掠夺 
DELETE FROM TraitModifiers WHERE TraitType="TRAIT_LEADER_ADVENTURES_ENKIDU" and ModifierId="TRAIT_ADJUST_JOINTWAR_PLUNDER";
--经验范围
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='TRAIT_ADJUST_JOINTWAR_EXPERIENCE' AND Name='Amount';

-- 斯基泰
UPDATE Units SET Cost=75,PrereqTech='TECH_HORSEBACK_RIDING',Combat=15,RangedCombat=25,BaseMoves=3 WHERE UnitType='UNIT_SCYTHIAN_HORSE_ARCHER';

UPDATE Improvement_YieldChanges SET YieldChange='1' WHERE ImprovementType='IMPROVEMENT_KURGAN' and YieldType='YIELD_GOLD';
UPDATE Improvement_YieldChanges SET YieldChange='1' WHERE ImprovementType='IMPROVEMENT_KURGAN' and YieldType='YIELD_FAITH';
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='TOMYRIS_BONUS_VS_WOUNDED_UNITS' and Name='Amount';	
UPDATE ModifierArguments SET Value='15' WHERE ModifierId='TOMYRIS_HEAL_AFTER_DEFEATING_UNIT' and Name='Amount';
--坟镦	
INSERT INTO Improvement_BonusYieldChanges (Id , ImprovementType , YieldType , BonusYieldChange , PrereqCivic)
	VALUES ('K204' , 'IMPROVEMENT_KURGAN' , 'YIELD_GOLD' , '1' , 'CIVIC_FEUDALISM');
INSERT INTO Improvement_BonusYieldChanges (Id , ImprovementType , YieldType , BonusYieldChange , PrereqCivic)
	VALUES ('K203' , 'IMPROVEMENT_KURGAN' , 'YIELD_FAITH' , '1' , 'CIVIC_FEUDALISM');
	-- Adjacent Pastures now give +1 production in addition to faith
/*INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_KURGAN' , 'KURGAN_PASTURE_PRODUCTION');
INSERT INTO Adjacency_YieldChanges (ID , Description , YieldType , YieldChange , TilesRequired , AdjacentImprovement)
	VALUES ('KURGAN_PASTURE_PRODUCTION' , 'Placeholder' , 'YIELD_PRODUCTION' , 1 , 1 , 'IMPROVEMENT_PASTURE');
INSERT INTO Improvement_YieldChanges (ImprovementType , YieldType , YieldChange)
	VALUES ('IMPROVEMENT_KURGAN' , 'YIELD_FOOD' , 0);
*/INSERT INTO Improvement_YieldChanges (ImprovementType , YieldType , YieldChange)
	VALUES ('IMPROVEMENT_KURGAN' , 'YIELD_PRODUCTION' , 1);
INSERT INTO Improvement_BonusYieldChanges (Id , ImprovementType , YieldType , BonusYieldChange , PrereqCivic)
	VALUES ('IMPROVEMENT_KURGAN_1' , 'IMPROVEMENT_KURGAN' , 'YIELD_PRODUCTION' , '1' , 'CIVIC_NATIONALISM');
/*INSERT INTO Improvement_BonusYieldChanges (Id , ImprovementType , YieldType , BonusYieldChange , PrereqCivic)
	VALUES ('IMPROVEMENT_KURGAN_2' , 'IMPROVEMENT_KURGAN' , 'YIELD_GOLD' , '1' , 'CIVIC_NATIONALISM');	
INSERT INTO Improvement_BonusYieldChanges (Id , ImprovementType , YieldType , BonusYieldChange , PrereqCivic)
	VALUES ('IMPROVEMENT_KURGAN_3' , 'IMPROVEMENT_KURGAN' , 'YIELD_FOOD' , '0' , 'CIVIC_DIVINE_RIGHT');	
*/INSERT INTO Improvement_ValidTerrains (ImprovementType, TerrainType)
	VALUES ('IMPROVEMENT_KURGAN' , 'TERRAIN_GRASS_HILLS');
INSERT INTO Improvement_ValidTerrains (ImprovementType, TerrainType)
	VALUES ('IMPROVEMENT_KURGAN' , 'TERRAIN_PLAINS_HILLS');	
--信仰买骑兵
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='TRAIT_EXTRASAKAHORSEARCHER' and NAME='Amount';
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='TRAIT_EXTRALIGHTCAVALRY' and NAME='Amount';
--DELETE FROM CivilizationTraits WHERE CivilizationType='CIVILIZATION_SCYTHIA' and TraitType='TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY';
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY' , 'SCYTHIA_FAITH_PURCHASE_LCAVALRY_CPLMOD');
--INSERT INTO TraitModifiers (TraitType , ModifierId)
--	VALUES ('TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY' , 'SCYTHIA_FAITH_PURCHASE_HCAVALRY_CPLMOD');
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY' , 'SCYTHIA_FAITH_PURCHASE_RCAVALRY_CPLMOD');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('SCYTHIA_FAITH_PURCHASE_LCAVALRY_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('SCYTHIA_FAITH_PURCHASE_HCAVALRY_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('SCYTHIA_FAITH_PURCHASE_RCAVALRY_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SCYTHIA_FAITH_PURCHASE_LCAVALRY_CPLMOD' , 'Tag' , 'CLASS_LIGHT_CAVALRY'); 
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SCYTHIA_FAITH_PURCHASE_HCAVALRY_CPLMOD' , 'Tag' , 'CLASS_HEAVY_CAVALRY');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SCYTHIA_FAITH_PURCHASE_RCAVALRY_CPLMOD' , 'Tag' , 'CLASS_RANGED_CAVALRY'); 	

--砍二
--INSERT INTO Building_YieldChanges (BuildingType , YieldType , YieldChange)
--	VALUES ('BUILDING_TLACHTLI' , 'YIELD_CULTURE' , '1'); 
--UPDATE Building_YieldChanges SET YieldType="YIELD_CULTURE",YieldChange="1" WHERE BuildingType="BUILDING_TLACHTLI" and YieldType="YIELD_FAITH";
--UPDATE Buildings SET RegionalRange="6",Description="LOC_BUILDING_ZOO_DESCRIPTION3",Cost="65",Entertainment="1" WHERE BuildingType="BUILDING_TLACHTLI";
UPDATE Buildings SET Cost="50" WHERE BuildingType="BUILDING_TLACHTLI";
Update Building_GreatPersonPoints SET PointsPerTurn="2" WHERE BuildingType="BUILDING_TLACHTLI" AND GreatPersonClassType="GREAT_PERSON_CLASS_GENERAL";
Update Building_YieldChanges SET YieldChange="3" WHERE BuildingType='BUILDING_TLACHTLI' and YieldType="YIELD_CULTURE";
--
Update Units Set Cost="45",Combat="23"  Where UnitType="UNIT_AZTEC_EAGLE_WARRIOR";
--区域速度
Update ModifierArguments Set Value="20" Where ModifierId="TRAIT_BUILDER_DISTRICT_PERCENT" and Name="Amount";
--努比亚
-- 努比亚UI可以草原平原修建
INSERT INTO Improvement_ValidTerrains (ImprovementType, TerrainType)
	VALUES ('IMPROVEMENT_PYRAMID' , 'TERRAIN_PLAINS');
INSERT INTO Improvement_ValidTerrains (ImprovementType, TerrainType)
	VALUES ('IMPROVEMENT_PYRAMID' , 'TERRAIN_GRASS');
INSERT INTO Improvement_ValidTerrains (ImprovementType, TerrainType)
	VALUES ('IMPROVEMENT_PYRAMID' , 'TERRAIN_GRASS_HILLS');
INSERT INTO Improvement_ValidTerrains (ImprovementType, TerrainType)
	VALUES ('IMPROVEMENT_PYRAMID' , 'TERRAIN_PLAINS_HILLS');
INSERT INTO Improvement_ValidFeatures (ImprovementType, FeatureType)
	VALUES ('IMPROVEMENT_PYRAMID' , 'FEATURE_FLOODPLAINS_PLAINS');
INSERT INTO Improvement_ValidFeatures (ImprovementType, FeatureType)
	VALUES ('IMPROVEMENT_PYRAMID' , 'FEATURE_FLOODPLAINS_GRASSLAND');
--
UPDATE Improvements SET SameAdjacentValid=0 WHERE ImprovementType='IMPROVEMENT_PYRAMID';
UPDATE Improvement_YieldChanges SET YieldChange='1' WHERE ImprovementType='IMPROVEMENT_PYRAMID' and YieldType='YIELD_FOOD';
--
--INSERT INTO Improvement_BonusYieldChanges(Id, ImprovementType, YieldType, BonusYieldChange, PrereqCivic)
--	VALUES ('IMPROVEMENT_PYRAMID_1', 'IMPROVEMENT_PYRAMID', 'YIELD_FOOD', 0, 'CIVIC_CODE_OF_LAWS');
-- 努比亚UI相邻+2
UPDATE Adjacency_YieldChanges SET YieldChange=1 WHERE ID="Pyramid_CityCenterAdjacency";
UPDATE Adjacency_YieldChanges SET YieldChange=2 WHERE ID="Pyramid_CampusAdjacency";
UPDATE Adjacency_YieldChanges SET YieldChange=2 WHERE ID="Pyramid_CommercialHubAdjacency";
UPDATE Adjacency_YieldChanges SET YieldChange=2 WHERE ID="Pyramid_HarborAdjacency";
UPDATE Adjacency_YieldChanges SET YieldChange=2 WHERE ID="Pyramid_HolySiteAdjacency";
UPDATE Adjacency_YieldChanges SET YieldChange=2 WHERE ID="Pyramid_IndustrialZoneAdjacency";
UPDATE Adjacency_YieldChanges SET YieldChange=2 WHERE ID="Pyramid_TheaterAdjacency";
-- 努比亚弓箭手
UPDATE Units SET Combat=15,RangedCombat=23,Cost=60 WHERE UnitType='UNIT_NUBIAN_PITATI';

UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_ANCIENT_RANGED_UNIT_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_CLASSICAL_RANGED_UNIT_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_MEDIEVAL_RANGED_UNIT_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_RENAISSANCE_RANGED_UNIT_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_INDUSTRIAL_RANGED_UNIT_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_MODERN_RANGED_UNIT_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_ATOMIC_RANGED_UNIT_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_INFORMATION_RANGED_UNIT_PRODUCTION' and Name='Amount';
--经验
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='TRAIT_RANGED_EXPERIENCE_MODIFIER' and Name='Amount';
--区域速度
UPDATE ModifierArguments SET Value='20' WHERE ModifierId='TRAIT_BASE_DISTRICT_PRODUCTION_MODIFIER' and Name='Amount';
UPDATE ModifierArguments SET Value='10' WHERE ModifierId='TRAIT_PYRAMID_DISTRICT_PRODUCTION_MODIFIER' and Name='Amount';


--西班牙
-- 传教团移至王权
UPDATE Units SET Cost=240,BaseMoves=3 WHERE UnitType='UNIT_SPANISH_CONQUISTADOR';

-- 极光之舞 +0.5faith per tundar terrian
--UPDATE ModifierArguments SET Value="0" where ModifierId="DANCE_OF_THE_AURORA_FAITHTUNDRAADJACENCY" and Name="Amount";
--UPDATE ModifierArguments SET Value="0" where ModifierId="DANCE_OF_THE_AURORA_FAITHTUNDRAHILLSADJACENCY" and Name="Amount";
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('DANCE_OF_THE_AURORA_FAITHTUNDRAADJACENCY', 'TilesRequired',2);
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('DANCE_OF_THE_AURORA_FAITHTUNDRAHILLSADJACENCY', 'TilesRequired',2);
--沙漠
--UPDATE ModifierArguments SET Value="0" where ModifierId="DESERT_FOLKLORE_FAITHDESERTADJACENCY" and Name="Amount";
--UPDATE ModifierArguments SET Value="0" where ModifierId="DESERT_FOLKLORE_FAITHDESERTHILLSADJACENCY" and Name="Amount";
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('DESERT_FOLKLORE_FAITHDESERTADJACENCY', 'TilesRequired',2);
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('DESERT_FOLKLORE_FAITHDESERTHILLSADJACENCY', 'TilesRequired',2);

--沙漠平原给金
INSERT INTO BeliefModifiers(BeliefType,ModifierId)
        VALUES("BELIEF_DESERT_FOLKLORE","DESERT_FOLKLORE_FAITHDESERTADJACENCY_GOLD");	
INSERT INTO Modifiers(ModifierId,ModifierType,SubjectRequirementSetId)
        VALUES("DESERT_FOLKLORE_FAITHDESERTADJACENCY_GOLD","MODIFIER_ALL_CITIES_TERRAIN_ADJACENCY","CITY_FOLLOWS_PANTHEON_REQUIREMENTS");
INSERT INTO ModifierArguments(ModifierId,Name,Value)
        VALUES("DESERT_FOLKLORE_FAITHDESERTADJACENCY_GOLD","DistrictType","DISTRICT_HOLY_SITE");
INSERT INTO ModifierArguments(ModifierId,Name,Value)
        VALUES("DESERT_FOLKLORE_FAITHDESERTADJACENCY_GOLD","TerrainType","TERRAIN_DESERT");
INSERT INTO ModifierArguments(ModifierId,Name,Value)
        VALUES("DESERT_FOLKLORE_FAITHDESERTADJACENCY_GOLD","YieldType","YIELD_GOLD");
INSERT INTO ModifierArguments(ModifierId,Name,Value)
        VALUES("DESERT_FOLKLORE_FAITHDESERTADJACENCY_GOLD","Amount","1");
INSERT INTO ModifierArguments(ModifierId,Name,Value)
        VALUES("DESERT_FOLKLORE_FAITHDESERTADJACENCY_GOLD","Description","LOC_DISTRICT_DESERT_FAITH");		
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	    VALUES ('DESERT_FOLKLORE_FAITHDESERTADJACENCY_GOLD', 'TilesRequired',2);

--沙漠丘陵给金
INSERT INTO BeliefModifiers(BeliefType,ModifierId)
        VALUES("BELIEF_DESERT_FOLKLORE","DESERT_FOLKLORE_FAITHDESERTHILLSADJACENCY_GOLD");	
INSERT INTO Modifiers(ModifierId,ModifierType,SubjectRequirementSetId)
        VALUES("DESERT_FOLKLORE_FAITHDESERTHILLSADJACENCY_GOLD","MODIFIER_ALL_CITIES_TERRAIN_ADJACENCY","CITY_FOLLOWS_PANTHEON_REQUIREMENTS");
INSERT INTO ModifierArguments(ModifierId,Name,Value)
        VALUES("DESERT_FOLKLORE_FAITHDESERTHILLSADJACENCY_GOLD","DistrictType","DISTRICT_HOLY_SITE");
INSERT INTO ModifierArguments(ModifierId,Name,Value)
        VALUES("DESERT_FOLKLORE_FAITHDESERTHILLSADJACENCY_GOLD","TerrainType","TERRAIN_DESERT_HILLS");		
INSERT INTO ModifierArguments(ModifierId,Name,Value)
        VALUES("DESERT_FOLKLORE_FAITHDESERTHILLSADJACENCY_GOLD","YieldType","YIELD_GOLD");
INSERT INTO ModifierArguments(ModifierId,Name,Value)
        VALUES("DESERT_FOLKLORE_FAITHDESERTHILLSADJACENCY_GOLD","Amount","1");
INSERT INTO ModifierArguments(ModifierId,Name,Value)
        VALUES("DESERT_FOLKLORE_FAITHDESERTHILLSADJACENCY_GOLD","Description","LOC_DISTRICT_DESERT_FAITH");		
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	    VALUES ('DESERT_FOLKLORE_FAITHDESERTHILLSADJACENCY_GOLD', 'TilesRequired',2);

--神圣	
--INSERT INTO ModifierArguments(ModifierId , Name, Value)
	--VALUES ('SACRED_PATH_FAITHFEATUREADJACENCY', 'TilesRequired',2);
	
-- 牛+1产能,马,羊+食物
INSERT INTO Types(Type, Kind)
	VALUES ('BELIEF_SHIPHERDER_PATH', 'KIND_BELIEF');
INSERT INTO Beliefs(BeliefType, Name, Description, BeliefClassType)
	VALUES ('BELIEF_SHIPHERDER_PATH', 'LOC_BELIEF_SHIPHERDER_PATH_NAME', 'LOC_BELIEF_SHIPHERDER_PATH_DESCRIPTION', 'BELIEF_CLASS_PANTHEON');
INSERT INTO BeliefModifiers(BeliefType , ModifierId)
	VALUES ('BELIEF_SHIPHERDER_PATH', 'SHIPHERDER_PATH_PASTURE_FOOD');
INSERT INTO BeliefModifiers(BeliefType , ModifierId)
	VALUES ('BELIEF_SHIPHERDER_PATH', 'SHIPHERDER_PATH_PASTURE_PRODUCTION');
	
INSERT INTO BeliefModifiers(BeliefType , ModifierId)
	VALUES ('BELIEF_SHIPHERDER_PATH', 'SHIPHERDER_PATH_PASTURE_GOLD');
	--
	
INSERT INTO Modifiers(ModifierId , ModifierType, SubjectRequirementSetId)
	VALUES ('SHIPHERDER_PATH_PASTURE_FOOD', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS');
INSERT INTO Modifiers(ModifierId , ModifierType, SubjectRequirementSetId)
	VALUES ('SHIPHERDER_PATH_PASTURE_PRODUCTION', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS');
	
INSERT INTO Modifiers(ModifierId , ModifierType, SubjectRequirementSetId)
	VALUES ('SHIPHERDER_PATH_PASTURE_GOLD', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS');
	
	--
INSERT INTO Modifiers(ModifierId , ModifierType, SubjectRequirementSetId)
	VALUES ('SHIPHERDER_PATH_PASTURE_PRODUCTION_MODIFIER', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_MUCHANG_REQUIREMENTS');
INSERT INTO Modifiers(ModifierId , ModifierType, SubjectRequirementSetId)
	VALUES ('SHIPHERDER_PATH_PASTURE_FOOD_MODIFIER', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_MAYANG_REQUIREMENTS');
INSERT INTO Modifiers(ModifierId , ModifierType, SubjectRequirementSetId)
	VALUES ('SHIPHERDER_PATH_PASTURE_GOLD_MODIFIER', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_MAYANG_REQUIREMENTS');
	
--牛 马 羊 牧场
INSERT INTO RequirementSets(RequirementSetId , RequirementSetType)
	VALUES ('PLOT_HAS_MAYANG_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId)
	VALUES ('PLOT_HAS_MAYANG_REQUIREMENTS', 'REQUIRES_PLOT_HAS_PASTURE');	
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId)
	VALUES ('PLOT_HAS_MAYANG_REQUIREMENTS', 'REQUIRES_PLOT_HAS_MAYANG');
--
/*
INSERT INTO RequirementSets(RequirementSetId , RequirementSetType)
	VALUES ('PLOT_HAS_NOT_NIU_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId)
	VALUES ('PLOT_HAS_NOT_NIU_REQUIREMENTS', 'REQUIRES_PLOT_HAS_PASTURE');	
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId)
	VALUES ('PLOT_HAS_NOT_NIU_REQUIREMENTS', 'REQUIRES_PLOT_HAS_MAYANG');	
	*/
--
INSERT INTO RequirementSets(RequirementSetId , RequirementSetType)
	VALUES ('PLOT_HAS_MUCHANG_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId)
	VALUES ('PLOT_HAS_MUCHANG_REQUIREMENTS', 'REQUIRES_PLOT_HAS_PASTURE');	
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId)
	VALUES ('PLOT_HAS_MUCHANG_REQUIREMENTS', 'REQUIRES_PLOT_HAS_MUCHANG');
INSERT INTO RequirementArguments(RequirementId , Name, Value)
	VALUES ('REQUIRES_PLOT_HAS_MUCHANG', 'Tag', 'CLASS_MUCHANG');
INSERT INTO Tags(Tag , Vocabulary)
	VALUES ('CLASS_MUCHANG', 'RESOURCE_CLASS');	
INSERT INTO TypeTags(Type , Tag)
	VALUES ('RESOURCE_SHEEP', 'CLASS_MUCHANG');		
INSERT INTO Requirements(RequirementId , RequirementType)
	VALUES ('REQUIRES_PLOT_HAS_MUCHANG', 'REQUIREMENT_PLOT_RESOURCE_TAG_MATCHES');
INSERT INTO RequirementArguments(RequirementId , Name, Value)
	VALUES ('REQUIRES_PLOT_HAS_MAYANG', 'Tag', 'CLASS_MAYANG');
--
INSERT INTO Tags(Tag , Vocabulary)
	VALUES ('CLASS_MAYANG', 'RESOURCE_CLASS');	
INSERT INTO TypeTags(Type , Tag)
	VALUES ('RESOURCE_HORSES', 'CLASS_MAYANG');	
INSERT INTO TypeTags(Type , Tag)
	VALUES ('RESOURCE_SHEEP', 'CLASS_MAYANG');		
INSERT INTO TypeTags(Type , Tag)
	VALUES ('RESOURCE_CATTLE', 'CLASS_MAYANG');
--
/*
INSERT INTO Tags(Tag , Vocabulary)
	VALUES ('CLASS_NOT_NIU', 'RESOURCE_CLASS');	
INSERT INTO TypeTags(Type , Tag)
	VALUES ('RESOURCE_HORSES', 'CLASS_NOT_NIU');	
INSERT INTO TypeTags(Type , Tag)
	VALUES ('RESOURCE_SHEEP', 'CLASS_NOT_NIU');		
	*/
--
INSERT INTO Requirements(RequirementId , RequirementType)
	VALUES ('REQUIRES_PLOT_HAS_MAYANG', 'REQUIREMENT_PLOT_RESOURCE_TAG_MATCHES');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('SHIPHERDER_PATH_PASTURE_FOOD', 'ModifierId','SHIPHERDER_PATH_PASTURE_FOOD_MODIFIER');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('SHIPHERDER_PATH_PASTURE_FOOD_MODIFIER', 'YieldType','YIELD_FOOD');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('SHIPHERDER_PATH_PASTURE_FOOD_MODIFIER', 'Amount', 1);	
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('SHIPHERDER_PATH_PASTURE_PRODUCTION', 'ModifierId','SHIPHERDER_PATH_PASTURE_PRODUCTION_MODIFIER');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('SHIPHERDER_PATH_PASTURE_PRODUCTION_MODIFIER', 'YieldType','YIELD_GOLD');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('SHIPHERDER_PATH_PASTURE_PRODUCTION_MODIFIER', 'Amount', -1);
--牧民金币
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('SHIPHERDER_PATH_PASTURE_GOLD', 'ModifierId','SHIPHERDER_PATH_PASTURE_GOLD_MODIFIER');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('SHIPHERDER_PATH_PASTURE_GOLD_MODIFIER', 'YieldType','YIELD_GOLD');
INSERT INTO ModifierArguments(ModifierId , Name, Value)
	VALUES ('SHIPHERDER_PATH_PASTURE_GOLD_MODIFIER', 'Amount', 1);
	
-- 火山
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='GODDESS_OF_FIRE_FEATURES_FAITH_MODIFIER' AND Name='Amount';

--巨人之矛
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='SPEAR_OF_FIONN_ADJUST_COMBAT_STRENGTH' and Name='Amount';	

--黄金国
UPDATE Feature_AdjacentYields SET YieldChange='1' WHERE FeatureType='FEATURE_PAITITI' and YieldType='YIELD_GOLD';
UPDATE Feature_AdjacentYields SET YieldChange='1' WHERE FeatureType='FEATURE_PAITITI' and YieldType='YIELD_CULTURE';

--张掖丹霞
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='GREAT_GENERAL_ZHANGYE' and Name='Amount';	
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='GREAT_MERCHANT_ZHANGYE' and Name='Amount';	

--白沙漠
UPDATE Feature_YieldChanges SET YieldChange='2' WHERE FeatureType='FEATURE_WHITEDESERT'    AND YieldType='YIELD_CULTURE'   ;
UPDATE Feature_YieldChanges SET YieldChange='2' WHERE FeatureType='FEATURE_WHITEDESERT'    AND YieldType='YIELD_SCIENCE'   ;

	
--总督 
UPDATE Governors SET TransitionStrength="150" WHERE GovernorType="GOVERNOR_THE_RESOURCE_MANAGER";
UPDATE Governors SET TransitionStrength="150" WHERE GovernorType="GOVERNOR_THE_BUILDER";
UPDATE Governors SET TransitionStrength="150" WHERE GovernorType="GOVERNOR_THE_AMBASSADOR";

--伐木工
UPDATE ModifierArguments SET Value="50" WHERE ModifierId="GROUNDBREAKER_BONUS_HARVEST_YIELDS" AND Name="Amount";
--梁
UPDATE ModifierArguments SET Value="45" WHERE ModifierId="ZONING_COMMISSIONER_FASTER_DISTRICT_CONSTRUCTION" AND Name="Amount";
--大主教
--右1 圣地翻倍信仰

INSERT INTO GovernorPromotionModifiers (GovernorPromotionType,ModifierId)
	VALUES ('GOVERNOR_PROMOTION_CARDINAL_LAYING_ON_OF_HANDS','CARDINAL_BONUS_HOLY_SITE_ADJACENCY');
INSERT INTO Modifiers (ModifierId,ModifierType,SubjectRequirementSetId)
	VALUES ('CARDINAL_BONUS_HOLY_SITE_ADJACENCY','MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_MODIFIER','DISTRICT_IS_HOLY_SITE');
INSERT INTO ModifierArguments (ModifierId,Name,Value)
	VALUES ('CARDINAL_BONUS_HOLY_SITE_ADJACENCY','YieldType','YIELD_FAITH');
INSERT INTO ModifierArguments (ModifierId,Name,Value)
	VALUES ('CARDINAL_BONUS_HOLY_SITE_ADJACENCY','Amount','100');
	
--左1人口+1信仰

DELETE FROM GovernorPromotionModifiers WHERE GovernorPromotionType="GOVERNOR_PROMOTION_CARDINAL_GRAND_INQUISITOR" and ModifierId="CARDINAL_GRAND_INQUISITOR_COMBAT";
INSERT INTO GovernorPromotionModifiers (GovernorPromotionType,ModifierId)
	VALUES ('GOVERNOR_PROMOTION_CARDINAL_GRAND_INQUISITOR','CONNOISSEUR_F_CITIZEN');
INSERT INTO Modifiers (ModifierId,ModifierType)
	VALUES ('CONNOISSEUR_F_CITIZEN','MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION');
INSERT INTO ModifierArguments (ModifierId,Name,Value)
	VALUES ('CONNOISSEUR_F_CITIZEN','YieldType','YIELD_FAITH');
INSERT INTO ModifierArguments (ModifierId,Name,Value)
	VALUES ('CONNOISSEUR_F_CITIZEN','Amount','1.3');
	
--中2
--25%

INSERT INTO GovernorPromotionModifiers (GovernorPromotionType,ModifierId)
	VALUES ('GOVERNOR_PROMOTION_CARDINAL_CITADEL_OF_GOD','CARDINAL_HOLY_SITE_TEAMPVP');
INSERT INTO Modifiers (ModifierId,ModifierType)
	VALUES ('CARDINAL_HOLY_SITE_TEAMPVP','MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER');
INSERT INTO ModifierArguments (ModifierId,Name,Value)
	VALUES ('CARDINAL_HOLY_SITE_TEAMPVP','YieldType','YIELD_FAITH');
INSERT INTO ModifierArguments (ModifierId,Name,Value)
	VALUES ('CARDINAL_HOLY_SITE_TEAMPVP','Amount','10');

INSERT INTO GovernorPromotionModifiers (GovernorPromotionType,ModifierId)
	VALUES ('GOVERNOR_PROMOTION_CARDINAL_CITADEL_OF_GOD','CARDINAL_HOLY_SITE_2_TEAMPVP');
INSERT INTO Modifiers (ModifierId,ModifierType)
	VALUES ('CARDINAL_HOLY_SITE_2_TEAMPVP','MODIFIER_SINGLE_CITY_ADJUST_YIELD_CHANGE');
INSERT INTO ModifierArguments (ModifierId,Name,Value)
	VALUES ('CARDINAL_HOLY_SITE_2_TEAMPVP','YieldType','YIELD_FAITH');
INSERT INTO ModifierArguments (ModifierId,Name,Value)
	VALUES ('CARDINAL_HOLY_SITE_2_TEAMPVP','Amount','4');

UPDATE ModifierArguments SET Value="55" WHERE ModifierId="CARDINAL_CITADEL_OF_GOD_FAITH_FINISH_BUILDINGS" AND Name="BuildingProductionPercent";

--关联

--加拿大
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_CANADA' AND TerrainType='TERRAIN_TUNDRA';
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_CANADA' AND TerrainType='TERRAIN_TUNDRA_HILLS';
--俄罗斯--
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_RUSSIA' AND TerrainType='TERRAIN_TUNDRA';
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_RUSSIA' AND TerrainType='TERRAIN_TUNDRA_HILLS';
--挪威--海边
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_NORWAY' AND TerrainType='TERRAIN_COAST';
--英国--海边
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_ENGLAND' AND TerrainType='TERRAIN_COAST';
--荷兰
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_NETHERLANDS' AND TerrainType='TERRAIN_COAST';
--澳大利亚
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_AUSTRALIA' AND TerrainType='TERRAIN_COAST';
--腓尼基
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_PHOENICIA' AND TerrainType='TERRAIN_COAST';
--日本
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_JAPAN' AND TerrainType='TERRAIN_COAST';
--印度尼西亚
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_INDONESIA' AND TerrainType='TERRAIN_COAST';

--英国--煤
--INSERT INTO StartBiasResources (CivilizationType,ResourceType,Tier)
--	VALUES ('CIVILIZATION_ENGLAND','RESOURCE_COAL','1');
--迦太基--
UPDATE StartBiasTerrains SET Tier='1' WHERE CivilizationType='CIVILIZATION_PHOENICIA' AND TerrainType='TERRAIN_COAST';
--努比亚--关联羊
UPDATE StartBiasResources SET Tier='1' WHERE CivilizationType='CIVILIZATION_NUBIA' AND ResourceType='RESOURCE_CATTLE';
--日本--海边
--INSERT INTO StartBiasTerrains (CivilizationType,TerrainType,Tier)
--	VALUES ('CIVILIZATION_JAPAN','TERRAIN_COAST','1');
--INSERT INTO StartBiasRivers (CivilizationType,Tier)
--	VALUES ('CIVILIZATION_JAPAN',"1");
--德国--河流
--INSERT INTO StartBiasRivers (CivilizationType,Tier)
--	VALUES ('CIVILIZATION_GERMANY',"1");
--斯基泰--牧场
INSERT INTO StartBiasResources (CivilizationType , ResourceType , Tier)
	VALUES
	('CIVILIZATION_SCYTHIA' , 'RESOURCE_SHEEP'  , 1),
	('CIVILIZATION_SCYTHIA' , 'RESOURCE_CATTLE' , 1);
--澳大利亚
UPDATE StartBiasResources SET Tier='1' WHERE CivilizationType='CIVILIZATION_AUSTRALIA' AND ResourceType='RESOURCE_CATTLE';
UPDATE StartBiasResources SET Tier='1' WHERE CivilizationType='CIVILIZATION_AUSTRALIA' AND ResourceType='RESOURCE_HORSES';
UPDATE StartBiasResources SET Tier='1' WHERE CivilizationType='CIVILIZATION_AUSTRALIA' AND ResourceType='RESOURCE_SHEEP';
--加拿大
INSERT INTO StartBiasResources (CivilizationType , ResourceType , Tier)
	VALUES
	('CIVILIZATION_CANADA' , 'RESOURCE_DEER'  , 1);


--波斯
--UPDATE ModifierArguments SET VALUE="3" WHERE  ModifierId="TRAIT_SATRAPIES_INTERNAL_TRADE_GOLD" AND Name="Amount";
--宣战加速
UPDATE ModifierArguments SET VALUE="6" WHERE  ModifierId="TRAIT_FALLBABYLON_SURPRISE_MOVEMENT" AND Name="TurnsActive";
UPDATE ModifierArguments SET VALUE="1" WHERE  ModifierId="TRAIT_FALLBABYLON_SURPRISE_MOVEMENT" AND Name="Amount";
--职业道德
--DELETE From BeliefModifiers WHERE ModifierId='WORK_ETHIC_FOLLOWER_PRODUCTION';
DELETE From BeliefModifiers WHERE ModifierId='WORK_ETHIC_ADJACENCY_PRODUCTION_2';

INSERT INTO Modifiers 
	(ModifierId                              , ModifierType                          , SubjectRequirementSetId)
	VALUES 
	('WORK_ETHIC_SHRINE_PRODUCTION'          , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER' , 'CITY_FOLLOWS_RELIGION_HAS_SHRINE'),--<
	('WORK_ETHIC_TEMPLE_PRODUCTION'          , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER' , 'CITY_FOLLOWS_RELIGION_HAS_TEMPLE'),
	('WORK_ETHIC_SHRINE_PRODUCTION_MODIFIER' , 'MODIFIER_BUILDING_YIELD_CHANGE'      , null                              ),--<
	('WORK_ETHIC_TEMPLE_PRODUCTION_MODIFIER' , 'MODIFIER_BUILDING_YIELD_CHANGE'      , null                              );
INSERT INTO ModifierArguments 
	(ModifierId                              , Name           , Value)
	VALUES 
	('WORK_ETHIC_SHRINE_PRODUCTION'          , 'ModifierId'   , 'WORK_ETHIC_SHRINE_PRODUCTION_MODIFIER'),--<
	('WORK_ETHIC_TEMPLE_PRODUCTION'          , 'ModifierId'   , 'WORK_ETHIC_TEMPLE_PRODUCTION_MODIFIER'),
	('WORK_ETHIC_SHRINE_PRODUCTION_MODIFIER' , 'BuildingType' , 'BUILDING_SHRINE'                      ),--<
	('WORK_ETHIC_SHRINE_PRODUCTION_MODIFIER' , 'YieldType'    , 'YIELD_PRODUCTION'                     ),
	('WORK_ETHIC_SHRINE_PRODUCTION_MODIFIER' , 'Amount'       , '2'                                    ),
	('WORK_ETHIC_TEMPLE_PRODUCTION_MODIFIER' , 'BuildingType' , 'BUILDING_TEMPLE'                      ),--<
	('WORK_ETHIC_TEMPLE_PRODUCTION_MODIFIER' , 'YieldType'    , 'YIELD_PRODUCTION'                     ),
	('WORK_ETHIC_TEMPLE_PRODUCTION_MODIFIER' , 'Amount'       , '3'                                    );
INSERT INTO BeliefModifiers 
	(BeliefType          , ModifierId)
	VALUES 
	('BELIEF_WORK_ETHIC' , 'WORK_ETHIC_TEMPLE_PRODUCTION'),
	('BELIEF_WORK_ETHIC' , 'WORK_ETHIC_SHRINE_PRODUCTION');

--哺育世界
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='FEED_THE_WORLD_SHRINE_FOOD3_MODIFIER' AND Name='Amount';
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='FEED_THE_WORLD_SHRINE_HOUSING_MODIFIER' AND Name='Amount';
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='FEED_THE_WORLD_TEMPLE_HOUSING_MODIFIER' AND Name='Amount';
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='FEED_THE_WORLD_TEMPLE_FOOD3_MODIFIER' AND Name='Amount';
	

--宗教社区
UPDATE ModifierArguments SET Value="1" WHERE ModifierId='RELIGIOUS_COMMUNITY_HOLY_SITE_TRADING_MODIFIER' AND Name='Amount';	
--UPDATE ModifierArguments SET Value="1" WHERE ModifierId='RELIGIOUS_COMMUNITY_TIER3_TRADING_MODIFIER' AND Name='Amount';


--毛利游泳加速
--UPDATE Modifiers SET SubjectRequirementSetId="UNIT_IS_SETTLER" WHERE ModifierId="MANA_EMBARKED_EXTRA_MOVEMENT" and ModifierType="MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT"
--and OwnerRequirementSetId="REQUIREMENTS_UNIT_IS_EMBARKED";
--开拓者、工人船上4移动
--UPDATE ModifierArguments SET Value='4' WHERE ModifierId='MANA_EMBARKED_EXTRA_MOVEMENT' AND Name='Amount';


--新老美 美国 进步党
UPDATE RequirementArguments SET Value='2' WHERE RequirementId='REQUIRES_PLOT_BREATHTAKING_APPEAL_ROOSEVELT' AND Name='MinimumAppeal';	
UPDATE ModifierArguments SET Value='YIELD_GOLD' WHERE ModifierId='TRAIT_ANTIQUES_AND_PARKS_CULTURE_FORESTS_OR_WONDERS' AND Name='YieldType';
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='TRAIT_ANTIQUES_AND_PARKS_CULTURE_FORESTS_OR_WONDERS' AND Name='Amount';
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='TRAIT_ANTIQUES_AND_PARKS_SCIENCE_NATIONAL_WONDERS_OR_MOUNTAINS' AND Name='Amount';

--政治哲学解锁+科技
UPDATE Modifiers SET OwnerRequirementSetId='PLAYER_HAS_POLITICAL_PHILOSOPHY_Z' WHERE ModifierId='TRAIT_ANTIQUES_AND_PARKS_SCIENCE_NATIONAL_WONDERS_OR_MOUNTAINS';


--ULK尤里卡
--UPDATE Boosts SET BoostClass='BOOST_TRIGGER_KILL_WITH',Unit1Type="UNIT_WARRIOR",NumItems="1" Where TechnologyType='TECH_BRONZE_WORKING';
UPDATE Boosts SET BoostClass='BOOST_TRIGGER_OWN_X_UNITS_OF_TYPE',Unit1Type="UNIT_SPEARMAN",NumItems="2" Where TechnologyType='TECH_MILITARY_TACTICS';
--UPDATE Boosts SET BoostClass='BOOST_TRIGGER_RESEARCH_TECH',BoostingTechType="TECH_HORSEBACK_RIDING" Where CivicType='CIVIC_MILITARY_TRADITION';
UPDATE Boosts SET BoostClass='BOOST_TRIGGER_OWN_X_UNITS_OF_TYPE',Unit1Type="UNIT_QUADRIREME",NumItems="2" Where CivicType='CIVIC_NAVAL_TRADITION';

--宣战不检票
UPDATE GlobalParameters SET Value='0' WHERE Name='FAVOR_GRIEVANCES_MINIMUM';

--沼泽夫人
--DELETE FROM RequirementSetRequirements WHERE RequirementSetId="PLOT_HAS_REEDS_REQUIREMENTS" AND RequirementId="REQUIRES_PLOT_HAS_FLOODPLAINS";

--弓箭庙
--UPDATE Buildings SET Cost=210 WHERE BuildingType='BUILDING_TEMPLE_ARTEMIS';
UPDATE Building_YieldChanges SET YieldChange="2" WHERE BuildingType="BUILDING_TEMPLE_ARTEMIS" and YieldType="YIELD_FOOD";

-- Venetian Arsenal gives 100% production boost to all naval units in all cities instead of an extra naval unit in its city each time you build one
DELETE FROM BuildingModifiers WHERE	BuildingType='BUILDING_VENETIAN_ARSENAL';

INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ANCIENT_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ANCIENT');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ATOMIC_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ATOMIC');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('CLASSICAL_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_CLASSICAL');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INDUSTRIAL_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INDUSTRIAL');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INFORMATION_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INFORMATION');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MEDIEVAL_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MEDIEVAL');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MODERN_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MODERN');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('RENAISSANCE_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_RENAISSANCE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');

INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ANCIENT_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ANCIENT');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ATOMIC_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ATOMIC');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('CLASSICAL_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_CLASSICAL');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INDUSTRIAL_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INDUSTRIAL');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INFORMATION_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INFORMATION');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MEDIEVAL_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MEDIEVAL');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MODERN_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MODERN');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('RENAISSANCE_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_RENAISSANCE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');

INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ANCIENT_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ANCIENT');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ATOMIC_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ATOMIC');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('CLASSICAL_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_CLASSICAL');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INDUSTRIAL_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INDUSTRIAL');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INFORMATION_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INFORMATION');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MEDIEVAL_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MEDIEVAL');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MODERN_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MODERN');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('RENAISSANCE_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_RENAISSANCE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');

INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ANCIENT_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ANCIENT');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ATOMIC_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ATOMIC');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('CLASSICAL_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_CLASSICAL');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INDUSTRIAL_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INDUSTRIAL');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INFORMATION_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INFORMATION');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MEDIEVAL_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MEDIEVAL');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MODERN_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MODERN');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('RENAISSANCE_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_RENAISSANCE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '75');

INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ANCIENT_NAVAL_MELEE_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ATOMIC_NAVAL_MELEE_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'CLASSICAL_NAVAL_MELEE_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INDUSTRIAL_NAVAL_MELEE_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INFORMATION_NAVAL_MELEE_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MEDIEVAL_NAVAL_MELEE_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MODERN_NAVAL_MELEE_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'RENAISSANCE_NAVAL_MELEE_PRODUCTION');

INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ANCIENT_NAVAL_RANGED_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ATOMIC_NAVAL_RANGED_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'CLASSICAL_NAVAL_RANGED_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INDUSTRIAL_NAVAL_RANGED_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INFORMATION_NAVAL_RANGED_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MEDIEVAL_NAVAL_RANGED_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MODERN_NAVAL_RANGED_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'RENAISSANCE_NAVAL_RANGED_PRODUCTION');

INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ANCIENT_NAVAL_RAIDER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ATOMIC_NAVAL_RAIDER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'CLASSICAL_NAVAL_RAIDER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INDUSTRIAL_NAVAL_RAIDER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INFORMATION_NAVAL_RAIDER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MEDIEVAL_NAVAL_RAIDER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MODERN_NAVAL_RAIDER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'RENAISSANCE_NAVAL_RAIDER_PRODUCTION');

INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ANCIENT_NAVAL_CARRIER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ATOMIC_NAVAL_CARRIER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'CLASSICAL_NAVAL_CARRIER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INDUSTRIAL_NAVAL_CARRIER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INFORMATION_NAVAL_CARRIER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MEDIEVAL_NAVAL_CARRIER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MODERN_NAVAL_CARRIER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'RENAISSANCE_NAVAL_CARRIER_PRODUCTION');

--刚果黑叔叔遗物需要政治哲学
UPDATE Modifiers SET OwnerRequirementSetId='PLAYER_HAS_POLITICAL_PHILOSOPHY_Z' WHERE  ModifierId='TRAIT_GREAT_WORK_FOOD_RELIC';
UPDATE Modifiers SET OwnerRequirementSetId='PLAYER_HAS_POLITICAL_PHILOSOPHY_Z' WHERE  ModifierId='TRAIT_GREAT_WORK_PRODUCTION_RELIC';
UPDATE Modifiers SET OwnerRequirementSetId='PLAYER_HAS_POLITICAL_PHILOSOPHY_Z' WHERE  ModifierId='TRAIT_GREAT_WORK_GOLD_RELIC';

--巴比伦
--送建筑政治哲学要求
UPDATE Modifiers SET OwnerRequirementSetId='PLAYER_HAS_POLITICAL_PHILOSOPHY_DGCQ' WHERE ModifierId='TRAIT_FREE_BUILDING_WHEN_DISTRICT_MADE'; 

--波兰遗物需要宗教
--UPDATE Modifiers SET SubjectRequirementSetId='PLAYER_FOUNDED_RELIGION_RELIC_CPLMOD' WHERE  ModifierId='TRAIT_LITHUANIANUNION_FAITH_RELIC';
--UPDATE Modifiers SET SubjectRequirementSetId='PLAYER_FOUNDED_RELIGION_RELIC_CPLMOD' WHERE  ModifierId='TRAIT_LITHUANIANUNION_CULTURE_RELIC';
--UPDATE Modifiers SET SubjectRequirementSetId='PLAYER_FOUNDED_RELIGION_RELIC_CPLMOD' WHERE  ModifierId='TRAIT_LITHUANIANUNION_GOLD_RELIC';
UPDATE Modifiers SET SubjectRequirementSetId='PLAYER_HAS_POLITICAL_PHILOSOPHY_Z' WHERE  ModifierId='TRAIT_LITHUANIANUNION_FAITH_RELIC';
UPDATE Modifiers SET SubjectRequirementSetId='PLAYER_HAS_POLITICAL_PHILOSOPHY_Z' WHERE  ModifierId='TRAIT_LITHUANIANUNION_CULTURE_RELIC';
UPDATE Modifiers SET SubjectRequirementSetId='PLAYER_HAS_POLITICAL_PHILOSOPHY_Z' WHERE  ModifierId='TRAIT_LITHUANIANUNION_GOLD_RELIC';


--祠堂 工人加移动
--INSERT INTO BuildingModifiers (BuildingType, ModifierId)
--	VALUES ('BUILDING_GOV_WIDE', 'GANDHI_FAST_BUILDERS');

