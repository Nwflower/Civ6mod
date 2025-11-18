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

UPDATE Players SET LeaderAbilityDescription = 'LOC_SSO_TRAIT_LEADER_ALLIANCE_AND_TRADE_DESCRIPTION'
               WHERE LeaderType = 'LEADER_POUNDMAKER' AND EXISTS(SELECT 1 FROM Players WHERE LeaderAbilityDescription = '埃莉诺的城市中每个巨作可使9个单元格内的外国城市每回合减少3点忠诚度。著作+2 [ICON_Science] 科技值，其他巨作类+3 [ICON_Science] 科技值。城市因失去忠诚度而离开另一文明后，如其每回合对埃莉诺的忠诚度最高，则会跳过成为自由城市阶段直接加入埃莉诺的文明。埃莉诺的宫殿额外获得一个任意槽位。埃莉诺在建造剧院建筑、区域时+25 [ICON_PRODUCTION] 生产力。[NEWLINE]若解锁“政治哲学”市政，则每回合+1 [ICON_GreatWriter] 大作家点数，“城堡”改良+1 [ICON_GOLD] 金币。')