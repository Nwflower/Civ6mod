-- 初始政体：部落
INSERT INTO Types(Type, Kind)
VALUES ('GOVERNMENT_BULUO', 'KIND_GOVERNMENT');

INSERT INTO Governments(GovernmentType, Name, PrereqCivic, InherentBonusDesc, AccumulatedBonusShortDesc,
                        AccumulatedBonusDesc, OtherGovernmentIntolerance, InfluencePointsPerTurn,
                        InfluencePointsThreshold, InfluenceTokensPerThreshold, BonusType, PolicyToUnlock, Tier)
SELECT 'GOVERNMENT_BULUO',
       'LOC_GOVERNMENT_BULUO_NAME',
       NULL,
       InherentBonusDesc,
       AccumulatedBonusShortDesc,
       AccumulatedBonusDesc,
       OtherGovernmentIntolerance,
       0,
       InfluencePointsThreshold,
       InfluenceTokensPerThreshold,
       BonusType,
       PolicyToUnlock,
       Tier
FROM Governments
WHERE GovernmentType = 'GOVERNMENT_CHIEFDOM';

INSERT INTO Governments_XP2(GovernmentType, Favor) SELECT
'GOVERNMENT_BULUO',Favor
FROM Governments_XP2 WHERE GovernmentType = 'GOVERNMENT_CHIEFDOM';

-- 酋邦后移
UPDATE Governments SET PrereqCivic = 'CIVIC_CODE_OF_LAWS',BonusType = 'GOVERNMENTBONUS_ENVOYS' WHERE GovernmentType = 'GOVERNMENT_CHIEFDOM';
UPDATE StartingGovernments SET Government = 'GOVERNMENT_BULUO' WHERE Government = 'GOVERNMENT_CHIEFDOM';
UPDATE Governments_XP2 SET Favor = Favor + 1 WHERE GovernmentType = 'GOVERNMENT_CHIEFDOM';


-- 神秘主义解锁法老：1军事1通配
INSERT INTO Types(Type, Kind)
VALUES ('GOVERNMENT_PHARAOH', 'KIND_GOVERNMENT');

INSERT INTO Governments(GovernmentType, Name, PrereqCivic, InherentBonusDesc, AccumulatedBonusShortDesc,
                        AccumulatedBonusDesc, OtherGovernmentIntolerance, InfluencePointsPerTurn,
                        InfluencePointsThreshold, InfluenceTokensPerThreshold, BonusType, PolicyToUnlock, Tier)
SELECT 'GOVERNMENT_PHARAOH',
       'LOC_GOVERNMENT_PHARAOH_NAME',
       'CIVIC_MYSTICISM',
       'LOC_GOVT_INHERENT_BONUS_PHARAOH',
       AccumulatedBonusShortDesc,
       AccumulatedBonusDesc,
       OtherGovernmentIntolerance,
       2,
       InfluencePointsThreshold,
       InfluenceTokensPerThreshold,
       'GOVERNMENTBONUS_ENVOYS',
       PolicyToUnlock,
       'Tier1'
FROM Governments
WHERE GovernmentType = 'GOVERNMENT_BULUO';

INSERT INTO Government_SlotCounts(GovernmentType, GovernmentSlotType, NumSlots) VALUES
('GOVERNMENT_PHARAOH','SLOT_MILITARY',1),
('GOVERNMENT_PHARAOH','SLOT_WILDCARD',1);


INSERT INTO GovernmentModifiers (GovernmentType, ModifierId) SELECT
'GOVERNMENT_PHARAOH', 'MODIFIER_GOVERNMENT_PHARAOH_ADD_CAPITAL_'||YieldType
FROM Yields;
INSERT INTO Modifiers (ModifierId, ModifierType) SELECT
'MODIFIER_GOVERNMENT_PHARAOH_ADD_CAPITAL_'||YieldType, 'MODIFIER_PLAYER_CAPITAL_CITY_ADJUST_CITY_YIELD_CHANGE'
FROM Yields;

INSERT INTO ModifierArguments (ModifierId, Name, Value) SELECT
'MODIFIER_GOVERNMENT_PHARAOH_ADD_CAPITAL_'||YieldType, 'Amount', 1
FROM Yields UNION SELECT
'MODIFIER_GOVERNMENT_PHARAOH_ADD_CAPITAL_'||YieldType, 'YieldType', YieldType
FROM Yields;

UPDATE Civics SET UITreeRow = 2 WHERE CivicType = 'CIVIC_MYSTICISM' AND UITreeRow = 3;

