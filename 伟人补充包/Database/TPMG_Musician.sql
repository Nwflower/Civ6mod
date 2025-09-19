------------------------------------------------------------------------------
--	FILE: TPMG_MUSICIAN.sql
--  VERSION: 1
--	PURPOSE: Team PVP More Great MUSICIAN
------------------------------------------------------------------------------
--	Copyright (c) 2025 Nwflower.
--	All rights reserved.
------------------------------------------------------------------------------

-- TPMG Files Support

CREATE TABLE IF NOT EXISTS NW_GreatPersonClass
(
    GreatPersonIndividualType TEXT NOT NULL,
    GreatPersonClassType      TEXT NOT NULL,
    EraType                   TEXT NOT NULL,
    GreatWorksNum             INTEGER DEFAULT 0,
    PRIMARY KEY (GreatPersonIndividualType)
);
INSERT INTO NW_GreatPersonClass(GreatPersonIndividualType, GreatPersonClassType, EraType)
VALUES
    --------------------------- 古典 -------------------------------
    --------------------------- 俞伯牙 -------------------------------
    ('GREAT_PERSON_INDIVIDUAL_NW_MUSICIAN_CLASSICAL_1', 'GREAT_PERSON_CLASS_MUSICIAN', 'ERA_CLASSICAL'),
    --------------------------- 中世纪 -------------------------------
    --------------------------- 关汉卿 -------------------------------
    ('GREAT_PERSON_INDIVIDUAL_NW_MUSICIAN_MEDIEVAL_1', 'GREAT_PERSON_CLASS_MUSICIAN', 'ERA_MEDIEVAL'),
    --------------------------- 李隆基 -------------------------------
    ('GREAT_PERSON_INDIVIDUAL_NW_MUSICIAN_MEDIEVAL_2', 'GREAT_PERSON_CLASS_MUSICIAN', 'ERA_MEDIEVAL'),
    --------------------------- 文艺复兴 -------------------------------
    --------------------------- 汤应曾 -------------------------------
    ('GREAT_PERSON_INDIVIDUAL_NW_MUSICIAN_RENAISSANCE_1', 'GREAT_PERSON_CLASS_MUSICIAN', 'ERA_RENAISSANCE'),
    --------------------------- 托马斯·路易斯 -------------------------------
    ('GREAT_PERSON_INDIVIDUAL_NW_MUSICIAN_RENAISSANCE_2', 'GREAT_PERSON_CLASS_MUSICIAN', 'ERA_RENAISSANCE');

INSERT INTO Types (Type, Kind)
SELECT GreatPersonIndividualType, 'KIND_GREAT_PERSON_INDIVIDUAL'
FROM NW_GreatPersonClass
WHERE GreatPersonClassType = 'GREAT_PERSON_CLASS_MUSICIAN';

UPDATE NW_GreatPersonClass
SET GreatWorksNum = 2
WHERE GreatPersonClassType = 'GREAT_PERSON_CLASS_MUSICIAN'
  AND EraType IS NOT 'ERA_MEDIEVAL';
UPDATE NW_GreatPersonClass
SET GreatWorksNum = 1
WHERE GreatPersonClassType = 'GREAT_PERSON_CLASS_MUSICIAN'
  AND EraType IS 'ERA_MEDIEVAL';

-- ======================================================
-- 大音乐家
-- ======================================================

INSERT INTO GreatPersonIndividuals(GreatPersonIndividualType, Name, GreatPersonClassType, EraType, Gender,
                                   ActionCharges, ActionRequiresOwnedTile,
                                   ActionEffectTileHighlighting)
SELECT GreatPersonIndividualType,
       'LOC_' || GreatPersonIndividualType || '_NAME',
       GreatPersonClassType,
       EraType,
       'M',
       0,
       1,
       1
FROM NW_GreatPersonClass
WHERE GreatPersonClassType = 'GREAT_PERSON_CLASS_MUSICIAN';

-- 创建临时数字表（使用正确的WITH RECURSIVE语法）
CREATE TEMP TABLE IF NOT EXISTS Numbers AS
WITH RECURSIVE Numbers(n) AS (SELECT 1
                              UNION ALL
                              SELECT n + 1
                              FROM Numbers
                              WHERE n < (SELECT MAX(GreatWorksNum) FROM NW_GreatPersonClass WHERE GreatWorksNum > 0))
SELECT n
FROM Numbers;

-- 批量插入巨作
CREATE TEMP TABLE NW_TEMP_TABLE_CLASSWORKS AS
SELECT gpc.GreatPersonIndividualType, gpc.GreatWorksNum, n.n AS WorkIndex
FROM NW_GreatPersonClass gpc
         JOIN Numbers n ON n.n <= gpc.GreatWorksNum
WHERE gpc.GreatWorksNum > 0
  AND gpc.GreatPersonClassType = 'GREAT_PERSON_CLASS_MUSICIAN';

INSERT INTO Types (Type, Kind)
SELECT 'GREATWORK_' || REPLACE(GreatPersonIndividualType, 'GREAT_PERSON_INDIVIDUAL_', '') || WorkIndex, 'KIND_GREATWORK'
FROM NW_TEMP_TABLE_CLASSWORKS;

INSERT INTO GreatWorks (GreatWorkType, GreatWorkObjectType, GreatPersonIndividualType, Name, Tourism, Audio)
SELECT 'GREATWORK_' || REPLACE(GreatPersonIndividualType, 'GREAT_PERSON_INDIVIDUAL_', '') || WorkIndex,
       'GREATWORKOBJECT_MUSIC',
       GreatPersonIndividualType,
       'LOC_GREATWORK_' || REPLACE(GreatPersonIndividualType, 'GREAT_PERSON_INDIVIDUAL_', '') || WorkIndex || '_NAME',
       (4 + GreatWorksNum - 1) / GreatWorksNum,
       ''
FROM NW_TEMP_TABLE_CLASSWORKS;

INSERT INTO GreatWork_YieldChanges (GreatWorkType, YieldType, YieldChange)
SELECT 'GREATWORK_' || REPLACE(GreatPersonIndividualType, 'GREAT_PERSON_INDIVIDUAL_', '') || WorkIndex,
       'YIELD_CULTURE',
       (4 + GreatWorksNum - 1) / GreatWorksNum
FROM NW_TEMP_TABLE_CLASSWORKS;

UPDATE GreatWorks
SET Tourism = 4
WHERE GreatPersonIndividualType IN
      ('GREAT_PERSON_INDIVIDUAL_NW_MUSICIAN_RENAISSANCE_1', 'GREAT_PERSON_INDIVIDUAL_NW_MUSICIAN_RENAISSANCE_2');

UPDATE GreatWork_YieldChanges
SET YieldChange = 4
WHERE GreatWorkType IN (SELECT GreatWorkType
                        FROM GreatWorks
                        WHERE GreatPersonIndividualType IN ('GREAT_PERSON_INDIVIDUAL_NW_MUSICIAN_RENAISSANCE_1',
                                                            'GREAT_PERSON_INDIVIDUAL_NW_MUSICIAN_RENAISSANCE_2'));

DROP TABLE NW_TEMP_TABLE_CLASSWORKS;