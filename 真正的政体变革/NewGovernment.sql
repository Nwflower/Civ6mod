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
UPDATE Governments SET PrereqCivic = 'CIVIC_CODE_OF_LAWS' WHERE GovernmentType = 'GOVERNMENT_CHIEFDOM';
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
('MODIFIER_GOVERNMENT_FENFENG_MINI_PLOT_COST', 'Amount', '20');

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
       AccumulatedBonusShortDesc,
       AccumulatedBonusDesc,
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
('GOVERNMENT_JUNXUANZHI','SLOT_DIPLOMATIC',0),
('GOVERNMENT_JUNXUANZHI','SLOT_WILDCARD',2);
INSERT INTO Governments_XP2(GovernmentType, Favor) SELECT
'GOVERNMENT_JUNXUANZHI',Favor
FROM Governments_XP2 WHERE GovernmentType = 'GOVERNMENT_AUTOCRACY';

-- 行政部门：封臣强化
INSERT INTO Types(Type, Kind)
VALUES ('GOVERNMENT_XINGSHENGFENQUAN', 'KIND_GOVERNMENT');
INSERT INTO Governments(GovernmentType, Name, PrereqCivic, InherentBonusDesc, AccumulatedBonusShortDesc,
                        AccumulatedBonusDesc, OtherGovernmentIntolerance, InfluencePointsPerTurn,
                        InfluencePointsThreshold, InfluenceTokensPerThreshold, BonusType, PolicyToUnlock, Tier)
SELECT 'GOVERNMENT_XINGSHENGFENQUAN',
       'LOC_GOVERNMENT_XINGSHENGFENQUAN_NAME',
       'CIVIC_CIVIL_SERVICE',
       'LOC_GOVT_INHERENT_BONUS_JUNXUANZHI',
       AccumulatedBonusShortDesc,
       AccumulatedBonusDesc,
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
('GOVERNMENT_XINGSHENGFENQUAN','SLOT_MILITARY',0),
('GOVERNMENT_XINGSHENGFENQUAN','SLOT_ECONOMIC',2),
('GOVERNMENT_XINGSHENGFENQUAN','SLOT_DIPLOMATIC',1),
('GOVERNMENT_XINGSHENGFENQUAN','SLOT_WILDCARD',2);
INSERT INTO Governments_XP2(GovernmentType, Favor) SELECT
'GOVERNMENT_XINGSHENGFENQUAN',Favor
FROM Governments_XP2 WHERE GovernmentType = 'GOVERNMENT_AUTOCRACY';

-- 公会：贵族共和
INSERT INTO Types(Type, Kind)
VALUES ('GOVERNMENT_GUIZUGONGHE', 'KIND_GOVERNMENT');
INSERT INTO Governments(GovernmentType, Name, PrereqCivic, InherentBonusDesc, AccumulatedBonusShortDesc,
                        AccumulatedBonusDesc, OtherGovernmentIntolerance, InfluencePointsPerTurn,
                        InfluencePointsThreshold, InfluenceTokensPerThreshold, BonusType, PolicyToUnlock, Tier)
SELECT 'GOVERNMENT_GUIZUGONGHE',
       'LOC_GOVERNMENT_GUIZUGONGHE_NAME',
       'CIVIC_GUILDS',
       'LOC_GOVT_INHERENT_BONUS_JUNXUANZHI',
       AccumulatedBonusShortDesc,
       AccumulatedBonusDesc,
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
('GOVERNMENT_GUIZUGONGHE','SLOT_MILITARY',0),
('GOVERNMENT_GUIZUGONGHE','SLOT_ECONOMIC',1),
('GOVERNMENT_GUIZUGONGHE','SLOT_DIPLOMATIC',0),
('GOVERNMENT_GUIZUGONGHE','SLOT_WILDCARD',4);
INSERT INTO Governments_XP2(GovernmentType, Favor) SELECT
'GOVERNMENT_GUIZUGONGHE',Favor
FROM Governments_XP2 WHERE GovernmentType = 'GOVERNMENT_AUTOCRACY';

-- 殖民主义：宗主集权殖民