INSERT INTO Governments_XP2(GovernmentType, Favor) SELECT
'GOVERNMENT_PHARAOH',Favor + 1
FROM Governments_XP2 WHERE GovernmentType = 'GOVERNMENT_BULUO';

-- 帝国初期：分封
INSERT INTO Types(Type, Kind)
VALUES ('GOVERNMENT_FENFENG', 'KIND_GOVERNMENT');

INSERT INTO Governments(GovernmentType, Name, PrereqCivic, InherentBonusDesc, AccumulatedBonusShortDesc,
                        AccumulatedBonusDesc, OtherGovernmentIntolerance, InfluencePointsPerTurn,
                        InfluencePointsThreshold, InfluenceTokensPerThreshold, BonusType, PolicyToUnlock, Tier)
SELECT 'GOVERNMENT_FENFENG',
       'LOC_GOVERNMENT_FENFENG_NAME',
       'CIVIC_EARLY_EMPIRE',
       'LOC_GOVT_INHERENT_BONUS_FENFENG',
       AccumulatedBonusShortDesc,
       AccumulatedBonusDesc,
       OtherGovernmentIntolerance,
       2,
       InfluencePointsThreshold,
       InfluenceTokensPerThreshold,
       'GOVERNMENTBONUS_ENVOYS',
       PolicyToUnlock,
       'Tier1'
FROM Governments
WHERE GovernmentType = 'GOVERNMENT_BULUO';

INSERT INTO Government_SlotCounts(GovernmentType, GovernmentSlotType, NumSlots) VALUES
('GOVERNMENT_FENFENG','SLOT_ECONOMIC',2);


INSERT INTO GovernmentModifiers (GovernmentType, ModifierId) VALUES
('GOVERNMENT_FENFENG', 'MODIFIER_GOVERNMENT_FENFENG_MINI_PLOT_COST');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_GOVERNMENT_FENFENG_MINI_PLOT_COST', 'MODIFIER_PLAYER_CITIES_ADJUST_PLOT_PURCHASE_COST', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GOVERNMENT_FENFENG_MINI_PLOT_COST', 'Amount', '-20');

INSERT INTO Governments_XP2(GovernmentType, Favor) SELECT
'GOVERNMENT_FENFENG',Favor + 1
FROM Governments_XP2 WHERE GovernmentType = 'GOVERNMENT_BULUO';

-- 封建主义：郡县制
INSERT INTO Types(Type, Kind)
VALUES ('GOVERNMENT_JUNXUANZHI', 'KIND_GOVERNMENT');
INSERT INTO Governments(GovernmentType, Name, PrereqCivic, InherentBonusDesc, AccumulatedBonusShortDesc,
                        AccumulatedBonusDesc, OtherGovernmentIntolerance, InfluencePointsPerTurn,
                        InfluencePointsThreshold, InfluenceTokensPerThreshold, BonusType, PolicyToUnlock, Tier)
SELECT 'GOVERNMENT_JUNXUANZHI',
       'LOC_GOVERNMENT_JUNXUANZHI_NAME',
       'CIVIC_FEUDALISM',
       'LOC_GOVT_INHERENT_BONUS_JUNXUANZHI',
       'LOC_GOVT_ACCUMULATE_BONUS_JUNXUANZHI',
       'LOC_GOVT_ACCUMULATE_BONUS_JUNXUANZHI',
       OtherGovernmentIntolerance,
       InfluencePointsPerTurn + 1,
       InfluencePointsThreshold,
       InfluenceTokensPerThreshold,
       BonusType,
       PolicyToUnlock,
       Tier
FROM Governments
WHERE GovernmentType = 'GOVERNMENT_AUTOCRACY';
INSERT INTO Government_SlotCounts(GovernmentType, GovernmentSlotType, NumSlots) VALUES
('GOVERNMENT_JUNXUANZHI','SLOT_MILITARY',2),
('GOVERNMENT_JUNXUANZHI','SLOT_ECONOMIC',1),
('GOVERNMENT_JUNXUANZHI','SLOT_DIPLOMATIC',1),
('GOVERNMENT_JUNXUANZHI','SLOT_WILDCARD',1);
INSERT INTO Governments_XP2(GovernmentType, Favor) SELECT
'GOVERNMENT_JUNXUANZHI',Favor
FROM Governments_XP2 WHERE GovernmentType = 'GOVERNMENT_AUTOCRACY';


