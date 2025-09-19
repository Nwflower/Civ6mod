--	FILE: SecretSociety_OLDRULE_SecretSocieties_MODE.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/7/3 11:22:01
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

-- 声明变量类型
INSERT INTO Types(Type, Kind)
VALUES ('SECRETSOCIETY_OLDRULE', 'KIND_SECRETSOCIETY'),
       ('GOVERNOR_OLDRULE', 'KIND_GOVERNOR'),
       ('GOVERNOR_PROMOTION_OLDRULE_1', 'KIND_GOVERNOR_PROMOTION'),
       ('GOVERNOR_PROMOTION_OLDRULE_2', 'KIND_GOVERNOR_PROMOTION'),
       ('GOVERNOR_PROMOTION_OLDRULE_3', 'KIND_GOVERNOR_PROMOTION'),
       ('GOVERNOR_PROMOTION_OLDRULE_4', 'KIND_GOVERNOR_PROMOTION');

-- 声明秘密结社
INSERT INTO SecretSocieties(SecretSocietyType, Name, Description, DiscoveryText, MembershipText, GovernorType,
                            DiscoverAtBarbarianCampBaseChance, DiscoverAtCityStateBaseChance,
                            DiscoverAtGoodyHutBaseChance, DiscoverAtNaturalWonderBaseChance, SmallIcon, IconString)
SELECT 'SECRETSOCIETY_OLDRULE',
       'LOC_SECRETSOCIETY_OLDRULE_NAME',
       'LOC_SECRETSOCIETY_OLDRULE_DESCRIPTION',
       'LOC_SECRETSOCIETY_OLDRULE_DISCOVERYTEXT',
       'LOC_SECRETSOCIETY_OLDRULE_MEMBERSHIPTEXT',
       'GOVERNOR_OLDRULE',
       300,
       100000,
       300,
       300,
       'Society_OLDRULE',
       IconString
FROM SecretSocieties
WHERE SecretSocietyType = 'SECRETSOCIETY_HERMETIC_ORDER';


-- 总督效果
INSERT INTO Governors(GovernorType, Name, Description, IdentityPressure, Title, ShortTitle, TransitionStrength,
                      AssignCityState, Image, PortraitImage, PortraitImageSelected, TraitType)
SELECT 'GOVERNOR_OLDRULE',
       'LOC_SECRETSOCIETY_OLDRULE_NAME',
       'LOC_SECRETSOCIETY_OLDRULE_DESCRIPTION',
       IdentityPressure,
       Title,
       ShortTitle,
       TransitionStrength,
       AssignCityState,
       'GOVERNOR_CARDINAL',
       'SECRETSOCIETY_OLDRULE',
       'SECRETSOCIETY_OLDRULE',
       TraitType
FROM Governors
WHERE GovernorType = 'GOVERNOR_HERMETIC_ORDER';

INSERT INTO GovernorsCannotAssign(GovernorType, CannotAssign)
VALUES ('GOVERNOR_OLDRULE', 1);

INSERT INTO GovernorPromotions(GovernorPromotionType, Name, Description, Level, "Column", BaseAbility)
VALUES ('GOVERNOR_PROMOTION_OLDRULE_1', 'LOC_GOVERNOR_PROMOTION_OLDRULE_1_NAME',
        'LOC_GOVERNOR_PROMOTION_OLDRULE_1_DESCRIPTION', 0, 1, 1),
       ('GOVERNOR_PROMOTION_OLDRULE_2', 'LOC_GOVERNOR_PROMOTION_OLDRULE_2_NAME',
        'LOC_GOVERNOR_PROMOTION_OLDRULE_2_DESCRIPTION', 1, 1, 0),
       ('GOVERNOR_PROMOTION_OLDRULE_3', 'LOC_GOVERNOR_PROMOTION_OLDRULE_3_NAME',
        'LOC_GOVERNOR_PROMOTION_OLDRULE_3_DESCRIPTION', 2, 1, 0),
       ('GOVERNOR_PROMOTION_OLDRULE_4', 'LOC_GOVERNOR_PROMOTION_OLDRULE_4_NAME',
        'LOC_GOVERNOR_PROMOTION_OLDRULE_4_DESCRIPTION', 3, 1, 0);

INSERT INTO GovernorPromotionSets(GovernorType, GovernorPromotion)
VALUES ('GOVERNOR_OLDRULE', 'GOVERNOR_PROMOTION_OLDRULE_1'),
       ('GOVERNOR_OLDRULE', 'GOVERNOR_PROMOTION_OLDRULE_2'),
       ('GOVERNOR_OLDRULE', 'GOVERNOR_PROMOTION_OLDRULE_3'),
       ('GOVERNOR_OLDRULE', 'GOVERNOR_PROMOTION_OLDRULE_4');

INSERT INTO GovernorPromotionConditions(GovernorPromotionType, HiddenWithoutPrereqs, EarliestGameEra)
VALUES ('GOVERNOR_PROMOTION_OLDRULE_1', 0, NULL),
       ('GOVERNOR_PROMOTION_OLDRULE_2', 1, 'ERA_MEDIEVAL'),
       ('GOVERNOR_PROMOTION_OLDRULE_3', 1, 'ERA_INDUSTRIAL'),
       ('GOVERNOR_PROMOTION_OLDRULE_4', 1, 'ERA_ATOMIC');

INSERT INTO GovernorPromotionPrereqs(GovernorPromotionType, PrereqGovernorPromotion)
VALUES ('GOVERNOR_PROMOTION_OLDRULE_2', 'GOVERNOR_PROMOTION_OLDRULE_1'),
       ('GOVERNOR_PROMOTION_OLDRULE_3', 'GOVERNOR_PROMOTION_OLDRULE_2'),
       ('GOVERNOR_PROMOTION_OLDRULE_4', 'GOVERNOR_PROMOTION_OLDRULE_3');
