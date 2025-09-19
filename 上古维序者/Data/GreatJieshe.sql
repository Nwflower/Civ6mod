-- GreatJieshe
-- Author: QIANCHUANBAILANG
-- DateCreated: 2025-8-7 22:45:53
--------------------------------------------------------------

-- 地脉改任意
INSERT OR IGNORE INTO Improvement_ValidResources (ResourceType, ImprovementType) VALUES
('RESOURCE_LEY_LINE', 'IMPROVEMENT_FARM'),
('RESOURCE_LEY_LINE', 'IMPROVEMENT_MINE'),
('RESOURCE_LEY_LINE', 'IMPROVEMENT_CAMP'),
('RESOURCE_LEY_LINE', 'IMPROVEMENT_PLANTATION'),
('RESOURCE_LEY_LINE', 'IMPROVEMENT_LUMBER_MILL');

-- 城邦改良
INSERT OR IGNORE INTO Improvement_ValidResources (ResourceType, ImprovementType) SELECT
'RESOURCE_LEY_LINE', ImprovementType
FROM Improvements WHERE TraitType LIKE 'MINOR/_CIV%' ESCAPE '/';


-- 吸血鬼虚空和夜莺增加奇观判定（概率和地脉一样就行）
UPDATE SecretSocieties 
SET DiscoverAtNaturalWonderBaseChance = 100000
WHERE 	SecretSocietyType IN ('SECRETSOCIETY_OWLS_OF_MINERVA','SECRETSOCIETY_VOIDSINGERS','SECRETSOCIETY_SANGUINE_PACT');

-- 吸血国境内+1速，虚空碑+1金
INSERT OR IGNORE INTO Building_YieldChanges(BuildingType, YieldType, YieldChange) VALUES 
('BUILDING_OLD_GOD_OBELISK','YIELD_GOLD', 1);

UPDATE Buildings SET Housing = 1 WHERE BuildingType = 'BUILDING_OLD_GOD_OBELISK';

INSERT OR IGNORE INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_LEADER_MAJOR_CIV', 'MODIFIER_TRAIT_LEADER_MAJOR_CIV_UNIT_VAMPIRE_FRIENDLY_TERRITORY_START_MOVEMENT');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_LEADER_MAJOR_CIV_UNIT_VAMPIRE_FRIENDLY_TERRITORY_START_MOVEMENT', 'MODIFIER_PLAYER_UNITS_ADJUST_FRIENDLY_TERRITORY_START_MOVEMENT', 0, 0, 0, NULL, 'REQS_NW_UNIT_VAMPIRE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_MAJOR_CIV_UNIT_VAMPIRE_FRIENDLY_TERRITORY_START_MOVEMENT', 'Amount', '1');

-- RequirementSets
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('REQS_NW_UNIT_VAMPIRE', 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('REQS_NW_UNIT_VAMPIRE', 'REQ_NW_UNIT_VAMPIRE');

-- Requirements
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES
('REQ_NW_UNIT_VAMPIRE', 'REQUIREMENT_UNIT_TYPE_MATCHES');
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES
('REQ_NW_UNIT_VAMPIRE', 'UnitType', 'UNIT_VAMPIRE');
