-- GreatJieshe
-- Author: QIANCHUANBAILANG
-- DateCreated: 2025-8-7 22:45:53
--------------------------------------------------------------


INSERT INTO Parameters(ParameterId,Name,Description,Domain,DefaultValue,ConfigurationGroup,ConfigurationId,GroupId,ChangeableAfterGameStart,SortIndex)VALUES
('NW_QAB_CONFIG1','混沌之子1','','NW_QAB',1,'Game','NW_QAB_CONFIG1','AdvancedOptions', 0,1001),
('NW_QAB_CONFIG2','混沌之子2','','NW_QAB',1,'Game','NW_QAB_CONFIG2','AdvancedOptions', 0,1002);

INSERT INTO DomainValues(Domain,Value,Name,Description,SortIndex)VALUES
('NW_QAB',1,'1号玩家','',1),
('NW_QAB',2,'2号玩家','',2),
('NW_QAB',3,'3号玩家','',3),
('NW_QAB',4,'4号玩家','',4),
('NW_QAB',5,'5号玩家','',5),
('NW_QAB',6,'6号玩家','',6),
('NW_QAB',7,'7号玩家','',7),
('NW_QAB',8,'8号玩家','',8),
('NW_QAB',9,'9号玩家','',9),
('NW_QAB',10,'10号玩家','',10),
('NW_QAB',11,'11号玩家','',11),
('NW_QAB',12,'12号玩家','',12),
('NW_QAB',13,'13号玩家','',13),
('NW_QAB',14,'14号玩家','',14),
('NW_QAB',15,'15号玩家','',15),
('NW_QAB',16,'16号玩家','',16);

UPDATE DomainValues SET Value = Value - 1 WHERE Domain = 'NW_QAB';