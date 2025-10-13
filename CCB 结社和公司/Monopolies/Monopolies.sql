-- 行业
UPDATE ModifierArguments SET Value='7' WHERE ModifierId='INDUSTRY_SCIENCE_YIELD_BONUS' AND Name='Amount';
UPDATE ModifierArguments SET Value='7' WHERE ModifierId='INDUSTRY_CULTURE_YIELD_BONUS' AND Name='Amount';
UPDATE ModifierArguments SET Value='10' WHERE ModifierId='INDUSTRY_CITY_GROWTH' AND Name='Amount';
UPDATE ModifierArguments SET Value='15' WHERE ModifierId='INDUSTRY_MILITARY_UNIT_DISCOUNT' AND Name='Amount';
UPDATE ModifierArguments SET Value='15' WHERE ModifierId='INDUSTRY_CIVILIAN_UNIT_DISCOUNT' AND Name='Amount';
UPDATE ModifierArguments SET Value='15' WHERE ModifierId='INDUSTRY_BUILDING_DISCOUNT' AND Name='Amount';
UPDATE ModifierArguments SET Value='15' WHERE ModifierId='INDUSTRY_GOLD_YIELD_BONUS' AND Name='Amount';
UPDATE ModifierArguments SET Value='20' WHERE ModifierId='INDUSTRY_FAITH_YIELD_BONUS' AND Name='Amount';

-- 公司
UPDATE ModifierArguments SET Value='15' WHERE ModifierId='CORPORATION_SCIENCE_YIELD_BONUS' AND Name='Amount';
UPDATE ModifierArguments SET Value='15' WHERE ModifierId='CORPORATION_CULTURE_YIELD_BONUS' AND Name='Amount';
UPDATE ModifierArguments SET Value='20' WHERE ModifierId='CORPORATION_CITY_GROWTH' AND Name='Amount';
UPDATE ModifierArguments SET Value='30' WHERE ModifierId='CORPORATION_BUILDING_DISCOUNT' AND Name='Amount';
UPDATE ModifierArguments SET Value='30' WHERE ModifierId='CORPORATION_MILITARY_UNIT_DISCOUNT' AND Name='Amount';
UPDATE ModifierArguments SET Value='30' WHERE ModifierId='CORPORATION_CIVILIAN_UNIT_DISCOUNT' AND Name='Amount';
UPDATE ModifierArguments SET Value='30' WHERE ModifierId='CORPORATION_GOLD_YIELD_BONUS' AND Name='Amount';
UPDATE ModifierArguments SET Value='40' WHERE ModifierId='CORPORATION_FAITH_YIELD_BONUS' AND Name='Amount';

-- 产品
UPDATE ModifierArguments SET Value='7' WHERE ModifierId LIKE 'PRODUCT\_SCIENCE\_YIELD\_BONUS\_%' ESCAPE '\' AND Name='Amount';
UPDATE ModifierArguments SET Value='10' WHERE ModifierId LIKE 'PRODUCT\_CITY\_GROWTH\_%' ESCAPE '\' AND Name='Amount';
UPDATE ModifierArguments SET Value='15' WHERE ModifierId LIKE 'PRODUCT\_BUILDING\_DISCOUNT\_%' ESCAPE '\' AND Name='Amount';
UPDATE ModifierArguments SET Value='15' WHERE ModifierId LIKE 'PRODUCT\_MILITARY\_UNIT\_DISCOUNT\_%' ESCAPE '\' AND Name='Amount';
UPDATE ModifierArguments SET Value='15' WHERE ModifierId LIKE 'PRODUCT\_GOLD\_YIELD\_BONUS\_%' ESCAPE '\' AND Name='Amount';
UPDATE ModifierArguments SET Value='15' WHERE ModifierId LIKE 'PRODUCT\_FAITH\_YIELD\_BONUS\_%' ESCAPE '\' AND Name='Amount';
UPDATE ModifierArguments SET Value='15' WHERE ModifierId LIKE 'PRODUCT\_CIVILIAN\_UNIT\_DISCOUNT\_%' ESCAPE '\' AND Name='Amount';

-- 取消垄断
UPDATE GlobalParameters
SET Value = 101
WHERE Name IN (
   'MONOPOLY_REQUIRED_RESOURCE_CONTROL_PERCENTAGE',
   'MONOPOLY_REQUIRED_RESOURCE_CONTROL_PERCENTAGE_MED',
   'MONOPOLY_REQUIRED_RESOURCE_CONTROL_PERCENTAGE_MAX'
);