--  FILE: CIVILIZATION_NW_HANJ_Script.lua
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/15 18:21:35

include('NwflowerMODCore')

-- ===========================================================================

function Nw_LC_GetDamage(iPlayer, Params)
	local pUnit = UnitManager.GetUnit(iPlayer, Params.iUnit);
    pUnit:ChangeDamage(-50)
end

function initialize()
	GameEvents.Nw_LC_GetDamage.Add(Nw_LC_GetDamage)
end

Events.LoadScreenClose.Add(initialize);
include('CIVILIZATION_NW_HANJ_Script_',true);
print('CIVILIZATION_NW_HANJ_Script Loaded Success.')