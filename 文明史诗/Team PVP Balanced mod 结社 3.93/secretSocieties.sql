--初始可选结社
/*
UPDATE GovernorsCannotAssign Set CannotAssign="false" WHERE GovernorType="GOVERNOR_OWLS_OF_MINERVA";
UPDATE GovernorsCannotAssign Set CannotAssign="false" WHERE GovernorType="GOVERNOR_HERMETIC_ORDER";
UPDATE GovernorsCannotAssign Set CannotAssign="false" WHERE GovernorType="GOVERNOR_VOIDSINGERS";
UPDATE GovernorsCannotAssign Set CannotAssign="false" WHERE GovernorType="GOVERNOR_SANGUINE_PACT";
*/

--触发几率
UPDATE SecretSocieties SET DiscoverAtCityStateBaseChance=100000 WHERE SecretSocietyType='SECRETSOCIETY_SANGUINE_PACT';
UPDATE SecretSocieties SET DiscoverAtCityStateBaseChance=100000 WHERE SecretSocietyType='SECRETSOCIETY_OWLS_OF_MINERVA';
UPDATE SecretSocieties SET DiscoverAtCityStateBaseChance=100000 WHERE SecretSocietyType='SECRETSOCIETY_HERMETIC_ORDER';
UPDATE SecretSocieties SET DiscoverAtCityStateBaseChance=100000 WHERE SecretSocietyType='SECRETSOCIETY_VOIDSINGERS';


--虚空信仰百分比
UPDATE ModifierArguments SET Value=1 WHERE ModifierId='GOVERNOR_PROMOTION_VOIDSINGERS_2_GOLD_FROM_FAITH' and Name="Amount";	
UPDATE ModifierArguments SET Value=10 WHERE ModifierId='GOVERNOR_PROMOTION_VOIDSINGERS_2_SCIENCE_FROM_FAITH' and Name="Amount";
UPDATE ModifierArguments SET Value=4 WHERE ModifierId='GOVERNOR_PROMOTION_VOIDSINGERS_2_CULTURE_FROM_FAITH' and Name="Amount";



--建筑
UPDATE Building_YieldChanges SET YieldChange=3 WHERE BuildingType='BUILDING_OLD_GOD_OBELISK' and YieldType='YIELD_FAITH' ;
UPDATE Building_YieldChanges SET YieldChange=4 WHERE BuildingType="BUILDING_ALCHEMICAL_SOCIETY" and YieldType="YIELD_SCIENCE" ;
UPDATE Building_YieldChanges SET YieldChange=2 WHERE BuildingType="BUILDING_ALCHEMICAL_SOCIETY" and YieldType="YIELD_PRODUCTION" ;
UPDATE Building_YieldChanges SET YieldChange=7 WHERE BuildingType="BUILDING_GILDED_VAULT" and YieldType="YIELD_GOLD" ;
--镀金大学
UPDATE Buildings SET Cost = 180  WHERE BuildingType="BUILDING_ALCHEMICAL_SOCIETY";
UPDATE Buildings SET PrereqTech = NULL ,PurchaseYield = NULL WHERE BuildingType="BUILDING_ALCHEMICAL_SOCIETY";
--镀金宝库
UPDATE Buildings SET Cost = 210  WHERE BuildingType="BUILDING_GILDED_VAULT";
UPDATE Buildings SET PrereqTech = NULL ,PurchaseYield = NULL WHERE BuildingType="BUILDING_GILDED_VAULT";

--大商点
UPDATE Building_GreatPersonPoints SET PointsPerTurn = 3  WHERE BuildingType="BUILDING_GILDED_VAULT" and GreatPersonClassType="GREAT_PERSON_CLASS_MERCHANT";




--夜莺建筑加文化
INSERT INTO Building_YieldChanges(BuildingType, YieldType , YieldChange)
	VALUES("BUILDING_GILDED_VAULT","YIELD_CULTURE","3");
	

--删除夜莺加文化
Delete FROM BuildingModifiers WHERE BuildingType="BUILDING_GILDED_VAULT" AND ModifierId="BUILDING_GILDED_VAULT_CULTURE_MIRRORS_GOLD";

--删除帝国初期、过劳总督
/*
Delete FROM CivicModifiers WHERE CivicType="CIVIC_EARLY_EMPIRE" and ModifierId="CIVIC_GRANT_PLAYER_GOVERNOR_POINTS";
Delete FROM CivicModifiers WHERE CivicType="CIVIC_STATE_WORKFORCE" and ModifierId="CIVIC_GRANT_PLAYER_GOVERNOR_POINTS";
*/		

/*
INSERT INTO Modifiers (ModifierId, ModifierType)
	VALUES ('COMMEMORATION_SCIENTIFIC_GA_HARBOR_NEW', 'MODIFIER_PLAYER_CITIE_ATTACH_MODIFIER');
INSERT INTO ModifierArguments (ModifierId, Name,Value)
	VALUES ('COMMEMORATION_SCIENTIFIC_GA_HARBOR_NEW', 'ModifierId', 'COMMEMORATION_SCIENTIFIC_GA_HARBOR_MODIFIER_NEW');
	
INSERT INTO ModifierArguments (ModifierId, Name,Value)
	VALUES ('COMMEMORATION_SCIENTIFIC_GA_HARBOR_MODIFIER_NEW', 'YieldType', 'YIELD_CULTURE');
INSERT INTO ModifierArguments (ModifierId, Name,Value)
	VALUES ('COMMEMORATION_SCIENTIFIC_GA_HARBOR_MODIFIER_NEW', 'Amount', '4');
INSERT INTO Modifiers (ModifierId, ModifierType,SubjectRequirementSetId)
	VALUES ('COMMEMORATION_SCIENTIFIC_GA_HARBOR_MODIFIER_NEW', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE', 'DISTRICT_IS_HARBOR');
	*/


--吸血鬼最高力
INSERT INTO ModifierArguments (ModifierId, Name,Value)
	VALUES ('SANGUINE_PACT_VAMPIRE_COMBAT_STRENGTH_FROM_PROPERTY', 'Max', '3');
UPDATE ModifierArguments SET Value=0 WHERE ModifierId='SANGUINE_PACT_VAMPIRE_BARB_COMBAT_STRENGTH_FROM_PROPERTY'and Name="Max";
--吸血鬼 不对枪兵+10
INSERT INTO TypeTags (Type, Tag)
	VALUES ('CLASS_VAMPIRE_FightToXX','CLASS_VAMPIRE');
INSERT INTO Types (Type, Kind)
	VALUES ('CLASS_VAMPIRE_FightToXX','KIND_ABILITY');
INSERT INTO UnitAbilities (UnitAbilityType, Name, Description)
	VALUES ('CLASS_VAMPIRE_FightToXX','LOC_ABILITY_ANTI_SPEAR_FightToXX_NAME','LOC_ABILITY_ANTI_SPEAR_FightToXX_DESCRIPTION');
INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId)
	VALUES ('CLASS_VAMPIRE_FightToXX','Modifier_VAMPIRE_FightToXX');
