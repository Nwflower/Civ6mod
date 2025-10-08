--	FILE: CIVILIZATION_GUMOON_Colors.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/9/24 19:28:22
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================


INSERT OR
REPLACE INTO Colors
    (Type, Color)
VALUES ('COLOR_GUMOON_1', '212,208,215,255'),
       ('COLOR_GUMOON_2', '123,112,42,255'),
       ('COLOR_GUMOON_3', '105,6,6,255');
-------------------------------------
--	PlayerColors
-------------------------------------
INSERT OR
REPLACE INTO PlayerColors
(Type,
 Usage,
 PrimaryColor,
 SecondaryColor,
 Alt1PrimaryColor,
 Alt1SecondaryColor,
 Alt2PrimaryColor,
 Alt2SecondaryColor,
 Alt3PrimaryColor,
 Alt3SecondaryColor)
VALUES ('LEADER_LEADER_GUMOON',
        'Unique',
        'COLOR_GUMOON_1',
        'COLOR_GUMOON_2',
        'COLOR_GUMOON_2',
        'COLOR_GUMOON_1',
        'COLOR_GUMOON_3',
        'COLOR_GUMOON_1',
        'COLOR_GUMOON_1',
        'COLOR_GUMOON_3');