--      FILE: Liuche_Colors.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--      Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/9 21:08:06
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================
INSERT OR
REPLACE INTO Colors
    (Type, Color)
VALUES ('COLOR_PLAYER_OP_FIAMMETTA_1', '253,229,220,255'), --#FDE5DC
       ('COLOR_PLAYER_OP_FIAMMETTA_2', '135,54,54,255'),   --#873636
       ('COLOR_PLAYER_OP_FIAMMETTA_3', '194,101,90,255'),   --#C2655A
       ('COLOR_PLAYER_OP_FIAMMETTA_4', '242,188,44,255'), -- f2bc2c
       ('COLOR_PLAYER_OP_FIAMMETTA_5', '26,26,25,255'); -- 1a1a19

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
VALUES ('LEADER_NW_LIUCHE',
        'Unique',
        'COLOR_PLAYER_OP_FIAMMETTA_5',
        'COLOR_PLAYER_OP_FIAMMETTA_4',
        'COLOR_PLAYER_OP_FIAMMETTA_1',
        'COLOR_PLAYER_OP_FIAMMETTA_3',
        'COLOR_PLAYER_OP_FIAMMETTA_3',
        'COLOR_PLAYER_OP_FIAMMETTA_1',
        'COLOR_PLAYER_OP_FIAMMETTA_1',
        'COLOR_PLAYER_OP_FIAMMETTA_2');


-------------------------------------
--      PlayerColors
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
VALUES ('LEADER_NW_LIUCHE_ALT',
        'Unique',
        'COLOR_PLAYER_OP_FIAMMETTA_5',
        'COLOR_PLAYER_OP_FIAMMETTA_4',
        'COLOR_PLAYER_OP_FIAMMETTA_1',
        'COLOR_PLAYER_OP_FIAMMETTA_3',
        'COLOR_PLAYER_OP_FIAMMETTA_3',
        'COLOR_PLAYER_OP_FIAMMETTA_1',
        'COLOR_PLAYER_OP_FIAMMETTA_1',
        'COLOR_PLAYER_OP_FIAMMETTA_2');