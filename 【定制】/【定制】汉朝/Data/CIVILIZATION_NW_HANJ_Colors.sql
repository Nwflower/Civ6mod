--	FILE: CIVILIZATION_NW_HANJ_Colors.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/9/15 18:21:35
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT OR REPLACE INTO Colors
		(Type,										Color)
VALUES	('COLOR_PHANTA_DYNASTY_LEADER_LIU_XIU',		"175,238,238,255");

INSERT INTO PlayerColors (Type,
                          Usage,
                          PrimaryColor,
                          SecondaryColor,
                          Alt1PrimaryColor,
                          Alt1SecondaryColor,
                          Alt2PrimaryColor,
                          Alt2SecondaryColor,
                          Alt3PrimaryColor,
                          Alt3SecondaryColor)
VALUES ('LEADER_NW_LIUXUN',
        'Unique',
        'COLOR_STANDARD_RED_MD',
        'COLOR_STANDARD_YELLOW_LT',
        'COLOR_STANDARD_YELLOW_LT',
        'COLOR_STANDARD_RED_MD',
        'COLOR_STANDARD_BLUE_MD',
        'COLOR_STANDARD_GREEN_LT',
        'COLOR_STANDARD_WHITE_MD',
        'COLOR_STANDARD_AQUA_LT');
INSERT INTO PlayerColors (Type,
                          Usage,
                          PrimaryColor,
                          SecondaryColor,
                          Alt1PrimaryColor,
                          Alt1SecondaryColor,
                          Alt2PrimaryColor,
                          Alt2SecondaryColor,
                          Alt3PrimaryColor,
                          Alt3SecondaryColor)
VALUES ('LEADER_NW_JET_LIUCHE',
        'Unique',
        'COLOR_STANDARD_RED_MD',
        'COLOR_PHANTA_DYNASTY_LEADER_LIU_XIU',
        'COLOR_PHANTA_DYNASTY_LEADER_LIU_XIU',
        'COLOR_STANDARD_RED_MD',
        'COLOR_STANDARD_BLUE_MD',
        'COLOR_STANDARD_GREEN_LT',
        'COLOR_STANDARD_WHITE_MD',
        'COLOR_STANDARD_AQUA_LT');

