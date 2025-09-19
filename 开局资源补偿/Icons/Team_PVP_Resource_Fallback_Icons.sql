------------------------------------------------------------------------------
--	FILE: TPRF Text.sql
--  VERSION: 1
--	PURPOSE: Team PVP Resource Fallback Text
------------------------------------------------------------------------------
--	Copyright (c) 2025 Nwflower.
--	All rights reserved.
------------------------------------------------------------------------------
INSERT OR
REPLACE INTO IconAliases(Name, OtherName)
SELECT REPLACE(Name,'ICON_RESOURCE_','ICON_IMPROVEMENT_NW_TPRF_RESOURCE_'), Name
FROM IconDefinitions WHERE Name LIKE 'ICON/_RESOURCE/_%' ESCAPE '/';

INSERT OR
REPLACE INTO IconAliases(Name, OtherName)
VALUES ('ICON_UNIT_RESOURCE_ENGINEER','ICON_UNIT_MILITARY_ENGINEER');