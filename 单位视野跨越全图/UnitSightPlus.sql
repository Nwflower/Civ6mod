UPDATE Units SET BaseSightRange = 999;
UPDATE Features SET SightThroughModifier = 0;
UPDATE Terrains SET SightModifier = 2 - SightModifier;