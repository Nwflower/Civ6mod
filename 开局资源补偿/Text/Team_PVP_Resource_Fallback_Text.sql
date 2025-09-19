------------------------------------------------------------------------------
--	FILE: TPRF Text.sql
--  VERSION: 1
--	PURPOSE: Team PVP Resource Fallback Text
------------------------------------------------------------------------------
--	Copyright (c) 2025 Nwflower.
--	All rights reserved.
------------------------------------------------------------------------------
INSERT OR
REPLACE INTO LocalizedText(Language, Tag, Text)
VALUES ('zh_Hans_CN', 'LOC_NW_TPRF_RESOURCE_DISABLED', '存在未揭示的资源，已拯救资源工程师！'),
       ('zh_Hans_CN', 'LOC_UNIT_RESOURCE_ENGINEER_NAME', '资源工程师'),
       ('zh_Hans_CN', 'LOC_UNIT_RESOURCE_ENGINEER_DESCRIPTION', '可以在空白地块上种植加成资源的特殊单位');

INSERT OR
REPLACE INTO LocalizedText(Language, Tag, Text)
SELECT 'zh_Hans_CN', 'LOC_IMPROVEMENT_NW_TPRF_'||REPLACE(REPLACE(Tag,'LOC_',''),'_NAME','')||'_DESCRIPTION', '在该地块种植一个'||Text||'资源'
FROM LocalizedText WHERE Language = 'zh_Hans_CN' AND Tag LIKE 'LOC/_RESOURCE/_%/_NAME' ESCAPE '/';