INSERT INTO Modifiers (ModifierId, ModifierType,SubjectRequirementSetId)
	VALUES ('Modifier_VAMPIRE_FightToXX','MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH','ANTI_SPEAR_OPPONENT_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId, Name,Value)
	VALUES ('Modifier_VAMPIRE_FightToXX','Amount','-5');
INSERT INTO ModifierStrings (ModifierId, Context,Text)
	VALUES ('Modifier_VAMPIRE_FightToXX','Preview','LOC_ABILITY_ANIT_SPEAR_MODIFIER_FightToXX_DESCRIPTION');
/*
UnitAbilityModifiers
<Row>
			<UnitAbilityType>ABILITY_ANTI_SPEAR</UnitAbilityType>
			<ModifierId>ANTI_SPEAR</ModifierId>
</Row>
Modifiers
	<Row>
			<ModifierId>ANTI_SPEAR</ModifierId>
			<ModifierType>MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH</ModifierType>
			<SubjectRequirementSetId>ANTI_SPEAR_OPPONENT_REQUIREMENTS</SubjectRequirementSetId>
		</Row>
	ModifierArguments
		<Row>
			<ModifierId>ANTI_SPEAR</ModifierId>
			<Name>Amount</Name>
			<Value>10</Value>
		</Row>
	TypeTags
<Row Type="ABILITY_ANTI_SPEAR" Tag="CLASS_MELEE"/>
Types
<Row Type="ABILITY_ANTI_SPEAR" Kind="KIND_ABILITY"/>
UnitAbilities
<Row UnitAbilityType="ABILITY_ANTI_SPEAR" Name="LOC_ABILITY_ANTI_SPEAR_NAME" Description="LOC_ABILITY_ANTI_SPEAR_DESCRIPTION"/>

		
Delete FROM TypeTags WHERE  Type="UNIT_VAMPIRE" and Tag="CLASS_MELEE";
INSERT INTO TypeTags (Type , Tag)
   VALUES ('ABILITY_FASCISM_ATTACK_BUFF' , 'CLASS_VAMPIRE');  
INSERT INTO TypeTags (Type , Tag)
   VALUES ('ABILITY_COMMUNISM_DEFENSE_BUFF' , 'CLASS_VAMPIRE');  
INSERT INTO TypeTags (Type , Tag)
   VALUES ('ABILITY_GREAT_GENERAL_MOVEMENT' , 'CLASS_VAMPIRE');  
INSERT INTO TypeTags (Type , Tag)
   VALUES ('ABILITY_GREAT_GENERAL_STRENGTH' , 'CLASS_VAMPIRE'); 
INSERT INTO TypeTags (Type , Tag)
   VALUES ('ABILITY_GREAT_LIGHTHOUSE_EMBARKED_MOVEMENT' , 'CLASS_VAMPIRE');    
--UPDATE Units SET BaseMoves="3" WHERE UnitType='UNIT_VAMPIRE';
*/

  
  
  
  
--吸血鬼城堡
/*
ModifierArguments
<Row>
      <ModifierId>SECRET_SOCIETY_GRANT_TWO_VAMPIRE_BUILDS</ModifierId>
      <Name>Amount</Name>
      <Value>2</Value>
    </Row>
	*/
--邪教徒
UPDATE Units SET Cost="60",BaseMoves="6",CostProgressionParam1="15" WHERE UnitType='UNIT_CULTIST';
UPDATE ModifierArguments SET Value=10 WHERE ModifierId='SPREAD_DISSENT_LOYALTY_DAMAGE'and Name="Amount";
--使用1次
UPDATE Units_MODE SET ActionCharges="1" WHERE UnitType='UNIT_CULTIST';

--频率
UPDATE Resources SET Frequency="10" WHERE ResourceType='RESOURCE_LEY_LINE';
--地脉产出
INSERT INTO Resource_YieldChanges(ResourceType,YieldType,YieldChange)
    VALUES("RESOURCE_LEY_LINE","YIELD_SCIENCE",1);
--INSERT INTO Resource_YieldChanges(ResourceType,YieldType,YieldChange)
--    VALUES("RESOURCE_LEY_LINE","YIELD_FOOD",1);
INSERT INTO Resource_YieldChanges(ResourceType,YieldType,YieldChange)
    VALUES("RESOURCE_LEY_LINE","YIELD_PRODUCTION",2);

Delete FROM Resource_ValidTerrains WHERE ResourceType='RESOURCE_LEY_LINE' and TerrainType="TERRAIN_TUNDRA";
Delete FROM Resource_ValidTerrains WHERE ResourceType='RESOURCE_LEY_LINE' and TerrainType="TERRAIN_SNOW";
Delete FROM Resource_ValidTerrains WHERE ResourceType='RESOURCE_LEY_LINE' and TerrainType="TERRAIN_TUNDRA_HILLS";
Delete FROM Resource_ValidTerrains WHERE ResourceType='RESOURCE_LEY_LINE' and TerrainType="TERRAIN_SNOW_HILLS";
Delete FROM Resource_ValidTerrains WHERE ResourceType='RESOURCE_LEY_LINE' and TerrainType="TERRAIN_DESERT_HILLS";
Delete FROM Resource_ValidTerrains WHERE ResourceType='RESOURCE_LEY_LINE' and TerrainType="TERRAIN_DESERT";

Delete FROM Resource_ValidTerrains WHERE ResourceType='RESOURCE_LEY_LINE' and TerrainType="TERRAIN_GRASS_HILLS";
Delete FROM Resource_ValidTerrains WHERE ResourceType='RESOURCE_LEY_LINE' and TerrainType="TERRAIN_PLAINS_HILLS";
--INSERT INTO Resource_ValidTerrains (ResourceType , TerrainType)
--   VALUES ('RESOURCE_LEY_LINE' , 'TERRAIN_COAST');
--INSERT INTO Resource_ValidFeatures (ResourceType , FeatureType)
--   VALUES ('RESOURCE_LEY_LINE' , 'FEATURE_FLOODPLAINS');
--INSERT INTO Resource_ValidFeatures (ResourceType , FeatureType)
--   VALUES ('RESOURCE_LEY_LINE' , 'FEATURE_JUNGLE');
--INSERT INTO Resource_ValidFeatures (ResourceType , FeatureType)
--   VALUES ('RESOURCE_LEY_LINE' , 'FEATURE_FOREST');
--INSERT INTO Resource_ValidFeatures (ResourceType , FeatureType)
 --  VALUES ('RESOURCE_LEY_LINE' , 'FEATURE_OASIS');  

--夜莺使者 
--Delete FROM GovernorPromotionModifiers WHERE GovernorPromotionType="GOVERNOR_PROMOTION_OWLS_OF_MINERVA_1" and  ModifierId="GOVERNOR_PROMOTION_OWLS_OF_MINERVA_1_ENVOY_FROM_TRADE_ROUTE";

--地脉3级提前
--UPDATE GovernorPromotionConditions SET EarliestGameEra="ERA_RENAISSANCE" WHERE GovernorPromotionType='GOVERNOR_PROMOTION_HERMETIC_ORDER_3';

--波兰遗物+1个
UPDATE ModifierArguments SET Value=1 WHERE ModifierId='TRAIT_LITHUANIANUNION_COMPLETE_RELIGION_RELIC_CPLMOD'and Name="Amount";
--Delete FROM TraitModifiers WHERE TraitType="TRAIT_LEADER_LITHUANIAN_UNION" and ModifierId="TRAIT_LITHUANIANUNION_FAITH_RELIC";

--谒见厅
--UPDATE ModifierArguments SET Value='1' WHERE ModifierId='GOV_TALL_FOOD_BUFF' AND Name='Amount';

--
--海军和大军
UPDATE ModifierArguments SET Value='YIELD_FOOD' WHERE ModifierId='HERMETIC_ORDER_GREAT_ADMIRAL_LEY_LINE_SCIENCE'and Name="YieldType";	
UPDATE ModifierArguments SET Value='YIELD_PRODUCTION' WHERE ModifierId='HERMETIC_ORDER_GREAT_GENERAL_LEY_LINE_SCIENCE'and Name="YieldType";	

--外交家使者
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='MESSENGER_GRANT_FREE_ENVOYS' AND Name='Amount';

--工业时代提前至文艺复兴
UPDATE GovernorPromotionConditions SET EarliestGameEra="ERA_RENAISSANCE" WHERE GovernorPromotionType='GOVERNOR_PROMOTION_HERMETIC_ORDER_3';
UPDATE GovernorPromotionConditions SET EarliestGameEra="ERA_RENAISSANCE" WHERE GovernorPromotionType='GOVERNOR_PROMOTION_OWLS_OF_MINERVA_3';
UPDATE GovernorPromotionConditions SET EarliestGameEra="ERA_RENAISSANCE" WHERE GovernorPromotionType='GOVERNOR_PROMOTION_VOIDSINGERS_3';
UPDATE GovernorPromotionConditions SET EarliestGameEra="ERA_RENAISSANCE" WHERE GovernorPromotionType='GOVERNOR_PROMOTION_SANGUINE_PACT_3';


--吸血鬼3级
UPDATE ModifierArguments SET Value="-2" WHERE ModifierId='SECRET_SOCIETY_INTIMIDATE_ADJACENT_ENEMIES_MODIFIER' and Name="Amount";
	
--虚空3级
/*
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_25' , 'YIELD_SCIENCE' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_26' , 'YIELD_SCIENCE' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_27' , 'YIELD_SCIENCE' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_28' , 'YIELD_SCIENCE' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_29' , 'YIELD_SCIENCE' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_30' , 'YIELD_SCIENCE' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_31' , 'YIELD_SCIENCE' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_32' , 'YIELD_SCIENCE' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_33' , 'YIELD_SCIENCE' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_34' , 'YIELD_SCIENCE' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_35' , 'YIELD_SCIENCE' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_36' , 'YIELD_SCIENCE' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_37' , 'YIELD_SCIENCE' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_38' , 'YIELD_SCIENCE' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_39' , 'YIELD_SCIENCE' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_40' , 'YIELD_SCIENCE' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_41' , 'YIELD_SCIENCE' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_42' , 'YIELD_SCIENCE' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_43' , 'YIELD_SCIENCE' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_44' , 'YIELD_SCIENCE' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_45' , 'YIELD_SCIENCE' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_46' , 'YIELD_SCIENCE' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_47' , 'YIELD_SCIENCE' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_48' , 'YIELD_SCIENCE' , '3');

INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_25' , 'YIELD_CULTURE' , '2');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_26' , 'YIELD_CULTURE' , '2');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_27' , 'YIELD_CULTURE' , '2');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_28' , 'YIELD_CULTURE' , '2');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_29' , 'YIELD_CULTURE' , '2');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_30' , 'YIELD_CULTURE' , '2');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_31' , 'YIELD_CULTURE' , '2');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_32' , 'YIELD_CULTURE' , '2');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_33' , 'YIELD_CULTURE' , '2');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_34' , 'YIELD_CULTURE' , '2');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_35' , 'YIELD_CULTURE' , '2');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_36' , 'YIELD_CULTURE' , '2');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_37' , 'YIELD_CULTURE' , '2');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_38' , 'YIELD_CULTURE' , '2');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_39' , 'YIELD_CULTURE' , '2');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_40' , 'YIELD_CULTURE' , '2');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_41' , 'YIELD_CULTURE' , '2');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_42' , 'YIELD_CULTURE' , '2');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_43' , 'YIELD_CULTURE' , '2');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_44' , 'YIELD_CULTURE' , '2');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_45' , 'YIELD_CULTURE' , '2');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_46' , 'YIELD_CULTURE' , '2');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_47' , 'YIELD_CULTURE' , '2');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_48' , 'YIELD_CULTURE' , '2');

INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_25' , 'YIELD_PRODUCTION' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_26' , 'YIELD_PRODUCTION' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_27' , 'YIELD_PRODUCTION' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_28' , 'YIELD_PRODUCTION' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_29' , 'YIELD_PRODUCTION' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_30' , 'YIELD_PRODUCTION' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_31' , 'YIELD_PRODUCTION' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_32' , 'YIELD_PRODUCTION' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_33' , 'YIELD_PRODUCTION' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_34' , 'YIELD_PRODUCTION' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_35' , 'YIELD_PRODUCTION' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_36' , 'YIELD_PRODUCTION' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_37' , 'YIELD_PRODUCTION' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_38' , 'YIELD_PRODUCTION' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_39' , 'YIELD_PRODUCTION' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_40' , 'YIELD_PRODUCTION' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_41' , 'YIELD_PRODUCTION' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_42' , 'YIELD_PRODUCTION' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_43' , 'YIELD_PRODUCTION' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_44' , 'YIELD_PRODUCTION' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_45' , 'YIELD_PRODUCTION' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_46' , 'YIELD_PRODUCTION' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_47' , 'YIELD_PRODUCTION' , '3');
INSERT INTO GreatWork_YieldChanges (GreatWorkType , YieldType , YieldChange) VALUES
('GREATWORK_RELIC_48' , 'YIELD_PRODUCTION' , '3');
*/

UPDATE GreatWork_YieldChanges SET YieldChange="2" WHERE GreatWorkType='GREATWORK_RELIC_25' and YieldType="YIELD_FAITH";
UPDATE GreatWork_YieldChanges SET YieldChange="2" WHERE GreatWorkType='GREATWORK_RELIC_26' and YieldType="YIELD_FAITH";
UPDATE GreatWork_YieldChanges SET YieldChange="2" WHERE GreatWorkType='GREATWORK_RELIC_27' and YieldType="YIELD_FAITH";
UPDATE GreatWork_YieldChanges SET YieldChange="2" WHERE GreatWorkType='GREATWORK_RELIC_28' and YieldType="YIELD_FAITH";
UPDATE GreatWork_YieldChanges SET YieldChange="2" WHERE GreatWorkType='GREATWORK_RELIC_29' and YieldType="YIELD_FAITH";
UPDATE GreatWork_YieldChanges SET YieldChange="2" WHERE GreatWorkType='GREATWORK_RELIC_30' and YieldType="YIELD_FAITH";
UPDATE GreatWork_YieldChanges SET YieldChange="2" WHERE GreatWorkType='GREATWORK_RELIC_31' and YieldType="YIELD_FAITH";
UPDATE GreatWork_YieldChanges SET YieldChange="2" WHERE GreatWorkType='GREATWORK_RELIC_32' and YieldType="YIELD_FAITH";
UPDATE GreatWork_YieldChanges SET YieldChange="2" WHERE GreatWorkType='GREATWORK_RELIC_33' and YieldType="YIELD_FAITH";
UPDATE GreatWork_YieldChanges SET YieldChange="2" WHERE GreatWorkType='GREATWORK_RELIC_34' and YieldType="YIELD_FAITH";
UPDATE GreatWork_YieldChanges SET YieldChange="2" WHERE GreatWorkType='GREATWORK_RELIC_35' and YieldType="YIELD_FAITH";
UPDATE GreatWork_YieldChanges SET YieldChange="2" WHERE GreatWorkType='GREATWORK_RELIC_36' and YieldType="YIELD_FAITH";
UPDATE GreatWork_YieldChanges SET YieldChange="2" WHERE GreatWorkType='GREATWORK_RELIC_37' and YieldType="YIELD_FAITH";
UPDATE GreatWork_YieldChanges SET YieldChange="2" WHERE GreatWorkType='GREATWORK_RELIC_38' and YieldType="YIELD_FAITH";
UPDATE GreatWork_YieldChanges SET YieldChange="2" WHERE GreatWorkType='GREATWORK_RELIC_39' and YieldType="YIELD_FAITH";
UPDATE GreatWork_YieldChanges SET YieldChange="2" WHERE GreatWorkType='GREATWORK_RELIC_40' and YieldType="YIELD_FAITH";
UPDATE GreatWork_YieldChanges SET YieldChange="2" WHERE GreatWorkType='GREATWORK_RELIC_41' and YieldType="YIELD_FAITH";
UPDATE GreatWork_YieldChanges SET YieldChange="2" WHERE GreatWorkType='GREATWORK_RELIC_42' and YieldType="YIELD_FAITH";
UPDATE GreatWork_YieldChanges SET YieldChange="2" WHERE GreatWorkType='GREATWORK_RELIC_43' and YieldType="YIELD_FAITH";
UPDATE GreatWork_YieldChanges SET YieldChange="2" WHERE GreatWorkType='GREATWORK_RELIC_44' and YieldType="YIELD_FAITH";
UPDATE GreatWork_YieldChanges SET YieldChange="2" WHERE GreatWorkType='GREATWORK_RELIC_45' and YieldType="YIELD_FAITH";
UPDATE GreatWork_YieldChanges SET YieldChange="2" WHERE GreatWorkType='GREATWORK_RELIC_46' and YieldType="YIELD_FAITH";
UPDATE GreatWork_YieldChanges SET YieldChange="2" WHERE GreatWorkType='GREATWORK_RELIC_47' and YieldType="YIELD_FAITH";
UPDATE GreatWork_YieldChanges SET YieldChange="2" WHERE GreatWorkType='GREATWORK_RELIC_48' and YieldType="YIELD_FAITH";


--夜莺3级
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='GOVERNOR_PROMOTION_OWLS_OF_MINERVA_3_SPY_CAPACITY'and Name="Amount";
--
UPDATE GovernorPromotionModifiers SET GovernorPromotionType="GOVERNOR_PROMOTION_OWLS_OF_MINERVA_3" WHERE GovernorPromotionType='GOVERNOR_PROMOTION_OWLS_OF_MINERVA_4' and ModifierId="GOVERNOR_PROMOTION_OWLS_OF_MINERVA_4_SPY_SUCCESS_GRANTS_SCIENCE";
UPDATE GovernorPromotionModifiers SET GovernorPromotionType="GOVERNOR_PROMOTION_OWLS_OF_MINERVA_3" WHERE GovernorPromotionType='GOVERNOR_PROMOTION_OWLS_OF_MINERVA_4' and ModifierId="GOVERNOR_PROMOTION_OWLS_OF_MINERVA_4_SPY_SUCCESS_GRANTS_CULTURE";
UPDATE GovernorPromotionModifiers SET GovernorPromotionType="GOVERNOR_PROMOTION_OWLS_OF_MINERVA_3" WHERE GovernorPromotionType='GOVERNOR_PROMOTION_OWLS_OF_MINERVA_4' and ModifierId="GOVERNOR_PROMOTION_OWLS_OF_MINERVA_4_SPY_SUCCESS_GRANTS_GOLD";
UPDATE GovernorPromotionModifiers SET GovernorPromotionType="GOVERNOR_PROMOTION_OWLS_OF_MINERVA_3" WHERE GovernorPromotionType='GOVERNOR_PROMOTION_OWLS_OF_MINERVA_4' and ModifierId="GOVERNOR_PROMOTION_OWLS_OF_MINERVA_4_SPY_SUCCESS_GRANTS_FAITH";
--比例
UPDATE ModifierArguments SET Value='150' WHERE ModifierId='GOVERNOR_PROMOTION_OWLS_OF_MINERVA_4_SPY_SUCCESS_GRANTS_GOLD'and Name="Percent";	
UPDATE ModifierArguments SET Value='150' WHERE ModifierId='GOVERNOR_PROMOTION_OWLS_OF_MINERVA_4_SPY_SUCCESS_GRANTS_SCIENCE'and Name="Percent";	
UPDATE ModifierArguments SET Value='150' WHERE ModifierId='GOVERNOR_PROMOTION_OWLS_OF_MINERVA_4_SPY_SUCCESS_GRANTS_CULTURE'and Name="Percent";	
UPDATE ModifierArguments SET Value='150' WHERE ModifierId='GOVERNOR_PROMOTION_OWLS_OF_MINERVA_4_SPY_SUCCESS_GRANTS_FAITH'and Name="Percent";	
--夜莺4级
UPDATE ModifierArguments SET Value='5' WHERE ModifierId='GOVERNOR_PROMOTION_OWLS_OF_MINERVA_4_GOLD_INTEREST'and Name="Percent";

--启蒙会虚空被
/*  INSERT INTO BeliefModifiers (BeliefType, ModifierId) VALUES
('BELIEF_INITIATION_RITES', 'RELIGIOUS_SETTLEMENTS_PALACE_YIELD_FAITH_OLD');

INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES
('RELIGIOUS_SETTLEMENTS_PALACE_YIELD_FAITH_OLD', 'MODIFIER_ALL_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('RELIGIOUS_SETTLEMENTS_PALACE_YIELD_FAITH_OLD', 'BuildingType', 'BUILDING_OLD_GOD_OBELISK'),
('RELIGIOUS_SETTLEMENTS_PALACE_YIELD_FAITH_OLD', 'YieldType',    'YIELD_FAITH'),
('RELIGIOUS_SETTLEMENTS_PALACE_YIELD_FAITH_OLD', 'Amount',       '0'); */
--

--共享教堂
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='SIMULTANEUM_BUILDING_YIELDS_HIGH_ADJACENCY' and Name='Amount';
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='SIMULTANEUM_BUILDING_YIELDS_HIGH_POP' and Name='Amount';
/*
--瑞典兼容炼金大学
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES
	('TRAIT_CIVILIZATION_NOBEL_PRIZE' , 'NOBEL_PRIZE_UNIVERISTY_BOOST2' );
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES
	('NOBEL_PRIZE_UNIVERISTY_BOOST2' , 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION' , null);
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra , SecondExtra)
	VALUES 
	('NOBEL_PRIZE_UNIVERISTY_BOOST2' , 'BuildingType' , 'BUILDING_ALCHEMICAL_SOCIETY' , null , null),
	('NOBEL_PRIZE_UNIVERISTY_BOOST2' , 'Amount'       , '30'                  , null , null);
*/	
--吸血鬼城堡不能在境外建造
UPDATE Improvements SET CanBuildOutsideTerritory=0 WHERE ImprovementType='IMPROVEMENT_VAMPIRE_CASTLE';
--虚空3级
--科技
INSERT INTO GovernorPromotionModifiers (GovernorPromotionType , ModifierId) VALUES
('GOVERNOR_PROMOTION_VOIDSINGERS_3' , 'GOVERNOR_PROMOTION_VOIDSINGERS_3_SCIENCE_RELIC');
INSERT INTO Modifiers (ModifierId , ModifierType) VALUES
('GOVERNOR_PROMOTION_VOIDSINGERS_3_SCIENCE_RELIC' , 'MODIFIER_PLAYER_CITIES_ADJUST_GREATWORK_YIELD');
INSERT INTO ModifierArguments (ModifierId , Name , Value) VALUES
('GOVERNOR_PROMOTION_VOIDSINGERS_3_SCIENCE_RELIC' , 'GreatWorkObjectType','GREATWORKOBJECT_RELIC');
INSERT INTO ModifierArguments (ModifierId , Name , Value) VALUES
('GOVERNOR_PROMOTION_VOIDSINGERS_3_SCIENCE_RELIC' , 'YieldType','YIELD_SCIENCE');
INSERT INTO ModifierArguments (ModifierId , Name , Value) VALUES
('GOVERNOR_PROMOTION_VOIDSINGERS_3_SCIENCE_RELIC' , 'YieldChange','2');
--文化
INSERT INTO GovernorPromotionModifiers (GovernorPromotionType , ModifierId) VALUES
('GOVERNOR_PROMOTION_VOIDSINGERS_3' , 'GOVERNOR_PROMOTION_VOIDSINGERS_3_CULTURE_RELIC');
INSERT INTO Modifiers (ModifierId , ModifierType) VALUES
('GOVERNOR_PROMOTION_VOIDSINGERS_3_CULTURE_RELIC' , 'MODIFIER_PLAYER_CITIES_ADJUST_GREATWORK_YIELD');
INSERT INTO ModifierArguments (ModifierId , Name , Value) VALUES
('GOVERNOR_PROMOTION_VOIDSINGERS_3_CULTURE_RELIC' , 'GreatWorkObjectType','GREATWORKOBJECT_RELIC');
INSERT INTO ModifierArguments (ModifierId , Name , Value) VALUES
('GOVERNOR_PROMOTION_VOIDSINGERS_3_CULTURE_RELIC' , 'YieldType','YIELD_CULTURE');
INSERT INTO ModifierArguments (ModifierId , Name , Value) VALUES
('GOVERNOR_PROMOTION_VOIDSINGERS_3_CULTURE_RELIC' , 'YieldChange','2');
--生产力
INSERT INTO GovernorPromotionModifiers (GovernorPromotionType , ModifierId) VALUES
('GOVERNOR_PROMOTION_VOIDSINGERS_3' , 'GOVERNOR_PROMOTION_VOIDSINGERS_3_PRODUCTION_RELIC');
INSERT INTO Modifiers (ModifierId , ModifierType) VALUES
('GOVERNOR_PROMOTION_VOIDSINGERS_3_PRODUCTION_RELIC' , 'MODIFIER_PLAYER_CITIES_ADJUST_GREATWORK_YIELD');
INSERT INTO ModifierArguments (ModifierId , Name , Value) VALUES
('GOVERNOR_PROMOTION_VOIDSINGERS_3_PRODUCTION_RELIC' , 'GreatWorkObjectType','GREATWORKOBJECT_RELIC');
INSERT INTO ModifierArguments (ModifierId , Name , Value) VALUES
('GOVERNOR_PROMOTION_VOIDSINGERS_3_PRODUCTION_RELIC' , 'YieldType','YIELD_PRODUCTION');
INSERT INTO ModifierArguments (ModifierId , Name , Value) VALUES
('GOVERNOR_PROMOTION_VOIDSINGERS_3_PRODUCTION_RELIC' , 'YieldChange','1');


--吸血鬼不能返回回城邦
Delete FROM UnitRetreats_XP1 WHERE UnitRetreatType="UNIT_RETREAT_VAMPIRE_TO_CASTLE"
and UnitType="UNIT_VAMPIRE" and 
ImprovementType="IMPROVEMENT_VAMPIRE_CASTLE";

UPDATE Adjacency_YieldChanges SET YieldChange='1' WHERE ID='LeyLine_Culture';
UPDATE Adjacency_YieldChanges SET YieldChange='1' WHERE ID='LeyLine_Faith';
UPDATE Adjacency_YieldChanges SET YieldChange='1' WHERE ID='LeyLine_Gold';
UPDATE Adjacency_YieldChanges SET YieldChange='1' WHERE ID='LeyLine_Production';
UPDATE Adjacency_YieldChanges SET YieldChange='1' WHERE ID='LeyLine_Science';


--
--朝鲜书院可以相邻地脉
INSERT INTO District_Adjacencies (DistrictType, YieldChangeId)
	VALUES ('DISTRICT_SEOWON', 'LeyLine_Science');
--越南城池可以相邻地脉
/*INSERT INTO District_Adjacencies (DistrictType, YieldChangeId)
	VALUES ('DISTRICT_THANH', 'LeyLine_Production');*/
	

--不消耗总督点
INSERT INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId)
	VALUES ('GOVERNOR_PROMOTION_OWLS_OF_MINERVA_1', 'CIVIC_GRANT_PLAYER_GOVERNOR_POINTS');
