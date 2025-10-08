--  FILE: NewLeader1_UIScript.lua
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/2 15:46:23

include('NwflowerMODCore')

-- ===========================================================================

local m_LocalPlayerID = Game.GetLocalPlayer()

--||======================initialize======================||--

function LateInitialize()

end

function Initialize()
    Events.LoadScreenClose.Add(LateInitialize);
end
Initialize()

include('NewLeader1_UIScript_',true);
print('NewLeader1_UIScript Loaded Success.')
