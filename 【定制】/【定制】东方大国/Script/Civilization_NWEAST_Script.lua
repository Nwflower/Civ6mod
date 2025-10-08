--  FILE: Civilization_NWEAST_Script.lua
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/12 11:48:27

include('NwflowerMODCore')

-- ===========================================================================


function initialize()

end

Events.LoadScreenClose.Add(initialize);
include('Civilization_NWEAST_Script_',true);
print('Civilization_NWEAST_Script Loaded Success.')