INSERT INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId)
	VALUES ('GOVERNOR_PROMOTION_OWLS_OF_MINERVA_2', 'CIVIC_GRANT_PLAYER_GOVERNOR_POINTS');
INSERT INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId)
	VALUES ('GOVERNOR_PROMOTION_OWLS_OF_MINERVA_3', 'CIVIC_GRANT_PLAYER_GOVERNOR_POINTS');
INSERT INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId)
	VALUES ('GOVERNOR_PROMOTION_OWLS_OF_MINERVA_4', 'CIVIC_GRANT_PLAYER_GOVERNOR_POINTS');

INSERT INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId)
	VALUES ('GOVERNOR_PROMOTION_HERMETIC_ORDER_1', 'CIVIC_GRANT_PLAYER_GOVERNOR_POINTS');
INSERT INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId)
	VALUES ('GOVERNOR_PROMOTION_HERMETIC_ORDER_2', 'CIVIC_GRANT_PLAYER_GOVERNOR_POINTS');
INSERT INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId)
	VALUES ('GOVERNOR_PROMOTION_HERMETIC_ORDER_3', 'CIVIC_GRANT_PLAYER_GOVERNOR_POINTS');
INSERT INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId)
	VALUES ('GOVERNOR_PROMOTION_HERMETIC_ORDER_4', 'CIVIC_GRANT_PLAYER_GOVERNOR_POINTS');