INSERT INTO Types(Type, Kind)
VALUES ('GOVERNMENT_NW1', 'KIND_GOVERNMENT');
INSERT INTO Governments(GovernmentType, Name, PrereqCivic, InherentBonusDesc, AccumulatedBonusShortDesc,
                        AccumulatedBonusDesc, OtherGovernmentIntolerance, InfluencePointsPerTurn,
                        InfluencePointsThreshold, InfluenceTokensPerThreshold, BonusType, PolicyToUnlock, Tier)
SELECT 'GOVERNMENT_NW1',
       'LOC_GOVERNMENT_NW1_NAME',
       'CIVIC_COLONIALISM',
       'LOC_GOVT_INHERENT_BONUS_JUNXUANZHI',
       AccumulatedBonusShortDesc,
       AccumulatedBonusDesc,
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

-- 自由资本主义：重商主义

INSERT INTO Types(Type, Kind)
VALUES ('GOVERNMENT_NW2', 'KIND_GOVERNMENT');
INSERT INTO Governments(GovernmentType, Name, PrereqCivic, InherentBonusDesc, AccumulatedBonusShortDesc,
                        AccumulatedBonusDesc, OtherGovernmentIntolerance, InfluencePointsPerTurn,
                        InfluencePointsThreshold, InfluenceTokensPerThreshold, BonusType, PolicyToUnlock, Tier)
SELECT 'GOVERNMENT_NW2',
       'LOC_GOVERNMENT_NW2_NAME',
       'CIVIC_URBANIZATION',
       'LOC_GOVT_INHERENT_BONUS_JUNXUANZHI',
       AccumulatedBonusShortDesc,
       AccumulatedBonusDesc,
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
('GOVERNMENT_NW2','SLOT_ECONOMIC',5),
('GOVERNMENT_NW2','SLOT_DIPLOMATIC',1),
('GOVERNMENT_NW2','SLOT_WILDCARD',1);
INSERT INTO Governments_XP2(GovernmentType, Favor) SELECT
'GOVERNMENT_NW2',Favor
FROM Governments_XP2 WHERE GovernmentType = 'GOVERNMENT_THEOCRACY';


-- 民族主义：君主立宪
INSERT INTO Types(Type, Kind)
VALUES ('GOVERNMENT_NW3', 'KIND_GOVERNMENT');
INSERT INTO Governments(GovernmentType, Name, PrereqCivic, InherentBonusDesc, AccumulatedBonusShortDesc,
                        AccumulatedBonusDesc, OtherGovernmentIntolerance, InfluencePointsPerTurn,
                        InfluencePointsThreshold, InfluenceTokensPerThreshold, BonusType, PolicyToUnlock, Tier)
SELECT 'GOVERNMENT_NW3',
       'LOC_GOVERNMENT_NW3_NAME',
       'CIVIC_NATIONALISM',
       'LOC_GOVT_INHERENT_BONUS_JUNXUANZHI',
       AccumulatedBonusShortDesc,
       AccumulatedBonusDesc,
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


INSERT INTO Types(Type, Kind)
VALUES ('GOVERNMENT_NW4', 'KIND_GOVERNMENT');
INSERT INTO Governments(GovernmentType, Name, PrereqCivic, InherentBonusDesc, AccumulatedBonusShortDesc,
                        AccumulatedBonusDesc, OtherGovernmentIntolerance, InfluencePointsPerTurn,
                        InfluencePointsThreshold, InfluenceTokensPerThreshold, BonusType, PolicyToUnlock, Tier)
SELECT 'GOVERNMENT_NW4',
       'LOC_GOVERNMENT_NW4_NAME',
       'CIVIC_CAPITALISM',
       'LOC_GOVT_INHERENT_BONUS_JUNXUANZHI',
       AccumulatedBonusShortDesc,
       AccumulatedBonusDesc,
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
('GOVERNMENT_NW4','SLOT_MILITARY',0),
('GOVERNMENT_NW4','SLOT_ECONOMIC',7),
('GOVERNMENT_NW4','SLOT_DIPLOMATIC',0),
('GOVERNMENT_NW4','SLOT_WILDCARD',0);
INSERT INTO Governments_XP2(GovernmentType, Favor) SELECT
'GOVERNMENT_NW4',Favor
FROM Governments_XP2 WHERE GovernmentType = 'GOVERNMENT_THEOCRACY';