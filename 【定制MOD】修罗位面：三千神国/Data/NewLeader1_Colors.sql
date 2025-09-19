--	FILE: NewLeader1_Colors.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025/9/2 15:46:23
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

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
SELECT 'LEADER_NW_SANQIAN',
        'Unique',
      PrimaryColor,
      SecondaryColor,
      Alt1PrimaryColor,
      Alt1SecondaryColor,
      Alt2PrimaryColor,
      Alt2SecondaryColor,
      Alt3PrimaryColor,
      Alt3SecondaryColor
FROM PlayerColors WHERE Type = 'LEADER_TRAJAN';