INSERT INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId)
	VALUES ('GOVERNOR_PROMOTION_VOIDSINGERS_1', 'CIVIC_GRANT_PLAYER_GOVERNOR_POINTS');
INSERT INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId)
	VALUES ('GOVERNOR_PROMOTION_VOIDSINGERS_2', 'CIVIC_GRANT_PLAYER_GOVERNOR_POINTS');
INSERT INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId)
	VALUES ('GOVERNOR_PROMOTION_VOIDSINGERS_3', 'CIVIC_GRANT_PLAYER_GOVERNOR_POINTS');
INSERT INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId)
	VALUES ('GOVERNOR_PROMOTION_VOIDSINGERS_4', 'CIVIC_GRANT_PLAYER_GOVERNOR_POINTS');

INSERT INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId)
	VALUES ('GOVERNOR_PROMOTION_SANGUINE_PACT_1', 'CIVIC_GRANT_PLAYER_GOVERNOR_POINTS');
INSERT INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId)
	VALUES ('GOVERNOR_PROMOTION_SANGUINE_PACT_2', 'CIVIC_GRANT_PLAYER_GOVERNOR_POINTS');
INSERT INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId)
	VALUES ('GOVERNOR_PROMOTION_SANGUINE_PACT_3', 'CIVIC_GRANT_PLAYER_GOVERNOR_POINTS');
