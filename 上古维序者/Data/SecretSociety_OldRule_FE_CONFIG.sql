--	FILE: SecretSociety_OldRule_FE_CONFIG.sql
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


-- 		<Row Key1="Map" Key2="TPT_Vertical_Continent.lua" ParameterId="MapWidth" Name="LOC_MAP_WIDTH_NAME" Description="LOC_MAP_WIDTH_DESC" Domain="MapWidthRange" DefaultValue="-2" ConfigurationGroup="Game" ConfigurationId="MapWidth" Hash="0" GroupId="MapOptions" SortIndex="211"/>

INSERT INTO Parameters(ParameterId, Name, Description, Domain, DefaultValue, ConfigurationGroup, ConfigurationId,  GroupId, SortIndex) VALUES
('Unit_Earth_Actions','LOC_UNIT_EARTH_ACTIONS_NAME','LOC_UNIT_EARTH_ACTIONS_DESCRIPTION','NwUnitActionTimes',2,'Game','Unit_Earth_Actions','AdvancedOptions',1685);
INSERT INTO Parameters(ParameterId, Name, Description, Domain, DefaultValue, ConfigurationGroup, ConfigurationId,  GroupId, SortIndex) VALUES
('NW_SSO_JIESHE_PRO','LOC_NW_SSO_JIESHE_PRO_NAME','LOC_NW_SSO_JIESHE_PRO_DESCRIPTION','bool',0,'Game','NW_SSO_JIESHE_PRO','AdvancedOptions',1686);

INSERT INTO DomainRanges(Domain, MinimumValue, MaximumValue) VALUES
('NwUnitActionTimes',1,2);