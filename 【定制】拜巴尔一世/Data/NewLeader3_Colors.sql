--	FILE: NewLeader3_Colors.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/9/22 21:48:22
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT INTO Colors (Type, Color)
VALUES ('COLOR_PLAYER_NW_0004_1', '0,0,0,255'),
       ('COLOR_PLAYER_NW_0004_2', '249,189,5,255'),
       ('COLOR_PLAYER_NW_0004_3', '53,231,225,255');

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
VALUES ('LEADER_NW_0004',
        'Unique',
        'COLOR_PLAYER_NW_0004_2',
        'COLOR_PLAYER_NW_0004_1',
        'COLOR_PLAYER_NW_0004_1',
        'COLOR_PLAYER_NW_0004_2',
        'COLOR_PLAYER_NW_0004_3',
        'COLOR_PLAYER_NW_0004_1',
        'COLOR_PLAYER_NW_0004_1',
        'COLOR_PLAYER_NW_0004_3');