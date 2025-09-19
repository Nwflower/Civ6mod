--===========================
-- 科技树随机
--===========================
ALTER TABLE Technologies ADD COLUMN shuffle_order INTEGER;

UPDATE Technologies
SET shuffle_order = (
    WITH params AS (
        -- 从 GlobalParams 表中获取 v1 到 v5 的值
        SELECT
            MAX(CASE WHEN Name = 'NW_RT_SEED_1' THEN CAST(Value AS INTEGER) ELSE 0 END) AS v1,
            MAX(CASE WHEN Name = 'NW_RT_SEED_2' THEN CAST(Value AS INTEGER) ELSE 0 END) AS v2,
            MAX(CASE WHEN Name = 'NW_RT_SEED_3' THEN CAST(Value AS INTEGER) ELSE 0 END) AS v3,
            MAX(CASE WHEN Name = 'NW_RT_SEED_4' THEN CAST(Value AS INTEGER) ELSE 0 END) AS v4,
            MAX(CASE WHEN Name = 'NW_RT_SEED_5' THEN CAST(Value AS INTEGER) ELSE 0 END) AS v5
        FROM GlobalParameters
    )
    SELECT ABS(
        (
            -- 基础哈希值
            (SELECT Hash FROM Types WHERE Type = TechnologyType LIMIT 1) * 1664525 +
            -- 日期序列化值
            -- 五个参数值
            v1 * 1000639 + v2 * 100591 + v3 * 10457 + v4 * 1361 + v5 * 379 +
            -- 添加常数
            1013904223
        ) % 2147483647  -- 使用大质数取模
    ) % 10000019  -- 最终取模到所需范围
    FROM params
)
WHERE TechnologyType IS NOT NULL;

-- 储存交换性科技
CREATE TABLE RandomTechnology (
    TechnologyType1 TEXT,  -- 存储原表奇数行的主键
    TechnologyType2 TEXT,   -- 存储原表偶数行的主键
    TechnologyCost1 INTEGER,
    TechnologyCost2 INTEGER,
    TechnologyEra1 TEXT,
    TechnologyEra2 TEXT
);
CREATE TEMP TABLE TempTechnologies AS
SELECT TechnologyType, shuffle_order
FROM Technologies
ORDER BY shuffle_order;
ALTER TABLE TempTechnologies ADD COLUMN row_num INTEGER;
UPDATE TempTechnologies
SET row_num = (
    SELECT COUNT(*)
    FROM TempTechnologies t2
    WHERE t2.shuffle_order <= TempTechnologies.shuffle_order
);

-- 插入配对数据
INSERT INTO RandomTechnology (TechnologyType1, TechnologyType2)
SELECT
    t1.TechnologyType AS TechnologyType1,
    t2.TechnologyType AS TechnologyType2
FROM TempTechnologies t1
JOIN TempTechnologies t2 ON t2.row_num = t1.row_num + 1
WHERE t1.row_num % 2 = 1;
DROP TABLE TempTechnologies;
UPDATE RandomTechnology SET TechnologyCost1 =
    (SELECT Cost FROM Technologies WHERE TechnologyType = TechnologyType1),
                             TechnologyCost2 =
    (SELECT Cost FROM Technologies WHERE TechnologyType = TechnologyType2),
                             TechnologyEra1 =
    (SELECT EraType FROM Technologies WHERE TechnologyType = TechnologyType1),
                             TechnologyEra2 =
    (SELECT EraType FROM Technologies WHERE TechnologyType = TechnologyType2);

-- 更新原表
UPDATE Technologies
SET Cost = (
    SELECT
        CASE
            WHEN Technologies.TechnologyType = RandomTechnology.TechnologyType1 THEN RandomTechnology.TechnologyCost2
            WHEN Technologies.TechnologyType = RandomTechnology.TechnologyType2 THEN RandomTechnology.TechnologyCost1
        END
    FROM RandomTechnology
    WHERE Technologies.TechnologyType IN (RandomTechnology.TechnologyType1, RandomTechnology.TechnologyType2)
)
WHERE TechnologyType IN (SELECT TechnologyType1 FROM RandomTechnology UNION SELECT TechnologyType2 FROM RandomTechnology);

UPDATE Technologies
SET EraType = (
    SELECT
        CASE
            WHEN Technologies.TechnologyType = RandomTechnology.TechnologyType1 THEN RandomTechnology.TechnologyEra2
            WHEN Technologies.TechnologyType = RandomTechnology.TechnologyType2 THEN RandomTechnology.TechnologyEra1
        END
    FROM RandomTechnology
    WHERE Technologies.TechnologyType IN (RandomTechnology.TechnologyType1, RandomTechnology.TechnologyType2)
)
WHERE TechnologyType IN (SELECT TechnologyType1 FROM RandomTechnology UNION SELECT TechnologyType2 FROM RandomTechnology);


