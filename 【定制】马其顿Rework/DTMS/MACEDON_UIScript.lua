
-- ===========================================================================
-- 变量定义
local m_iCurrentPlayerID = Game.GetLocalPlayer()
local m_pCurrentPlayer = Players[m_iCurrentPlayerID]
local Debug_mode = 1;
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
function __DEBUG(...)
	if Debug_mode then
		print(...)
	end
end

function onPlayerTurnActivated(playerID, isFirst)
	if playerID ~= m_iCurrentPlayerID then return end
	if isFirst then
		local pPlayer = Players[playerID];
		local iUnits = {}
		local EqualTurn = Game.GetCurrentGameTurn() - 1
		for i, unit in pPlayer:GetUnits():Members() do
			if (unit ~= nil) then
				local Turn = unit:GetProperty("DTMS_UNIT_HAS_MOVED") or 0;
				if Turn ~= EqualTurn then
					table.insert(iUnits,unit:GetID())
				end
			end
    	end
		if iUnits and #iUnits > 0 then
			UI.RequestPlayerOperation(playerID, PlayerOperations.EXECUTE_SCRIPT, {
				OnStart = "Nw_DTMS_MAQIDUN_Move",
				iUnits = iUnits
			});
		end
	end
end


function onUnitMoveComplete(playerID, unitID, iX, iY)
	if playerID ~= m_iCurrentPlayerID then return end
	local pUnit = UnitManager.GetUnit(playerID, unitID);
	if pUnit:GetMovesRemaining() == 0 then
		UI.RequestPlayerOperation(playerID, PlayerOperations.EXECUTE_SCRIPT, {
			OnStart = "Nw_DTMS_MAQIDUN_Moved",
			iUnit = unitID
		});
	end
end

-- ===========================================================================

-- ===========================================================================
-- 文件初始化
function Initialize()
	-- 为了减轻运算负担，如果本地是亚历山大，则运行函数
	if (HasTrait_Property('TRAIT_LEADER_TO_WORLDS_END',m_iCurrentPlayerID)) then
		Events.UnitMoveComplete.Add(onUnitMoveComplete);
		Events.PlayerTurnActivated.Add(onPlayerTurnActivated);
	end
	print('DTMS MQD UIScript Loaded Succeed.');
end
Events.LoadGameViewStateDone.Add(Initialize);
