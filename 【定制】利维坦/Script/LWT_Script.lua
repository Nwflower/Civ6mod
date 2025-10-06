--  FILE: LWT_Script.lua
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/29 22:03:38

include('NwflowerMODCore')

function HasTrait_Property(m_sTrait, iPlayer)
	local pPlayer = Players[iPlayer];
	local ePro = pPlayer:GetProperty('PROPERTY_'..m_sTrait) or 0
	if ePro > 0 then
		return true
	end
	return false
end

-- ===========================================================================
-- 占领城市或者蛮族营地时，首都获得1个免费的商人并+1 [ICON_TRADEROUTE] 贸易路线容量。

function OnPlayerCreateCity(playerID,cityID,pX,pY)
	local pCity = CityManager.GetCity(playerID, cityID);
	if (HasTrait_Property('TRAIT_CIVILIZATION_NW_DEEPSKY_NICHAO', playerID)) and pCity:GetOriginalOwner() ~= playerID then
		local pPlayer = Players[playerID]
		pPlayer:AttachModifierByID('MODIFIER_ATTACH_TRAIT_CIVILIZATION_NW_DEEPSKY_NICHAO_TRADER');
		pPlayer:AttachModifierByID('MODIFIER_ATTACH_TRAIT_CIVILIZATION_NW_DEEPSKY_NICHAO_TRADER_CAPBILITY');
	end
end


-- 每次死亡时，首都将获得一个新的鲨兵，
-- 并且所有鲨兵+4 [ICON_STRENGTH] 战斗力、+1 [ICON_MOVEMENT] 移动力，
-- 其余的近战单位+2 [ICON_STRENGTH] 战斗力、+1 [ICON_MOVEMENT] 移动力，
-- 远程单位+1 [ICON_RANGE] 射程、+1 [ICON_MOVEMENT] 移动力，平民单位+1 [ICON_MOVEMENT] 移动力。

function onUnitRemovedFromMap(playerID,unitID)
	local pUnit = UnitManager.GetUnit(playerID, unitID)
    if pUnit and GameInfo.Units['UNIT_20250929'].Index == pUnit:GetType() then
		local pPlayer = Players[playerID]
		pPlayer:AttachModifierByID('MODIFIER_TRAIT_UNIT_20250929_ADD_MOVEMENT');
		pPlayer:AttachModifierByID('MODIFIER_TRAIT_UNIT_20250929_ADD_RANGE');
		pPlayer:AttachModifierByID('MODIFIER_TRAIT_UNIT_20250929_ADD_COMBAT');
		pPlayer:AttachModifierByID('MODIFIER_TRAIT_UNIT_20250929_ADD_COMBAT_SB');
    	local iCapital = pPlayer:GetCities():GetCapitalCity();
	    UnitManager.InitUnitValidAdjacentHex(playerID, "UNIT_20250929", iCapital:GetX(), iCapital:GetY(), 1);
    end
end

function initialize()
	Events.CityAddedToMap.Add(OnPlayerCreateCity);
    Events.UnitRemovedFromMap.Add(onUnitRemovedFromMap);
end

Events.LoadScreenClose.Add(initialize);
include('LWT_Script_',true);
print('LWT_Script Loaded Success.')