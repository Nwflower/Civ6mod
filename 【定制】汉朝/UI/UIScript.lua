-- Ottoman_TransferButton
-- Author: Nwflower
-- DateCreated: 2025-6-11 17:08:53

local m_iCurrentPlayerID = Game.GetLocalPlayer()
local m_pCurrentPlayer = Players[m_iCurrentPlayerID]

local iG_Improvement1 = GameInfo.Improvements['IMPROVEMENT_FARM'].Index
local iG_Improvement2 = GameInfo.Improvements['IMPROVEMENT_PASTURE'].Index
local iG_Improvement3 = GameInfo.Improvements['IMPROVEMENT_CAMP'].Index

function OnImprovementChanged(iX,iY,improvementType, improvementOwner,resource, isPillaged, isWorked)
	-- 首先改良设施必须被掠夺，且是要求的三种改良之一
	if isPillaged and (improvementType == iG_Improvement1 or improvementType == iG_Improvement2 or improvementType == iG_Improvement3) then
		-- 获取该单元格上的己方追猎者单位
		for loop, pUnit in ipairs(Units.GetUnitsInPlot(Map.GetPlot(iX, iY))) do
			if(pUnit ~= nil) then
				if pUnit:GetOwner() == m_iCurrentPlayerID and GameInfo.Units[pUnit:GetType()].UnitType == "UNIT_NW_BIAOQI" then
					UI.RequestPlayerOperation(m_iCurrentPlayerID, PlayerOperations.EXECUTE_SCRIPT, {
						OnStart = "Nw_LC_GetDamage",
						iUnit = pUnit:GetID()
					});
				end
			end
		end
	end
end


function Initialize()
	if m_pCurrentPlayer:GetProperty('PROPERTY_TRAIT_LEADER_NW005') then
		-- 如果玩家是
		Events.ImprovementChanged.Add(OnImprovementChanged);
	end
end

Events.LoadGameViewStateDone.Add(Initialize)