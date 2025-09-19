
-- 删除梯田之前的建造条件
DELETE FROM Improvement_ValidTerrains WHERE ImprovementType = 'IMPROVEMENT_TERRACE_FARM';
DELETE FROM Improvement_ValidFeatures WHERE ImprovementType = 'IMPROVEMENT_TERRACE_FARM';
DELETE FROM Improvement_ValidResources WHERE ImprovementType = 'IMPROVEMENT_TERRACE_FARM';

-- 继承滑雪场的建造条件，梯田只能修建在山上
INSERT INTO Improvement_ValidTerrains(ImprovementType, TerrainType) SELECT
'IMPROVEMENT_TERRACE_FARM',TerrainType
FROM Improvement_ValidTerrains WHERE ImprovementType = 'IMPROVEMENT_SKI_RESORT';
INSERT INTO Improvements_XP2(ImprovementType,BuildOnAdjacentPlot)VALUES
('IMPROVEMENT_TERRACE_FARM',1);

-- 文明技能，相邻山给粮食删除
DELETE FROM TraitModifiers WHERE TraitType= 'TRAIT_TERRACE_GRASS_MOUNTAIN' AND ModifierId LIKE 'TRAIT\_TERRACE\_%\_MOUNTAIN' ESCAPE '\';
-- 领袖技能，内商给粮食删除
DELETE FROM TraitModifiers WHERE TraitType= 'TRAIT_LEADER_PACHACUTI_QHAPAQ_NAN' AND ModifierId LIKE 'DOMESTIC\_TRADE\_ROUTE\_FOOD\_%\_MOUNTAIN\_ORIGIN' ESCAPE '\';

-- 灌溉给1粮食，封建给1粮食
DELETE FROM Improvement_Adjacencies WHERE ImprovementType = 'IMPROVEMENT_TERRACE_FARM' AND YieldChangeId LIKE 'Terrace\_%MountainAdjacency' ESCAPE '\';
DELETE FROM Improvement_Adjacencies WHERE ImprovementType = 'IMPROVEMENT_TERRACE_FARM' AND YieldChangeId = 'Terrace_MedievalAdjacency';

INSERT OR IGNORE INTO Improvement_YieldChanges
    (ImprovementType, YieldType, YieldChange)
VALUES ('IMPROVEMENT_TERRACE_FARM', 'YIELD_FOOD', 0);
INSERT INTO Improvement_BonusYieldChanges
    (Id, ImprovementType, YieldType, BonusYieldChange, PrereqTech,PrereqCivic)
VALUES ('100', 'IMPROVEMENT_TERRACE_FARM', 'YIELD_FOOD', 1, NULL,'CIVIC_FEUDALISM'),
       ('101', 'IMPROVEMENT_TERRACE_FARM', 'YIELD_FOOD', 1, 'TECH_IRRIGATION',NULL);

-- 相邻淡水+1锤删除（描述性修正）