--  FILE: CIVILIZATION_LUNA_UIScript.lua
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/2 16:15:28

include('NwflowerMODCore')

-- ===========================================================================

local m_LocalPlayerID = Game.GetLocalPlayer()

--||======================initialize======================||--

function onUnitSelectionChanged()
	local pUnit = UI.GetHeadSelectedUnit()
    if pUnit and GameInfo.Units[pUnit:GetType()].UnitType == 'UNIT_LUNAR_BOAT' then
		UI.PlaySound("Play_MP_Chat_Message_Received");
    end
end

function Initialize()
	Events.UnitSelectionChanged.Add(onUnitSelectionChanged)
end
Initialize()

include('CIVILIZATION_LUNA_UIScript_',true);
print('CIVILIZATION_LUNA_UIScript Loaded Success.')