INSERT INTO GovernmentModifiers (GovernmentType, ModifierId) VALUES
('GOVERNMENT_JUNXUANZHI', 'MODIFIER_GOVERNMENT_JUNXUANZHI_ATTACH');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_GOVERNMENT_JUNXUANZHI_ATTACH', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GOVERNMENT_JUNXUANZHI_ATTACH', 'ModifierId', 'MODIFIER_GOVERNMENT_JUNXUANZHI_YIELD_MODIFIER');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_GOVERNMENT_JUNXUANZHI_YIELD_MODIFIER', 'MODIFIER_PLAYER_CAPITAL_CITY_ADJUST_CITY_YIELD_MODIFIER', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GOVERNMENT_JUNXUANZHI_YIELD_MODIFIER', 'Amount', '10,10,10,10,10'),
('MODIFIER_GOVERNMENT_JUNXUANZHI_YIELD_MODIFIER', 'YieldType', 'YIELD_PRODUCTION,YIELD_SCIENCE,YIELD_GOLD,YIELD_CULTURE,YIELD_FAITH');

INSERT INTO GovernmentModifiers (GovernmentType, ModifierId) VALUES
('GOVERNMENT_JUNXUANZHI', 'MODIFIER_GOVERNMENT_JUNXUANZHI_ADJUST_IDENTITY_PER_TURN');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_GOVERNMENT_JUNXUANZHI_ADJUST_IDENTITY_PER_TURN', 'MODIFIER_PLAYER_CITIES_ADJUST_IDENTITY_PER_TURN', 0, 0, 0, NULL, 'CITY_HAS_GOVERNOR_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GOVERNMENT_JUNXUANZHI_ADJUST_IDENTITY_PER_TURN', 'Amount', '10');


-- 行政部门：封臣强化
INSERT INTO Types(Type, Kind)
VALUES ('GOVERNMENT_XINGSHENGFENQUAN', 'KIND_GOVERNMENT');
INSERT INTO Governments(GovernmentType, Name, PrereqCivic, InherentBonusDesc, AccumulatedBonusShortDesc,
                        AccumulatedBonusDesc, OtherGovernmentIntolerance, InfluencePointsPerTurn,
                        InfluencePointsThreshold, InfluenceTokensPerThreshold, BonusType, PolicyToUnlock, Tier)
SELECT 'GOVERNMENT_XINGSHENGFENQUAN',
       'LOC_GOVERNMENT_XINGSHENGFENQUAN_NAME',
       'CIVIC_CIVIL_SERVICE',
       'LOC_GOVT_INHERENT_BONUS_XINGSHENGFENQUAN',
       'LOC_GOVT_ACCUMULATE_BONUS_XINGSHENGFENQUAN',
       'LOC_GOVT_ACCUMULATE_BONUS_XINGSHENGFENQUAN',
       OtherGovernmentIntolerance,
       InfluencePointsPerTurn + 1,
       InfluencePointsThreshold,
       InfluenceTokensPerThreshold,
       BonusType,
       PolicyToUnlock,
       Tier
FROM Governments
WHERE GovernmentType = 'GOVERNMENT_AUTOCRACY';
INSERT INTO Government_SlotCounts(GovernmentType, GovernmentSlotType, NumSlots) VALUES
('GOVERNMENT_XINGSHENGFENQUAN','SLOT_MILITARY',1),
('GOVERNMENT_XINGSHENGFENQUAN','SLOT_ECONOMIC',2),
('GOVERNMENT_XINGSHENGFENQUAN','SLOT_DIPLOMATIC',1),
('GOVERNMENT_XINGSHENGFENQUAN','SLOT_WILDCARD',1);
INSERT INTO Governments_XP2(GovernmentType, Favor) SELECT
'GOVERNMENT_XINGSHENGFENQUAN',Favor
FROM Governments_XP2 WHERE GovernmentType = 'GOVERNMENT_AUTOCRACY';


INSERT INTO GovernmentModifiers (GovernmentType, ModifierId) VALUES
('GOVERNMENT_XINGSHENGFENQUAN', 'MODIFIER_GOVERNMENT_XINGSHENGFENQUAN_UNIT_PRODUCTION');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_GOVERNMENT_XINGSHENGFENQUAN_UNIT_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_PRODUCTION_MODIFIER', 0, 0, 0, NULL, 'CITY_HAS_GOVERNOR_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GOVERNMENT_XINGSHENGFENQUAN_UNIT_PRODUCTION', 'Amount', '20');


