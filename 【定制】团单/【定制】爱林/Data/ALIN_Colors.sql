--	FILE: NewLeader2_Colors.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/10/3 11:23:08
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

--======================================================================
--	COLORS
--======================================================================
--	Colors
-------------------------------------
INSERT OR REPLACE INTO Colors
		(Type,							Color)
VALUES
		("COLOR_STANDARD_INDIGO_MD",	"0,119,168,255");
-------------------------------------
--	PlayerColors
-------------------------------------
INSERT OR REPLACE INTO PlayerColors
		(
			Type,
			Usage,

			PrimaryColor,
			SecondaryColor,

			Alt1PrimaryColor,
			Alt1SecondaryColor,

			Alt2PrimaryColor,
			Alt2SecondaryColor,

			Alt3PrimaryColor,
			Alt3SecondaryColor
		)
VALUES
		(
			"LEADER_NWALIN",
			"Unique",

			"COLOR_STANDARD_INDIGO_MD",
			"COLOR_STANDARD_WHITE_LT",

			"COLOR_STANDARD_WHITE_LT",
			"COLOR_STANDARD_INDIGO_MD",

			"COLOR_STANDARD_AQUA_MD",
			"COLOR_STANDARD_BLUE_DK",

			"COLOR_STANDARD_BLUE_DK",
			"COLOR_STANDARD_AQUA_MD"
		);
--======================================================================
--======================================================================
