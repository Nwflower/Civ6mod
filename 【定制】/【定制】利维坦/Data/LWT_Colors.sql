--	FILE: LWT_Colors.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/9/29 22:03:38
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

INSERT INTO Colors (Type, Color)
VALUES ('COLOR_PLAYER_LEADER_LIWEITAN_1', '0,0,0,255'),
       ('COLOR_PLAYER_LEADER_LIWEITAN_2', '56,171,251,255'),
       ('COLOR_PLAYER_LEADER_LIWEITAN_3', '0,186,255,255'),
       ('COLOR_PLAYER_LEADER_LIWEITAN_4', '255,255,255,255');
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
VALUES ('LEADER_LIWEITAN',
        'Unique',
        'COLOR_PLAYER_LEADER_LIWEITAN_2',
        'COLOR_PLAYER_LEADER_LIWEITAN_4',
        'COLOR_PLAYER_LEADER_LIWEITAN_1',
        'COLOR_PLAYER_LEADER_LIWEITAN_2',
        'COLOR_PLAYER_LEADER_LIWEITAN_3',
        'COLOR_PLAYER_LEADER_LIWEITAN_4',
        'COLOR_PLAYER_LEADER_LIWEITAN_1',
        'COLOR_PLAYER_LEADER_LIWEITAN_3');