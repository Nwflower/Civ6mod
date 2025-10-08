--	FILE: NL_Colors.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/10/6 11:26:46
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
		(Type,						Color)
VALUES
		("COLOR_PLAYER_MILKL_1",	"210,168,12,255");	--#D2A80C
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
			"LEADER_MILKL",
			"Unique",

			"COLOR_STANDARD_YELLOW_MD",
			"COLOR_STANDARD_WHITE_DK",

			"COLOR_STANDARD_WHITE_LT",
			"COLOR_PLAYER_MILKL_1",

			"COLOR_STANDARD_YELLOW_MD",
			"COLOR_STANDARD_RED_MD",

			"COLOR_STANDARD_RED_MD",
			"COLOR_STANDARD_YELLOW_MD"
		);
--======================================================================
--======================================================================