INSERT INTO GovernmentModifiers (GovernmentType, ModifierId) VALUES
('GOVERNMENT_XINGSHENGFENQUAN', 'MODIFIER_GOVERNMENT_XINGSHENGFENQUAN_CAPITAL_ATTACH');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_GOVERNMENT_XINGSHENGFENQUAN_CAPITAL_ATTACH', 'MODIFIER_PLAYER_NW_CAPITAL_DIS_ATTACH_MODIFIER', 0, 0, 0, NULL, 'BUILDING_IS_PALACE');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GOVERNMENT_XINGSHENGFENQUAN_CAPITAL_ATTACH', 'ModifierId', 'MODIFIER_GOVERNMENT_XINGSHENGFENQUAN_YIELD');

-- Custom ModifierType
INSERT INTO Types (Type, Kind) VALUES
('MODIFIER_PLAYER_NW_CAPITAL_DIS_ATTACH_MODIFIER', 'KIND_MODIFIER');
INSERT INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES
('MODIFIER_PLAYER_NW_CAPITAL_DIS_ATTACH_MODIFIER', 'COLLECTION_PLAYER_DISTRICTS', 'EFFECT_ATTACH_MODIFIER');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_GOVERNMENT_XINGSHENGFENQUAN_YIELD', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', 0, 0, 0, NULL, 'BUILDING_IS_PALACE');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GOVERNMENT_XINGSHENGFENQUAN_YIELD', 'Amount', '10,10,10,10,10'),
('MODIFIER_GOVERNMENT_XINGSHENGFENQUAN_YIELD', 'YieldType', 'YIELD_PRODUCTION,YIELD_SCIENCE,YIELD_GOLD,YIELD_CULTURE,YIELD_FAITH');


-- 雇佣兵：贵族共和
INSERT INTO Types(Type, Kind)
VALUES ('GOVERNMENT_GUIZUGONGHE', 'KIND_GOVERNMENT');
INSERT INTO Governments(GovernmentType, Name, PrereqCivic, InherentBonusDesc, AccumulatedBonusShortDesc,
                        AccumulatedBonusDesc, OtherGovernmentIntolerance, InfluencePointsPerTurn,
                        InfluencePointsThreshold, InfluenceTokensPerThreshold, BonusType, PolicyToUnlock, Tier)
SELECT 'GOVERNMENT_GUIZUGONGHE',
       'LOC_GOVERNMENT_GUIZUGONGHE_NAME',
       'CIVIC_MERCENARIES',
       'LOC_GOVT_INHERENT_BONUS_JUNXUANZHI',
       'LOC_GOVT_ACCUMULATE_BONUS_GUIZUGONGHE',
       'LOC_GOVT_ACCUMULATE_BONUS_GUIZUGONGHE',
       OtherGovernmentIntolerance,
       InfluencePointsPerTurn + 1,
       InfluencePointsThreshold,
       InfluenceTokensPerThreshold,
       BonusType,
       PolicyToUnlock,
       Tier
FROM Governments
WHERE GovernmentType = 'GOVERNMENT_AUTOCRACY';
INSERT INTO Government_SlotCounts(GovernmentType, GovernmentSlotType, NumSlots) VALUES
('GOVERNMENT_GUIZUGONGHE','SLOT_MILITARY',1),
('GOVERNMENT_GUIZUGONGHE','SLOT_ECONOMIC',2),
('GOVERNMENT_GUIZUGONGHE','SLOT_DIPLOMATIC',0),
('GOVERNMENT_GUIZUGONGHE','SLOT_WILDCARD',2);
INSERT INTO Governments_XP2(GovernmentType, Favor) SELECT
'GOVERNMENT_GUIZUGONGHE',Favor
FROM Governments_XP2 WHERE GovernmentType = 'GOVERNMENT_AUTOCRACY';


INSERT INTO GovernmentModifiers (GovernmentType, ModifierId) VALUES
('GOVERNMENT_GUIZUGONGHE', 'MODIFIER_GOVERNMENT_GUIZUGONGHE_WONDER_GOLD');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_GOVERNMENT_GUIZUGONGHE_WONDER_GOLD', 'MODIFIER_NW_PLAYER_CITYS_ADJUST_WONDER_YIELD_CHANGE', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GOVERNMENT_GUIZUGONGHE_WONDER_GOLD', 'Amount', '4'),
('MODIFIER_GOVERNMENT_GUIZUGONGHE_WONDER_GOLD', 'YieldType', 'YIELD_GOLD');

-- Custom ModifierType
INSERT INTO Types (Type, Kind) VALUES
('MODIFIER_NW_PLAYER_CITYS_ADJUST_WONDER_YIELD_CHANGE', 'KIND_MODIFIER');
INSERT INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES
('MODIFIER_NW_PLAYER_CITYS_ADJUST_WONDER_YIELD_CHANGE', 'COLLECTION_PLAYER_CITIES', 'EFFECT_ADJUST_WONDER_YIELD_CHANGE');


