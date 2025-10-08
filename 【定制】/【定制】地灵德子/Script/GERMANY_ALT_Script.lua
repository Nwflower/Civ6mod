--  FILE: GERMANY_ALT_Script.lua
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/23 9:28:58

include('NwflowerMODCore')

-- ===========================================================================

function initialize()
end

Events.LoadScreenClose.Add(initialize);
include('GERMANY_ALT_Script_',true);
print('GERMANY_ALT_Script Loaded Success.')