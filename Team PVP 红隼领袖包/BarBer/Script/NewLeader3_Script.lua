--  FILE: NewLeader3_Script.lua
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/22 21:48:22

include('NwflowerMODCore')

-- ===========================================================================


function initialize()

end

Events.LoadScreenClose.Add(initialize);
include('NewLeader3_Script_',true);
print('NewLeader3_Script Loaded Success.')