


INSERT INTO Parameters(ParameterId, Name, Description, Domain, DefaultValue, ConfigurationGroup, ConfigurationId,  GroupId, SortIndex) VALUES
('NW_RT_SEED_NYR','LOC_NW_RT_SEED_NYR_NAME','','bool',1,'Game','NW_RT_SEED_NYR','AdvancedOptions',1550);

INSERT INTO Parameters(ParameterId, Name, Description, Domain, DefaultValue, ConfigurationGroup, ConfigurationId,  GroupId, SortIndex) VALUES
('NW_RT_SEED_1','LOC_NW_RT_SEED_1_NAME','','NwSeedNum',1,'Game','NW_RT_SEED_1','AdvancedOptions',1685),
('NW_RT_SEED_2','LOC_NW_RT_SEED_2_NAME','','NwSeedNum',1,'Game','NW_RT_SEED_2','AdvancedOptions',1685),
('NW_RT_SEED_3','LOC_NW_RT_SEED_3_NAME','','NwSeedNum',1,'Game','NW_RT_SEED_3','AdvancedOptions',1685),
('NW_RT_SEED_4','LOC_NW_RT_SEED_4_NAME','','NwSeedNum',1,'Game','NW_RT_SEED_4','AdvancedOptions',1685),
('NW_RT_SEED_5','LOC_NW_RT_SEED_5_NAME','','NwSeedNum',1,'Game','NW_RT_SEED_5','AdvancedOptions',1685);
INSERT INTO DomainRanges(Domain, MinimumValue, MaximumValue) VALUES
('NwSeedNum',1,5);