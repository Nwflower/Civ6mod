--  FILE: ALIN_Script.lua
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/10/3 14:25:12

include('NwflowerMODCore')

-- ===========================================================================


function initialize()

end

Events.LoadScreenClose.Add(initialize);
include('ALIN_Script_',true);
print('ALIN_Script Loaded Success.')