INSERT INTO GovernmentModifiers (GovernmentType, ModifierId) VALUES
('GOVERNMENT_GUIZUGONGHE', 'MODIFIER_GOVERNMENT_GUIZUGONGHE_MOVEMENT');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_GOVERNMENT_GUIZUGONGHE_MOVEMENT', 'MODIFIER_PLAYER_UNITS_ADJUST_SEA_MOVEMENT', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GOVERNMENT_GUIZUGONGHE_MOVEMENT', 'Amount', '1');



-- 殖民主义：宗主集权殖民

INSERT INTO Types(Type, Kind)
VALUES ('GOVERNMENT_NW1', 'KIND_GOVERNMENT');
INSERT INTO Governments(GovernmentType, Name, PrereqCivic, InherentBonusDesc, AccumulatedBonusShortDesc,
                        AccumulatedBonusDesc, OtherGovernmentIntolerance, InfluencePointsPerTurn,
                        InfluencePointsThreshold, InfluenceTokensPerThreshold, BonusType, PolicyToUnlock, Tier)
SELECT 'GOVERNMENT_NW1',
       'LOC_GOVERNMENT_NW1_NAME',
       'CIVIC_COLONIALISM',
       'LOC_GOVT_INHERENT_BONUS_NW1',
       'LOC_GOVT_ACCUMULATE_BONUS_NW1',
       'LOC_GOVT_ACCUMULATE_BONUS_NW1',
       OtherGovernmentIntolerance,
       InfluencePointsPerTurn + 1,
       InfluencePointsThreshold,
       InfluenceTokensPerThreshold,
       BonusType,
       PolicyToUnlock,
       Tier
FROM Governments
WHERE GovernmentType = 'GOVERNMENT_THEOCRACY';
INSERT INTO Government_SlotCounts(GovernmentType, GovernmentSlotType, NumSlots) VALUES
('GOVERNMENT_NW1','SLOT_MILITARY',1),
('GOVERNMENT_NW1','SLOT_ECONOMIC',3),
('GOVERNMENT_NW1','SLOT_DIPLOMATIC',1),
('GOVERNMENT_NW1','SLOT_WILDCARD',2);
INSERT INTO Governments_XP2(GovernmentType, Favor) SELECT
'GOVERNMENT_NW1',Favor
FROM Governments_XP2 WHERE GovernmentType = 'GOVERNMENT_THEOCRACY';

INSERT INTO GovernmentModifiers (GovernmentType, ModifierId) VALUES
('GOVERNMENT_NW1', 'MODIFIER_GOVERNMENT_NW1_ADD_POPULATION');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_GOVERNMENT_NW1_ADD_POPULATION', 'MODIFIER_PLAYER_CITIES_ADD_POPULATION', 0, 0, 1, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GOVERNMENT_NW1_ADD_POPULATION', 'Amount', '4');

INSERT INTO GovernmentModifiers (GovernmentType, ModifierId) VALUES
('GOVERNMENT_NW1', 'MODIFIER_GOVERNMENT_NW1_YIELD_MODIFIER');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_GOVERNMENT_NW1_YIELD_MODIFIER', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', 0, 0, 0, NULL, 'CITY_NOT_OWNER_CAPITAL_CONTINENT_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GOVERNMENT_NW1_YIELD_MODIFIER', 'Amount', '15,15,15,15,15'),
('MODIFIER_GOVERNMENT_NW1_YIELD_MODIFIER', 'YieldType', 'YIELD_PRODUCTION,YIELD_SCIENCE,YIELD_GOLD,YIELD_CULTURE,YIELD_FAITH');

INSERT INTO GovernmentModifiers (GovernmentType, ModifierId) VALUES
('GOVERNMENT_NW1', 'MODIFIER_GOVERNMENT_NW1_IDENTITY_PER_TURN');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_GOVERNMENT_NW1_IDENTITY_PER_TURN', 'MODIFIER_PLAYER_CITIES_ADJUST_IDENTITY_PER_TURN', 0, 0, 0, NULL, 'CITY_NOT_OWNER_CAPITAL_CONTINENT_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GOVERNMENT_NW1_IDENTITY_PER_TURN', 'Amount', '-5');

-- 贸易路线+8 [ICON_GOLD] 金币、+1 [ICON_CULTURE] 文化值。

