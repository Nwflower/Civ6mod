--  FILE: MRK_Modifier.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/10/5 12:10:26

--============================================================
-- Lua Support
--============================================================
CREATE TABLE IF NOT EXISTS Nwflower_MOD_Traits
(
    TraitType TEXT NOT NULL,
    PRIMARY KEY (TraitType),
    FOREIGN KEY (TraitType) REFERENCES Traits (TraitType) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT OR IGNORE INTO Nwflower_MOD_Traits(TraitType)
VALUES ('TRAIT_LEADER_NW251004_MRK');

INSERT OR IGNORE INTO TraitModifiers(TraitType, ModifierId)
SELECT TraitType,
       'MODFEAT_TRAIT_PROPERTY_' || TraitType
FROM Nwflower_MOD_Traits;

INSERT OR IGNORE INTO Modifiers(ModifierId, ModifierType)
SELECT 'MODFEAT_TRAIT_PROPERTY_' || TraitType,
       'MODIFIER_PLAYER_ADJUST_PROPERTY'
FROM Nwflower_MOD_Traits;

INSERT OR IGNORE INTO ModifierArguments(ModifierId, Name, Value)
SELECT 'MODFEAT_TRAIT_PROPERTY_' || TraitType,
       'Key',
       'PROPERTY_' || TraitType
FROM Nwflower_MOD_Traits
UNION
SELECT 'MODFEAT_TRAIT_PROPERTY_' || TraitType,
       'Amount',
       1
FROM Nwflower_MOD_Traits;

--============================================================
-- TRAIT_LEADER_NW251004_MRK
-- [ICON_CAPITAL]首都训练的建造者+1 [ICON_MOVEMENT] 移动力，并能建造一个额外的改良设施。

INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_LEADER_NW251004_MRK', 'MODIFIER_TRAIT_LEADER_NW251004_MRK_CUM');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_TRAIT_LEADER_NW251004_MRK_CUM', 'MODIFIER_NW_MRK_PLAYER_CAPITAL_CITY_ATTACH_MODIFIER', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_NW251004_MRK_CUM', 'ModifierId', 'MODIFIER_TRAIT_LEADER_NW251004_MRK_CUM_AB');
-- Custom ModifierType
INSERT INTO Types (Type, Kind) VALUES
('MODIFIER_NW_MRK_PLAYER_CAPITAL_CITY_ATTACH_MODIFIER', 'KIND_MODIFIER');
INSERT INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES
('MODIFIER_NW_MRK_PLAYER_CAPITAL_CITY_ATTACH_MODIFIER', 'COLLECTION_PLAYER_CAPITAL_CITY', 'EFFECT_ATTACH_MODIFIER');

INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
('MODIFIER_TRAIT_LEADER_NW251004_MRK_CUM_AB', 'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_TRAIT_LEADER_NW251004_MRK_CUM_AB', 'AbilityType', 'AB_TRAIT_LEADER_NW251004_MRK');



INSERT OR IGNORE INTO Types(Type, Kind)
VALUES ( 'AB_TRAIT_LEADER_NW251004_MRK','KIND_ABILITY');
INSERT OR IGNORE INTO TypeTags(Type,Tag)
VALUES ('AB_TRAIT_LEADER_NW251004_MRK','CLASS_BUILDER');
INSERT OR IGNORE INTO UnitAbilities(UnitAbilityType,Inactive,Name,Description)
VALUES ( 'AB_TRAIT_LEADER_NW251004_MRK', 1 ,'LOC_AB_TRAIT_LEADER_NW251004_MRK_NAME','LOC_AB_TRAIT_LEADER_NW251004_MRK_NAME');

INSERT OR IGNORE INTO UnitAbilityModifiers(UnitAbilityType,ModifierId)
VALUES ( 'AB_TRAIT_LEADER_NW251004_MRK', 'MODIFIER_AB_TRAIT_LEADER_NW251004_MRK');
INSERT OR IGNORE INTO Modifiers(ModifierId,ModifierType)
VALUES ( 'MODIFIER_AB_TRAIT_LEADER_NW251004_MRK', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT' );
INSERT OR IGNORE INTO ModifierArguments(ModifierId,Name,Value)
VALUES ( 'MODIFIER_AB_TRAIT_LEADER_NW251004_MRK', 'Amount',1);


INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
('AB_TRAIT_LEADER_NW251004_MRK', 'MODIFIER_AB_TRAIT_LEADER_NW251004_MRK_BC');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('MODIFIER_AB_TRAIT_LEADER_NW251004_MRK_BC', 'MODIFIER_SINGLE_UNIT_NW_MRK_BUILDER_CHARGES', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('MODIFIER_AB_TRAIT_LEADER_NW251004_MRK_BC', 'Amount', '1');
-- Custom ModifierType
INSERT INTO Types (Type, Kind) VALUES
('MODIFIER_SINGLE_UNIT_NW_MRK_BUILDER_CHARGES', 'KIND_MODIFIER');
INSERT INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES
('MODIFIER_SINGLE_UNIT_NW_MRK_BUILDER_CHARGES', 'COLLECTION_OWNER', 'EFFECT_ADJUST_UNIT_BUILD_CHARGES');
-- Requirements
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('REQ_56DJ1BMW', 'REQUIREMENT_ALLIANCE_AT_WAR_WITH_COMBAT_TARGET');
