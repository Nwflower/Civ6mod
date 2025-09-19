--  FILE: SecretSociety_OldRule_Script.lua
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--  All rights reserved.
--  DateCreated: 2025/7/3 11:22:01
-- ===========================================================================
function SCHOLARGetULK(iPlayer, Param)
    local pPlayer = Players[iPlayer]
    pPlayer:GetTechs():TriggerBoost(Param.TechID, 1);
end


function initialize()
    GameEvents.SCHOLARGetULK.Add(SCHOLARGetULK)
end

Events.LoadScreenClose.Add(initialize);
include('SCHOLARGetULK',true);
print('SCHOLARGetULK Loaded Success.')