INSERT INTO GovernmentModifiers (GovernmentType, ModifierId) VALUES
('GOVERNMENT_NW1', 'MODIFIER_GOVERNMENT_NW1_ROUTE_YIELD_1');
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
('MODIFIER_GOVERNMENT_NW1_ROUTE_YIELD_1', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GOVERNMENT_NW1_ROUTE_YIELD_1', 'Amount', 8),
('MODIFIER_GOVERNMENT_NW1_ROUTE_YIELD_1', 'YieldType', 'YIELD_GOLD');
INSERT INTO GovernmentModifiers (GovernmentType, ModifierId) VALUES
('GOVERNMENT_NW1', 'MODIFIER_GOVERNMENT_NW1_ROUTE_YIELD_2');
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
('MODIFIER_GOVERNMENT_NW1_ROUTE_YIELD_2', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GOVERNMENT_NW1_ROUTE_YIELD_2', 'Amount', 1),
('MODIFIER_GOVERNMENT_NW1_ROUTE_YIELD_2', 'YieldType', 'YIELD_CULTURE');

INSERT INTO GovernmentModifiers (GovernmentType, ModifierId) VALUES
('GOVERNMENT_NW1', 'MODIFIER_GOVERNMENT_NW1_ROUTE_YIELD_3');
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
('MODIFIER_GOVERNMENT_NW1_ROUTE_YIELD_3', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_DOMESTIC');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GOVERNMENT_NW1_ROUTE_YIELD_3', 'Amount', 8),
('MODIFIER_GOVERNMENT_NW1_ROUTE_YIELD_3', 'YieldType', 'YIELD_GOLD');
INSERT INTO GovernmentModifiers (GovernmentType, ModifierId) VALUES
('GOVERNMENT_NW1', 'MODIFIER_GOVERNMENT_NW1_ROUTE_YIELD_4');
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
('MODIFIER_GOVERNMENT_NW1_ROUTE_YIELD_4', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_DOMESTIC');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GOVERNMENT_NW1_ROUTE_YIELD_4', 'Amount', 1),
('MODIFIER_GOVERNMENT_NW1_ROUTE_YIELD_4', 'YieldType', 'YIELD_CULTURE');


-- 自由资本主义：重商主义

INSERT INTO Types(Type, Kind)
VALUES ('GOVERNMENT_NW2', 'KIND_GOVERNMENT');
INSERT INTO Governments(GovernmentType, Name, PrereqCivic, InherentBonusDesc, AccumulatedBonusShortDesc,
                        AccumulatedBonusDesc, OtherGovernmentIntolerance, InfluencePointsPerTurn,
                        InfluencePointsThreshold, InfluenceTokensPerThreshold, BonusType, PolicyToUnlock, Tier)
SELECT 'GOVERNMENT_NW2',
       'LOC_GOVERNMENT_NW2_NAME',
       'CIVIC_URBANIZATION',
       'LOC_GOVT_INHERENT_BONUS_NW2',
       'LOC_GOVT_ACCUMULATE_BONUS_NW2',
       'LOC_GOVT_ACCUMULATE_BONUS_NW2',
       OtherGovernmentIntolerance,
       InfluencePointsPerTurn + 1,
       InfluencePointsThreshold,
       InfluenceTokensPerThreshold,
       BonusType,
       PolicyToUnlock,
       Tier
FROM Governments
WHERE GovernmentType = 'GOVERNMENT_THEOCRACY';
INSERT INTO Government_SlotCounts(GovernmentType, GovernmentSlotType, NumSlots) VALUES
('GOVERNMENT_NW2','SLOT_MILITARY',0),
('GOVERNMENT_NW2','SLOT_ECONOMIC',4),
('GOVERNMENT_NW2','SLOT_DIPLOMATIC',2),
('GOVERNMENT_NW2','SLOT_WILDCARD',1);
INSERT INTO Governments_XP2(GovernmentType, Favor) SELECT
'GOVERNMENT_NW2',Favor
FROM Governments_XP2 WHERE GovernmentType = 'GOVERNMENT_THEOCRACY';

-- 商业中心和港口的 [ICON_GOLD] 金币相邻加成也提供 [ICON_PRODUCTION] 生产力。

INSERT INTO GovernmentModifiers (GovernmentType, ModifierId) VALUES
('GOVERNMENT_NW2', 'MODIFIER_GOVERNMENT_NW2_YIELD_BASED_ON_ADJACENCY_BONUS1');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_GOVERNMENT_NW2_YIELD_BASED_ON_ADJACENCY_BONUS1', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GOVERNMENT_NW2_YIELD_BASED_ON_ADJACENCY_BONUS1', 'DistrictType', 'DISTRICT_COMMERCIAL_HUB'),
('MODIFIER_GOVERNMENT_NW2_YIELD_BASED_ON_ADJACENCY_BONUS1', 'YieldTypeToGrant', 'YIELD_PRODUCTION'),
('MODIFIER_GOVERNMENT_NW2_YIELD_BASED_ON_ADJACENCY_BONUS1', 'YieldTypeToMirror', 'YIELD_GOLD');

INSERT INTO GovernmentModifiers (GovernmentType, ModifierId) VALUES
('GOVERNMENT_NW2', 'MODIFIER_GOVERNMENT_NW2_YIELD_BASED_ON_ADJACENCY_BONUS2');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_GOVERNMENT_NW2_YIELD_BASED_ON_ADJACENCY_BONUS2', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GOVERNMENT_NW2_YIELD_BASED_ON_ADJACENCY_BONUS2', 'DistrictType', 'DISTRICT_HARBOR'),
('MODIFIER_GOVERNMENT_NW2_YIELD_BASED_ON_ADJACENCY_BONUS2', 'YieldTypeToGrant', 'YIELD_PRODUCTION'),
('MODIFIER_GOVERNMENT_NW2_YIELD_BASED_ON_ADJACENCY_BONUS2', 'YieldTypeToMirror', 'YIELD_GOLD');

