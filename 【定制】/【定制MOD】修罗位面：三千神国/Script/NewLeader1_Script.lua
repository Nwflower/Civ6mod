--  FILE: NewLeader1_Script.lua
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/2 15:46:23

include('NwflowerMODCore')

-- ===========================================================================


function initialize()

end

Events.LoadScreenClose.Add(initialize);
include('NewLeader1_Script_',true);
print('NewLeader1_Script Loaded Success.')