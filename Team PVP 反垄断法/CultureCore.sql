--  FILE: 文胜补丁
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
UPDATE GlobalParameters
SET Value = 101
WHERE Name IN (
   'MONOPOLY_REQUIRED_RESOURCE_CONTROL_PERCENTAGE',
   'MONOPOLY_REQUIRED_RESOURCE_CONTROL_PERCENTAGE_MED',
   'MONOPOLY_REQUIRED_RESOURCE_CONTROL_PERCENTAGE_MAX'
);

INSERT OR IGNORE INTO CivicModifiers(CivicType, ModifierID) SELECT
CivicType,'NW_MODIFIER_PLAYER_ADJUST_TOURISM_PER_CIVIC'
FROM Civics;
INSERT OR IGNORE  INTO Modifiers(ModifierId,ModifierType)VALUES
('NW_MODIFIER_PLAYER_ADJUST_TOURISM_PER_CIVIC','MODIFIER_PLAYER_ADJUST_TOURISM');
INSERT OR IGNORE  INTO ModifierArguments(ModifierId,Name,Value)VALUES
('NW_MODIFIER_PLAYER_ADJUST_TOURISM_PER_CIVIC','Amount',5);