-- 每个回合开始时，获得等同于国库 [ICON_GOLD] 金币5%的利息。市场-1 [ICON_Amenities] 宜居度。
INSERT INTO GovernmentModifiers (GovernmentType, ModifierId) VALUES
('GOVERNMENT_NW2', 'MODIFIER_GOVERNMENT_NW2_MULTIPLY_TREASURY');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_GOVERNMENT_NW2_MULTIPLY_TREASURY', 'MODIFIER_PLAYER_MULTIPLY_TREASURY', 0, 1, 0, NULL, 'ON_TURN_STARTED');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GOVERNMENT_NW2_MULTIPLY_TREASURY', 'Amount', '5');

INSERT INTO GovernmentModifiers (GovernmentType, ModifierId) VALUES
('GOVERNMENT_NW2', 'MODIFIER_GOVERNMENT_NW2_POLICY_AMENITY');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_GOVERNMENT_NW2_POLICY_AMENITY', 'MODIFIER_PLAYER_CITIES_ADJUST_POLICY_AMENITY', 0, 0, 0, NULL, 'REQS_NW_GN_CITY_HAS_BUILDING_MARKET');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GOVERNMENT_NW2_POLICY_AMENITY', 'Amount', '-1');
-- RequirementSets
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('REQS_NW_GN_CITY_HAS_BUILDING_MARKET', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('REQS_NW_GN_CITY_HAS_BUILDING_MARKET', 'REQ_NW_GN_CITY_HAS_BUILDING_MARKET');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('REQ_NW_GN_CITY_HAS_BUILDING_MARKET', 'REQUIREMENT_CITY_HAS_BUILDING');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('REQ_NW_GN_CITY_HAS_BUILDING_MARKET', 'BuildingType', 'BUILDING_MARKET');


-- 民族主义：君主立宪
INSERT INTO Types(Type, Kind)
VALUES ('GOVERNMENT_NW3', 'KIND_GOVERNMENT');
INSERT INTO Governments(GovernmentType, Name, PrereqCivic, InherentBonusDesc, AccumulatedBonusShortDesc,
                        AccumulatedBonusDesc, OtherGovernmentIntolerance, InfluencePointsPerTurn,
                        InfluencePointsThreshold, InfluenceTokensPerThreshold, BonusType, PolicyToUnlock, Tier)
SELECT 'GOVERNMENT_NW3',
       'LOC_GOVERNMENT_NW3_NAME',
       'CIVIC_NATIONALISM',
       'LOC_GOVT_INHERENT_BONUS_NW3',
       'LOC_GOVT_ACCUMULATE_BONUS_NW3',
       'LOC_GOVT_ACCUMULATE_BONUS_NW3',
       OtherGovernmentIntolerance,
       InfluencePointsPerTurn + 1,
       InfluencePointsThreshold,
       InfluenceTokensPerThreshold,
       BonusType,
       PolicyToUnlock,
       Tier
FROM Governments
WHERE GovernmentType = 'GOVERNMENT_THEOCRACY';
INSERT INTO Government_SlotCounts(GovernmentType, GovernmentSlotType, NumSlots) VALUES
('GOVERNMENT_NW3','SLOT_MILITARY',3),
('GOVERNMENT_NW3','SLOT_ECONOMIC',2),
('GOVERNMENT_NW3','SLOT_DIPLOMATIC',1),
('GOVERNMENT_NW3','SLOT_WILDCARD',1);
INSERT INTO Governments_XP2(GovernmentType, Favor) SELECT
'GOVERNMENT_NW3',Favor
FROM Governments_XP2 WHERE GovernmentType = 'GOVERNMENT_THEOCRACY';


INSERT INTO GovernmentModifiers (GovernmentType, ModifierId) SELECT
'GOVERNMENT_NW3', 'MODIFIER_GOVERNMENT_NW3_'||TechnologyType
FROM Technologies;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) SELECT
'MODIFIER_GOVERNMENT_NW3_'||TechnologyType, 'MODIFIER_PLAYER_ADJUST_YIELD_CHANGE', 'NW_PLAYER_HAS_' || TechnologyType
FROM Technologies;
INSERT INTO ModifierArguments (ModifierId, Name, Value) SELECT
'MODIFIER_GOVERNMENT_NW3_'||TechnologyType, 'Amount', '1'
FROM Technologies UNION SELECT
'MODIFIER_GOVERNMENT_NW3_'||TechnologyType, 'YieldType', 'YIELD_CULTURE'
FROM Technologies;

