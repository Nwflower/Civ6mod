-- Team_PVP_More_GreatPeople
-- Author: Nwflower
-- DateCreated: 2025-6-12 14:19:14
--------------------------------------------------------------
-- 调整了后期伟人的价格。联机速度下，招募伟人的基准花费调整为30（古典）/60（中世纪）/90（文艺复兴）/180（工业时代）/270（现代）/420（原子能）/600（信息）。
UPDATE Eras SET GreatPersonBaseCost = 180 WHERE EraType = 'ERA_RENAISSANCE';
UPDATE Eras SET GreatPersonBaseCost = 360 WHERE EraType = 'ERA_INDUSTRIAL';
UPDATE Eras SET GreatPersonBaseCost = 540 WHERE EraType = 'ERA_MODERN';
UPDATE Eras SET GreatPersonBaseCost = 840 WHERE EraType = 'ERA_ATOMIC';
UPDATE Eras SET GreatPersonBaseCost = 1200 WHERE EraType = 'ERA_INFORMATION';
UPDATE Eras SET GreatPersonBaseCost = 1200 WHERE EraType = 'ERA_FUTURE';
