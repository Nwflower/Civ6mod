--	FILE: 随机科文Boost
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
------------------------------------------------------------------------------
-- 首先将Boost表按照时代先后排序
CREATE TEMPORARY TABLE IF NOT EXISTS EraBoost
(
    BoostID       INTEGER NOT NULL PRIMARY KEY,
    Type          TEXT,
    EraIndex      INTEGER,
    NewBoostID    INTEGER,
    SHUFFLE_ORDER INTEGER
);

INSERT INTO EraBoost(BoostID, EraIndex)
SELECT BoostID,
       coalesce((SELECT (SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = Civics.EraType) FROM Civics WHERE Boosts.CivicType = Civics.CivicType),
                (SELECT (SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = Technologies.EraType) FROM Technologies WHERE Boosts.TechnologyType = Technologies.TechnologyType)) AS EraIndex
FROM Boosts;

UPDATE EraBoost
SET NewBoostID = (SELECT COUNT(*)
                  FROM EraBoost B2
                  WHERE (B2.BoostID <= EraBoost.BoostID AND
                         B2.EraIndex == EraBoost.EraIndex)
                     OR (B2.EraIndex < EraBoost.EraIndex))
WHERE BoostID IS NOT NULL;

-- 倒置BoostID，避免违反主键约束
UPDATE Boosts
SET BoostID = (SELECT -NewBoostID
               FROM EraBoost
               WHERE EraBoost.BoostID == Boosts.BoostID
               LIMIT 1);
UPDATE Boosts SET BoostID = -BoostID;

DELETE FROM EraBoost;
------------------------------------------------------------------------------
-- 按照哈希值和日期建表，确定打乱顺序

INSERT INTO EraBoost(BoostID, EraIndex, Type)
SELECT BoostID,
       coalesce((SELECT (SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = Civics.EraType) FROM Civics WHERE Boosts.CivicType = Civics.CivicType),
                (SELECT (SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = Technologies.EraType) FROM Technologies WHERE Boosts.TechnologyType = Technologies.TechnologyType)) AS EraIndex,
       coalesce(CivicType, TechnologyType) AS Type
FROM Boosts;


UPDATE EraBoost
SET SHUFFLE_ORDER = (
    WITH current_time AS (
        SELECT
            CAST(STRFTIME('%H', 'now') AS INTEGER) AS hour,
            CASE
                -- 若小时小于4，则使用前一天日期，否则使用当前日期
                WHEN CAST(STRFTIME('%H', 'now') AS INTEGER) < 4
                THEN DATE('now', '-1 day')
                ELSE DATE('now')
            END AS calc_date
    ),
    params AS (
        SELECT
            (CAST(STRFTIME('%Y', calc_date) AS INTEGER) * 167
            + CAST(STRFTIME('%m', calc_date) AS INTEGER) * 179
            + CAST(STRFTIME('%d', calc_date) AS INTEGER) * 173) AS date_hash
        FROM current_time
    )
    SELECT ABS(
        ((SELECT Hash FROM Types WHERE Type = EraBoost.Type LIMIT 1) * 1664525
        + date_hash * 22695477) % 1000639
    )
    FROM params
)
WHERE BoostID IS NOT NULL;

UPDATE EraBoost
SET NewBoostID = (SELECT COUNT(*) FROM EraBoost E2
                  WHERE (E2.SHUFFLE_ORDER <= EraBoost.SHUFFLE_ORDER AND E2.EraIndex == EraBoost.EraIndex)
                     OR (E2.EraIndex < EraBoost.EraIndex))
WHERE BoostID IS NOT NULL;

UPDATE Boosts
SET CivicType = coalesce((SELECT Type FROM EraBoost WHERE EraBoost.NewBoostID = Boosts.BoostID AND Type LIKE 'CIVIC\_%' ESCAPE '\'), NULL),
    TechnologyType =coalesce((SELECT Type FROM EraBoost WHERE EraBoost.NewBoostID = Boosts.BoostID AND Type LIKE 'TECH\_%' ESCAPE '\'), NULL)
WHERE BoostID IS NOT NULL;