INSERT INTO GovernmentModifiers (GovernmentType, ModifierId) SELECT
'GOVERNMENT_NW3', 'MODIFIER_GOVERNMENT_NW3_'||CivicType
FROM Civics;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) SELECT
'MODIFIER_GOVERNMENT_NW3_'||CivicType, 'MODIFIER_PLAYER_ADJUST_YIELD_CHANGE', 'NW_PLAYER_HAS_' || CivicType
FROM Civics;
INSERT INTO ModifierArguments (ModifierId, Name, Value) SELECT
'MODIFIER_GOVERNMENT_NW3_'||CivicType, 'Amount', 1
FROM Civics UNION SELECT
'MODIFIER_GOVERNMENT_NW3_'||CivicType, 'YieldType', 'YIELD_SCIENCE'
FROM Civics;

-- 玩家拥有某科技
INSERT OR IGNORE INTO RequirementSets(RequirementSetId, RequirementSetType)
SELECT 'NW_PLAYER_HAS_' || TechnologyType, 'REQUIREMENTSET_TEST_ALL'
FROM Technologies;
INSERT OR IGNORE INTO Requirements(RequirementId, RequirementType)
SELECT 'NW_UTILS_PLAYER_HAS_' || TechnologyType || '_REQUIREMENT', 'REQUIREMENT_PLAYER_HAS_TECHNOLOGY'
FROM Technologies;
INSERT OR IGNORE INTO RequirementArguments(RequirementId, Name, Value)
SELECT 'NW_UTILS_PLAYER_HAS_' || TechnologyType || '_REQUIREMENT', 'TechnologyType', TechnologyType
FROM Technologies;
INSERT OR IGNORE INTO RequirementSetRequirements(RequirementSetId, RequirementId)
SELECT 'NW_PLAYER_HAS_' || TechnologyType, 'NW_UTILS_PLAYER_HAS_' || TechnologyType || '_REQUIREMENT'
FROM Technologies;

-- 玩家拥有某市政
INSERT OR IGNORE INTO RequirementSets(RequirementSetId, RequirementSetType)
SELECT 'NW_PLAYER_HAS_' || CivicType, 'REQUIREMENTSET_TEST_ALL'
FROM Civics;
INSERT OR IGNORE INTO Requirements(RequirementId, RequirementType)
SELECT 'NW_UTILS_PLAYER_HAS_' || CivicType || '_REQUIREMENT', 'REQUIREMENT_PLAYER_HAS_CIVIC'
FROM Civics;
INSERT OR IGNORE INTO RequirementArguments(RequirementId, Name, Value)
SELECT 'NW_UTILS_PLAYER_HAS_' || CivicType || '_REQUIREMENT', 'CivicType', CivicType
FROM Civics;
INSERT OR IGNORE INTO RequirementSetRequirements(RequirementSetId, RequirementId)
SELECT 'NW_PLAYER_HAS_' || CivicType, 'NW_UTILS_PLAYER_HAS_' || CivicType || '_REQUIREMENT'
FROM Civics;

INSERT INTO GovernmentModifiers (GovernmentType, ModifierId) VALUES
('GOVERNMENT_NW3', 'MODIFIER_GOVERNMENT_NW3_CITY_GROWTH');
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
('MODIFIER_GOVERNMENT_NW3_CITY_GROWTH', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_GROWTH',  'CITY_NOT_FOUNDED');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_GOVERNMENT_NW3_CITY_GROWTH', 'Amount', '-10');