INSERT INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId)
	VALUES ('GOVERNOR_PROMOTION_SANGUINE_PACT_4', 'CIVIC_GRANT_PLAYER_GOVERNOR_POINTS');

--镀金船厂加煤
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
	VALUES
	('PLAYER_CAN_SEE_COAL_CPLMOD2_DUJ'		, 	'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	VALUES
	('PLAYER_CAN_SEE_COAL_CPLMOD2_DUJ'		, 'REQUIRES_PLAYER_CAN_SEE_COAL');
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES
	('BUILDING_GILDED_Shipyard', 'COAL_FROM_SEAPORT_BBG2');
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
	('COAL_FROM_SEAPORT_BBG2', 'MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_IMPORT_EXTRACTION', 'PLAYER_CAN_SEE_COAL_CPLMOD2_DUJ');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('COAL_FROM_SEAPORT_BBG2', 'ResourceType', 'RESOURCE_COAL'),
	('COAL_FROM_SEAPORT_BBG2', 'Amount', '1');

--地脉 大商人+2金
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='HERMETIC_ORDER_GREAT_MERCHANT_LEY_LINE_GOLD' and Name='Amount';

--吸血鬼城堡 数量 2级2个-》1个，3级1个-》2个
UPDATE GovernorPromotionModifiers SET ModifierId="SECRET_SOCIETY_GRANT_ONE_VAMPIRE_BUILD" WHERE GovernorPromotionType = "GOVERNOR_PROMOTION_SANGUINE_PACT_2" and ModifierId="SECRET_SOCIETY_GRANT_TWO_VAMPIRE_BUILDS";
UPDATE GovernorPromotionModifiers SET ModifierId="SECRET_SOCIETY_GRANT_TWO_VAMPIRE_BUILDS" WHERE GovernorPromotionType = "GOVERNOR_PROMOTION_SANGUINE_PACT_3" and ModifierId="SECRET_SOCIETY_GRANT_ONE_VAMPIRE_BUILD";

--3级吸血鬼 吸血鬼+0移动
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('SECRET_SOCIETY_VAMPIRE_ADDMOVE_TEAMPVP' , 'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT' , 'THIS_UNIT_IS_A_VAMPIRE');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SECRET_SOCIETY_VAMPIRE_ADDMOVE_TEAMPVP' , 'Amount' , '0');

INSERT INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId)
	VALUES ('GOVERNOR_PROMOTION_SANGUINE_PACT_3','SECRET_SOCIETY_VAMPIRE_ADDMOVE_TEAMPVP');

--吸血鬼城堡收益 修复重载BUG
--删除所有人效果 仅个人生效
Delete FROM GameModifiers WHERE ModifierId="SECRET_SOCIETIES_ATTACH_PLAYER_CASTLES_GAIN_ADJACENT_YIELDS";
--Delete FROM Improvement_YieldsOutsideTerritories WHERE ImprovementType="IMPROVEMENT_VAMPIRE_CASTLE";
--INSERT INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId)
--	VALUES ('GOVERNOR_PROMOTION_SANGUINE_PACT_2', 'SANGUINE_PACT_GRANT_CASTLES_ADJACENT_YIELDS');