-- 采用游戏自带打乱函数
DELETE FROM TechnologyPrereqs;
INSERT OR REPLACE INTO Technologies_XP2(TechnologyType, RandomPrereqs, HiddenUntilPrereqComplete) SELECT
TechnologyType,1,1
FROM Technologies;

--===========================
-- 市政树随机
--===========================
ALTER TABLE Civics ADD COLUMN shuffle_order INTEGER;

UPDATE Civics
SET shuffle_order = (
    WITH params AS (
        -- 从 GlobalParams 表中获取 v1 到 v5 的值
        SELECT
            MAX(CASE WHEN Name = 'NW_RT_SEED_1' THEN CAST(Value AS INTEGER) ELSE 0 END) AS v1,
            MAX(CASE WHEN Name = 'NW_RT_SEED_2' THEN CAST(Value AS INTEGER) ELSE 0 END) AS v2,
            MAX(CASE WHEN Name = 'NW_RT_SEED_3' THEN CAST(Value AS INTEGER) ELSE 0 END) AS v3,
            MAX(CASE WHEN Name = 'NW_RT_SEED_4' THEN CAST(Value AS INTEGER) ELSE 0 END) AS v4,
            MAX(CASE WHEN Name = 'NW_RT_SEED_5' THEN CAST(Value AS INTEGER) ELSE 0 END) AS v5
        FROM GlobalParameters
    )
    SELECT ABS(
        (
            -- 基础哈希值
            (SELECT Hash FROM Types WHERE Type = CivicType LIMIT 1) * 1664525 +
            -- 五个参数值
            v1 * 1000639 + v2 * 100591 + v3 * 10457 + v4 * 1361 + v5 * 379 +
            -- 添加常数
            1013904223
        ) % 2147483647  -- 使用大质数取模
    ) % 10000019  -- 最终取模到所需范围
    FROM params
)
WHERE CivicType IS NOT NULL;

-- 储存交换性科技
CREATE TABLE RandomCivic (
    CivicType1 TEXT,  -- 存储原表奇数行的主键
    CivicType2 TEXT,   -- 存储原表偶数行的主键
    CivicCost1 INTEGER,
    CivicCost2 INTEGER,
    CivicEra1 TEXT,
    CivicEra2 TEXT
);
CREATE TEMP TABLE TempCivics AS
SELECT CivicType, shuffle_order
FROM Civics
ORDER BY shuffle_order;
ALTER TABLE TempCivics ADD COLUMN row_num INTEGER;
UPDATE TempCivics
SET row_num = (
    SELECT COUNT(*)
    FROM TempCivics t2
    WHERE t2.shuffle_order <= TempCivics.shuffle_order
);

-- 插入配对数据
INSERT INTO RandomCivic (CivicType1, CivicType2)
SELECT
    t1.CivicType AS CivicType1,
    t2.CivicType AS CivicType2
FROM TempCivics t1
JOIN TempCivics t2 ON t2.row_num = t1.row_num + 1
WHERE t1.row_num % 2 = 1;
DROP TABLE TempCivics;
UPDATE RandomCivic SET CivicCost1 =
    (SELECT Cost FROM Civics WHERE CivicType = CivicType1),
                             CivicCost2 =
    (SELECT Cost FROM Civics WHERE CivicType = CivicType2),
                             CivicEra1 =
    (SELECT EraType FROM Civics WHERE CivicType = CivicType1),
                             CivicEra2 =
    (SELECT EraType FROM Civics WHERE CivicType = CivicType2);

-- 更新原表
UPDATE Civics
SET Cost = (
    SELECT
        CASE
            WHEN Civics.CivicType = RandomCivic.CivicType1 THEN RandomCivic.CivicCost2
            WHEN Civics.CivicType = RandomCivic.CivicType2 THEN RandomCivic.CivicCost1
        END
    FROM RandomCivic
    WHERE Civics.CivicType IN (RandomCivic.CivicType1, RandomCivic.CivicType2)
)
WHERE CivicType IN (SELECT CivicType1 FROM RandomCivic UNION SELECT CivicType2 FROM RandomCivic);

UPDATE Civics
SET EraType = (
    SELECT
        CASE
            WHEN Civics.CivicType = RandomCivic.CivicType1 THEN RandomCivic.CivicEra2
            WHEN Civics.CivicType = RandomCivic.CivicType2 THEN RandomCivic.CivicEra1
        END
    FROM RandomCivic
    WHERE Civics.CivicType IN (RandomCivic.CivicType1, RandomCivic.CivicType2)
)
WHERE CivicType IN (SELECT CivicType1 FROM RandomCivic UNION SELECT CivicType2 FROM RandomCivic);


-- 采用游戏自带打乱函数
DELETE FROM CivicPrereqs;
INSERT OR REPLACE INTO Civics_XP2(CivicType, RandomPrereqs, HiddenUntilPrereqComplete) SELECT
CivicType,1,1
FROM Civics;