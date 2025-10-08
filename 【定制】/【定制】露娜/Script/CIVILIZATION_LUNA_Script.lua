--  FILE: CIVILIZATION_LUNA_Script.lua
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/2 16:15:28

include('NwflowerMODCore')

-- ===========================================================================


-- 额外晋升

-- 不屈：新单位双晋升
function onUnitPromoted(iPlayer, unit, iX, iY)
    local Player = Players[iPlayer]
    -- 2.检查玩家是否Get过相关效果
    local pUnit = UnitManager.GetUnit(iPlayer, unit);
    if pUnit:GetProperty('UNIT_LUNAR_BOAT') == 'GETTING' then
        pUnit:SetProperty('UNIT_LUNAR_BOAT','GETED');
        return
    end
    if GameInfo.Units[pUnit:GetType()].UnitType == 'UNIT_LUNAR_BOAT' then
        for row in GameInfo.UnitPromotions() do
            if row.PromotionClass == GameInfo.Units[pUnit:GetType()].PromotionClass and not pUnit:GetExperience():HasPromotion(row.Index) then
                pUnit:SetProperty('UNIT_LUNAR_BOAT','GETTING')
                pUnit:GetExperience():SetPromotion(row.Index);
                return;
            end
        end
    end
end

function initialize()
	Events.UnitPromoted.Add(onUnitPromoted);
end

Events.LoadScreenClose.Add(initialize);
include('CIVILIZATION_LUNA_Script_',true);
print('CIVILIZATION_LUNA_Script Loaded Success.')