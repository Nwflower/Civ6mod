
INSERT OR
REPLACE INTO Colors
    (Type, Color)
VALUES ('COLOR_PLAYER_OP_FIAMMETTA_1', '253,229,220,255'), --#FDE5DC
       ('COLOR_PLAYER_OP_FIAMMETTA_2', '135,54,54,255'),   --#873636
       ('COLOR_PLAYER_OP_FIAMMETTA_3', '194,101,90,255');   --#C2655A

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
VALUES ('LEADER_NWBNB',
        'Unique',
        'COLOR_PLAYER_OP_FIAMMETTA_2',
        'COLOR_PLAYER_OP_FIAMMETTA_1',
        'COLOR_PLAYER_OP_FIAMMETTA_1',
        'COLOR_PLAYER_OP_FIAMMETTA_3',
        'COLOR_PLAYER_OP_FIAMMETTA_3',
        'COLOR_PLAYER_OP_FIAMMETTA_1',
        'COLOR_PLAYER_OP_FIAMMETTA_1',
        'COLOR_PLAYER_OP_FIAMMETTA_2');