/*--2级
INSERT INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId)
	VALUES ('GOVERNOR_PROMOTION_SANGUINE_PACT_2', 'XIXUEGUI_SHOUDU_JIASHIWU_CITY_Modifier_1');
INSERT INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId)
	VALUES ('GOVERNOR_PROMOTION_SANGUINE_PACT_2', 'XIXUEGUI_SHOUDU_JIACHUIZI_CITY_Modifier_1');
--食物
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('XIXUEGUI_SHOUDU_JIASHIWU_CITY_Modifier_1' , 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('XIXUEGUI_SHOUDU_JIASHIWU_CITY_Modifier_1' , 'ModifierId' , 'XIXUEGUI_SHOUDU_JIASHIWU_Modifier_1');
--
INSERT INTO Modifiers (ModifierId , ModifierType,SubjectRequirementSetId)
	VALUES ('XIXUEGUI_SHOUDU_JIASHIWU_Modifier_1' , 'MODIFIER_SINGLE_CITY_ADJUST_YIELD_CHANGE',"CITY_HSA_GONGDIAN_XIXUEGUI");
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('XIXUEGUI_SHOUDU_JIASHIWU_Modifier_1' , 'YieldType' , 'YIELD_FOOD');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('XIXUEGUI_SHOUDU_JIASHIWU_Modifier_1' , 'Amount' , '12');
--生产力
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('XIXUEGUI_SHOUDU_JIACHUIZI_CITY_Modifier_1' , 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('XIXUEGUI_SHOUDU_JIACHUIZI_CITY_Modifier_1' , 'ModifierId' , 'XIXUEGUI_SHOUDU_JIACHUIZI_Modifier_1');
--
INSERT INTO Modifiers (ModifierId , ModifierType,SubjectRequirementSetId)
	VALUES ('XIXUEGUI_SHOUDU_JIACHUIZI_Modifier_1' , 'MODIFIER_SINGLE_CITY_ADJUST_YIELD_CHANGE',"CITY_HSA_GONGDIAN_XIXUEGUI");
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('XIXUEGUI_SHOUDU_JIACHUIZI_Modifier_1' , 'YieldType' , 'YIELD_PRODUCTION');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('XIXUEGUI_SHOUDU_JIACHUIZI_Modifier_1' , 'Amount' , '12');


--3级
INSERT INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId)
	VALUES ('GOVERNOR_PROMOTION_SANGUINE_PACT_3', 'XIXUEGUI_SHOUDU_JIASHIWU_CITY_Modifier_2');
INSERT INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId)
	VALUES ('GOVERNOR_PROMOTION_SANGUINE_PACT_3', 'XIXUEGUI_SHOUDU_JIACHUIZI_CITY_Modifier_2');
--食物
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('XIXUEGUI_SHOUDU_JIASHIWU_CITY_Modifier_2' , 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('XIXUEGUI_SHOUDU_JIASHIWU_CITY_Modifier_2' , 'ModifierId' , 'XIXUEGUI_SHOUDU_JIASHIWU_Modifier_2');
INSERT INTO Modifiers (ModifierId , ModifierType,SubjectRequirementSetId)
	VALUES ('XIXUEGUI_SHOUDU_JIASHIWU_Modifier_2' , 'MODIFIER_SINGLE_CITY_ADJUST_YIELD_CHANGE',"CITY_HSA_GONGDIAN_XIXUEGUI");
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('XIXUEGUI_SHOUDU_JIASHIWU_Modifier_2' , 'YieldType' , 'YIELD_FOOD');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('XIXUEGUI_SHOUDU_JIASHIWU_Modifier_2' , 'Amount' , '24');
--生产力
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('XIXUEGUI_SHOUDU_JIACHUIZI_CITY_Modifier_2' , 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('XIXUEGUI_SHOUDU_JIACHUIZI_CITY_Modifier_2' , 'ModifierId' , 'XIXUEGUI_SHOUDU_JIACHUIZI_Modifier_2');
--
INSERT INTO Modifiers (ModifierId , ModifierType,SubjectRequirementSetId)
	VALUES ('XIXUEGUI_SHOUDU_JIACHUIZI_Modifier_2' , 'MODIFIER_SINGLE_CITY_ADJUST_YIELD_CHANGE',"CITY_HSA_GONGDIAN_XIXUEGUI");
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('XIXUEGUI_SHOUDU_JIACHUIZI_Modifier_2' , 'YieldType' , 'YIELD_PRODUCTION');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('XIXUEGUI_SHOUDU_JIACHUIZI_Modifier_2' , 'Amount' , '24');

--4级
INSERT INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId)
	VALUES ('GOVERNOR_PROMOTION_SANGUINE_PACT_4', 'XIXUEGUI_SHOUDU_JIASHIWU_CITY_Modifier_3');
INSERT INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId)
	VALUES ('GOVERNOR_PROMOTION_SANGUINE_PACT_4', 'XIXUEGUI_SHOUDU_JIACHUIZI_CITY_Modifier_3');
--食物
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('XIXUEGUI_SHOUDU_JIASHIWU_CITY_Modifier_3' , 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('XIXUEGUI_SHOUDU_JIASHIWU_CITY_Modifier_3' , 'ModifierId' , 'XIXUEGUI_SHOUDU_JIASHIWU_Modifier_3');
--
INSERT INTO Modifiers (ModifierId , ModifierType,SubjectRequirementSetId)
	VALUES ('XIXUEGUI_SHOUDU_JIASHIWU_Modifier_3' , 'MODIFIER_SINGLE_CITY_ADJUST_YIELD_CHANGE',"CITY_HSA_GONGDIAN_XIXUEGUI");
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('XIXUEGUI_SHOUDU_JIASHIWU_Modifier_3' , 'YieldType' , 'YIELD_FOOD');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('XIXUEGUI_SHOUDU_JIASHIWU_Modifier_3' , 'Amount' , '12');
--生产力
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('XIXUEGUI_SHOUDU_JIACHUIZI_CITY_Modifier_3' , 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('XIXUEGUI_SHOUDU_JIACHUIZI_CITY_Modifier_3' , 'ModifierId' , 'XIXUEGUI_SHOUDU_JIACHUIZI_Modifier_3');
--
INSERT INTO Modifiers (ModifierId , ModifierType,SubjectRequirementSetId)
	VALUES ('XIXUEGUI_SHOUDU_JIACHUIZI_Modifier_3' , 'MODIFIER_SINGLE_CITY_ADJUST_YIELD_CHANGE',"CITY_HSA_GONGDIAN_XIXUEGUI");
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('XIXUEGUI_SHOUDU_JIACHUIZI_Modifier_3' , 'YieldType' , 'YIELD_PRODUCTION');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('XIXUEGUI_SHOUDU_JIACHUIZI_Modifier_3' , 'Amount' , '12');

--条件 首都
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
    VALUES ('CITY_HSA_GONGDIAN_XIXUEGUI', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
    VALUES ('CITY_HSA_GONGDIAN_XIXUEGUI', 'Requirement_CITY_HSA_GONGDIAN_XIXUEGUI');
INSERT INTO Requirements (RequirementId, RequirementType)
    VALUES ('Requirement_CITY_HSA_GONGDIAN_XIXUEGUI', 'REQUIREMENT_CITY_HAS_BUILDING');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
    VALUES ('Requirement_CITY_HSA_GONGDIAN_XIXUEGUI', 'BuildingType','BUILDING_PALACE');*/
--吸血鬼城堡 相邻获得产出
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentTerrain)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_TERRAIN_TUNDRA_HILLS', 'Placeholder',"YIELD_PRODUCTION","1","1","TERRAIN_TUNDRA_HILLS");
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentTerrain)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_TERRAIN_PLAINS_HILLS', 'Placeholder',"YIELD_PRODUCTION","1","1","TERRAIN_PLAINS_HILLS");
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentTerrain)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_TERRAIN_GRASS_HILLS', 'Placeholder',"YIELD_PRODUCTION","1","1","TERRAIN_GRASS_HILLS");
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentTerrain)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_TERRAIN_DESERT_HILLS', 'Placeholder',"YIELD_PRODUCTION","1","1","TERRAIN_DESERT_HILLS");

INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentFeature)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_FEATURE_FOREST', 'Placeholder',"YIELD_PRODUCTION","1","1","FEATURE_FOREST");
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentFeature)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_FEATURE_JUNGLE', 'Placeholder',"YIELD_PRODUCTION","1","1","FEATURE_JUNGLE");  

INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentResourceClass)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_RESOURCECLASS_BONUS', 'Placeholder',"YIELD_PRODUCTION","1","1","RESOURCECLASS_BONUS");
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentResourceClass)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_RESOURCECLASS_LUXURY', 'Placeholder',"YIELD_PRODUCTION","1","1","RESOURCECLASS_LUXURY");
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentResourceClass)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_RESOURCECLASS_STRATEGIC', 'Placeholder',"YIELD_PRODUCTION","1","1","RESOURCECLASS_STRATEGIC");

INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentImprovement)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_IMPROVEMENT_MINE', 'Placeholder',"YIELD_PRODUCTION","1","1","IMPROVEMENT_MINE");  
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentImprovement)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_IMPROVEMENT_LUMBER_MILL', 'Placeholder',"YIELD_PRODUCTION","1","1","IMPROVEMENT_LUMBER_MILL");
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentImprovement)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_IMPROVEMENT_FISHING_BOATS', 'Placeholder',"YIELD_PRODUCTION","1","1","IMPROVEMENT_FISHING_BOATS");
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentImprovement)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_IMPROVEMENT_PASTURE', 'Placeholder',"YIELD_PRODUCTION","1","1","IMPROVEMENT_PASTURE");
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentImprovement)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_IMPROVEMENT_PLANTATION', 'Placeholder',"YIELD_PRODUCTION","1","1","IMPROVEMENT_PLANTATION");
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentImprovement)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_IMPROVEMENT_QUARRY', 'Placeholder',"YIELD_PRODUCTION","1","1","IMPROVEMENT_QUARRY");
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentImprovement)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_IMPROVEMENT_CAMP', 'Placeholder',"YIELD_PRODUCTION","1","1","IMPROVEMENT_CAMP");
    

INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentDistrict)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_HOLY_SITE', 'Placeholder',"YIELD_FAITH","1","1","DISTRICT_HOLY_SITE"); 
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentDistrict)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_LAVRA', 'Placeholder',"YIELD_FAITH","1","1","DISTRICT_LAVRA"); 
    
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentDistrict)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_HARBOR', 'Placeholder',"YIELD_GOLD","2","1","DISTRICT_HARBOR");
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentDistrict)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_ROYAL_NAVY_DOCKYARD', 'Placeholder',"YIELD_GOLD","2","1","DISTRICT_ROYAL_NAVY_DOCKYARD"); 
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentDistrict)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_COTHON', 'Placeholder',"YIELD_GOLD","2","1","DISTRICT_COTHON"); 

INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentDistrict)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_COMMERCIAL_HUB', 'Placeholder',"YIELD_GOLD","2","1","DISTRICT_COMMERCIAL_HUB");
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentDistrict)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_SUGUBA', 'Placeholder',"YIELD_GOLD","2","1","DISTRICT_SUGUBA");

INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentDistrict)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_THEATER', 'Placeholder',"YIELD_CULTURE","1","1","DISTRICT_THEATER");
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentDistrict)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_ACROPOLIS', 'Placeholder',"YIELD_CULTURE","1","1","DISTRICT_ACROPOLIS"); 

INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentDistrict)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_INDUSTRIAL_ZONE', 'Placeholder',"YIELD_PRODUCTION","1","1","DISTRICT_INDUSTRIAL_ZONE");
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentDistrict)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_HANSA', 'Placeholder',"YIELD_PRODUCTION","1","1","DISTRICT_HANSA");
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentDistrict)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_OPPIDUM', 'Placeholder',"YIELD_PRODUCTION","1","1","DISTRICT_OPPIDUM"); 

INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentDistrict)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_CAMPUS', 'Placeholder',"YIELD_SCIENCE","1","1","DISTRICT_CAMPUS");
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentDistrict)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_OBSERVATORY', 'Placeholder',"YIELD_SCIENCE","1","1","DISTRICT_OBSERVATORY"); 
INSERT INTO Adjacency_YieldChanges(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentDistrict)
    VALUES ('XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_SEOWON', 'Placeholder',"YIELD_SCIENCE","1","1","DISTRICT_SEOWON"); 

INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_TERRAIN_TUNDRA_HILLS');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_TERRAIN_PLAINS_HILLS');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_TERRAIN_GRASS_HILLS');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_TERRAIN_DESERT_HILLS');

INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_FEATURE_FOREST');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_FEATURE_JUNGLE');

INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_RESOURCECLASS_BONUS');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_RESOURCECLASS_LUXURY');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_RESOURCECLASS_STRATEGIC');
	

INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_IMPROVEMENT_MINE');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_IMPROVEMENT_LUMBER_MILL');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_IMPROVEMENT_FISHING_BOATS');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_IMPROVEMENT_PASTURE');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_IMPROVEMENT_PLANTATION');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_IMPROVEMENT_QUARRY');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_IMPROVEMENT_CAMP');
	

INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_HOLY_SITE');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_LAVRA');

INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_HARBOR');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_ROYAL_NAVY_DOCKYARD');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_COTHON');

INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_COMMERCIAL_HUB');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_SUGUBA');

INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_THEATER');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_ACROPOLIS');

INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_INDUSTRIAL_ZONE');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_HANSA');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_OPPIDUM');
	

INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_CAMPUS');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_OBSERVATORY');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'XIXUEGUICHENGBAO_DIXING_ADD_DISTRICT_SEOWON');

INSERT INTO Improvement_YieldChanges (ImprovementType , YieldType , YieldChange)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'YIELD_PRODUCTION' , 5);
INSERT INTO Improvement_YieldChanges (ImprovementType , YieldType , YieldChange)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'YIELD_FAITH' , 0);
INSERT INTO Improvement_YieldChanges (ImprovementType , YieldType , YieldChange)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'YIELD_GOLD' , 0);
INSERT INTO Improvement_YieldChanges (ImprovementType , YieldType , YieldChange)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'YIELD_FOOD' , 9);
INSERT INTO Improvement_YieldChanges (ImprovementType , YieldType , YieldChange)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'YIELD_CULTURE' , 0);
INSERT INTO Improvement_YieldChanges (ImprovementType , YieldType , YieldChange)
	VALUES ('IMPROVEMENT_VAMPIRE_CASTLE' , 'YIELD_SCIENCE' , 0);
--镀金造船厂
--条件
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
VALUES
    ('REQUIRES_CITY_HAS_ZAOCHUANCHANG_TEAMPVP'		, 	'REQUIREMENT_DISTRICT_TYPE_MATCHES');
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name,Value)
VALUES
    ('REQUIRES_CITY_HAS_ZAOCHUANCHANG_TEAMPVP',     'DistrictType','DISTRICT_HARBOR');

INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY1'		, 	'REQUIREMENTSET_TEST_ALL'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY2', 	'REQUIREMENTSET_TEST_ALL'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY3'	, 	'REQUIREMENTSET_TEST_ALL'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY4'	, 	'REQUIREMENTSET_TEST_ALL'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY5'	, 	'REQUIREMENTSET_TEST_ALL'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY6'	, 	'REQUIREMENTSET_TEST_ALL'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY7'	, 	'REQUIREMENTSET_TEST_ALL'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY8'	, 	'REQUIREMENTSET_TEST_ALL'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY9'	, 	'REQUIREMENTSET_TEST_ALL'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY10'	, 	'REQUIREMENTSET_TEST_ALL'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY11'	, 	'REQUIREMENTSET_TEST_ALL'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY12'	, 	'REQUIREMENTSET_TEST_ALL');

INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY1'		, 	'REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY1'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY2', 	'REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY2'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY3'	, 	'REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY3'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY4', 	'REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY4'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY5', 	'REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY5'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY6', 	'REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY6'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY7', 	'REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY7'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY8', 	'REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY8'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY9', 	'REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY9'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY10', 	'REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY10'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY11', 	'REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY11'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY12', 	'REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY12');

INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY1'		, 	'REQUIRES_CITY_HAS_ZAOCHUANCHANG_TEAMPVP'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY2', 	'REQUIRES_CITY_HAS_ZAOCHUANCHANG_TEAMPVP'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY3'	, 	'REQUIRES_CITY_HAS_ZAOCHUANCHANG_TEAMPVP'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY4', 	'REQUIRES_CITY_HAS_ZAOCHUANCHANG_TEAMPVP'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY5', 	'REQUIRES_CITY_HAS_ZAOCHUANCHANG_TEAMPVP'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY6', 	'REQUIRES_CITY_HAS_ZAOCHUANCHANG_TEAMPVP'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY7', 	'REQUIRES_CITY_HAS_ZAOCHUANCHANG_TEAMPVP'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY8', 	'REQUIRES_CITY_HAS_ZAOCHUANCHANG_TEAMPVP'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY9', 	'REQUIRES_CITY_HAS_ZAOCHUANCHANG_TEAMPVP'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY10', 	'REQUIRES_CITY_HAS_ZAOCHUANCHANG_TEAMPVP'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY11', 	'REQUIRES_CITY_HAS_ZAOCHUANCHANG_TEAMPVP'),
    ('ZaoChuanChang_HAS_HIGH_ADJACENCY12', 	'REQUIRES_CITY_HAS_ZAOCHUANCHANG_TEAMPVP');

INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
VALUES
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY1'		, 	'REQUIREMENT_CITY_HAS_HIGH_ADJACENCY_DISTRICT'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY2', 	'REQUIREMENT_CITY_HAS_HIGH_ADJACENCY_DISTRICT'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY3'	, 	'REQUIREMENT_CITY_HAS_HIGH_ADJACENCY_DISTRICT'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY4', 	'REQUIREMENT_CITY_HAS_HIGH_ADJACENCY_DISTRICT'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY5', 	'REQUIREMENT_CITY_HAS_HIGH_ADJACENCY_DISTRICT'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY6', 	'REQUIREMENT_CITY_HAS_HIGH_ADJACENCY_DISTRICT'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY7', 	'REQUIREMENT_CITY_HAS_HIGH_ADJACENCY_DISTRICT'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY8', 	'REQUIREMENT_CITY_HAS_HIGH_ADJACENCY_DISTRICT'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY9', 	'REQUIREMENT_CITY_HAS_HIGH_ADJACENCY_DISTRICT'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY10', 	'REQUIREMENT_CITY_HAS_HIGH_ADJACENCY_DISTRICT'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY11', 	'REQUIREMENT_CITY_HAS_HIGH_ADJACENCY_DISTRICT'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY12', 	'REQUIREMENT_CITY_HAS_HIGH_ADJACENCY_DISTRICT');

INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name,Value)
VALUES
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY1',     'DistrictType','DISTRICT_HARBOR'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY2', 	'DistrictType','DISTRICT_HARBOR'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY3', 	'DistrictType','DISTRICT_HARBOR'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY4', 	'DistrictType','DISTRICT_HARBOR'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY5', 	'DistrictType','DISTRICT_HARBOR'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY6', 	'DistrictType','DISTRICT_HARBOR'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY7', 	'DistrictType','DISTRICT_HARBOR'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY8', 	'DistrictType','DISTRICT_HARBOR'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY9', 	'DistrictType','DISTRICT_HARBOR'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY10', 	'DistrictType','DISTRICT_HARBOR'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY11', 	'DistrictType','DISTRICT_HARBOR'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY12', 	'DistrictType','DISTRICT_HARBOR');

INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name,Value)
VALUES
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY1'		, 	'YieldType','YIELD_GOLD'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY2', 	'YieldType','YIELD_GOLD'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY3'	, 	'YieldType','YIELD_GOLD'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY4', 	'YieldType','YIELD_GOLD'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY5', 	'YieldType','YIELD_GOLD'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY6', 	'YieldType','YIELD_GOLD'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY7', 	'YieldType','YIELD_GOLD'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY8', 	'YieldType','YIELD_GOLD'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY9', 	'YieldType','YIELD_GOLD'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY10', 	'YieldType','YIELD_GOLD'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY11', 	'YieldType','YIELD_GOLD'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY12', 	'YieldType','YIELD_GOLD');

INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name,Value)
VALUES
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY1'		, 	'Amount','1'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY2', 	'Amount','2'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY3'	, 	'Amount','3'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY4', 	'Amount','4'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY5', 	'Amount','5'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY6', 	'Amount','6'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY7', 	'Amount','7'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY8', 	'Amount','8'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY9', 	'Amount','9'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY10', 	'Amount','10'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY11', 	'Amount','11'),
    ('REQUIRES_ZaoChuanChang_HAS_HIGH_ADJACENCY12', 	'Amount','12');

INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType,SubjectRequirementSetId)
VALUES
    ('ZaoChuanChang_MODIFIER_NEW1', 'MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE', 'ZaoChuanChang_HAS_HIGH_ADJACENCY1'),
    ('ZaoChuanChang_MODIFIER_NEW2', 'MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE', 'ZaoChuanChang_HAS_HIGH_ADJACENCY2'),
    ('ZaoChuanChang_MODIFIER_NEW3', 'MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE', 'ZaoChuanChang_HAS_HIGH_ADJACENCY3'),
    ('ZaoChuanChang_MODIFIER_NEW4', 'MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE', 'ZaoChuanChang_HAS_HIGH_ADJACENCY4'),
    ('ZaoChuanChang_MODIFIER_NEW5', 'MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE', 'ZaoChuanChang_HAS_HIGH_ADJACENCY5'),
    ('ZaoChuanChang_MODIFIER_NEW6', 'MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE', 'ZaoChuanChang_HAS_HIGH_ADJACENCY6'),
    ('ZaoChuanChang_MODIFIER_NEW7', 'MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE', 'ZaoChuanChang_HAS_HIGH_ADJACENCY7'),
    ('ZaoChuanChang_MODIFIER_NEW8', 'MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE', 'ZaoChuanChang_HAS_HIGH_ADJACENCY8'),
    ('ZaoChuanChang_MODIFIER_NEW9', 'MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE', 'ZaoChuanChang_HAS_HIGH_ADJACENCY9'),
    ('ZaoChuanChang_MODIFIER_NEW10', 'MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE', 'ZaoChuanChang_HAS_HIGH_ADJACENCY10'),
    ('ZaoChuanChang_MODIFIER_NEW11', 'MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE', 'ZaoChuanChang_HAS_HIGH_ADJACENCY11'),
    ('ZaoChuanChang_MODIFIER_NEW12', 'MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE', 'ZaoChuanChang_HAS_HIGH_ADJACENCY12');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name,Value)
VALUES
    ('ZaoChuanChang_MODIFIER_NEW1', 'YieldType', 'YIELD_PRODUCTION'),
    ('ZaoChuanChang_MODIFIER_NEW2', 'YieldType', 'YIELD_PRODUCTION'),
    ('ZaoChuanChang_MODIFIER_NEW3', 'YieldType', 'YIELD_PRODUCTION'),
    ('ZaoChuanChang_MODIFIER_NEW4', 'YieldType', 'YIELD_PRODUCTION'),
    ('ZaoChuanChang_MODIFIER_NEW5', 'YieldType', 'YIELD_PRODUCTION'),
    ('ZaoChuanChang_MODIFIER_NEW6', 'YieldType', 'YIELD_PRODUCTION'),
    ('ZaoChuanChang_MODIFIER_NEW7', 'YieldType', 'YIELD_PRODUCTION'),
    ('ZaoChuanChang_MODIFIER_NEW8', 'YieldType', 'YIELD_PRODUCTION'),
    ('ZaoChuanChang_MODIFIER_NEW9', 'YieldType', 'YIELD_PRODUCTION'),
    ('ZaoChuanChang_MODIFIER_NEW10', 'YieldType', 'YIELD_PRODUCTION'),
    ('ZaoChuanChang_MODIFIER_NEW11', 'YieldType', 'YIELD_PRODUCTION'),
    ('ZaoChuanChang_MODIFIER_NEW12', 'YieldType', 'YIELD_PRODUCTION');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name,Value)
VALUES
    ('ZaoChuanChang_MODIFIER_NEW1', 'Amount', '1'),
    ('ZaoChuanChang_MODIFIER_NEW2', 'Amount', '1'),
    ('ZaoChuanChang_MODIFIER_NEW3', 'Amount', '1'),
    ('ZaoChuanChang_MODIFIER_NEW4', 'Amount', '1'),
    ('ZaoChuanChang_MODIFIER_NEW5', 'Amount', '1'),
    ('ZaoChuanChang_MODIFIER_NEW6', 'Amount', '1'),
    ('ZaoChuanChang_MODIFIER_NEW7', 'Amount', '1'),
    ('ZaoChuanChang_MODIFIER_NEW8', 'Amount', '1'),
    ('ZaoChuanChang_MODIFIER_NEW9', 'Amount', '1'),
    ('ZaoChuanChang_MODIFIER_NEW10', 'Amount', '1'),
    ('ZaoChuanChang_MODIFIER_NEW11', 'Amount', '1'),
    ('ZaoChuanChang_MODIFIER_NEW12', 'Amount', '1');

INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES
    ('BUILDING_GILDED_Shipyard', 'ZaoChuanChang_MODIFIER_NEW1'),
    ('BUILDING_GILDED_Shipyard', 'ZaoChuanChang_MODIFIER_NEW2'),
    ('BUILDING_GILDED_Shipyard', 'ZaoChuanChang_MODIFIER_NEW3'),
    ('BUILDING_GILDED_Shipyard', 'ZaoChuanChang_MODIFIER_NEW4'),
    ('BUILDING_GILDED_Shipyard', 'ZaoChuanChang_MODIFIER_NEW5'),
    ('BUILDING_GILDED_Shipyard', 'ZaoChuanChang_MODIFIER_NEW6'),
    ('BUILDING_GILDED_Shipyard', 'ZaoChuanChang_MODIFIER_NEW7'),
    ('BUILDING_GILDED_Shipyard', 'ZaoChuanChang_MODIFIER_NEW8'),
    ('BUILDING_GILDED_Shipyard', 'ZaoChuanChang_MODIFIER_NEW9'),
    ('BUILDING_GILDED_Shipyard', 'ZaoChuanChang_MODIFIER_NEW10'),
    ('BUILDING_GILDED_Shipyard', 'ZaoChuanChang_MODIFIER_NEW11'),
    ('BUILDING_GILDED_Shipyard', 'ZaoChuanChang_MODIFIER_NEW12');