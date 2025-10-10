--	FILE: 千川白浪MOD核心
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025-9-19 20:16:26
--------------------------------------------------------------------------------
--  作者： 千川白浪
--  特别鸣谢： 优妮
------------------------------------------------------------------------------

-- 同时代尤里卡和鼓舞顺序打乱

--     CASE
--            WHEN CivicType IS NOT NULL THEN CivicType
--            ELSE TechnologyType
-- END AS Type
DROP TABLE EraBoost;
CREATE TABLE IF NOT EXISTS EraBoost
(
    BoostID       INTEGER NOT NULL PRIMARY KEY,
    Type          TEXT,
    EraType       TEXT,
    EraIndex      INTEGER,
    NewBoostID    INTEGER,
    SHUFFLE_ORDER INTEGER
);


INSERT INTO EraBoost(BoostID, EraType, Type)
SELECT BoostID,
       CASE
           WHEN CivicType IS NOT NULL THEN (SELECT EraType
                                            FROM Civics
                                            WHERE Boosts.CivicType = Civics.CivicType
                                            LIMIT 1)
           WHEN TechnologyType IS NOT NULL THEN (SELECT EraType
                                                 FROM Technologies
                                                 WHERE Boosts.TechnologyType = Technologies.TechnologyType
                                                 LIMIT 1)
           ELSE 'ERA_ANCIENT'
           END                             AS EraType,
       coalesce(CivicType, TechnologyType) AS Type
FROM Boosts;


UPDATE EraBoost
SET SHUFFLE_ORDER = (WITH params AS (SELECT
                                         -- 计算日期序列化值
                                         (CAST(STRFTIME('%Y') AS INTEGER) * 167 +
                                          CAST(STRFTIME('%m') AS INTEGER) * 179 +
                                          CAST(STRFTIME('%d') AS INTEGER) * 173) AS date_hash
                                     FROM GlobalParameters)
                     SELECT ABS(
                                    (
                                        -- 基础哈希值
                                        (SELECT Hash FROM Types WHERE Type = EraBoost.Type LIMIT 1) * 1664525 +
                                            -- 日期序列化值
                                        date_hash * 22695477
                                        ) % 2147483647 -- 使用大质数取模
                            ) % 10000019 -- 最终取模到所需范围
                     FROM params)
WHERE BoostID IS NOT NULL;

UPDATE EraBoost
SET EraIndex = (SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = EraBoost.EraType LIMIT 1)
WHERE BoostID IS NOT NULL;

-- 按EraType分组，在组内按SHUFFLE_ORDER降序计算排序序号，更新到NewBoostID
UPDATE EraBoost
SET NewBoostID = (SELECT COUNT(*)
                  FROM EraBoost E2
                  WHERE (E2.SHUFFLE_ORDER <= EraBoost.SHUFFLE_ORDER AND E2.EraType == EraBoost.EraType)
                     OR (E2.EraIndex < EraBoost.EraIndex))
WHERE BoostID IS NOT NULL;

UPDATE Boosts
SET CivicType      =
        CASE
            WHEN (SELECT Kind
                  FROM Types
                  WHERE Types.Type = (SELECT Type FROM EraBoost WHERE EraBoost.NewBoostID = Boosts.BoostID LIMIT 1)) IS
                 'KIND_CIVIC' THEN
                (SELECT Type FROM EraBoost WHERE EraBoost.NewBoostID = Boosts.BoostID LIMIT 1)
            END,
    TechnologyType =
        CASE
            WHEN (SELECT Kind
                  FROM Types
                  WHERE Types.Type = (SELECT Type FROM EraBoost WHERE EraBoost.NewBoostID = Boosts.BoostID LIMIT 1)) IS
                 'KIND_TECH' THEN
                (SELECT Type FROM EraBoost WHERE EraBoost.NewBoostID = Boosts.BoostID LIMIT 1)
            END;
