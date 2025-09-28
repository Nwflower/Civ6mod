-- Script
-- Author: Nwflower
-- DateCreated: 2025-9-14 17:54:01
--------------------------------------------------------------
--||=======================include========================||--

-- ===========================================================================
function HasTrait_Property(sTrait, iPlayer)
	local pPlayer = Players[iPlayer];
	local ePro = pPlayer:GetProperty('PROPERTY_'..sTrait) or 0
	if ePro > 0 then
		return true
	end
	return false
end
-- ===========================================================================

-- ===========================================================================
-- 加移动力
function Nw_DTMS_MAQIDUN_Move(iPlayerID, params)
	for _,iUnit in ipairs(params.iUnits) do
		local pUnit = UnitManager.GetUnit(iPlayerID, iUnit)
		UnitManager.ChangeMovesRemaining(pUnit, 1)
	end
end
-- 城市获得虚拟建筑
function Nw_DTMS_MAQIDUN_Moved(iPlayerID, params)
	local pUnit = UnitManager.GetUnit(iPlayerID, params.iUnit)
	pUnit:SetProperty('DTMS_UNIT_HAS_MOVED',Game.GetCurrentGameTurn());
end
-- 文件初始化
function Initialize()
    GameEvents.Nw_DTMS_MAQIDUN_Move.Add(Nw_DTMS_MAQIDUN_Move);
    GameEvents.Nw_DTMS_MAQIDUN_Moved.Add(Nw_DTMS_MAQIDUN_Moved);
	print('DTMS MQD Script Loaded Succeed.')
end
Events.LoadGameViewStateDone.Add(Initialize)